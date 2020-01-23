Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14FBF14641E
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2020 10:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgAWJDl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jan 2020 04:03:41 -0500
Received: from smtpq3.tb.mail.iss.as9143.net ([212.54.42.166]:55618 "EHLO
        smtpq3.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726194AbgAWJDl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jan 2020 04:03:41 -0500
Received: from [212.54.42.110] (helo=smtp7.tb.mail.iss.as9143.net)
        by smtpq3.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <felix@kngnt.org>)
        id 1iuYOo-0008Ec-5u; Thu, 23 Jan 2020 10:03:38 +0100
Received: from 94-209-183-118.cable.dynamic.v4.ziggo.nl ([94.209.183.118] helo=mail.kngnt.org)
        by smtp7.tb.mail.iss.as9143.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <felix@kngnt.org>)
        id 1iuYOo-00049b-2o; Thu, 23 Jan 2020 10:03:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kngnt.org; s=mail;
        t=1579770217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzlcgij6vwtpgnOxRq3W2xylFCBZww+nqoRcEm8Rw7U=;
        b=CpLJvpfi1ZgbMcCS/56wGURF137gq6FfEPAu8Kkv32iYJok2lpiNBeKVCkrwWYnpiE3iUx
        ut/lm34iaOV2C1HHiqF9PyKEdz6BHXIbk0ZXevJKWaYm9RnViE3sUrubagWUvJLLBxLQJa
        g28aVp1fz/8xYyLwEoKkDKrZIfsa/bA/+6QIZo1xkm1Fmj87IZP5vz8iFtwJ94uCkWXM0J
        YP37tF9KKVR+KTS/ZJiQbBNgOdROMM+waH/nB0Wu19TxIITOYbr9wzuZWjdEYIXKpUNJ58
        0I66COaU5kAIhwMzPWMuEVga9YtJflZEqs0A7vTUEnShBkYwAInVFaQhQe9YMQ==
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 23 Jan 2020 10:03:36 +0100
From:   Felix Rubio <felix@kngnt.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
In-Reply-To: <724CB91C-76AC-425B-BAE3-04887ED5DE73@redhat.com>
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
 <724CB91C-76AC-425B-BAE3-04887ED5DE73@redhat.com>
Message-ID: <6d998611c9205d6a0a8bf3806c297011@kngnt.org>
X-Sender: felix@kngnt.org
X-SourceIP: 94.209.183.118
X-Authenticated-Sender: f.rubiodalmau@ziggo.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=Aa/P4EfG c=1 sm=1 tr=0 a=KDOoBKh8T/kja8HrlTi2+A==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=Jdjhy38mL1oA:10 a=TjzCTycqxPel2pYwfCcA:9 a=KysyrU1RCDK6y3Z1:21 a=9Wtg93LIApSNP26M:21 a=QEXdDO2ut3YA:10
X-Ziggo-Spam-Status: No
X-Spam-Status: No
X-Spam-Flag: No
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ben,

     Thank your for trying to help. Indeed, I can get as much information 
as you might need (I am the administrator of those machines). After 
enabling rpcdebug -m nfs -s mount on the client this is what I get:

     [  461.238568] NFS: nfs mount 
opts='hard,sec=sys,vers=4.1,addr=10.0.2.9,clientaddr=10.1.0.12'
     [  461.243621] NFS:   parsing nfs mount option 'hard'
     [  461.246573] NFS:   parsing nfs mount option 'sec=sys'
     [  461.249809] NFS: parsing sec=sys option
     [  461.252364] NFS:   parsing nfs mount option 'vers=4.1'
     [  461.255472] NFS:   parsing nfs mount option 'addr=10.0.2.9'
     [  461.258864] NFS:   parsing nfs mount option 
'clientaddr=10.1.0.12'
     [  461.262610] NFS: MNTPATH: '/home'
     [  461.264757] --> nfs4_try_mount()
     [  461.273063] <-- nfs4_try_mount() = -1 [error]

when running tcpdump on the nfs server (tcpdump -i eth0 host 10.1.0.12 
and port nfs -n -s 0 -vvv), and mounting on the client, this is what I 
get:

     tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture 
size 262144 bytes
     09:55:01.603947 IP (tos 0x0, ttl 64, id 15242, offset 0, flags [DF], 
proto TCP (6), length 188)
         10.1.0.12.epp > 10.0.2.9.nfs: Flags [P.], cksum 0x1fdf 
(correct), seq 1347340908:1347341056, ack 1722815553, win 1919, length 
148: NFS request xid 3760933574 144 getattr fh 0,1/53
     09:55:01.604325 IP (tos 0x0, ttl 64, id 38336, offset 0, flags [DF], 
proto TCP (6), length 132)
         10.0.2.9.nfs > 10.1.0.12.epp: Flags [P.], cksum 0x168c 
(incorrect -> 0x08f4), seq 1:93, ack 148, win 1432, length 92: NFS reply 
xid 3760933574 reply ok 88 getattr ERROR: unk 10016
     09:55:01.604717 IP (tos 0x0, ttl 64, id 15243, offset 0, flags [DF], 
proto TCP (6), length 40)
         10.1.0.12.epp > 10.0.2.9.nfs: Flags [.], cksum 0xf0e6 (correct), 
seq 148, ack 93, win 1919, length 0
     09:55:01.612334 IP (tos 0x0, ttl 64, id 15244, offset 0, flags [DF], 
proto TCP (6), length 252)
         10.1.0.12.epp > 10.0.2.9.nfs: Flags [P.], cksum 0xe9ed 
(correct), seq 148:360, ack 93, win 1919, length 212: NFS request xid 
3777710790 208 getattr fh 0,1/53
     09:55:01.612495 IP (tos 0x0, ttl 64, id 38337, offset 0, flags [DF], 
proto TCP (6), length 240)
         10.0.2.9.nfs > 10.1.0.12.epp: Flags [P.], cksum 0x16f8 
(incorrect -> 0x417f), seq 93:293, ack 360, win 1432, length 200: NFS 
reply xid 3777710790 reply ok 196 getattr NON 4 ids 0/47982174 sz 
-1769090185
     09:55:01.652270 IP (tos 0x0, ttl 64, id 15245, offset 0, flags [DF], 
proto TCP (6), length 40)
         10.1.0.12.epp > 10.0.2.9.nfs: Flags [.], cksum 0xef34 (correct), 
seq 360, ack 293, win 1941, length 0

I have noticed there is this error 10016, that in nfs4.h translates to 
NFS4ERR_WRONGSEC, suggesting that the server does not allow 'sys', but I 
have checked again my /etc/exports file and contains

     /home 10.0.0.0/8(rw,no_subtree_check,sec=sys:krb5:krb5i:krb5p)

and also is reported by the operating system:

     # cat /proc/fs/nfsd/exports
     /export/home    
10.0.0.0/8(rw,root_squash,sync,wdelay,no_subtree_check,uuid=0743ce63:00c1185a:00000000:00000000,sec=1:390003:390004:390005)

Any ideas?

Thank you!
Felix


---
Felix Rubio
"Don't believe what you're told. Double check."

On 2020-01-22 19:30, Benjamin Coddington wrote:
> On 22 Jan 2020, at 4:22, Felix Rubio wrote:
> 
>> Hi everybody,
>> 
>> I have a kerberized NFSv4 server that is exporting a mountpoint:
>> 
>>     /home 10.0.0.0/8(rw,no_subtree_check,sec=krb5:krb5i:krb5p)
>> 
>> if I mount that export with this command on the client, it works as 
>> expected:
>> 
>>     /sbin/mount.nfs4 NFS.domain:/home /network/home -o 
>> _netdev,noatime,hard,sec=krb5
>> 
>> However, if I modify the export to be
>> 
>>     /home 10.0.0.0/8(rw,no_subtree_check,sec=sys:krb5:krb5i:krb5p)
>> 
>> and I mount that export with sec=sys, as
>> 
>>     /sbin/mount.nfs4 NFS.domain:/home /network/home -o 
>> _netdev,noatime,hard,sec=sys
>> 
>> I get the following error:
>> 
>>     mount.nfs4: timeout set for Fri Jan 17 14:11:32 2020
>>     mount.nfs4: trying text-based options 
>> 'hard,sec=sys,vers=4.1,addr=10.2.2.9,clientaddr=10.2.0.12'
>>     mount.nfs4: mount(2): Operation not permitted
>>     mount.nfs4: Operation not permitted
>> 
>> What might be the reason for this behavior?
> 
> Hi Felix,
> 
> I don't know.  Can you get more information?  Try again after `rpcdebug 
> -m
> nfs -s mount`.  That will turn up debugging for messages labeled for 
> mount,
> and the output will be in the kernel log.  There are other facilities 
> there,
> see rpcdebug(8).
> 
> Another good option is getting a network capture of the mount attempt 
> and
> trying to figure out if the server is returning an error, or the client 
> is
> generating the error.
> 
> There are also a lot of "nfs", "nfs4", and "rpc" tracepoints you can 
> enable
> to get more information.
> 
> Ben
