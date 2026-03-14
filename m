Return-Path: <linux-nfs+bounces-20171-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGwFHj3itWlt6QAAu9opvQ
	(envelope-from <linux-nfs+bounces-20171-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 23:33:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD0728F516
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 23:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C418302AC33
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Mar 2026 22:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311EE3126D7;
	Sat, 14 Mar 2026 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTUP/xGy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57051139D
	for <linux-nfs@vger.kernel.org>; Sat, 14 Mar 2026 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527597; cv=pass; b=gCc/RcOwiruVK34efPmlyAWC/rIYPZBTu+BUpo+5xcLDj6oJS+lR2CQLtpxjR1K3cx99rVDfb8A6bdqPOxD20N/X+hwrew/Pvoqg4BTHdOs+NDQp4RAyoWFoMGSAdVXK6zp4CdH6Ii3zRy5TKPPH3XCOu6QDyZQln7SQ+8x8dfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527597; c=relaxed/simple;
	bh=ONsTTIBh8uaVI0J6uCxg+aIRGwiQP8AirXOkeuBdKCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YMeZ88d1A+8fWyM3kWmtWTYy6q/LfkViZdq8jj33lf9BY74556mhH4f7Sl7tJy31Ox8QX2zbiJNQ6DXUUQxgHfCKx81Y+zX90F0C0npekgtKFzTHSLZTz8ofB/DrR91zH9g5lWVQUYwn49wdvgY47F0BlA8yk7WYbKdW4ypnSZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTUP/xGy; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b942a41c5fcso466551266b.0
        for <linux-nfs@vger.kernel.org>; Sat, 14 Mar 2026 15:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773527593; cv=none;
        d=google.com; s=arc-20240605;
        b=gaF/xgCPK1DYTEoJ+L8CMumvEvPr/l9diWN9i1IMDUvJIxY/TGWSNNa/PcMQ1BlkLm
         8PrfKOzMDFXqij0xjmko2lA6ymLjxirMAmOF22cp8o8UJvw50KPF6r53HAeZ9NmjrE5J
         7dC164A+wHWj2N4X8ZzpyHkreRnZqtrB+yYtBNROzLNXCjPsQabuPPdgmbtMjecpJ8Tv
         1G3zd1wieYPW1+j1L1AtaltmGx2b4xlNlq9HnSp3+T+aRWdKTcQCImqMnRMf6Jq9nBz4
         GVZSBAMYax+Re1nhfMYGT99wwS6PHU/DsiDSXmzgZBy5AP5wGWQSseDqg5HcVq6q7KQO
         tKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MXgMyrxQHqRMEIDLq+afjBUSY+i4nB/oh/p7Y7onhcs=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=aCDZaJKHt+gnkh5PqW+/96qxK+3RNMxpkXq2kvyQH6XzBzOwmH3ZwIrPZYEjR2vSad
         DYm+n2/UUTXUffIZp57WkrS+NP7okSV5ypSNcoYcy98E0oaZkvAswcvk4GLkL+h8Hzvb
         LG+lp1W9RJDyPakdqx+iNFUBLDEnN1KsTOSuvcFcZ+FwYRLSAxIzIJIcU7lwvlchiPfK
         KYkcqmt1qyM7OM9EXA5uN3bFV3duOykJpfTTwmle0/nhUP7ZVYOu4wc6r9aKkG7OuwMN
         kjvul9aXWFvgk1EghdBo9J2Xm1RQHURJG3BU5EgWsKSXnAyMyoIw4afy+v009MvT3E4Y
         K6Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773527593; x=1774132393; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXgMyrxQHqRMEIDLq+afjBUSY+i4nB/oh/p7Y7onhcs=;
        b=fTUP/xGynaCMhsN7ElF7IGXPZ2MHCh5UrGjjA9kLnnQxJWOIUmdio29Ipu3sVyuTrM
         PoCNTLTAh/ZJSYCI/Khc5H2HLkfh6rQVQsaIXrQCfHm8MU6AdXU1ruOt+ANAfdqaGFRn
         wuI1x16CH2tj5iwfFUqxFOODS1Ngh/PrZ1C5ueI6XOVM/JKjqkVKvuouYZvDHlZicirc
         HJq8yE/Mem8fYxXs8GWa8tvIboYwkfArVXxDav08uLJTHvufp3j4AmcgV3SME68juJxz
         MDBqwnqaiQmFWT8I9+jXNVgqeFuuACLQcWcztUDz4LDPRfyzpmG+WwlwDom1ZRsikkOB
         O/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773527593; x=1774132393;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MXgMyrxQHqRMEIDLq+afjBUSY+i4nB/oh/p7Y7onhcs=;
        b=PWMw6mxNyW4eSQdPCgS3u5eEhnDSqkzoPEMIhkgYYTKZFUKEPasKX5wlSnBUXxXqix
         Pc/UWuhWUCCdzV5zoZmNJkfbzuKEUC6LGFCr+8PX5YAWxLLxbOWr5QHaUNt7jF1IxhpZ
         +kz2iRbETVzbDsiyz1n6/hDwwqPZJm93vvGmGEAekYuSenCnGgrKnfLN4nbj06yIlV+Y
         B4ItPHJX37IJ2A4heEblij3fEIk0Bz5zAI/UY8fEL9lDcgtAxjbVRPxT3+nIhgnb0lYo
         IOkaSYWInsLbmk7ftNrJTUafnobsmO+VZKhFAXM9cR1YgBxkN9ETx3kgzOO3jut1uDOX
         GHnA==
X-Gm-Message-State: AOJu0Yz6I+l1JG1oG9v8TK0ZyxMLC5M5zn8IWhA1U7u+6TBDR0lK+V3D
	Qoz6cXXDd1IFzC0+VGoBVxuLAckR4vK5jGO9DTDLhkYxMoQLWYEZshAlW2DwrEpTdHtDBSnkyZX
	RSmOVLeC1J+SQCeLVfZGHdGcJLwManNv21YO0
X-Gm-Gg: ATEYQzx91Y6rKuwmTmeMx3EDvXTFAMOk39bvLoDLm5HzJorGq1Bpb70SNOs1FzDetD7
	3rS8kn90ng9ubA7S1lD6N8FhW1+GIqXIna0qJHI/zAyLQUl9wfqNlt4SddDT1z3R9jBgERNNCj5
	zXbp2pS9UKcxuisIo8ePp6RygxgajtYeB1mmxUx5NwZefUFQ5OZerS1Bl1M7ZI5GhALYwtVpmm9
	GICSwwz5E3l+Yz7ngw4qd4tI0WHqX/5/jceUhuAq1NcKZ2Se3dALJZvqfvR9rkzAib/Z9hY4yON
	zXZEQK4=
X-Received: by 2002:a17:907:8dcd:b0:b93:81e7:8454 with SMTP id
 a640c23a62f3a-b976507b064mr411664166b.6.1773527593146; Sat, 14 Mar 2026
 15:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQ=CJ-VyKmJjnZEghJ4mAYKoDUszbw0TsGYbMPCSLQH9wg@mail.gmail.com>
In-Reply-To: <CAKAoaQ=CJ-VyKmJjnZEghJ4mAYKoDUszbw0TsGYbMPCSLQH9wg@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Sat, 14 Mar 2026 23:33:00 +0100
X-Gm-Features: AaiRm53vUYgw-Uv75IulVHOiXe7FUg8spPMxCQ4eQMVIzpN4xRugxbo_JUzXOjE
Message-ID: <CANH4o6M1J2FW1dgvA4JHz+EXzMsyguuAT_TfbUy57WJR6+My8w@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
 filesystem client Windows driver binaries for Windows 10/11+WindowsServer
 2019/2022/2025 for testing, 2026-03-14 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20171-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.8.1:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martinlwege@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nrubsig.org:email,nrubsig.org:url]
X-Rspamd-Queue-Id: CCD0728F516
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
ARM64+AMD64+x86 and Windows Server 2019+2022+2025/AMD64, but
Interoperability feedback with NFSv4.1/NFSv4.2 servers based on Linux
6.6+ LTS and 6.19+/7.0 would be great.

News:
See announcement below; Support for Linux 7.1 case-insensitive NFS
filesystems was added, Windows Alternate Streams (Win32 streams)
support was added, xcopy.exe/cmd.exe copy/MS Explorer file copy
acceleration via NFS server side copies and copy-by-block-cloning are
IMO the most interesting new features (cloning now works with FreeBSD
14.3/15.0/16.0 nfsd and Linux nfsd exporting btrfs&xfs filesystems,
server side copy with FreeBSD+Linux with all filesystems), because
it's "on" by default for all Windows 11 applications which copy files,
followed by wings.exe (Linux users read man sg(1)) with powershell
support.

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Sat, Mar 14, 2026 at 7:18=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
filesystem client Windows driver binaries for Windows
10/11+WindowsServer 2019/2022/2025 for testing, 2026-03-14 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!


----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32bit x86, x86-64, ARM64),
Windows 11 (x86-64, ARM64)+Windows Server 2019/2022/2025 (x86-64,
ARM64), based on https://github.com/kofemann/ms-nfs41-client (commit
id #5ce53d1d6736581324ba4f0e444d34ce8b969cee, git bundle in tarball),
for testing and feedback.

** FULL release readme:
http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing/m=
snfs41client_cygwin_64bit32bit_binaries_20260314_17h22m_git5ce53d1.html
http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing/m=
snfs41client_cygwin_64bit32bit_binaries_20260314_17h22m_git5ce53d1.readme

** Download URL (all architectures+platforms):
http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing/m=
snfs41client_cygwin_64bit32bit_binaries_20260314_17h22m_git5ce53d1.tar.bz2

** Download hash sums:
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260314_17h22m_git5ce53d=
1.html)=3D
e0c5d27a7ebd8bcb007a61dadaa77a5b7545fa2733251b10078f8e6e70720ef6
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260314_17h22m_git5ce53d=
1.readme)=3D
cb9c58c14a5b7a13edf0b51312f5c1d37c35889e3ba1cf02ad5609e5b234d4aa
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260314_17h22m_git5ce53d=
1.tar.bz2)=3D
c8fdcb3552329c078dcf0111357720c628c0a7fdce582f13a219d5631c1fd0fc

** Major changes since the last release:
- Added support for FreeBSD 16.0 NFS server
- More fixes for case-insensitive NFS filesystems (requires FreeBSD
n>=3D 16.0 NFS server, Linux >=3D 7.1 NFS server or Windows Server NFS
server with a case-insensitive filesystem)
- Fixed |FileRenameInformation|/|FileLinkInformation| SRVOpen
collapsing support when files are being replaced.
- Bugfixes to enable compilation of ReactOS on a NFSv4.1 filesystem
- Support for Win32 named streams/Alternate Data Streams (ADS), if the
NFSv4.x server supports NFS named attributes (e.g. Solaris >=3D 11.4,
Illumos, FreeBSD >=3D 15.0, ...), including NTFS-style renaming support.
This also includes new utilities (e.g. winstreamsutil.exe) to find,
list, create, rename, delete etc. Win32 named streams
- Support for Windows "SRVOpen collapsing", which enables file handles
with the access/permission/etc attributes to share one NFS file handle
(saving open/close round trips to the NFS server)
- Symlinks are now using the group defined by Win32 PrimaryGroup
(which can be set via Cygwin newgrp(1)/|setgid()| or winsg(1))
- Added a new standalone tool called catdbgprint.exe which can be used
to listen to Windows kernel |DbgPrint()| debug messages (DbgView.exe
from Windows Internals still works, but this avoids installing an
extra tool)
- Added support for Windows "Extended Create Parameters" |ECP
QUERY_ON_CREATE| |QoCFileStatInformation| and |QoCFileLxInformation|
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
- Better FreeBSD 14.x/15.0 nfsd compatibility
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
- Support for |FSCTL_DUPLICATE_EXTENTS_TO_FILE|, which allows Windows
11 applications which use |CopyFile2()| (like cmd.exe  copy, xcopy.exe
etc) to copy files via block cloning. Requires NFSv4.2 NFS server with
{ CLONE, SEEK, DEALLOCATE } support, exporting a filesystem which
supports block cloning (e.g. btrfs, xfs). This includes correct
cloning of sparse files.
- Sparse file support (requires NFSv4.2 server { SEEK, ALLOCATE,
DEALLOCATE } and the |FATTR4_WORD1_SPACE_USED| attr), including
hole/data range enumeration, punching holes etc., e.g. $ fsutil sparse
queryrange mysparsefile # and Win32 named stream support
- Improved Windows Extended Attribute (EA) support (requires NFS named
attributes support in the NFS server (e.g. Solaris >=3D 11.4, Illumos,
FreeBSD >=3D 15.0, ...)), including create/read/write/delete
- Support for Storage32-API (e.g. enables use of *.msi installer files
on NFS filesystems)
- Cygwin /usr/bin/svn and Windows '/cygdrive/c/Program
Files/Git/cmd/git' now work
- Illumos NFSv4.2+Solaris 11.4 NFSv4.1 server is now supported
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

