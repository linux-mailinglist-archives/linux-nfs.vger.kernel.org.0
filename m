Return-Path: <linux-nfs+bounces-14109-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB938B4760F
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 20:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B661562999
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447E4227B9F;
	Sat,  6 Sep 2025 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKD+hmgI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5103F2036FA
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183057; cv=none; b=m/hUB6PVSUi6Sumjv6V6DGW/3vkkUwPPCKpffEvLA/fYHIRzgQ6FFNlitKfVfgefKN6uvSvV3lAbvNDGzxqtdMBxK9/vovboB18xqBTyjJOIawks135fWLK2LhmqDBC4Sw6skVYetQfy9mo9f+tGwOsi2XlOAESaxoHQqjBID9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183057; c=relaxed/simple;
	bh=Uqo0E7vJJv5Lll0SptWsTVAKYWV4G4VtBHy+JGIDLtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=f7OT6exhcuixRK/Vy1TaTx6WBLbEBNw4yCbk/apT61CWFQNkjF1RB1GrVH3T/DWOQObmz5IElh+HtsfDSKZUMOVKEpMTgwbj4f8KxczQZQpLDiWdN63YPZRIHJ7oigRNKQF4oxFyLgNZjLKD1L2XU32lWGkfhsR4T2c55m33dac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKD+hmgI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so4458369a12.0
        for <linux-nfs@vger.kernel.org>; Sat, 06 Sep 2025 11:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757183053; x=1757787853; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59w4BTLcCmC1AlyWHsXZgud+qhjn0HcR/JimY1vU1JU=;
        b=GKD+hmgIfL7e+Rl7Oj+cDpT00sIT5CBy0+UcuP5PHm1ZUaQxP5MmuYdqp3Gnp8bO36
         QMhk+pjKOkCe0FI8SS2m/ZSVUgdc4RP6Ql7bWyJo/96IqGpnIkpzdAdxYNWhd1jyeVKK
         RFcTw6m0vYe8PYy3ubKfJFLZQjqW30oTtCF4dCun08CeEgFCl4qP5zKsF71sfPMcW7pJ
         RQWKw8FlA3qMwVQXKHoJBx0lXlGGgsLlMmVYjdndNVm90cviMU420WbjyJLUvxFt8n0p
         kLXzljkLQ+rFC1kP2HyyKi9px9jg0m7ZRWxhBcYcKXG3wlJ3n+giZjksrEmXxhX8ROLn
         v3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757183053; x=1757787853;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59w4BTLcCmC1AlyWHsXZgud+qhjn0HcR/JimY1vU1JU=;
        b=UDblBQaLMT+ead2fzk5h6dpetsg6hDWOiKd28vJxDDZVNmDFlequ5UUydg2Krelj0H
         Mvy5wBNYOC1CmFVnfiO2jvzoKFk6FUMl65N9EZQ1GfO9KZ5tVczxI+UREJFcgfpm/1Q2
         rcRlpv8hoNsxghhAqp0tBS8u1EcHKlO6lLQOi0o2NdNAIQ1ztBMyKeytaOhacEV45996
         f0ehBSn2B+z5kJyHY/9XTPLeji6kJQ7gKCabHGG5vkI1FtjZhFUQALtydFhRQREdwn1/
         wrOKl2AcOozMrGd8YFzkSfdXz1LjEOB02N7cwZGI61RoHAFJmiYDg2rqoWK+YxUjiiAF
         AvIw==
X-Gm-Message-State: AOJu0YxZlUUe72ngTAZTIYfVzmdOZBfFRvMtX85JWw5JQLv7QuKFOGat
	6s+FYMepcn0Ofdmy3bb9Ft3AeEn2UO1tP0O5ztlrirIcsCoxUZvVnFzP93mwUJzKAc3sYcyyZSJ
	SR/8Y5+9tzp2frJV8XAdCaw6bUIfIepGMqb2d
X-Gm-Gg: ASbGncvLnIkt4kg5m7tIleZu2PhAxZ06u9CH3InfIj22/XVhw0xoaBZ7QQ3mAII/Rj4
	8x02CYYQ4a3lnAYoaCvfg7eSOrq3394a29hcUNQh622Tq1Lm2Kc7emOsKnwgzmaPfRHxvFLlyfA
	tysrwb8qB2A9svb2M/alj62sOacHYzA46K9bGggoccReKTWJifJ2PA3cLmgKjG3ZEIA7CK1gLsr
	oRJh0M=
X-Google-Smtp-Source: AGHT+IE1bq5SCSBVDvGwiE947+X5JoU9+kJs1HKHxG0MPwaKwTKoBKuO/weHt9Ljjs4rBJUXUwq174YTARhJjaZLgD4=
X-Received: by 2002:a05:6402:280b:b0:61e:a5c1:fd27 with SMTP id
 4fb4d7f45d1cf-62374f44cd7mr3054010a12.0.1757183053217; Sat, 06 Sep 2025
 11:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmUgjYc+ofToW9x0Du97foU57AmYr5=FUN7afcKUwoDRg@mail.gmail.com>
In-Reply-To: <CAKAoaQmUgjYc+ofToW9x0Du97foU57AmYr5=FUN7afcKUwoDRg@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Sat, 6 Sep 2025 20:23:00 +0200
X-Gm-Features: Ac12FXwQjFj1RnoXVy80KVGAEq5bCMbAJv12DQQlYnKkV2I5JmtPl8NR84SyGQg
Message-ID: <CANH4o6MPK=nzGtds0C8MTGP53t+1Y1BOMX29aKDqy9sd-CVsKQ@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
 filesystem client Windows driver binaries for Windows 10/11+WindowsServer
 2019/2022 for testing, 2025-09-06 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
AMD64+x86 and Windows Server 2019+2022/AMD64, but interoperability
feedback with NFSv4.1/NFSv4.2 servers based on Linux 6.6+ LTS and
6.16+ would be great.

News:
See announcement below; xcopy.exe/cmd.exe copy/MS Explorer file copy
acceleration via NFS server side copies and copy-by-block-cloning are
IMO the most interesting new features (cloning now works with Linux
nfsd exporting btrfs or xfs filesystems, server side copy with all
filesystems), because it's "on" by default for all Windows 11
applications which copy files, followed by wings.exe (Linux users read
man sg(1)) with powershell support.

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Sat, Sep 6, 2025 at 12:33=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
filesystem client Windows driver binaries for Windows
10/11+WindowsServer 2019/2022 for testing, 2025-09-06 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!


----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32+64bit), Windows 11+Windows
Server 2019/2022 (64bit), based on
https://github.com/kofemann/ms-nfs41-client (commit id
#46aa157ba1031b15d6a3539d7204c95da32fe0d6, git bundle in tarball), for
testing and feedback.

** FULL release readme:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250906_10h29m_git46aa157.readme
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250906_10h29m_git46aa157.html
(experimental HTML version)

** Download URL:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250906_10h29m_git46aa157.tar.bz=
2

** Download hash sums:
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250906_10h29m_git46aa15=
7.html)=3D
5e390967c8892b720cf8a426ceb78e33d6f10ecb4c24601dfc9892b4366fa276
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250906_10h29m_git46aa15=
7.readme)=3D
4981aa747db803f57c1756edaa23e9528dcc2b4620b358f4aceaf4aade2d26aa
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250906_10h29m_git46aa15=
7.tar.bz2)=3D
bdd4c2bab46d7c1970dd5dfc995bdcd03bd84df5478a04191d152688d255f795


** Major changes since the last release:
- /sbin/nfs_globalmount, a new tool for Administrators to manage
global/machine-wide mounts which are available to all Windows
users/services/logons
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

