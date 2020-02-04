Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 099E01520E5
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2020 20:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgBDTOx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Feb 2020 14:14:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37475 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727314AbgBDTOw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Feb 2020 14:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580843691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qzf+mQRnTBj6DOHudNHZ6OMd7Si1CEqxw7dgwQwVIIA=;
        b=ZZUJEb9hqNy2nTetYmPu7hzaktyP9W/xDS9g2ctNLMH/Vu/iKgkfWDV9OteyBLSNBdfAKF
        33bJwnIAWz38Vl+3h9fXZWWVdS+sBnNVkOOR5OkLPLHshJVR1bwlldMEHbkbCu+N1exnPe
        4L4oiFnAhXWhsZCdGWo9MheuvvG2eic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-lr6U-fSmOnOQH2p2KD4D8Q-1; Tue, 04 Feb 2020 14:14:47 -0500
X-MC-Unique: lr6U-fSmOnOQH2p2KD4D8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E52EFA0CC1;
        Tue,  4 Feb 2020 19:14:46 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96DAB19C69;
        Tue,  4 Feb 2020 19:14:46 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Felix Rubio" <felix@kngnt.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
Date:   Tue, 04 Feb 2020 14:14:45 -0500
Message-ID: <9B0320D2-CA0A-4EA1-BAAD-6CB30A56C7C7@redhat.com>
In-Reply-To: <b93eadb0240439b8ca8286deb708a517@kngnt.org>
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
 <724CB91C-76AC-425B-BAE3-04887ED5DE73@redhat.com>
 <6d998611c9205d6a0a8bf3806c297011@kngnt.org>
 <87BD58D0-7A14-42BB-BA8F-54E6C78B2755@redhat.com>
 <b93eadb0240439b8ca8286deb708a517@kngnt.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 24 Jan 2020, at 11:49, Felix Rubio wrote:

> Hi Benjamin,
>
>     I have enabled the debug logging on nfsd by running
>
>     When mounting from the client, this is what I get:
>
> [629588.647849] nfsd_dispatch: vers 4 proc 1
> [629588.655615] nfsv4 compound op #1/1: 53 (OP_SEQUENCE)
> [629588.663926] __find_in_sessionid_hashtbl: 
> 1579604994:2010353049:95:0
> [629588.675361] nfsd4_sequence: slotid 0
> [629588.679065] check_slot_seqid enter. seqid 644 slot_seqid 643
> [629588.684589] nfsv4 compound op ffff882839705080 opcnt 1 #1: 53: 
> status 0
> [629588.691545] nfsv4 compound returned 0
> [629588.695292] --> nfsd4_store_cache_entry slot ffff882806e83000
> [629588.701933] renewing client (clientid 5e26dc02/77d38d99)
> [629591.804857] nfsd_dispatch: vers 4 proc 1
> [629591.809364] nfsv4 compound op #1/4: 53 (OP_SEQUENCE)
> [629591.814944] __find_in_sessionid_hashtbl: 
> 1579604994:2010353053:99:0
> [629591.822163] nfsd4_sequence: slotid 0
> [629591.826670] check_slot_seqid enter. seqid 155 slot_seqid 154
> [629591.832771] nfsv4 compound op ffff882839705080 opcnt 4 #1: 53: 
> status 0
> [629591.839864] nfsv4 compound op #2/4: 24 (OP_PUTROOTFH)
> [629591.845161] nfsd: fh_compose(exp 08:02/17468677 /export, 
> ino=17468677)
> [629591.851706] nfsv4 compound op ffff882839705080 opcnt 4 #2: 24: 
> status 10016
> [629591.859660] nfsv4 compound returned 10016

So this is definitely the server returning NFS4ERR_WRONGSEC..

> [629591.864797] --> nfsd4_store_cache_entry slot ffff882838b9e000
> [629591.872968] renewing client (clientid 5e26dc02/77d38d9d)
> [629591.889085] nfsd_dispatch: vers 4 proc 1
> [629591.893713] nfsv4 compound op #1/4: 53 (OP_SEQUENCE)
> [629591.899703] __find_in_sessionid_hashtbl: 
> 1579604994:2010353053:99:0
> [629591.906687] nfsd4_sequence: slotid 0
> [629591.912695] check_slot_seqid enter. seqid 156 slot_seqid 155
> [629591.918261] nfsv4 compound op ffff882839705080 opcnt 4 #1: 53: 
> status 0
> [629591.924866] nfsv4 compound op #2/4: 22 (OP_PUTFH)
> [629591.931075] nfsd: fh_verify(32: 01060001 63ce4307 5a18c100 
> 00000000 00000000 1fba000a)
> [629591.940556] nfsv4 compound op ffff882839705080 opcnt 4 #2: 22: 
> status 0
> [629591.948776] nfsv4 compound op #3/4: 3 (OP_ACCESS)
> [629591.954607] nfsd: fh_verify(32: 01060001 63ce4307 5a18c100 
> 00000000 00000000 1fba000a)
> [629591.967117] nfsv4 compound op ffff882839705080 opcnt 4 #3: 3: 
> status 0
> [629591.975364] nfsv4 compound op #4/4: 9 (OP_GETATTR)
> [629591.980854] nfsd: fh_verify(32: 01060001 63ce4307 5a18c100 
> 00000000 00000000 1fba000a)
> [629591.990257] nfsv4 compound op ffff882839705080 opcnt 4 #4: 9: 
> status 0
> [629591.996796] nfsv4 compound returned 0
> [629592.001758] --> nfsd4_store_cache_entry slot ffff882838b9e000
> [629592.008061] renewing client (clientid 5e26dc02/77d38d9d)
>
> Using wireshark, this is the log of the packages from/to that ip 
> address:
>
> # tshark -i eth0 -p -w /tmp/nfs_mount.cap host 10.1.0.12 and port nfs
> # tshark -r /tmp/nfs_mount.cap
>   1 0.000000000    10.1.0.12 -> 10.0.2.9     NFS 202 V4 Call PUTROOTFH 
> | GETATTR

..to this call ^^ ..

>   2 0.000058001     10.0.2.9 -> 10.1.0.12    TCP 54 nfs > rndc [ACK] 
> Seq=1 Ack=149 Win=1432 Len=0
>   3 0.074041118     10.0.2.9 -> 10.1.0.12    NFS 146 V4 Reply (Call In 
> 1) PUTROOTFH Status: NFS4ERR_WRONGSEC
>   4 0.074927630    10.1.0.12 -> 10.0.2.9     TCP 54 rndc > nfs [ACK] 
> Seq=149 Ack=93 Win=1476 Len=0
>   5 0.084223658    10.1.0.12 -> 10.0.2.9     NFS 266 V4 Call ACCESS 
> FH: 0xea1b01ae, [Check: RD LU MD XT DL]
>   6 0.084270458     10.0.2.9 -> 10.1.0.12    TCP 54 nfs > rndc [ACK] 
> Seq=93 Ack=361 Win=1432 Len=0
>   7 0.208635667     10.0.2.9 -> 10.1.0.12    NFS 254 V4 Reply (Call In 
> 5) ACCESS, [Access Denied: RD MD XT DL], [Allowed: LU]
>   8 0.248855020    10.1.0.12 -> 10.0.2.9     TCP 54 rndc > nfs [ACK] 
> Seq=361 Ack=293 Win=1498 Len=0
>
> I think the frame of interest is #1, so this is its contents:
> Frame 1: 202 bytes on wire (1616 bits), 202 bytes captured (1616 bits) 
> on interface 0
>     Interface id: 0
>     Encapsulation type: Ethernet (1)
>     Arrival Time: Jan 24, 2020 17:39:05.721360043 CET
>     [Time shift for this packet: 0.000000000 seconds]
>     Epoch Time: 1579883945.721360043 seconds
>     [Time delta from previous captured frame: 0.000000000 seconds]
>     [Time delta from previous displayed frame: 0.000000000 seconds]
>     [Time since reference or first frame: 0.000000000 seconds]
>     Frame Number: 1
>     Frame Length: 202 bytes (1616 bits)
>     Capture Length: 202 bytes (1616 bits)
>     [Frame is marked: False]
>     [Frame is ignored: False]
>     [Protocols in frame: eth:ip:tcp:rpc]
> Ethernet II, Src: 00:81:c4:c1:50:7f (00:81:c4:c1:50:7f), Dst: 
> Microsof_44:24:d3 (00:0d:3a:44:24:d3)
>     Destination: Microsof_44:24:d3 (00:0d:3a:44:24:d3)
>         Address: Microsof_44:24:d3 (00:0d:3a:44:24:d3)
>         .... ..0. .... .... .... .... = LG bit: Globally unique 
> address (factory default)
>         .... ...0 .... .... .... .... = IG bit: Individual address 
> (unicast)
>     Source: 00:81:c4:c1:50:7f (00:81:c4:c1:50:7f)
>         Address: 00:81:c4:c1:50:7f (00:81:c4:c1:50:7f)
>         .... ..0. .... .... .... .... = LG bit: Globally unique 
> address (factory default)
>         .... ...0 .... .... .... .... = IG bit: Individual address 
> (unicast)
>     Type: IP (0x0800)
> Internet Protocol Version 4, Src: 10.1.0.12 (10.1.0.12), Dst: 10.0.2.9 
> (10.0.2.9)
>     Version: 4
>     Header length: 20 bytes
>     Differentiated Services Field: 0x00 (DSCP 0x00: Default; ECN: 
> 0x00: Not-ECT (Not ECN-Capable Transport))
>         0000 00.. = Differentiated Services Codepoint: Default (0x00)
>         .... ..00 = Explicit Congestion Notification: Not-ECT (Not 
> ECN-Capable Transport) (0x00)
>     Total Length: 188
>     Identification: 0xa3e0 (41952)
>     Flags: 0x02 (Don't Fragment)
>         0... .... = Reserved bit: Not set
>         .1.. .... = Don't fragment: Set
>         ..0. .... = More fragments: Not set
>     Fragment offset: 0
>     Time to live: 64
>     Protocol: TCP (6)
>     Header checksum: 0x8046 [validation disabled]
>         [Good: False]
>         [Bad: False]
>     Source: 10.1.0.12 (10.1.0.12)
>     Destination: 10.0.2.9 (10.0.2.9)
> Transmission Control Protocol, Src Port: rndc (953), Dst Port: nfs 
> (2049), Seq: 1, Ack: 1, Len: 148
>     Source port: rndc (953)
>     Destination port: nfs (2049)
>     [Stream index: 0]
>     Sequence number: 1    (relative sequence number)
>     [Next sequence number: 149    (relative sequence number)]
>     Acknowledgment number: 1    (relative ack number)
>     Header length: 20 bytes
>     Flags: 0x018 (PSH, ACK)
>         000. .... .... = Reserved: Not set
>         ...0 .... .... = Nonce: Not set
>         .... 0... .... = Congestion Window Reduced (CWR): Not set
>         .... .0.. .... = ECN-Echo: Not set
>         .... ..0. .... = Urgent: Not set
>         .... ...1 .... = Acknowledgment: Set
>         .... .... 1... = Push: Set
>         .... .... .0.. = Reset: Not set
>         .... .... ..0. = Syn: Not set
>         .... .... ...0 = Fin: Not set
>     Window size value: 1476
>     [Calculated window size: 1476]
>     [Window size scaling factor: -1 (unknown)]
>     Checksum: 0x4455 [validation disabled]
>         [Good Checksum: False]
>         [Bad Checksum: False]
>     [SEQ/ACK analysis]
>         [Bytes in flight: 148]
> Remote Procedure Call, Type:Call XID:0xd17c6210
>     Fragment header: Last fragment, 144 bytes
>         1... .... .... .... .... .... .... .... = Last Fragment: Yes
>         .000 0000 0000 0000 0000 0000 1001 0000 = Fragment Length: 144
>     XID: 0xd17c6210 (3514589712)
>     Message Type: Call (0)
>     RPC Version: 2
>     Program: NFS (100003)
>     Program Version: 4
>     Procedure: COMPOUND (1)
>     Credentials
>         Flavor: AUTH_UNIX (1)

.. and the client is using AUTH_UNIX, or sec=sys.  Seems your server 
isn't
picking up the change to the export for the root for some reason.

How are you modifying the export?  What does `exportfs -v` say?

Ben

