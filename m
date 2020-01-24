Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59289148C81
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2020 17:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbgAXQtn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jan 2020 11:49:43 -0500
Received: from smtpq3.tb.mail.iss.as9143.net ([212.54.42.166]:51708 "EHLO
        smtpq3.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387674AbgAXQtn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jan 2020 11:49:43 -0500
Received: from [212.54.42.110] (helo=smtp7.tb.mail.iss.as9143.net)
        by smtpq3.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <felix@kngnt.org>)
        id 1iv29K-00036N-4m; Fri, 24 Jan 2020 17:49:38 +0100
Received: from 94-209-183-118.cable.dynamic.v4.ziggo.nl ([94.209.183.118] helo=mail.kngnt.org)
        by smtp7.tb.mail.iss.as9143.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <felix@kngnt.org>)
        id 1iv29K-00048J-0r; Fri, 24 Jan 2020 17:49:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kngnt.org; s=mail;
        t=1579884577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FTntNSS7d7L1vX/l5mjzcl7JoBTfl6OrhZcQrEb1XBw=;
        b=c+AvyqpA7ZSsYn/uRPIAhcxzOfWysl40KjElyLWEBAJ4afYKDHl1vgmfBvRcIS/72LY4c8
        NrxjVa4sAzjLEdSNRsvXh3BFa2O38J9YRi7UQxXoDk3bMHYD07Z4qIst0NjCjEhZVATHV7
        AFPamhbO1utVZyDc43dzxO9A3WbvnvRLVqFRp9XFi1vWdxLf+6V1YpuYazTQY6/gWqCkdp
        xTSHy+N9m8SP18w6H0WXjlF0UtBHAQGkhL6/f5wxFEv0NLNG5Jjv9ZDPj8DMxZw9LH/vB2
        2PN8rXro6U8RgGdLE6ky7UW/iEcvobON1vxtYY3ctGHTwN/TUS71Vu3wmePHIQ==
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Jan 2020 17:49:37 +0100
From:   Felix Rubio <felix@kngnt.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
In-Reply-To: <87BD58D0-7A14-42BB-BA8F-54E6C78B2755@redhat.com>
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
 <724CB91C-76AC-425B-BAE3-04887ED5DE73@redhat.com>
 <6d998611c9205d6a0a8bf3806c297011@kngnt.org>
 <87BD58D0-7A14-42BB-BA8F-54E6C78B2755@redhat.com>
Message-ID: <b93eadb0240439b8ca8286deb708a517@kngnt.org>
X-Sender: felix@kngnt.org
X-SourceIP: 94.209.183.118
X-Authenticated-Sender: f.rubiodalmau@ziggo.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=PPhxBsiC c=1 sm=1 tr=0 a=KDOoBKh8T/kja8HrlTi2+A==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=Jdjhy38mL1oA:10 a=ITzZAvUNQL8YSV4YsY8A:9 a=HnnX74U3PouIzNDD:21 a=mpcjKtS0YAX47Xzt:21 a=QEXdDO2ut3YA:10
X-Ziggo-Spam-Status: No
X-Spam-Status: No
X-Spam-Flag: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Benjamin,

     I have enabled the debug logging on nfsd by running

     When mounting from the client, this is what I get:

[629588.647849] nfsd_dispatch: vers 4 proc 1
[629588.655615] nfsv4 compound op #1/1: 53 (OP_SEQUENCE)
[629588.663926] __find_in_sessionid_hashtbl: 1579604994:2010353049:95:0
[629588.675361] nfsd4_sequence: slotid 0
[629588.679065] check_slot_seqid enter. seqid 644 slot_seqid 643
[629588.684589] nfsv4 compound op ffff882839705080 opcnt 1 #1: 53: 
status 0
[629588.691545] nfsv4 compound returned 0
[629588.695292] --> nfsd4_store_cache_entry slot ffff882806e83000
[629588.701933] renewing client (clientid 5e26dc02/77d38d99)
[629591.804857] nfsd_dispatch: vers 4 proc 1
[629591.809364] nfsv4 compound op #1/4: 53 (OP_SEQUENCE)
[629591.814944] __find_in_sessionid_hashtbl: 1579604994:2010353053:99:0
[629591.822163] nfsd4_sequence: slotid 0
[629591.826670] check_slot_seqid enter. seqid 155 slot_seqid 154
[629591.832771] nfsv4 compound op ffff882839705080 opcnt 4 #1: 53: 
status 0
[629591.839864] nfsv4 compound op #2/4: 24 (OP_PUTROOTFH)
[629591.845161] nfsd: fh_compose(exp 08:02/17468677 /export, 
ino=17468677)
[629591.851706] nfsv4 compound op ffff882839705080 opcnt 4 #2: 24: 
status 10016
[629591.859660] nfsv4 compound returned 10016
[629591.864797] --> nfsd4_store_cache_entry slot ffff882838b9e000
[629591.872968] renewing client (clientid 5e26dc02/77d38d9d)
[629591.889085] nfsd_dispatch: vers 4 proc 1
[629591.893713] nfsv4 compound op #1/4: 53 (OP_SEQUENCE)
[629591.899703] __find_in_sessionid_hashtbl: 1579604994:2010353053:99:0
[629591.906687] nfsd4_sequence: slotid 0
[629591.912695] check_slot_seqid enter. seqid 156 slot_seqid 155
[629591.918261] nfsv4 compound op ffff882839705080 opcnt 4 #1: 53: 
status 0
[629591.924866] nfsv4 compound op #2/4: 22 (OP_PUTFH)
[629591.931075] nfsd: fh_verify(32: 01060001 63ce4307 5a18c100 00000000 
00000000 1fba000a)
[629591.940556] nfsv4 compound op ffff882839705080 opcnt 4 #2: 22: 
status 0
[629591.948776] nfsv4 compound op #3/4: 3 (OP_ACCESS)
[629591.954607] nfsd: fh_verify(32: 01060001 63ce4307 5a18c100 00000000 
00000000 1fba000a)
[629591.967117] nfsv4 compound op ffff882839705080 opcnt 4 #3: 3: status 
0
[629591.975364] nfsv4 compound op #4/4: 9 (OP_GETATTR)
[629591.980854] nfsd: fh_verify(32: 01060001 63ce4307 5a18c100 00000000 
00000000 1fba000a)
[629591.990257] nfsv4 compound op ffff882839705080 opcnt 4 #4: 9: status 
0
[629591.996796] nfsv4 compound returned 0
[629592.001758] --> nfsd4_store_cache_entry slot ffff882838b9e000
[629592.008061] renewing client (clientid 5e26dc02/77d38d9d)

Using wireshark, this is the log of the packages from/to that ip 
address:

# tshark -i eth0 -p -w /tmp/nfs_mount.cap host 10.1.0.12 and port nfs
# tshark -r /tmp/nfs_mount.cap
   1 0.000000000    10.1.0.12 -> 10.0.2.9     NFS 202 V4 Call PUTROOTFH | 
GETATTR
   2 0.000058001     10.0.2.9 -> 10.1.0.12    TCP 54 nfs > rndc [ACK] 
Seq=1 Ack=149 Win=1432 Len=0
   3 0.074041118     10.0.2.9 -> 10.1.0.12    NFS 146 V4 Reply (Call In 
1) PUTROOTFH Status: NFS4ERR_WRONGSEC
   4 0.074927630    10.1.0.12 -> 10.0.2.9     TCP 54 rndc > nfs [ACK] 
Seq=149 Ack=93 Win=1476 Len=0
   5 0.084223658    10.1.0.12 -> 10.0.2.9     NFS 266 V4 Call ACCESS FH: 
0xea1b01ae, [Check: RD LU MD XT DL]
   6 0.084270458     10.0.2.9 -> 10.1.0.12    TCP 54 nfs > rndc [ACK] 
Seq=93 Ack=361 Win=1432 Len=0
   7 0.208635667     10.0.2.9 -> 10.1.0.12    NFS 254 V4 Reply (Call In 
5) ACCESS, [Access Denied: RD MD XT DL], [Allowed: LU]
   8 0.248855020    10.1.0.12 -> 10.0.2.9     TCP 54 rndc > nfs [ACK] 
Seq=361 Ack=293 Win=1498 Len=0

I think the frame of interest is #1, so this is its contents:
Frame 1: 202 bytes on wire (1616 bits), 202 bytes captured (1616 bits) 
on interface 0
     Interface id: 0
     Encapsulation type: Ethernet (1)
     Arrival Time: Jan 24, 2020 17:39:05.721360043 CET
     [Time shift for this packet: 0.000000000 seconds]
     Epoch Time: 1579883945.721360043 seconds
     [Time delta from previous captured frame: 0.000000000 seconds]
     [Time delta from previous displayed frame: 0.000000000 seconds]
     [Time since reference or first frame: 0.000000000 seconds]
     Frame Number: 1
     Frame Length: 202 bytes (1616 bits)
     Capture Length: 202 bytes (1616 bits)
     [Frame is marked: False]
     [Frame is ignored: False]
     [Protocols in frame: eth:ip:tcp:rpc]
Ethernet II, Src: 00:81:c4:c1:50:7f (00:81:c4:c1:50:7f), Dst: 
Microsof_44:24:d3 (00:0d:3a:44:24:d3)
     Destination: Microsof_44:24:d3 (00:0d:3a:44:24:d3)
         Address: Microsof_44:24:d3 (00:0d:3a:44:24:d3)
         .... ..0. .... .... .... .... = LG bit: Globally unique address 
(factory default)
         .... ...0 .... .... .... .... = IG bit: Individual address 
(unicast)
     Source: 00:81:c4:c1:50:7f (00:81:c4:c1:50:7f)
         Address: 00:81:c4:c1:50:7f (00:81:c4:c1:50:7f)
         .... ..0. .... .... .... .... = LG bit: Globally unique address 
(factory default)
         .... ...0 .... .... .... .... = IG bit: Individual address 
(unicast)
     Type: IP (0x0800)
Internet Protocol Version 4, Src: 10.1.0.12 (10.1.0.12), Dst: 10.0.2.9 
(10.0.2.9)
     Version: 4
     Header length: 20 bytes
     Differentiated Services Field: 0x00 (DSCP 0x00: Default; ECN: 0x00: 
Not-ECT (Not ECN-Capable Transport))
         0000 00.. = Differentiated Services Codepoint: Default (0x00)
         .... ..00 = Explicit Congestion Notification: Not-ECT (Not 
ECN-Capable Transport) (0x00)
     Total Length: 188
     Identification: 0xa3e0 (41952)
     Flags: 0x02 (Don't Fragment)
         0... .... = Reserved bit: Not set
         .1.. .... = Don't fragment: Set
         ..0. .... = More fragments: Not set
     Fragment offset: 0
     Time to live: 64
     Protocol: TCP (6)
     Header checksum: 0x8046 [validation disabled]
         [Good: False]
         [Bad: False]
     Source: 10.1.0.12 (10.1.0.12)
     Destination: 10.0.2.9 (10.0.2.9)
Transmission Control Protocol, Src Port: rndc (953), Dst Port: nfs 
(2049), Seq: 1, Ack: 1, Len: 148
     Source port: rndc (953)
     Destination port: nfs (2049)
     [Stream index: 0]
     Sequence number: 1    (relative sequence number)
     [Next sequence number: 149    (relative sequence number)]
     Acknowledgment number: 1    (relative ack number)
     Header length: 20 bytes
     Flags: 0x018 (PSH, ACK)
         000. .... .... = Reserved: Not set
         ...0 .... .... = Nonce: Not set
         .... 0... .... = Congestion Window Reduced (CWR): Not set
         .... .0.. .... = ECN-Echo: Not set
         .... ..0. .... = Urgent: Not set
         .... ...1 .... = Acknowledgment: Set
         .... .... 1... = Push: Set
         .... .... .0.. = Reset: Not set
         .... .... ..0. = Syn: Not set
         .... .... ...0 = Fin: Not set
     Window size value: 1476
     [Calculated window size: 1476]
     [Window size scaling factor: -1 (unknown)]
     Checksum: 0x4455 [validation disabled]
         [Good Checksum: False]
         [Bad Checksum: False]
     [SEQ/ACK analysis]
         [Bytes in flight: 148]
Remote Procedure Call, Type:Call XID:0xd17c6210
     Fragment header: Last fragment, 144 bytes
         1... .... .... .... .... .... .... .... = Last Fragment: Yes
         .000 0000 0000 0000 0000 0000 1001 0000 = Fragment Length: 144
     XID: 0xd17c6210 (3514589712)
     Message Type: Call (0)
     RPC Version: 2
     Program: NFS (100003)
     Program Version: 4
     Procedure: COMPOUND (1)
     Credentials
         Flavor: AUTH_UNIX (1)
         Length: 32
         Stamp: 0x00418ae8
         Machine Name: worker01
             length: 8
             contents: worker01
         UID: 0
         GID: 0
         Auxiliary GIDs (1) [0]
             GID: 0
     Verifier
         Flavor: AUTH_NULL (0)
         Length: 0
Network File System, Ops(4): SEQUENCE, PUTROOTFH, GETFH, GETATTR
     [Program Version: 4]
     [V4 Procedure: COMPOUND (1)]
     Tag: <EMPTY>
         length: 0
         contents: <EMPTY>
     minorversion: 1
     Operations (count: 4): SEQUENCE, PUTROOTFH, GETFH, GETATTR
         Opcode: SEQUENCE (53)
             sessionid: 02dc265e9d8dd3776300000000000000
             seqid: 0x0000009b
             slot id: 0
             high slot id: 0
             cache this?: No
         Opcode: PUTROOTFH (24)
         Opcode: GETFH (10)
         Opcode: GETATTR (9)
             Attr mask[0]: 0x0010011a (TYPE, CHANGE, SIZE, FSID, FILEID)
                 reqd_attr: TYPE (1)
                 reqd_attr: CHANGE (3)
                 reqd_attr: SIZE (4)
                 reqd_attr: FSID (8)
                 reco_attr: FILEID (20)
             Attr mask[1]: 0x00b0a23a (MODE, NUMLINKS, OWNER, 
OWNER_GROUP, RAWDEV, SPACE_USED, TIME_ACCESS, TIME_METADATA, 
TIME_MODIFY, MOUNTED_ON_FILEID)
                 reco_attr: MODE (33)
                 reco_attr: NUMLINKS (35)
                 reco_attr: OWNER (36)
                 reco_attr: OWNER_GROUP (37)
                 reco_attr: RAWDEV (41)
                 reco_attr: SPACE_USED (45)
                 reco_attr: TIME_ACCESS (47)
                 reco_attr: TIME_METADATA (52)
                 reco_attr: TIME_MODIFY (53)
                 reco_attr: MOUNTED_ON_FILEID (55)
     [Main Opcode: PUTROOTFH (24)]
     [Main Opcode: GETATTR (9)]

Just in case, this is the answer of the server:
Frame 3: 146 bytes on wire (1168 bits), 146 bytes captured (1168 bits) 
on interface 0
     Interface id: 0
     Encapsulation type: Ethernet (1)
     Arrival Time: Jan 24, 2020 17:39:05.795401161 CET
     [Time shift for this packet: 0.000000000 seconds]
     Epoch Time: 1579883945.795401161 seconds
     [Time delta from previous captured frame: 0.073983117 seconds]
     [Time delta from previous displayed frame: 0.000000000 seconds]
     [Time since reference or first frame: 0.074041118 seconds]
     Frame Number: 3
     Frame Length: 146 bytes (1168 bits)
     Capture Length: 146 bytes (1168 bits)
     [Frame is marked: False]
     [Frame is ignored: False]
     [Protocols in frame: eth:ip:tcp:rpc]
Ethernet II, Src: Microsof_44:24:d3 (00:0d:3a:44:24:d3), Dst: 
12:34:56:78:9a:bc (12:34:56:78:9a:bc)
     Destination: 12:34:56:78:9a:bc (12:34:56:78:9a:bc)
         Address: 12:34:56:78:9a:bc (12:34:56:78:9a:bc)
         .... ..1. .... .... .... .... = LG bit: Locally administered 
address (this is NOT the factory default)
         .... ...0 .... .... .... .... = IG bit: Individual address 
(unicast)
     Source: Microsof_44:24:d3 (00:0d:3a:44:24:d3)
         Address: Microsof_44:24:d3 (00:0d:3a:44:24:d3)
         .... ..0. .... .... .... .... = LG bit: Globally unique address 
(factory default)
         .... ...0 .... .... .... .... = IG bit: Individual address 
(unicast)
     Type: IP (0x0800)
Internet Protocol Version 4, Src: 10.0.2.9 (10.0.2.9), Dst: 10.1.0.12 
(10.1.0.12)
     Version: 4
     Header length: 20 bytes
     Differentiated Services Field: 0x00 (DSCP 0x00: Default; ECN: 0x00: 
Not-ECT (Not ECN-Capable Transport))
         0000 00.. = Differentiated Services Codepoint: Default (0x00)
         .... ..00 = Explicit Congestion Notification: Not-ECT (Not 
ECN-Capable Transport) (0x00)
     Total Length: 132
     Identification: 0x794c (31052)
     Flags: 0x02 (Don't Fragment)
         0... .... = Reserved bit: Not set
         .1.. .... = Don't fragment: Set
         ..0. .... = More fragments: Not set
     Fragment offset: 0
     Time to live: 64
     Protocol: TCP (6)
     Header checksum: 0xab12 [validation disabled]
         [Good: False]
         [Bad: False]
     Source: 10.0.2.9 (10.0.2.9)
     Destination: 10.1.0.12 (10.1.0.12)
Transmission Control Protocol, Src Port: nfs (2049), Dst Port: rndc 
(953), Seq: 1, Ack: 149, Len: 92
     Source port: nfs (2049)
     Destination port: rndc (953)
     [Stream index: 0]
     Sequence number: 1    (relative sequence number)
     [Next sequence number: 93    (relative sequence number)]
     Acknowledgment number: 149    (relative ack number)
     Header length: 20 bytes
     Flags: 0x018 (PSH, ACK)
         000. .... .... = Reserved: Not set
         ...0 .... .... = Nonce: Not set
         .... 0... .... = Congestion Window Reduced (CWR): Not set
         .... .0.. .... = ECN-Echo: Not set
         .... ..0. .... = Urgent: Not set
         .... ...1 .... = Acknowledgment: Set
         .... .... 1... = Push: Set
         .... .... .0.. = Reset: Not set
         .... .... ..0. = Syn: Not set
         .... .... ...0 = Fin: Not set
     Window size value: 1432
     [Calculated window size: 1432]
     [Window size scaling factor: -1 (unknown)]
     Checksum: 0x168c [validation disabled]
         [Good Checksum: False]
         [Bad Checksum: False]
     [SEQ/ACK analysis]
         [Bytes in flight: 92]
Remote Procedure Call, Type:Reply XID:0xd17c6210
     Fragment header: Last fragment, 88 bytes
         1... .... .... .... .... .... .... .... = Last Fragment: Yes
         .000 0000 0000 0000 0000 0000 0101 1000 = Fragment Length: 88
     XID: 0xd17c6210 (3514589712)
     Message Type: Reply (1)
     [Program: NFS (100003)]
     [Program Version: 4]
     [Procedure: COMPOUND (1)]
     Reply State: accepted (0)
     [This is a reply to a request in frame 1]
     [Time from request: 0.074041118 seconds]
     Verifier
         Flavor: AUTH_NULL (0)
         Length: 0
     Accept State: RPC executed successfully (0)
Network File System, Ops(2): SEQUENCE PUTROOTFH(NFS4ERR_WRONGSEC)
     [Program Version: 4]
     [V4 Procedure: COMPOUND (1)]
     Status: NFS4ERR_WRONGSEC (10016)
     Tag: <EMPTY>
         length: 0
         contents: <EMPTY>
     Operations (count: 2)
         Opcode: SEQUENCE (53)
             Status: NFS4_OK (0)
             sessionid: 02dc265e9d8dd3776300000000000000
             seqid: 0x0000009b
             slot id: 0
             high slot id: 9
             target high slot id: 9
             status flags: 0x00000000
                 .... .... .... .... .... .... .... ...0 = 
SEQ4_STATUS_CB_PATH_DOWN: Not set
                 .... .... .... .... .... .... .... ..0. = 
SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRING: Not set
                 .... .... .... .... .... .... .... .0.. = 
SEQ4_STATUS_CB_GSS_CONTEXTS_EXPIRED: Not set
                 .... .... .... .... .... .... .... 0... = 
SEQ4_STATUS_EXPIRED_ALL_STATE_REVOKED: Not set
                 .... .... .... .... .... .... ...0 .... = 
SEQ4_STATUS_EXPIRED_SOME_STATE_REVOKED: Not set
                 .... .... .... .... .... .... ..0. .... = 
SEQ4_STATUS_ADMIN_STATE_REVOKED: Not set
                 .... .... .... .... .... .... .0.. .... = 
SEQ4_STATUS_RECALLABLE_STATE_REVOKED: Not set
                 .... .... .... .... .... .... 0... .... = 
SEQ4_STATUS_LEASE_MOVED: Not set
                 .... .... .... .... .... ...0 .... .... = 
SEQ4_STATUS_RESTART_RECLAIM_NEEDED: Not set
                 .... .... .... .... .... ..0. .... .... = 
SEQ4_STATUS_CB_PATH_DOWN_SESSION: Not set
                 .... .... .... .... .... .0.. .... .... = 
SEQ4_STATUS_BACKCHANNEL_FAULT: Not set
                 .... .... .... .... .... 0... .... .... = 
SEQ4_STATUS_DEVID_CHANGED: Not set
                 .... .... .... .... ...0 .... .... .... = 
SEQ4_STATUS_DEVID_DELETED: Not set
         Opcode: PUTROOTFH (24)
             Status: NFS4ERR_WRONGSEC (10016)
     [Main Opcode: PUTROOTFH (24)]

Does this provide any light?

Thank you very much for your help!

Felix


---
Felix Rubio
"Don't believe what you're told. Double check."
