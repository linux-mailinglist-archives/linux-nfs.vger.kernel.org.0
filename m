Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE755148A3E
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2020 15:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbgAXOqL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jan 2020 09:46:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43451 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387979AbgAXOqL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jan 2020 09:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579877170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCYA4RqKXXiZ0BgSyr8Pg/He8GsP88bu6iEBffQkeJo=;
        b=UkBwcCDbwxyLX42CI22stZ1zyoQqXRzgYzW2nJfRKwPbi1mINeWn310BNjLOi6elvuuaaX
        fH9GvGkYz/W3HN4UplkTsiRNsvKnuGPfMfCX0rUTcRC5UDnSPzs9Qk0R2LxQeHNmlV48n9
        TX8Hl1cVX49fv+Tvzp+w8gxl+PrrQjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-Mj79fOKMPo6iq0dFI6ny-Q-1; Fri, 24 Jan 2020 09:46:05 -0500
X-MC-Unique: Mj79fOKMPo6iq0dFI6ny-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9ACE18A8CA7;
        Fri, 24 Jan 2020 14:45:54 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A5D560BEC;
        Fri, 24 Jan 2020 14:45:53 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Felix Rubio" <felix@kngnt.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
Date:   Fri, 24 Jan 2020 09:45:52 -0500
Message-ID: <87BD58D0-7A14-42BB-BA8F-54E6C78B2755@redhat.com>
In-Reply-To: <6d998611c9205d6a0a8bf3806c297011@kngnt.org>
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
 <724CB91C-76AC-425B-BAE3-04887ED5DE73@redhat.com>
 <6d998611c9205d6a0a8bf3806c297011@kngnt.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Felix - now see if you can turn up the nfsd debug messages on the =

server
during that mount.  It does seem odd.  Its also hard to see from your
capture what security the client is trying to use for that GETATTR.  You =

can
use `tshark -r/path/to/pcap` to get a nicer summary, then `tshark -V
-r/path/to/pcap frame.number=3D=3D<frame of interest> to get very verbose=

results..

Ben

On 23 Jan 2020, at 4:03, Felix Rubio wrote:

> Hi Ben,
>
>     Thank your for trying to help. Indeed, I can get as much =

> information as you might need (I am the administrator of those =

> machines). After enabling rpcdebug -m nfs -s mount on the client this =

> is what I get:
>
>     [  461.238568] NFS: nfs mount =

> opts=3D'hard,sec=3Dsys,vers=3D4.1,addr=3D10.0.2.9,clientaddr=3D10.1.0.1=
2'
>     [  461.243621] NFS:   parsing nfs mount option 'hard'
>     [  461.246573] NFS:   parsing nfs mount option 'sec=3Dsys'
>     [  461.249809] NFS: parsing sec=3Dsys option
>     [  461.252364] NFS:   parsing nfs mount option 'vers=3D4.1'
>     [  461.255472] NFS:   parsing nfs mount option 'addr=3D10.0.2.9'
>     [  461.258864] NFS:   parsing nfs mount option =

> 'clientaddr=3D10.1.0.12'
>     [  461.262610] NFS: MNTPATH: '/home'
>     [  461.264757] --> nfs4_try_mount()
>     [  461.273063] <-- nfs4_try_mount() =3D -1 [error]
>
> when running tcpdump on the nfs server (tcpdump -i eth0 host 10.1.0.12 =

> and port nfs -n -s 0 -vvv), and mounting on the client, this is what I =

> get:
>
>     tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture =

> size 262144 bytes
>     09:55:01.603947 IP (tos 0x0, ttl 64, id 15242, offset 0, flags =

> [DF], proto TCP (6), length 188)
>         10.1.0.12.epp > 10.0.2.9.nfs: Flags [P.], cksum 0x1fdf =

> (correct), seq 1347340908:1347341056, ack 1722815553, win 1919, length =

> 148: NFS request xid 3760933574 144 getattr fh 0,1/53
>     09:55:01.604325 IP (tos 0x0, ttl 64, id 38336, offset 0, flags =

> [DF], proto TCP (6), length 132)
>         10.0.2.9.nfs > 10.1.0.12.epp: Flags [P.], cksum 0x168c =

> (incorrect -> 0x08f4), seq 1:93, ack 148, win 1432, length 92: NFS =

> reply xid 3760933574 reply ok 88 getattr ERROR: unk 10016
>     09:55:01.604717 IP (tos 0x0, ttl 64, id 15243, offset 0, flags =

> [DF], proto TCP (6), length 40)
>         10.1.0.12.epp > 10.0.2.9.nfs: Flags [.], cksum 0xf0e6 =

> (correct), seq 148, ack 93, win 1919, length 0
>     09:55:01.612334 IP (tos 0x0, ttl 64, id 15244, offset 0, flags =

> [DF], proto TCP (6), length 252)
>         10.1.0.12.epp > 10.0.2.9.nfs: Flags [P.], cksum 0xe9ed =

> (correct), seq 148:360, ack 93, win 1919, length 212: NFS request xid =

> 3777710790 208 getattr fh 0,1/53
>     09:55:01.612495 IP (tos 0x0, ttl 64, id 38337, offset 0, flags =

> [DF], proto TCP (6), length 240)
>         10.0.2.9.nfs > 10.1.0.12.epp: Flags [P.], cksum 0x16f8 =

> (incorrect -> 0x417f), seq 93:293, ack 360, win 1432, length 200: NFS =

> reply xid 3777710790 reply ok 196 getattr NON 4 ids 0/47982174 sz =

> -1769090185
>     09:55:01.652270 IP (tos 0x0, ttl 64, id 15245, offset 0, flags =

> [DF], proto TCP (6), length 40)
>         10.1.0.12.epp > 10.0.2.9.nfs: Flags [.], cksum 0xef34 =

> (correct), seq 360, ack 293, win 1941, length 0
>
> I have noticed there is this error 10016, that in nfs4.h translates to =

> NFS4ERR_WRONGSEC, suggesting that the server does not allow 'sys', but =

> I have checked again my /etc/exports file and contains
>
>     /home 10.0.0.0/8(rw,no_subtree_check,sec=3Dsys:krb5:krb5i:krb5p)
>
> and also is reported by the operating system:
>
>     # cat /proc/fs/nfsd/exports
>     /export/home    =

> 10.0.0.0/8(rw,root_squash,sync,wdelay,no_subtree_check,uuid=3D0743ce63:=
00c1185a:00000000:00000000,sec=3D1:390003:390004:390005)
>
> Any ideas?
>
> Thank you!
> Felix
>
>
> ---
> Felix Rubio
> "Don't believe what you're told. Double check."
>
> On 2020-01-22 19:30, Benjamin Coddington wrote:
>> On 22 Jan 2020, at 4:22, Felix Rubio wrote:
>>
>>> Hi everybody,
>>>
>>> I have a kerberized NFSv4 server that is exporting a mountpoint:
>>>
>>>     /home 10.0.0.0/8(rw,no_subtree_check,sec=3Dkrb5:krb5i:krb5p)
>>>
>>> if I mount that export with this command on the client, it works as =

>>> expected:
>>>
>>>     /sbin/mount.nfs4 NFS.domain:/home /network/home -o =

>>> _netdev,noatime,hard,sec=3Dkrb5
>>>
>>> However, if I modify the export to be
>>>
>>>     /home 10.0.0.0/8(rw,no_subtree_check,sec=3Dsys:krb5:krb5i:krb5p)
>>>
>>> and I mount that export with sec=3Dsys, as
>>>
>>>     /sbin/mount.nfs4 NFS.domain:/home /network/home -o =

>>> _netdev,noatime,hard,sec=3Dsys
>>>
>>> I get the following error:
>>>
>>>     mount.nfs4: timeout set for Fri Jan 17 14:11:32 2020
>>>     mount.nfs4: trying text-based options =

>>> 'hard,sec=3Dsys,vers=3D4.1,addr=3D10.2.2.9,clientaddr=3D10.2.0.12'
>>>     mount.nfs4: mount(2): Operation not permitted
>>>     mount.nfs4: Operation not permitted
>>>
>>> What might be the reason for this behavior?
>>
>> Hi Felix,
>>
>> I don't know.  Can you get more information?  Try again after =

>> `rpcdebug -m
>> nfs -s mount`.  That will turn up debugging for messages labeled for =

>> mount,
>> and the output will be in the kernel log.  There are other facilities =

>> there,
>> see rpcdebug(8).
>>
>> Another good option is getting a network capture of the mount attempt =

>> and
>> trying to figure out if the server is returning an error, or the =

>> client is
>> generating the error.
>>
>> There are also a lot of "nfs", "nfs4", and "rpc" tracepoints you can =

>> enable
>> to get more information.
>>
>> Ben

