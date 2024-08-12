Return-Path: <linux-nfs+bounces-5310-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CE694EB90
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 13:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E87C281749
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE304170A3D;
	Mon, 12 Aug 2024 11:06:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C94380;
	Mon, 12 Aug 2024 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460767; cv=none; b=eISUsstyaJ9OwB1BpFjWbGLT73k1GNU7S8wJbCEBiU7m14tjUmyiENkFSBH0PhyS7cNi8aA8j4loiF9e78g8QgZkDHTVa8ZYdBAsAGe7BDNfW9wHbeYSz9Z7PkPNSNdg7gjpPPazQOYAaoetpMtjWlk9KfURg9s4gnQIXn97/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460767; c=relaxed/simple;
	bh=5msWubFUrC7JH/hdT6tuEQlfTvrJRBDt3jfOM4r1dPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oA6sc7SJCX9WuxYLP2Y51ylstbrdB7hI+MswpH0d9bfyEqjKMVtaqSsjEOEhDApDzunSssipn3PntcDda78fdYOYtO6mCiIep/2tiNlknX/GZMFqVVwkzfDPUs+XxvB8rPt+dbrmmLyqfHyeb4BKYLUSuTFlL2MbpNk4rp9Sn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 74AC768AA6; Mon, 12 Aug 2024 13:06:00 +0200 (CEST)
Date: Mon, 12 Aug 2024 13:06:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Tariq Toukan <ttoukan.linux@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Maxim Mikityanskiy <maxtram95@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Networking <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [Bug report] NFS patch breaks TLS device-offloaded TX zerocopy
Message-ID: <20240812110600.GB14300@lst.de>
References: <aeea3ae5-5c0b-48fa-942b-4d17acfd8cba@gmail.com> <77fb3db5-7a59-4879-b9c2-d3408fcf67e8@grimberg.me> <4f42fac4-2a4e-426a-be86-1f4bb79987b4@gmail.com> <3e08421f-91ac-4bd1-9886-3d5ecf9afa04@grimberg.me> <8683155c-79ad-4090-9aff-fc8d765b096b@gmail.com> <20240812090215.GA5497@lst.de> <06a66824-cc2e-4f6d-8776-c2bd415c06f9@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a66824-cc2e-4f6d-8776-c2bd415c06f9@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 12, 2024 at 12:13:51PM +0300, Sagi Grimberg wrote:
>
>
>
> On 12/08/2024 12:02, Christoph Hellwig wrote:
>> On Tue, Aug 06, 2024 at 01:07:47PM +0300, Tariq Toukan wrote:
>>> Adding Maxim Mikityanskiy, he might have some insights.
>> I think the important part to find out is if the in-kernel TLS API
>> has a limitation to PAGE_SIZE buffer segments, or not.
>
> I don't see why it should. Also note that sw tls does not suffer from
> this. Maybe Jakub can add more light here in case something was missed?

I don't see why it should either, but instead of assuming we should
make it clear what the assumptions are before going further.

