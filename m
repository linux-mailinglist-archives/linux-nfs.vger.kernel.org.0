Return-Path: <linux-nfs+bounces-3846-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C8B909259
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 20:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E944B23C55
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937F16A397;
	Fri, 14 Jun 2024 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iNDnAVqm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E21474C5
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390088; cv=none; b=Hic9C0oc6SxryEQZxj3HK7HhU0an9CXJQHek0SzRmaFOtpNAJP63oSg5BZi46h42is7Ouf6pvoqPuz5HbzxDir2fFio7n0hhW+6qZxy5Hcs+EVVXNDpM8IPQO/AqAgFSUc6ZU4M3G1G2gLeC8U2EAfneCvBUHsXdKX3+v3CipII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390088; c=relaxed/simple;
	bh=MSy+Mp5BnDYt6yJcVhei657G1YZgPKl4YpVK0/sjL58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tbdmq8B3Asj9x0kPs4idA5QgDXUgHY7r2AbKHtsMYGCeXTgdj8kRcA2bQQ+k0bHqHSg5LjvjliiEMo9H902FbmhxXspLTDKKRJPgplpPRtOPTTKKNlogVWhHCqT+8ONlqeGZpfwjWfKPuXEjNHDiyzX1VtxWrOoZXk3jpeyNEqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iNDnAVqm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HsgS0uD7/wIZlvex5WVWALLsizpiwhAGaxWkvv+86cY=; b=iNDnAVqmylfH1+1lEZZwxsCU5o
	RA6/Z1jFu0RpWy+JFe70vsEx4vEeLdCFwQq/hmQP8Thrw4JR6W6IVjPeE8TpeO6YmMlvRJbth810U
	s/bR4VVarT0CuXwcYJ3FJHH6zzBcGq3JFDKj9fNBeNPaMNhWTQYit6dzj3bmLne/gwojSRtNmO/zS
	/EgxZ+UT5ODPUPTqi2GhE/zHj8YlA6LZxC8dH7JF6nHxoValha2In+KY1es0TrOcHLHsFply6Wo9M
	0qVJmbV0HNV4D1kcJw91OTbR2o3legoD6w44trEWfGCTjXqhfmPlJ9dZYpHJ8m45/hGcrHzNBOZR3
	oqzAco9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIBl9-00000003m2j-0yyd;
	Fri, 14 Jun 2024 18:34:47 +0000
Date: Fri, 14 Jun 2024 11:34:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: reservation errors during fstests on pNFS block
Message-ID: <ZmyNR8ALcWdVoe97@infradead.org>
References: <34F83726-2A28-4E29-A40E-A01BED7744EC@oracle.com>
 <Zmxx-H2KrT5QpJ-g@infradead.org>
 <C02C8230-4ACA-4F2D-AC28-B9583ADCADA5@oracle.com>
 <ZmyLSZGWDeaIXdx4@infradead.org>
 <ED7EB3B3-F56A-451F-A639-D30BBA125EE6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED7EB3B3-F56A-451F-A639-D30BBA125EE6@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 14, 2024 at 06:33:02PM +0000, Chuck Lever III wrote:
> > Well, they really should be alarming because the admin configured
> > a block layout setup and it did not work as expected.  So it should
> > ring alarm bells.
> 
> Yes, I expect that "pNFS: failed to open device
> /dev/disk/by-id/dm-uuid-mpath-0x6001 ..." is very likely
> operator error.

Actually that one is purely a debug message if at all - we don't know
if it is a mpath or non-mpath device, so we just try that first.
So that is totally fine to downgrade or turn into a trace point.  OTOH
a warning if you could open neither option would still be useful.


