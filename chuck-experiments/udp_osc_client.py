#!/usr/bin/env python3

import argparse
import socket
import struct
import random


def send_note(pitch, event="/note/on"):
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    client_socket.settimeout(1.0)
    packet = osc_message(pitch, event)
    addr = ("127.0.0.1", 6449) # Port hardwired from osc-dump.ck
    client_socket.sendto(packet, addr)
    #print("Sent %s" % packet)

def send_off(pitch, event="/note/off"):
    send_note(pitch, event=event)

TAG_INT = "i"
TAG_STRING = "s"
TAG_FLOAT = "f"

def osc_message(pitch, event):
    # See https://opensoundcontrol.stanford.edu/spec-1_0.html#osc-packets
    # How is size handled?
    # Apparently not needed when sent in a UDP datagram? OSC docs confusing about this,
    # but it seems that a UDP datagram IS an OSC packet.

    typetag = "," + TAG_INT + TAG_INT
    address = event
    args = [osc_int_as_bytes(pitch), osc_int_as_bytes(100)] # MIDI pitch, velocity
    message = osc_string_as_bytes(address)
    print(address, pitch)
    #print("Message size is %s: %s" % (len(message), message))
    message += osc_string_as_bytes(typetag)
    # print("Message size is %s: %s" % (len(message), message))
    for arg in args:
        # Assume already padded
        message += arg
    # print("Message size is %s: %s" % (len(message), message))
    return message


def osc_int_as_bytes(i):
    # 32-bit big-endian two’s complement integer
    return struct.pack(">i", i)

def osc_string_as_bytes(s):
    chunksize = 4
    b = bytes(s, 'ascii')
    padsize = 4 - (len(b) % 4)
    if padsize:
        padding = bytes('\0' * padsize, 'ascii')
        b += padding
    return b

def kill(instr=""):
    for pitch in range(128):
        send_off(pitch, event="/note/off/%s" % instr)

parser = argparse.ArgumentParser(
    prog='OSC over UDP toy client',
    description='Sends hardcoded OSC messages over UDP regularly until killed',
    )

parser.add_argument(
    '-k', '--kill',
    action="store_true",
    help="send note-off for all pitches"
)
parser.add_argument(
    '-o', '--note-offs',
    action="store_true",
    help="Send note-off event for previous note just before each note-on",
)

parser.add_argument(
    'delay_ms',
    default=100,
    type=int,
    help="Time between notes in milliseconds"
)

parser.add_argument(
    '--base-pitch',
    default=38,
    type=int,
    help="Lowest MIDI pitch"
)

parser.add_argument(
    '--octaves',
    default=4,
    type=int,
    help="Number of octaves up from base pitch"
)

parser.add_argument(
    '--instrument',
    default=[],
    action="append",
    help="Instrument names to send. If you provide more than one, each note will randomly choose one"
)

if __name__ == '__main__':
    args = parser.parse_args()

    instruments = args.instrument or ['synth']

    if args.kill:
        print("Killing all notes")
        for instr in instruments:
            kill(instr)
        exit()

    delay_ms = args.delay_ms

    import time
    print("Playing notes forever, Ctrl-C to stop")
    mixolydian = [0, 0, 2, 4, 5, 7, 9, 10]
    scale = mixolydian
    base_pitch = args.base_pitch
    pitches = [base_pitch + offset for offset in scale]
    # And octaves
    for octave in range(1, args.octaves):
        pitches += [base_pitch + offset + (12 * octave) for offset in scale]

    while True: # for pitch in [76, 76, 76]:
        pitch = random.choice(pitches)
        instr = random.choice(instruments)
        send_note(pitch, event="/note/on/" + instr)
        time.sleep(0.001 * delay_ms)
        if args.note_offs:
            send_off(pitch, event="/note/off/" + instr)
