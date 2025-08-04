Return-Path: <linux-nfs+bounces-13403-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C28B1A53B
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 16:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4B2167076
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6141F4612;
	Mon,  4 Aug 2025 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5rOuyFj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842B22F2D
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319014; cv=none; b=pzuiiREZmUC7nRRQ1jHIaHGq7nt5X3at33Tgh2s/wftsfRKzG44gKBYqT77C9N2JTo0/la80p5DKXAl/DBUPNJetHdixYuQJYkU++jvwjjJkDWwgNxqn51jZKJOpxQpqjByc0Cm3VySwT799X5acaQva9ZJTmxJUaNIXEKzV/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319014; c=relaxed/simple;
	bh=mrA5IcxqjHG94Opdm9o8kGEANhrLjACRP3qlIPyifso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bQ4fLzQ+IgfK9VGXpPUudxsVklgWyVFSUDf+Dogb8MRc3P0WELYqSrPxuBpfP5yPDMdRMZyPXR4TjzvKoRPeLfV4QTOvHAc4MbJcLefWXs7dRHWIbGSWiMF8GdebszIjXk3CE4YM2XawoX/MPbX/DjCIyrgWb9mzi523rQIRx3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5rOuyFj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61576e33ce9so8208984a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 04 Aug 2025 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754319010; x=1754923810; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvZf87iKejwCcjc5RF4KVBpwikm5Bv7Lrgnvnt/bBOs=;
        b=K5rOuyFjHj6OKjwnJJiETrefldyGXw7/EgDoS3yITDGUN/MqsNmJxs44nQX3dWtumt
         Pf7s4wZcdCu1O6pQQu14Vy3gxj2/rsiLi6tywaRlqW+29oi40/tP9gJP+oetjZRfP8RM
         Z3p/VH14OF3ZmMHFZDwhzLSRzyLn7gyWBiiaB/sGWY+XXd/l5ANFIz8w2mtxpZO4zbTS
         MaxmHLXnWWxtOCnaZlfEWAMkHxrwAryg5bQZKQOtwezrf6MOzkrU1KJDwPPEAaGGIHqM
         oDgpEDG5haC/17XMWKL/UQlHoW5cBasCrwcKbNROWw2dno2AwLDVGxJe8GLbySid1C/h
         9zOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319010; x=1754923810;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvZf87iKejwCcjc5RF4KVBpwikm5Bv7Lrgnvnt/bBOs=;
        b=njjrqTmnq+OmesMrb7CMhxCal3p19fKPdGGlesztH6fcyYjxdIe1Gu3TjrJkdL/btw
         38BXuYLmCGtsQ7ha3GcawxwhCR2mM7ZVex7dNquGZzR3loAQ5huJj5nMD25itEBq2AQy
         NwvRlBNb0ydUimSiwQ3V5wgPQe+VwV04709BiZUCK2Y3B5bRsUnj2QllwWLVtn/70RpK
         6gzKQsqeDEHSR2Cc7maNCl6OhVOMP9ByaBUoiXhEYigyZO7nFsNOl8SPvMiTYJCRjrei
         +PRE1nHMSDWF5YEuR9pLmaps1tjdUEMclC3NXjTuJdXT4Was5uX2qFLiKinDAasNfmNg
         4poQ==
X-Gm-Message-State: AOJu0YzOeXSOx61UX3fYRnFDGsOPW3MRQ0a2rHLrIeuE5DBl/yINkbmd
	/FQXZn+kGCLbehySz0D2ty2C6mHHO53qD8l4T5a0oQ5TjxIb4ptiGI6eZj4Xzgl8VsyfKHTSa0S
	Y8oSghevkl9hU5vkwVV7d9aBvniZ+iOlmgiS4
X-Gm-Gg: ASbGncvFWmd/erqEaQsHtsA406oS5SFZAQwf5Q5zoyBPUSoG4nAgXd9jBGVAnkxUfkr
	gfnIcL5yMXRZC9DEoYTrY1E5RYA60TIoUZvz/EKg4nwImxxjL/rWlFrPK1k62SlkwPyADa2bdSi
	C24podKW22r3G7Lb+MI4dkUFE9NacIx3MMKdgAxSrT0CmLO6zXXtYy182OhjWp+/6ej/pEDhh+H
	sonZ8o=
X-Google-Smtp-Source: AGHT+IHWItSS2q6oDOq0SZ4K5kj2Hs7d+qheBTYdhDXe5aM0HscwyHKSUgdYwJKt4NKExs9xpZCWq3UDwF0ub3mx07g=
X-Received: by 2002:a05:6402:27cc:b0:607:35d:9fb4 with SMTP id
 4fb4d7f45d1cf-615e5e52361mr9031464a12.15.1754319010294; Mon, 04 Aug 2025
 07:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQ=9s64SD4BVvbQ4+4QGmfd2h+sh9-ihr1rBWyEGLYcdTg@mail.gmail.com>
In-Reply-To: <CAKAoaQ=9s64SD4BVvbQ4+4QGmfd2h+sh9-ihr1rBWyEGLYcdTg@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Mon, 4 Aug 2025 16:49:00 +0200
X-Gm-Features: Ac12FXwtFamglw0qGUC930Feu9JZvKp-fqvwu-Zj3xfaWtMtpMhD4FKT_rXrxcQ
Message-ID: <CANH4o6Oum1P_O4xW+7d6jVTFD8jhf3hVvd1R3xF=1dn=QJpKmw@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] ANN: NFSv4.2/NFSv4.1 filesystem client
 Windows driver binaries for Windows 10/11+WindowsServer 2019/2022 for
 testing, 2025-08-04 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
AMD64+x86 and Windows Server 2019+2022/AMD64, but interoperability
feedback with NFSv4.1/NFSv4.2 servers based on Linux 6.6+ LTS and
6.16+ would be great.

News:
See announcement below, copy-by-block-cloning is IMO the most
interesting new feature (now works with Linux nfsd exporting btrfs or
xfs filesystems), because it's "on" by default for all Windows 11
applications (now working for 32bit *.exe on 64bit Windows) which copy
files, followed by wings.exe (Linux users read man sg(1)) with
powershell support.

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, Aug 4, 2025 at 1:58=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] ANN: NFSv4.2/NFSv4.1 filesystem
client Windows driver binaries for Windows 10/11+WindowsServer
2019/2022 for testing, 2025-08-04 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!


----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32+64bit), Windows 11+Windows
Server 2019/2022 (64bit), based on
https://github.com/kofemann/ms-nfs41-client (commit id
#d02fdef0eb50ffead29d88bd6e6899cfc49decd7, git bundle in tarball), for
testing and feedback.

** FULL release readme:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250804_10h39m_gitd02fdef.readme
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250804_10h39m_gitd02fdef.html
(experimental HTML version)

** Download URL:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250804_10h39m_gitd02fdef.tar.bz=
2

** Download hash sums:
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250804_10h39m_gitd02fde=
f.html)=3D
2972b6440f8911e3a2007498b5fc4307fe86e8aa8612a529cd20548eddcca73f
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250804_10h39m_gitd02fde=
f.readme)=3D
68d91ac23cfb450c41c1bfcc22609cdf52ded26db83b36f5eeb058e5237b5bbc
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250804_10h39m_gitd02fde=
f.tar.bz2)=3D
c7ffb058cfd7df5bd905ba10b15efce5c22e31c8bcb07f477dca47e19dcc62fd

** Major changes since the last release:
- Maximum number of ACEs in ACLs has been increased to 128
- More software tested for compatibility: MariaDB, Microsoft Office
2016, Visual Studio 2022 work with msnfs41client
- Volume label is now the nfs://-URL to the server (up to 31
characters for Windows Explorer compatibility)
- Support for user and group names with non-ASCII (e.g. Unicode) names
(like German umlauts) in ms-nfs41-client, winsg.exe etc.
- winsg.exe now has a /P option to run powershell.exe with the requested gr=
oup
- |FSCTL_DUPLICATE_EXTENTS_TO_FILE| (file/block cloning) now works
with 32bit processes on 64bit kernel
- nfs_mount.exe now enforces that normal mounts need nfs://-URLs with
absolute paths, and "public NFS" mounts need relative paths in a
nfs://-URL
- sec=3Dnone support
- Improved /sbin/cygwinaccount2nfs4account script to better handle
creation of Windows Domain accounts on the NFS server side
- Various documentation+READMEs converted into a single DocBook/XML
documentation
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

