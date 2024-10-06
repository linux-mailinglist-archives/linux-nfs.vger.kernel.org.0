Return-Path: <linux-nfs+bounces-6897-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534C3991F85
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 18:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B9E1F20F54
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C2017C203;
	Sun,  6 Oct 2024 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mbosch.me header.i=@mbosch.me header.b="YFbYNkPu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.mbosch.me (mail.mbosch.me [65.21.144.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C93D1DFD8
	for <linux-nfs@vger.kernel.org>; Sun,  6 Oct 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.144.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728230416; cv=none; b=cKCsqEfb43qwpIrXC6CRCzXp7Ks95f6YeQRaGhRR05WSWDEr/L/5FekojHg5AQyKRbTh6IhLMHByLxGmCkJtKNGpeb4jGJhtJN0NswIxEdLcrbkk4OOJYnJfMoLPCRRQKurVZ1s7esY2ml3RNcftA0UOy3LAz90xJz7pcvccCng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728230416; c=relaxed/simple;
	bh=US5/ANGi1vGO9mnBMVlpEl/LAld5nA/qRxSZTeF438s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=WniAi5xN6nshxaRJ3wQTAHyAWjng+kFj3Z+NbXbi5kZ91x0Me8yocZtUIaD7LlWBy02Ct9Eq+9MWdUm5Y0dyZmH6Y+OUcF0jl2/0yxjCS1B6WSgW8C0y4mpaHycs3Gs18V/azjSqesJ2NLtTOEiLq7OPLTeklwVMVEX6Q6nArug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mbosch.me; spf=pass smtp.mailfrom=mbosch.me; dkim=pass (1024-bit key) header.d=mbosch.me header.i=@mbosch.me header.b=YFbYNkPu; arc=none smtp.client-ip=65.21.144.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mbosch.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbosch.me
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mbosch.me; s=mail;
	t=1728230405; bh=mcNTHpuSgHI3cCOV31NQLEE5HXMBb2/agCVuG7Scfjk=;
	h=Date:Cc:Subject:From:To;
	b=YFbYNkPulrYyZkrU3GQLkmPFfPEXqiuhD9vEpcynwUmL9Czd04gu7CFbBYLp7wxjY
	 rFmHVkzeEKkhFZYWDR4OD1I8X+zcpuYxYHdsa8aJpN6vgaxIKEX2WHGeo/dNM19fOD
	 OebUkK2X1WZCTF7QbQ9ehYLejHfs8176PVQBBFvs=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Oct 2024 18:00:05 +0200
Message-Id: <D4OUJRP8YWRM.ATQ7KASTYX5H@mbosch.me>
Cc: <regressions@lists.linux.dev>
Subject: [REGRESSION] Build failure with CONFIG_NFS_LOCALIO=y on Linux
 6.12-rc1
From: "Maximilian Bosch" <maximilian@mbosch.me>
To: <linux-nfs@vger.kernel.org>

Hi!

I haven't found an existing report for this problem, but I observed
that Linux 6.12-rc1 fails to build like this on aarch64-linux with
CONFIG_NFS_LOCALIO=3Dy:

    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: warni=
ng: -z relro ignored
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: Unexp=
ected GOT/PLT entries detected!
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: Unexp=
ected run-time procedure linkages detected!
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o: in function `nfs_local_iocb_alloc':
    /build/source/build/../fs/nfs/localio.c:290:(.text+0x324): undefined re=
ference to `nfs_to'
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `nfs_to' =
which may bind externally can not be used when making a shared object; reco=
mpile with -fPIC
    /build/source/build/../fs/nfs/localio.c:290:(.text+0x324): dangerous re=
location: unsupported relocation
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: /buil=
d/source/build/../fs/nfs/localio.c:290:(.text+0x330): undefined reference t=
o `nfs_to'
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o: in function `nfs_local_pgio_release':
    /build/source/build/../fs/nfs/localio.c:344:(.text+0x47c): undefined re=
ference to `nfs_to'
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `nfs_to' =
which may bind externally can not be used when making a shared object; reco=
mpile with -fPIC
    /build/source/build/../fs/nfs/localio.c:344:(.text+0x47c): dangerous re=
location: unsupported relocation
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: /buil=
d/source/build/../fs/nfs/localio.c:344:(.text+0x488): undefined reference t=
o `nfs_to'
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o: in function `nfs_local_fsync_work':
    /build/source/build/../fs/nfs/localio.c:725:(.text+0x838): undefined re=
ference to `nfs_to'
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `nfs_to' =
which may bind externally can not be used when making a shared object; reco=
mpile with -fPIC
    /build/source/build/../fs/nfs/localio.c:725:(.text+0x838): dangerous re=
location: unsupported relocation
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o:/build/source/build/../fs/nfs/localio.c:725: more undefined ref=
erences to `nfs_to' follow
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o: in function `nfs_local_disable':
    /build/source/build/../fs/nfs/localio.c:140:(.text+0xeb4): undefined re=
ference to `nfs_uuid_invalidate_one_client'
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o: in function `nfs_local_probe':
    /build/source/build/../fs/nfs/localio.c:209:(.text+0xfac): undefined re=
ference to `nfs_uuid_begin'
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: /buil=
d/source/build/../fs/nfs/localio.c:212:(.text+0x1074): undefined reference =
to `nfs_uuid_end'
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o: in function `nfs_local_open_fh':
    /build/source/build/../fs/nfs/localio.c:233:(.text+0x12cc): undefined r=
eference to `nfs_open_local_fh'
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o: in function `nfs_local_doio':
    /build/source/build/../fs/nfs/localio.c:600:(.text+0x13c8): undefined r=
eference to `nfs_to'
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `nfs_to' =
which may bind externally can not be used when making a shared object; reco=
mpile with -fPIC
    /build/source/build/../fs/nfs/localio.c:600:(.text+0x13c8): dangerous r=
elocation: unsupported relocation
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: /buil=
d/source/build/../fs/nfs/localio.c:600:(.text+0x13d8): undefined reference =
to `nfs_to'
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: /buil=
d/source/build/../fs/nfs/localio.c:625:(.text+0x150c): undefined reference =
to `nfs_to'
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o: in function `nfs_local_release_commit_data':
    /build/source/build/../fs/nfs/localio.c:676:(.text+0x18dc): undefined r=
eference to `nfs_to'
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: fs/nf=
s/localio.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `nfs_to' =
which may bind externally can not be used when making a shared object; reco=
mpile with -fPIC
    /build/source/build/../fs/nfs/localio.c:676:(.text+0x18dc): dangerous r=
elocation: unsupported relocation
    /nix/store/f3k0rdhcd2cx57phx755c2xixgifw5m5-binutils-2.42/bin/ld: /buil=
d/source/build/../fs/nfs/localio.c:676:(.text+0x18ec): undefined reference =
to `nfs_to'
    make[2]: *** [../scripts/Makefile.vmlinux:34: vmlinux] Error 1
    make[1]: *** [/build/source/Makefile:1166: vmlinux] Error 2
    make: *** [../Makefile:224: __sub-make] Error 2

On x86_64-linux the problem doesn't exist.

For the build are binutils 2.42 & GCC 13.3 used.

The workaround was to turn off CONFIG_NFS_LOCALIO.

With best regards

Ma27

