Return-Path: <linux-nfs+bounces-5315-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E043794EE08
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 15:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D657282ADC
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 13:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058A017C20E;
	Mon, 12 Aug 2024 13:24:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB9B178378;
	Mon, 12 Aug 2024 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469041; cv=none; b=nNe3FDJDJfEFD7WvPnHt12ngqlF65vjWUrIs+LmnDecuJTLsexltYFLfOoUXhM70G+r2t5uhuJa7Y3xdDccQ1iSlnzBTNNop2IVnYXlhQDHvgIAOHsLTYKGvzTkTiMNCgDDa18ReVAh9O7eCyfZxlJ/ORgALAQ0iQUDp633PWMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469041; c=relaxed/simple;
	bh=VuI+wPFxg0qN0XzAAYkHh993rdpl2H1G9OpKgKCGieE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUBMHFgacRJk6yTYYkq7lf1Z7tsMp23f/YV6w6rRiivk0tzkD+Toda1vNzuz5NwEAGz7LK1qhp0BH6E3NSpA73sRNUHmIlSByW1yi4dHkWTyYBIJ69oCc0cMMFxRAxd62j6iQkQUK6XI9O0HLY1Aozi5F4IZaso9ILSsPOFR1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 43C42227A87; Mon, 12 Aug 2024 15:23:54 +0200 (CEST)
Date: Mon, 12 Aug 2024 15:23:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxim Mikityanskiy <maxtram95@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Mina Almasry <almasrymina@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Networking <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	drort@nvidia.com
Subject: Re: [Bug report] NFS patch breaks TLS device-offloaded TX zerocopy
Message-ID: <20240812132354.GA23655@lst.de>
References: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com> <77fb3db5-7a59-4879-b9c2-d3408fcf67e8@grimberg.me> <4f42fac4-2a4e-426a-be86-1f4bb79987b4@gmail.com> <3e08421f-91ac-4bd1-9886-3d5ecf9afa04@grimberg.me> <8683155c-79ad-4090-9aff-fc8d765b096b@gmail.com> <65a77bbb-b7dc-40d8-b09f-c0cf0cb01271@gmail.com> <a11a0502-4174-48d3-a8ad-8584fd304fe1@grimberg.me> <c1096b57-a03f-4fa2-b61f-7418f2304618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1096b57-a03f-4fa2-b61f-7418f2304618@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 12, 2024 at 04:15:35PM +0300, Tariq Toukan wrote:
>> Can you explain where in your test is NFS used? Is the nginx server runs 
>> on an NFS mount?
>
> I checked with the team.
> The requested file, as well as the wrk and nginx apps, all reside on an NFS 
> mount.

So maybe I misunderstood the workload.  You aren't using the NFS over
TLS, but your are webserving using sendfile with the TLS offload,
with the data coming from a NFS share that isn't using TLS?

In that case NFS really is just the trigger here and you'd see the
exact same behavior when serving from another large folios enabled
file system like XFS, or probably also when serving from anonymous
memory.  This very clearly points to a debug in the hardware TLS
offload.

