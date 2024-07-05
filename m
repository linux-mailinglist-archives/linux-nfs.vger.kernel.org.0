Return-Path: <linux-nfs+bounces-4642-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E80E928A95
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 16:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276961F2659B
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBF016A95C;
	Fri,  5 Jul 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r0D7UW5K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165314885C
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189113; cv=none; b=kvX0X2QZfjGNdw6KCoRR5uPXGHUrGs/MYIScFx9HCpv46U9tJSzv4zzbfbcQ/AC9Dqu6vJAfTbIesppjxdgjuhAUgNiaLYuMA8/HWzMjMF050iMvkE3mM3Y0u7YGbM5n26MT9qNG/HzRU8BLLckUxvwyoJFCZfZYRmWxflO1Ygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189113; c=relaxed/simple;
	bh=EgKY2uQ9UiVx9OlpI9n6fSYUwT4WaTs/0R1en5cuEyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inhIvUKbiE5td3A6UgYa2h3rB7U4B58wuNFwOFIeBVdLa7KENIBMh+nBbsdsew0MmEnQDUmwT0A7fslAXCRs1S7X9tO++bLg6XIm0Pd/7OV3zzwEOkZuvDTRrpCRtThBh/I6fciUEgTL6aryM7CLqT8HrrGAXNzhCNFhEvBJfFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r0D7UW5K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kd9rD3kvoYlR3JyBGN8fswNHveRKK7xWKnjPd9MxAW8=; b=r0D7UW5KzuDnetdexfyAtph8NI
	cQ9UL1DiKHi8JCb8R3rO78KIf0W9+rBIbI/nlHwAlQRPiLbAyrtvwZ7NFLu4sGdSM+OfCLJgR50U5
	MOa5H1nkvzUGKk1xPyj0a3t86c7kx3XTo9zgS1Ro/ITZn9UKp0MXFcYlZq+ULJvTfA1fOKSe584y8
	o4SIBGzw+XhRMb50MDTy/SfjHwrzWpiGVGNz3lW8CkfINSgC9w4r7FST6/0Nt/2E5VIiY/b59Z5cO
	59YlqD48R3chbsYIYTHqEmkrn5sdtX9b68jyvemaydNqcNngyVN3/9ulWK92gj7kaJGvszca4mxRQ
	cKyWHlvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPjld-0000000GBCi-41Cn;
	Fri, 05 Jul 2024 14:18:29 +0000
Date: Fri, 5 Jul 2024 07:18:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZogAtVfeqXv3jgAv@infradead.org>
References: <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
 <ZoVv4IVNC2dP1EaM@kernel.org>
 <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
 <ZoY6e-BmRJFLkziG@infradead.org>
 <ZobqkgBeQaPwq7ly@kernel.org>
 <ZoeCFwzmGiQT4V0a@infradead.org>
 <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
 <ZogAEqYvJaYLVyKj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZogAEqYvJaYLVyKj@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 05, 2024 at 10:15:46AM -0400, Mike Snitzer wrote:
> NFSv3 is needed because NFSv3 is used to initiate IO to NFSv3 knfsd on
> the same host.

That doesn't really bring is any further.  Why is it required?

I think we'll just need to stop this discussion until we have reasonable
documentation of the use cases and assumptions, because without that
we'll get hund up in dead loops.

