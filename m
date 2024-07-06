Return-Path: <linux-nfs+bounces-4671-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DA5929131
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 07:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35902B222B6
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 05:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539D218040;
	Sat,  6 Jul 2024 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bSJybUk6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF87D28F0
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720245503; cv=none; b=k5K2LRsNRPf4C4PU68E0yaQJw44uaXpmURPNnjJX1Y6uVgq84Oun4P+1YEjwbkMhyShsfj/0IkZsO4A29O59UgJJUevrnAWVQ3HHWTFAySf5s2usL/4oOgPNcKILNthRblCXWgYHPBJ0zaSKLHiUKNzbmq7Gk0F2OFPHbX5/qYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720245503; c=relaxed/simple;
	bh=arEmpRUSFmaFMdrEQkwRMsmpzK0UPGcfexogS39Pr8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeOeirMenxOuzG7c3ijTYvaSU2OCFPx6Wg2BFP2UEJzo/HWVqkY5jc3bcnOfuLQRIF2rHAIa3NloXWQR2EWEPUulnztHhKlBwTZ2Vi3r+Lijb51K7IRDFkUI1+tMc1hy+M8OmKY1KOtnUrd1dCdiSdt523ICCkzcAtsbIhcj7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bSJybUk6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a2kXsLpG9UDutmMs7vYq0PAJuZxJhrTLgc4vtAqQkUc=; b=bSJybUk64OoXqUAyBjNquUSc8c
	mzD8Oxe+wYLq3MWgIGOh+CPJ9CM9bJffwQqOBvoLc+Rww7Y4X9093ou7JWxz++mSPMP7UQRA0Qjuw
	zo4a+AeoD4e+t0ZcruYE/Ol5tVmSCc3LvoiKhQs4xN94WULklhgp1hVKw0dF1Buiekc1a2ZuhEKvU
	62nJ07KOxhUkCILDoZS1vy5IU105hLZh3kXtXkYH25hptgT6lsJOSRKjdwe3MLQjZ67vKVinZIrTQ
	8gHvz1A2H0aEW33vy5fcPXtTUuAbWr0uObqKlitozITjsRCcMaJaZalZXPJf2OvPKfGx+NllxR4WK
	oRe8i1eQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPyR8-0000000HNxX-2wYt;
	Sat, 06 Jul 2024 05:58:18 +0000
Date: Fri, 5 Jul 2024 22:58:18 -0700
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
Message-ID: <Zojc-v8C2ChEOMjq@infradead.org>
References: <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
 <ZoY6e-BmRJFLkziG@infradead.org>
 <ZobqkgBeQaPwq7ly@kernel.org>
 <ZoeCFwzmGiQT4V0a@infradead.org>
 <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
 <ZogAEqYvJaYLVyKj@kernel.org>
 <ZogAtVfeqXv3jgAv@infradead.org>
 <ZogFBqv0z7Rnh4_p@kernel.org>
 <990C712E-99B0-4227-B67D-0DBAA2B2B72E@oracle.com>
 <ZojBAC3XYIee9wN2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZojBAC3XYIee9wN2@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 05, 2024 at 11:58:56PM -0400, Mike Snitzer wrote:
> I'm out-gunned with this good-cop/bad-cop dynamic.  I was replying to
> Christoph.  Who has taken to feign incapable of understanding localio
> yet is perfectly OK with flexing like he is an authority on the topic.

Hi Mike,

please take a few days off and relax, and then write an actual use case
and requirements document.  I'm out of this thread for now, but I'd
appreciate if you'd just restart, assuming no one is activing in bad
faith and try to explain what you are doing and why without getting
upset.


