Return-Path: <linux-nfs+bounces-11730-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB284AB7948
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 01:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E79D1B65993
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 23:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3AA21C16D;
	Wed, 14 May 2025 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGp9NRST"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BB920E6E7
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747263893; cv=none; b=KbDaV6ci71o0/OM/98G2br84gXMpOZEvd/sD9XbJyUnLn/EhanhlovLIt1K+uDrEp/fmBgLrLPYglJxvNNhArf+9+fejxeEuhI5FemihnSFSl9eOX5Ak8nixLw6akuQ9lXfD8stasE1QyOsjEoevThkKzW/jAK+2a0DNE1FGCdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747263893; c=relaxed/simple;
	bh=iJ3eXMXSILqCF1lpYH7XX+AxoO0z4i1//AmB+vl2P3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ulXTMm5QCWjwkwZGUsJDe8r3o6ZENWZHSe4OqW6FwvNTp3Ecy0bD8gMOFgP7Wfh3/vzkzBZEgUbRixeCfJT1+s9cppVfsghk3R+a6Rap8QRJBfiO3cARthb9u0OysmOGtw/R9LD1/2LOu/+fbIqExJOkwqcqNupL+cw9wfyVD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGp9NRST; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fbe7a65609so658190a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747263889; x=1747868689; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wXpdNKajoX2+L47Q8+7BdYVVq57RuSzQunlZmBVSFY=;
        b=QGp9NRSTZzsn9eTTVK/ZamywzqGVKYx0NO9hIFj88ExxVnMoEQ8rLEcNNOIJvUNQfo
         9Js/R+jlU9r/wVS5zTB7hf2s6U+7cJZBWf2zaeUVsXtuVEGa+bPMyep1XuYarDjvtrsq
         PJkM4w3mdfrOO4WMa4IXir9PCC2dP/HubS/D3qJ0bn/q3DFJhFePWucNn80zc1H2fDIq
         PjZa7/5HLSIR6GljTV7Mf062Fk1mKaVQ53Qe1dbn1BBKyMqejSfoVa4mBt2WN/yRasd0
         NIM72kwBdL48+Ydd5Loq4MgVtMsa6yiO2vqDMaYfN6Bic4FAu8w9U6E+At2DP+UlIYEj
         gSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747263889; x=1747868689;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wXpdNKajoX2+L47Q8+7BdYVVq57RuSzQunlZmBVSFY=;
        b=YVKmtWVqfHlRHAiEb1teACi2hjJlTSdY/hhmLuWGSdQ5COSeeD3jejfsKJiwCocITu
         qT9w3H5ZmiL3DkvE4nkNvOxW48hHubzQ9ttEejIYCPn1qUZ09k0WuFfSH2Ky5GmpUOCH
         eQiNDopK4ROzvLteXmxQ3391wx2wQDAJvDgQ6VHG2c+PRzTpbuNymj8LerxOWIJSI2oH
         f/MjGM2bKzZsZRXrBYURcEUdrQYdoW35iGOpvLD7GYwp4aoJxXYB1YfZONUBcS+e5dO4
         kvwOfB8S4g4mog5+/KrxYAQ6cqMl3hnsvCOk4s/tkK/9+MjeXoFv7hxx5sGpKCCLcmM6
         Judw==
X-Gm-Message-State: AOJu0YyHR5MfQid41r+qYPgMxOknOFyn9OhjbjOynrbUPnXrPlH4jIdv
	dVY1v+HfYlB+pRDd4ySM1XdvJxbQH+MCmRHfzFt3ChTcXanL1+5M2KZpJA6wc9GYKhz0yODVyWK
	Zx+XNNwLjAKSzxCPwVi9qAkKOFSsiZJMV
X-Gm-Gg: ASbGncsRHxs+AmoHFIHCSTHMeFmyvutush/R3beklQbi7EpGIU5p3Xh8YgNF2IIjoQ+
	dDIt/Ee2o6cSfMdSLWrTASNAZsXpcHDp2qRd64YCAk9yVc7rc6gQHRiWVMVk0kqC4DNzwutFhYc
	dzhytUc3OvAMYh15VNnhJzMgRkFRSdzLBk
X-Google-Smtp-Source: AGHT+IExgja5DzE0JObJwZW8r5BVtRiUZtXVtF4gMMZMUHs/xtr7tpFnrBhRPfc+bn1/ORfFR8u6/1XTStO7b5skOGk=
X-Received: by 2002:a05:6402:1ec9:b0:5fd:194e:9ee3 with SMTP id
 4fb4d7f45d1cf-5ff988d44e8mr4292147a12.24.1747263889222; Wed, 14 May 2025
 16:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmue3zaStgJcOa+29Jh-k_H8QyD3a0=kB4E25feUT2X8w@mail.gmail.com>
In-Reply-To: <CAKAoaQmue3zaStgJcOa+29Jh-k_H8QyD3a0=kB4E25feUT2X8w@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Thu, 15 May 2025 01:03:00 +0200
X-Gm-Features: AX0GCFtNby9ebj1tf2n4i0vteUAxcTgLJUK9wUmRKBdrSZEsHQuku3sIPv4XKG0
Message-ID: <CANH4o6McqtFUmCO6vBH8JD+aS142FAKcqxi8GkW2g2Sj=hm6yQ@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] ANN: NFSv4.2/NFSv4.1 filesystem client
 Windows driver binaries for Windows 10/11+WindowsServer 2019/2022 for
 testing, 2025-05-14 ...
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
interesting new feature, because it's "on" by default for all Windows
11 applications which copy files

Thanks,
Martin

---------- Forwarded message ---------
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Wed, May 14, 2025 at 8:49=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] ANN: NFSv4.2/NFSv4.1 filesystem
client Windows driver binaries for Windows 10/11+WindowsServer
2019/2022 for testing, 2025-05-14 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!

----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32+64bit), Windows 11+Windows
Server 2019/2022 (64bit), based on
https://github.com/kofemann/ms-nfs41-client (commit id
#0dc698b9c563c7958a52862ed10d0758f3522fb3, git bundle in tarball), for
testing and feedback.

** FULL release readme:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250514_20h00m_git0dc698b.readme
** Download URL:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250514_20h00m_git0dc698b.tar.bz=
2

** Major changes since the last release:
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

