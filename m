Return-Path: <linux-nfs+bounces-12978-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D7B0031D
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 15:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B8D1C442B9
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 13:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E22525D21A;
	Thu, 10 Jul 2025 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO38hXx4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD12367CD;
	Thu, 10 Jul 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153265; cv=none; b=ZmL4ZP3XNn04rHOrJlkrZaB7FPzAJRUlgaiQPIS/gkIblznnuThEYsDQo1LUEXcUNjaco9lzniMf54zGyTyuqM/C9UPbHZtgNUCf+Tg753U0dWdbkiLBARabibsX0RorEJ4vpn7HYI8HUTb36e5dYGptPo/dByfDUgc+ZBybAqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153265; c=relaxed/simple;
	bh=EFP1+wvOgBptEiJUGJiwXtmUQ/sObDgGxSNbaKCJvp0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=un/+5Av6pOMc/cm1fyAonyvLYKKmOnVinAghdjwwYIH8j2d/xnNO37/XKt0TZTtUIytYnJglQHgy/UpSouFAPHZQgUqTNe2FzYZEPm1X4czn6iEcBlpps3d7TX6SMey2fNGsTpqAtaP00IWTk1ZQfK0GgQ5/Dlohmmlr2CL4RR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO38hXx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E0DC4CEE3;
	Thu, 10 Jul 2025 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752153264;
	bh=EFP1+wvOgBptEiJUGJiwXtmUQ/sObDgGxSNbaKCJvp0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NO38hXx4EB15majfdclQwOID+8WflKYQkoT41caC8pOadpB0JRRikdlfxDRwWEv/Q
	 mY89XuQCKBkJRa4giSlNgIDf0Lzavmzp3k3N0xi66EDlWKVfd+ujupdJzEiVFj2rlA
	 x3IUOrp5pOyoSAcoMFRvo8V273FHWlt/XIXhBH7oz1Jnpuxx6U7rTPBwjotNJZf/2t
	 QhQi5ZTWLte2KcebH9Osn09LTrNk6e3OOrqppk/Us7Yli7Oe4aL44Q8kHTVV4yvqwF
	 gcNtVMT8R133QygEXkiP7XOTFMpCeIKsUMoYDfMBCrbtpxwT6KMqoJ1fOAW3bFNo7h
	 60tVqXOLMZ+bA==
Message-ID: <1c15a03126ba907a05d1646b78580ae004c21f92.camel@kernel.org>
Subject: Re: support keyrings for NFS TLS mounts v2
From: Trond Myklebust <trondmy@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: Anna Schumaker <anna@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, linux-nfs@vger.kernel.org,
 kernel-tls-handshake	 <kernel-tls-handshake@lists.linux.dev>,
 keyrings@vger.kernel.org
Date: Thu, 10 Jul 2025 06:14:22 -0700
In-Reply-To: <20250710072517.GA5891@lst.de>
References: <20250515115107.33052-1-hch@lst.de>
	 <20250710072517.GA5891@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-10 at 09:25 +0200, Christoph Hellwig wrote:
> Trond/Anna:
>=20
> can you queue this up?=C2=A0 If not can you tell me what is missing?
>=20

Sorry. That series managed to fly under the radar while I was on
vacation. It looks good to me, so I'm picking it into my 'testing'
branch now.

Thanks for the reminder!

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

