Return-Path: <linux-nfs+bounces-16215-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71724C4350C
	for <lists+linux-nfs@lfdr.de>; Sat, 08 Nov 2025 23:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2713A8B71
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Nov 2025 22:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E61F20B80B;
	Sat,  8 Nov 2025 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnJzmJm/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E571FE44A
	for <linux-nfs@vger.kernel.org>; Sat,  8 Nov 2025 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762639358; cv=none; b=cqMnO5gOc8OXjmc57k86KDsGMO2aZgwgEvuyF/FNErh28I5j2fOFbTnlSwp0L+qy29wwPVckFHvEza0o288yA/2D+dxUdLJL64wGUnu71mIjZ0u3huTl5I10KwyR8Yw7oJIAU1RaVglrXrbwmXXKGawyKMUEUg7qmTdozLhwLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762639358; c=relaxed/simple;
	bh=9c6eSvJyfNwzadDlReFVLcb/ZKko/V9VnXK+nP0wMrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XQGgR+JpaLZnHekTuwQ+OTP9+H8efkl3Qar4rAT3nwyCM9BLbcAT4m+fyNT7/mlEtQQFcLNhNK/2bsctjqG+3xOiMWuNrn29Rf/q24tQKDmiCTLzGbf9RfuExLgA8wwNZ5PVJqG1GsXdgG0zHHBhqqxhrh8su2zGdALrcPTrCqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnJzmJm/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3e9d633b78so330249966b.1
        for <linux-nfs@vger.kernel.org>; Sat, 08 Nov 2025 14:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762639355; x=1763244155; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anBhZ7zIqfZyywlNk5A4Q6nfoROmDI3iQPk1zAAe/XA=;
        b=YnJzmJm/5gTfrt4IhzH0wN3tCUQOs5iMxB53MrF8EAf+4tA15InDqwvqXWEnawHWL+
         t+Qbbtim/zoFQeDcdml/D+WRG3DuECzkR+9w6ByCr+q/tuFyjfTW3r852mcxk+tqeQXs
         9MYR6hdCjbY6B9L3s4YF/X4m1QxpibXhf1iy2aPQumoopBx6MBpZb2Wh0pB7T1Q5Is7K
         a9S3jU/kltUZcGIELaCH/bvy7EQ1QYmF48adH/8TfBvhUBJ/lpZM3Uj0TkwyN8WPQWaf
         AOcKCylFIMS1tFzTRWHm+FBoWQmMRMNbruGWltZ9rlDK3jTg6XXlmTfASPJjRoaytVNA
         TkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762639355; x=1763244155;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=anBhZ7zIqfZyywlNk5A4Q6nfoROmDI3iQPk1zAAe/XA=;
        b=epOTnprG26b3oD3VU8z2PBi5h4RWXl2DNxmQwjYUoX+G3vo9X8QIwXeWBm2sa/cKMV
         p4EmjkJ0n9Qa2SRShortLANVdNCcsJ4AYN7tiWxgtHHNkGhbbvPxaaQyM1/EXqPonnSk
         EMD4SDP6OQYbLiZF1fDZOCJq1jCNiH7RLq+NLedFisvDxjp8C60QGOuZBbud8Jul87Qx
         L9G+4Q5FzO6cm2IPidwPBgC3tCTEhuksULm0EyZQMKrVcjaEtXCoNYCs6LLZZi/7m1Hj
         MAfCyA3jm4qV5sHxzx+5NBLr52BNBkBHio+DlH6HsNkeEGby5Iyit8QlWSMCW0IF/He+
         NWjw==
X-Gm-Message-State: AOJu0YzJKzI/Fc7+oUJk8Nw+saIsgMcD1gro4Btq0MB6fSMkXftNfL/t
	poEG7jnBDmPZXAEx1Vnk0gSEn/Uk6PVQHCAO7OIg5l+nfKPp1WbMDWfxcmR2cAwT/JDKFYInGNr
	iFbyyh17UBmVzD8HxrWVrp8AEbRk0jG+Zkwd+
X-Gm-Gg: ASbGnctH/LmFMmEGYzNFHdtX1sWPmnS/kgRULtxy1BGiT5raanvN2QRNkD9JaJELxZx
	nZR8Rb7QqfbeUMEoTIXSCjUndpTbD3GBM4+H2alAYMH9u8+kSp73Q3C7+K2wASQVOB4T1WOUN+W
	R72ebYqeYC6eNayBSFxVCwDmeEb7BnlVv3G8qZfCe/XqJciUoczVuFVDlk1vMjcuGAUprB+Z1RY
	Uj6WTyul1a2Amo/KcrxL8bh6b5tLsmywj021KkbZmX3W5IiIb92j/Jpwxns
X-Google-Smtp-Source: AGHT+IHT4N2VQ7rGs3EKzDbqHRUdjr8znSUEgxZub9Bw6lEPdBuKM1gBIzilvN+w9uCVT8f1pyoe96eFSnronEf8LFY=
X-Received: by 2002:a17:907:7b9a:b0:b3a:8070:e269 with SMTP id
 a640c23a62f3a-b72df9d994bmr422775066b.14.1762639354995; Sat, 08 Nov 2025
 14:02:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQ=NHPEM7BZP9gFNT_pw3-ARhZE=mRjhvNxG6c4Tn+n32w@mail.gmail.com>
In-Reply-To: <CAKAoaQ=NHPEM7BZP9gFNT_pw3-ARhZE=mRjhvNxG6c4Tn+n32w@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Sat, 8 Nov 2025 23:01:00 +0100
X-Gm-Features: AWmQ_blIpV2GpBHQjpAewqsAhsIdLldo9TftITVvzcdjZg3LetkIF5igmrP6XMA
Message-ID: <CANH4o6MQLM2kT70enD-OfQLXCnU_ruwG=o937r5q3VyBDFo7=A@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
 filesystem client Windows driver binaries for Windows 10/11+WindowsServer
 2019/2022 for testing, 2025-11-08 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
ARM64+AMD64+x86 and Windows Server 2019+2022/AMD64, but
interoperability feedback with NFSv4.1/NFSv4.2 servers based on Linux
6.6+ LTS and 6.17+ would be great.

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

PS: be careful when updating Cygwin to the latest package versions,
because of https://cygwin.com/pipermail/cygwin/2025-November/258945.html

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Sat, Nov 8, 2025 at 3:22=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
filesystem client Windows driver binaries for Windows
10/11+WindowsServer 2019/2022 for testing, 2025-11-08 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!


----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32bit x86, x86-64, ARM64),
Windows 11 (x86-64, ARM64)+Windows Server 2019/2022 (x86-64, ARM64),
based on https://github.com/kofemann/ms-nfs41-client (commit id
#897a1b5563b0bf27f846acec5a0bf8d73ca09d2f, git bundle in tarball), for
testing and feedback.

** FULL release readme:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20251108_11h29m_git897a1b5.readme
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20251108_11h29m_git897a1b5.html
(experimental HTML version)

** Download URL (all architectures+platforms):
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20251108_11h29m_git897a1b5.tar.bz=
2

** Download hash sums:
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20251108_11h29m_git897a1b=
5.html)=3D
daa2bcd03d857d54dce9f4fc244cd5b850aea2aec6824480f6136a5d0a2d089a
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20251108_11h29m_git897a1b=
5.readme)=3D
e0d33497737839affe254a5f57ae756c65bc1fa88096620f2ec6fe60e9d906e4
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20251108_11h29m_git897a1b=
5.tar.bz2)=3D
33d4c49f60e3c87f05d568150f15d5dfb1dd8aa1169dbb7f0a33b80f9e22d996

** Major changes since the last release:
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

