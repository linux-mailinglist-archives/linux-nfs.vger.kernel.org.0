Return-Path: <linux-nfs+bounces-16266-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E8CC4E799
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 15:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93FE74FF1A2
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2571C6FE1;
	Tue, 11 Nov 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ubi/wvL3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3B1D47B4
	for <linux-nfs@vger.kernel.org>; Tue, 11 Nov 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870925; cv=none; b=HQnRfns0XtwKIcxDtRDUXsmSSpGv/hTtyhH5Qig3c7Tfkd6crFu85Jj2L6tvZttZN/p7iYVtauNjNMI1embbBfeWf0WbW7biav9iuVCd44qJACBa3/7H4K3E+RuBjaDmB8pyQmow9UwCZSKw/+k/6FTTVV6HBHxqRukfbcrSTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870925; c=relaxed/simple;
	bh=+STlGUUvLGD7OZlNdO7J73n8yb6SZi4yrgdtVgSvMvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB7Uvxt3LtquN98b1lgXkw8HDDd3vtPAXfv6daQ8QVBrUxnbKZTMkpMK5IauQ9liFD9eXp9vSzYwxrBCqPiihH8CYzFN59IfZ+Sr7GG8H6odXLQfi5CjmksG1/WoNAkF3Vg65oKglatsutJZDmye6D5uUpZUY5B/X3aGyDgUMBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ubi/wvL3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1GW0/7uhlT3mxPYX9xCaoWOLbqvC0gMtvysQIgWRH6s=; b=Ubi/wvL346RKebng2SchSQ08mn
	26gqcHQrJqS6dKgDK4+3SMlSth35MtoswJ9H+XpJ6WilFpGiM01k6QM8pTzT2CE5bPQwZz6OU0YqI
	QWv0ue4GJUMQebVoRVfWlqmZE96QIHMnoCVTB0R38glh795nVcQZ5yCR+1qpCf5sF6tBRogInsapM
	/k6znkgDBy+u6ZxaSDAQuJ3VVz+xsyy0wOLIpSRIxaZ69ivjuiPQpgcE+yxkl+Yg7Z6KSqJC1kEOg
	iso59ucUNNelU4KQ/YJ3nJbvz9qGOKilfesBFdEd20rDbcvP/s7nsH1wOsr5yJPIFYH4mDG7hDyXp
	G2xTo+DQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIpFv-00000007JJj-3dT5;
	Tue, 11 Nov 2025 14:21:59 +0000
Date: Tue, 11 Nov 2025 06:21:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRNGhy1YePKbs1Ab@infradead.org>
References: <aQ5Q99Kvw0ZE09Th@kernel.org>
 <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>
 <aQ5SSnW9xUWj9xBi@kernel.org>
 <176255273643.634289.15333032218575182744@noble.neil.brown.name>
 <aQ5xkjIzf6uU_zLa@kernel.org>
 <176255894778.634289.2265909350991291087@noble.neil.brown.name>
 <aQ6kkd74pj2aUd8b@kernel.org>
 <2b024928-e078-4414-a062-bbeedfeea5d9@oracle.com>
 <aRL5EPMD9VsG1n3D@infradead.org>
 <e0798cbc-87ce-4ba3-ae9c-d1ff669dcf75@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0798cbc-87ce-4ba3-ae9c-d1ff669dcf75@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 11, 2025 at 09:20:52AM -0500, Chuck Lever wrote:
> To move forward before it is too late to hit v6.19, what I'm thinking
> is this:
> 
> * I'll reset the patch to leave DONTCACHE set for all unaligned
>   segments, as it was in the original logic
> 
> * I'll post a final version of the series to be merged
> 
> * We can resume this discussion after the series is merged, as an
>   opportunity for optimization

Sounds reasonable.  And just to make it clear again:  I'm not against
this optimization, I just want to it to be consistent and well
understood.


