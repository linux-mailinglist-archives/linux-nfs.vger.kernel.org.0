Return-Path: <linux-nfs+bounces-15083-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37453BC8C1D
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 391D64F8E85
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 11:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EC62C21F1;
	Thu,  9 Oct 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TczFVD15"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7BF2DA762
	for <linux-nfs@vger.kernel.org>; Thu,  9 Oct 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008815; cv=none; b=JjOzEauDKoQ51+VgY4LI6yHnSKQ0T50JIO4Sw/FIMjj/HtVKGoy7CQwEzCZ9Fzs2glB5rsPIgFOI+e67xtyHfDs7Gloe3MhniU8jfzNgBTrKqLzT0JKM61M8Kj9tDtm7TZC0moRXG3NKmew6pNqWiKLkDJysrLWSTyTee5KdHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008815; c=relaxed/simple;
	bh=chixwHNBiDI/7Ahxx1890nMCBqWqzPKJgLezla+n+WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dNQW4+3q1j/b1V9yz4tfUD2Ui871Z5sIyXi95eGkp77ppphaJa+JiCQ/dgfGi+MfsM/k74h39f2/3tL0J4o1vMIT7DPslr1psN/bKzUxS1YW4CpmRNE8yjiQZ3bTSKL/Lrw1W5YxrUwOjzD5ByC5qLXE992xJ4U56y52UHPaLI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TczFVD15; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so1611374a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 09 Oct 2025 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760008811; x=1760613611; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m52LPyiQeU9xuda9TFefWNUMlMf9cay/zE4j1brcuvQ=;
        b=TczFVD15Gt5R0v3x6EAjvlaL4DMuXhfK2q6l+dbx3sBgY3b3ohZL9N8/PSubKCi59p
         gdo5VaRKUtsJtdFMWJyFDimBUrIrFORVsT/mpujgZtjpC+0KUQ423aXUZpDQ8+eg6xKT
         kip73yoh6PJ4tKhdtYcppBWdeNQjum1mresbhWwyy1NwldgwN9Dof0lIPSH5vtkDKLPu
         jyHWJQUf/l/ziTPWjfkWS5R1c3eS81zgzQqYSo1bJJlDWo42cphBBbWR0UjGtNwqByCk
         U4unTribGxQo8bR/geH/ITjx60ITZCMSuzv82Vtd0wgSJD7RNDTx8n+jcSo3Mi1IMq3/
         Hr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760008811; x=1760613611;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m52LPyiQeU9xuda9TFefWNUMlMf9cay/zE4j1brcuvQ=;
        b=s3sz2+4yu7FMZn+1dGAJRcGIftUsOznUoIRTVKQD+1td1NqMztWSgKI7JqZtXRjyAe
         pxvmrvRb4jFw0TF82pytFfM1K1sIrxbm+Ekt+9L2NRVZTVpg1zhBo3vrQzZgZNTEKxKl
         4H9zOTnwGDEb8rpo3sBGj4naouXmsDOdmTC8sE5FI51B29mwFUqtOeQR+H4CIKqznH/r
         uTZFVrwS8SN++Id5fu6mmRtzSlhQkYWJ7vKXb8UFInh96j35Dzzbb+YEKUaM5/YI6EGE
         au4EY7oSDjLb0+ESS03ve90RYZQKfvg2PvyOr+TT6ahZCLiOvhDlElq8AWdVVykRcI/r
         H1hw==
X-Gm-Message-State: AOJu0YyavGPtziS0Le0huG7i54dT1wEvklggHQt7xvGvsKXjwXXtZjSh
	jDNjEzS6amgLN6Om0U0MF/WTH3rEnT7k7D55YeSxxfuiX7pNhUQiYT7UmNGB1dO8PdrLGsbf390
	jpQAdzNrLrfN6n5zQfdbSay2thoxm8tqhuUj6
X-Gm-Gg: ASbGncufnLI2grn1C1PCIVF0zEa5hC/g7r53yk3kmxNFuutuWXlE8cRZv6ffibzLJsg
	+tXbGCQ3bmxFxoVbIzEsKxc5KwkNS6SdEq9OWqu+AREBYYzJ4M+APYdUlugOTHgQLJoxGzEf5wp
	3N1ItSHYv5OjmdyHN2Mpm/64J39tkcpBgW8fay7P3Ebx/yOdCX9lBfZj0fNHEmIHcQuMNgfbTkb
	9cRKFUAINSTh/lQb9dteC+1Av/oW74=
X-Google-Smtp-Source: AGHT+IEhTQXtePbrsrBRv2yq78c8sMEbnMw0RiC4r4IKvTqMkcYXFg4EJy7D0Nq4ngt4vDnTxYq70lSJNI5hBIEtA6g=
X-Received: by 2002:a05:6402:2809:b0:639:c9c2:3956 with SMTP id
 4fb4d7f45d1cf-639d5c5a382mr6988008a12.28.1760008811329; Thu, 09 Oct 2025
 04:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQnWu8pcvEtRahV+Tvr5XxWpsBEOgWCSjn4ppnsJWGNr0A@mail.gmail.com>
In-Reply-To: <CAKAoaQnWu8pcvEtRahV+Tvr5XxWpsBEOgWCSjn4ppnsJWGNr0A@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Thu, 9 Oct 2025 13:19:00 +0200
X-Gm-Features: AS18NWAU3f-_1fmRYD1QQHoNf5_X4E6N88GGdEl9SGK_NMvpUXerG0Z2KAHfmYQ
Message-ID: <CANH4o6Nf8=THbEKsmfATJS5Mk=7iP31WoW8sDhfm==MqeaXx0w@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
 filesystem client Windows driver binaries for Windows 10/11+WindowsServer
 2019/2022 for testing, 2025-10-09 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
ARM64+AMD64+x86 and Windows Server 2019+2022/AMD64, but
interoperability feedback with NFSv4.1/NFSv4.2 servers based on Linux
6.6+ LTS and
6.17+ would be great.

News:
See announcement below; ARM64/aarch64 platform support was added,
xcopy.exe/cmd.exe copy/MS Explorer file copy acceleration via NFS
server side copies and copy-by-block-cloning are IMO the most
interesting new features (cloning now works with Linux nfsd exporting
btrfs or xfs filesystems, server side copy with all filesystems),
because it's "on" by default for all Windows 11 applications which
copy files, followed by wings.exe (Linux users read man sg(1)) with
powershell support.

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Thu, Oct 9, 2025 at 10:44=E2=80=AFAM
Subject: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
filesystem client Windows driver binaries for Windows
10/11+WindowsServer 2019/2022 for testing, 2025-10-09 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!


----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32bit x86, x86-64, ARM64),
Windows 11 (x86-64, ARM64)+Windows Server 2019/2022 (x86-64, ARM64),
based on https://github.com/kofemann/ms-nfs41-client (commit id
#1934011ecccd0a881c9a3806493af78aece2f4b8, git bundle in tarball), for
testing and feedback.

** FULL release readme:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20251009_09h50m_git1934011.readme
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20251009_09h50m_git1934011.html
(experimental HTML version)

** Download URL (all architectures+platforms):
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20251009_09h50m_git1934011.tar.bz=
2

** Download hash sums:
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20251009_09h50m_git193401=
1.html)=3D
c4e9ec9a224d7f93a7a76ef941ee50a5d013c889ea2da505ae53fc4486dcc7d8
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20251009_09h50m_git193401=
1.readme)=3D
4a407763c7f11144603394015b9b267e42c136d8a60866fc78870d3b20636a72
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20251009_09h50m_git193401=
1.tar.bz2)=3D
72d2908f6ebcb0e8b300c7dc105e1dd44098444ed06ca5430fb30ca73b118873

** Major changes since the last release:
- Window 11/ARM64 is now supported (native aarch64 kernel module and
nfs*.exe userland utilities)
- /sbin/nfs_globalmount, a new tool for Administrators to manage
global/machine-wide mounts which are available to all Windows
users/services/logons
- support for case-insensitive filesystems (e.g. Windows Server NTFS)
- NFS referrals now work with custom (non-TCP/2049) port numbers
- Implemented |FSCTL_OFFLOAD_READ|+|FSCTL_OFFLOAD_WRITE| (e.g. used by
Windows 10 xcopy, Windows Explorer etc) for server-side NFSv4.2 COPY
- Better FreeBSD 14 nfsd compatibility
- DFS service no longer needs to be disabled
- More software tested for compatibility: MariaDB, Microsoft Office
2016, Visual Studio 2022 work with msnfs41client
- Volume label is now the nfs://-URL to the server (up to 31
characters for Windows Explorer compatibility)
- Support for user and group names with non-ASCII (e.g. Unicode) names
(like German umlauts) in ms-nfs41-client, winsg.exe etc.
- winsg.exe now has a /P option to run powershell.exe with the requested gr=
oup
- nfs_mount.exe now enforces that normal mounts need nfs://-URLs with
absolute paths, and "public NFS" mounts need relative paths in a
nfs://-URL
- sec=3Dnone support
- Improved /sbin/cygwinaccount2nfs4account script to better handle
creation of Windows Domain accounts on the NFS server side
- *.(exe|dll) executables are now signed with a WDK test signature,
helping with *rare* cases that Windows Defender with paranoid settings
wrongly recognising the binaries as potential threads. A *.cer
certificate file is supplied which can be imported into the Windows
Defender to whitelist the binaries if this happens.
- Support for FSCTL_DUPLICATE_EXTENTS_TO_FILE, which allows Windows 11
applications which use |CopyFile2()| (like cmd.exe  copy, xcopy.exe
etc) to copy files via block cloning. Requires NFSv4.2 NFS server with
{ CLONE, SEEK, DEALLOCATE } support, exporting a filesystem which
supports block cloning (e.g. btrfs, xfs). This includes correct
cloning of sparse files.
- Sparse file support (requires NFSv4.2 server { SEEK, ALLOCATE,
DEALLOCATE } and the |FATTR4_WORD1_SPACE_USED| attr), including
hole/data range enumeration, punching holes etc., e.g. $ fsutil sparse
queryrange mysparsefile #
- Improved Windows Extended Attribute (EA) support (requires NFS >=3D
v4.1 server with "Named Attribute" support ("OPENATTR")), including
create/read/write/delete
- Improved WSL support
- Support for Storage32-API (e.g. enables use of *.msi installer files
on NFS filesystems)
- Cygwin /usr/bin/svn and Windows '/cygdrive/c/Program
Files/Git/cmd/git' now work
- Illumos NFSv4.2 server is now supported
- Solaris 11.4 NFSv4.1 server is now supported
- Windows Server 2022 NFSv4.1 server is now supported (compared to
WS2019 this NFS server version has ACL support)

** Please send comments, bugs, test reports, complaints etc. to the
MailMan mailing list at
https://sourceforge.net/projects/ms-nfs41-client/lists/ms-nfs41-client-deve=
l

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

