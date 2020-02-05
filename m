Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE41529AB
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2020 12:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBELJ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Feb 2020 06:09:57 -0500
Received: from smtpq4.tb.mail.iss.as9143.net ([212.54.42.167]:50770 "EHLO
        smtpq4.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727170AbgBELJ5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Feb 2020 06:09:57 -0500
Received: from [212.54.42.137] (helo=smtp6.tb.mail.iss.as9143.net)
        by smtpq4.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <felix@kngnt.org>)
        id 1izIZ6-0001iK-JJ; Wed, 05 Feb 2020 12:09:52 +0100
Received: from 94-209-183-118.cable.dynamic.v4.ziggo.nl ([94.209.183.118] helo=mail.kngnt.org)
        by smtp6.tb.mail.iss.as9143.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <felix@kngnt.org>)
        id 1izIZ6-0006ju-Fd; Wed, 05 Feb 2020 12:09:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kngnt.org; s=mail;
        t=1580900991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2+iWvIXRJ6853htMEkC1UUd1bViu0TjGbQodHKtgbU=;
        b=BgLMs8RKNA12pjs7no2JEfP3nyX04p25DDVLoERlPOBUZlPNzDJRyGl740IiOm6V4HnCFu
        xNyHEYa5lNuNwRZWIxKgHNXvGK+Zq3AXJ0P/1E0fhTi8QRmwPynYAqqrJvR6GRoqI7tREG
        RP1wa5ddp889/MyE99quWDEgMYGwTeqQ0BNL/Ud4JIDG3U+S5kusCfi2sr1cyd5EcZH07K
        uDQMqxK2UH9fMUQUWifAAfj5Hlj6kDWVOaRXah2XsuIambKEftI6BmqsslzMb11umSGREg
        k1Rw4U1SEnIqS1F/Fqhm0mD3Ala1Ei2h8A8tiZhYV8iXIHy6EgQezwvkBN3zbg==
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Feb 2020 12:09:51 +0100
From:   Felix Rubio <felix@kngnt.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
In-Reply-To: <9B0320D2-CA0A-4EA1-BAAD-6CB30A56C7C7@redhat.com>
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
 <724CB91C-76AC-425B-BAE3-04887ED5DE73@redhat.com>
 <6d998611c9205d6a0a8bf3806c297011@kngnt.org>
 <87BD58D0-7A14-42BB-BA8F-54E6C78B2755@redhat.com>
 <b93eadb0240439b8ca8286deb708a517@kngnt.org>
 <9B0320D2-CA0A-4EA1-BAAD-6CB30A56C7C7@redhat.com>
Message-ID: <9c84ea206c562d00eed526d6b8539404@kngnt.org>
X-Sender: felix@kngnt.org
X-SourceIP: 94.209.183.118
X-Authenticated-Sender: f.rubiodalmau@ziggo.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=W/FGqiek c=1 sm=1 tr=0 a=KDOoBKh8T/kja8HrlTi2+A==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=l697ptgUJYAA:10 a=D7LYSQ-zpW_tMKFIR4wA:9 a=CEo8RZIc0JqJ824J:21 a=bc4ac6GGH6fjpXs9:21 a=QEXdDO2ut3YA:10
X-Ziggo-Spam-Status: No
X-Spam-Status: No
X-Spam-Flag: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ben,

exportfs -v returns the following output:

/export/home    
10.0.0.0/8(sync,wdelay,hide,no_subtree_check,sec=sys:krb5:krb5i:krb5p,rw,secure,root_squash,no_all_squash)

Maybe helps to know that I am using a CentOS 7.7.1908, SELinux enabled, 
kernel (provided by CentOS) 3.10.0-1062.9.1.el7.x86_64.

Thank you for your help!
Felix

---
Felix Rubio
"Don't believe what you're told. Double check."

On 2020-02-04 20:14, Benjamin Coddington wrote:
> On 24 Jan 2020, at 11:49, Felix Rubio wrote:
> 
>> Hi Benjamin,
>> 
>>     I have enabled the debug logging on nfsd by running
>> 
>>     When mounting from the client, this is what I get:
>> 
>> [629588.647849] nfsd_dispatch: vers 4 proc 1
>> [629588.655615] nfsv4 compound op #1/1: 53 (OP_SEQUENCE)
>> [629588.663926] __find_in_sessionid_hashtbl: 
>> 1579604994:2010353049:95:0
>> [629588.675361] nfsd4_sequence: slotid 0
>> [629588.679065] check_slot_seqid enter. seqid 644 slot_seqid 643
>> [629588.684589] nfsv4 compound op ffff882839705080 opcnt 1 #1: 53: 
>> status 0
>> [629588.691545] nfsv4 compound returned 0
>> [629588.695292] --> nfsd4_store_cache_entry slot ffff882806e83000
>> [629588.701933] renewing client (clientid 5e26dc02/77d38d99)
>> [629591.804857] nfsd_dispatch: vers 4 proc 1
>> [629591.809364] nfsv4 compound op #1/4: 53 (OP_SEQUENCE)
>> [629591.814944] __find_in_sessionid_hashtbl: 
>> 1579604994:2010353053:99:0
>> [629591.822163] nfsd4_sequence: slotid 0
>> [629591.826670] check_slot_seqid enter. seqid 155 slot_seqid 154
>> [629591.832771] nfsv4 compound op ffff882839705080 opcnt 4 #1: 53: 
>> status 0
>> [629591.839864] nfsv4 compound op #2/4: 24 (OP_PUTROOTFH)
>> [629591.845161] nfsd: fh_compose(exp 08:02/17468677 /export, 
>> ino=17468677)
>> [629591.851706] nfsv4 compound op ffff882839705080 opcnt 4 #2: 24: 
>> status 10016
>> [629591.859660] nfsv4 compound returned 10016
> 
> So this is definitely the server returning NFS4ERR_WRONGSEC..
> 
>> [629591.864797] --> nfsd4_store_cache_entry slot ffff882838b9e000
>> [629591.872968] renewing client (clientid 5e26dc02/77d38d9d)
>> [629591.889085] nfsd_dispatch: vers 4 proc 1
>> [629591.893713] nfsv4 compound op #1/4: 53 (OP_SEQUENCE)
>> [629591.899703] __find_in_sessionid_hashtbl: 
>> 1579604994:2010353053:99:0
>> [629591.906687] nfsd4_sequence: slotid 0
>> [629591.912695] check_slot_seqid enter. seqid 156 slot_seqid 155
>> [629591.918261] nfsv4 compound op ffff882839705080 opcnt 4 #1: 53: 
>> status 0
>> [629591.924866] nfsv4 compound op #2/4: 22 (OP_PUTFH)
>> [629591.931075] nfsd: fh_verify(32: 01060001 63ce4307 5a18c100 
>> 00000000 00000000 1fba000a)
>> [629591.940556] nfsv4 compound op ffff882839705080 opcnt 4 #2: 22: 
>> status 0
>> [629591.948776] nfsv4 compound op #3/4: 3 (OP_ACCESS)
>> [629591.954607] nfsd: fh_verify(32: 01060001 63ce4307 5a18c100 
>> 00000000 00000000 1fba000a)
>> [629591.967117] nfsv4 compound op ffff882839705080 opcnt 4 #3: 3: 
>> status 0
>> [629591.975364] nfsv4 compound op #4/4: 9 (OP_GETATTR)
>> [629591.980854] nfsd: fh_verify(32: 01060001 63ce4307 5a18c100 
>> 00000000 00000000 1fba000a)
>> [629591.990257] nfsv4 compound op ffff882839705080 opcnt 4 #4: 9: 
>> status 0
>> [629591.996796] nfsv4 compound returned 0
>> [629592.001758] --> nfsd4_store_cache_entry slot ffff882838b9e000
>> [629592.008061] renewing client (clientid 5e26dc02/77d38d9d)
>> 
>> Using wireshark, this is the log of the packages from/to that ip 
>> address:
>> 
>> # tshark -i eth0 -p -w /tmp/nfs_mount.cap host 10.1.0.12 and port nfs
>> # tshark -r /tmp/nfs_mount.cap
>>   1 0.000000000    10.1.0.12 -> 10.0.2.9     NFS 202 V4 Call PUTROOTFH 
>> | GETATTR
> 
> ..to this call ^^ ..
> 
>>   2 0.000058001     10.0.2.9 -> 10.1.0.12    TCP 54 nfs > rndc [ACK] 
>> Seq=1 Ack=149 Win=1432 Len=0
>>   3 0.074041118     10.0.2.9 -> 10.1.0.12    NFS 146 V4 Reply (Call In 
>> 1) PUTROOTFH Status: NFS4ERR_WRONGSEC
>>   4 0.074927630    10.1.0.12 -> 10.0.2.9     TCP 54 rndc > nfs [ACK] 
>> Seq=149 Ack=93 Win=1476 Len=0
>>   5 0.084223658    10.1.0.12 -> 10.0.2.9     NFS 266 V4 Call ACCESS 
>> FH: 0xea1b01ae, [Check: RD LU MD XT DL]
>>   6 0.084270458     10.0.2.9 -> 10.1.0.12    TCP 54 nfs > rndc [ACK] 
>> Seq=93 Ack=361 Win=1432 Len=0
>>   7 0.208635667     10.0.2.9 -> 10.1.0.12    NFS 254 V4 Reply (Call In 
>> 5) ACCESS, [Access Denied: RD MD XT DL], [Allowed: LU]
>>   8 0.248855020    10.1.0.12 -> 10.0.2.9     TCP 54 rndc > nfs [ACK] 
>> Seq=361 Ack=293 Win=1498 Len=0
>> 
>> I think the frame of interest is #1, so this is its contents:
>> Frame 1: 202 bytes on wire (1616 bits), 202 bytes captured (1616 bits) 
>> on interface 0
>>     Interface id: 0
>>     Encapsulation type: Ethernet (1)
>>     Arrival Time: Jan 24, 2020 17:39:05.721360043 CET
>>     [Time shift for this packet: 0.000000000 seconds]
>>     Epoch Time: 1579883945.721360043 seconds
>>     [Time delta from previous captured frame: 0.000000000 seconds]
>>     [Time delta from previous displayed frame: 0.000000000 seconds]
>>     [Time since reference or first frame: 0.000000000 seconds]
>>     Frame Number: 1
>>     Frame Length: 202 bytes (1616 bits)
>>     Capture Length: 202 bytes (1616 bits)
>>     [Frame is marked: False]
>>     [Frame is ignored: False]
>>     [Protocols in frame: eth:ip:tcp:rpc]
>> Ethernet II, Src: 00:81:c4:c1:50:7f (00:81:c4:c1:50:7f), Dst: 
>> Microsof_44:24:d3 (00:0d:3a:44:24:d3)
>>     Destination: Microsof_44:24:d3 (00:0d:3a:44:24:d3)
>>         Address: Microsof_44:24:d3 (00:0d:3a:44:24:d3)
>>         .... ..0. .... .... .... .... = LG bit: Globally unique 
>> address (factory default)
>>         .... ...0 .... .... .... .... = IG bit: Individual address 
>> (unicast)
>>     Source: 00:81:c4:c1:50:7f (00:81:c4:c1:50:7f)
>>         Address: 00:81:c4:c1:50:7f (00:81:c4:c1:50:7f)
>>         .... ..0. .... .... .... .... = LG bit: Globally unique 
>> address (factory default)
>>         .... ...0 .... .... .... .... = IG bit: Individual address 
>> (unicast)
>>     Type: IP (0x0800)
>> Internet Protocol Version 4, Src: 10.1.0.12 (10.1.0.12), Dst: 10.0.2.9 
>> (10.0.2.9)
>>     Version: 4
>>     Header length: 20 bytes
>>     Differentiated Services Field: 0x00 (DSCP 0x00: Default; ECN: 
>> 0x00: Not-ECT (Not ECN-Capable Transport))
>>         0000 00.. = Differentiated Services Codepoint: Default (0x00)
>>         .... ..00 = Explicit Congestion Notification: Not-ECT (Not 
>> ECN-Capable Transport) (0x00)
>>     Total Length: 188
>>     Identification: 0xa3e0 (41952)
>>     Flags: 0x02 (Don't Fragment)
>>         0... .... = Reserved bit: Not set
>>         .1.. .... = Don't fragment: Set
>>         ..0. .... = More fragments: Not set
>>     Fragment offset: 0
>>     Time to live: 64
>>     Protocol: TCP (6)
>>     Header checksum: 0x8046 [validation disabled]
>>         [Good: False]
>>         [Bad: False]
>>     Source: 10.1.0.12 (10.1.0.12)
>>     Destination: 10.0.2.9 (10.0.2.9)
>> Transmission Control Protocol, Src Port: rndc (953), Dst Port: nfs 
>> (2049), Seq: 1, Ack: 1, Len: 148
>>     Source port: rndc (953)
>>     Destination port: nfs (2049)
>>     [Stream index: 0]
>>     Sequence number: 1    (relative sequence number)
>>     [Next sequence number: 149    (relative sequence number)]
>>     Acknowledgment number: 1    (relative ack number)
>>     Header length: 20 bytes
>>     Flags: 0x018 (PSH, ACK)
>>         000. .... .... = Reserved: Not set
>>         ...0 .... .... = Nonce: Not set
>>         .... 0... .... = Congestion Window Reduced (CWR): Not set
>>         .... .0.. .... = ECN-Echo: Not set
>>         .... ..0. .... = Urgent: Not set
>>         .... ...1 .... = Acknowledgment: Set
>>         .... .... 1... = Push: Set
>>         .... .... .0.. = Reset: Not set
>>         .... .... ..0. = Syn: Not set
>>         .... .... ...0 = Fin: Not set
>>     Window size value: 1476
>>     [Calculated window size: 1476]
>>     [Window size scaling factor: -1 (unknown)]
>>     Checksum: 0x4455 [validation disabled]
>>         [Good Checksum: False]
>>         [Bad Checksum: False]
>>     [SEQ/ACK analysis]
>>         [Bytes in flight: 148]
>> Remote Procedure Call, Type:Call XID:0xd17c6210
>>     Fragment header: Last fragment, 144 bytes
>>         1... .... .... .... .... .... .... .... = Last Fragment: Yes
>>         .000 0000 0000 0000 0000 0000 1001 0000 = Fragment Length: 144
>>     XID: 0xd17c6210 (3514589712)
>>     Message Type: Call (0)
>>     RPC Version: 2
>>     Program: NFS (100003)
>>     Program Version: 4
>>     Procedure: COMPOUND (1)
>>     Credentials
>>         Flavor: AUTH_UNIX (1)
> 
> .. and the client is using AUTH_UNIX, or sec=sys.  Seems your server 
> isn't
> picking up the change to the export for the root for some reason.
> 
> How are you modifying the export?  What does `exportfs -v` say?
> 
> Ben
