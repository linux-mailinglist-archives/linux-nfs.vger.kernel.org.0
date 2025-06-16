Return-Path: <linux-nfs+bounces-12477-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D94ADB1BF
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 15:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82BE3A37EE
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B4C2D9EEC;
	Mon, 16 Jun 2025 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FT0Fd39Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10E2C3745;
	Mon, 16 Jun 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080222; cv=none; b=P71TKBBkVmCUcA78gQDieCjEAixgbP4E6rI7H9UQCWHQ2g34wHoGqQvBWw+JFGn51B0tcwSd0WhxK0x8ifEYOWzizgjgRmrqTfwQNYaaar0wBEyzl4dC02YGXxBIlc6tjok3YkFtNIQaDECgeFoax8ANPFGLkUkiwT458uwV0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080222; c=relaxed/simple;
	bh=2oBvNQrWsiRyPdhD15PGNTGXKZtuko0STd9ktC6ru44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg012D+xUPYl/1X53zmAjtH4xFBWCGZ1oLRETr0fLcqOU6YcfRFanM+Mb24sw9+FLeS5z0Pavob6661NqdFG82SxQV8ibePUpUBiKTsoPj8SFhEyCKqOCN0odLKUjNunB787wrwFgwkXEKeNuYC6kZWoEvAjX4OXKS3Ih+m8teI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FT0Fd39Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2oBvNQrWsiRyPdhD15PGNTGXKZtuko0STd9ktC6ru44=; b=FT0Fd39YYvhfT9KZus8rnhozt6
	W2JGpsBq019hD0fn1epUSvgxY2TNttLfw+4cCr8X23LPCyc45ckacbLFb0fgm0TpHNglhrnVSviwJ
	2SCZ8pfbgjDZm9gIH3bVX1lAGj/04eLcWhR0BUhChhsCTzT6JrxcAjacEnFz7142hJscQkLJPO/5Z
	TOVuoHpT3dpHwbxWjqvqNg5AgvySL24NOGEStYopasba7VfuIBFfFvs9BjVsnv9Yyj76s6Z343OYb
	I/kSPlpVhBa7pDGaSgcmtcIsqYnW/O9xGOtGwnpv+IgwsVDWO/Cq/+0NMrFzvj7vTHTFdY05YgNd8
	hksyrWKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9oI-00000004X72-1lPa;
	Mon, 16 Jun 2025 13:23:38 +0000
Date: Mon, 16 Jun 2025 06:23:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH] nfsd: Use correct error code when decoding extents
Message-ID: <aFAa2ggSYZKmYU6t@infradead.org>
References: <20250611154445.12214-1-sergeybashirov@gmail.com>
 <5c8c207c-0844-492f-99e0-48b874b5404a@oracle.com>
 <2eq26bzisytieyfvad46uz5lr55msw6fdzs57lp5lcjmguuod2@nr2aryd6qaau>
 <b6ba7275-ceab-4619-9e5b-a886daf34689@oracle.com>
 <aFAQTwpSSJtDUmu8@infradead.org>
 <0b8605e2-ff29-4996-b74e-24b9097cc9de@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8605e2-ff29-4996-b74e-24b9097cc9de@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 16, 2025 at 09:21:27AM -0400, Chuck Lever wrote:
> Passing in a non-aligned bex_length still doesn't seem to me to be an
> XDR issue. Failing with NFS4ERR_INVAL seems like the correct server
> response for this situation.

Fine with me.


