Return-Path: <linux-nfs+bounces-18203-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLxNENnAb2lsMQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18203-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 18:52:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C4748E26
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 18:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 886747A752A
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B08733AD94;
	Tue, 20 Jan 2026 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZvcCntH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3632E13B
	for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927320; cv=pass; b=GQVZa7qKimB0dZ16NyPvLCZFnEhk+UnW0ONfnrwtSIiP4JeJXx160M79t7kGW4KWHEFFNAdTKvuyOjh+TmTPruBxKwwkS8KMffNKL1tp8rKMSQZHx8LincN+uvfDTC9DM4EIXX14ZudYdGMOeafvYXkJ41PB4FWrUnLbGB/cD7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927320; c=relaxed/simple;
	bh=xBRKWYMJTjDM6DZimtFVGr53qQ2r3me23N/lN+Pt4bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=El0a0YMz7DJxALOZs8r2v53pdD8N8vWtXM+fB6ePmFkxu31DAUHl27E0ykv1Ctv8QjJcfrv6Ynvg6lQmzRGijxklqEHkU9jv8IHXu38ko5hD20Sr+1+DKyCzxCEWZEDrYjXneK91KZ7kp7hVpjqih7YQxeRJ05Qgcz9txi6uRxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZvcCntH; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b870732cce2so850688166b.3
        for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 08:41:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768927316; cv=none;
        d=google.com; s=arc-20240605;
        b=aUffiRlAgUJNAHgKHHI+lm1UDT8ZK6ZIuu7sK/aMV5kv9axoUuodcnpCtIORVouEnu
         Gm80cKOUV3VbxtAClOjRU7MWvBeNR2+XfGE+dVkizuTrsucgTa9Mh6a4aEX7GKHeSB8m
         2NA+RnQ2f+nsmazfx3kS//jenXLp0FyPU7LDfEG3kSElzMo+bX5oVhvmBVzGibSaftGn
         qTj2sk1OpcW/5CwrW/jME0EBtDkCdXEftQWGzUKIMMQ+jcjuKSAtG6zmaRgJ0AaBJNmF
         /iOylNal2qEQHlWSp2ilDXMmdp/S6DoZ/VO/2AIeaehF4yHz3oNmxTLbapFiPQu5FSII
         5Kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e9AQYWtaGbi019szXm3TXVLSSVqzZ69tjU+sSJe7RUI=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=kE5DO5DxJscq0xysYltFddEwnB9eSd/caIihgRB3L1aF08CjDsEnlM2gvN/czV2tZ0
         ruJ5U1zSJ1c3YHRDwa5iRyNAb9pH3c6PXlCFoyknTPWAPXKKryfY/yarB+rFPofpFmVL
         rSrrOJflFA8vmokvPly9P8HMBQr7UcvIO6v1QqlZ/8FZdZ8ALtGCLTT0ZzH8sSEXzEBC
         A4Xsy6K6iNnDNMB9qRBJJu2YdnrSqDFbwm/IIW8kqgC0dBSnHV+qViYAipOk1J52D88w
         aNyOmInkl5MkFRoHHlTzLogSai4BhlmEntZ3O0Cu8ykdPjSqBOj+Afnw+LxfQ8i+fpNT
         B/IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768927316; x=1769532116; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9AQYWtaGbi019szXm3TXVLSSVqzZ69tjU+sSJe7RUI=;
        b=lZvcCntHO5fTqOCD6BI6js+NAICSRdK7idNEIXUw735jQ3zmB0N6WTlWUc9yODexbH
         86/F6YVOTai41DzhIZv4kmCDn+NVFg43pVw+Hqjg/VSuOYjzmq5zbTbzbo7YNkkfEkjv
         md9YmCZ9fALmoDU2T7EoohWTZ9TzwHozkWJ2JUB1hqooVwWyWAsFPp1O/Gge1Mi6bXsX
         kvn3NoAXZBMZmMJDs+tlBVz5w1cmFdpDnEfb65QdDWPbgUFeJFrzCRtO3dH/ert4joot
         JLDjuqRHm8rVKA+XevxHPt/Ti+5WYM52TESBXhVLI0lwsZbErbb1F9aXsGiFp4d9e7AM
         DVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768927316; x=1769532116;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e9AQYWtaGbi019szXm3TXVLSSVqzZ69tjU+sSJe7RUI=;
        b=LLJLwDYvV8W9NfB+0cJi/KTXH63b4H4m/127B60o4oNJwBsQwU3oUTDxTu+3Ypxd1Q
         6sfU37wSPYkP9PGvA9/nOlPGzU6msfUKoiGPNwczxAYA7f60HUmmgA15YLLtskmCxRR8
         eq0+TuRSr9Q3x8/AuxROQH69oVWM0wStdwjqeor8SSLp9s9XIXb0TKSDQr6LVkiN6wZn
         nMJKuPT3DqeHM79MicpMyHuVQn2938Q93bI2lcOu72HISIrCUyQVJqfl896R+s+ipZ8l
         a+TswSIz6W3BAqXQoWVUFzD3YJ4fuR8LvoG3PCSmLPSn4r1rwlpysi0x7+gojoqKb1oS
         mctg==
X-Gm-Message-State: AOJu0YyufUzRLXJE6KawQf3jvO0dGkQqoN311gIWERs6/7nJI9+fW1Ne
	h9ryavRkhAOkULLFFggWkGPVooMpTOSHFKWIRH3IjqIjwpRcfsmKH6/NbfZmRqxX2OjwGi+9X+g
	mBUtohpCLbqwz9uQr8+NH58sY1tB25LRhlybe
X-Gm-Gg: AZuq6aIxaz81JoNQ/HGjImxYpEiKgI9X/ne+gzDuTx9v6RWJC/XUa2QQ7FT0N3N21g9
	0OhCdVUDMiwgldL8OGfeAlrkXJPmmBVaWzbG0j7HwwXsm7Z0giI4AMkYiWO0p74OWGJMCKS7jnB
	+z75ikVGMa6HCdRzZNqUM9fmS7SoNMt0MhXGPmo7CIfwAsg7FY5aoo6XEmW9QHmK44jvws1ld7y
	Hb5BTv9UpozsGKsLwMmig29lAS3i+KdmJEIwQrmUQNXZZaBZcSzMXb16ylPu6nw1/LEU8I=
X-Received: by 2002:a17:906:2090:b0:b88:dc6:395d with SMTP id
 a640c23a62f3a-b880dc63bb5mr186778066b.48.1768927315621; Tue, 20 Jan 2026
 08:41:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQn49JsBsbmp+ChQHBd0_PLd5bVFmvgOOdwcED0QCkPzOw@mail.gmail.com>
In-Reply-To: <CAKAoaQn49JsBsbmp+ChQHBd0_PLd5bVFmvgOOdwcED0QCkPzOw@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Tue, 20 Jan 2026 17:41:19 +0100
X-Gm-Features: AZwV_QjdTo0IE_UpL1Y1y33O4kc6wGDMIoorsNc0xjLOGeO5UXruZ7hmIhZi2II
Message-ID: <CANH4o6POBPzHv6wppWKj6j5Af8NHHbWO92cAZa1veXCwnXusMA@mail.gmail.com>
Subject: Re: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1 filesystem
 client Windows driver binaries for Windows 10/11+WindowsServer 2019/2022/2025
 for testing, 2026-01-19 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-18203-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martinlwege@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.8.1:email];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nfs:email,nrubsig.org:email,nrubsig.org:url]
X-Rspamd-Queue-Id: D8C4748E26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
ARM64+AMD64+x86 and Windows Server 2019+2022+2025/AMD64, but
Interoperability feedback with NFSv4.1/NFSv4.2 servers based on Linux
6.6+ LTS and 6.19+ would be great.

News:
See announcement below; Windows Alternate Streams (Win32 streams)
support was added (create, r/w, lock/unlock, sparse streams, rename,
copy, clone, delete, ...), xcopy.exe/cmd.exe copy/MS Explorer file
copy acceleration via NFS server side copies and copy-by-block-cloning
are IMO the most interesting new features (cloning now works with
FreeBSD 14.3/15.0 nfsd and Linux nfsd exporting btrfs&xfs filesystems,
server side copy with FreeBSD+Linux with all filesystems), because
it's "on" by default for all Windows 11 applications which copy files,
followed by wings.exe (Linux users read man sg(1)) with powershell
support.

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, Jan 19, 2026 at 11:16=E2=80=AFAM
Subject: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
filesystem client Windows driver binaries for Windows
10/11+WindowsServer 2019/2022/2025 for testing, 2026-01-19 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!


----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32bit x86, x86-64, ARM64),
Windows 11 (x86-64, ARM64)+Windows Server 2019/2022/2025 (x86-64,
ARM64), based on https://github.com/kofemann/ms-nfs41-client (commit
id #e2d33638f6193fb84b32d6db194f1ba87c41aaba, git bundle in tarball),
for testing and feedback.

** FULL release readme:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20260119_10h49m_gite2d3363.readme
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20260119_10h49m_gite2d3363.html

** Download URL (all architectures+platforms):
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20260119_10h49m_gite2d3363.tar.bz=
2

** Download hash sums:
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260119_10h49m_gite2d336=
3.html)=3D
311afd4741c204fbe7c4d803e9856b499f1984a77872f4a315cc232073188828
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260119_10h49m_gite2d336=
3.readme)=3D
0faa9a9b216c9be1ce866c57885679b47d2dad2f9d7c8610a85da9d7ae05728c
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20260119_10h49m_gite2d336=
3.tar.bz2)=3D
fc6aedf0c5682c2132727f4500e037b8ca19320dc5ea57b58d1e51898d3f6ea9


** Major changes since the last release:
- Support for Win32 named streams/Alternate Data Streams (ADS), if the
NFSv4.x server support NFS named attributes (e.g. Solaris >=3D 11.4,
Illumos, FreeBSD >=3D 15.0, ...), including NTFS-style renaming support
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

