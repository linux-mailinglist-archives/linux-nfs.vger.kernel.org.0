Return-Path: <linux-nfs+bounces-15558-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB07ABFF3F2
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 07:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A89A44E1CFF
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 05:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B68242D70;
	Thu, 23 Oct 2025 05:26:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E3242D7C
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761197200; cv=none; b=SsmiamezU41AeSHiJ9wu0EJiBBhquXfa9E24Bsth/2AUpd2Q+eBM4sfDzIIhkw9RXtxMt9EOipfxN/WAed9n5TuGMMse7gIccmsIqyDJyi/of4NoynNF9zSNeqb1e+P9tdQCi/5u6guU0xoQiORL198QVz7OEf9tbSrJrXPr9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761197200; c=relaxed/simple;
	bh=VWHAiTao588/TBl85fWqH4XqVRENbsTWUVhJrYgGhUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1PjbccPtX5ua2nDHjF8iomUfH8lpABu/O5lDKCPtO1xJpvd9Mh/w28MkOlZrm7A3o34WtBrzMFI73H/cYMO61CWbmVGpz5soqSVnYxK/yRQ8ud1gjs5D+1fTgxk6FVMw9gjjUoW2ll0lEdj8pIbLcL+3lspP1eh+yhQ3ClYWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 888C2227A8E; Thu, 23 Oct 2025 07:26:27 +0200 (CEST)
Date: Thu, 23 Oct 2025 07:26:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add a nfsd blocklayout reviewer
Message-ID: <20251023052627.GA28396@lst.de>
References: <20251022114533.2181580-1-hch@lst.de> <953be593-41aa-4d4a-809e-7614150ee778@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <953be593-41aa-4d4a-809e-7614150ee778@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 22, 2025 at 09:34:06AM -0400, Chuck Lever wrote:
> On 10/22/25 7:45 AM, Christoph Hellwig wrote:
> > Add a minimal entry for the block layout driver to make sure Christoph
> > who wrote the code gets Cced on all patches.  The actual maintenance
> > stays with the nfsd maintainer team.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  MAINTAINERS | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f2bc6c6a214e..1dbdf64bc362 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13586,6 +13586,10 @@ F:	include/uapi/linux/sunrpc/
> >  F:	net/sunrpc/
> >  F:	tools/net/sunrpc/
> >  
> > +KERNEL NFSD BLOCK and SCSI LAYOUT DRIVER
> > +R:	Christoph Hellwig <hch@lst.de>
> > +F:	fs/nfsd/blocklayout*
> > +
> 
> It would be sensible to copy the other fields from NFSD for this, yes?

get_maintainers.pl automatically adds overlapping sections, so I'm not
sure what that would buys us.


