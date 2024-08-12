Return-Path: <linux-nfs+bounces-5308-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED2394E91D
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 11:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DC71C211DB
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C3D1607A1;
	Mon, 12 Aug 2024 09:02:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4C1514C1;
	Mon, 12 Aug 2024 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453342; cv=none; b=LZMRFoVAgdJqB/iSVGZUPFAn92aZgUoBja21kEWGJEO5p4mdgRO8+Ho2n3afBXxlwThnR0Z2IHKovS8gOLrLH27w5pz2yn47ve1ajCsix1Rkz4VAXl8kcCyBNCnAaq4XmSRFBAqC6YDLxpOrsFshdXFdpvYrZG7O25sm6k9Zc0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453342; c=relaxed/simple;
	bh=BFO105tEEmXbtHTUoioswKPlKS/k/Zfx//loGsJXejY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsldSt+n609HuUtuuXTSn+uQjJPdrQvCXRMio3R8KBr4SWXjO29+cyRu1L+41kyOzyUixBp34Z1kWfYiiuHUwSFZgB73GNoIzmiN7xENV5kcK7d065sVHNk1RhqbRhHq0b7JuGHrrmSPkTE+/UDV0/y8DbYCHfgUR1Xm1vKVa0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4DB30227A88; Mon, 12 Aug 2024 11:02:16 +0200 (CEST)
Date: Mon, 12 Aug 2024 11:02:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxim Mikityanskiy <maxtram95@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Networking <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [Bug report] NFS patch breaks TLS device-offloaded TX zerocopy
Message-ID: <20240812090215.GA5497@lst.de>
References: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com> <77fb3db5-7a59-4879-b9c2-d3408fcf67e8@grimberg.me> <4f42fac4-2a4e-426a-be86-1f4bb79987b4@gmail.com> <3e08421f-91ac-4bd1-9886-3d5ecf9afa04@grimberg.me> <8683155c-79ad-4090-9aff-fc8d765b096b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8683155c-79ad-4090-9aff-fc8d765b096b@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 06, 2024 at 01:07:47PM +0300, Tariq Toukan wrote:
> Adding Maxim Mikityanskiy, he might have some insights.

I think the important part to find out is if the in-kernel TLS API
has a limitation to PAGE_SIZE buffer segments, or not.  If it does
we need to disable large folios for the in-kernel consumers of the
API, which is easy (but annoying) for NFS that trigger this, but quite
painful for NVMe.  Or the API is supposed to handle it and just this
one offload gets it wrong, in which case we need to fix it.


