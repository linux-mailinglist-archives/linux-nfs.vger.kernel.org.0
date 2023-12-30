Return-Path: <linux-nfs+bounces-844-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6535782088E
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Dec 2023 22:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4032DB21ABF
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Dec 2023 21:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B05C2C6;
	Sat, 30 Dec 2023 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTkgURia"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CABC2E6
	for <linux-nfs@vger.kernel.org>; Sat, 30 Dec 2023 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dc018228b4so2247330a34.0
        for <linux-nfs@vger.kernel.org>; Sat, 30 Dec 2023 13:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703971489; x=1704576289; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTtnXzo465RCnYfU+ZWD7lz0JTIpEO0ZRaz3Ng+sGIY=;
        b=aTkgURia0GVWnY7RErcGAJXYZUvjAX2sW0Bjw1Vu0t+n32/RtiqWvOkZEJq2ygI3aB
         GbkoVTg/g/1r+DHuhTGz/tT1Fd7lujWQhLPtSrtYMZeWkZHUjHP95SQ8echcqi4fEwAQ
         EuuQQREnghpqJduMK8tRMGy5rKHbIDG3H977lyPVbiijIcaFaxy3tXCwJ8zZPyD8tkB7
         TJWGfsUOlIeD/grPHGO5/CXbFoyUaztVKxO0iM7IHUTrD8JynCJkXRSSe1UC+PiQXCBq
         /PmjNDyQRKKoQFLneabdWoRArAk2oILI4M7jlA+2o8ehB5OvGe1O5AQchnVmiNsAhNvY
         6SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703971489; x=1704576289;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTtnXzo465RCnYfU+ZWD7lz0JTIpEO0ZRaz3Ng+sGIY=;
        b=Vjr4PGl37Eiv7qa24wZOnmh4SVJ8K6Su666NlqbEinhzWup4nGXkq5K2lJP/PZDSxl
         HDWok+oG8TOTkFrP5tjhB/8W/6W/GnMHB5Q3mQKabOwTDLBT9KvMlh2BYJbeFahpZl4P
         9pSG21OJRlpvMGKFEkZkkbtPo9S4FfWrdUgVjifAo9APxWuAXiqJ71svUpTWc/LVpppl
         /+4ztE1kQkGKAlNKpFltiFnqa5cAfmHhiQ6vjbxi6kvY0EUwrQiDbqTo2ctdKRP5n8D+
         VveisTBP8JovEguyzKI1292lQUbeiR8bn3m4cd0C72uod+LIAR0KOgNSWdQdlin55kzE
         lKsw==
X-Gm-Message-State: AOJu0YzfNSWw6azEEPCpsCkG5RXMbyhMD/yJOAEJ0Ooqbd2UHNmIsJOC
	ipXM3mIP1JCAd6BIEx/EUdOSJp7OZrcqK9Uld5VYLx0P
X-Google-Smtp-Source: AGHT+IEgvvCnVrdpd9jLPGdyxKhr5OTH6gi8ySYzD8usJ0xcMrZx2F746zLyTOv1OH71XjHhJpOaNHGf851rwpFSJOo=
X-Received: by 2002:a05:6871:68d:b0:204:44fa:95e4 with SMTP id
 l13-20020a056871068d00b0020444fa95e4mr16252984oao.71.1703971488900; Sat, 30
 Dec 2023 13:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQkVgYiSYhJDhRm5KY5TA6Q8chtwh5PpP=tt-o-TZoRF8w@mail.gmail.com>
In-Reply-To: <CAKAoaQkVgYiSYhJDhRm5KY5TA6Q8chtwh5PpP=tt-o-TZoRF8w@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Sat, 30 Dec 2023 22:24:37 +0100
Message-ID: <CANH4o6N2kBSa7sb72O93N0_twAgXZWqXW659e21YxqLyxQn_aw@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] ANN: NFSv4.1 Windows driver binaries for
 Windows 10 for testing, 2023-12-30 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Please test the binaries

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Sat, Dec 30, 2023 at 4:34=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] ANN: NFSv4.1 Windows driver binaries
for Windows 10 for testing, 2023-12-30 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!

----

I've created a set of test binaries for the NFSv4.1 filesystem driver
for Windows, based on https://github.com/kofemann/ms-nfs41-client
(commit id #43852f547ce80b3b33bb05c2e993e322d2264dfa), for testing and
feedback (download URL below).
Please send comments, bugs, test reports, complaints etc. to
https://sourceforge.net/projects/ms-nfs41-client/lists/ms-nfs41-client-deve=
l

# 1. Requirements:
- Windows 10 (64bit, without SecureBoot!!)
- Cygwin 3.5.0
(Install in Cygwin setup.exe, Install with checkboxes "Testing" and "Sync")
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
esting/msnfs41client_cygwin_binaries_20231230_14h12m_git43852f5.tar.bz2'
$ (cd / && tar -xf
~/download/msnfs41client_cygwin_binaries_20231230_14h12m_git43852f5.tar.bz2
)
$ /sbin/msnfs41client install


# 3. Deinstallation:
$ (set -x ; cd / && tar -tf
~/download/msnfs41client_cygwin_binaries_20231230_14h12m_git43852f5.tar.bz2
| while read i ; do [[ -f "$i" ]] && rm "$i" ; done)


##
## Usage
##

# Run the NFSv4 client daemon:
# - run this preferably as "Adminstrator", but this is not a requirement
# - requires separate terminal
$ /sbin/msnfs41client run_daemon

# Mount a filesystem and use it
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
  Add "nfsd.exe", "nfsd_debug.exe", ksh93.exe, bash.exe, git.exe and
  other offending commands to process name whitelist.

- performance: Use vmxnet3 in VMware to improve performance

- ACLs are supported via the normal Windows ACL tools, but on
  Linux require the nfs4_getfacl/nfs4_setfacl utilties to see the
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


#
# Known issues:
#
- The kernel driver ("nfs41_driver.sys") does not have a cryptographic
  signature for SecureBoot - which means it will only work if SecureBoot
  is turned off (otherwise $ /sbin/msnfs41client install # will FAIL!)
- If nfsd_debug.exe crashes or gets killed, the only safe way
  to run it again requires a reboot
- LDAP support does not work yet
- Attribute caching is to agressiv, making $ tail -f ... # not seeing
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

