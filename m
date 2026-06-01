Return-Path: <linux-nfs+bounces-22170-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJDeHDOpHWp+cwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22170-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 17:45:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 782A2621FE1
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 17:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73589302A59D
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A302765DF;
	Mon,  1 Jun 2026 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD6o1N+2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B72475D0
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jun 2026 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328569; cv=pass; b=Smw14lBK8KNxgQiMwJtzvX0a1X5FCfYKYLTqHgHfkZFDBbrlzItw93Cjau/uOIb702xaqDY0RXemPddCdyGLPEI5FaLj1nsRxkilOpVSdWMCgeJQKKcdcDNmDcyPFRuuMcxK9xjBN98N6GEff9FyL2hwiBdKbjaJRozymBkus9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328569; c=relaxed/simple;
	bh=KPmk3cFWkqr9SQtiRAx7lDJ5RKNrhsA6aNpmwIRwIS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=f/Y0ebYgwVI8K7pmxAJZMSBxQYmlqL2acYVQ7brcgOeKbMciB05Za4ndYd8cOMohIHKHPt33nXCnRlMu2Gm/QPHsOKplWg69O7jJA4FwQdvzn/+IgQdluVkwEbHbfiw7IKZ3GkS/0Y/qVOK0TgjvXL+k68021OfnEPCI8t2UYdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD6o1N+2; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-beb2a97cc9aso414864966b.2
        for <linux-nfs@vger.kernel.org>; Mon, 01 Jun 2026 08:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780328566; cv=none;
        d=google.com; s=arc-20240605;
        b=BXkW6t6pFa6E8CQC/oAJgsG60qskzMyIeliIUYAyyA0ckJR3oTosv57C/vlwNOHJcb
         eh6VZ8jO2q1HYnqmq0KV0WjItUl+URVGAOzVrDmTtZZAfwcCja6IfKrNN89MD35xQK1U
         twxa5ARwvWRmvCaV1DnDb9HeG6x/J8wAmfZ3GJQtuM47xlYHnt0iClIbnDEqcC4qKuK+
         laJ4qF41hzUkOPeJPqAiuA696/5OXulZ+Y75+pcPjlSGZQtHstaqJdoDeHvRC8TWysUq
         +m4el2LXQdLrYwQ7sFhn63ENyTRRw2O33g6JlHz1NQfD8ccAyee2J83sXJVl0kXWKNI+
         a9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XqqJAyZWRvYsz+bXDw3FFOXS7V0izBm2aAqgfxjJOoc=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=QGnJybeMR7SG41X0COlZjY6S7OFsECGF6XyZiecXcJIj2G9b94NX2rA4Tw6+qW/hgy
         gbh1+ud72Jir2qWYa7FEaD7ExSnniE0YgOgDLJDLPYDvLO7QZ2VxpfduOk8DH8oyk9pF
         0edBkwlMaixhPYPLbjzBfZAht3FHjtF8AIZuhjRlzUYrrYs9HlS5C8Q9kckJS785u/Ox
         D7Mi4imyKB+tvuOf9O1x3wMorBmlZCchrLI2ddlBZmOa/5V4kMSwiSVOFbS+XCCuevW5
         GVG/BthK7WzPFS2rpr5lRabLA43w9kBY4vFTKvBXrEVYpcmWzHYwTlgpLNg6gDqOKsyp
         AGYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780328566; x=1780933366; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqqJAyZWRvYsz+bXDw3FFOXS7V0izBm2aAqgfxjJOoc=;
        b=GD6o1N+2/u6iGzIro4uxkeMC5ob4KVYzq91BTT7LyBFPOII6ZQJMfdIYEct4xpi+XN
         feJuwlzeIC0HEVyMdqWqkQGwiOJydSr3MsMd0HbS6VQEhRmDXaoCYDy4wo9bKy+/+kWs
         NTT1miCMjB1Nn0ucRPvws225DnB86iKt6v4w5IpAVFI5hE0uW3SL59bsD0X9plAkCmZ3
         OeOj51iD/pHURK5Wz3h3cMRdD74BNlwRsAlRqUVDx1gGfrQO8C4bQTHdO3xVPHUAaM3R
         7efYIMguEOT7hlEbzMviXANl8U7xRiP6rNQsqAfB2qi65c/5H0XAGa8Jc1pyxygWXZAo
         kjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328566; x=1780933366;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqqJAyZWRvYsz+bXDw3FFOXS7V0izBm2aAqgfxjJOoc=;
        b=DuIQyv+rShSzCnctiaNDCybP/CGCiUU2MQ9cptziBaXYcgKYjhFtLm8dWhfo9NvStM
         bOaseJ5tcSvL94dv2X6eHpugXBrGle9st/mAADId8h4jCSlOA08tYO1TpBIVJOrD8sXV
         r/D0OkFU7lnjR0X4igtgtYtG+eTqX8jBo8DxVk25FyibeX7z/nR0bOMgfl7b0ZijfYSq
         QOp0YRHRcEkp8JF+bqB/tNE203RSdtWMUm9WrQMAb1t+bc4im6sG3/9ElNDpvYdFB/M6
         3yUn85fdKwY2tamT29Y57gw2LjYkMXpDzLST4klFQokmYN8Y+Trs0zu8PRmKWID8cBKu
         Cz6w==
X-Gm-Message-State: AOJu0YxCBUD+auiIDuehSxlacEnEixvdqN+R3fmMilZ2UQ/XS8lAcjNd
	f1VMy5ZEP7hxrctdaAYbsC0PaoMrFFo4ueolxvEWOiLjZjiQPcWSBMiKVas93hGwT+i0wIvw/mD
	eFrSpePcZ6XW/7f7EgD8O2sk/aRqPvJCQTZwQQJI=
X-Gm-Gg: Acq92OGLHXAIPsAzdgrHVvBEUVVyo/fOylBSuf+B+d531dMAxkSPzjWBNfpQd+EXTR5
	3yWEPQCO6WJ39l/9OQ4gAYxSwyzO4KcnwAKK7/KDIuAukNO6qI38j3BZtGCabL5i3fV4UxW/UZk
	oDGte7bPYx2SmstUt7K/xtNUTD76fU4jsIHR2rJEprr6YBQd0IWxysngbroZBeIFvBxyCN83c6y
	a4+p+FpnRSgWIRKVyphtxqSmBP3hKf01aOCNOwF6TqolGItF713ykemfMzpLTMa8KNQZm+OIFuv
	+Ukvt6ks7zyIm0yChQ==
X-Received: by 2002:a17:907:960e:b0:be5:57ff:cd4 with SMTP id
 a640c23a62f3a-beab0cd2aeemr713061666b.1.1780328566112; Mon, 01 Jun 2026
 08:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmzKUO+WMQkZd4yrYgfSxJPXPzOuojQ03p_WZ8eYyfz1g@mail.gmail.com>
In-Reply-To: <CAKAoaQmzKUO+WMQkZd4yrYgfSxJPXPzOuojQ03p_WZ8eYyfz1g@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Mon, 1 Jun 2026 17:41:00 +0200
X-Gm-Features: AVHnY4LlQjBt8qvdBpO2v_gEonXJi84xNex2Kslk2TVQB6FRSiMTxQE8_i6k-Lg
Message-ID: <CANH4o6MahxiVGFUBPrvyo6b_v6OrX=ALPFwYiQercYecSk497w@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
 filesystem client Windows driver binaries for Windows 10/11+WindowsServer
 2019/2022/2025 for testing, 2026-06-01 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22170-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nfslinux1:email]
X-Rspamd-Queue-Id: 782A2621FE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
ARM64+AMD64+x86 and Windows Server 2019+2022+2025/AMD64, but
Interoperability feedback with NFSv4.1/NFSv4.2 servers based on Linux
6.6+ LTS and 6.19+/7.2 would be great.

News:
See announcement below; New idmapper which maps any NFS user/group to
any Windows user/group, support for Linux 7.1 case-insensitive NFS
filesystems, Windows Alternate Streams (Win32 streams) support,
xcopy.exe/cmd.exe copy/MS Explorer file copy acceleration via NFS
server side copies, and copy-by-block-cloning are IMO the most
interesting new features.

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, Jun 1, 2026 at 4:17=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
filesystem client Windows driver binaries for Windows
10/11+WindowsServer 2019/2022/2025 for testing, 2026-06-01 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!


----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32bit x86, x86-64, ARM64),
Windows 11 (x86-64, ARM64)+Windows Server 2019/2022/2025 (x86-64,
ARM64), based on https://github.com/kofemann/ms-nfs41-client (commit
id #474807ac63a17827ac8fdb334dd773aad0f145ef, git bundle in tarball),
for testing and feedback.

** FULL release readme:
http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing/m=
snfs41client_cygwin_64bit32bit_binaries_20260601_12h24m_git474807a.html
http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing/m=
snfs41client_cygwin_64bit32bit_binaries_20260601_12h24m_git474807a.readme

** Download URL (all architectures+platforms):
http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing/m=
snfs41client_cygwin_64bit32bit_binaries_20260601_12h24m_git474807a.tar.bz2

** Download hash sums:
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260601_12h24m_git474807=
a.html)=3D
eced1e98f9a6168256eb7a5c0356c342ce49f15bb6218df08853a0a34b996037
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260601_12h24m_git474807=
a.readme)=3D
dc6660211bbbedf1ea386aac770e991411e21155e3cc0909aad6d57f7033f322
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260601_12h24m_git474807=
a.tar.bz2)=3D
4ec3000a4ba6d52cbc75aaf6eb53b99d4779028c4b13a682813ff2cce099e43c


** Major changes since the last release:
- UNC tag numbers (experimetal), to give mounts an unique UNC path
(and separate NFS server connection) via $ /sbin/nfs_mount -o
unctagnum=3D4000 ... #)
- New winfsinfo subcmd "fsctlnfs41queryidmapinfo" to query the
idmapper data (Win32 user/group names+Cygwin/UWIN/SFU uid/gid, mapped
NFSv4 fatt4_owner/fattr4_owner_group data etc) for a file. This is
intended as diagnostics aid for administrators.
- Idmapper configuration is now obtained via "cygwin_idmapper.ksh"
- New idmapper, which allows to map any NFS server { uid, gid,
fattr4_owner, fattr4_owner_group } to any Windows user/group account.
Mapping is done per mount, so Windows user "abc@windomain" can be user
"def@nfslinux1" on NFS server "linux1" and "xyz@otherlinux2" on NFS
server "otherlinux2". Same applies to groups. Windows localised
builtin accounts are also supported, to handle situations like a
German Window client connecting to a French WindowServer NFSv4.1
server.
Idmapping itself is done with a shell script (for maximum flexibility,
as attemps to handle this with builtin code could NOT cover all
compliciated site setups, including Windows localised account names,
and NFS clients which have to connect to multiple different sites with
completely different NFS server account setups), and also provides
uid/gid values for Cygwin/MSYS2/UWIN (which can now be fully
independent from uid/gid values used by the NFS server)
- Added support for FreeBSD 16.0 NFS server
- More fixes for case-insensitive NFS filesystems (requires FreeBSD
n>=3D 16.0 NFS server, Linux >=3D 7.1 NFS server or Windows Server NFS
server with a case-insensitive filesystem)
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
- Added support for Windows "Extended Create Parameters" |ECP
QUERY_ON_CREATE| |QoCFileStatInformation| and |QoCFileLxInformation|
- Added support for setting a file's ACL at file creation time
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

