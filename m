Return-Path: <linux-nfs+bounces-4581-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6908B925240
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 06:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C46F1C233C3
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 04:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F37224D1;
	Wed,  3 Jul 2024 04:25:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4011CAF
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 04:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980725; cv=none; b=ajhYYvXBDEqOqk59Z36zpeKrhbb09bpT6ciipd3XZTxsxrnt565vYxRNTshtd9gwFv+eKwamtI+wH73pCPaOp6doHDideaqsxvS0NUMHTkmLCwUCvX4dt6raBJRPYo3Wj7uRErGPeUjySh4MrE+u2jYBffTWLJtRmTd5lB/+Edo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980725; c=relaxed/simple;
	bh=EOJicD6QZj22IjGV1rKfKnXhuwNQsciCy5BnS12erJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaiyvcoO/8Vw5Tj7c6KhlRIpUxzZco0Ae4DCZzl4K34V/Ip0YV/2bPBd7wCqpQxTZwE9AbZlZnv6CwLTABAQBRFQOtOiIC5lNXyAH0yP6+SxDwb9rQRhdanYUbNDuuoug4q2+H5Pua5pTH4KKu5VD0an3Vj4VLaJ+cJ8MYooUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA29068AA6; Wed,  3 Jul 2024 06:25:19 +0200 (CEST)
Date: Wed, 3 Jul 2024 06:25:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 7/7] nfs: don't reuse partially completed requests in
 nfs_lock_and_join_requests
Message-ID: <20240703042519.GC24050@lst.de>
References: <20240701052707.1246254-1-hch@lst.de> <20240701052707.1246254-8-hch@lst.de> <1bae89b5-0f11-4417-81f3-8fce05a9c751@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bae89b5-0f11-4417-81f3-8fce05a9c751@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 02, 2024 at 11:07:13AM +0300, Sagi Grimberg wrote:
> On 01/07/2024 8:26, Christoph Hellwig wrote:
>> When NFS requests are split into sub-requests, nfs_inode_remove_request
>> calls nfs_page_group_sync_on_bit to set PG_REMOVE on this sub-request and
>> only completes the head requests once PG_REMOVE is set on all requests.
>> This means that when nfs_lock_and_join_requests sees a PG_REMOVE bit, I/O
>> on the request is in progress and has partially completed.   If such a
>> request is returned to nfs_try_to_update_request, it could be extended
>> with the newly dirtied region and I/O for the combined range will be
>> re-scheduled, leading to extra I/O.
>
> Probably worth noting in the change log that large folios makes this 
> potentially much
> worse?

That assumes large folios actually create more subrequest.  One big
reason to create subrequests is flexfiles mirroring, which of course
doesn't change with large folio.  The other is that if ->pg_test
doesn't allow the nfs_page to cover everything, which is roughly
bound by a page array allocation and for PNFS the layout segment
size, and the chance for that to fail could very slightly increase.


