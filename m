Return-Path: <linux-nfs+bounces-4124-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC490FC23
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 07:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DAC1C22F0D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 05:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B339A1BC5C;
	Thu, 20 Jun 2024 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lHhsTbEb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B2628
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 05:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718860620; cv=none; b=L9eunyQtLCuQRME3BMqxvfBJedPN2vF9JdlmbOUtfGGDa9hBn0FD7LNIA2RgXi3TTeLgNTxp5sOTIwyYNcaCYOJG1yPulZElH71UQJYi0vnngUO32Er77iWHT0OcPPNDKJ995ZzQTa33lwVVmyHs4UWsoTdjuyT6ICwZGiy0jtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718860620; c=relaxed/simple;
	bh=1vEhI9hEGWFutrFCX9XBawB8tnSL0ysAHRsZrj/orB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjvT1+WoWCfR0qEOCNZ39nOdgm7mvFcH4iPm7nktV4F1lnj2A+fykOLVGQjWZv2n58UXPdpvbQxNrjMjpcOsLmBSHU8zP8tH3ZSZNzCqLg28PbsP/YSN4szMIpvmSNObhjptdAfpEj0qP8zI8xW/0Rd0IUjeLreo4YmY0u3eNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lHhsTbEb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1vEhI9hEGWFutrFCX9XBawB8tnSL0ysAHRsZrj/orB0=; b=lHhsTbEbaCK3wwD7j5N1ONK3+Z
	gTRVuNWPuNGwJZPf+DXRUOpEbDZmpuEqkjifkgSqqjt/FZKkAQQfFQtx+uxQ8th3NL/S62iP0PvJS
	7u92wdAqsPoOkHtOSXnSwnjo/EcUnU98G02IWEV/q54c0bLs9xzJuBFXt8Nf7SJY++OvofjESuoE6
	f9r0JWYCVzxeVzU2fmJrJzluewI8BRkXduLQ0pdy8zDmFG/9IFaZrimRtCoSfHgwKZ5gl6jGOa9lI
	Uu42L3JGluWbGW8/mKyeCQIUAl9Qy6xUAMFbc1fempcWo8rV71RbVdfRUd1/w9pNDSh0vlbSclsZK
	DU6I4Ecw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKAAM-00000003f5N-0cRF;
	Thu, 20 Jun 2024 05:16:58 +0000
Date: Wed, 19 Jun 2024 22:16:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v5 00/19] nfs/nfsd: add support for localio
Message-ID: <ZnO7SpxwmtQUqTGB@infradead.org>
References: <>
 <23aa79999595e0ec5af04795be315de73ec5cfe0.camel@kernel.org>
 <171883136311.14261.10658469664795186377@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171883136311.14261.10658469664795186377@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 20, 2024 at 07:09:23AM +1000, NeilBrown wrote:
> I don't see where an O_TMPFILE could fit into this, or how a different
> high-level approach would be any better.

... especially given that O_TMPFILE requires and open but unlinked
file, which v3 can't really support at all, and even for v4 would
require quite a bit of work (although it would be very useful).


