Return-Path: <linux-nfs+bounces-2441-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB68A886535
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Mar 2024 03:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507BA1F23FA0
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Mar 2024 02:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92E1A38C5;
	Fri, 22 Mar 2024 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ELhrDAFM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44F8387
	for <linux-nfs@vger.kernel.org>; Fri, 22 Mar 2024 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711075083; cv=none; b=rW1EnNa7PTTunUxV78biAkxJf1Wvpu0v1ZA7OlVNGHOhfaRomr7JF/HWQaqxtRuUbzxVmc/S1WJBqxR1bc5jJV1c2rLcyPaj7Nh+fOprC5ORMyTkb5QhxEY7RzEzLuZKuI/rXj7KtTWXP++dzJ8DEEwvEYWuKYB54GxbrWfNnuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711075083; c=relaxed/simple;
	bh=0iPnfcSlC30Z/CszmZOSzCzy+hktL+N9CiLZOxmd2tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qbz6xKyUbjfFQEtzGSU5no6wKChE6oda5QKMZVeZwj/ARwt+TRshS6MWJ32gZDimtgk0or9s94ETp531jmr/952MlgijlFVOtWQ4tJ2uemDS/SeyIVJW4WZTP3umKKrskPbyxfigTlDTcHYWPyA4E28B8qgT80EmuO0BaQf5gRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ELhrDAFM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CFpVKJVJRfjSWuMbue/EbEUElZ2dHk7l7G3ViVHfJPk=; b=ELhrDAFMoI2V+AwWxX1YPjUgfl
	YULDcLi12H4VO4+DBR07cg9+ytkUKHZ56JRrnMG6HMNL9jg3FzXpplvZp8ZuUZKO/U6ARZR+B0Ans
	YKsYinPt6W2a4jQHKolrErcnRcP/YZ9JWI8CWkcfuQM64fCuWc2iHNQBrGAB4cCxMJmOVkZH1o4Yv
	p44fi1+G2BW09bRthhGj8Zjm0YNkOMAqHX9FMxtBAPA2J/W0bIqyfO69wQPjSYsY+hg8/AVcSIv50
	Z6drcgLgX9ewXWciuWAdGS/A6/gkCrm6ApCUHuD+9kkAaokamhZ+GLJeUcgLCkF5SElDKiJshuizD
	MeBlXCsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rnUn5-00EDmH-1U;
	Fri, 22 Mar 2024 02:37:55 +0000
Date: Fri, 22 Mar 2024 02:37:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: Fix error cleanup path in nfsd_rename()
Message-ID: <20240322023755.GL538574@ZenIV>
References: <20240318163209.26493-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318163209.26493-1-jack@suse.cz>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 18, 2024 at 05:32:09PM +0100, Jan Kara wrote:
> Commit a8b0026847b8 ("rename(): avoid a deadlock in the case of parents
> having no common ancestor") added an error bail out path. However this
> path does not drop the remount protection that has been acquired. Fix
> the cleanup path to properly drop the remount protection.
> 
> Fixes: a8b0026847b8 ("rename(): avoid a deadlock in the case of parents having no common ancestor")
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Al Viro <viro@zeniv.linux.org.uk>

Sorry, my fault.

