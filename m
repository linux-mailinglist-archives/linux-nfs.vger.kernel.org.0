Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E74B6FB9
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 01:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfIRXgZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Sep 2019 19:36:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44915 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfIRXgZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Sep 2019 19:36:25 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so3235238iog.11
        for <linux-nfs@vger.kernel.org>; Wed, 18 Sep 2019 16:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=azyNHXKjPFa9sGFDHJONWhjbTGZvYHZOCQbX2wxTayc=;
        b=PuV2vg0VX4XmCG2DhFtocZzaorVlXWp1hlyWFRS3JzsHOLsMX71VPdahTZLqjI+HZ2
         7G+SYJPDkgFivD1+MxcQoJTIcK3eCOqE10njwz23bDcFFQE0LyvdKaQAgKj29raEz6bT
         LfWKj2lDtZkPeVGL/ZMJwZsFPaXflk+uAOqQ0wTOg7OpQO7+uO6nsowrgDtjsRiL0lTT
         7DguiWrwbtPUXyzE61qlsPsXJoVlRFlqPdFG0iTMOnPrbxuxXlNTAp4oeaIFu9osirRz
         FcnyblPe6v2nfvgGOAKoqAxk6b2LWfXgg2nnJ40KgF0krL2siZowC7WdHFAbDUADscC/
         9Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=azyNHXKjPFa9sGFDHJONWhjbTGZvYHZOCQbX2wxTayc=;
        b=YnE2BqVvw4/lJohD0OkrDM7+vhpdaEjQqdmqSQHWeVHyNpRvoUdCKPflDEr7LwftKj
         EHmCnsybmOUSW58TLZF3cv30qpHGe9A6iKbEfFNOJLl9dCexWZEIy27soouWV9Twpvzt
         sWhkZUS37luYNjItb4D4noDvHy7fglzQEu2p7nQDWeU3mFrb/EGrtmMGk7dMkUVDYGOs
         zoFaKs8hvnUwgUzOUDBcReZrVrwmBPLlc8qYfPTe89bCcLn1IJAAMYFz1+rLEqEtrj2G
         z1xL7jLWBC60G+YVkUrURjHS0uIRD8GYl+H7EahqnrhKMtJgKguDrOS5OxBBGDH5duBZ
         hssg==
X-Gm-Message-State: APjAAAWqoAMMiYbNdx9xVPByX4y9Lft1OTzIKzU6zb5xpsPR21r+kSIY
        o5beCUbXsaFXC9cVXQVFHVRKl1VhVChVLPU54fMp6a1p
X-Google-Smtp-Source: APXvYqwrjNnIqbSgRLWOouDKcj3ryMpDH2NeeiploP4GCnJ88nEJHnRm/1W+M51U39PLq5zvouFXy35AOUhNJoUIG00=
X-Received: by 2002:a6b:b593:: with SMTP id e141mr8653304iof.233.1568849783951;
 Wed, 18 Sep 2019 16:36:23 -0700 (PDT)
MIME-Version: 1.0
From:   Kevin Vasko <kvasko@gmail.com>
Date:   Wed, 18 Sep 2019 18:36:13 -0500
Message-ID: <CAMd28E-pJp4=kvp62FJqGLZo-jGA2rH2OT6-hK_N=TvMiJuT2A@mail.gmail.com>
Subject: NFSv4 client locks up on larger writes with Kerberos enabled
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,


We have a new Dell EMC Unity 300 acting as NAS Server that is
presenting a NFSv4 NFS Share. Our clients are mostly Ubuntu 18.04.3
but issue is also present on CentOS 7.6 systems. We have been
struggling with this issue for over a week now and not sure how to
resolve it.



We are having trouble with NFS Clients completing their writes to the
Dell EMC Unity 300 NFS Server when Kerberos is enabled on the NFS
Share. I created the NFS Share on the U300, associated it with our
FreeIPA (Kerberos/LDAP server) and everything shows successful.



I can mount the share without a problem on multiple Ubuntu/CentOS
machines without issues. I can ls around and move around on the share
without issue (seemingly). I can copy files as well and that seem to
work (haven=E2=80=99t tested it extensively as I have been heavily focused =
on
this issue). However, clients won't complete their writes to the NFS
share randomly once the file gets to > 2GB or so in file size.
_sometimes_ they do, but I would say anything > 3GB, the client locks
up and won=E2=80=99t ever return 80% of the time I try it.



For example, I can run dd and write ten 1MB files to the NFS share no
issues, all back to back to back. However, when I try to do a single
3GB file, it _might_ or might not finish. If it doesn=E2=80=99t finish it j=
ust
locks up the client. Sometimes it will finish though so its random.
However, I would say 70-80% of the time it is reproducible with files
> 3GB or so.



Here is some information on the client and what I=E2=80=99m doing to reprod=
uce
the issue. I have tried krb5, and krb5p with the same results.
Removing the requirement for krb5 in the NFS server and mounting with
sec=3Dnone, I don=E2=80=99t seem to hit the issue.



$uname -a

5.0.0-27-generic #28~18.04.1-Ubuntu SMP Thu Aug 22 03:00:32 UTC 2019
x86_64 x86_64 x86_64 GNU/Linux



$mount

nfs-server.example.com:/ds1 on /data type nfs4
(rw,relatime,vers=3D4.1,rsize=3D65536,wsize=3D65536,namlen=3D255,hard,proto=
=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dkrb5p,clientaddr=3D10.75.40.254,local_=
lock=3Dnone,addr=3D10.75.37.2)



$ dd if=3D/dev/zero of=3D/data/test.img count=3D1000 bs=3D1000

1000+0 records in

1000+0 records out

1000000 bytes (1.0 MB, 977 KiB) copied, 0.00613671 s, 163 MB/s

$ dd if=3D/dev/zero of=3D/data/test.img bs=3D1000M count=3D6

---- HUNG ----



After it hangs it will NEVER return. The only way I've been able to
get the client to return is to go into the U300 Control panel and
change the "SP Owner:" from SPA to SPB (effectively restarting the NFS
server). Once that happens the client returns.



If I disable Kerberos on the NFS Share I have no problems writing
larger files it seems.



I did some straces of the dd and this is what I saw.



This was a successful write=E2=80=A6.



$ strace dd if=3D/dev/zero of=3D/data/test3.img bs=3D100M count=3D1

execve("/bin/dd", ["dd", "if=3D/dev/zero", "of=3D/data/test3.img",
"bs=3D100M", "count=3D1"], 0x7fff8c03c7f0 /* 21 vars */) =3D 0

brk(NULL)                               =3D 0x559b8b39a000

access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)

access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or dire=
ctory)

openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3

fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D93482, ...}) =3D 0

mmap(NULL, 93482, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f62b6180000

close(3)                                =3D 0

access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)

openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) =3D=
 3

read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\34\2\0\0\0\0\0"=
...,
832) =3D 832

fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D2030544, ...}) =3D 0

mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x7f62b617e000

mmap(NULL, 4131552, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) =3D 0x7f62b5b7f000

mprotect(0x7f62b5d66000, 2097152, PROT_NONE) =3D 0

mmap(0x7f62b5f66000, 24576, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e7000) =3D 0x7f62b5f66000

mmap(0x7f62b5f6c000, 15072, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7f62b5f6c000

close(3)                                =3D 0

arch_prctl(ARCH_SET_FS, 0x7f62b617f540) =3D 0

mprotect(0x7f62b5f66000, 16384, PROT_READ) =3D 0

mprotect(0x559b8978b000, 4096, PROT_READ) =3D 0

mprotect(0x7f62b6197000, 4096, PROT_READ) =3D 0

munmap(0x7f62b6180000, 93482)           =3D 0

rt_sigaction(SIGINT, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_flags=3D=
0}, 8) =3D 0

rt_sigaction(SIGUSR1, {sa_handler=3D0x559b8957e0e0, sa_mask=3D[INT USR1],
sa_flags=3DSA_RESTORER, sa_restorer=3D0x7f62b5bbdf20}, NULL, 8) =3D 0

rt_sigaction(SIGINT, {sa_handler=3D0x559b8957e0d0, sa_mask=3D[INT USR1],
sa_flags=3DSA_RESTORER|SA_NODEFER|SA_RESETHAND,
sa_restorer=3D0x7f62b5bbdf20}, NULL, 8) =3D 0

brk(NULL)                               =3D 0x559b8b39a000

brk(0x559b8b3bb000)                     =3D 0x559b8b3bb000

openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) =3D =
3

fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D4326016, ...}) =3D 0

mmap(NULL, 4326016, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f62b575e000

close(3)                                =3D 0

openat(AT_FDCWD, "/dev/zero", O_RDONLY) =3D 3

dup2(3, 0)                              =3D 0

close(3)                                =3D 0

lseek(0, 0, SEEK_CUR)                   =3D 0

openat(AT_FDCWD, "/data/test3.img", O_WRONLY|O_CREAT|O_TRUNC, 0666) =3D 3

dup2(3, 1)                              =3D 1

close(3)                                =3D 0

mmap(NULL, 104869888, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) =3D 0x7f62af35b000

read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0".=
..,
104857600) =3D 104857600

write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"=
...,
104857600) =3D 104857600

close(0)                                =3D 0

close(1)                                =3D 0

openat(AT_FDCWD, "/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) =3D =
0

fstat(0, {st_mode=3DS_IFREG|0644, st_size=3D2995, ...}) =3D 0

read(0, "# Locale name alias data base.\n#"..., 4096) =3D 2995

read(0, "", 4096)                       =3D 0

close(0)                                =3D 0

openat(AT_FDCWD,
"/usr/share/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
-1 ENOENT (No such file or directory)

openat(AT_FDCWD,
"/usr/share/locale/en_US.utf8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
-1 ENOENT (No such file or directory)

openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/coreutils.mo",
O_RDONLY) =3D -1 ENOENT (No such file or directory)

openat(AT_FDCWD,
"/usr/share/locale/en.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D -1
ENOENT (No such file or directory)

openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/coreutils.mo",
O_RDONLY) =3D -1 ENOENT (No such file or directory)

openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/coreutils.mo",
O_RDONLY) =3D -1 ENOENT (No such file or directory)

openat(AT_FDCWD,
"/usr/share/locale-langpack/en_US.UTF-8/LC_MESSAGES/coreutils.mo",
O_RDONLY) =3D -1 ENOENT (No such file or directory)

openat(AT_FDCWD,
"/usr/share/locale-langpack/en_US.utf8/LC_MESSAGES/coreutils.mo",
O_RDONLY) =3D -1 ENOENT (No such file or directory)

openat(AT_FDCWD,
"/usr/share/locale-langpack/en_US/LC_MESSAGES/coreutils.mo", O_RDONLY)
=3D -1 ENOENT (No such file or directory)

openat(AT_FDCWD,
"/usr/share/locale-langpack/en.UTF-8/LC_MESSAGES/coreutils.mo",
O_RDONLY) =3D -1 ENOENT (No such file or directory)

openat(AT_FDCWD,
"/usr/share/locale-langpack/en.utf8/LC_MESSAGES/coreutils.mo",
O_RDONLY) =3D -1 ENOENT (No such file or directory)

openat(AT_FDCWD,
"/usr/share/locale-langpack/en/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
0

fstat(0, {st_mode=3DS_IFREG|0644, st_size=3D578, ...}) =3D 0

mmap(NULL, 578, PROT_READ, MAP_PRIVATE, 0, 0) =3D 0x7f62b6196000

close(0)                                =3D 0

write(2, "1+0 records in\n1+0 records out\n", 311+0 records in

1+0 records out

) =3D 31

write(2, "104857600 bytes (105 MB, 100 MiB"..., 61104857600 bytes (105
MB, 100 MiB) copied, 1.01552 s, 103 MB/s) =3D 61

write(2, "\n", 1

)                       =3D 1

close(2)                                =3D 0

exit_group(0)                           =3D ?

+++ exited with 0 +++



This one was unsuccessful write and hung until I restarted the NFS server.



strace -f dd if=3D/dev/zero of=3D/data/test.img bs=3D1000M count=3D6

execve("/bin/dd", ["dd", "if=3D/dev/zero", "of=3D/data/test.img",
"bs=3D1000M", "count=3D6"], 0x7ffc8ee7e8b8 /* 30 vars */) =3D 0

brk(NULL)                               =3D 0x5648bd26a000

access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)

access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or dire=
ctory)

openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3

fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D125550, ...}) =3D 0

mmap(NULL, 125550, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f4f8dda1000

close(3)                                =3D 0

access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)

openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) =3D=
 3

read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\34\2\0\0\0\0\0"=
...,
832) =3D 832

fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D2030544, ...}) =3D 0

mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x7f4f8dd9f000

mmap(NULL, 4131552, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) =3D 0x7f4f8d7a8000

mprotect(0x7f4f8d98f000, 2097152, PROT_NONE) =3D 0

mmap(0x7f4f8db8f000, 24576, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e7000) =3D 0x7f4f8db8f000

mmap(0x7f4f8db95000, 15072, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7f4f8db95000

close(3)                                =3D 0

arch_prctl(ARCH_SET_FS, 0x7f4f8dda0540) =3D 0

mprotect(0x7f4f8db8f000, 16384, PROT_READ) =3D 0

mprotect(0x5648bb739000, 4096, PROT_READ) =3D 0

mprotect(0x7f4f8ddc0000, 4096, PROT_READ) =3D 0

munmap(0x7f4f8dda1000, 125550)          =3D 0

rt_sigaction(SIGINT, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_flags=3D=
0}, 8) =3D 0

rt_sigaction(SIGUSR1, {sa_handler=3D0x5648bb52c0e0, sa_mask=3D[INT USR1],
sa_flags=3DSA_RESTORER, sa_restorer=3D0x7f4f8d7e6f20}, NULL, 8) =3D 0

rt_sigaction(SIGINT, {sa_handler=3D0x5648bb52c0d0, sa_mask=3D[INT USR1],
sa_flags=3DSA_RESTORER|SA_NODEFER|SA_RESETHAND,
sa_restorer=3D0x7f4f8d7e6f20}, NULL, 8) =3D 0

brk(NULL)                               =3D 0x5648bd26a000

brk(0x5648bd28b000)                     =3D 0x5648bd28b000

openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) =3D =
3

fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D11603728, ...}) =3D 0

mmap(NULL, 11603728, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f4f8cc97000

close(3)                                =3D 0

openat(AT_FDCWD, "/dev/zero", O_RDONLY) =3D 3

dup2(3, 0)                              =3D 0

close(3)                                =3D 0

lseek(0, 0, SEEK_CUR)                   =3D 0

openat(AT_FDCWD, "/data/test.img", O_WRONLY|O_CREAT|O_TRUNC, 0666) =3D 3

dup2(3, 1)                              =3D 1

close(3)                                =3D 0

mmap(NULL, 1048588288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f4f4e494000

read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0".=
..,
1048576000) =3D 1048576000

write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"=
...,
1048576000) =3D 1048576000

read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0".=
..,
1048576000) =3D 1048576000

write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"=
...,
1048576000) =3D 1048576000

read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0".=
..,
1048576000) =3D 1048576000

write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"=
...,
1048576000) =3D 1048576000

read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0".=
..,
1048576000) =3D 1048576000

write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"=
...,
1048576000) =3D 1048576000

read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0".=
..,
1048576000) =3D 1048576000

write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"=
...,
1048576000) =3D 1048576000

read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0".=
..,
1048576000) =3D 1048576000

write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"=
...,
1048576000) =3D 1048576000

close(0)                                =3D 0

close(1







I did some packet tracing and on the smaller writes, I would see a
bunch of writes and replies to those writes, the client would COMMIT
and then NFS server would reply with an ack COMMIT, client would then
issue a CLOSE, and server would respond with a CLOSE. However, on
larger writes where it would hang it would do=E2=80=A6client would do a bun=
ch
of writes packets, NFS server would respond to the write packets,
client would issue a COMMIT command, server would respond with a
COMMIT, and then nothing else would happen. No CLOSE would seemingly
be sent from the client, so I don=E2=80=99t know if the client was waiting =
on
the server to send back some type of message saying that the system
could issue a CLOSE or the client was never sending a CLOSE.



Once it is in the locked state, if I restart the NFS server as I
mentioned above the close(1=E2=80=A6will continue and finish the write and
exit normally.



I did a kernel Stack Traceback on the NFS client (the light weight
version of just printing out /proc/*/wchan) while the dd command was
stuck in the =E2=80=9Cclose(1=E2=80=9D and the process for the dd command j=
ust says.



Process /proc/32161/wchan

ep_poll



I also enabled the NFS debugging and while its stuck it just keep
repeating the bottom section.



Sep 19 06:25:19 examplehost kernel: [772614.270750] NFS:       commit
(0:52/9439 4096@4609744896) OK

Sep 19 06:25:19 examplehost kernel: [772614.270751] NFS:       commit
(0:52/9439 4096@4609748992) OK

Sep 19 06:25:19 examplehost kernel: [772614.270754] NFS:       commit
(0:52/9439 4096@4609753088) OK

Sep 19 06:25:19 examplehost kernel: [772614.270757] NFS:       commit
(0:52/9439 4096@4609757184) OK

Sep 19 06:25:19 examplehost kernel: [772614.270759] NFS:       commit
(0:52/9439 4096@4609761280) OK

Sep 19 06:25:19 examplehost kernel: [772614.270761] NFS:       commit
(0:52/9439 4096@4609765376) OK

Sep 19 06:25:19 examplehost kernel: [772614.270763] NFS:       commit
(0:52/9439 4096@4609769472) OK

Sep 19 06:25:19 examplehost kernel: [772614.270767] NFS:       commit
(0:52/9439 4096@4609773568) OK

Sep 19 06:25:19 examplehost kernel: [772614.270769] NFS:       commit
(0:52/9439 4096@4609777664) OK

Sep 19 06:25:19 examplehost kernel: [772614.270772] NFS:       commit
(0:52/9439 4096@4609781760) OK

Sep 19 06:25:19 examplehost kernel: [772614.270773] NFS:       commit
(0:52/9439 4096@4609785856) OK

Sep 19 06:25:19 examplehost kernel: [772614.270775] NFS:       commit
(0:52/9439 4096@4609789952) OK

Sep 19 06:25:19 examplehost kernel: [772614.270777] NFS:       commit
(0:52/9439 4096@4609794048) OK

Sep 19 06:25:19 examplehost kernel: [772614.270781] NFS:       commit
(0:52/9439 4096@4609798144) OK

Sep 19 06:25:31 examplehost kernel: [772626.175927] <--
nfs41_proc_async_sequence status=3D0

Sep 19 06:25:31 examplehost kernel: [772626.176018] encode_sequence:
sessionid=3D61:1568410703:305419896:61 seqid=3D2907 slotid=3D0 max_slotid=
=3D35
cache_this=3D0

Sep 19 06:25:31 examplehost kernel: [772626.176572]
nfs41_sequence_process: Error 0 free the slot

Sep 19 06:25:31 examplehost kernel: [772626.176576]
nfs41_sequence_call_done rpc_cred 000000004b01718a

Sep 19 06:25:31 examplehost kernel: [772626.176577] <-- nfs41_sequence_call=
_done

Sep 19 06:25:43 examplehost kernel: [772638.207976] <--
nfs41_proc_async_sequence status=3D0

Sep 19 06:25:43 examplehost kernel: [772638.208074] encode_sequence:
sessionid=3D61:1568410703:305419896:61 seqid=3D2908 slotid=3D0 max_slotid=
=3D35
cache_this=3D0

Sep 19 06:25:43 examplehost kernel: [772638.208642]
nfs41_sequence_process: Error 0 free the slot

Sep 19 06:25:43 examplehost kernel: [772638.208646]
nfs41_sequence_call_done rpc_cred 000000004b01718a

Sep 19 06:25:43 examplehost kernel: [772638.208648] <-- nfs41_sequence_call=
_done

Sep 19 06:25:55 examplehost kernel: [772650.240046] <--
nfs41_proc_async_sequence status=3D0

Sep 19 06:25:55 examplehost kernel: [772650.240129] encode_sequence:
sessionid=3D61:1568410703:305419896:61 seqid=3D2909 slotid=3D0 max_slotid=
=3D35
cache_this=3D0

Sep 19 06:25:55 examplehost kernel: [772650.240904]
nfs41_sequence_process: Error 0 free the slot

Sep 19 06:25:55 examplehost kernel: [772650.240908]
nfs41_sequence_call_done rpc_cred 000000004b01718a

Sep 19 06:25:55 examplehost kernel: [772650.240909] <-- nfs41_sequence_call=
_done





On a small file that actually completes it looks like this=E2=80=A6



Sep 19 06:13:29 examplehost kernel: [771904.532059] NFS:       commit
(0:52/9439 4096@7409315840) OK

Sep 19 06:13:29 examplehost kernel: [771904.532061] NFS:       commit
(0:52/9439 4096@7409319936) OK

Sep 19 06:13:29 examplehost kernel: [771904.532064] NFS:       commit
(0:52/9439 4096@7409324032) OK

Sep 19 06:13:29 examplehost kernel: [771904.532066] NFS:       commit
(0:52/9439 4096@7409328128) OK

Sep 19 06:13:29 examplehost kernel: [771904.532069] NFS:       commit
(0:52/9439 4096@7409332224) OK

Sep 19 06:13:29 examplehost kernel: [771904.532071] NFS:       commit
(0:52/9439 4096@7409336320) OK

Sep 19 06:13:29 examplehost kernel: [771904.532073] NFS:       commit
(0:52/9439 4096@7409340416) OK

Sep 19 06:13:29 examplehost kernel: [771904.532076] NFS:       commit
(0:52/9439 4096@7409344512) OK

Sep 19 06:13:29 examplehost kernel: [771904.532078] NFS:       commit
(0:52/9439 4096@7409348608) OK

Sep 19 06:13:29 examplehost kernel: [771904.532081] NFS:       commit
(0:52/9439 4096@7409352704) OK

Sep 19 06:13:29 examplehost kernel: [771904.532083] NFS:       commit
(0:52/9439 4096@7409356800) OK

Sep 19 06:13:29 examplehost kernel: [771904.532086] NFS:       commit
(0:52/9439 4096@7409360896) OK

Sep 19 06:13:29 examplehost kernel: [771904.532088] NFS:       commit
(0:52/9439 4096@7409364992) OK

Sep 19 06:13:29 examplehost kernel: [771904.532090] NFS:       commit
(0:52/9439 4096@7409369088) OK

Sep 19 06:13:29 examplehost kernel: [771904.532093] NFS:       commit
(0:52/9439 4096@7409373184) OK

Sep 19 06:13:29 examplehost kernel: [771904.532171] NFS: release(/test.img)

Sep 19 06:13:29 examplehost kernel: [771904.532193] nfs4_close_prepare: beg=
in!

Sep 19 06:13:29 examplehost kernel: [771904.532197] nfs4_close_prepare: don=
e!

Sep 19 06:13:29 examplehost kernel: [771904.532235] encode_sequence:
sessionid=3D61:1568410703:305419896:61 seqid=3D6 slotid=3D0 max_slotid=3D0
cache_this=3D1

Sep 19 06:13:29 examplehost kernel: [771904.532525] nfs4_close_done: begin!

Sep 19 06:13:29 examplehost kernel: [771904.532528]
nfs41_sequence_process: Error 0 free the slot

Sep 19 06:13:29 examplehost kernel: [771904.532531] nfs4_close_done:
done, ret =3D 0!

Sep 19 06:13:29 examplehost kernel: [771904.532555] NFS:
dentry_delete(/test.img, 48084c)

Sep 19 06:13:41 examplehost kernel: [771916.540491] <--
nfs41_proc_async_sequence status=3D0

Sep 19 06:13:41 examplehost kernel: [771916.540586] encode_sequence:
sessionid=3D61:1568410703:305419896:61 seqid=3D7 slotid=3D0 max_slotid=3D0
cache_this=3D0

Sep 19 06:13:41 examplehost kernel: [771916.541182]
nfs41_sequence_process: Error 0 free the slot

Sep 19 06:13:41 examplehost kernel: [771916.541186]
nfs41_sequence_call_done rpc_cred 000000004b01718a

Sep 19 06:13:41 examplehost kernel: [771916.541187] <-- nfs41_sequence_call=
_done

Sep 19 06:13:53 examplehost kernel: [771928.572599] <--
nfs41_proc_async_sequence status=3D0

Sep 19 06:13:53 examplehost kernel: [771928.572675] encode_sequence:
sessionid=3D61:1568410703:305419896:61 seqid=3D8 slotid=3D0 max_slotid=3D0
cache_this=3D0

Sep 19 06:13:53 examplehost kernel: [771928.572895] encode_sequence:
sessionid=3D61:1568410703:305419896:61 seqid=3D2 slotid=3D1 max_slotid=3D1
cache_this=3D1

Sep 19 06:13:53 examplehost kernel: [771928.573163]
nfs41_sequence_process: Error 0 free the slot

Sep 19 06:13:53 examplehost kernel: [771928.573166]
nfs41_sequence_call_done rpc_cred 000000004b01718a

Sep 19 06:13:53 examplehost kernel: [771928.573167] <-- nfs41_sequence_call=
_done

Sep 19 06:13:53 examplehost kernel: [771928.573236] decode_attr_type: type=
=3D00

Sep 19 06:13:53 examplehost kernel: [771928.573238]
decode_attr_change: change attribute=3D6738121685800950864

Sep 19 06:13:53 examplehost kernel: [771928.573240] decode_attr_size:
file size=3D8388608000

Sep 19 06:13:53 examplehost kernel: [771928.573242] decode_attr_fsid:
fsid=3D(0x0/0x0)

Sep 19 06:13:53 examplehost kernel: [771928.573243] decode_attr_fileid: fil=
eid=3D0

Sep 19 06:13:53 examplehost kernel: [771928.573245]
decode_attr_fs_locations: fs_locations done, error =3D 0

Sep 19 06:13:53 examplehost kernel: [771928.573246] decode_attr_mode:
file mode=3D00



As you can see the NFS: release(/test.img) is immediately after all of
the writes on the successful version. In the version that gets stuck
it never responds with that =E2=80=9Crelease=E2=80=9D.



It=E2=80=99s hard for me to do any debugging on the NFS Server sinces its m=
ore
of a =E2=80=9Cmanaged=E2=80=9D box (e.g I don=E2=80=99t have root and only =
have access to
certain debugging utilities). I do have a ticket open with Dell and
their engineering team is looking at this but I=E2=80=99m trying anything I
can do to figure this out as soon as I can.




Any help on this matter would be appreciated.
