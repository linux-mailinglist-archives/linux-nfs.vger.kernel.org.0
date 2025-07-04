Return-Path: <linux-nfs+bounces-12895-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 442B7AF8FBD
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 12:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBD01CA5A3E
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6B2EF9CD;
	Fri,  4 Jul 2025 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsq+h53Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F972EF9B9
	for <linux-nfs@vger.kernel.org>; Fri,  4 Jul 2025 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624088; cv=none; b=gAF4PakZrYfpOkcdkWpWjgxGYexUW5ePIKMC6Ux/lIxjuKHGYsMEMmVjzbB13Nt1iD8s4IM9oPmXXWG9WRQlbtKfidVMrH51t00JTq5bYP/qiehZJYBcMkO1oUIWp7vWfCBrSSfmpgMj1KCX5HraCO8JZqivGS2gYS35IpUTrfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624088; c=relaxed/simple;
	bh=OaWTXM9Hx1lfhwjTHRA9oM51mtfQ9KDG2XN8Ey0LTZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BXW8AJGuPXa6s0Vb7gpD9kdtWHI9LB9Y9tWio+62k2jsOl82TTFcfh7nrzBUqzbc6gnScmUjQZZJE8Tah5Ni1IE9WzUGWUx3Oi7Gb3cngbibvsVxx5gbHcMiSOkWAFOxL4rsa35Yt5zOoKmPO0OX5mMqvy+64yBk4JS0ZbrUW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsq+h53Z; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60dffae17f3so1289067a12.1
        for <linux-nfs@vger.kernel.org>; Fri, 04 Jul 2025 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751624085; x=1752228885; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnPueBfmQovh/Kpy8zo+7fPrd9PCCf24mVjEbeexsw8=;
        b=dsq+h53ZrAVPEHMOaSNu/hdtPv2mxPLF3nKO75DruzGxP0JNepGLCXK7TYutwhHGQY
         JpI4RhE+dtDW955t5AvI9LQ8nFNfVrI8zdyUUZE8yG3/AX5Q4xAYCTVFLEJkgNXmVz27
         LEDEeWOj8XdMg3F3qMXxZhWdo1eDncK/PozzP8MlwNRF1+JBbIurwEM8X6vAafCQt/lK
         fPt7DMQvmkhyluCZPp5cMegH/O56zONCVQGpC+FiXLycVBed5Act1rbZV6NZBlp9wsiE
         lvaeEsz20/lv4B2RtzwKt0YbokjP2nhVwHfDtthVPLPdcKaTITHkID6IDTY4GJZwfSHE
         69JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624085; x=1752228885;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnPueBfmQovh/Kpy8zo+7fPrd9PCCf24mVjEbeexsw8=;
        b=IwGcMO1jjb8STp1nUXyFO40t59xst1WzlBLFkRx+7wDs8IORUb2rv+NzFVjjMumALE
         4NBs3LOY+XlD85XGAUApR5qjM6A7lfXK4jS61RDrkwgIu8p1RixZV1QS174RGt9UY3l4
         /WqI347/7QPqIF2zwsM3edtMbzZYqnj4+gdbmYVjPgJb0TEvY8lQQ2Gg5LAB5JI9xWvT
         DYluGKZKwy9SBeKQjmBLaMXzW6dRlxVxSS9Tv6V8HnfAt3bKGQAId7y7B1+kMACFvTF6
         J4+41EfdMbA0e1THfhWRdTEtgr/bJhNMA8Lmt3unzly0reGWElWcFQHYLAAKjrZ8wpQq
         pcDA==
X-Gm-Message-State: AOJu0YwbGI4Yxf8uBTHhUQIzU0qHQaGr4JQ1Uym/6gbCDPv1TeDqowVg
	2hO2ufQ190BLH8Q2MyzQ96kI+T8KbLQlJqOu2406VpHkx8uAO+tEahDD05a8zmOaZaANi8jEWN6
	XFLOFuzv2QhVB5r12gtatXUn5kT5UW3z42eKLmPU=
X-Gm-Gg: ASbGncuNQl3oNA5oCkXrioRwKKUloZG4G7bmWkdFRgq0mxeGfhV2sRmjRYQgV8l3f9l
	OgcUeZqNpN6C5qoPH/cWpVY7lEn7E16APCnNNb5rqxlhUP15zegKlJ3pgj1M3IeDaAjRRiulI8h
	vhvQYsN/5Jn/kyCw7Aj8ptd9N5LKmik3S2RcUwcoYFeo8=
X-Google-Smtp-Source: AGHT+IH7B4ir+QnviXslG6/wip+0l8CPG2wm/pRnZZVxJ5fkwtIEUYawpZisATkXtW1Rn2Y23aRWN9+7UQyiq73yVIY=
X-Received: by 2002:a05:6402:518c:b0:607:35d8:4cf8 with SMTP id
 4fb4d7f45d1cf-60fd65156admr1431279a12.11.1751624084368; Fri, 04 Jul 2025
 03:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmCwj2VNJS7dTBh3bXOF3DqMkLP2t4s85ewh00LpVzmiA@mail.gmail.com>
In-Reply-To: <CAKAoaQmCwj2VNJS7dTBh3bXOF3DqMkLP2t4s85ewh00LpVzmiA@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Fri, 4 Jul 2025 12:14:00 +0200
X-Gm-Features: Ac12FXzRSvP1yJ-4ikPw7TtjL1lDYc2CJ9O4JnblFeViLshWKLS4oMoxpxbDA3A
Message-ID: <CANH4o6NfZABc4GS7kPJhJW9LFSR23TvpXE_UHWWm5h4xPiachA@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] ANN: NFSv4.2/NFSv4.1 filesystem client
 Windows driver binaries for Windows 10/11+WindowsServer 2019/2022 for
 testing, 2025-07-03 ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
AMD64+x86 and Windows Server 2019+2022/AMD64, but interoperability
feedback with NFSv4.1/NFSv4.2 servers based on Linux 6.6+ LTS and
6.14+ would be great.

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
Date: Thu, Jul 3, 2025 at 9:09=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] ANN: NFSv4.2/NFSv4.1 filesystem
client Windows driver binaries for Windows 10/11+WindowsServer
2019/2022 for testing, 2025-07-03 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!


----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32+64bit), Windows 11+Windows
Server 2019/2022 (64bit), based on
https://github.com/kofemann/ms-nfs41-client (commit id
#0b05f267c063c3d40e32727304e9f6ea9fc3b00f, git bundle in tarball), for
testing and feedback.

** FULL release readme:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250703_20h33m_git0b05f26.readme
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250703_20h33m_git0b05f26.html
(experimental HTML version)

** Download URL:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250703_20h33m_git0b05f26.tar.bz=
2

** Download hash sums:
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250703_20h33m_git0b05f2=
6.html)=3D
95b5507674ce36fc711644ef0d16a93efa1121183463ef676753f5f740ed5301
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250703_20h33m_git0b05f2=
6.readme)=3D
093739659441a3c66dc552b2cacd8454d8c82f8fee478d0f00ca8897a015d377
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250703_20h33m_git0b05f2=
6.tar.bz2)=3D
faf38128e2e7edbf6b3ca6f314dce81ebb224792394451683ef6260a6d1ca645

** Major changes since the last release:
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

