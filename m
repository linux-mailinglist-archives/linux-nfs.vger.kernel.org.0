Return-Path: <linux-nfs+bounces-4620-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A20926F31
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 08:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFB61F23731
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jul 2024 06:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309811B7E4;
	Thu,  4 Jul 2024 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xlb9zJY4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2EA53370
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jul 2024 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720072829; cv=none; b=cN4sSkMva4wXnY7xR6a6ognD4CZVFyVbZ/aVtwUsTCuVjZ0m2rVJ0EVRE7PX4J6toskEZ/zofbiBmrTnbOm84BH/bz4Zykx5rPsfPfQUFvDOi4QGXWvBV8SCJ61QGoWh1sk48J/OlFcduxjl2fCuuI955V0kyF20IyNFqJqojqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720072829; c=relaxed/simple;
	bh=jcttPxu901sc/ahVdWKQsPlOw3NmLFs3Oz81a12uPSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0l5KJwZrV3S50rYBVfmKg5NtBO0aG7c8tNTkM+4bXBGVVtobRXZZwz+K+/IOOT0NqQ3h7due0MyZSlYmje56DtPEa6xjMBNdaU2zjmBUJOyMhXL1SeAbPAXpdBbi9Zlldg4CWkdcZH3R9I5zQIKZy/Nyjsyl5In8jHP6vqpBWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xlb9zJY4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qrawXIH8jMpJvtKdZWoFlRIsdBjEfFxl2OPLPmhUdhc=; b=xlb9zJY44ycoCpm3Q0fZWhhCo0
	ZscoNtM+XOhD2uuZVtLAUd5Ou2e0iR69ECLsO3ot8P3aK0sG78u0bi7O78Wr0kmeePpfyB4HYOJB8
	eT2IM7nlsrRVDAVGOboYd/LUTl7jdNpLvd+b0oYO3XzLRgbzr1s22SXPuCdD4gd4H7D+fo2le3xYk
	CenMWMp0GvTFZDWwv86hL11aL0uTveL4EIr3yOeQFcOj3G4vVeYXamHMxcNnTZQDmCOOP8ti51XRJ
	9srCINTKJ51ET6hn8gqoTjiVjuJ5/s2RL7FJDOUnO+tXn/4Nfmt+uRbmjEW7THGE/hvsBBPr0AnQW
	ftACls6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPFW7-0000000CHCz-0Qye;
	Thu, 04 Jul 2024 06:00:27 +0000
Date: Wed, 3 Jul 2024 23:00:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoY6e-BmRJFLkziG@infradead.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org>
 <ZoURUoz1ZBTZ2sr_@kernel.org>
 <ZoVdP-S01NOyZqlQ@infradead.org>
 <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
 <ZoVv4IVNC2dP1EaM@kernel.org>
 <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 03, 2024 at 01:06:51PM -0400, Jeff Layton wrote:
> The other problem with doing this is that if a server is running in a
> container, how is it to know that the client is in different container
> on the same host, and hence that it can give out a localio layout? We'd
> still need some way to detect that anyway, which would probably look a
> lot like the localio protocol.

We'll need some way to detect that client and server are capable
of the bypass.  And from all it looks that's actually the hard and
complicated part, and we'll need that for any scheme.

And then we need a way to bypass the server for I/O, which currently is
rather complex in the patchset and would be almost trivial with a new
pNFS layout.

> Can the client use its localio access to bypass that since it's not
> going across the network anymore? Maybe by using open_by_handle_at on
> the NFS share on a guessed filehandle? I think we need to ensure that
> that isn't possible.

If a file system is shared by containers and users in containers have
the capability to use open_by_handle_at the security model is already
broken without NFS or localio involved.

> I wonder if it's also worthwhile to gate localio access on an export
> option, just out of an abundance of caution.

export and mount option.  We're speaking a non-standard side band
protocol here, there is no way that should be done without explicit
opt-in from both sides.


