Return-Path: <linux-nfs+bounces-4228-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FBE91320D
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 07:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DCA1C21D04
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 05:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0BE1494B8;
	Sat, 22 Jun 2024 05:08:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B302F3B
	for <linux-nfs@vger.kernel.org>; Sat, 22 Jun 2024 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719032898; cv=none; b=rXucvIP0QMvClCFKxKdwbKAFCBjHgUH7bBsrGIHNENXJlwp6vwUhpVCqILvhbRWEhKBE4A3H+U3kJ9LghwUwLt8cXYjoeUUDu3oampmDRfuljHm2Brl4gdTUTXyP6z6X3vh4leWNhhcIMaKw/2gAN0KLXFeR4ILKLh2rW6dy3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719032898; c=relaxed/simple;
	bh=Mk2tOKOv+apGcNFaDafL1EY6Y0ogOlKyyFIDZnw4Lo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUv0SJuoALYWXpLTHAox3hh86Ggm1mgI2QKVcda6WiQGnWV07SgQFPPGfaD0Ox4GDGx3kImpggzlYNMwWz7EpTzjjVtHAiyKVeazFwBQBlvrbZZVvrM0dNWoyVUMhlicd/SStXCaPZtw6/mOSOdm+llUA4tKcePGWYW0N+bL9QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 788C868C7B; Sat, 22 Jun 2024 07:08:12 +0200 (CEST)
Date: Sat, 22 Jun 2024 07:08:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 2/4] nfs/blocklayout: Use bulk page allocation APIs
Message-ID: <20240622050812.GB11110@lst.de>
References: <20240621162227.215412-6-cel@kernel.org> <20240621162227.215412-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621162227.215412-8-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 21, 2024 at 12:22:30PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> nfs4_get_device_info() frequently requests more than a few pages
> when provisioning a nfs4_deviceid_node object. Make this more
> efficient by using alloc_pages_bulk_array(). This API is known to be
> several times faster than an open-coded loop around alloc_page().
> 
> release_pages() is folio-enabled so it is also more efficient than
> repeatedly invoking __free_pages().

This isn't really a pnfs fix, right?  Just a little optimization.
It does looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I'd really with if we could do better than this with lazy
decoding in ->alloc_deviceid_node, which (at least for blocklayout)
knows roughly how much we need to decode after the first value
parsed.  Or at least cache it if it is that frequent (which it
really shouldn't be due to the device id cache, or am I missing
something?)


