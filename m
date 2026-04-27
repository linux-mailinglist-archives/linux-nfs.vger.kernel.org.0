Return-Path: <linux-nfs+bounces-21201-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI+MCviu72lyDwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21201-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 20:46:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 934E9478D34
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 20:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D007F3014138
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010593C3453;
	Mon, 27 Apr 2026 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM/vKjwj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640A35836B
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315570; cv=pass; b=K2ix+JuG9RxfhkckZ5gN9gPM+uz1XJHYykDVVYeiiqgdGwKO5+jbtUvEiI8JHc8zY7U/3F9I/cqm3QfpZZAZERoOZq2TW2JMBNOSVndbu+MWh51QatYwMRlbvW0YE/7fSTzu4nJ6Y+9pF6hfOXy3jkrnzjuTsHypTEPnFlDwTuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315570; c=relaxed/simple;
	bh=ncJJMwwg1zQ43Kt6mJtEurbbM2thhFWSAM3LsFdOYHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WhSd8cyOTPOeNdKOkkJnuL7/dSc5tG1PXcC79JcaIY4heRfOJtbmsattkx8ubAJCbMtEpPWEtVVki6ZMCIOuyUZIHIONd5YbKtMEFitzboiLpVm/6ktghdf5hTDRLm2L9nhfaoeaaCwSZVDIHRwT9eebXbwqctJuojJF8eNWDIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM/vKjwj; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso1334864766b.1
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 11:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777315567; cv=none;
        d=google.com; s=arc-20240605;
        b=Vzn1SSAnyPL46yLI/+f8+V3Y9SlQpKYrzB/enPyiNDMgeO7JNhzfQJ9ozu4/x23JyX
         pipYmcL4TLvBmgD/ky/jYTqw3TWl7k5pT5c9fOSia8XNGcbJYEMdzgjIU39Gy3DEFAc7
         eP/y/Y1Ax2KaTj1Wg8AXfAvkwpm3ahruxSP1b3+4FcSWPUceYx77G00Pph+sp3ibFXzV
         s+jAzBTAy3gu+QCKRx1/Q1OQGAf9UTcRX8/KeHmxKpXaTYLcO/qY2vh0S2bdLq+SvM3P
         uT6eK6WqwvDG33Ci4u7KEzXAK/nZQLkVww3RJ9cQL5mWMszZtQkmLDRVCvTMhZ6Tmfq1
         lKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JWvWtUEr1EToN+xuSinql/kUAQu4fZySFz3pi3uMyd8=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=i7snQm+/OQnfEyNqwtpz5UL4BaCsQWZ7BV6Eqy1K8ax3bWb73r7wFK0GtHt2+ejIBR
         VqrvMkDb64NMKQcF1ww2gKUuiL5+Pj2T+qOJcyygEvagq7AWL55i1Iv2K82FoO38xc/8
         3ybTrL1twhOdOfbr9XRgONwQN8L4zTJCGkPC1GGG9E889QNeeflXaSxb7zcnZnId8wlq
         NZyEBI6TMrtONN4jePYq8dPqr0qISaz4SxTrIyRwN7ptGY7nu3P1YduF0h5qNku/3Dxa
         QUoC9c1T2tr5cp5E2PiB/ou0EdRiI5qRtwpA/6nHaj6RT2z0Qa+om1H+kIJF01YTGBzB
         WPFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777315567; x=1777920367; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWvWtUEr1EToN+xuSinql/kUAQu4fZySFz3pi3uMyd8=;
        b=MM/vKjwj2tBehgezeLT8qRpfRVtEQ81r3Re3hjSQ1m96MMbmAp0pQfWiMACLEuyTeY
         c/MchuP0EOPLKux1MpDVHOI/yKXYYBPrAgAQJCmElmEnx6v3dkGtaAIpjQRKsFOBJUD8
         WKm5TO/og1QyjtnC4fagL3fzZ+/18g2biLbtq5stbp6bHk6zoQzlRFeckU6pcXRh50DM
         yu0Dg5+Xq0zr+OUbB5e+ETAeZnXjMfP8/uONQHl4KBtqVjdWzKGTDINzvREwxRbZM1RQ
         hGipN3/Hl8JW/AEYNYz0YES5mR9+n2N8LjjWsVbEbj7TStl1e6g7pckKf413lIfJWD0r
         GSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777315567; x=1777920367;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JWvWtUEr1EToN+xuSinql/kUAQu4fZySFz3pi3uMyd8=;
        b=qrkxfMyAR9gfHF2kQObi3YWeCN031Wnbx8AJ8hrQPGkQ8cNA211heBEYtFzud9mkR7
         9Kjwir+5TTYzXHrf9GtxH7E/BZW2ow5d82rL29Kft+2Va2kJGDNU+aNDige1wtySVD5F
         rnHT5/IE165mhVtm5r761ahHoqEan/mwR6qzW/Gz1zR/LthDtmbSCQCkdbFLisWpHUua
         oAZ64iuDH8n/SPQhyiob9Qg8zxTL+TjWcfmHvRqbYIz6/45+0AmDeixXtwfcG+pmf89D
         ldlmsa711bwsBRQywsIqcbV0XOilRWzFZj0NBKnZQ1u+EnjDQh7i7luDtnwz00QSACBu
         CIow==
X-Gm-Message-State: AOJu0YxizdRcLK+OkYdXKy6TJ9jo4GcyABazDxcH43nS7YoVLnUrib0H
	ag3Gi1u4Z+KhyylKXPLRF5uuHs/eJVaMSaK5CrQoLFoHcR989ZIJRJ0IF9Nvm5xV+nph07a4DFb
	t8JlXbdOTli+t/WbM9ovulREXpM6ElpuYo7SvMdI=
X-Gm-Gg: AeBDieupaLvoqolJYc4bZB8FnLkKjW8PK7tGHSA49dNt3UEdgE1iP8//EXgg1tZWIvw
	lAwb5F2JvgN6CF9RmQdvQHAQ5bukp5DFljUYzv/cTWNP4k+1KQPSejD+0CGhFc8DrSrVOqH9FCZ
	T+cCXaPl7XXy2FTggcyB+XUoCvRZW6K8eLdh7BnRQXuvT43hj2e31uLfkkp0VMaDwkI+v0E32AT
	LBg00guRQo5Ak45/4kmy/bhfh87Snl9jHy4pvplxvICHzAGd3x6utYkImqgBH4wnK+Js04ki4NZ
	bzo5fPLiQjAHK2cQYA==
X-Received: by 2002:a17:906:2081:b0:b96:eee1:bb66 with SMTP id
 a640c23a62f3a-bb801ececebmr935866b.10.1777315566981; Mon, 27 Apr 2026
 11:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQkL_e0-5c8T1c6G7qQA_5vjf75MQffuy4J7x=AO90+ykA@mail.gmail.com>
In-Reply-To: <CAKAoaQkL_e0-5c8T1c6G7qQA_5vjf75MQffuy4J7x=AO90+ykA@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Mon, 27 Apr 2026 20:46:00 +0200
X-Gm-Features: AVHnY4JisnrRA6YJOXhvjxALSvSkeN4oD5T56mEBI_Kp2sKYHfWae9kF8Ekn45U
Message-ID: <CANH4o6PPZk3UwFBO+e2pF=5Z0-sZDNEJ9kReL9ZANH=VKpbw9w@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
 filesystem client Windows driver binaries for Windows 10/11+WindowsServer
 2019/2022/2025 for testing, 2026-04-27 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 934E9478D34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-21201-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martinlwege@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello,

Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
ARM64+AMD64+x86 and Windows Server 2019+2022+2025/AMD64, but
Interoperability feedback with NFSv4.1/NFSv4.2 servers based on Linux
6.6+ LTS and 6.19+/7.1 would be great.

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
Date: Mon, Apr 27, 2026 at 4:41=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
filesystem client Windows driver binaries for Windows
10/11+WindowsServer 2019/2022/2025 for testing, 2026-04-27 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!


----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32bit x86, x86-64, ARM64),
Windows 11 (x86-64, ARM64)+Windows Server 2019/2022/2025 (x86-64,
ARM64), based on https://github.com/kofemann/ms-nfs41-client (commit
id #2a52b61f83bd40cd32f4b2413d04df520508c05a, git bundle in tarball),
for testing and feedback.

** FULL release readme:
http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing/m=
snfs41client_cygwin_64bit32bit_binaries_20260427_12h10m_git2a52b61.html
http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing/m=
snfs41client_cygwin_64bit32bit_binaries_20260427_12h10m_git2a52b61.readme

** Download URL (all architectures+platforms):
http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing/m=
snfs41client_cygwin_64bit32bit_binaries_20260427_12h10m_git2a52b61.tar.bz2

** Download hash sums:
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260427_12h10m_git2a52b6=
1.html)=3D
a3f0e10ebdc4813faf61bfebbd9f13beb9b8541067e0553e8d5649c573686b44
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260427_12h10m_git2a52b6=
1.readme)=3D
42fcf3de25338699307c4e3615df6227f75029c680b5d775fa60ed098f71b9c2
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260427_12h10m_git2a52b6=
1.tar.bz2)=3D
865864aed92715f68976e9033b38f9681870c8874fdc4c91545c815a830c81d6

** Major changes since the last release:
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

