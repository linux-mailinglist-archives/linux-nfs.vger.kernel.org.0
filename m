Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97826B7D5C
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 16:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbfISO6s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 10:58:48 -0400
Received: from mail-yb1-f180.google.com ([209.85.219.180]:34369 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387407AbfISO6s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Sep 2019 10:58:48 -0400
Received: by mail-yb1-f180.google.com with SMTP id u68so1451345ybg.1
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2019 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:date:subject:message-id
         :references:in-reply-to:to;
        bh=M0Ghb5i3L/AllqHYjE0RBcffWxIxvJuJK3A5hlAjI9k=;
        b=hYwVsSD+z5FE3X1p0SIg2NjEQDu5dUTwnzr1mrSvpWtHWB7K7+ZFLU5T2iRYqyQShS
         5Ih7itATWJW+x+Gj+HLmmM6sbDqQlA8KdihJ8muonnSGYS+nz+PlxJUMkohw4r4uazax
         pX8IK5mU57GVGKKoq7QLR3NqNnYzOqiBpYhIJv+WW6Z9K1nruHYWK9K7DYrDA560N4E8
         jXUc7VtThEa/nsylHnWYDtuANn8n8fr6GaUirGE+kRat0G0k3VLHYAdbFTiUyyNjm2pK
         y6KkCx/Q+ffdZE2d9rHzfM6H+FpA1CtfIpNy2C5xUyyIMmWjLGaY4OpO5PVVWXj5ltnC
         fYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version:date
         :subject:message-id:references:in-reply-to:to;
        bh=M0Ghb5i3L/AllqHYjE0RBcffWxIxvJuJK3A5hlAjI9k=;
        b=QNZumnu4AI0SSusIG4ZAgs7IQ9Ltx5M6N3JLhgEo2P2Rhi22XRYmmLZTP6TT7t1wru
         Va4L7bEF3FDUB4+1CIw9iqfU/bq1jodVTcxMeQXMJKznYmtUEO2AkVAGrb4qRTtSYCpp
         RTxrxTmOeM4tMOA6IiTvbGywUbRKkI9HkGNBlK72yTITHbuGboo5wqV2uc8/sUIwZO2d
         fFUAud3oCER9pbtTHeCq0s7sBiHrWisCcc/HawtjB1bWQbyfiFDds94UQzmhow5UfXev
         CLMRtQ65EWGDHnmLKkKGLglqWicX674kLLkDIra7KghQ0ptWQt3cETK142i6MHi1UmMS
         vHmA==
X-Gm-Message-State: APjAAAUkyr9iS4DmYddIzxiiDLC/FhC5c3kbZg889mYPWi925K+Y+zKx
        FiMfJpK1016mNI+nunauTJcktrjT
X-Google-Smtp-Source: APXvYqw9Quf2G+MUWoKeuQKQu8/4uvnA6soe7ea9Dgd6RETPkaOlKei/xfW9JPlS2KI/DMz/wQIVeg==
X-Received: by 2002:a25:764d:: with SMTP id r74mr1307917ybc.80.1568905126367;
        Thu, 19 Sep 2019 07:58:46 -0700 (PDT)
Received: from ?IPv6:2600:1005:b160:760f:4c1d:66bd:b8b:8ad5? ([2600:1005:b160:760f:4c1d:66bd:b8b:8ad5])
        by smtp.gmail.com with ESMTPSA id 14sm1952861ywf.61.2019.09.19.07.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:58:45 -0700 (PDT)
From:   Kevin Vasko <kvasko@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date:   Thu, 19 Sep 2019 09:58:44 -0500
Subject: Re: NFSv4 client locks up on larger writes with Kerberos enabled
Message-Id: <C6E1D129-98E2-4B42-B84A-AD1528F0292D@gmail.com>
References: <CAMd28E-pJp4=kvp62FJqGLZo-jGA2rH2OT6-hK_N=TvMiJuT2A@mail.gmail.com> <E172CA50-EC89-4072-9C1D-1B825DC3FE8B@lysator.liu.se> <280ADE78-D617-4A97-9B92-18DCE3063B93@gmail.com> <72E82F62-C743-4783-B81E-98E6A8E35738@lysator.liu.se>
In-Reply-To: <72E82F62-C743-4783-B81E-98E6A8E35738@lysator.liu.se>
To:     Peter Eriksson <pen@lysator.liu.se>, linux-nfs@vger.kernel.org
X-Mailer: iPhone Mail (16G102)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Yeah I appreciate the suggestion, worth a check.

Yeah this problem happens almost every single time I perform a file write to=
 the NFS. It all started and happened as soon as I set it up. I finished set=
ting up the server, installed the packages on the clients. Copied some small=
 configs over to the NFS to make sure permissions were working. That worked f=
ine. I started copying the anaconda package over which was about 500MB. Afte=
r about 5 minutes and it still wasn=E2=80=99t wasn=E2=80=99t done. These sys=
tems are all on 10Gbps networks so I knew something was amiss. At that point=
 started digging into and now a week and a half later here I am.

This problem has been a total pain in my rear and I=E2=80=99m scraping the b=
ottom of the barrel of what I know to check so really anything is good for m=
e haha.=20

Thanks!=20

-Kevin

> On Sep 19, 2019, at 9:40 AM, Peter Eriksson <pen@lysator.liu.se> wrote:
>=20
> Yeah, it=E2=80=99s probably not that. But I thought you might wanna keep a=
n eye out for that just in case. When gssd crashed for us it just silently d=
ied. No traces in log files. We just noticed it because it suddenly had a di=
fferent process number.=20
>=20
> In our case Puppet, which runs every 30 minutes, would detect that it was d=
own and restart the process. A debug of it pointed to a strcmp() being done o=
n a NULL pointer. It didn=E2=80=99t happen every time, on a machine that mou=
nted ~10 different NFS Servers every minute 24/7 (via both IPv4 and IPv6) it=
 happened perhaps once per week or month or so. So not very often. We only n=
oticed it since there would be gaps it the latency test graphs produced by t=
hose machines (measures the time it takes to mount an NFS share) :-)
>=20
>=20
> We do se hanging NFS-related processes on some Ubuntu 18 machines here tho=
ugh (without crashing gssd=E2=80=99s which a co-worker is investigating.
>=20
> - Peter
>=20
>=20
>> On 19 Sep 2019, at 16:19, Kevin Vasko <kvasko@gmail.com> wrote:
>>=20
>> Unfortunately, I haven=E2=80=99t seen rpc.gssd crash anywhere in the logs=
.
>>=20
>> Just to confirm though I stopped rpc-gssd and started it manually in the f=
oreground with
>>=20
>> sudo rpc.gssd -f -vvv -rrr
>>=20
>> Unmounted the share, mounted it again. Saw a bunch of logs and authentica=
tions seemingly
>>=20
>> I then produced a lockup. It did some authentication in the logs and did n=
ot crash. The only warning is=20
>>=20
>> WARNING: gssd_clnt_gssd_cb: failed reading request
>>=20
>> Googling that warning doesn=E2=80=99t produce much information and seems u=
nrelated.
>>=20
>> My keys when I do klist=20
>>=20
>> This shows they expire 24h in the future for both  my user and the NFS se=
rver. Not sure how refreshing the tickets would help in this case. In additi=
on, if it=E2=80=99s locked, I restart the nfs server and then the client wil=
l immediately finish that write. I can then immediately transfer a 1MB file a=
nd it will complete successfully immediately. So if it was a kerberos ticket=
 was expiring I would assume it wouldn=E2=80=99t work with the small file im=
mediately after it just failed.
>>=20
>> I=E2=80=99m using sssd so it refreshes the tickets basically every time I=
 login to the NFS client.
>>=20
>> -Kevin
>>=20
>>> On Sep 19, 2019, at 6:38 AM, Peter Eriksson <pen@lysator.liu.se> wrote:
>>>=20
>>> Have you verified that the =E2=80=9Crpc.gssd=E2=80=9D daemon doesn=E2=80=
=99t crash while the write is under way? We=E2=80=99ve seen problems possibl=
y related to it (or gssproxy) with Linux clients connecting to our NFS Serve=
rs (FreeBSD-based) with NFSv4 & sec=3Dkrb5. Sometimes you might not notice i=
t crashing due to it being restarted automatically=E2=80=A6=20
>>>=20
>>> When things go south for us the Linux client =E2=80=9Clocks=E2=80=9D up a=
nd processes end up in =E2=80=9Cdevice wait=E2=80=9D and are unkillable. Onl=
y way out so far has been to reboot the client. _Sometimes_ it might be rela=
ted to Kerberos tickets expiring - things _seems_ to work better here when w=
e created a hack that renews them automatically (for as long as they can).
>>>=20
>>> - Peter
>>>=20
>>>=20
>>>> On 19 Sep 2019, at 01:36, Kevin Vasko <kvasko@gmail.com> wrote:
>>>>=20
>>>> Hello,
>>>>=20
>>>>=20
>>>> We have a new Dell EMC Unity 300 acting as NAS Server that is
>>>> presenting a NFSv4 NFS Share. Our clients are mostly Ubuntu 18.04.3
>>>> but issue is also present on CentOS 7.6 systems. We have been
>>>> struggling with this issue for over a week now and not sure how to
>>>> resolve it.
>>>>=20
>>>>=20
>>>>=20
>>>> We are having trouble with NFS Clients completing their writes to the
>>>> Dell EMC Unity 300 NFS Server when Kerberos is enabled on the NFS
>>>> Share. I created the NFS Share on the U300, associated it with our
>>>> FreeIPA (Kerberos/LDAP server) and everything shows successful.
>>>>=20
>>>>=20
>>>>=20
>>>> I can mount the share without a problem on multiple Ubuntu/CentOS
>>>> machines without issues. I can ls around and move around on the share
>>>> without issue (seemingly). I can copy files as well and that seem to
>>>> work (haven=E2=80=99t tested it extensively as I have been heavily focu=
sed on
>>>> this issue). However, clients won't complete their writes to the NFS
>>>> share randomly once the file gets to > 2GB or so in file size.
>>>> _sometimes_ they do, but I would say anything > 3GB, the client locks
>>>> up and won=E2=80=99t ever return 80% of the time I try it.
>>>>=20
>>>>=20
>>>>=20
>>>> For example, I can run dd and write ten 1MB files to the NFS share no
>>>> issues, all back to back to back. However, when I try to do a single
>>>> 3GB file, it _might_ or might not finish. If it doesn=E2=80=99t finish i=
t just
>>>> locks up the client. Sometimes it will finish though so its random.
>>>> However, I would say 70-80% of the time it is reproducible with files
>>>>> 3GB or so.
>>>>=20
>>>>=20
>>>>=20
>>>> Here is some information on the client and what I=E2=80=99m doing to re=
produce
>>>> the issue. I have tried krb5, and krb5p with the same results.
>>>> Removing the requirement for krb5 in the NFS server and mounting with
>>>> sec=3Dnone, I don=E2=80=99t seem to hit the issue.
>>>>=20
>>>>=20
>>>>=20
>>>> $uname -a
>>>>=20
>>>> 5.0.0-27-generic #28~18.04.1-Ubuntu SMP Thu Aug 22 03:00:32 UTC 2019
>>>> x86_64 x86_64 x86_64 GNU/Linux
>>>>=20
>>>>=20
>>>>=20
>>>> $mount
>>>>=20
>>>> nfs-server.example.com:/ds1 on /data type nfs4
>>>> (rw,relatime,vers=3D4.1,rsize=3D65536,wsize=3D65536,namlen=3D255,hard,p=
roto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dkrb5p,clientaddr=3D10.75.40.254,loc=
al_lock=3Dnone,addr=3D10.75.37.2)
>>>>=20
>>>>=20
>>>>=20
>>>> $ dd if=3D/dev/zero of=3D/data/test.img count=3D1000 bs=3D1000
>>>>=20
>>>> 1000+0 records in
>>>>=20
>>>> 1000+0 records out
>>>>=20
>>>> 1000000 bytes (1.0 MB, 977 KiB) copied, 0.00613671 s, 163 MB/s
>>>>=20
>>>> $ dd if=3D/dev/zero of=3D/data/test.img bs=3D1000M count=3D6
>>>>=20
>>>> ---- HUNG ----
>>>>=20
>>>>=20
>>>>=20
>>>> After it hangs it will NEVER return. The only way I've been able to
>>>> get the client to return is to go into the U300 Control panel and
>>>> change the "SP Owner:" from SPA to SPB (effectively restarting the NFS
>>>> server). Once that happens the client returns.
>>>>=20
>>>>=20
>>>>=20
>>>> If I disable Kerberos on the NFS Share I have no problems writing
>>>> larger files it seems.
>>>>=20
>>>>=20
>>>>=20
>>>> I did some straces of the dd and this is what I saw.
>>>>=20
>>>>=20
>>>>=20
>>>> This was a successful write=E2=80=A6.
>>>>=20
>>>>=20
>>>>=20
>>>> $ strace dd if=3D/dev/zero of=3D/data/test3.img bs=3D100M count=3D1
>>>>=20
>>>> execve("/bin/dd", ["dd", "if=3D/dev/zero", "of=3D/data/test3.img",
>>>> "bs=3D100M", "count=3D1"], 0x7fff8c03c7f0 /* 21 vars */) =3D 0
>>>>=20
>>>> brk(NULL)                               =3D 0x559b8b39a000
>>>>=20
>>>> access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or d=
irectory)
>>>>=20
>>>> access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or d=
irectory)
>>>>=20
>>>> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
>>>>=20
>>>> fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D93482, ...}) =3D 0
>>>>=20
>>>> mmap(NULL, 93482, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f62b6180000
>>>>=20
>>>> close(3)                                =3D 0
>>>>=20
>>>> access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or d=
irectory)
>>>>=20
>>>> openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC)=
 =3D 3
>>>>=20
>>>> read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\34\2\0\0\0\=
0\0"...,
>>>> 832) =3D 832
>>>>=20
>>>> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D2030544, ...}) =3D 0
>>>>=20
>>>> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
>>>> 0) =3D 0x7f62b617e000
>>>>=20
>>>> mmap(NULL, 4131552, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
>>>> 0) =3D 0x7f62b5b7f000
>>>>=20
>>>> mprotect(0x7f62b5d66000, 2097152, PROT_NONE) =3D 0
>>>>=20
>>>> mmap(0x7f62b5f66000, 24576, PROT_READ|PROT_WRITE,
>>>> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e7000) =3D 0x7f62b5f66000
>>>>=20
>>>> mmap(0x7f62b5f6c000, 15072, PROT_READ|PROT_WRITE,
>>>> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7f62b5f6c000
>>>>=20
>>>> close(3)                                =3D 0
>>>>=20
>>>> arch_prctl(ARCH_SET_FS, 0x7f62b617f540) =3D 0
>>>>=20
>>>> mprotect(0x7f62b5f66000, 16384, PROT_READ) =3D 0
>>>>=20
>>>> mprotect(0x559b8978b000, 4096, PROT_READ) =3D 0
>>>>=20
>>>> mprotect(0x7f62b6197000, 4096, PROT_READ) =3D 0
>>>>=20
>>>> munmap(0x7f62b6180000, 93482)           =3D 0
>>>>=20
>>>> rt_sigaction(SIGINT, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_flag=
s=3D0}, 8) =3D 0
>>>>=20
>>>> rt_sigaction(SIGUSR1, {sa_handler=3D0x559b8957e0e0, sa_mask=3D[INT USR1=
],
>>>> sa_flags=3DSA_RESTORER, sa_restorer=3D0x7f62b5bbdf20}, NULL, 8) =3D 0
>>>>=20
>>>> rt_sigaction(SIGINT, {sa_handler=3D0x559b8957e0d0, sa_mask=3D[INT USR1]=
,
>>>> sa_flags=3DSA_RESTORER|SA_NODEFER|SA_RESETHAND,
>>>> sa_restorer=3D0x7f62b5bbdf20}, NULL, 8) =3D 0
>>>>=20
>>>> brk(NULL)                               =3D 0x559b8b39a000
>>>>=20
>>>> brk(0x559b8b3bb000)                     =3D 0x559b8b3bb000
>>>>=20
>>>> openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) =3D=
 3
>>>>=20
>>>> fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D4326016, ...}) =3D 0
>>>>=20
>>>> mmap(NULL, 4326016, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f62b575e000
>>>>=20
>>>> close(3)                                =3D 0
>>>>=20
>>>> openat(AT_FDCWD, "/dev/zero", O_RDONLY) =3D 3
>>>>=20
>>>> dup2(3, 0)                              =3D 0
>>>>=20
>>>> close(3)                                =3D 0
>>>>=20
>>>> lseek(0, 0, SEEK_CUR)                   =3D 0
>>>>=20
>>>> openat(AT_FDCWD, "/data/test3.img", O_WRONLY|O_CREAT|O_TRUNC, 0666) =3D=
 3
>>>>=20
>>>> dup2(3, 1)                              =3D 1
>>>>=20
>>>> close(3)                                =3D 0
>>>>=20
>>>> mmap(NULL, 104869888, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
>>>> -1, 0) =3D 0x7f62af35b000
>>>>=20
>>>> read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0"...,
>>>> 104857600) =3D 104857600
>>>>=20
>>>> write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0"...,
>>>> 104857600) =3D 104857600
>>>>=20
>>>> close(0)                                =3D 0
>>>>=20
>>>> close(1)                                =3D 0
>>>>=20
>>>> openat(AT_FDCWD, "/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) =3D=
 0
>>>>=20
>>>> fstat(0, {st_mode=3DS_IFREG|0644, st_size=3D2995, ...}) =3D 0
>>>>=20
>>>> read(0, "# Locale name alias data base.\n#"..., 4096) =3D 2995
>>>>=20
>>>> read(0, "", 4096)                       =3D 0
>>>>=20
>>>> close(0)                                =3D 0
>>>>=20
>>>> openat(AT_FDCWD,
>>>> "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D=

>>>> -1 ENOENT (No such file or directory)
>>>>=20
>>>> openat(AT_FDCWD,
>>>> "/usr/share/locale/en_US.utf8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
>>>> -1 ENOENT (No such file or directory)
>>>>=20
>>>> openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/coreutils.mo",
>>>> O_RDONLY) =3D -1 ENOENT (No such file or directory)
>>>>=20
>>>> openat(AT_FDCWD,
>>>> "/usr/share/locale/en.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D -1=

>>>> ENOENT (No such file or directory)
>>>>=20
>>>> openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/coreutils.mo",
>>>> O_RDONLY) =3D -1 ENOENT (No such file or directory)
>>>>=20
>>>> openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/coreutils.mo",
>>>> O_RDONLY) =3D -1 ENOENT (No such file or directory)
>>>>=20
>>>> openat(AT_FDCWD,
>>>> "/usr/share/locale-langpack/en_US.UTF-8/LC_MESSAGES/coreutils.mo",
>>>> O_RDONLY) =3D -1 ENOENT (No such file or directory)
>>>>=20
>>>> openat(AT_FDCWD,
>>>> "/usr/share/locale-langpack/en_US.utf8/LC_MESSAGES/coreutils.mo",
>>>> O_RDONLY) =3D -1 ENOENT (No such file or directory)
>>>>=20
>>>> openat(AT_FDCWD,
>>>> "/usr/share/locale-langpack/en_US/LC_MESSAGES/coreutils.mo", O_RDONLY)
>>>> =3D -1 ENOENT (No such file or directory)
>>>>=20
>>>> openat(AT_FDCWD,
>>>> "/usr/share/locale-langpack/en.UTF-8/LC_MESSAGES/coreutils.mo",
>>>> O_RDONLY) =3D -1 ENOENT (No such file or directory)
>>>>=20
>>>> openat(AT_FDCWD,
>>>> "/usr/share/locale-langpack/en.utf8/LC_MESSAGES/coreutils.mo",
>>>> O_RDONLY) =3D -1 ENOENT (No such file or directory)
>>>>=20
>>>> openat(AT_FDCWD,
>>>> "/usr/share/locale-langpack/en/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D=

>>>> 0
>>>>=20
>>>> fstat(0, {st_mode=3DS_IFREG|0644, st_size=3D578, ...}) =3D 0
>>>>=20
>>>> mmap(NULL, 578, PROT_READ, MAP_PRIVATE, 0, 0) =3D 0x7f62b6196000
>>>>=20
>>>> close(0)                                =3D 0
>>>>=20
>>>> write(2, "1+0 records in\n1+0 records out\n", 311+0 records in
>>>>=20
>>>> 1+0 records out
>>>>=20
>>>> ) =3D 31
>>>>=20
>>>> write(2, "104857600 bytes (105 MB, 100 MiB"..., 61104857600 bytes (105
>>>> MB, 100 MiB) copied, 1.01552 s, 103 MB/s) =3D 61
>>>>=20
>>>> write(2, "\n", 1
>>>>=20
>>>> )                       =3D 1
>>>>=20
>>>> close(2)                                =3D 0
>>>>=20
>>>> exit_group(0)                           =3D ?
>>>>=20
>>>> +++ exited with 0 +++
>>>>=20
>>>>=20
>>>>=20
>>>> This one was unsuccessful write and hung until I restarted the NFS serv=
er.
>>>>=20
>>>>=20
>>>>=20
>>>> strace -f dd if=3D/dev/zero of=3D/data/test.img bs=3D1000M count=3D6
>>>>=20
>>>> execve("/bin/dd", ["dd", "if=3D/dev/zero", "of=3D/data/test.img",
>>>> "bs=3D1000M", "count=3D6"], 0x7ffc8ee7e8b8 /* 30 vars */) =3D 0
>>>>=20
>>>> brk(NULL)                               =3D 0x5648bd26a000
>>>>=20
>>>> access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or d=
irectory)
>>>>=20
>>>> access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or d=
irectory)
>>>>=20
>>>> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
>>>>=20
>>>> fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D125550, ...}) =3D 0
>>>>=20
>>>> mmap(NULL, 125550, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f4f8dda1000
>>>>=20
>>>> close(3)                                =3D 0
>>>>=20
>>>> access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or d=
irectory)
>>>>=20
>>>> openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC)=
 =3D 3
>>>>=20
>>>> read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\34\2\0\0\0\=
0\0"...,
>>>> 832) =3D 832
>>>>=20
>>>> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D2030544, ...}) =3D 0
>>>>=20
>>>> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
>>>> 0) =3D 0x7f4f8dd9f000
>>>>=20
>>>> mmap(NULL, 4131552, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
>>>> 0) =3D 0x7f4f8d7a8000
>>>>=20
>>>> mprotect(0x7f4f8d98f000, 2097152, PROT_NONE) =3D 0
>>>>=20
>>>> mmap(0x7f4f8db8f000, 24576, PROT_READ|PROT_WRITE,
>>>> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e7000) =3D 0x7f4f8db8f000
>>>>=20
>>>> mmap(0x7f4f8db95000, 15072, PROT_READ|PROT_WRITE,
>>>> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7f4f8db95000
>>>>=20
>>>> close(3)                                =3D 0
>>>>=20
>>>> arch_prctl(ARCH_SET_FS, 0x7f4f8dda0540) =3D 0
>>>>=20
>>>> mprotect(0x7f4f8db8f000, 16384, PROT_READ) =3D 0
>>>>=20
>>>> mprotect(0x5648bb739000, 4096, PROT_READ) =3D 0
>>>>=20
>>>> mprotect(0x7f4f8ddc0000, 4096, PROT_READ) =3D 0
>>>>=20
>>>> munmap(0x7f4f8dda1000, 125550)          =3D 0
>>>>=20
>>>> rt_sigaction(SIGINT, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], sa_flag=
s=3D0}, 8) =3D 0
>>>>=20
>>>> rt_sigaction(SIGUSR1, {sa_handler=3D0x5648bb52c0e0, sa_mask=3D[INT USR1=
],
>>>> sa_flags=3DSA_RESTORER, sa_restorer=3D0x7f4f8d7e6f20}, NULL, 8) =3D 0
>>>>=20
>>>> rt_sigaction(SIGINT, {sa_handler=3D0x5648bb52c0d0, sa_mask=3D[INT USR1]=
,
>>>> sa_flags=3DSA_RESTORER|SA_NODEFER|SA_RESETHAND,
>>>> sa_restorer=3D0x7f4f8d7e6f20}, NULL, 8) =3D 0
>>>>=20
>>>> brk(NULL)                               =3D 0x5648bd26a000
>>>>=20
>>>> brk(0x5648bd28b000)                     =3D 0x5648bd28b000
>>>>=20
>>>> openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) =3D=
 3
>>>>=20
>>>> fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D11603728, ...}) =3D 0
>>>>=20
>>>> mmap(NULL, 11603728, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f4f8cc97000
>>>>=20
>>>> close(3)                                =3D 0
>>>>=20
>>>> openat(AT_FDCWD, "/dev/zero", O_RDONLY) =3D 3
>>>>=20
>>>> dup2(3, 0)                              =3D 0
>>>>=20
>>>> close(3)                                =3D 0
>>>>=20
>>>> lseek(0, 0, SEEK_CUR)                   =3D 0
>>>>=20
>>>> openat(AT_FDCWD, "/data/test.img", O_WRONLY|O_CREAT|O_TRUNC, 0666) =3D 3=

>>>>=20
>>>> dup2(3, 1)                              =3D 1
>>>>=20
>>>> close(3)                                =3D 0
>>>>=20
>>>> mmap(NULL, 1048588288, PROT_READ|PROT_WRITE,
>>>> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f4f4e494000
>>>>=20
>>>> read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0"...,
>>>> 1048576000) =3D 1048576000
>>>>=20
>>>> write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0"...,
>>>> 1048576000) =3D 1048576000
>>>>=20
>>>> read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0"...,
>>>> 1048576000) =3D 1048576000
>>>>=20
>>>> write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0"...,
>>>> 1048576000) =3D 1048576000
>>>>=20
>>>> read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0"...,
>>>> 1048576000) =3D 1048576000
>>>>=20
>>>> write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0"...,
>>>> 1048576000) =3D 1048576000
>>>>=20
>>>> read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0"...,
>>>> 1048576000) =3D 1048576000
>>>>=20
>>>> write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0"...,
>>>> 1048576000) =3D 1048576000
>>>>=20
>>>> read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0"...,
>>>> 1048576000) =3D 1048576000
>>>>=20
>>>> write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0"...,
>>>> 1048576000) =3D 1048576000
>>>>=20
>>>> read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0"...,
>>>> 1048576000) =3D 1048576000
>>>>=20
>>>> write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0"...,
>>>> 1048576000) =3D 1048576000
>>>>=20
>>>> close(0)                                =3D 0
>>>>=20
>>>> close(1
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>> I did some packet tracing and on the smaller writes, I would see a
>>>> bunch of writes and replies to those writes, the client would COMMIT
>>>> and then NFS server would reply with an ack COMMIT, client would then
>>>> issue a CLOSE, and server would respond with a CLOSE. However, on
>>>> larger writes where it would hang it would do=E2=80=A6client would do a=
 bunch
>>>> of writes packets, NFS server would respond to the write packets,
>>>> client would issue a COMMIT command, server would respond with a
>>>> COMMIT, and then nothing else would happen. No CLOSE would seemingly
>>>> be sent from the client, so I don=E2=80=99t know if the client was wait=
ing on
>>>> the server to send back some type of message saying that the system
>>>> could issue a CLOSE or the client was never sending a CLOSE.
>>>>=20
>>>>=20
>>>>=20
>>>> Once it is in the locked state, if I restart the NFS server as I
>>>> mentioned above the close(1=E2=80=A6will continue and finish the write a=
nd
>>>> exit normally.
>>>>=20
>>>>=20
>>>>=20
>>>> I did a kernel Stack Traceback on the NFS client (the light weight
>>>> version of just printing out /proc/*/wchan) while the dd command was
>>>> stuck in the =E2=80=9Cclose(1=E2=80=9D and the process for the dd comma=
nd just says.
>>>>=20
>>>>=20
>>>>=20
>>>> Process /proc/32161/wchan
>>>>=20
>>>> ep_poll
>>>>=20
>>>>=20
>>>>=20
>>>> I also enabled the NFS debugging and while its stuck it just keep
>>>> repeating the bottom section.
>>>>=20
>>>>=20
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270750] NFS:       commit
>>>> (0:52/9439 4096@4609744896) OK
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270751] NFS:       commit
>>>> (0:52/9439 4096@4609748992) OK
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270754] NFS:       commit
>>>> (0:52/9439 4096@4609753088) OK
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270757] NFS:       commit
>>>> (0:52/9439 4096@4609757184) OK
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270759] NFS:       commit
>>>> (0:52/9439 4096@4609761280) OK
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270761] NFS:       commit
>>>> (0:52/9439 4096@4609765376) OK
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270763] NFS:       commit
>>>> (0:52/9439 4096@4609769472) OK
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270767] NFS:       commit
>>>> (0:52/9439 4096@4609773568) OK
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270769] NFS:       commit
>>>> (0:52/9439 4096@4609777664) OK
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270772] NFS:       commit
>>>> (0:52/9439 4096@4609781760) OK
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270773] NFS:       commit
>>>> (0:52/9439 4096@4609785856) OK
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270775] NFS:       commit
>>>> (0:52/9439 4096@4609789952) OK
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270777] NFS:       commit
>>>> (0:52/9439 4096@4609794048) OK
>>>>=20
>>>> Sep 19 06:25:19 examplehost kernel: [772614.270781] NFS:       commit
>>>> (0:52/9439 4096@4609798144) OK
>>>>=20
>>>> Sep 19 06:25:31 examplehost kernel: [772626.175927] <--
>>>> nfs41_proc_async_sequence status=3D0
>>>>=20
>>>> Sep 19 06:25:31 examplehost kernel: [772626.176018] encode_sequence:
>>>> sessionid=3D61:1568410703:305419896:61 seqid=3D2907 slotid=3D0 max_slot=
id=3D35
>>>> cache_this=3D0
>>>>=20
>>>> Sep 19 06:25:31 examplehost kernel: [772626.176572]
>>>> nfs41_sequence_process: Error 0 free the slot
>>>>=20
>>>> Sep 19 06:25:31 examplehost kernel: [772626.176576]
>>>> nfs41_sequence_call_done rpc_cred 000000004b01718a
>>>>=20
>>>> Sep 19 06:25:31 examplehost kernel: [772626.176577] <-- nfs41_sequence_=
call_done
>>>>=20
>>>> Sep 19 06:25:43 examplehost kernel: [772638.207976] <--
>>>> nfs41_proc_async_sequence status=3D0
>>>>=20
>>>> Sep 19 06:25:43 examplehost kernel: [772638.208074] encode_sequence:
>>>> sessionid=3D61:1568410703:305419896:61 seqid=3D2908 slotid=3D0 max_slot=
id=3D35
>>>> cache_this=3D0
>>>>=20
>>>> Sep 19 06:25:43 examplehost kernel: [772638.208642]
>>>> nfs41_sequence_process: Error 0 free the slot
>>>>=20
>>>> Sep 19 06:25:43 examplehost kernel: [772638.208646]
>>>> nfs41_sequence_call_done rpc_cred 000000004b01718a
>>>>=20
>>>> Sep 19 06:25:43 examplehost kernel: [772638.208648] <-- nfs41_sequence_=
call_done
>>>>=20
>>>> Sep 19 06:25:55 examplehost kernel: [772650.240046] <--
>>>> nfs41_proc_async_sequence status=3D0
>>>>=20
>>>> Sep 19 06:25:55 examplehost kernel: [772650.240129] encode_sequence:
>>>> sessionid=3D61:1568410703:305419896:61 seqid=3D2909 slotid=3D0 max_slot=
id=3D35
>>>> cache_this=3D0
>>>>=20
>>>> Sep 19 06:25:55 examplehost kernel: [772650.240904]
>>>> nfs41_sequence_process: Error 0 free the slot
>>>>=20
>>>> Sep 19 06:25:55 examplehost kernel: [772650.240908]
>>>> nfs41_sequence_call_done rpc_cred 000000004b01718a
>>>>=20
>>>> Sep 19 06:25:55 examplehost kernel: [772650.240909] <-- nfs41_sequence_=
call_done
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>> On a small file that actually completes it looks like this=E2=80=A6
>>>>=20
>>>>=20
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532059] NFS:       commit
>>>> (0:52/9439 4096@7409315840) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532061] NFS:       commit
>>>> (0:52/9439 4096@7409319936) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532064] NFS:       commit
>>>> (0:52/9439 4096@7409324032) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532066] NFS:       commit
>>>> (0:52/9439 4096@7409328128) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532069] NFS:       commit
>>>> (0:52/9439 4096@7409332224) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532071] NFS:       commit
>>>> (0:52/9439 4096@7409336320) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532073] NFS:       commit
>>>> (0:52/9439 4096@7409340416) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532076] NFS:       commit
>>>> (0:52/9439 4096@7409344512) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532078] NFS:       commit
>>>> (0:52/9439 4096@7409348608) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532081] NFS:       commit
>>>> (0:52/9439 4096@7409352704) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532083] NFS:       commit
>>>> (0:52/9439 4096@7409356800) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532086] NFS:       commit
>>>> (0:52/9439 4096@7409360896) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532088] NFS:       commit
>>>> (0:52/9439 4096@7409364992) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532090] NFS:       commit
>>>> (0:52/9439 4096@7409369088) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532093] NFS:       commit
>>>> (0:52/9439 4096@7409373184) OK
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532171] NFS: release(/test.=
img)
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532193] nfs4_close_prepare:=
 begin!
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532197] nfs4_close_prepare:=
 done!
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532235] encode_sequence:
>>>> sessionid=3D61:1568410703:305419896:61 seqid=3D6 slotid=3D0 max_slotid=3D=
0
>>>> cache_this=3D1
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532525] nfs4_close_done: be=
gin!
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532528]
>>>> nfs41_sequence_process: Error 0 free the slot
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532531] nfs4_close_done:
>>>> done, ret =3D 0!
>>>>=20
>>>> Sep 19 06:13:29 examplehost kernel: [771904.532555] NFS:
>>>> dentry_delete(/test.img, 48084c)
>>>>=20
>>>> Sep 19 06:13:41 examplehost kernel: [771916.540491] <--
>>>> nfs41_proc_async_sequence status=3D0
>>>>=20
>>>> Sep 19 06:13:41 examplehost kernel: [771916.540586] encode_sequence:
>>>> sessionid=3D61:1568410703:305419896:61 seqid=3D7 slotid=3D0 max_slotid=3D=
0
>>>> cache_this=3D0
>>>>=20
>>>> Sep 19 06:13:41 examplehost kernel: [771916.541182]
>>>> nfs41_sequence_process: Error 0 free the slot
>>>>=20
>>>> Sep 19 06:13:41 examplehost kernel: [771916.541186]
>>>> nfs41_sequence_call_done rpc_cred 000000004b01718a
>>>>=20
>>>> Sep 19 06:13:41 examplehost kernel: [771916.541187] <-- nfs41_sequence_=
call_done
>>>>=20
>>>> Sep 19 06:13:53 examplehost kernel: [771928.572599] <--
>>>> nfs41_proc_async_sequence status=3D0
>>>>=20
>>>> Sep 19 06:13:53 examplehost kernel: [771928.572675] encode_sequence:
>>>> sessionid=3D61:1568410703:305419896:61 seqid=3D8 slotid=3D0 max_slotid=3D=
0
>>>> cache_this=3D0
>>>>=20
>>>> Sep 19 06:13:53 examplehost kernel: [771928.572895] encode_sequence:
>>>> sessionid=3D61:1568410703:305419896:61 seqid=3D2 slotid=3D1 max_slotid=3D=
1
>>>> cache_this=3D1
>>>>=20
>>>> Sep 19 06:13:53 examplehost kernel: [771928.573163]
>>>> nfs41_sequence_process: Error 0 free the slot
>>>>=20
>>>> Sep 19 06:13:53 examplehost kernel: [771928.573166]
>>>> nfs41_sequence_call_done rpc_cred 000000004b01718a
>>>>=20
>>>> Sep 19 06:13:53 examplehost kernel: [771928.573167] <-- nfs41_sequence_=
call_done
>>>>=20
>>>> Sep 19 06:13:53 examplehost kernel: [771928.573236] decode_attr_type: t=
ype=3D00
>>>>=20
>>>> Sep 19 06:13:53 examplehost kernel: [771928.573238]
>>>> decode_attr_change: change attribute=3D6738121685800950864
>>>>=20
>>>> Sep 19 06:13:53 examplehost kernel: [771928.573240] decode_attr_size:
>>>> file size=3D8388608000
>>>>=20
>>>> Sep 19 06:13:53 examplehost kernel: [771928.573242] decode_attr_fsid:
>>>> fsid=3D(0x0/0x0)
>>>>=20
>>>> Sep 19 06:13:53 examplehost kernel: [771928.573243] decode_attr_fileid:=
 fileid=3D0
>>>>=20
>>>> Sep 19 06:13:53 examplehost kernel: [771928.573245]
>>>> decode_attr_fs_locations: fs_locations done, error =3D 0
>>>>=20
>>>> Sep 19 06:13:53 examplehost kernel: [771928.573246] decode_attr_mode:
>>>> file mode=3D00
>>>>=20
>>>>=20
>>>>=20
>>>> As you can see the NFS: release(/test.img) is immediately after all of
>>>> the writes on the successful version. In the version that gets stuck
>>>> it never responds with that =E2=80=9Crelease=E2=80=9D.
>>>>=20
>>>>=20
>>>>=20
>>>> It=E2=80=99s hard for me to do any debugging on the NFS Server sinces i=
ts more
>>>> of a =E2=80=9Cmanaged=E2=80=9D box (e.g I don=E2=80=99t have root and o=
nly have access to
>>>> certain debugging utilities). I do have a ticket open with Dell and
>>>> their engineering team is looking at this but I=E2=80=99m trying anythi=
ng I
>>>> can do to figure this out as soon as I can.
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>> Any help on this matter would be appreciated.
>>>=20
>=20
