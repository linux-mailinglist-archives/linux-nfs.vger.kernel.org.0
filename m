Return-Path: <linux-nfs+bounces-3884-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C05A90A362
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 07:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D101E281560
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 05:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F4C14AB2;
	Mon, 17 Jun 2024 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PdWzsubq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2D17F5
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 05:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718602647; cv=none; b=RLpGaNaTv1koXkTALMeeosRJQ+D+JD1Uikv6ihVsKfXtP/Mj23w4XQbVK/iQNaogqPmeoKF93NE6E30E8mj4Z+wucuhoD6XHGhLFMWDaq4BT/WZcOviwoEXiq/0UxdRDx0GCl8orM2l28IOn3ai3m3X7iPMHZyGHekXxcqfyj7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718602647; c=relaxed/simple;
	bh=20vrn2u6N67u229YyOqwWgI7AEbnHurtvAwChXu6KV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JW7X6h2AElWW46/x8vFVhTIhAXZvOqey+QiqlFzjdiZiD1mCs7KNEmzhNmrAe4YC0g99a739CsLOaC6oKaCi+3lUOBPvfDFepgMO/q6XJoM/d75pMAFXJuFxdxYuSoOVfTuFA3vzIy0BZubsWTDP22km6yf8sY8mg1dFY6wx8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PdWzsubq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hRxigAfUhFafvmEQq8lLg2R9/aC4XLVEJz5pUP4c6aU=; b=PdWzsubq9kWNipCQINNAelVi82
	9zIzVVTF5QsYiXpRZ7vpzrrPeCtfIwPsDNEKzaVOQRqweg8PNfC8m/CimEnpI/MYwNElUVfFjvFss
	KqhuCX+rwsU0B5eBrNd+UTPxB883+dONDZzJwNjp8GIFchDemzBCUbHJeNqmRWSYVoXS90rgikxl4
	gE8yaW7qS0GoXFJKITz1EQsq0ESgGWzEcm7TT53tgn6GQ23z5dUfLfrd26K64j0lDrmjMXqbnIPTt
	9Nxyfx6hWRBaDG/WBn8JiTVbUxnVGwTGNrR04SK6iSeNjHVdwaa6EuUBVnxjvmw9DiX/e65nOU5K/
	O1Hpa1lQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ53T-00000009Erp-2xO1;
	Mon, 17 Jun 2024 05:37:23 +0000
Date: Sun, 16 Jun 2024 22:37:23 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/19] OPEN optimisations and Attribute delegations
Message-ID: <Zm_LkyePKGiZvNs3@infradead.org>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <Zm0z5RW90ucxfHSa@infradead.org>
 <ebf1bc0ca71f8f90f2737d0b974165cb4cb3201a.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf1bc0ca71f8f90f2737d0b974165cb4cb3201a.camel@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 17, 2024 at 01:28:26AM +0000, Trond Myklebust wrote:
> On Fri, 2024-06-14 at 23:25 -0700, Christoph Hellwig wrote:
> > Btw, your patch mail threading is quite broken, it replies to the
> > previous patch instead of the cover letter, leading to really long
> > fake reply chains..
> > 
> 
> I'm just using the 
> 
> [sendemail]
> 	        thread = true
> 
> git config option. Is that no longer recommended?

According to the man page thread = true is the same as thread = shallow,
which make git always reply to the cover letter, which is the
recommended form.  Try removing it or replace it with 'thread =
shallow'


