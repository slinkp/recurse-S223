import socket
import struct
import random

def send_note(pitch, event="/note/on"):
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    client_socket.settimeout(1.0)
    packet = osc_message(pitch, event)
    addr = ("127.0.0.1", 6449) # Port hardwired from osc-dump.ck
    client_socket.sendto(packet, addr)
    print("Sent %s" % packet)

def send_off(pitch):
    send_note(pitch, event="/note/off")

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
    # print("Message size is %s: %s" % (len(message), message))
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

def kill():
    for pitch in range(128):
        send_off(pitch)

if __name__ == '__main__':
    import sys
    if sys.argv[-1].lower() in ('kill', '-k', '--kill'):
        print("Killing all notes")
        kill()
        exit()

    if sys.argv[-1].isdigit():
        delay_ms = int(sys.argv[-1])
    else:
        delay_ms = 100

    import time
    print("Playing notes forever, Ctrl-C to stop")
    mixolydian = [0, 0, 0, 2, 4, 5, 7, 9, 10, 12]
    base_pitch = 50
    pitches = [base_pitch + offset for offset in mixolydian]
    # And octaves up
    pitches += [base_pitch + offset + 12 for offset in mixolydian]
    pitches += [base_pitch + offset + 24 for offset in mixolydian]
    while True:
        pitch = random.choice(pitches)
        send_note(pitch)
        time.sleep(0.001 * delay_ms)
        # send_off(pitch)
