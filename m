Return-Path: <linux-nfs+bounces-13056-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D4DB044BA
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 17:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6013B46C7
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194625BEF0;
	Mon, 14 Jul 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4Bj/4SA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7725B305
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508308; cv=none; b=b+NSjDC4KWVz7nsN1i9AcAWr6oVrycQ+Hc0OFpg5PMGm9ucvFCMmMDAxXASU4DY8VZ4EtYsSIODQhNxn7nVlk8zn/2tleZnO6vb4QXcRi+Rn2Cri/kq0cSoCdNQy2q8qYcoJZJwwM/PwbcjIjD8VQllksieqsQ5JImYfaaiJNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508308; c=relaxed/simple;
	bh=mr2jhZFiII4nfhRvxwCYBSSxhfqNS6etAnoWc2jbT5E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwDSHIJLftEyHWeBMUozFYryXHfTOTaaD5KbbZ6agueVjYdQbXAox2RuF8a7Lo6BjDmiEVEtnGWknuOE/mJ8O5b2w4wEFg5fmyP2WZnCtzJqk/grIGjURI5/HeVcB3jT3S2WEEIOGdJ94U5kDtdOOTN43YpiA9qL46BC2ricGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4Bj/4SA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3D8C4CEED;
	Mon, 14 Jul 2025 15:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752508307;
	bh=mr2jhZFiII4nfhRvxwCYBSSxhfqNS6etAnoWc2jbT5E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=O4Bj/4SAf7gMzzpams86LaL2zxpcbH88s7fXsPkTONepufCCNM/z1Pc7hTcil7GVJ
	 gIPJxR/NP2DvFIb3urfuHyWKVB1F6Txdcn1DXCR/qPPnj2sK0RfUuyQY96oUi8ejoX
	 iZ8O7MwegRXBLEze8MwnI57gSNfuDrEf6U1LC9d+FrnjQUR/j7bvszkaFWMcUzBNxt
	 ThU9IHJ85d/z4wVsebaTlnqgg9PwsTr58BQijIKP03pN6f622BSOqKB5yj7YWLxzXm
	 bOGa2+QDth42fnckwt8hjb264Jh8nxkYFKGSKJyshwsyjb2x0ebqIS/E0txeg2Oo1g
	 G4RJ8czIAv5Sg==
Message-ID: <78c76f23be37325c8aa5dd86a49eb8a41d2fe91d.camel@kernel.org>
Subject: Re: [PATCH 1/2] NFS: pass struct nfs_client_initdata to
 nfs4_set_client
From: Trond Myklebust <trondmy@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Date: Mon, 14 Jul 2025 08:51:45 -0700
In-Reply-To: <20250714063053.1487761-2-hch@lst.de>
References: <20250714063053.1487761-1-hch@lst.de>
	 <20250714063053.1487761-2-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-14 at 08:30 +0200, Christoph Hellwig wrote:
> Passed the partially filled out structure to nfs4_set_client instead
> of
> 11 arguments that then get stashed into the structure.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>=20

This looks like a decent cleanup.



--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

