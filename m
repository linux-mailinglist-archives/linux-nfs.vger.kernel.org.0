Return-Path: <linux-nfs+bounces-3456-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91708D2B3F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 05:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181051C21801
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 03:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6521DFDE;
	Wed, 29 May 2024 03:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwMShRUp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD53207
	for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716951791; cv=none; b=kBTMQn0P8qK8CmwGAPIgmIKs7/VWt9oMVgksEb7iaLDD94h8Y1PZ4si9VutjWTD19f65g9gBtfGvRoWnRDBSyOip/GqQLom9SodwxPDEWJFYPFxDopQPdoBdicM4RsW5lmpaC75yNPVIIL4Js7KsBBWALUneBJkwM0fJ5EeAwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716951791; c=relaxed/simple;
	bh=W9UnJm65lWm5fNO0HQTCcC5VA0aElnV0sUpAy8ALd94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ibU3oXd/CK2LtEoxycV+hzua0L9nzR3CxF/I/SB8SQ46B5bXDrCnXjYdoBt80d/DbbBbSVYZIsAnGP02TOwAhqzVPzkS4Q9fXZjhbxfnPc/QfsY0baq6s/mfxsG7nZ2yDUZmSxisdaun5xm7su8U23XOCCGO2B51BrRM98eJ74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwMShRUp; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-523b017a5c6so2078374e87.1
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2024 20:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716951786; x=1717556586; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ti7rhMzpm2O3Hc4EZ+Hovs+/OPB66MtoRRStkrGzpRk=;
        b=OwMShRUpuQKLUPdsXk+hJF6Tr8UoHH25X0n7zCny5BGqZdS56y+GrjP9j5bpalUN10
         Kah3+RTs+5AFzWegX0a7vJovJ2L/CVlkIXZK/UVZH4bJ3mJBLVCmZVcgjPCBIEco99rQ
         kXpRjYDY/e0CUWLkDcT0kioaYdZoHjLQLumb/FqLSH9bH7PyxQy1W8bs+dP4Xs3F2DWD
         3jAx1vJACmDUnlm1eGhI+0di3g6p+64QQ/7K3MqDjONndIR3UQwtpGv97Rg+UJc3qe16
         pceY65HYfvVIES84/Bqkf19JX2nOL53KmbWnmQNHNYBHn+BwEo+I0E9U6bddcEkRgDRT
         Y67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716951786; x=1717556586;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ti7rhMzpm2O3Hc4EZ+Hovs+/OPB66MtoRRStkrGzpRk=;
        b=YeSKnAjOGoDpzHSjWbPqhw3wUbSimwp/GPAsspoNXOHufaRUDh3ZUSqISVAWuI5F41
         VybO0Z+QzN5WxEspS60mr3APJFr/0gPuFPYOit07GDiTgJA9fyG5jMJI49wyRYa8WEWI
         Ao/qxsEd/hGx3/YvtMuNrm4o4MA/SNW0q1vQs1d73BIuYB5uNozjqyPSCR8abU52bAYH
         zG7e0kZWUydlSJBGwmoIAfkWXCFegU1gAB4i6Rw6NDuiPk5636/rEJR3IJPuIFlPXTaU
         GNeQlqIuz9BFly3Nj6zBumSkrY/iP+AsfT52K4G/RtLROjUfOcHbUM/Fm5uvwDnAPm/M
         g5DQ==
X-Gm-Message-State: AOJu0YytUB0zJtupGXmZTZ6sJ+nJ1/ENQPt7wUMiGKMhtNOxS2x5qZDl
	/YQXzF5Pi58/sPZOp+2q4Qu6eEdYTUDzeSdlwPrZ4WzmSpxi/pDY6UpNUlijFOmmAhbsV9WcjSK
	U7VeS8bhaFMplPXAbI4oUd2MGzrkIqipU
X-Google-Smtp-Source: AGHT+IHmzq0XB1Xixqp14yJB+UZugsDiOKvRSWFu75yZLwPaK+WpjYhiejJn9p8CzWfxERt//zKV9CW4mBNywaU/6/I=
X-Received: by 2002:ac2:57de:0:b0:523:af1f:89d9 with SMTP id
 2adb3069b0e04-529679319ccmr9432790e87.58.1716951785956; Tue, 28 May 2024
 20:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcCTWbU-ejURuUC0_xhcoU3GF+2jX28rV4+2cKgfO5Lqxg@mail.gmail.com>
 <619bbf23-dbfe-4c26-adb9-1cc89f3f22a2@redhat.com> <CAAvCNcCGhZ917yerEOMcEEj7+_Yz5by8en2F4Yr5zLk0iQEGjg@mail.gmail.com>
 <ee3805865e12f8ed2f82f7e99e33598f0bcc6667.camel@kernel.org>
In-Reply-To: <ee3805865e12f8ed2f82f7e99e33598f0bcc6667.camel@kernel.org>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Wed, 29 May 2024 05:02:00 +0200
Message-ID: <CAAvCNcD0MTwBthZE3KPAoG=_gsVY=tNS5D4K+UV6+9jMJPs1Og@mail.gmail.com>
Subject: Re: RFC2224 support in Linux /sbin/mount.nfs4?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 May 2024 at 13:28, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Fri, 2024-05-24 at 19:11 +0200, Dan Shelton wrote:
> > On Wed, 15 May 2024 at 23:46, Steve Dickson <steved@redhat.com> wrote:
> > >
> > > Hey!
> > >
> > > On 5/14/24 5:57 PM, Dan Shelton wrote:
> > > > Hello!
> > > >
> > > > Solaris, Windows and libnfs NFSv4 clients support RFC2224 URLs, which
> > > > provide platform-independent paths where resources can be mounted
> > > > from, i.e. nfs://myhost//dir1/dir2
> > > >
> > > > Could Linux /sbin/mount.nfs4 support this too, please?
> > > Why? What does it bring to the table that the Linux client
> > > does already do via v4... with the except, of course, public
> > > filehandles, which is something I'm pretty sure the Linux
> > > client will not support.
> >
> > This is NOT for Linux only. Every OS has its own system to describe
> > shares, and not all are compatible. URLs are portable.
> >
> > >
> > > So again why? WebNFS died with Sun... Plus RFC2224 talks
> > > about v2 and v3... How does it fit in a V4 world.
> >
> > This is NOT about WebNFS or SUN, this is to make the job of admins easier.
> >
>
> I think Steve is just trying to get at the use-case for this. Who is
> using nfs:// URLs in their environment, and why? IOW, how will adding
> this make things better?
>
> Then there are the more practical questions:
>
> - will this require kernel support? If I mount using a nfs:// URL,
> should I expect to see that in /proc/self/mounts, instead of a
> host:/export ?
>
> - do you need support for public filehandles? Those were largely
> ignored by most NFS implementors, including Linux. That opens an
> entirely separate can of worms.
>
> I'm happy to consider patches that add support for this (including
> documentation), but I'd need to understand why this is a material
> improvement over the traditional ":/" syntax.

One syntax across all platforms?

The ms-nfs41-client (ref below) has a parser in nfs_mount.exe, so I
think it would just plug into the existing /sbin/mount.nfs4

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd


---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Tue, 28 May 2024 at 18:58
Subject: [Ms-nfs41-client-devel] ANN: NFSv4.1 filesystem client
Windows driver binaries for Windows 10/11 for testing, 2024-05-28 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!

----

I've created a set of test binaries for the NFSv4.1 filesystem client
driver for Windows 10/11, based on
https://github.com/kofemann/ms-nfs41-client (commit id
#0cb44281d376cd6aa0e43a402153405b7b32ddd8, git bundle in tarball), for
testing and feedback (download URL in "Download" section below).

Please send comments, bugs, test reports, complaints etc. to the
MailMan mailing list at
https://sourceforge.net/projects/ms-nfs41-client/lists/ms-nfs41-client-devel

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
- Custom primary group support
    - Supports primary group changes in the calling process/thread
      (via |SetTokenInformation(..., TokenPrimaryGroup,...)|), e.g.
      if the calling process/threads switches the primary group
      in its access token then the NFSv4.1 client will use that
      group as GID for file creation.
    - newgrp(1)/sg(1)-style "winsg" utilty to run cmd.exe with
      different primary group, e.g.
      $ winsg [-] -g group [-c command | /C command] #
- Software compatibility:
    - Any NFSv4.1 server (Linux, Solaris, Illumos, FreeBSD, nfs4j,
        ...)
    - All tools from Cygwin/MinGW
    - Visual Studio
    - VMware Workstation (can use VMs hosted on NFSv4.1 filesystem)


# 3. Requirements:
- Windows 10 (32bit or 64bit) or Windows 11
- Cygwin:
    - Cygwin versions:
        - 64bit: >= 3.5.3 (or 3.6.x-devel)
        - 32bit: >= 3.3.6
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
        gcc-core
        gcc-g++
        clang
        mingw64-i686-clang
        mingw64-x86_64-clang
        dos2unix
        unzip


# 4. Download:
$ mkdir -p ~/download
$ cd ~/download
$ wget 'http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing/msnfs41client_cygwin_binaries_20240528_12h15m_git0cb4428.tar.bz2'
$ openssl sha256
"msnfs41client_cygwin_binaries_20240528_12h15m_git0cb4428.tar.bz2"
SHA2-256(msnfs41client_cygwin_binaries_20240528_12h15m_git0cb4428.tar.bz2)=
e3d7adeef8b28161410bb7095036043aa587190488bf9247a00b881c19dbcc0d


# 5. Installation (as "Administrator"):
$ (cd / && tar -xf
~/download/msnfs41client_cygwin_binaries_20240528_12h15m_git0cb4428.tar.bz2
)
$ /sbin/msnfs41client install
<REBOOT>


# 6. Deinstallation:
$ (set -o xtrace ; cd / && tar -tf
~/download/msnfs41client_cygwin_binaries_20240528_12h15m_git0cb4428.tar.bz2
| while read i ; do [[ -f "$i" ]] && rm "$i" ; done)
<REBOOT>


# 7. Usage:
# Option a)
# * Start NFSv4 client daemon as Windows service (requires
# "Adminstrator" account):

$ sc start ms-nfs41-client-service

# * Notes:
# - requires "Adminstrator" account, and one nfsd client daemon is
#   used for all users on a machine.
# - The "ms-nfs41-client-service" service is installed by default as
#   "disabled" and therefore always requires a "manual" start (e.g.
#   $ sc start ms-nfs41-client-service #)
# - note that DOS devices are virtualised per LSA Logon, so each Logon
#   needs to do a separare nfs_mount.exe to mount a NFSv4 share
# - nfsd_debug.exe will run as user "SYSTEM", but will do user
#   impersonation for each request
# - stopping the service will NOT unmount filesystems, and due to a
#   bug a reboot is required to restart and mount any NFSv4
#   filesystems again

# * Administration:
# - Follow new log messages:
$ tail -f '/var/log/ms-nfs41-client-service.log'
# - Query service status:
$ sc queryex ms-nfs41-client-service
# - Query service config:
$ sc qc ms-nfs41-client-service
# - Start service automatically:
# (nfsd_debug.exe will be started automagically, but mounts are
# not restored):
$ sc config ms-nfs41-client-service start=auto
# - Start service manually (default):
$ sc config ms-nfs41-client-service start=disabled


# Option b)
# Run the NFSv4 client daemon manually:
#
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
drwxr-xr-x 3 Unix_User+197608 Unix_Group+197121  60 Dec 13 17:58 directory_t
drwxr-xr-x 3 Unix_User+197608 Unix_Group+197121  60 Dec  7 11:01 test2

# Unmount filesystem:
$ cd ~ && /sbin/nfs_mount -d N:
# OR
$ cd ~
$ net use N: /delete

# List mounted NFSv4.1 filesystems:
$ /sbin/nfs_mount


# 8. Notes:
- Cygwin 32bit can be installed like this:
---- snip ----
# Install Cygwin 32bit on Windows 32 with packages required by "ms-nfs41-client"
# (Windows NFSv4.1 client):
# 1. Get installer from https://www.cygwin.com/setup-x86.exe
# 2. Run installer with these arguments:
setup-x86.exe --allow-unsupported-windows -q --no-verify --site
http://ctm.crouchingtigerhiddenfruitbat.org/pub/cygwin/circa/2022/11/23/063457
-P cygwin,cygwin-devel,cygrunsrv,cygutils,cygutils-extra,bash,bzip2,coreutils,getent,gdb,grep,hostname,less,libiconv,libiconv2,pax,pbzip2,procps-ng,sed,tar,time,util-linux,wget,libnfs,make,git,dos2unix,unzip
---- snip ----

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
    $ nfs_mount -o sec=sys,rw 'L' nfs://derfwnb4966_ipv4//bigdisk #

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
  the "insecure" export option in /etc/exports and on Solaris/Illumos
  using export option "resvport" (see nfs(5)).

- Accessing mounts from a VMware/QEMU/VirtualBox VM using NAT requires
  the the "insecure" export option in /etc/exports and on
  Solaris/Illumos using export option "resvport" (see nfs(5)), as the
  NFSv4 client source TCP port will be >= 1024.


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
  Workaround: Use GNU tail'S $ tail --follow=name ... #
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

- File access timestamps might be wrong for delegations.

- Extended attributes are supported with some limitations:
  a) the server must support NFS Named Attributes,
  b) the order of listings cannot be guaranteed by NFS, and
  c) the EaSize field cannot be reported for directory queries of
  FileBothDirInformation, FileFullDirInfo, or FileIdFullDirInfo.

- Win10/32bit-only: $ net use H: /delete # does not work,
  use $ nfs_mount -d 'H' instead #

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
  $ nfsv4port=2049 ; /cygdrive/c/Program\ Files/Wireshark/tshark \
    -f "port $nfsv4port" -d "tcp.port==${nfsv4port},rpc" -i Ethernet0
  ---- snip ----

  If you are running inside a VMware VM on a Linux host it
  might require $ chmod a+rw /dev/vmnet0 # on VMware host, so that
  the VM can use "Promiscuous Mode".

# 11. Source code:
- Source code can be obtained from https://github.com/kofemann/ms-nfs41-client

- Build instructions can be found at
https://github.com/kofemann/ms-nfs41-client/tree/master/cygwin

----

Bye,
Roland
--
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /==\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)


_______________________________________________
Ms-nfs41-client-devel mailing list
Ms-nfs41-client-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ms-nfs41-client-devel


-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

