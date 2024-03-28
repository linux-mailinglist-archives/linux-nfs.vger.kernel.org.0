Return-Path: <linux-nfs+bounces-2549-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF14890C10
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 21:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C1F2A7959
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 20:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB3113A403;
	Thu, 28 Mar 2024 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFw63mUb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698C13A3E9
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659334; cv=none; b=SCjxrqlYSwzLVgz6xG+9zys3lnlNtO0GGlHRev7HAXOJHm/M25uSxj/Znkov/S/B4WLhEorPkF6a7xH3cJqc9lBDRbCbyGPJeELEDYMH3wwQhcwQgOsBYFJfvnqS189ZyOpo5dnVO0xu1CD/WyoV2UPwxiZJKkIITN4HRViulO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659334; c=relaxed/simple;
	bh=evHxNFhnrjqpetgo+C692k86dqxlcL+fI34Fx/eOI08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sPkCsIbFNaMhKy1ZkbML54bQWropUhdkXQH2K7uFO4t9gXiH5EJrZ9AHWFgBdNVmhno2lGJEbV1RetJjb4koH2JSvDKbPzWEWmXvK89Tpgiwi7aPz/8GD3K9It9EPfjIk0SJJGNPiCmQKy58fnEvCUw0futcjoW3JFCIzMzQ/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFw63mUb; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56c12c73ed8so1799144a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 13:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711659331; x=1712264131; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIM6hVcE9mpHZn5BqhgbP6p5qjW9b3WN2dTikhW9jaY=;
        b=eFw63mUbIo2qtjYVa8TXyjlRWlJin0Ghe8uuxexRkgYQB1TNhIubEDToVBYrfSInEw
         to/eh5Er4MU2IY+SXIL0FmtBuVmifja/H8NhNccoEaKdR1F6+3RTzb9eNF++CthiiL+6
         slUe+jEXqwKRu+Pg1wynhrMbL5JinEYAO6k1J8fr2TWXgma7HfZA1AEKiCIZTnYes6eP
         KQ503Qy5yvE0ZLWadT4XzAQjC8vQWYqxgqligXeCBtx1zq3aqxW8GOiPxxqGIx1GKijH
         SdQgqbyPdMlhIrCfCq2HvQmrj/cjJqJmRddao1NoixsT6dtGDOfYzaHR1wz0na04j0H0
         WpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711659331; x=1712264131;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIM6hVcE9mpHZn5BqhgbP6p5qjW9b3WN2dTikhW9jaY=;
        b=k++hHAIszaxmRh6oGQ8eNGFyKNp4+p4CEaims+eYeSmPTFVKtUT35sLVn4k+Sx+dwD
         qCrM8vfNfzGUWQBKedZmpJjQQPQx1Gx873ClOflLUbgBZpH0BTzbumXs+I6Yvp0gAIcB
         aWFwCGxc4eBwuYjCzB9mlNTlRxGaB75RUhMjkW589kOJTmisisr5URxnOk+lbVVIKA2A
         4bkNMN2mi9tTqGnK9HH9x79xwsr3PpQKW66g9JeD9hmmr1aJIx59qTz6HMb3PLMfhPrl
         pbe/uMjW4WSX0Be4n6I2xvaxVZy+vA8eSfePXwKDbq6v6xhpnyvki0iUcOJw8wUcWQJp
         ZoPQ==
X-Gm-Message-State: AOJu0YwQmOJMqhc91zcEZc1V+Rx9JeDJ+AhdcbnO9k2tHogVVnNtG3LN
	AfSos8b4vsepj4EuxQafAbr6l6sd1KBWlTQIRbb86YRoY6ytrVoPb5iXJuPV1xCas5R9GJxPKAs
	j7d8snl6hl/8HFQpOGzWannT+R8PdyHep3VI=
X-Google-Smtp-Source: AGHT+IEUnWrcl0JjE6rdeKWMohaXxGPrbBCFOuKFaGX4vutP6dTeOkmB/UOl7hu5vgLc1lWdeynJ3TBA4AwtDHEWhMs=
X-Received: by 2002:a17:906:361b:b0:a47:145c:e777 with SMTP id
 q27-20020a170906361b00b00a47145ce777mr280292ejb.28.1711659330543; Thu, 28 Mar
 2024 13:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQnRP9O8_1H90rd4yxtXVtYaEKJB6p3L++V5V14G+S5abw@mail.gmail.com>
In-Reply-To: <CAKAoaQnRP9O8_1H90rd4yxtXVtYaEKJB6p3L++V5V14G+S5abw@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Thu, 28 Mar 2024 21:55:18 +0100
Message-ID: <CANH4o6Oz3Tk5QLfFmABGia1VjvOexOPPFDp5aYLA6-=N0TtK=g@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] ANN: NFSv4.1 filesystem client Windows
 driver binaries for Windows 10/11 for testing, 2024-03-28 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Please test the binaries. The client is for Windows 10/11, but
compatibility feedback for Linux 6.6 stable and 6.8 would be great.

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Thu, Mar 28, 2024 at 1:20=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] ANN: NFSv4.1 filesystem client
Windows driver binaries for Windows 10/11 for testing, 2024-03-28 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!

----

I've created a set of test binaries for the NFSv4.1 filesystem client
driver for Windows 10/11, based on
https://github.com/kofemann/ms-nfs41-client (commit id
#4c9528a5e9094cd80906c0e8af9785e1748b0a25, git bundle in tarball), for
testing and feedback (download URL in "Download" section below).

Please send comments, bugs, test reports, complaints etc. to the
MailMan mailing list at
https://sourceforge.net/projects/ms-nfs41-client/lists/ms-nfs41-client-deve=
l

# 1. What is this ?
NFSv4.1 client and filesystem driver for Windows 10/11

# 2. Features:
- Full NFSv4.1 protocol support
- idmapper (mapping usernames and uid/gid values between server and
    client)
- Support for custom ports (NFSv4 defaults to TCP port 2049, this
    client can use different ports per mount)
- Support for nfs://-URL
    * Why ? nfs://-URLs are crossplatform, portable and Character-Encoding
      independent descriptions of NFSv4 server resources (exports).
    - including custom ports and raw IPv6 addresses
    - nfs://-URL conversion utility (/usr/bin/nfsurlconv) to convert
        URLs, including non-ASCII/Unicode characters in mount path
- Support ssh forwarding, e.g. mounting NFSv4 filesystems via ssh
    tunnel
- Support for long paths (up to 4096 bytes), no Windows MAXPATH limit
- Unicode support
- UNC paths
    - IPv6 support in UNC paths
    - /sbin/nfs_mount prints UNC paths in Win32+Cygwin formats
    - Cygwin bash+ksh93 support UNC paths, e.g.
      cd //derfwnb4966@2049/nfs4/bigdisk/mysqldb4/
- IPv6 support
    - IPv6 address within '[', ']'
      (will be converted to *.ipv6-literal.net)
- Windows ACLs
    - Win32 C:\Windows\system32\icacls.exe
    - Cygwin /usr/bin/setfacl+/usr/bin/getfacl
    - Windows Explorer ACL dialog
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
- Cygwin 3.5.1 (or 3.6.x-devel)
    - Packages (required):
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
        libiconv
        libiconv2
        pax
        pbzip2
        procps-ng
        sed
        tar
        time
        util-linux
        wget
    - Packages (recommended):
        libnfs (for /usr/bin/nfs-ls)
        make
        git
        dos2unix

# 4. Download:
$ mkdir -p ~/download
$ cd ~/download
$ wget 'http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/t=
esting/msnfs41client_cygwin_binaries_20240328_12h28m_git4c9528a.tar.bz2'
$ openssl sha256
"msnfs41client_cygwin_binaries_20240328_12h28m_git4c9528a.tar.bz2"
SHA2-256(msnfs41client_cygwin_binaries_20240328_12h28m_git4c9528a.tar.bz2)=
=3D
ff683f954109f344403ce7f54830c36827984a1fc999460aa7054a97ca6ad473

# 5. Installation (as "Administrator"):
$ (cd / && tar -xf
~/download/msnfs41client_cygwin_binaries_20240328_12h28m_git4c9528a.tar.bz2
)
$ /sbin/msnfs41client install
<REBOOT>

# 6. Deinstallation:
$ (set -o xtrace ; cd / && tar -tf
~/download/msnfs41client_cygwin_binaries_20240328_12h28m_git4c9528a.tar.bz2
| while read i ; do [[ -f "$i" ]] && rm "$i" ; done)
<REBOOT>

# 7. Usage:
# Run the NFSv4 client daemon:
# - run this preferably as "Administrator", but this is not a requirement
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
$ cd ~ && /sbin/nfs_mount -d N:
# OR
$ cd ~
$ net use N: /delete

# List mounted NFSv4.1 filesystems:
$ /sbin/nfs_mount

# 8. Notes:
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
- Workflow for nfs://-URLs:
  - Create nfs://-URLs with nfsurlconv, read $ nfsurlconv --man # for usage
  - pass URL to nfs_mount.exe like this:
    $ nfs_mount -o sec=3Dsys,rw 'L' nfs://derfwnb4966_ipv4//bigdisk #
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
  * Example 1 (assuming that Windows, Linux NFSv4 client and NFSv4
  server have a user "siegfried_wulsch"):
  - On Windows on a NFSv4 filesystem:
  $ icacls myhorribledata.txt /grant "siegfried_wulsch:WD" #
  - On Linux NFSv4 clients you will then see this:
  ---- snip ----
  $ nfs4_getfacl myhorribledata.txt
  A::OWNER@:rwatTcCy
  A::siegfried_wulsch@global.loc:rwatcy
  A::GROUP@:rtcy
  A::EVERYONE@:rtcy
  ---- snip ----
  * Example 2 (assuming that Windows, Linux NFSv4 client and NFSv4
  server have a group "cygwingrp2"):
  - On Windows on a NFSv4 filesystem:
  $ icacls myhorribledata.txt /grant "cygwingrp2:(WDAC)" /t /c #
  - On Linux NFSv4 clients you will then see this:
  ---- snip ----
  $ nfs4_getfacl myhorribledata.txt
  A::OWNER@:rwatTcCy
  A::GROUP@:rtcy
  A:g:cygwingrp2@global.loc:rtcy
  A::EVERYONE@:rtcy
  ---- snip ----
- nfs_mount.exe vs. reserved ports:
  By default the NFSv4 server on Solaris, Illumos, Linux
  etc. only accepts connections if the NFSv4 client uses a
  "privileged (TCP) port", i.e. using a TCP port number < 1024.
  If nfsd.exe/nfsd_debug.exe is started without the Windows priviledge
  to use reserved ports, then a mount attempt can fail.
  This can be worked around on the NFSv4 server side - on Linux using
  the "insecure" export option in  /etc/exports and on Solaris/Illumos
  using export option "resvport" (see nfs(5)).

# 9. Known issues:
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

# 10. Notes for troubleshooting && finding bugs/debugging:
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

# 11. Source code:
- Source code can be obtained from https://github.com/kofemann/ms-nfs41-cli=
ent
- Build instructions can be found at
  https://github.com/kofemann/ms-nfs41-client/tree/master/cygwin

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

