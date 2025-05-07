Return-Path: <linux-nfs+bounces-11553-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E3BAAD8F6
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 09:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9772F3B0650
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B564221FD5;
	Wed,  7 May 2025 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XLLQGYYF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30E220F4F;
	Wed,  7 May 2025 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603743; cv=none; b=RFsrJ8qIREtilzqzTWee2O7Ed7VHQb4+Iqoe1GqwikfhhLv90h9NAcnIqO2xgON8zYk8502SILZVTXuU4Xlb6Ik15d1lW8rd4UwHlAsicRcO9AKczuE9G53iaCCjTJH4E+/eHN47VzEDVceZPWcNt2bLX5XSzgbqKgnOfR+E9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603743; c=relaxed/simple;
	bh=HHp5H7G2E8fGD9MVdYFQmn1WrfJCaPcz5UTzKMcuINY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXI09tNLiEAs469xWGjV4tIzfnvjU4U47vj4BxtWO6p47zhDLmozQlkxN3W9pmeQ24vTmgrX72CqepAhg+hXSAJ5z6t82znQAi8bpiTmXs/4CdVqBQ08HQxLX301Ns6OmyQf7Sgg7kFku+bvPCSL6nIS023vY5L7rKCJC4APL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XLLQGYYF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0ke6EYah+uY4vpjtJLy0dpIgV5ZCmCNv1pgp/+dxS5c=; b=XLLQGYYFwm7JiksHJp5h2ZTn3u
	76st4NL1kAKyNatOXdW0f1wo7wc4cNINf+uXaghVMWnZM0Ypk/+W0r4P/P/4E3kRiZokgJ8QYhqBl
	dB75HXPmsaz74OuRXf55qa35V8/XM4wYqquPPbVdq09Tuxfcf/QgMI/NPcHqHt5UZ9RC01T/5zrWj
	FkcJfOwqYo0Cdw0XL5dp6d6gudD6X8eYocNpozsUysacsQBpJSGtdyvQIzpz7QOklgcaq/QcmF3RA
	xTTvz/YA+bkSppzbRCN+D68gr43SAAfubLFyNaqik8Ia++0z/P0KBmtGtFxqy4qBDAyy24h9+Ge0S
	hM9FNqaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZQ3-0000000EZrI-22QD;
	Wed, 07 May 2025 07:42:19 +0000
Date: Wed, 7 May 2025 00:42:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 14/14] SUNRPC: Bump the maximum payload size for the
 server
Message-ID: <aBsO28mbIZrU2HHD@infradead.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-15-cel@kernel.org>
 <aBoP249KZ5G9hU81@infradead.org>
 <390ac9ce-d32d-4534-a406-52288f79ab0c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390ac9ce-d32d-4534-a406-52288f79ab0c@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 06, 2025 at 09:52:06AM -0400, Chuck Lever wrote:
> > Are you going to wire this up to a config file in nfs-utils that
> > gets set before the daemon starts?
> 
> That's up to SteveD -- it might be added to /etc/nfs.conf.

Well, you should be talking to him or even include a patch.

> > Because otherwise this is a pretty horrible user interface.
> 
> This is an API that has existed forever.

Huh?  It is a brand new file added by this patch.

> I don't even like that this maximum can be tuned. After a period of
> experimentation, I was going to set the default to a higher value and
> be done with it, because I can't think of a reason why it needs to be
> shifted up or down after that.

Why not?  A tiny desk NAS box has very different resources available
compared to say a multi-socket enterprise AI data server.


