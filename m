Return-Path: <linux-nfs+bounces-1529-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E048400F2
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 10:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212FD1C2258C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 09:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D0354F86;
	Mon, 29 Jan 2024 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGHbUZ4+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F73754F8A
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519418; cv=none; b=AwtAmt0WYXNGMCXLMFloLZuIEwujg/VNNTQLRSs3f2/yBt391FlPQkpC76HxTs1/g0FIttCZjszXbf0O7maBcY0+IDTg4MmwXynjvIfl5a05o1w1MUxdk30CSLAz0D9r5KB0GzR5OBq7oPoZAggKEJXjWfbEyHlCvfqTQn0GdyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519418; c=relaxed/simple;
	bh=onwYBDbTlly64HNwNVDHwfeovxReKM7moQNS/ThCgf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=kQWUvJdNtscqLSHZau5WLStLfjcvvoymrwGdn+OF0l4JGYjzHVFcIoJiakvxLoDgVf6StAXYj4vdDQZq4/a/Da3tD9/qeAbEHz1Kt5w+n1kAgPtxVI/kvYFtgIunG8UFgxRrPQCR04e82UjxmEfcWhIDzVDabow1me+ly3/6yBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGHbUZ4+; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2143a96d185so589475fac.3
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 01:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706519415; x=1707124215; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS9yZ5ikU77fXmwbn+LlLxjzQmsUgKOvInxJj3B8mTk=;
        b=DGHbUZ4+U0B7ovPTv4KtpW7E7JecpifVTaqY/HUU3ZatVgzG4xWNgwRCeSNwXJSyTZ
         Cixj5F145y/sgn8bPN2jt0NvGK0F12HxKWyQpNXdiQEvZ44NgxCwv/D3qjPLTqFkPA4x
         kTpP0VozO3ta/HmgsgUT312ne9SBg0kbF4RIfICK08ErlJ2krCxyOzWTVPsZHrNTOwGV
         sG4Af5hRzopiUSuvDlrHnQ8oU7gUJDiYtLvGpv25orUHSvJRMBQL420/s8htq3cOM8O5
         swiSYpwSBaytt2cDmzh5HWZehbaCLlbaQezDnbG3xrC6sKVCgAg8zjtzBWvno3NSlr9/
         X2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519415; x=1707124215;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uS9yZ5ikU77fXmwbn+LlLxjzQmsUgKOvInxJj3B8mTk=;
        b=bPpK38N9Xsdu39y03RXRC+Uexi/Vm1YRwuyJJHPNC5Enohu915PaNVVEGS8b6Otoi1
         +odqlwh12QWqwDhljP6jzqOmqkCyuWPnwF2Ouc+h2lQtbcOSRC85x2ZNuFbcIqOIl+Q0
         2Zrxo2UbL/x3hze33hUoR2iLYY7++hMNtt3ONLdx9Vu0qadbwGTmeBMEJ96diNzx4EBL
         Ld3uMyEy9mybj13+HAnHlNbxJmxxly0+DKCqsGFDTzIpaZk1cQ2GCEcUEFlQRPKBtn9b
         3nJztPsxykk/Fj97vML1W+AbofkAF16I0gfpIFK/LmgnBYxp1nva42j/zkbiH1x/lYhU
         WBmw==
X-Gm-Message-State: AOJu0Yzw7sbiu0IFj3EDfpfbDx7Qa8vVbHHiSxhqge5t+jdubyPKB4Qw
	tlUa5kMmMGHpDysJeEcnTgpVqEF8S4Q5W1YIDME7dymaO+69VHfjH68G1NdeDXlCM7/egwQMLsD
	w9E4gOSFDneKlFuzExratEWnu31AKNd5FRIM=
X-Google-Smtp-Source: AGHT+IEIElLNgerlz+y8vMurRKl7SNyWS3axWdauTW3RjgNWs14OtOc/seABSi4duGgfQXgEvuJVFcOY8FfgyMJA2yg=
X-Received: by 2002:a05:6870:d8cd:b0:210:ccdb:7cb0 with SMTP id
 of13-20020a056870d8cd00b00210ccdb7cb0mr1779010oac.7.1706519414970; Mon, 29
 Jan 2024 01:10:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmF2_iQtSdyTvk0ayLPqSXpLt0d_NFNHUwL90hGrYRgSA@mail.gmail.com>
 <CAKAoaQnsgn+wE02qReVqq5NtwL6t-GdAkfv-EU5zoGZfQb1LjQ@mail.gmail.com>
In-Reply-To: <CAKAoaQnsgn+wE02qReVqq5NtwL6t-GdAkfv-EU5zoGZfQb1LjQ@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Mon, 29 Jan 2024 10:09:00 +0100
Message-ID: <CANH4o6P-x8ku-hrNH5Ryz++1hE35JKHPM-5WXWn5pQPC3o8gRQ@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] NFSv4.1 filesystem client Windows driver
 binaries for Windows 10/11 for testing, 2024-01-28 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Please test the binaries

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Sun, Jan 28, 2024 at 11:54=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] NFSv4.1 filesystem client Windows
driver binaries for Windows 10/11 for testing, 2024-01-28 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!

----

I've created a set of test binaries for the NFSv4.1 filesystem client
driver for Windows 10/11, based on
https://github.com/kofemann/ms-nfs41-client (commit id
#38817b806bc146316c193954bfbfdc2209a7b3c6, git bundle in tarball), for
testing and feedback (download URL in "Installation" section below).

Please send comments, bugs, test reports, complaints etc. to the
MailMan mailing list at
https://sourceforge.net/projects/ms-nfs41-client/lists/ms-nfs41-client-deve=
l

# 1. What is this ?
NFSv4.1 filesystem client driver for Windows 10/11

# 2. Features:
- Full NFSv4.1 protocol support
- idmapper (mapping usernames and uid/gid values between server and
    client)
- Support for custom ports (NFSv4 defaults to TCP port 2049, this
    client can use different ports per mount)
- Support for nfs://-URL, including custom ports and raw IPv6
    addresses
- Support ssh forwarding, e.g. mounting NFSv4 filesystems via ssh
    tunnel
- Support for long paths (up to 4096 bytes), no Windows MAXPATH limit
- Unicode support
- UNC paths
    - IPv6 support in UNC paths
- IPv6 support
    - IPv6 address within '[', ']'
      (will be converted to *.ipv6-literal.net)
- Windows ACLs
- SFU/Cygwin support, including:
    - uid/gid
    - Cygwin symlinks
- Software compatibility:
    - Any NFSv4.1 server (Linux, Solaris, Illumos, FreeBSD, nfs4j,
        ...)
    - All tools from Cygwin/MinGW
    - Visual Studio
    - VMware Workstation (can use VMs hosted on NFSv4.1 filesystem)

# 3. Requirements:
- Windows 10 or Windows 11
- Cygwin 3.5.0
    - Packages:
        cygwin
        cygwin-devel
        cygrunsrv
        cygutils
        cygutils-extra
        bash
        bzip2
        coreutils
        getent
        gdb
        grep
        hostname
        less
        pax
        pbzip2
        procps-ng
        sed
        tar
        time
        util-linux
        wget

# 4. Installation (as "Administrator"):
$ mkdir -p ~/download
$ cd ~/download
$ wget 'http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/t=
esting/msnfs41client_cygwin_binaries_20240128_17h08m_git38817b8.tar.bz2'
$ openssl sha256
msnfs41client_cygwin_binaries_20240128_17h08m_git38817b8.tar.bz2
SHA2-256(msnfs41client_cygwin_binaries_20240128_17h08m_git38817b8.tar.bz2)=
=3D
e449955c1ea9c99d30ec02b9126047f587b2780c47753f3286bc5f2b5f9e6164
$ (cd / && tar -xf
~/download/msnfs41client_cygwin_binaries_20240128_17h08m_git38817b8.tar.bz2
)
$ /sbin/msnfs41client install

# 5. Deinstallation:
$ (set -x ; cd / && tar -tf
~/download/msnfs41client_cygwin_binaries_20240128_17h08m_git38817b8.tar.bz2
| while read i ; do [[ -f "$i" ]] && rm "$i" ; done)

# 6. Usage:

# Run the NFSv4 client daemon:
# - run this preferably as "Administrator", but this is not a requirement
# - requires separate terminal
$ /sbin/msnfs41client run_daemon

# Mount a filesystem and use it
# - requires that NFSv4 server accepts connections from a TCP port
# number > 1024, which can be archived on Linux with the "insecure"
# export option in /etc/exports, or "resvport" on Solaris/Illumos
# (see nfs(5))
$ /sbin/nfs_mount -o rw N 10.49.20.110:/net_tmpfs2
Successfully mounted '10.49.20.110@2049' to drive 'N:'
$ cd /cygdrive/n/
$ ls -la
total 4
drwxrwxrwt 5 Unix_User+0      Unix_Group+0      100 Dec  7 14:17 .
dr-xr-xr-x 1 roland_mainz     Kein                0 Dec 14 13:48 ..
drwxr-xr-x 3 Unix_User+197608 Unix_Group+197121  80 Dec 12 16:24 10492030
drwxr-xr-x 3 Unix_User+197608 Unix_Group+197121  60 Dec 13 17:58 directory_=
t
drwxr-xr-x 3 Unix_User+197608 Unix_Group+197121  60 Dec  7 11:01 test2

# Unmount filesystem:
$ cd ~ && /sbin/nfs_mount -d N:
# OR
$ cd ~
$ net use N: /delete

# List mounted NFSv4.1 filesystems:
$ /sbin/nfs_mount


# 7. Notes:
- Idmapping (including uid/gid mapping) between NFSv4 client and
  NFSv4 server works via /lib/msnfs41client/cygwin_idmapper.ksh,
  which either uses builtin static data, or /usr/bin/getent passwd
  and /usr/bin/getent group.
  As getent uses the configured name services it should work with
  LDAP too.
  This is still work-in-progress, with the goal that both NFSv4
  client and server can use different uid/gid numeric values for
  client and server side.

- UNC paths are supported, after successful mounting /sbin/nfs_mount
  will list the paths in Cygwin UNC format.

- SIDs work, users with valid Windows accounts (see Cygwin idmapping
  above get their SIDs, unknown users with valid uid/gid values get
  Unix_User+id/Unix_Group+id SIDs, and all others are mapped
  to nobody/nogroup SIDs.

- Cygwin symlinks are supported, but might require
  $ fsutil behavior set SymlinkEvaluation L2L:1 R2R:1 L2R:1 R2L:1 #.
  This includes symlinks to UNC paths, e.g. as Admin
  $ cmd /c 'mklink /d c:\home\rmainz
\\derfwpc5131_ipv6@2049\nfs4\export\home2\rmainz' #
  and then $ cd /cygdrive/c/home/rmainz/ # should work

- performance: All binaries are build without any optimisation, so
  the filesystem is much slower than it could be.

- bad performance due to Windows Defender AntiVirus:
  Option 1:
  # disable Windows defender realtime monitoring
  # (requires Admin shell)
  powershell -Command 'Set-MpPreference -DisableRealtimeMonitoring 1'
  Option 2:
  Add "nfsd.exe", "nfsd_debug.exe", "ksh93.exe", "bash.exe",
  "git.exe" and other offending commands to the process name
  whitelist.

- performance: Use vmxnet3 in VMware to improve performance

- ACLs are supported via the normal Windows ACL tools, but on
  Linux require the nfs4_getfacl/nfs4_setfacl utilities to see the
  data.
  Example (assuming that Windows, Linux NFSv4 client and NFSv4
  server have a user "siegfried_wulsch"):
  - On Windows on a NFSv4 filesystem, :
  $ icacls myhorribledata.txt /grant "siegfried_wulsch:WD" #
  - On Linux NFSv4 clients you will then see this:
  ---- snip ----
  $ nfs4_getfacl myhorribledata.txt
  A::OWNER@:rwatTcCy
  A::siegfried_wulsch@global.loc:rwatcy
  A::GROUP@:rtcy
  A::EVERYONE@:rtcy
  ---- snip ----

- nfs_mount only works when the NFSv4 server allows connections from
  ports >=3D 1024, as Windows does not allow the Windows NFSv4 client
  to use a "privileged port" (i.e. TCP port number < 1024)).
  By default the NFSv4 server on Solaris, Illumos, Linux
  etc. only accepts connections if the NFSv4 client uses a
  "privileged (TCP) port", i.e. a port number < 1024.
  This can be worked around by using the "insecure" export option in
  Linux /etc/exports, which allows connections from ports >=3D 1024,
  and for Solaris/Illumos see nfs(5), option "resvport".


# 8. Known issues:
- The kernel driver ("nfs41_driver.sys") does not yet have a
  cryptographic signature for SecureBoot - which means it will only
  work if SecureBoot is turned off (otherwise
  $ /sbin/msnfs41client install # will FAIL!)

- If nfsd_debug.exe crashes or gets killed, the only safe way
  to run it again requires a reboot

- LDAP support does not work yet

- Attribute caching is too aggressive

- Caching in the kernel does not always work. For example
  $ tail -f ... # does not not see new data.
  Workaround: Use GNU tail'S $ tail --follow=3Dname ... #
  Working theory is that this is related to FCB caching, see
  |FCB_STATE_FILESIZECACHEING_ENABLED|, as the nfs41_driver.sys
  kernel module does not see the |stat()| syscalls. But $ tail -f ... #
  always works for a momemnt if something else opens the same file.

- Unmounting and then mounting the same filesystem causes issues
  as the name cache in nfsd*.exe is not flushed on umount, including
  leftover delegations.

- krb5p security with AES keys do not work against the linux server,
  as it does not support gss krb5 v2 tokens with rotated data.

- When recovering opens and locks outside of the server's grace
  period, client does not check whether the file has been modified
  by another client.

- If nfsd.exe is restarted while a drive is mapped, that drive needs
  to be remounted before further use.

- Does not allow renaming a file on top of an existing open file.
  Connectathon's special test op_ren has been commented out.

- Extended attributes are supported with some limitations:
  a) the server must support NFS Named Attributes,
  b) the order of listings cannot be guaranteed by NFS, and
  c) the EaSize field cannot be reported for directory queries of
  FileBothDirInformation, FileFullDirInfo, or FileIdFullDirInfo.


# 9. Notes for troubleshooting && finding bugs/debugging:
- nfsd_debug.exe has the -d option to set a level for debug
  output.
  Edit /sbin/msnfs41client to set the "-d" option.

- The "msnfs41client" script has the option "watch_kernel_debuglog"
  to get the debug output of the kernel module.

  Run as Admin: $ /sbin/msnfs41client watch_kernel_debuglog #

  Currently requires DebugView
  (https://learn.microsoft.com/en-gb/sysinternals/downloads/debugview)
  to be installed.

- Watching network traffic:
  WireShark has a command line tool called "tshark", which can be used
  to see NFSv4 traffic. As NFSv4 uses RPC you have to filter for RPC,
  and the RPC filter automatically identifies NFSv4 traffic on it's RPC
  id.
  Example for Windows:
  (for NFSv4 default TCP port "2049", replace "2049" with the
  desired port if you use a custom port ; use "ipconfig" to find the
  correct interface name, in this case "Ethernet0"):
  ---- snip ----
  $ nfsv4port=3D2049 ; /cygdrive/c/Program\ Files/Wireshark/tshark \
    -f "port $nfsv4port" -d "tcp.port=3D=3D${nfsv4port},rpc" -i Ethernet0
  ---- snip ----

  If you are running inside a VMware VM on a Linux host it
  might require $ chmod a+rw /dev/vmnet0 # on VMware host, so that
  the VM can use "Promiscuous Mode".

# EOF.

----

Bye,
Roland
--
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)


--
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)


_______________________________________________
Ms-nfs41-client-devel mailing list
Ms-nfs41-client-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ms-nfs41-client-devel

