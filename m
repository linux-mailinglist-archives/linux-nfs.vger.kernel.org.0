Return-Path: <linux-nfs+bounces-16129-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7D0C3B384
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 14:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB76C426276
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 13:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4671D9663;
	Thu,  6 Nov 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X+wwElAI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938F1E1E12
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434949; cv=none; b=ELGgKznxO1++DWAzkWo20lFkpf4Ee+LqIQ9kmSioIueTl5Ttkmuj88kxVi2wbylbSDIg+cEE3peiZ4TuCNTsa4vUy/+12p1zjds4yB8oAmMe5fr/KhKSQACJm1wS1d78d4Jl9FJ2IDPpYeK8oyJ8QH2EiXAVU+ybe3ZOBybizzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434949; c=relaxed/simple;
	bh=C1gaUftdYiQvVPTuZwEkNOftwokpvQzxIwj9P1rR9F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0HzyXYT+rR384U3OGOWAqE9ghEKjFj2vBTIasMSSuJdp1KbioxzXfNRVe1kHoD3BbcZNJ3n4UYseB4vFl3aHxUX9JiDbsxwYJ+SJrpbfbzsdlBI0Em6Mbg41QpKmnnc0WsjOkmaSD8JHqhLaQy0oaWc/X8uqalUN5v38QVxtH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X+wwElAI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dQDg8ZLbO/j2tvOu5zLl2rczQ/IIZBu38MPYfRLNno8=; b=X+wwElAIjhR/lGkscBTE7aNCUJ
	l+OObngYBiF3ckZZ8i1DRWGuqcdwtI/P1zbErH8cCWEevhtkbK9AQ6kKYkhBwHIRU7LJeRFDI6E1w
	iXJRekvhLJIW7VeY1F91Y1Qq2ERpxh6l8crxDxqjmJKee2Pz2Orayve8rfC7uo38uqhkyVKR4KLxV
	OrXRkRsrBjahCmTzYOKWLHEJOFcFLhm6D1HdcgQ6t2eaSyaOheCJhb5RTR7NHQK6kXl4fQQQHF/s3
	iUVdPz2sSG01eZDkuhQCJIoiAut2j/oSt1E+EV6L+0esNI+3o7Wm5wciCAz7pyKcXIf6Q+1jHRoDb
	xywBDNyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGzq5-0000000FYSb-0wMG;
	Thu, 06 Nov 2025 13:15:45 +0000
Date: Thu, 6 Nov 2025 05:15:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v10 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aQyfgfWu8kPfe1uA@infradead.org>
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-5-cel@kernel.org>
 <176242391124.634289.8771352649615589358@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176242391124.634289.8771352649615589358@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 06, 2025 at 09:11:51PM +1100, NeilBrown wrote:
> > +struct nfsd_write_dio_seg {
> > +	struct iov_iter			iter;
> > +	bool				use_dio;
> 
> This is only used to choose which flags to use.
> I think it would be neater the have 'flags' here explicitly.

Actually, looking at the grand unified patch now (thanks, this is so
much easier to review!), we can just do away with the struct entirely.
Just have nfsd_write_dio_iters_init return if direct I/O is possible
or not, and do a single vfs_iocb_iter_write on the origin kiocb/iter
if not.


