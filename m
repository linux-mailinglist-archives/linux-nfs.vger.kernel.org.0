Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE072BE561
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2019 21:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407776AbfIYTKT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Sep 2019 15:10:19 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:44948 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732813AbfIYTKS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Sep 2019 15:10:18 -0400
Received: by mail-io1-f48.google.com with SMTP id j4so1573685iog.11
        for <linux-nfs@vger.kernel.org>; Wed, 25 Sep 2019 12:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Pq/QiPOqh0FQqpkYb53t2EpjKRVc3dO3+0c43z7V97M=;
        b=TS+XtploGfADfTxlyKxlQnT4gZBQsMyRBAEjH2EYplGvfmVnRfEVcRKI7qRW1vZg5m
         hW4viZB5cZxI63viYth6+Nq5f4BvNVtznqSf8DGXSN8Ss0P8WTuE7up47rhh7AReKSRo
         0iX9DwqRuKtR7RQug431fbptIm1t/PY13FpvjLgAGDCZVE3UFWZwQG7ywRf+Fkv+794B
         TOE6Hgvh0wltLCJFr+yVdJngRjYHWFvi8yXpAqYJOAGIwYlJYohKDeDt+i+7bUfFb62z
         O1QF23QBHaYrkrcOfl0iiwrkMbP6TWgP6RTFZe/F8LnCvUrRgKSeT6wksiFqv+YAmGuf
         tTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Pq/QiPOqh0FQqpkYb53t2EpjKRVc3dO3+0c43z7V97M=;
        b=rQqYEwYW8CY/f+WeX2ibIJSdGx011ni3YWULTF+xTdKw2Qbrz/YEwW81DZh9Rit1ga
         i/VAMgPfpA99smUwH338y/QRN6pW6wKpGQ9bARJVPatCM5hCOMWC0pLAJpfO8Y/WU2qf
         kvmQgav4TEoiSClVN5isiNyQcfbvuOoXEuBIiZ2QW7bM3OJYyVwFsNU2RasyOl0mqlxM
         Ey24Myu9h9xX1OfvtFb4KqVwUtybin6YqPc9PC9OJVkoTEVTxap3jx6q4ijXAHLz76rD
         MO5h790KTYc6PoBQCr/8M20YQkjk8p5ONbb6p6W/ztYIO2L+v/TPXzvNU2/Z9xAw9Swf
         /R8Q==
X-Gm-Message-State: APjAAAU+CfUihxzUSPzGX4xYOTTQ97/Lh2bgXSSg24AX0vuKUoLx28q0
        IE/ucGOiKgY0JsvgyvELLQ4zeVG7vdsXl/6Y3AWbTY6P
X-Google-Smtp-Source: APXvYqxyL+aOGPitOo59r5kbYQJLvlaryCfvca4I5sx8TZXqKVJcj2q7nE5t2aPTh5nmeawmc5l/3PfknfLSOXQM/DU=
X-Received: by 2002:a6b:4416:: with SMTP id r22mr979693ioa.297.1569438616049;
 Wed, 25 Sep 2019 12:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAMd28E-pJp4=kvp62FJqGLZo-jGA2rH2OT6-hK_N=TvMiJuT2A@mail.gmail.com>
 <20190925164831.GA9366@fieldses.org> <57192382-86BE-4878-9AE0-B22833D56367@oracle.com>
 <CAMd28E-zcjuCfVbDCra4Av3Ewsdd-Ai=E0j3tF2GKJ8P6nG8=w@mail.gmail.com> <FCAD9EFD-26AD-41F0-BCCA-80E475219731@oracle.com>
In-Reply-To: <FCAD9EFD-26AD-41F0-BCCA-80E475219731@oracle.com>
From:   Kevin Vasko <kvasko@gmail.com>
Date:   Wed, 25 Sep 2019 14:10:05 -0500
Message-ID: <CAMd28E_zQk4HyGypegear9rHiOhFe=YHWYbgJhn5KT80ARTiYQ@mail.gmail.com>
Subject: Re: NFSv4 client locks up on larger writes with Kerberos enabled
To:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Forgive my ignorance but I assume you mean GSS (Generic Security
Services) of which Kerberos is an implementation of? So effectively in
my environment with Kerberos being enabled, thats usually a sign that
the GSS window has overflowed? I assume that would be the same meaning
for my context?

"Sounds like the NFS server is dropping the connection."
This seems certainly likely that this could be the issue. Is there a
way of proving that the GSS window is overflowing via the packets? If
I could get to the rpc-gssd service on the NFS server would that show
me what I need to know? Or would there be some other service that
would help narrow it down?

Thanks again,

-Kevin

On Wed, Sep 25, 2019 at 1:49 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Sep 25, 2019, at 11:44 AM, Kevin Vasko <kvasko@gmail.com> wrote:
> >
> > Appreciate the information. I have tried different clients. The Centos
> > and Ubuntu clients exhibit the same issue. I also did packet tracing.
> > On small files the client will go through its "WRITE..." packets...
> > and then will issue COMMIT and then do the CLOSE. On larger files it
> > will do all of its WRITE... packets and then will issue COMMIT and
> > then it will never do a CLOSE. I'm assuming whats happening is the
> > client is waiting for the NFS server to authenticate with the Kerberos
> > server to make sure the write is okay, however I assume it never does.
> > I would like to try and figure out how to see that "authentication"
> > packet to kerberos from the server (if there is one).
> >
> > Just for giggles, I just tried it with NFSv3 and there is a slight
> > change and gives a little more information (albeit, what I kind of
> > already assumed). Mounted the shared with krb5p, and vers=3D3.
> >
> > I write a file with
> > strace -f dd if=3D/dev/zero of=3D/data/test.img bs=3D10M count=3D1
> >
> > This is successful.  No issues. Just like NFSv4
> >
> > Then I change nothing but the size of the file being written (just
> > like with NFSv4)=E2=80=A6however with NFSv3 it will halt for ~1 minute =
and
> > then spit out a permission denied even though I just wrote out the
> > SAME exact file in the SAME exact location (literally overwriting the
> > file) a few seconds prior. The only difference in NFSv3 and NFSv4 is
> > that NFSv3 fails with a permission issue, whereas NFSv4 never returns.
>
> Sounds like the NFS server is dropping the connection. With
> GSS enabled, that's usually a sign that the GSS window has
> overflowed.
>
>
> > strace -f dd if=3D/dev/zero of=3D/data/test.img bs=3D1000M count=3D1
> >
> > This command with NFSv3, takes ~1min and will return file permissions
> > error (even though it just wrote it and can run the above command
> > again and it will finish with no errors).
> >
> > This makes sense in that my initial suspicion is that the Dell Unity
> > 300 isn=E2=80=99t authenticating properly with larger writes (for whate=
ver
> > reason) with Kerberos. This is also why I don=E2=80=99t see the problem=
 when I
> > disable Kerberos on the Unity 300 system.
> >
> > When should the NFS server be sending a packet to the Kerberos server
> > to validate the write? Or should it be? I did do packet capture on the
> > Unity box but I don=E2=80=99t see anything really useful regarding Kerb=
eros
> > authentication. What should I be looking for in the packet traces to
> > look for the authentication packets?
> >
> > Debugging commands:
> >
> > $mount
> >
> > ...snip=E2=80=A6
> >
> > 10.75.37.2:/ds1 on /data type nfs
> > (rw,relatime,vers=3D3,rsize=3D65536,wsize=3D65536,namlen=3D255,hard,pro=
to=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dkrb5p,mountaddr=3D10.75.37.2,mountve=
rs=3D3,mountport=3D1234,mountproto=3Dudp,local_lock=3Dnone,addr=3D10.75.37.=
2)
> >
> >
> >
> > $ time dd if=3D/dev/zero of=3D/data/test.img bs=3D10M count=3D1
> > 1+0 records in
> > 1+0 records out
> > 10485760 bytes (10 MB, 10 MiB) copied, 0.112561 s, 93.2 MB/s
> > real    0m0.188s
> > user    0m0.000s
> > sys     0m0.087s
> >
> > $ time dd if=3D/dev/zero of=3D/data/test.img bs=3D1000M count=3D1
> > dd: closing output file '/data/test.img': Permission denied
> > real    1m9.093s
> > user    0m0.000s
> > sys     0m1.124s
> >
> > $ strace -f dd if=3D/dev/zero of=3D/data/test.img bs=3D10M count=3D1
> > execve("/bin/dd", ["dd", "if=3D/dev/zero", "of=3D/data/test.img",
> > "bs=3D10M", "count=3D1"], 0x7ffec9914328 /* 30 vars */) =3D 0
> > brk(NULL)                               =3D 0x5595514e6000
> > access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
> > access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or =
directory)
> > openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
> > fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D125550, ...}) =3D 0
> > mmap(NULL, 125550, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f5e4e5d2000
> > close(3)                                =3D 0
> > access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
> > openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC)=
 =3D 3
> > read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\34\2\0\0\0\=
0\0"...,
> > 832) =3D 832
> > fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D2030544, ...}) =3D 0
> > mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> > 0) =3D 0x7f5e4e5d0000
> > mmap(NULL, 4131552, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
> > 0) =3D 0x7f5e4dfd9000
> > mprotect(0x7f5e4e1c0000, 2097152, PROT_NONE) =3D 0
> > mmap(0x7f5e4e3c0000, 24576, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e7000) =3D 0x7f5e4e3c0000
> > mmap(0x7f5e4e3c6000, 15072, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7f5e4e3c6000
> > close(3)                                =3D 0
> > arch_prctl(ARCH_SET_FS, 0x7f5e4e5d1540) =3D 0
> > mprotect(0x7f5e4e3c0000, 16384, PROT_READ) =3D 0
> > mprotect(0x55954fd03000, 4096, PROT_READ) =3D 0
> > mprotect(0x7f5e4e5f1000, 4096, PROT_READ) =3D 0
> > munmap(0x7f5e4e5d2000, 125550)          =3D 0
> > rt_sigaction(SIGINT, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_flag=
s=3D0}, 8) =3D 0
> > rt_sigaction(SIGUSR1, {sa_handler=3D0x55954faf60e0, sa_mask=3D[INT USR1=
],
> > sa_flags=3DSA_RESTORER, sa_restorer=3D0x7f5e4e017f20}, NULL, 8) =3D 0
> > rt_sigaction(SIGINT, {sa_handler=3D0x55954faf60d0, sa_mask=3D[INT USR1]=
,
> > sa_flags=3DSA_RESTORER|SA_NODEFER|SA_RESETHAND,
> > a_restorer=3D0x7f5e4e017f20}, NULL, 8) =3D 0
> > brk(NULL)                               =3D 0x5595514e6000
> > brk(0x559551507000)                     =3D 0x559551507000
> > openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) =
=3D 3
> > fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D11603728, ...}) =3D 0
> > mmap(NULL, 11603728, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f5e4d4c8000
> > close(3)                                =3D 0
> > openat(AT_FDCWD, "/dev/zero", O_RDONLY) =3D 3
> > dup2(3, 0)                              =3D 0
> > close(3)                                =3D 0
> > lseek(0, 0, SEEK_CUR)                   =3D 0
> > openat(AT_FDCWD, "/data/test.img", O_WRONLY|O_CREAT|O_TRUNC, 0666) =3D =
3
> > dup2(3, 1)                              =3D 1
> > close(3)                                =3D 0
> > mmap(NULL, 10498048, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
> > -1, 0) =3D 0x7f5e4cac5000
> > read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0"...,
> > 10485760) =3D 10485760
> > write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0"...,
> > 10485760) =3D 10485760
> > close(0)                                =3D 0
> > close(1)                                =3D 0
> > openat(AT_FDCWD, "/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) =
=3D 0
> > fstat(0, {st_mode=3DS_IFREG|0644, st_size=3D2995, ...}) =3D 0
> > read(0, "# Locale name alias data base.\n#"..., 4096) =3D 2995
> > read(0, "", 4096)                       =3D 0
> > close(0)                                =3D 0
> > openat(AT_FDCWD,
> > "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
> > -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale/en_US.utf8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
> > -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale/en.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D -1
> > ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en_US.UTF-8/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en_US.utf8/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en_US/LC_MESSAGES/coreutils.mo", O_RDONLY)
> > =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en.UTF-8/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en.utf8/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
> > 0
> > fstat(0, {st_mode=3DS_IFREG|0644, st_size=3D578, ...}) =3D 0
> > mmap(NULL, 578, PROT_READ, MAP_PRIVATE, 0, 0) =3D 0x7f5e4e5f0000
> > close(0)                                =3D 0
> > write(2, "1+0 records in\n1+0 records out\n", 311+0 records in
> > 1+0 records out
> > ) =3D 31
> > write(2, "10485760 bytes (10 MB, 10 MiB) c"..., 6010485760 bytes (10
> > MB, 10 MiB) copied, 0.105735 s, 99.2 MB/s) =3D 60
> > write(2, "\n", 1
> > )                       =3D 1
> > close(2)                                =3D 0
> > exit_group(0)                           =3D ?
> > +++ exited with 0 +++
> >
> >
> >
> > $ strace -f dd if=3D/dev/zero of=3D/data/test.img bs=3D1000M count=3D1
> > execve("/bin/dd", ["dd", "if=3D/dev/zero", "of=3D/data/test.img",
> > "bs=3D1000M", "count=3D1"], 0x7fff46397c58 /* 30 vars */) =3D 0
> > brk(NULL)                               =3D 0x55a768f09000
> > access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
> > access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or =
directory)
> > openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
> > fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D125550, ...}) =3D 0
> > mmap(NULL, 125550, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f604f357000
> > close(3)                                =3D 0
> > access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
> > openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC)=
 =3D 3
> > read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\34\2\0\0\0\=
0\0"...,
> > 832) =3D 832
> > fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D2030544, ...}) =3D 0
> > mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> > 0) =3D 0x7f604f355000
> > mmap(NULL, 4131552, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
> > 0) =3D 0x7f604ed5e000
> > mprotect(0x7f604ef45000, 2097152, PROT_NONE) =3D 0
> > mmap(0x7f604f145000, 24576, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e7000) =3D 0x7f604f145000
> > mmap(0x7f604f14b000, 15072, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7f604f14b000
> > close(3)                                =3D 0
> > arch_prctl(ARCH_SET_FS, 0x7f604f356540) =3D 0
> > mprotect(0x7f604f145000, 16384, PROT_READ) =3D 0
> > mprotect(0x55a767990000, 4096, PROT_READ) =3D 0
> > mprotect(0x7f604f376000, 4096, PROT_READ) =3D 0
> > munmap(0x7f604f357000, 125550)          =3D 0
> > rt_sigaction(SIGINT, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_flag=
s=3D0}, 8) =3D 0
> > rt_sigaction(SIGUSR1, {sa_handler=3D0x55a7677830e0, sa_mask=3D[INT USR1=
],
> > sa_flags=3DSA_RESTORER, sa_restorer=3D0x7f604ed9cf20}, NULL, 8) =3D 0
> > rt_sigaction(SIGINT, {sa_handler=3D0x55a7677830d0, sa_mask=3D[INT USR1]=
,
> > sa_flags=3DSA_RESTORER|SA_NODEFER|SA_RESETHAND,
> > a_restorer=3D0x7f604ed9cf20}, NULL, 8) =3D 0
> > brk(NULL)                               =3D 0x55a768f09000
> > brk(0x55a768f2a000)                     =3D 0x55a768f2a000
> > openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) =
=3D 3
> > fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D11603728, ...}) =3D 0
> > mmap(NULL, 11603728, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f604e24d000
> > close(3)                                =3D 0
> > openat(AT_FDCWD, "/dev/zero", O_RDONLY) =3D 3
> > dup2(3, 0)                              =3D 0
> > close(3)                                =3D 0
> > lseek(0, 0, SEEK_CUR)                   =3D 0
> > openat(AT_FDCWD, "/data/test.img", O_WRONLY|O_CREAT|O_TRUNC, 0666) =3D =
3
> > dup2(3, 1)                              =3D 1
> > close(3)                                =3D 0
> > mmap(NULL, 1048588288, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f600fa4a000
> > read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0"...,
> > 1048576000) =3D 1048576000
> > write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0"...,
> > 1048576000) =3D 1048576000
> > close(0)                                =3D 0
> > close(1)                                =3D -1 EACCES (Permission denie=
d)
> > openat(AT_FDCWD, "/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) =
=3D 0
> > fstat(0, {st_mode=3DS_IFREG|0644, st_size=3D2995, ...}) =3D 0
> > read(0, "# Locale name alias data base.\n#"..., 4096) =3D 2995
> > read(0, "", 4096)                       =3D 0
> > close(0)                                =3D 0
> > openat(AT_FDCWD,
> > "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
> > -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale/en_US.utf8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
> > -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale/en.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D -1
> > ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en_US.UTF-8/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en_US.utf8/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en_US/LC_MESSAGES/coreutils.mo", O_RDONLY)
> > =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en.UTF-8/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en.utf8/LC_MESSAGES/coreutils.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
> > 0
> > fstat(0, {st_mode=3DS_IFREG|0644, st_size=3D578, ...}) =3D 0
> > mmap(NULL, 578, PROT_READ, MAP_PRIVATE, 0, 0) =3D 0x7f604f375000
> > close(0)                                =3D 0
> > write(2, "dd: ", 4dd: )                     =3D 4
> > write(2, "closing output file '/data/test."..., 36closing output file
> > '/data/test.img') =3D 36
> > openat(AT_FDCWD, "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/libc.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en_US.utf8/LC_MESSAGES/libc.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/libc.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en.UTF-8/LC_MESSAGES/libc.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY)
> > =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en_US.UTF-8/LC_MESSAGES/libc.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en_US.utf8/LC_MESSAGES/libc.mo", O_RDONLY)
> > =3D -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en_US/LC_MESSAGES/libc.mo", O_RDONLY) =3D -=
1
> > ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) =
=3D
> > -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD,
> > "/usr/share/locale-langpack/en.utf8/LC_MESSAGES/libc.mo", O_RDONLY) =3D
> > -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/share/locale-langpack/en/LC_MESSAGES/libc.mo",
> > O_RDONLY) =3D -1 ENOENT (No such file or directory)
> > write(2, ": Permission denied", 19: Permission denied)     =3D 19
> > write(2, "\n", 1
> > )                       =3D 1
> > close(2)                                =3D 0
> > exit_group(1)                           =3D ?
> > +++ exited with 1 +++
> >
> > On Wed, Sep 25, 2019 at 12:06 PM Chuck Lever <chuck.lever@oracle.com> w=
rote:
> >>
> >>
> >>
> >>> On Sep 25, 2019, at 9:48 AM, bfields@fieldses.org wrote:
> >>>
> >>> On Wed, Sep 18, 2019 at 06:36:13PM -0500, Kevin Vasko wrote:
> >>>> We have a new Dell EMC Unity 300 acting as NAS Server that is
> >>>> presenting a NFSv4 NFS Share. Our clients are mostly Ubuntu 18.04.3
> >>>> but issue is also present on CentOS 7.6 systems. We have been
> >>>> struggling with this issue for over a week now and not sure how to
> >>>> resolve it.
> >>>>
> >>>>
> >>>>
> >>>> We are having trouble with NFS Clients completing their writes to th=
e
> >>>> Dell EMC Unity 300 NFS Server when Kerberos is enabled on the NFS
> >>>> Share. I created the NFS Share on the U300, associated it with our
> >>>> FreeIPA (Kerberos/LDAP server) and everything shows successful.
> >>>
> >>> Troubleshooting ideas off the top of my head:
> >>>
> >>> It might be worth trying some other client versions if it's not hard.
> >>>
> >>> It'd be interesting to know what's happening on the network....
> >>> Unfortunately big krb5p writes won't be fun to try to capture and
> >>> examine.
> >>
> >> Wireshark is supposed to have a mechanism for giving it the keys
> >> so that captured GSS data can be decrypted. I've never gotten it
> >> to work, but I didn't try hard. Should be appropriately documented.
> >>
> >>
> >>> Maybe some network or rpc-level statistics would help show if
> >>> there are an unusual number of retries or failures.
> >>
> >>
> >> --
> >> Chuck Lever
> >>
> >>
> >>
>
> --
> Chuck Lever
>
>
>
