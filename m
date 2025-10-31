Return-Path: <linux-nfs+bounces-15846-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9EC253D7
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66303351715
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA70F32720D;
	Fri, 31 Oct 2025 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zm+DK35j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F03491F1
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916916; cv=none; b=n8RAVLSVqj7ieSf9qgRAWx4N8QeXVfOJ0PKapHVC9HrH0bsDEezG/jOUXLC40gIOwr4Ocg0KUV9vP9EBS3Dd0SD5EYBtruzR4DqfIUnDF6N+Lf2bLM0G0xEa9tJjT9E+4+KBdB3pZPBx6L/7P1FYshoXaxELSKKJjnkbCAoCSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916916; c=relaxed/simple;
	bh=K4+tXce7/wIiyISjuMW6XgSjjlDRXHikwJQr+g1zPvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJerrXmX8RVNlYGrOUJyQ11Tbr/mtCnFmwMU0j5kLjGSF3nUMuGxf3zsSaSHo62eKpwUCJ915uCtKZSPhXYJiBOCoMiAxV/WjlfdurvjA1OKNoYnwQw2xHY+NJy9TPuESRFWRbajlYVmGzc04WSTp7sx4cdu0pOEKUqxxBTFcZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zm+DK35j; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K4+tXce7/wIiyISjuMW6XgSjjlDRXHikwJQr+g1zPvQ=; b=Zm+DK35j9c+bVnbFIlER3P0zYe
	4eQG+E1BoTOSJTFQAyKAdYRX/tmdIE1OnfG60eFgovaCHIfWbfgM2nQHNzCbe0QRvmSLjx7BWM3CR
	xlduK7iDEpahlvCkc8UrzmQbSolf1wmB1i/KpGOiqKF8Op08hO5kXr/u5kK60Vp0l/nIAK7EUOOx8
	kBNg/muohR0lY88YxyCtJyH15XPw7bZFCOqtFb1wiD9sS2uR/swEzDSvCZ94W42X7IBWSr9dq/2Nx
	b923WKvZ6STojCJIqXd6S13oeUhsAV3m0LsqUtx27wBvYeUfvvlT62iJsZUjNJhB+F/eeps0GAJ7h
	G7PsuVfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEp4i-000000069fx-4Ays;
	Fri, 31 Oct 2025 13:21:52 +0000
Date: Fri, 31 Oct 2025 06:21:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v8 11/12] NFSD: Handle kiocb->ki_flags correctly
Message-ID: <aQS38Ek0TB5xc0rf@infradead.org>
References: <20251027154630.1774-1-cel@kernel.org>
 <20251027154630.1774-12-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027154630.1774-12-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Thanks, this looks good.


