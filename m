Return-Path: <linux-nfs+bounces-853-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D07EA8215EB
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jan 2024 00:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0D8B20FCE
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jan 2024 23:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EEFEAC2;
	Mon,  1 Jan 2024 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FW8+7pa4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E33DE56A
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jan 2024 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dc025dd9a9so3183546a34.1
        for <linux-nfs@vger.kernel.org>; Mon, 01 Jan 2024 15:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704151570; x=1704756370; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1dQU9q7iSKNp0a+oOG+LwAeCdhymo2xMOh3lKGhxo4=;
        b=FW8+7pa4NerqpY9zL3nIs2W1h9EgpsXuJx4AVKs4jWQqtcKWnGD/sQ7Evrc4wBzjXs
         GC2KjqwrLQofRTxYHyty61M9Nw5g7LUmRxcNqmf7jV7kP2qfelC7rza2cDY4VPgNCHxr
         fa7DfztL8mN0OBVmzBKwEs2dxUavWiPy6YraO00m1VKaLwtBL1YFIYszheIqPJMU3Xkg
         hCVSMss0xCcClSFQuQxmJ0R8f5KBBSUzIEwdv/4Yzx5TeGAUMSJ4hPXtqMaF5FvrtVLp
         VpUQokHKav3ttw2Wtulu/5+lmKT4xq1mn3iwh3jJRRdz9Bi8VlRaSsjXIpTzQ83cQzqV
         FWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704151570; x=1704756370;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1dQU9q7iSKNp0a+oOG+LwAeCdhymo2xMOh3lKGhxo4=;
        b=m829YmDDulb0hjsiM7qFNpySiDX7ssmEKQk/gNj3W3knVz9lAUmX5u0yLnsZETmmwG
         crp4muxW2fXO25D2tj5fb8FhLJl0Admx7Dgcg906ZrTJfSigBhw33jxcNvXQAhgtF4LQ
         OYeJTIPbJhYUXB8Ff/r91cgRDNErN30+vVrRIAr2O0WPdGKP/1TD3LE7XpKViTGzgGJu
         A2WN5QeiJDbTAzdH10MdLwtk9muPMpye2ZQu03zKB88zMj9GujoyuzzC+dqMbIRA0ztw
         u3SiZd6TWe1PfasNjUk8TU3lu5TS0V+iNNg46h4lUAjnYGA8Hfk3rb5mx4XXcpEtKdpo
         oufw==
X-Gm-Message-State: AOJu0YzpX+eT6GcCDNISpTpciyueQWZhnwNc7u4B6uOatafjExfX06e8
	M5JuAizHrt0X3f+0UFGphhDV+ANRCjreD1Pcjzx6i6f06p4=
X-Google-Smtp-Source: AGHT+IGFFLn0b4juLGLQ2WzSnWAXSk//qpG9oxCFC4d96BeArAj0Y5Vow08gpGfk2FwDGllXKuXKVPohdPk/fbdcT6c=
X-Received: by 2002:a05:6870:a693:b0:203:416c:d2dc with SMTP id
 i19-20020a056870a69300b00203416cd2dcmr20102175oam.45.1704151570014; Mon, 01
 Jan 2024 15:26:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQ=q6USo3CB6dmnmsPAhuaXQ1q2ZYK7+GA7gLBZ1yA968w@mail.gmail.com>
In-Reply-To: <CAKAoaQ=q6USo3CB6dmnmsPAhuaXQ1q2ZYK7+GA7gLBZ1yA968w@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Tue, 2 Jan 2024 00:25:00 +0100
Message-ID: <CANH4o6OqQFK0znnq2jjDqp5-YHnikuiOfdvZRwiS6m4WpbLQhA@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] ANN: NFSv4.1 Windows driver binaries for
 Windows 10/11 for testing, 2024-01-01 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Please test the binaries

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, Jan 1, 2024 at 10:47=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] ANN: NFSv4.1 Windows driver binaries
for Windows 10/11 for testing, 2024-01-01 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!

----

I've created a set of test binaries for the NFSv4.1 filesystem driver
for Windows 10/11, based on
https://github.com/kofemann/ms-nfs41-client (commit id
#43852f547ce80b3b33bb05c2e993e322d2264dfa + patches which should fix
the VC runtime issues, git bundle in tarball), for testing and
feedback (download URL below).

Please send comments, bugs, test reports, complaints etc. to the
MailMan mailing list at
https://sourceforge.net/projects/ms-nfs41-client/lists/ms-nfs41-client-deve=
l

# 1. Requirements:
- Windows 10
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


# 2. Installation (as "Administrator"):
$ mkdir -p ~/download
$ cd ~/download
$ wget 'http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/t=
esting/msnfs41client_cygwin_binaries_20240101_22h08m_git683af48.tar.bz2'
$ (cd / && tar -xf
~/download/msnfs41client_cygwin_binaries_20240101_22h08m_git683af48.tar.bz2
)
$ /sbin/msnfs41client install


# 3. Deinstallation:
$ (set -x ; cd / && tar -tf
~/download/msnfs41client_cygwin_binaries_20240101_22h08m_git683af48.tar.bz2
| while read i ; do [[ -f "$i" ]] && rm "$i" ; done)


##
## Usage
##

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


#
# Notes:
#
- Idmapping (including uid/gid mapping) between NFSv4 client and NFSv4
  server works via /lib/msnfs41client/cygwin_idmapper.ksh, which
  either uses builtin static data, or /usr/bin/getent passwd and
  /usr/bin/getent group.
  As getent uses the configured name services it should work with LDAP
  too.
  This is still work-in-progress, with the goal that both NFSv4 client
  and server can use different uid/gid numeric values for client and
  server side.

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
  Add "nfsd.exe", "nfsd_debug.exe", "ksh93.exe", "bash.exe", "git.exe"
  and other offending commands to the process name whitelist.

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
  etc. only accepts connections if the NFSv4 client uses a "privileged
  (TCP) port", i.e. a port number < 1024.
  This can be worked around by using the "insecure" export option in
  Linux /etc/exports, which allows connections from ports >=3D 1024,
  and for Solaris/Illumos see nfs(5), option "resvport".

#
# Known issues:
#
- The kernel driver ("nfs41_driver.sys") does not have a cryptographic
  signature for SecureBoot - which means it will only work if SecureBoot
  is turned off (otherwise $ /sbin/msnfs41client install # will FAIL!)
- If nfsd_debug.exe crashes or gets killed, the only safe way
  to run it again requires a reboot
- LDAP support does not work yet
- Attribute caching is to aggressive, making $ tail -f ... # not seeing
  new data.
  Workaround: Use GNU tail'S $ tail --follow=3Dname ... #
- krb5p security with AES keys do not work against the linux server,
  as it does not support gss krb5 v2 tokens with rotated data.
- When recovering opens and locks outside of the server's grace period,
  client does not check whether the file has been modified by another
  client.
- If nfsd.exe is restarted while a drive is mapped, that drive needs
  to be remounted before further use.
- Does not allow renaming a file on top of an existing open file.
  Connectathon's special test op_ren has been commented out.
- Extended attributes are supported with some limitations:
  a) the server must support NFS Named Attributes,
  b) the order of listings cannot be guaranteed by NFS, and
  c) the EaSize field cannot be reported for directory queries of
  FileBothDirInformation, FileFullDirInfo, or FileIdFullDirInfo.

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


_______________________________________________
Ms-nfs41-client-devel mailing list
Ms-nfs41-client-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ms-nfs41-client-devel

