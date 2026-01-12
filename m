Return-Path: <linux-nfs+bounces-17754-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 918D8D14584
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 18:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 106C53082FE9
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D6D376BC7;
	Mon, 12 Jan 2026 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1x7JlKG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68D430C35E
	for <linux-nfs@vger.kernel.org>; Mon, 12 Jan 2026 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237641; cv=none; b=YkAFbcqtRR74ZZNxIv6/j8dhYWWsmbSsVB6G9AEUNz3NoWSGSd3D5gWnA38gjx4eUjYTFgQAe4QM1nDH/OeBbm1Bm+V4Fieyvk096LR6KcPDiahxrLiuff7ye9Zsb8Ftwh4ZWd833NBUmpeCDsDMdxJZW9FBqrnfJsklIxM/KZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237641; c=relaxed/simple;
	bh=ORP9fu9hnmn1attsezJPhF2UpAS2UsF7OL3mTpACml0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SXCxvnwN+qArfVEaNhafVp9LLRWeVWvBaf238Ez71QFJpSKhLpOEwMtxiGttiLXHvVSPyLYGGHpuI+BBNeSTOrvZNEvfuRI8CPKSya4Eb3I+JIdaiTOQyWt69M+aRG7c1xz/U4V/7GQNu0WEc1/Pbu2DabTVoSbhRDXFRYmaczE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1x7JlKG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8715a4d9fdso166586566b.0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jan 2026 09:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768237638; x=1768842438; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84SbeOtD+TvMtLVsw4ByQCJt1Hto7piM99bLKRQ7Tf4=;
        b=c1x7JlKGNdKfWfBQGUhsVow6g3NAYHyTNRDTFg5CQfqe3DoIAgQJ6F6I9jZ3Clzn4r
         0pVrsl0ktb81PWJbaELYWTuNh2+7FTrAlBYpVu+RODBZKbHOZ4GpbKEfGy30NSizFQH4
         sk5687Ui+9zuW0n+RHiFVBD6iso+1dSB5kB6nk8CFJWabQo3ZULPn+OnXLAY6n+jpFUA
         QuV0AURNfPSxBUo7TSmNEa/UzUUFKtgL05bwnnIVISOwtlNkNl6aEMCqHC12gABVQOmC
         +ggJ859i1ZLfQHCNGLAYw/HKzEH0U5DdwGScbSnZbhyvdsFDOTl1khqQMFbtikXgcvqS
         bkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768237638; x=1768842438;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=84SbeOtD+TvMtLVsw4ByQCJt1Hto7piM99bLKRQ7Tf4=;
        b=kcbYL/ATtZvQIPIuFYBgGPP7GZSZvdBbv5L0g0AdtV6qWS1F+gERyP8UnGscrFA3wX
         rZoT4lzZftdGzDWuTbYps0THNx/bOvIIWe7xoLJu6Sh3TFnbu2X2LdM21Y/WK5w4H2/B
         G2DprHtFfNlHRL6JH9rQImPR2/4qHuwNaz/OOlEZaX/08BFJF/tkweY9k2MxE4F5DIaM
         b4mLHvcFeJqy014LQNZSmgwC26nSPuUi6JOLF7/bzlh0LbdCVN6KZlAlTTTfLt2tUc4V
         qZ0PPiqBK5tBqxqNCBNDXkzWq00rePYV5N4XfHVa54CZZ4Rzkm/TVHyXtAkx3lzqI2qu
         iNdg==
X-Gm-Message-State: AOJu0Yypw3eqvNrjPgzHggLoJvuzPEUmAs2Qm3JwyLAC901D6bULi6ci
	d5luH3StujF4I5qT9cNpORDLycLx5RdJ3j+Yelo6ztA7x0gCi0S6NBWrTFU4/VO+0D2Z1FH1fjG
	f0ZKFW/42rWaWzLIDY5Fxa8Md96JOk/QTb8QS
X-Gm-Gg: AY/fxX7CzvidOr8o4C3A6FdGnAy207WNum+Aq/CUBLtntqh41ubfDRvKTEgKyiVeB72
	D/7Lk2ER1sLGnI05W/1cRgtk6MA8yUKoQ0ilXJsxic/lIWdn+qqrNaM9kJcxHi8OM1OaHU0bUUs
	tdQUzo71gbDxJulrYfiB8BsXP+3YS+LPe7dVYG7iOA/7XA2TZmOV6n7DwLqV0sJswrT8FkdVqUX
	IbFhMqKnhm9k9Wjq7Ky+Fj5cBVkxTSpjjjNHHtQsosuoWvTPqcqa6GohsNPkinUd3NteZI=
X-Google-Smtp-Source: AGHT+IFzitP7JjcNikjx9YMpCj8L0qm6zP6XYhLhkJcP+sE5WF1MLjbiGn0ZtsUXLsqksIbzP2BKiD3snSQbrDO6WS4=
X-Received: by 2002:a17:907:7291:b0:b87:2f29:205c with SMTP id
 a640c23a62f3a-b872f293a41mr130780466b.26.1768237637814; Mon, 12 Jan 2026
 09:07:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmC-rUcPaA+cyG7ssqk4EbKKgtOeQrG6kx=ewmqaGtspw@mail.gmail.com>
In-Reply-To: <CAKAoaQmC-rUcPaA+cyG7ssqk4EbKKgtOeQrG6kx=ewmqaGtspw@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Mon, 12 Jan 2026 18:06:41 +0100
X-Gm-Features: AZwV_QitBh-DOuU6OgD3X3gDq01I2UOA0iRRBqi9FLPLwWI_kLFixSKBIWrLCFQ
Message-ID: <CANH4o6P-TU8S00EL=hWH5uooiaSgVOooHMO1=8t4QTHNNEadMw@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
 filesystem client Windows driver binaries for Windows 10/11+WindowsServer
 2019/2022/2025 for testing, 2026-01-12 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
ARM64+AMD64+x86 and Windows Server 2019+2022+2025/AMD64, but
interoperability feedback with NFSv4.1/NFSv4.2 servers based on Linux
6.6+ LTS and 6.17+ would be great.

News:
See announcement below; Windows Alternate Streams (Win32 streams)
support was added, xcopy.exe/cmd.exe copy/MS Explorer file copy
acceleration via NFS server side copies and copy-by-block-cloning are
IMO the most interesting new features (cloning now works with FreeBSD
14.3/15.0 nfsd and Linux nfsd exporting btrfs&xfs filesystems, server
side copy with FreeBSD+Linux with all filesystems), because it's "on"
by default for all Windows 11 applications which copy files, followed
by wings.exe (Linux users read man sg(1)) with powershell support.

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, Jan 12, 2026 at 1:09=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
filesystem client Windows driver binaries for Windows
10/11+WindowsServer 2019/2022/2025 for testing, 2026-01-12 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!


----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32bit x86, x86-64, ARM64),
Windows 11 (x86-64, ARM64)+Windows Server 2019/2022/2025 (x86-64,
ARM64), based on https://github.com/kofemann/ms-nfs41-client (commit
id #ac375d7f91f70f142544fc59eb18a911ea3ba453, git bundle in tarball),
for testing and feedback.

** FULL release readme:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20260112_12h18m_gitac375d7.readme
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20260112_12h18m_gitac375d7.html

** Download URL (all architectures+platforms):
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20260112_12h18m_gitac375d7.tar.bz=
2

** Download hash sums:
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260112_12h18m_gitac375d=
7.html)=3D
e6c57cffeb0c095ec1b1dd582d85a931d57ebb783bcebdb728b83f209d4eb7a9
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260112_12h18m_gitac375d=
7.readme)=3D
511c9aa1008a74d7a49aa0846f1b0fa12e890f8419c2dde5c80a0162c1e55c72
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260112_12h18m_gitac375d=
7.tar.bz2)=3D
1ee4ef852c98d9f8e3e030bfdbf90579ae91ce689fecd3c1e0c8c076895479ce

** Major changes since the last release:
- Support for Win32 named streams/Alternate Data Streams (ADS), if the
NFSv4.x server support NFS named attributes (e.g. Solaris >=3D 11.4,
Illumos, FreeBSD >=3D 15.0, ...)
- Support for Windows "SRVOpen collapsing", which enables file handles
with the access/permission/etc attributes to share one NFS file handle
(saving open/close round trips to the NFS server)
- Added support for Windows Server 2025
- Symlinks are now using the group defined by Win32 PrimaryGroup
(which can be set via Cygwin newgrp(1)/|setgid()| or winsg(1))
- Added a new standalone tool called catdbgprint.exe which can be used
to listen to Windows kernel |DbgPrint()| debug messages (DbgView.exe
from Windows Internals still works, but this avoids installing an
extra tool)
- Added support for Windows "Extended Create Parameters" ECP
QUERY_ON_CREATE |QoCFileStatInformation| and |QoCFileLxInformation|
- Added support for setting a file's ACL at file creation time
- Bugfixes for FreeBSD NFS server
- Fixed issues probing sparse files when using the nfs-ganesha NFS server
- Disk and CDROM/DVD images can now be mounted via
https://github.com/gisburn/filedisk-sparse/
- UNC path format changed to <hostname>@<protocol>@<port>, e.g.
ournfsserver@NFS@2049, to support future transport+mount options (e.g.
RDMA , TLS/SSL etc.)
- Window 11/ARM64 is now supported (native aarch64 kernel module and
nfs*.exe userland utilities)
- /sbin/nfs_globalmount, a new tool for Administrators to manage
global/machine-wide mounts which are available to all Windows
users/services/logons
- New "nfsclientdctl" utility to change the NFS client daemon
parameters at runtime
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

