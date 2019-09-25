Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41FD0BE4FB
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2019 20:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfIYSt3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Sep 2019 14:49:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51732 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfIYSt3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Sep 2019 14:49:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8PImw8O116169;
        Wed, 25 Sep 2019 18:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=YudKhuNqdaXVAxHW84cIHlSDJO7pZUE41/Mp0qvaVvc=;
 b=Rwb+py/eZAcvKfHDdpGX8RI3QToeWvrQqO//9XPVnDp8GadTRV5Dn5+vSfeJOADL1WWH
 pS16AKWqIO0MA1UyVmFJmcCfhyqGHh/hsexAEjfrR9b/CPoulv7UrETLvt9vMPwHMfq4
 Bi8er8CIBBkzuBVHodbM0jqSxtH334hPNiwmKHMxWw7ulDrb6USkYuR/7e2VKsQXttgq
 XwLZ3GCT1iqODPeEEfFdbsBEtw2de6xF1Q0/GLhycbsRfxnypTNVv2HZkr/h5hHVGX+f
 YMwH/Z1pb6CAVYi6I47QHI4Qxky116lmLHTgagNMSK+/3HTQclgqVxfoq1GHPbIWcMTU Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v5cgr6nmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 18:49:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8PIn1YA011047;
        Wed, 25 Sep 2019 18:49:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2v7vnykg2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 18:49:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8PInHEW018614;
        Wed, 25 Sep 2019 18:49:17 GMT
Received: from [10.3.1.157] (/8.25.222.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Sep 2019 11:49:16 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: NFSv4 client locks up on larger writes with Kerberos enabled
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAMd28E-zcjuCfVbDCra4Av3Ewsdd-Ai=E0j3tF2GKJ8P6nG8=w@mail.gmail.com>
Date:   Wed, 25 Sep 2019 11:49:14 -0700
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FCAD9EFD-26AD-41F0-BCCA-80E475219731@oracle.com>
References: <CAMd28E-pJp4=kvp62FJqGLZo-jGA2rH2OT6-hK_N=TvMiJuT2A@mail.gmail.com>
 <20190925164831.GA9366@fieldses.org>
 <57192382-86BE-4878-9AE0-B22833D56367@oracle.com>
 <CAMd28E-zcjuCfVbDCra4Av3Ewsdd-Ai=E0j3tF2GKJ8P6nG8=w@mail.gmail.com>
To:     Kevin Vasko <kvasko@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909250159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909250159
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 25, 2019, at 11:44 AM, Kevin Vasko <kvasko@gmail.com> wrote:
>=20
> Appreciate the information. I have tried different clients. The Centos
> and Ubuntu clients exhibit the same issue. I also did packet tracing.
> On small files the client will go through its "WRITE..." packets...
> and then will issue COMMIT and then do the CLOSE. On larger files it
> will do all of its WRITE... packets and then will issue COMMIT and
> then it will never do a CLOSE. I'm assuming whats happening is the
> client is waiting for the NFS server to authenticate with the Kerberos
> server to make sure the write is okay, however I assume it never does.
> I would like to try and figure out how to see that "authentication"
> packet to kerberos from the server (if there is one).
>=20
> Just for giggles, I just tried it with NFSv3 and there is a slight
> change and gives a little more information (albeit, what I kind of
> already assumed). Mounted the shared with krb5p, and vers=3D3.
>=20
> I write a file with
> strace -f dd if=3D/dev/zero of=3D/data/test.img bs=3D10M count=3D1
>=20
> This is successful.  No issues. Just like NFSv4
>=20
> Then I change nothing but the size of the file being written (just
> like with NFSv4)=E2=80=A6however with NFSv3 it will halt for ~1 minute =
and
> then spit out a permission denied even though I just wrote out the
> SAME exact file in the SAME exact location (literally overwriting the
> file) a few seconds prior. The only difference in NFSv3 and NFSv4 is
> that NFSv3 fails with a permission issue, whereas NFSv4 never returns.

Sounds like the NFS server is dropping the connection. With
GSS enabled, that's usually a sign that the GSS window has
overflowed.


> strace -f dd if=3D/dev/zero of=3D/data/test.img bs=3D1000M count=3D1
>=20
> This command with NFSv3, takes ~1min and will return file permissions
> error (even though it just wrote it and can run the above command
> again and it will finish with no errors).
>=20
> This makes sense in that my initial suspicion is that the Dell Unity
> 300 isn=E2=80=99t authenticating properly with larger writes (for =
whatever
> reason) with Kerberos. This is also why I don=E2=80=99t see the =
problem when I
> disable Kerberos on the Unity 300 system.
>=20
> When should the NFS server be sending a packet to the Kerberos server
> to validate the write? Or should it be? I did do packet capture on the
> Unity box but I don=E2=80=99t see anything really useful regarding =
Kerberos
> authentication. What should I be looking for in the packet traces to
> look for the authentication packets?
>=20
> Debugging commands:
>=20
> $mount
>=20
> ...snip=E2=80=A6
>=20
> 10.75.37.2:/ds1 on /data type nfs
> =
(rw,relatime,vers=3D3,rsize=3D65536,wsize=3D65536,namlen=3D255,hard,proto=3D=
tcp,timeo=3D600,retrans=3D2,sec=3Dkrb5p,mountaddr=3D10.75.37.2,mountvers=3D=
3,mountport=3D1234,mountproto=3Dudp,local_lock=3Dnone,addr=3D10.75.37.2)
>=20
>=20
>=20
> $ time dd if=3D/dev/zero of=3D/data/test.img bs=3D10M count=3D1
> 1+0 records in
> 1+0 records out
> 10485760 bytes (10 MB, 10 MiB) copied, 0.112561 s, 93.2 MB/s
> real    0m0.188s
> user    0m0.000s
> sys     0m0.087s
>=20
> $ time dd if=3D/dev/zero of=3D/data/test.img bs=3D1000M count=3D1
> dd: closing output file '/data/test.img': Permission denied
> real    1m9.093s
> user    0m0.000s
> sys     0m1.124s
>=20
> $ strace -f dd if=3D/dev/zero of=3D/data/test.img bs=3D10M count=3D1
> execve("/bin/dd", ["dd", "if=3D/dev/zero", "of=3D/data/test.img",
> "bs=3D10M", "count=3D1"], 0x7ffec9914328 /* 30 vars */) =3D 0
> brk(NULL)                               =3D 0x5595514e6000
> access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
> access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or =
directory)
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
> fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D125550, ...}) =3D 0
> mmap(NULL, 125550, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f5e4e5d2000
> close(3)                                =3D 0
> access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
> openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", =
O_RDONLY|O_CLOEXEC) =3D 3
> read(3, =
"\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\34\2\0\0\0\0\0"...,
> 832) =3D 832
> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D2030544, ...}) =3D 0
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) =3D 0x7f5e4e5d0000
> mmap(NULL, 4131552, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
> 0) =3D 0x7f5e4dfd9000
> mprotect(0x7f5e4e1c0000, 2097152, PROT_NONE) =3D 0
> mmap(0x7f5e4e3c0000, 24576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e7000) =3D 0x7f5e4e3c0000
> mmap(0x7f5e4e3c6000, 15072, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7f5e4e3c6000
> close(3)                                =3D 0
> arch_prctl(ARCH_SET_FS, 0x7f5e4e5d1540) =3D 0
> mprotect(0x7f5e4e3c0000, 16384, PROT_READ) =3D 0
> mprotect(0x55954fd03000, 4096, PROT_READ) =3D 0
> mprotect(0x7f5e4e5f1000, 4096, PROT_READ) =3D 0
> munmap(0x7f5e4e5d2000, 125550)          =3D 0
> rt_sigaction(SIGINT, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], =
sa_flags=3D0}, 8) =3D 0
> rt_sigaction(SIGUSR1, {sa_handler=3D0x55954faf60e0, sa_mask=3D[INT =
USR1],
> sa_flags=3DSA_RESTORER, sa_restorer=3D0x7f5e4e017f20}, NULL, 8) =3D 0
> rt_sigaction(SIGINT, {sa_handler=3D0x55954faf60d0, sa_mask=3D[INT =
USR1],
> sa_flags=3DSA_RESTORER|SA_NODEFER|SA_RESETHAND,
> a_restorer=3D0x7f5e4e017f20}, NULL, 8) =3D 0
> brk(NULL)                               =3D 0x5595514e6000
> brk(0x559551507000)                     =3D 0x559551507000
> openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) =
=3D 3
> fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D11603728, ...}) =3D 0
> mmap(NULL, 11603728, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f5e4d4c8000
> close(3)                                =3D 0
> openat(AT_FDCWD, "/dev/zero", O_RDONLY) =3D 3
> dup2(3, 0)                              =3D 0
> close(3)                                =3D 0
> lseek(0, 0, SEEK_CUR)                   =3D 0
> openat(AT_FDCWD, "/data/test.img", O_WRONLY|O_CREAT|O_TRUNC, 0666) =3D =
3
> dup2(3, 1)                              =3D 1
> close(3)                                =3D 0
> mmap(NULL, 10498048, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
> -1, 0) =3D 0x7f5e4cac5000
> read(0, =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 10485760) =3D 10485760
> write(1, =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 10485760) =3D 10485760
> close(0)                                =3D 0
> close(1)                                =3D 0
> openat(AT_FDCWD, "/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) =
=3D 0
> fstat(0, {st_mode=3DS_IFREG|0644, st_size=3D2995, ...}) =3D 0
> read(0, "# Locale name alias data base.\n#"..., 4096) =3D 2995
> read(0, "", 4096)                       =3D 0
> close(0)                                =3D 0
> openat(AT_FDCWD,
> "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
> -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale/en_US.utf8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
> -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale/en.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D =
-1
> ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en_US.UTF-8/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en_US.utf8/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en_US/LC_MESSAGES/coreutils.mo", O_RDONLY)
> =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en.UTF-8/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en.utf8/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
> 0
> fstat(0, {st_mode=3DS_IFREG|0644, st_size=3D578, ...}) =3D 0
> mmap(NULL, 578, PROT_READ, MAP_PRIVATE, 0, 0) =3D 0x7f5e4e5f0000
> close(0)                                =3D 0
> write(2, "1+0 records in\n1+0 records out\n", 311+0 records in
> 1+0 records out
> ) =3D 31
> write(2, "10485760 bytes (10 MB, 10 MiB) c"..., 6010485760 bytes (10
> MB, 10 MiB) copied, 0.105735 s, 99.2 MB/s) =3D 60
> write(2, "\n", 1
> )                       =3D 1
> close(2)                                =3D 0
> exit_group(0)                           =3D ?
> +++ exited with 0 +++
>=20
>=20
>=20
> $ strace -f dd if=3D/dev/zero of=3D/data/test.img bs=3D1000M count=3D1
> execve("/bin/dd", ["dd", "if=3D/dev/zero", "of=3D/data/test.img",
> "bs=3D1000M", "count=3D1"], 0x7fff46397c58 /* 30 vars */) =3D 0
> brk(NULL)                               =3D 0x55a768f09000
> access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
> access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or =
directory)
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
> fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D125550, ...}) =3D 0
> mmap(NULL, 125550, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f604f357000
> close(3)                                =3D 0
> access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or =
directory)
> openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", =
O_RDONLY|O_CLOEXEC) =3D 3
> read(3, =
"\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\34\2\0\0\0\0\0"...,
> 832) =3D 832
> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D2030544, ...}) =3D 0
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) =3D 0x7f604f355000
> mmap(NULL, 4131552, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
> 0) =3D 0x7f604ed5e000
> mprotect(0x7f604ef45000, 2097152, PROT_NONE) =3D 0
> mmap(0x7f604f145000, 24576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e7000) =3D 0x7f604f145000
> mmap(0x7f604f14b000, 15072, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7f604f14b000
> close(3)                                =3D 0
> arch_prctl(ARCH_SET_FS, 0x7f604f356540) =3D 0
> mprotect(0x7f604f145000, 16384, PROT_READ) =3D 0
> mprotect(0x55a767990000, 4096, PROT_READ) =3D 0
> mprotect(0x7f604f376000, 4096, PROT_READ) =3D 0
> munmap(0x7f604f357000, 125550)          =3D 0
> rt_sigaction(SIGINT, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[], =
sa_flags=3D0}, 8) =3D 0
> rt_sigaction(SIGUSR1, {sa_handler=3D0x55a7677830e0, sa_mask=3D[INT =
USR1],
> sa_flags=3DSA_RESTORER, sa_restorer=3D0x7f604ed9cf20}, NULL, 8) =3D 0
> rt_sigaction(SIGINT, {sa_handler=3D0x55a7677830d0, sa_mask=3D[INT =
USR1],
> sa_flags=3DSA_RESTORER|SA_NODEFER|SA_RESETHAND,
> a_restorer=3D0x7f604ed9cf20}, NULL, 8) =3D 0
> brk(NULL)                               =3D 0x55a768f09000
> brk(0x55a768f2a000)                     =3D 0x55a768f2a000
> openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) =
=3D 3
> fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D11603728, ...}) =3D 0
> mmap(NULL, 11603728, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f604e24d000
> close(3)                                =3D 0
> openat(AT_FDCWD, "/dev/zero", O_RDONLY) =3D 3
> dup2(3, 0)                              =3D 0
> close(3)                                =3D 0
> lseek(0, 0, SEEK_CUR)                   =3D 0
> openat(AT_FDCWD, "/data/test.img", O_WRONLY|O_CREAT|O_TRUNC, 0666) =3D =
3
> dup2(3, 1)                              =3D 1
> close(3)                                =3D 0
> mmap(NULL, 1048588288, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f600fa4a000
> read(0, =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 1048576000) =3D 1048576000
> write(1, =
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 1048576000) =3D 1048576000
> close(0)                                =3D 0
> close(1)                                =3D -1 EACCES (Permission =
denied)
> openat(AT_FDCWD, "/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) =
=3D 0
> fstat(0, {st_mode=3DS_IFREG|0644, st_size=3D2995, ...}) =3D 0
> read(0, "# Locale name alias data base.\n#"..., 4096) =3D 2995
> read(0, "", 4096)                       =3D 0
> close(0)                                =3D 0
> openat(AT_FDCWD,
> "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
> -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale/en_US.utf8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
> -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale/en.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D =
-1
> ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en_US.UTF-8/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en_US.utf8/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en_US/LC_MESSAGES/coreutils.mo", O_RDONLY)
> =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en.UTF-8/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en.utf8/LC_MESSAGES/coreutils.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en/LC_MESSAGES/coreutils.mo", O_RDONLY) =3D
> 0
> fstat(0, {st_mode=3DS_IFREG|0644, st_size=3D578, ...}) =3D 0
> mmap(NULL, 578, PROT_READ, MAP_PRIVATE, 0, 0) =3D 0x7f604f375000
> close(0)                                =3D 0
> write(2, "dd: ", 4dd: )                     =3D 4
> write(2, "closing output file '/data/test."..., 36closing output file
> '/data/test.img') =3D 36
> openat(AT_FDCWD, "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/libc.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en_US.utf8/LC_MESSAGES/libc.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/libc.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en.UTF-8/LC_MESSAGES/libc.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY)
> =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en_US.UTF-8/LC_MESSAGES/libc.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en_US.utf8/LC_MESSAGES/libc.mo", O_RDONLY)
> =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en_US/LC_MESSAGES/libc.mo", O_RDONLY) =3D =
-1
> ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) =3D=

> -1 ENOENT (No such file or directory)
> openat(AT_FDCWD,
> "/usr/share/locale-langpack/en.utf8/LC_MESSAGES/libc.mo", O_RDONLY) =3D
> -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/share/locale-langpack/en/LC_MESSAGES/libc.mo",
> O_RDONLY) =3D -1 ENOENT (No such file or directory)
> write(2, ": Permission denied", 19: Permission denied)     =3D 19
> write(2, "\n", 1
> )                       =3D 1
> close(2)                                =3D 0
> exit_group(1)                           =3D ?
> +++ exited with 1 +++
>=20
> On Wed, Sep 25, 2019 at 12:06 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Sep 25, 2019, at 9:48 AM, bfields@fieldses.org wrote:
>>>=20
>>> On Wed, Sep 18, 2019 at 06:36:13PM -0500, Kevin Vasko wrote:
>>>> We have a new Dell EMC Unity 300 acting as NAS Server that is
>>>> presenting a NFSv4 NFS Share. Our clients are mostly Ubuntu 18.04.3
>>>> but issue is also present on CentOS 7.6 systems. We have been
>>>> struggling with this issue for over a week now and not sure how to
>>>> resolve it.
>>>>=20
>>>>=20
>>>>=20
>>>> We are having trouble with NFS Clients completing their writes to =
the
>>>> Dell EMC Unity 300 NFS Server when Kerberos is enabled on the NFS
>>>> Share. I created the NFS Share on the U300, associated it with our
>>>> FreeIPA (Kerberos/LDAP server) and everything shows successful.
>>>=20
>>> Troubleshooting ideas off the top of my head:
>>>=20
>>> It might be worth trying some other client versions if it's not =
hard.
>>>=20
>>> It'd be interesting to know what's happening on the network....
>>> Unfortunately big krb5p writes won't be fun to try to capture and
>>> examine.
>>=20
>> Wireshark is supposed to have a mechanism for giving it the keys
>> so that captured GSS data can be decrypted. I've never gotten it
>> to work, but I didn't try hard. Should be appropriately documented.
>>=20
>>=20
>>> Maybe some network or rpc-level statistics would help show if
>>> there are an unusual number of retries or failures.
>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20

--
Chuck Lever



