Return-Path: <linux-nfs+bounces-3851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2F990964A
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jun 2024 08:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980C0B21C5F
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jun 2024 06:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5107913FFC;
	Sat, 15 Jun 2024 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2OmLnmSv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA35107A0
	for <linux-nfs@vger.kernel.org>; Sat, 15 Jun 2024 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718432744; cv=none; b=EW9aOKA5pWBIYVXnxgQkvYKFDpJGf5rx1YA9x9SnengGeKWudIjWiT+HCowjQHUAzHInZ5OhvPzvQM8ZjXij1mNgDDlXU8ADF/hI7GD8IZGzSCtySbn4/JFNA1mLamnMBgFsBPW6mNoxyQzgayyHtzVrS90buiPoE6DtiQDm6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718432744; c=relaxed/simple;
	bh=wlK5jbTAQZzhsCmlnoTMmv6AixA9QkxlQLf4EXAPf/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+bFpEtoDXwq6QruolmnN9rGDnpGfAdHU6gWjQlhltVISup6wq5DRShfpbv8AjI3GVcgI48uViQp7oCJMG0OWJeiVgepcKJQUUhV97NQ269sNKOl3boh1ZBBVT6i+QTUTLk79loS7bA1Cu6pr741jzg1JRsVpHW63DMnEw2zeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2OmLnmSv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wlK5jbTAQZzhsCmlnoTMmv6AixA9QkxlQLf4EXAPf/U=; b=2OmLnmSvj/Zey31YmFomOXz8hF
	h0Tpx6YzD9EIJMusOqwbW6/z7EW2Ne5Sg3B2ErMz2oZuoF1hRPocMF7si0FUlTETY3M71gMhDerKU
	a0rjSTtpwG6RRg7vEF+VAD2MHeL9a19VESheVIbpFqDqsz9i04xt48fMp6Ez7ge6KMfwsSyFNxhEi
	WAu4bZt1ArIsMApQ82FIT6YlOpIY2ic15sVRMeDig6Gmw/cojVg/gKFHteaFzb6rlwiKx0ZIU3MCt
	BTnhps+zLjWBcy39OE0qz417SrKLpH1unhiVIBdieAYoCoWKNyujWcaR74TZhyXShVtiua+aVP4NN
	2B6PD4IA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIMr7-00000004nYf-1qkh;
	Sat, 15 Jun 2024 06:25:41 +0000
Date: Fri, 14 Jun 2024 23:25:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: trondmy@gmail.com
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 00/19] OPEN optimisations and Attribute delegations
Message-ID: <Zm0z5RW90ucxfHSa@infradead.org>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Btw, your patch mail threading is quite broken, it replies to the
previous patch instead of the cover letter, leading to really long
fake reply chains..


