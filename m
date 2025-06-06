Return-Path: <linux-nfs+bounces-12178-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FFDAD08D4
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 21:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1AA7A99E3
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 19:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79561DE889;
	Fri,  6 Jun 2025 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB+ThKEx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42A323D
	for <linux-nfs@vger.kernel.org>; Fri,  6 Jun 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749239301; cv=none; b=jU2t8T6zf4qKoKHZfk3357nkvSS3Cr92uJ4G6duwbdbethfPJeBnzpeB+QlIBDTh+EKI4xHKVdkBt3sFCHWdHbmCH8SqDKupxcs5mXMXYgtH3ycswtgRDSCfiO9IGexDfoD7iNC/x7jOoTEQFhXmvJEU0AQunQdxgQZ6EMZo7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749239301; c=relaxed/simple;
	bh=68ZnoTbSYZGs6zm3vKKbhFlDCRhf+Sxt6J72x4j5e4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HsdT7qOFas7KzQrkLESgkYbyOOrHceWS7+fwVBw6AwL99xafxVZe7jQ66E0GH8no8YdVYh8EKm67/KDHTRJACfeQv5LNIm5RnPAhtkdNHE7Cwr+hAByNy6FaiOamoiqKZvCY7JIflRR5t3yK5yCu/XAeAZaMUWZSmh8BdpTlBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB+ThKEx; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-604f5691bceso5040903a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Jun 2025 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749239298; x=1749844098; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGDVjsiRb8TXDxan1ctBOY9JFbqoeBL6CSTLLRGH6rI=;
        b=EB+ThKEx5NlFAfRv2tPpoN2K6FD59sbwJSSn08UUcBUQjNbg84eReFRGhQ5Rm/AYhb
         SN3xR8vO8uxsbb6O7krGNmCr5/C+LuUbOonAEBYJOLma4DR5ohzNwsi5PXLUdyRTCu9O
         WIzV9jfjaj9tdsWDlfwsmNQ+A7SsULIVdV/Q3QcnR65+TfNiGKJIK+a/hgoR2hnqDrJN
         QzkVN++UAQ5FMyVcPHivGy03u+1TAxBQTyzLNzvQMYPsxzInebnMaiokAx7OGoQh6UOZ
         1aSuSWs/3vppUNHJl3FZEN7b0tHiDX5euNqlENjsco1mpw+VO2Suji9WBUmEIUx/lCdw
         CAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749239298; x=1749844098;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGDVjsiRb8TXDxan1ctBOY9JFbqoeBL6CSTLLRGH6rI=;
        b=UlS63cc3Udn1GMz4Bzh0i5HnDIUmb+LCudI5fZb+fH97nPNhl0XgflKnMNQauZJJOl
         BcLDtJBe7z8+xWFYDMamP8ZsEcZPSJU/SBYTfJTBPmLwUVkLO55BJLIXveqb5IaJqyFZ
         BNhxIDldrZwDJeO5BP2pNf/4kuJq01LdngjvJH8kDr94+gFOxU+VeFI/cLuJuSO5cP0s
         rUz+yqU5HyZfJo7cX+snVyNrY96e78dDpqqXZl0b00tj7z6wngqHhx7fM0enybHmygma
         +l23UsabjzTkg3HwqBdTGeamPZCH1gS+UsADC9Fy1lypGGrjfOPCao75jTrlVzMnfzw6
         R77w==
X-Gm-Message-State: AOJu0YzEqX7lI07vBfAjP++Mdt6TMHF8BlKb7vahJbPggO+vsz9JX4xf
	0fxKbeSYT0zrNcpgqJ159nC9fVR3ZWz6z6O98+fx7JooqVLcrOBnrk7U9y+VhjHj3WeXk7/qkqn
	No8t3jkHkEACeWLBGdpaDupa5WMz/GArtqN+YvYU=
X-Gm-Gg: ASbGnctFXbKkecHaeEgj3EpkLbFaRh5tEeJ773WwfHau64jV72QsjnpM7EgGbq6Uri6
	OHzfTtlK4QcBAq5VpLDcm2RMXFqEuZqUaoKyeGHF/pPcfQNUNiiZB+PWvWQ2DMGFexgCPVjj5Zs
	EsdvGhX0dVbis3nRXzvS5BrbOK9cHxae7iXNxLhjaTke0=
X-Google-Smtp-Source: AGHT+IHurp9napnRlL0k/x7hxJ5RD7qHjYhewK3AlLEU1fyuiswZrTaLKCMfdJ642JoZIq9sUdr8s1ri5u87Y6VXJKE=
X-Received: by 2002:a05:6402:1cc1:b0:604:60a1:7d7d with SMTP id
 4fb4d7f45d1cf-607748987f8mr4428191a12.33.1749239297774; Fri, 06 Jun 2025
 12:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQkv+jOKy_209oDpcMR4q2LM8x2jsaQDxA9sJezC2n+3xQ@mail.gmail.com>
 <CAKAoaQkcxaqPEiNDOTx_e8bLJ2y88jh5-u1FAN6cnwdVrzY7Pg@mail.gmail.com>
In-Reply-To: <CAKAoaQkcxaqPEiNDOTx_e8bLJ2y88jh5-u1FAN6cnwdVrzY7Pg@mail.gmail.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Fri, 6 Jun 2025 21:48:00 +0200
X-Gm-Features: AX0GCFuuRy3j8a33Iyl2SRPyFoRtxzRJ9t7G_k7Av1JmFAOWQo55A_5Q07Gr17A
Message-ID: <CANH4o6Mtb7Oaa5GiCt5WGCqPQo6O0CHD+foFsWwUm+Sy1f5SYw@mail.gmail.com>
Subject: Fwd: [Ms-nfs41-client-devel] ANN: NFSv4.2/NFSv4.1 filesystem client
 Windows driver binaries for Windows 10/11+WindowsServer 2019/2022 for
 testing, 2025-06-06 ...
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
Date: Fri, Jun 6, 2025 at 5:23=E2=80=AFPM
Subject: [Ms-nfs41-client-devel] ANN: NFSv4.2/NFSv4.1 filesystem
client Windows driver binaries for Windows 10/11+WindowsServer
2019/2022 for testing, 2025-06-06 ...
To: <ms-nfs41-client-devel@lists.sourceforge.net>


Hi!

----

We've created a set of test binaries for the NFSv4.2/NFSv4.1
filesystem client driver for Windows 10 (32+64bit), Windows 11+Windows
Server 2019/2022 (64bit), based on
https://github.com/kofemann/ms-nfs41-client (commit id
#e79b93ac7ad74392640018b3a2ca3e74f5050499, git bundle in tarball), for
testing and feedback.

** FULL release readme:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250606_10h56m_gite79b93a.readme
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250606_10h56m_gite79b93a.html
(experimental HTML version)

** Download URL:
- http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testing=
/msnfs41client_cygwin_64bit32bit_binaries_20250606_10h56m_gite79b93a.tar.bz=
2

** Download hash sums:
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250606_10h56m_gite79b93=
a.readme)=3D
957d56ce4e4ec6afd262565238e52f3dbadb08c071f42898977dec31d49fa7f3
SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250606_10h56m_gite79b93=
a.tar.bz2)=3D
10bbc9fc84dd00d6c0d87bc6da319c2bb3c0dff26126eb148eedd89ed01b6ecd

** Major changes since the last release:
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

