Return-Path: <linux-nfs+bounces-14110-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D069FB476E9
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 21:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26669A42B8E
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 19:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB287273D77;
	Sat,  6 Sep 2025 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImFWGjwg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B6710E0
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757188130; cv=none; b=ffNm+XSSuDHHBLhcjoKHGQ2jW3iCdqmYuZ8csV9PlZmVETOdN2tGVW+QmE3s1eFJNHgVCjxfp6sEhElOGJj5RAZVA665klG0/VdxZCXITAeYDv51cIO03VGhkqs+z16W1IOWB13RgC56PBToUuE2NqMs1uOoAc2GISeytIg46iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757188130; c=relaxed/simple;
	bh=RhJmxFlTMN0jGNOWVhtQrnV4jlOY6cMKXmaBExApM+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nnw/QTe27XeenXRtcaspOwEJtpAMmo9xNo78UVS/sWJhG3v3Itc2rE20cEgtKCc0kSdUvAHRkM1+sJCIKsOGV6oNH8p3RXnW5wGDjOqtxSa5DCr2UyCnAsJc17sZNZXkHoGRz6QkI0ZVtvePIcntXfpL0v6dr5T/lAvkDca/qSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImFWGjwg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6229f5ed47fso1634477a12.1
        for <linux-nfs@vger.kernel.org>; Sat, 06 Sep 2025 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757188126; x=1757792926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chlqNuf8QSUVthWKETxr++++nqWQdsXU271WibGsNrY=;
        b=ImFWGjwgbyMZr07a8rVArp5UjslC4hOJXUh1Oim/KOUfEs6N0TekiXLq/NmMTr9xAu
         OGAr/LiCS1KA9WhajDZJmN3us/DkX2/v2zNYON92YHCSKbDcCAZI7m3De9Siqp4iCm0V
         SEvrgR5SMRZH06IWBcDqQfCJxr5Aua5FV7mu1OtyuPSS+s86YrSLUoY1Zhy1qJwXBgzr
         D5rpgbpO/j6ufA4Gtp1BJ0bCnzy1F5r1AHrRSAimfJVcfi3VRgw4umKKo5iX22n+sKe5
         5sKz0MglhIeO2HScC3Wg9NGBIP/MnSasnGNJdNpb5zoMW4wAFe2px8RGv5d7pJQVl1nV
         BH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757188126; x=1757792926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chlqNuf8QSUVthWKETxr++++nqWQdsXU271WibGsNrY=;
        b=gPupmqJxWGt5Hd68yFebuVAVagcRowztl2yeWZvCQadkWeZ1OPQX26to5JGa5WE2Kx
         2NefqYyz+Vkgz3x+iyHnent2VAvXCH+kW+phJu+j2idL85Nv7/D6FE4tVrXkHcgQtPJm
         GGs/pqt8jz9LdvwiBi72IRLh/056ZQ8goCBHONuotSflPbpKFXzhTW+Vw2CdFFETJWMU
         CmE39wVVeM+gBrV2DBewVGL+9eQofZ564srN67itu7a2FX29UQ3i3EeZKCqW1u8FuVHf
         6XqYbBU3WAz4e3zr06zopg/thF6krr9Sy1vqj9hN6oLGd/dJdrHN7+9jhl0HiKkeLkFV
         v0Ng==
X-Gm-Message-State: AOJu0YxPnQd4AS2gnHGVbYT3rPPZ7FHGadTRhvfK0DQJpc6YUIuohX6P
	0yJzYvooCjLCdb2FPac6S1VIdreGVlX4B0driVTa8shNtkjI756FITNuUf25x9yoFsMQCYtib/k
	KklXKykVPrstsMrsVaUV3bB2G0xZufIEl
X-Gm-Gg: ASbGncvY1OHWSap1ysoObyJ28QCYY3hBKm655UyUuWenFjXJEeu8lcpTSVmpi0CAm1o
	f83SznXfGTHl2OtkSkNp6llKK2n5BUb07fGwQ4TeBwuSJ0+fsG1NKnq+XrUJemdYeVmEhtB3Nvs
	qsZme06Yza1mmeV3Hflb0UmijO2TZ+6xcA5NBSyIIc+lhyUU/RFlInM0x046dJ3AY64/EgPEVV2
	Ie/8dXrqiZFxoxhxBorJh90/elGFg+j/2A4BO6PgdP3gKn7uA==
X-Google-Smtp-Source: AGHT+IExn2mPsQnRrUzuWf/ruAVlBQYuQ2ODc1oEZix3hqBrElYjVT0NTlCftK8kqb3bYqz80x4qcxW/oP6zSimEi+s=
X-Received: by 2002:a05:6402:3507:b0:620:f9c3:4566 with SMTP id
 4fb4d7f45d1cf-6237fa3d351mr2629000a12.21.1757188126174; Sat, 06 Sep 2025
 12:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKAoaQmUgjYc+ofToW9x0Du97foU57AmYr5=FUN7afcKUwoDRg@mail.gmail.com>
 <CANH4o6MPK=nzGtds0C8MTGP53t+1Y1BOMX29aKDqy9sd-CVsKQ@mail.gmail.com>
In-Reply-To: <CANH4o6MPK=nzGtds0C8MTGP53t+1Y1BOMX29aKDqy9sd-CVsKQ@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sat, 6 Sep 2025 12:48:34 -0700
X-Gm-Features: AS18NWDEmuPgB-njIIOTImArCPVoens4kCU_vEuFWa1GQldqR2-7fZHE-G6RT8M
Message-ID: <CAM5tNy6d1YDEoUMz1MHySCSKet_dqTcDVgMY=CgX_vHc8hKWwg@mail.gmail.com>
Subject: Re: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1 filesystem
 client Windows driver binaries for Windows 10/11+WindowsServer 2019/2022 for
 testing, 2025-09-06 ...
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 11:24=E2=80=AFAM Martin Wege <martin.l.wege@gmail.co=
m> wrote:
>
> Hello,
>
> Please test the binaries. The NFSv4.2/4.1 client is for Windows 10/11
> AMD64+x86 and Windows Server 2019+2022/AMD64, but interoperability
> feedback with NFSv4.1/NFSv4.2 servers based on Linux 6.6+ LTS and
> 6.16+ would be great.
I do plan on testing someday, but I will note that it would be really nice
if someone was to test this at the next Bakeathon in Oct.
(You can do so remotely using tailscale.)

rick

>
> News:
> See announcement below; xcopy.exe/cmd.exe copy/MS Explorer file copy
> acceleration via NFS server side copies and copy-by-block-cloning are
> IMO the most interesting new features (cloning now works with Linux
> nfsd exporting btrfs or xfs filesystems, server side copy with all
> filesystems), because it's "on" by default for all Windows 11
> applications which copy files, followed by wings.exe (Linux users read
> man sg(1)) with powershell support.
>
> Thanks,
> Martin
>
> ---------- Forwarded message ---------
> From: Roland Mainz <roland.mainz@nrubsig.org>
> Date: Sat, Sep 6, 2025 at 12:33=E2=80=AFPM
> Subject: [Ms-nfs41-client-devel] [Announcement] NFSv4.2/NFSv4.1
> filesystem client Windows driver binaries for Windows
> 10/11+WindowsServer 2019/2022 for testing, 2025-09-06 ...
> To: <ms-nfs41-client-devel@lists.sourceforge.net>
>
>
> Hi!
>
>
> ----
>
> We've created a set of test binaries for the NFSv4.2/NFSv4.1
> filesystem client driver for Windows 10 (32+64bit), Windows 11+Windows
> Server 2019/2022 (64bit), based on
> https://github.com/kofemann/ms-nfs41-client (commit id
> #46aa157ba1031b15d6a3539d7204c95da32fe0d6, git bundle in tarball), for
> testing and feedback.
>
> ** FULL release readme:
> - http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testi=
ng/msnfs41client_cygwin_64bit32bit_binaries_20250906_10h29m_git46aa157.read=
me
> - http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testi=
ng/msnfs41client_cygwin_64bit32bit_binaries_20250906_10h29m_git46aa157.html
> (experimental HTML version)
>
> ** Download URL:
> - http://www.nrubsig.org/people/gisburn/work/msnfs41client/releases/testi=
ng/msnfs41client_cygwin_64bit32bit_binaries_20250906_10h29m_git46aa157.tar.=
bz2
>
> ** Download hash sums:
> SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250906_10h29m_git46aa=
157.html)=3D
> 5e390967c8892b720cf8a426ceb78e33d6f10ecb4c24601dfc9892b4366fa276
> SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250906_10h29m_git46aa=
157.readme)=3D
> 4981aa747db803f57c1756edaa23e9528dcc2b4620b358f4aceaf4aade2d26aa
> SHA2-256(msnfs41client_cygwin_64bit32bit_binaries_20250906_10h29m_git46aa=
157.tar.bz2)=3D
> bdd4c2bab46d7c1970dd5dfc995bdcd03bd84df5478a04191d152688d255f795
>
>
> ** Major changes since the last release:
> - /sbin/nfs_globalmount, a new tool for Administrators to manage
> global/machine-wide mounts which are available to all Windows
> users/services/logons
> - Implemented |FSCTL_OFFLOAD_READ|+|FSCTL_OFFLOAD_WRITE| (e.g. used by
> Windows 10 xcopy, Windows Explorer etc) for server-side NFSv4.2 COPY
> - Better FreeBSD 14 nfsd compatibility
> - DFS service no longer needs to be disabled
> - More software tested for compatibility: MariaDB, Microsoft Office
> 2016, Visual Studio 2022 work with msnfs41client
> - Volume label is now the nfs://-URL to the server (up to 31
> characters for Windows Explorer compatibility)
> - Support for user and group names with non-ASCII (e.g. Unicode) names
> (like German umlauts) in ms-nfs41-client, winsg.exe etc.
> - winsg.exe now has a /P option to run powershell.exe with the requested =
group
> - nfs_mount.exe now enforces that normal mounts need nfs://-URLs with
> absolute paths, and "public NFS" mounts need relative paths in a
> nfs://-URL
> - sec=3Dnone support
> - Improved /sbin/cygwinaccount2nfs4account script to better handle
> creation of Windows Domain accounts on the NFS server side
> - *.(exe|dll) executables are now signed with a WDK test signature,
> helping with *rare* cases that Windows Defender with paranoid settings
> wrongly recognising the binaries as potential threads. A *.cer
> certificate file is supplied which can be imported into the Windows
> Defender to whitelist the binaries if this happens.
> - Support for FSCTL_DUPLICATE_EXTENTS_TO_FILE, which allows Windows 11
> applications which use |CopyFile2()| (like cmd.exe  copy, xcopy.exe
> etc) to copy files via block cloning. Requires NFSv4.2 NFS server with
> { CLONE, SEEK, DEALLOCATE } support, exporting a filesystem which
> supports block cloning (e.g. btrfs, xfs). This includes correct
> cloning of sparse files.
> - Sparse file support (requires NFSv4.2 server { SEEK, ALLOCATE,
> DEALLOCATE } and the |FATTR4_WORD1_SPACE_USED| attr), including
> hole/data range enumeration, punching holes etc., e.g. $ fsutil sparse
> queryrange mysparsefile #
> - Improved Windows Extended Attribute (EA) support (requires NFS >=3D
> v4.1 server with "Named Attribute" support ("OPENATTR")), including
> create/read/write/delete
> - Improved WSL support
> - Support for Storage32-API (e.g. enables use of *.msi installer files
> on NFS filesystems)
> - Cygwin /usr/bin/svn and Windows '/cygdrive/c/Program
> Files/Git/cmd/git' now work
> - Illumos NFSv4.2 server is now supported
> - Solaris 11.4 NFSv4.1 server is now supported
> - Windows Server 2022 NFSv4.1 server is now supported (compared to
> WS2019 this NFS server version has ACL support)
>
> ** Please send comments, bugs, test reports, complaints etc. to the
> MailMan mailing list at
> https://sourceforge.net/projects/ms-nfs41-client/lists/ms-nfs41-client-de=
vel
>
> ----
>
> Bye,
> Roland
> --
>   __ .  . __
>  (o.\ \/ /.o) roland.mainz@nrubsig.org
>   \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
>   /O /=3D=3D\ O\  TEL +49 641 3992797
>  (;O/ \/ \O;)
>
>
> _______________________________________________
> Ms-nfs41-client-devel mailing list
> Ms-nfs41-client-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ms-nfs41-client-devel
>

