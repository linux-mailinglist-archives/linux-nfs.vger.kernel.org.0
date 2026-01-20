Return-Path: <linux-nfs+bounces-18152-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C54AED3C03E
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 08:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA73A404857
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 07:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82663816E5;
	Tue, 20 Jan 2026 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZyANLSLP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC513815EA
	for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892899; cv=none; b=gZg952ytZuoGesoJdZYfd2gkGmGnOR2fSucb9BFX3BO1GuLl0VHfEpJ3DqrZOSgCZn8/CBWsFhr02Y8rbMHq+OynEO+Ab52uddjQfZ1zIdcPBuxRHaqcXl72btN40MNlHd+h7KnA1Yogu59KRellpzeFP0QhHgAsoVY33Us/4wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892899; c=relaxed/simple;
	bh=I/zcfeYTBXm/zyKziKb14ZoSFB5EWnDETMZxcrhMbaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSeyQgYZwqRj3JO7vLSZ4IY/a4bFqAj1NI3+NI+UwNKCcdi573e+FPyJuUNS6u+YEkuC7PKlhUcnihm8Y6BCkSGx4V7K0o39V+hiN5wRNRe3EmKwjeaWoyCXI5beYOdyLskLKZxsrGIuaTDdMFYdB1y1H8qeO9Yxf+ZMRoS3e9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZyANLSLP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OMQG6LW4+zygJKcYJJYsjl7dQUQeXTyCl7MhWsS0XjE=; b=ZyANLSLPMwQ1w4dHdbTE1AeOAy
	SbhbNak+Eu6bIIoHCAxejC7TnV2zXfyrMyDzvvgm2J9yIY3JPhLw3r1DPrRyMwIAqUV4ZpI1utbR8
	lyG3B9avij84rHmmtt1akx+mR/WCgfx6SG4VALHl5crSKxfwGNPpXuf4x6JJcfjsNkGpptNBU2XiG
	PMD1V0+62is2dafwVksr97I0vnppmP6Jg3AM5+3+WJT+43iW2lSS6qYTR8/pqO7rdR+DlkgNvK3Ns
	4iyzSnPb+jE6nsdW8tVq8F91et36pjXASfkDPhqYwkiaJX/equCAq7/H+706lklFh7Ncwxpuyp6rd
	2+9iBTHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi5qP-00000003KHI-2B7k;
	Tue, 20 Jan 2026 07:08:05 +0000
Date: Mon, 19 Jan 2026 23:08:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Dai Ngo <dai.ngo@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Bug in nfsd4_block_get_device_info_scsi in nfsd-testing branch
Message-ID: <aW8p1e3hIM5HHvbo@infradead.org>
References: <45f16856-b71d-4844-bf11-fc9aa5c2feed@oracle.com>
 <a1442149-fdc2-4f66-b73a-499a2e192960@app.fastmail.com>
 <108fb719-8654-42b8-9e37-275726f4b5d8@oracle.com>
 <08c33c91-abda-42de-8771-e61d48b50cc7@oracle.com>
 <aW3jGVAHrEusJyBk@infradead.org>
 <453f0d57-5230-432e-90c3-df0308f7fddd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453f0d57-5230-432e-90c3-df0308f7fddd@app.fastmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 19, 2026 at 09:33:37AM -0500, Chuck Lever wrote:
> > and maybe even add little inline helpers for
> > setting/clearing the mark.
> 
> In the past you've actively hated "adding little inline helpers"
> so I don't suggest that any more. But I actually prefer that.

I like them when they provide a useful abstraction, and not when they
don't.  Of course the "useful" might sometimes be in the eye of the
beholder.


