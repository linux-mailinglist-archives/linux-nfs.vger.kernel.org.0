Return-Path: <linux-nfs+bounces-4596-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3309264B1
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 17:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D18283A0F
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F9F17A5A8;
	Wed,  3 Jul 2024 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fML7blr1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487E81DA319
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019884; cv=none; b=NEr/gTIXK2aNhJdvt1DeFShKpk+HQ6vG7+uF8LlLnBxkT0Zm+1kYDq+vXlYeeNPB1HgvClL79zfRNjOnUBgxsBTdN3Fcs5L603nBkf4EcquTTtz1ht9isiTnca09mriELa+eAxffdQ2E85A0LgoXynEVzgZQfit9x8lRFTetbi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019884; c=relaxed/simple;
	bh=T0ZF/MSQPxoXbdeND2nqhn2dvUTbTXiOsAEhIxy6O68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDc04JHRwiDmF30aMarFRAcE3DTN1zyxyyFH9akgwcpxNLvj7mnXZOIctYAkpUfJS9WvVqiqeu4RCxoXVMMQxxm9aLrQc9+0Idpjm4RQTZkc6C/GKNuH2BFfoAAekM/NYXg3t3eMwpr/3JuzY6KlrxjSc5+aUbUl2kV9ItJEhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fML7blr1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WWJz0bHgyKEqMRH5qw9++gTE5Hm8o5NCfWAZnoc+qxA=; b=fML7blr10g1bqGSV/zQkLk7an9
	TkghWxROm6aACnlA8+bj3RGZBlkI/RTil4kHQ4ZLo2qKwWQgMbwsCPT2AA9vrx9fgf9T8eR+MxAc3
	XR1MUaEy9c6zIoFzYNhfgKQfWyQ2n8a6BSbLtqbRT20YjjdDdtMrSpbF8cXwDJQ+ieVm5svNqD61n
	8iySGJyVhHiJnaIKJoNcl4oUU8JqPSjYhP9jwK2YO+yQfWnS9i1LjuHuhvrvgHNAOfnsnfCmVS2ix
	ucJySfOZ5Snfo/QYQfBfJHUi/TOvYCHqmz2gMA+utHF0TMT/twkfxA2/o4nWTSu+kGbGqrVqmN+i2
	eYFrSwBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1kA-0000000Aezr-1aoJ;
	Wed, 03 Jul 2024 15:18:02 +0000
Date: Wed, 3 Jul 2024 08:18:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoVrqp-EpkPAhTGs@infradead.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org>
 <ZoURUoz1ZBTZ2sr_@kernel.org>
 <ZoVdP-S01NOyZqlQ@infradead.org>
 <ZoVqN7J6vbl0BzIl@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVqN7J6vbl0BzIl@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 03, 2024 at 11:11:51AM -0400, Mike Snitzer wrote:
> Will welcome any help you might offer to optimize localio as much as
> possible (doesn't need to be in near-term, whenever you might have
> time to look).  Its current approach to use synchronous buffered
> read_iter and write_iter, with active waiting, should be improved.
> 
> But Dave's idea to go full RMW to be page aligned will complicate a
> forecasted NFS roadmap item to allow for: "do-not-cache capabilities,
> so that the NFS server can turn off the buffer caching of files on
> clients (force O_DIRECT-like writing/reading)".  But even that seems a
> catch-22 given the NFS client doesn't enforce DIO alignment.

As I just wrote in another mail I've now looked at the architecture,
and either I'm missing some unstated requires, or the whole architecture
seems very overcomplicated and suboptimal.  If localio actually just was
a pNFS layout type you could trivially do asynchronous direct I/O from
the layout driver, and bypass a lot of the complexity.  The actual way
to find the file struct still would be nasty, but I'll try to think of
something good for that.

