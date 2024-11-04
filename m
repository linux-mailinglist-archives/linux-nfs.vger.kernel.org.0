Return-Path: <linux-nfs+bounces-7658-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BFA9BBECA
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 21:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B08281491
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 20:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE38F1D3194;
	Mon,  4 Nov 2024 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQP0AfRX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362141CCEFA
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752092; cv=none; b=EtgmwnW/ySUhEMRjzJM9+NWwF5nAnRc1ECGDzBrV28zboFJMvyzWMYPJHceTuleV30tfGdoY0qDvX9cvri3EQYoMfwWdNHn0pOX7eHBy2TSGMP/O/BeNolKEeifcz9d8YyKhjzO2m9w/aUNA0X+JkxcwBC57J266m7FCJgLyD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752092; c=relaxed/simple;
	bh=gvBchEKmlj39GZeIpeEHszQc0CcuJn74Wtq0r1MGEQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=oCpVQ39I7l265JIdFIygo6D9KaIkfcZhLCmDBMMOULPcCIhmy/OmtxiytVCzZBlm2zxJikcWhbw5Sv5VUAta8JF+RpfDXgMfmZ/mZB1ejg0q4HZgSjbPx91sZNkk0uDO0Ilh4ve4YjCceT2bnEm56zIDck2ckCzXS4KpclA5Z4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQP0AfRX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cec93719ccso3067599a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 04 Nov 2024 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730752088; x=1731356888; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUnlCzEbKROe4Hq1Two5pZJl2pZE2D+SDqNWlxIkr2A=;
        b=gQP0AfRXNi/tUgkI7lp5MJJz5IgT+2x4m2COnvjOeoFBsEjxclOCv/0ELBvFzX5+1v
         qhXkg+UHix5sJegNIDAStZ7wJWGsaYOnrJUqTLRzldKNZM/EM0Di0P56CSbf88VFKF1U
         ccBnP8dJZZxt0WHg2A6K7hBAhLXSC2F2IWla/Kt6rU/Di+v6o6VfsR+WiT1KZIPz0uCA
         5BbLHBZpcCF7ET7zMwuK1+j+H28MqmHkFTSrtI/ZxLXDA5MSPn82kxe2gHyS4dXzcC/8
         tPkESX8CQQJjgAyXnRwi584m53UtwanOfH8/xLkudoFo35BeRjciFfPU2J2rxj9PS8su
         ur8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730752088; x=1731356888;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUnlCzEbKROe4Hq1Two5pZJl2pZE2D+SDqNWlxIkr2A=;
        b=Y+70pMTX8PCBG++ZWkP7uh/vaIaW+MCsLrj2yhUncqjccc9dmzavLxSr8a9U6jho2B
         bUrQoyaQzGoCb99DmLwLaRvsWpjeKbTR6KEJqvVWOz8wdkyaIVUmGVD/h4hCmVWGVy0M
         y8awsx7s8nvzkyN67try48a3Y5gyiyqoI+kn/YO7KaAOii/tffrecHrngGHUZ4/3YlyV
         3dXimGon1/mDT0+tDRMTVicOQHLWz+JXMq9fKLaGtfSRKytCJAsaewy++7IN3mK1shBV
         PPQ52hNm1Q87iZh5uOWg7ykd9Yhy1g//0Z74azhPEBWEKPoiiZP6282cTBijPWlXkxmz
         Xg9g==
X-Gm-Message-State: AOJu0Yy8LrDK+zr+Obkqtqttpcml761WfS4hduodVoG0h3hX5fKFEkQg
	XzB656AKEtkbALahpyzxnWZsy0V41L9vlmaFT7crIwXe3xGvINDb4Ioxrx7LW9pQGiHC+4UOCWg
	wCZ95dyXWLuakn1VlRSdEYS87B3rv+3mL
X-Google-Smtp-Source: AGHT+IHTmmCfp7f14yJkbCmnQeOyx2c6CtxS0IV6XaoPdMN/oTpeb4RriBBub0KbSFtn+e78ScAwdHhk3ZjG/7iQKC0=
X-Received: by 2002:a17:907:728d:b0:a9a:cc8a:b281 with SMTP id
 a640c23a62f3a-a9e3a573cfbmr1902342566b.3.1730752087524; Mon, 04 Nov 2024
 12:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQkWqC65obyBJGvGm0hsCyWDtTinz5b7wBtWdT5vGFG48A@mail.gmail.com>
In-Reply-To: <CAKAoaQkWqC65obyBJGvGm0hsCyWDtTinz5b7wBtWdT5vGFG48A@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Mon, 4 Nov 2024 21:27:00 +0100
Message-ID: <CANH4o6PKzBh2MOQF5By1LzcybAdEb+vUUdnGwvXUs8zNJb2f0g@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] ANN: NFSv4.1 filesystem client Windows
 driver binaries for Windows 10/11+WindowsServer 2019 for testing, 2024-11-04 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Please test the binaries. The NFSv4.1 client is for Windows 10/11
AMD64+x86 and Windows Server 2019/AMD64, but interoperability feedback
with NFS servers based on Linux 6.6 LTS and 6.12+ would be great.

News:
- Added support for Windows server 2019 AMD64
- Cygwin interoperability fixes
- WSL (Windows Services for Linux) support
- Machine-wide mounts useable by all users (if mounted by user
SYSTEM), e.g. DOS device letter H: can refer to /home, and then
H:\mwege is the same as /home/mwege/
- Support for nfs:// urls in nfs_mount.exe to make like of Windows admins e=
asier
- new Windows/Cygwin /sbin/cygwinaccount2nfs4account tool to convert
the Win32 account information of the (current) user SID+groups SIDs to
a small POSIX/bash script for the NFSv4 server to set-up these
accounts on the server side (assuming no ActiveDirectory/LDAP setup).
Currently Linux only, but support for FreeBSD+Solaris/Illumos is coming soo=
n
- More work has been done to deal with Linux nfsd ACL bugs+workarounds for =
those
- Many fixes for winsg.exe (which runs Windows applications with a
different group, akin /bin/newgrp or /bin/sg (Linux))
- Fixes for Win32 32bit applications on Windows 64bit kernels
- Support for Windows Server 2019 NFS4.1 nfsd
[https://learn.microsoft.com/en-us/windows-server/storage/nfs/nfs-overview#=
nfs-version-41]

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, Nov 4, 2024 at 1:13=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] ANN: NFSv4.1 filesystem client
Windows driver binaries for Windows 10/11+WindowsServer 2019 for
testing, 2024-11-04 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!

----

We've created a set of test binaries for the NFSv4.1 filesystem client
driver for Windows 10/11+Windows Server 2019, based on
https://github.com/kofemann/ms-nfs41-client (commit id
#ff72667deb07da4636f67352ff8a84ce0bc3c3f4, git bundle in tarball), for
testing and feedback (download URL in "Download" section below).

Please send comments, bugs, test reports, complaints etc. to the
MailMan mailing list at
https://sourceforge.net/projects/ms-nfs41-client/lists/ms-nfs41-client-deve=
l

# 1. What is this ?
NFSv4.1 filesystem driver for Windows 10/11&Windows Server 2019

# 2. Features:
- Full NFSv4.1 protocol support
- idmapper (mapping usernames and uid/gid values between server and
    client)
- Support for custom ports (NFSv4 defaults to TCP port 2049, this
    client can use different ports per mount)
- Support for nfs://-URLs
    * Why ? nfs://-URLs are crossplatform, portable and Character-Encoding
      independent descriptions of NFSv4 server resources (exports).
    - including custom ports and raw IPv6 addresses
    - nfs://-URL conversion utility (/usr/bin/nfsurlconv) to convert
        URLs, including non-ASCII/Unicode characters in mount path
- Support ssh forwarding, e.g. mounting NFSv4 filesystems via ssh
    tunnel
- Support for long paths (up to 4096 bytes), no Windows MAXPATH limit
- Unicode support
    - File names can use any Unicode character supported by
      the NFS server's filesystem.
    - nfs://-URLs can be used to mount filesystems with non-ASCII
      characters in the mount path, independent of current locale.
- UNC paths
    - Mounting UNC paths without DOS driver letter
    - IPv6 support in UNC paths
    - /sbin/nfs_mount prints UNC paths in Win32+Cygwin formats
    - Cygwin bash+ksh93 support UNC paths, e.g.
      cd //derfwnb4966@2049/nfs4/bigdisk/mysqldb4/
- WSL support
    - Mount Windows NFSv4.1 shares via driver letter or UNC path
      in WSL via mount -t drvfs
    - Supports NFS owner/group to WSL uid/gid mapping
- IPv6 support
    - IPv6 address within '[', ']'
      (will be converted to *.ipv6-literal.net)
- Windows ACLs <---> NFSv4 ACL translation
    - Win32 C:\Windows\system32\icacls.exe
    - Cygwin /usr/bin/setfacl+/usr/bin/getfacl
    - Windows Explorer ACL dialog
- Support for NFSv4 public mounts (i.e. use the NFSv4 public file handle
    lookup protocol via $ nfs_mount -o public ... #)
- Support for NFSv4 referrals
    - See Linux export(5) refer=3D option, nfsref(5) or
        https://docs.oracle.com/cd/E86824_01/html/E54764/nfsref-1m.html
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
- Windows 10 (32bit or 64bit), Windows 11 or Windows Server 2019
- Cygwin:
    - Cygwin versions:
        - 64bit: >=3D 3.5.3 (or 3.6.x-devel)
        - 32bit: >=3D 3.3.6
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
        libnfs-utils (for /usr/bin/nfs-ls)
        make
        bmake
        git
        gcc-core
        gcc-g++
        clang
        mingw64-i686-clang
        mingw64-x86_64-clang
        dos2unix
        unzip
        bison
        cygport
        libiconv-devel

# 4. Download and install Cygwin (if not installed yet):
# Windows 32bit-vs.-64bit can be tested from Windows cmd.exe console:
# Run this command:
# ---- snip ----
echo %PROCESSOR_ARCHITECTURE%
# ---- snip ----
# If this returns "AMD64" then you have a Windows 64bit kernel, and
# if it returns "x86" then you have Windows 32bit kernel.
# If you get any other value then this is a (documentation) bug.

- Cygwin 64bit can be installed like this:
# ---- snip ----
# Install Cygwin 64bit on Windows 64bit with packages required by
"ms-nfs41-client"
# (Windows NFSv4.1 client):
# 1. Create subdir
mkdir download
cd download
# 2. Get installer from https://cygwin.com/setup-x86_64.exe
curl --remote-name "https://www.cygwin.com/setup-x86_64.exe"
# 3. Run installer with these arguments:
setup-x86_64.exe -q --site
"https://mirrors.kernel.org/sourceware/cygwin" -P
cygwin,cygwin-devel,cygrunsrv,cygutils,cygutils-extra,bash,bzip2,coreutils,=
getent,gdb,grep,hostname,less,libiconv,libiconv2,pax,pbzip2,procps-ng,sed,t=
ar,time,util-linux,wget,libnfs-utils,make,bmake,git,dos2unix,unzip
# ---- snip ----

- Cygwin 32bit can be installed like this:
# ---- snip ----
# Install Cygwin 32bit on Windows 32bit with packages required by
"ms-nfs41-client"
# (Windows NFSv4.1 client):
# 1. Create subdir
mkdir download
cd download
# 2. Get installer from https://www.cygwin.com/setup-x86.exe
curl --remote-name "https://www.cygwin.com/setup-x86.exe"
# 3. Run installer with these arguments:
setup-x86.exe --allow-unsupported-windows -q --no-verify --site
"http://ctm.crouchingtigerhiddenfruitbat.org/pub/cygwin/circa/2022/11/23/06=
3457"
-P cygwin,cygwin-devel,cygrunsrv,cygutils,cygutils-extra,bash,bzip2,coreuti=
ls,getent,gdb,grep,hostname,less,libiconv,libiconv2,pax,pbzip2,procps-ng,se=
d,tar,time,util-linux,wget,libnfs-utils,make,bmake,git,dos2unix,unzip
# ---- snip ----

# 5. Download "ms-nfs41-client" installation tarball:
#
# (from a Cygwin terminal)
$ mkdir -p ~/download
$ cd ~/download
$ wget 'http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/t=
esting/msnfs41client_cygwin_binaries_20241104_11h21m_gitff72667.tar.bz2'
$ openssl sha256
"msnfs41client_cygwin_binaries_20241104_11h21m_gitff72667.tar.bz2"
SHA2-256(msnfs41client_cygwin_binaries_20241104_11h21m_gitff72667.tar.bz2)=
=3D
fa8bb45da297b706bb711ca58ff4a1c3571b259b98025522e543c9ae2064a5c7

# 6. Installation (as "Administrator"):
#
$ (cd / && tar -xf
~/download/msnfs41client_cygwin_binaries_20241104_11h21m_gitff72667.tar.bz2
)
$ /sbin/msnfs41client install
<REBOOT>

# 7. Deinstallation:
$ (set -o xtrace ; cd / && tar -tf
~/download/msnfs41client_cygwin_binaries_20241104_11h21m_gitff72667.tar.bz2
| while read i ; do [[ -f "$i" ]] && rm "$i" ; done)
<REBOOT>

# 8. Usage:
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
#   needs to do a separare nfs_mount.exe to mount a NFSv4 share.
#   The exception are mounts created by user "SYSTEM", such mounts
#   are available to all users/logons.
#   (see PsExec or function "su_system" in msnfs41client.bash how
#   to run a process as user "SYSTEM")
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
$ sc config ms-nfs41-client-service start=3Dauto
# - Start service manually (default):
$ sc config ms-nfs41-client-service start=3Ddisabled

# Option b)
# Run the NFSv4 client daemon manually:
#
# - run this preferably as "Administrator", but this is not a requirement
# - requires separate terminal
$ /sbin/msnfs41client run_daemon

# Mount a filesystem to drive N: and use it
$ /sbin/nfs_mount -o rw N 10.49.202.230:/net_tmpfs2
Successfully mounted '10.49.202.230@2049' to drive 'N:'
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
$ cd ~ && /sbin/nfs_umount N:
# OR
$ cd ~
$ net use N: /delete

# Mount a filesystem WITHOUT a dos drive assigned and use it via UNC path
$ /sbin/nfs_mount -o rw 10.49.202.230:/net_tmpfs2
Successfully mounted '10.49.202.230@2049' to drive
'\\10.49.202.230@2049\nfs4\net_tmpfs2'
$ cygpath -u '\\10.49.202.230@2049\nfs4\net_tmpfs2'
//10.49.202.230@2049/nfs4/net_tmpfs2
$ cd '//10.49.202.230@2049/nfs4/net_tmpfs2'
$ ls -la
total 4
drwxrwxrwt 5 Unix_User+0      Unix_Group+0      100 Dec  7 14:17 .
dr-xr-xr-x 1 roland_mainz     Kein                0 Dec 14 13:48 ..
drwxr-xr-x 3 Unix_User+197608 Unix_Group+197121  80 Dec 12 16:24 10492030
drwxr-xr-x 3 Unix_User+197608 Unix_Group+197121  60 Dec 13 17:58 directory_=
t
drwxr-xr-x 3 Unix_User+197608 Unix_Group+197121  60 Dec  7 11:01 test2

# Unmount filesystem:
$ cd ~ && /sbin/nfs_umount '\\10.49.202.230@2049\nfs4\net_tmpfs2'
# OR
$ cd ~
$ net use '\\10.49.202.230@2049\nfs4\net_tmpfs2' /delete

# List mounted NFSv4.1 filesystems:
$ /sbin/nfs_mount

# Global/System-wide mounts:
Mounts created by user "SYSTEM" are useable by all users in a system.
Example usage:
---- snip ----
# Create a file /etc/fstab.msnfs41client, which list the mounts
# which should be available system-wide
$ cat /etc/fstab.msnfs41client
nfs://[fe80::21b:1bff:fec3:7713]//bigdisk       V       nfs     rw
 0       0
# run "ms-nfs41-client-globalmountall-service", which runs
# /sbin/mountall_msnfs41client as user "SYSTEM" to read
# /etc/fstab.msnfs41client and mount the matching filesystems
sc start ms-nfs41-client-globalmountall-service
---- snip ----

BUG: Note that "ms-nfs41-client-globalmountall-service" currently
does not wait until nfsd*.exe is available for accepting mounts.


# WSL usage:
Example 1: Mount Windows NFSv4.1 share via Windows driver letter
# Mount NFSv4.1 share in Windows to driver letter 'N':
---- snip ----
$ /sbin/nfs_mount -o rw 'N' nfs://10.49.202.230//bigdisk
Successfully mounted '10.49.202.230@2049' to drive 'N:'
---- snip ----

# Within WSL mount driver letter 'N' to /mnt/n
---- snip ----
$ sudo bash
$ mkdir /mnt/n
$ mount -t drvfs N: /mnt/n
---- snip ----

Example 2: Mount Windows NFSv4.1 share via UNC path:
# Mount NFSv4.1 share in Windows
---- snip ----
$ /sbin/nfs_mount -o rw nfs://10.49.202.230//bigdisk
Successfully mounted '10.49.202.230@2049' to drive
'\\10.49.202.230@2049\nfs4\bigdisk'
---- snip ----

# Within WSL mount UNC path returned by /sbin/nfs_mount
---- snip ----
$ sudo bash
$ mkdir /mnt/bigdisk
$ mount -t drvfs '\\10.49.202.230@2049\nfs4\bigdisk' /mnt/bigdisk
---- snip ----

* Known issues with WSL:
- Softlinks do not work yet
- Creating a hard link returns "Invalid Argument", maybe drvfs
  limitation
- Not all POSIX file types (e.g. block devices) etc. are supported

# 9. Notes:
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
  # ---- snip ----
  $ nfs4_getfacl myhorribledata.txt
  A::OWNER@:rwatTcCy
  A::siegfried_wulsch@global.loc:rwatcy
  A::GROUP@:rtcy
  A::EVERYONE@:rtcy
  # ---- snip ----
  * Example 2 (assuming that Windows, Linux NFSv4 client and NFSv4
  server have a group "cygwingrp2"):
  - On Windows on a NFSv4 filesystem:
  $ icacls myhorribledata.txt /grant "cygwingrp2:(WDAC)" /t /c #
  - On Linux NFSv4 clients you will then see this:
  # ---- snip ----
  $ nfs4_getfacl myhorribledata.txt
  A::OWNER@:rwatTcCy
  A::GROUP@:rtcy
  A:g:cygwingrp2@global.loc:rtcy
  A::EVERYONE@:rtcy
  # ---- snip ----
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
  NFSv4 client source TCP port will be >=3D 1024.
- Install: Adding Windows accounts+groups to the NFSv4 server:
  ms-nfs41-client comes with /sbin/cygwinaccount2nfs4account to
  convert the Win32/Cygwin account information of the (current)
  user+groups to a small script for the NFSv4 server to set-up
  these accounts on the server side.

# 10. Known issues:
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
- File access timestamps might be wrong for delegations.
- Extended attributes are supported with some limitations:
  a) the server must support NFS Named Attributes,
  b) the order of listings cannot be guaranteed by NFS, and
  c) the EaSize field cannot be reported for directory queries of
  FileBothDirInformation, FileFullDirInfo, or FileIdFullDirInfo.
- Win10/32bit-only: $ net use H: /delete # does not work,
  use $ nfs_umount 'H' instead #
- Bug: Subversion checkout can fail with
  "sqlite[S11]: database disk image is malformed" like this:
  # ---- snip ----
  $ svn --version
  svn, version 1.14.2 (r1899510)
    compiled May 20 2023, 11:51:30 on x86_64-pc-cygwin
  $ svn checkout https://svn.FreeBSD.org/base/head/share/man
  A    man/man4
  A    man/man4/tcp.4
  A    man/man4/ndis.4
  A    man/man4/Makefile
  A    man/man4/altq.4
  A    man/man4/miibus.4
  A    man/man4/vlan.4
  A    man/man4/ng_macfilter.4
  A    man/man4/mn.4
  A    man/man4/ossl.4
  A    man/man4/ktls.4
  A    man/man4/ftwd.4
  A    man/man4/inet6.4
  A    man/man4/crypto.4
  A    man/man4/rtsx.4
  A    man/man4/isp.4
  svn: E200030: sqlite[S11]: database disk image is malformed
  svn: E200042: Additional errors:
  svn: E200030: sqlite[S11]: database disk image is malformed
  svn: E200030: sqlite[S11]: database disk image is malformed
  svn: E200030: sqlite[S11]: database disk image is malformed
  # ---- snip ----
  Workaround is to mount the NFS filesystem with the "writethru"
  option, e.g.
  $ /sbin/nfs_mount -o rw,writethru 'j' derfwpc5131:/export/home/rmainz #
- Windows event log can list errors like "MUP 0xc0000222"
  (|STATUS_LOST_WRITEBEHIND_DATA|) in case the disk on the NFSv4 server
  is full and outstanding writes from a memory-mapped file fail.
  Example:
  ---- snip ----
  {Fehler beim verzoegerten Schreibvorgang} Nicht alle Daten fuer die
  Datei "\\34.159.25.153@2049\nfs4\export\nfs4export\gcc\lto-dump.exe"
  konnten gespeichert werden. Daten gingen verloren.
  Dieser Fehler wurde von dem Server zurueckgegeben, auf dem sich die
  Datei befindet. Versuchen Sie, die Datei woanders zu speichern.
  ---- snip ----
- Bug: Native Windows git (NOT cygwin /usr/bin/git) clone fails
  like this:
  # ---- snip ----
  $ '/cygdrive/c/Program Files/Git/cmd/git' --version
  git version 2.45.2.windows.1
  $ '/cygdrive/c/Program Files/Git/cmd/git' clone
https://github.com/kofemann/ms-nfs41-client.git
  Cloning into 'ms-nfs41-client'...
  remote: Enumerating objects: 6558, done.
  remote: Counting objects: 100% (318/318), done.
  remote: Compressing objects: 100% (172/172), done.
  remote: Total 6558 (delta 191), reused 233 (delta 141), pack-reused
6240 (from 1)
  Receiving objects: 100% (6558/6558), 2.43 MiB | 4.66 MiB/s, done.
  fatal: premature end of pack file, 655 bytes missing
  warning: die() called many times. Recursion error or racy threaded death!
  fatal: fetch-pack: invalid index-pack output
  # ---- snip ----
  Workaround is to mount the NFS filesystem with the "writethru"
  OR "nocache" option, e.g.
  $ /sbin/nfs_mount -o rw,writethru 'j' derfwpc5131:/export/home/rmainz #

# 11. Notes for troubleshooting && finding bugs/debugging:
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
  # ---- snip ----
  $ nfsv4port=3D2049 ; /cygdrive/c/Program\ Files/Wireshark/tshark \
    -f "port $nfsv4port" -d "tcp.port=3D=3D${nfsv4port},rpc" -i Ethernet0
  # ---- snip ----
  If you are running inside a VMware VM on a Linux host it
  might require $ chmod a+rw /dev/vmnet0 # on VMware host, so that
  the VM can use "Promiscuous Mode".

# 12. Source code:
- Source code can be obtained from https://github.com/kofemann/ms-nfs41-cli=
ent
- Build instructions can be found at
https://github.com/kofemann/ms-nfs41-client/tree/master/cygwin

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

