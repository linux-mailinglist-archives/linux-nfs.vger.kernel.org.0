Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3E161626C
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Nov 2022 13:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiKBMJa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Nov 2022 08:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBMJ3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Nov 2022 08:09:29 -0400
Received: from za-smtp-delivery-134.mimecast.co.za (za-smtp-delivery-134.mimecast.co.za [41.74.205.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1068922516
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 05:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uct.ac.za;
        s=mimecast20140617; t=1667390963;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2j/7s3z/s4PmQ/AJuEtKv8lChikBdRFyM2g2giuuupU=;
        b=UJsjFI8J+I8SKrSyb1kDi5EINoivUsMIkA6SENtAE7G3PUNlCJ/wB0kKn0KnFqhTB3n8Ft
        byVCTnD5th7z8q1t6YAwqGf38omJZS7lKmn9QQoarCUAJzyTDXlbUCU8FwK3lfW8MBCmpD
        cmun3Xvv0ZNS1w6hJkCu8NHlERCaL20=
Received: from srvwinexc005.wf.uct.ac.za (srvwinexc005.wf.uct.ac.za
 [137.158.154.116]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 za-mta-118-gMIEruI3OBGXuiY591TS4w-1; Wed, 02 Nov 2022 14:09:22 +0200
X-MC-Unique: gMIEruI3OBGXuiY591TS4w-1
Received: from [197.239.191.215] (197.239.191.215) by
 srvwinexc005.wf.uct.ac.za (137.158.154.100) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 2 Nov 2022 14:09:22 +0200
Message-ID: <243be6ef-e6a5-5ed8-1ffd-b8e121b4a124@uct.ac.za>
Date:   Wed, 2 Nov 2022 14:09:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Reply-To: <Andrew.Lewis@uct.ac.za>
To:     <linux-nfs@vger.kernel.org>
From:   Andrew Lewis <Andrew.Lewis@uct.ac.za>
Subject: NFS cosmetic quota exceeded bug
X-Originating-IP: [197.239.191.215]
X-ClientProxiedBy: srvwinexc005.wf.uct.ac.za (137.158.154.100) To
 srvwinexc005.wf.uct.ac.za (137.158.154.100)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: uct.ac.za
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi

Anyone else experienced this? Spent quite a bit of time googling, can=E2=80=
=99t
find a similar issue. Also unsure if this is something that also occurs
in Centos 8.

Occurs on Rocky 8.6 (kernel 4.18.0) and 9.0 (kernel 5.14.0) and
apparently Ubuntu 20-04 although another team tested this last OS for us.

Tested from a NFS4.1 mount from a Pure Storage device as well as a
NFS4.2 mount from a xfs volume running on a Rocky9 server.
The user name spaces (uids) were identical for all tests.


Summary:
NFS client continues to issue =E2=80=9CDisk quota exceeded=E2=80=9D errors =
after quota
is raised. This is only for block quotas, not inode quotas. It appears
to be related to client side attribute caching.


Description:
NFS file system mounted on host on which client is working.
Client is overquota and tries to write to a file (call this FileA.txt).
Client gets =E2=80=9CDisk quota exceeded=E2=80=9D error as expected.

Admin now increases the quota sufficiently to allow the user to continue
writing to FileA.txt. However writes to this particular file still
produce =E2=80=9CDisk quota exceeded=E2=80=9D errors, even though client su=
ccessfully
writes to the file. Writes to other files do not produce errors so long
as client did not attempt to write to them while quota was exceeded.
Writes to FileA.txt on other hosts which have the NFS file system
mounted do not throw this error, even while the error is simultaneously
presenting itself on the initial host. Copying the file to another file
name and then overwriting the original FileA.txt =E2=80=98fixes=E2=80=99 th=
e problem.

The same mounts above were also exported to a Centos7.3 server (kernel
3.10.0)and the error did not occur: raising the user quota after a file
write caused a =E2=80=9CDisk quota exceeded=E2=80=9D allows subsequent writ=
es to that
file with no further error messages.

Note 1: when the FS is mounted with the noac option this bug does not
occur. Conversely setting actimeo=3D0 does not fix the bug. The noac
option is a combination of the generic option sync, and the NFS-specific
option actimeo=3D0. Hence it appears that the issue is caused by the
default async, and setting noac forces sync and fixes the issue.

Note 2: inode quotas do not cause this issue and behave as expected.

Note 3: making use of soft vs hard quotas does not change the behaviour.
The issue occurs at the hard quota.

Note 4: looking at TCPDUMP the server is not passing error messages to
the client during this condition.


Setup:
SELinux and all firewalls disabled

exportfs -v from my xfs NFS server:
/opt/nfs
rocky8.client(sync,wdelay,hide,no_subtree_check,sec=3Dsys,rw,secure,no_root=
_squash,no_all_squash)
/opt/nfs
centos7.server(sync,wdelay,hide,no_subtree_check,sec=3Dsys,rw,secure,no_roo=
t_squash,no_all_squash)

All servers mentioned here:
cat /proc/fs/nfsd/versions
-2 +3 +4 +4.1 +4.2

For the xfs server setup:
acl client =3D 2.2.53-1.el8.1
acl server =3D  2.3.1-3.el9
libgssapi no such package in rocky
libevent client =3D 2.1.8-5.el8
libevent server =3D 2.1.12-6.el9
librpcsecgss no such package in rocky
nfs-utils client =3D 1:2.3.3-51.el8
nfs-utils server =3D1:2.5.4-10.el9
util-linux =3D 2.32.1-35.el8
util-linux =3D 2.37.4-3.el9



TCPDUMP:
We start dumping data to FileA.txt:

# cat data >> FileA.txt

16:42:39.788810 IP rocky8.client.943 > rocky9.server.nfs: Flags [.], seq
2497532:2498980, ack 4153, win 12282, options [nop,nop,TS val 2571582773
ecr 4267237588], length 1448
16:42:39.788822 IP rocky8.client.943 > rocky9.server.nfs: Flags [.], seq
2498980:2500428, ack 4153, win 12282, options [nop,nop,TS val 2571582773
ecr 4267237588], length 1448
16:42:39.788823 IP rocky9.server.nfs > rocky8.client.943: Flags [.], ack
2500428, win 24568, options [nop,nop,TS val 4267237589 ecr 2571582773],
length 0
16:42:39.788834 IP rocky8.client.943 > rocky9.server.nfs: Flags [.], seq
2500428:2501876, ack 4153, win 12282, options [nop,nop,TS val 2571582773
ecr 4267237588], length 1448

# cat data >> FileA.txt

16:42:39.788847 IP rocky8.client.943 > rocky9.server.nfs: Flags [.], seq
2501876:2503324, ack 4153, win 12282, options [nop,nop,TS val 2571582773
ecr 4267237588], length 1448
16:42:39.788849 IP rocky9.server.nfs > rocky8.client.943: Flags [.], ack
2503324, win 24568, options [nop,nop,TS val 4267237589 ecr 2571582773],
length 0
16:42:39.788856 IP rocky8.client.943 > rocky9.server.nfs: Flags [P.],
seq 2503324:2503872, ack 4153, win 12282, options [nop,nop,TS val
2571582773 ecr 4267237588], length 548

# cat data >> FileA.txt

16:42:39.788903 IP rocky9.server.nfs > rocky8.client.943: Flags [P.],
seq 4153:4253, ack 2503872, win 24568, options [nop,nop,TS val
4267237589 ecr 2571582773], length 100: NFS reply xid 4118676701 reply
ok 96 getattr ERROR: Disc quota exceeded
16:42:39.789416 IP rocky8.client.943 > rocky9.server.nfs: Flags [P.],
seq 2503872:2504072, ack 4253, win 12282, options [nop,nop,TS val
2571582775 ecr 4267237589], length 200: NFS request xid 4135453917 196
getattr fh 0,2/53
16:42:39.790175 IP rocky9.server.nfs > rocky8.client.943: Flags [P.],
seq 4253:4361, ack 2504072, win 24568, options [nop,nop,TS val
4267237590 ecr 2571582775], length 108: NFS reply xid 4135453917 reply
ok 104 getattr NON 3 ids 0/-530227613 sz 695948683
16:42:39.830384 IP rocky8.client.943 > rocky9.server.nfs: Flags [.], ack
4361, win 12282, options [nop,nop,TS val 2571582816 ecr 4267237590],
length 0



User ID      Used   Soft   Hard Warn/Grace
---------- ---------------------------------
alewis       3.9M     4M     4M  00 [------]


So now we grant the user more than enough space to continue extending
the file...

# setquota -u alewis 5M 5M 1000 1000 -a /opt/nfs
# xfs_quota -x -c 'report -h' /opt/nfs/

User quota on /opt/nfs (/dev/mapper/VGsplunk-LVsplunk)
User ID      Used   Soft   Hard Warn/Grace
---------- ---------------------------------
alewis       3.9M     5M     5M  00 [------]


But the error remains:

# cat data >> FileA.txt
cat: write error: Disk quota exceeded
<nothing in tcpdump>
alewis       4.0M     5M     5M  00 [------]

# cat data >> FileA.txt
# cat: write error: Disk quota exceeded
<nothing in tcpdump>
alewis       4.2M     5M     5M  00 [------]

# cat data >> FileA.txt
cat: write error: Disk quota exceeded
<nothing in tcpdump>
alewis       4.4M     5M     5M  00 [------]

Finally we exceed the new limit:
cat data >> FileA.txt
cat: write error: Input/output error
cat: write error: Disk quota exceeded
16:47:32.739902 IP rocky9.server.nfs > rocky8.client.943: Flags [P.],
seq 5185:5285, ack 1505904, win 24568, options [nop,nop,TS val
4267530540 ecr 2571875724], length 100: NFS reply xid 2726233309 reply
ok 96 getattr ERROR: Disc quota exceeded
________________________________
 UNIVERSITY OF CAPE TOWN

This e-mail is subject to the UCT ICT policies and e-mail disclaimer publis=
hed on our website at http://www.uct.ac.za/about/policies/emaildisclaimer/ =
or obtainable from +27 21 650 9111. This e-mail is intended only for the pe=
rson(s) to whom it is addressed. If the e-mail has reached you in error, pl=
ease notify the author. If you are not the intended recipient of the e-mail=
 you may not use, disclose, copy, redirect or print the content. If this e-=
mail is not related to the business of UCT it is sent by the sender in the =
sender's individual capacity.

