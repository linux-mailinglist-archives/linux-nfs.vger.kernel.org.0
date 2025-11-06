Return-Path: <linux-nfs+bounces-16133-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F61C3BE50
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 15:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F57F1884544
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6419D07E;
	Thu,  6 Nov 2025 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dJyGKuHS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0D432E6B0
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440604; cv=none; b=IR3Ufji6RgWpUnkgJBi++MvMykrD/SwGopYfjM5ie6CcAUZ//tYpYZxjijM6NnxPZEYTPHpYj9E+NshtbBeXmYZ61mYQD1yqns/WGUS2ff8ZNJmVSvkR+djNkjzgpAcyPHIYIS+14UB0gwmLqtXRmY3RS1UzJgJ//2XFmQYEJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440604; c=relaxed/simple;
	bh=rD9pRYy5HOXUG3KkFV+EAn5CAr4JUE81c8NDEEB9uYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViRmQvx0N5udtuejztBjdQqGCPSfNTz1W8vx1feOponkq4yGqZKL4IUOI0aqMkYW3a194ELo6uqf4Z/7ZU4hmfH4eelaFQ18I77SOe91jMrtWlvBd6wEcCVqHuJXlyTp076Sb0A8/WmixKj3Xs7swuYSfq6zbmrM1FZlTLr3Ih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dJyGKuHS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WlL2KnwxqRVzxb0HTECwsGZ9ephA4kOEpyJTK8x9eyY=; b=dJyGKuHS2lPx08xn4P562alTaS
	Xbg85XY7NwQjhLIwMIGjMQFVgI1vKO8eArbRJEU5IZqECIVyChc6fk5EBDpwz9KCkHuQ7he+nGJKZ
	Dfvg4Is5vBsbWB0ObBHqWbYZUyWJ4utHNc/Orpyet52Rm2Wrzc4PguMkRUvA0RYLrWVR2sCj6nF/M
	UaCLlpTy96ftBwM3cQDj2rSQ0eWRzdv6UUF490cEtnvsS7CMZz9R0VkRm2DSBh1sqA3qJatTbm41a
	Ac016QG9AcNy0atL3CoBmMZ/aZeQRUwFmavGqwueoINxf24YbCdSYX46LVbPHdYGcqDL+x8s736DS
	eBWP11ag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH1JH-0000000FjWb-0m15;
	Thu, 06 Nov 2025 14:49:59 +0000
Date: Thu, 6 Nov 2025 06:49:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v10 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aQy1ly4E1OK_ZQbD@infradead.org>
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-5-cel@kernel.org>
 <176242391124.634289.8771352649615589358@noble.neil.brown.name>
 <aQyfgfWu8kPfe1uA@infradead.org>
 <aQyn-_GSL_z3a9to@infradead.org>
 <fd7e5de7-bad7-4f0b-83f8-7e1d7d27cffd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd7e5de7-bad7-4f0b-83f8-7e1d7d27cffd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 06, 2025 at 09:45:39AM -0500, Chuck Lever wrote:
> It's not missing. This series applies on patches that are already in
> the nfsd-testing branch, which has a patch that defines that constant.

Ah, sorry.  It did apply and compile fine except for the define, though.

> I'm not sure my tooling enables me to specify a particular base commit
> when posting a series. Maybe I can add it to the cover letter.

Yeah, I usually just write that down manually.


