Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04DA6EC178
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2019 12:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfKALAP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Nov 2019 07:00:15 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:58257 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbfKALAP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Nov 2019 07:00:15 -0400
Received: from icode.fritz.box ([IPv6:2001:888:4:50::1007])
        by smtp-cloud9.xs4all.net with ESMTPA
        id QUf0iktAtsBskQUf0iUIxC; Fri, 01 Nov 2019 12:00:06 +0100
To:     linux-nfs@vger.kernel.org
From:   Jan-Pieter Cornet <johnpc@xs4all.net>
Openpgp: preference=signencrypt
Autocrypt: addr=johnpc@xs4all.net; prefer-encrypt=mutual; keydata=
 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 RA==
Subject: process hangs on kernel 4.19 and 5.2, not on 4.9
Message-ID: <bea770e3-0c1f-edbb-28d9-2a730f9e58fc@xs4all.net>
Date:   Fri, 1 Nov 2019 12:00:02 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="M7vl22wKZxyEx3dQALOdELvUpHymDE8Mz"
X-CMAE-Envelope: MS4wfOgviHn/BaSfd+t+/qmBALpCoRIR9jY9UDH1mUGhBmq+rtj+pnRFPKAMqnB0RisNbYC618M8N1TTI0DXvLIGnnmU5jjduVstytVoCrYpeLRLkG86wOgm
 prmwuJ4bShT6lQHh0za9VVYL3mOqCjnULRIQWgmdasQq4YKpxUTu0nvtcTtVYsrGTEl3Qia+dsX0SQ==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M7vl22wKZxyEx3dQALOdELvUpHymDE8Mz
Content-Type: multipart/mixed; boundary="icLwONGfbQ7285hWnV7ZA3nbekw3DbCOf";
 protected-headers="v1"
From: Jan-Pieter Cornet <johnpc@xs4all.net>
To: linux-nfs@vger.kernel.org
Message-ID: <bea770e3-0c1f-edbb-28d9-2a730f9e58fc@xs4all.net>
Subject: process hangs on kernel 4.19 and 5.2, not on 4.9

--icLwONGfbQ7285hWnV7ZA3nbekw3DbCOf
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

We are running dovecot, with NFS mounted mail spools. After a recent roun=
d of upgrades, we noticed that occasionally a process hangs in state "D",=
 while accessing a file over NFS. This is on the default debian buster ke=
rnel: 4.19.67-2+deb10u1. When we downgraded to the older default stretch =
kernel, 4.9.189-3+deb9u1 (without changing anything else on the system), =
the hangs do not occur. I've also reproduced the crash on the buster back=
ports kernel, 5.2.17-1~bpo10+1.

This is with dovecot 2.3.8 (latest), storing mails using mdbox. The NFS s=
erver is a Netapp running OnTap 9.6P2 clustermode.

With "hang" I mean that the process is unresponsive to anything but a kil=
l -KILL signal. strace shows nothing (and after attaching, strace itself =
cannot be killed except with a kill -KILL). The netapp shows that the cli=
ent is holding 2 files locked with an fcntl byte-range lock (preventing a=
ny other process from writing to the mailbox). There is only one process =
that gets stuck (commonly lmtp, writing to the mailbox, but I've also see=
n IMAP APPEND causing the problem on the production platform). After kill=
ing the stuck process, the mdbox index files are damaged and need rebuild=
ing using "doveadm force-resync" (but that's just because the writing pro=
cess was rudely interrupted).

/proc/$PID/stack of the hanging process contains, on the 4.19 kernel, wit=
h every crash that I've reproduced:
[<0>] nfs_iocounter_wait+0x74/0xa0 [nfs]
[<0>] do_unlk+0x8c/0xe0 [nfs]
[<0>] __x64_sys_flock+0xa4/0xf0
[<0>] do_syscall_64+0x53/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] 0xffffffffffffffff

On the 5.2 kernel, /proc/$PID/stack looks like this:
[<0>] do_unlk+0x8e/0xe0 [nfs]
[<0>] __x64_sys_flock+0xa7/0x100
[<0>] do_syscall_64+0x53/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

I can reproduce the crash on a test system, but it takes anywhere from a =
few minutes upto 30 minutes to hang. To trigger the bug, I start two "whi=
le true; do swaks -s localhost --proto LMTP ...; done" endless loops that=
 hammer a single destination mailbox with mail. Another thread goes in ev=
ery minute and deletes the mails again. Running a single "swaks" hammerin=
g loop does not trigger the hang. And as said, downgrading to 4.9 does no=
t cause a hang either (so we're currently running the production cluster =
on the older kernel).

I'd appreciate any help in getting this resolved. I can also provide a de=
tailed description of the test setup so someone can hopefully reproduce t=
his, or I can try to dig deeper (I basically saved everything readable fr=
om /proc/$PID for the reproduced crashes, don't know if anything else is =
interesting in there). I could even try to make a tcpdump of the traffic =
to the NFS server, if you think that helps, although that will likely pro=
duce a pretty massive capture file. Or I can try with other kernel versio=
ns. So far I only tried using the available (pre-packaged) debian kernels=
=2E

Thanks for any input,

--=20
Jan-Pieter Cornet <johnpc@xs4all.net>
Systeembeheer XS4ALL Internet bv
www.xs4all.nl


--icLwONGfbQ7285hWnV7ZA3nbekw3DbCOf--

--M7vl22wKZxyEx3dQALOdELvUpHymDE8Mz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAEBCgB9FiEERi08X+sQJ+Ye9TauIGpRrVHKNykFAl28EDJfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDQ2
MkQzQzVGRUIxMDI3RTYxRUY1MzZBRTIwNkE1MUFENTFDQTM3MjkACgkQIGpRrVHK
NymjIxAAwC50jSp3OwWRuHAT5MybnbTIqoSUZOfL0L3DMbNEWblWQvRfIPRr9ag2
sO8jUlgBVO/MXNzI8uhciTBWq8y8rew3wxeZvAokxn6y3NZj+CvlGPf8Yik/e/13
wEcng0E7BJmELG17KWARibZNZ1cJsm7X3qaWjb7VVCgZ88MQ9DPcrpoWuP4MCwEa
AkuJH83pUnJHayHWBW9TZbs0TprOcpOl978cx9b3Jo7ZMxSD7mJk06xrFINRERnN
p0ZG8yrGVbws525BJXUy+4BYSuIzArpqYu5APqPCYCnkZkWTM4ITreaBiAXrrmZV
X0q3igWkdmXE4n8dEDBjX7QWubdcJrQo96A38ZPkgSz4kOEMNLJl6URqk7jtnsmH
t+owgjTShFk0nz2UP/5eHIksJLXvxFaTc3nxSSU6/c0W5BiUs7At45rVokzUtHJY
F+CB3wC3c7bKBJY/ClUw+wT6KLh8oL1VbETF9JEdOgIPGJAF8yLI88FjiLJckJKJ
ihWciNBcQoUZt4Cv8rOZtapC89RuR67chPuwwvp4jAUb4r0ac8jo5gdJdGwsaK32
b/M8df9inJ1LGBU/fyau/JiZb0mRoRm+LsmCDgwzuHFKHZuUDgiUL7NeptPB0yMF
y+Y1fDXC8OLnP6ij76JfWb9uejGbrMKfNvgpWAqKni0FpRGRdKE=
=Wkoi
-----END PGP SIGNATURE-----

--M7vl22wKZxyEx3dQALOdELvUpHymDE8Mz--
