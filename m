Return-Path: <linux-nfs+bounces-12876-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C112AAF754C
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 15:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F199A1883300
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 13:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5459C35966;
	Thu,  3 Jul 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xUpZQ6v7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFB24C9F;
	Thu,  3 Jul 2025 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548701; cv=none; b=OzWupsgFTq/aKRON3u9t+o9LvjiFzmofQoVGKJRH3XXKzFzVX4d88fpFm7CaTquRudy2rE2hy5AsI9JbZPb+YrKqr33slS52/jrLdIgRHWLKfej9je1hCUV7Yo7HWX1VCCLrfbdYLQ9Joq772pyp0UvOi6XgzIihuTZLJlLXnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548701; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ci9w7IDH1Z/DWGVBfpG3/sAhKt62zT8FC/gIGxr7W0xrB60T1EgKIBa5f5aGKZYUfhtzC8YwV+/b/0GktJHgXUeeIMBHP+ug67j/x0XakJ6Y1UWavkpsyYmg3aFRNbI58OIaOoQUs3y/kpw17AlVF8WHN3MOksvug6LNSefuBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xUpZQ6v7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=xUpZQ6v7bT0Ci4di5lZ0aY8F5x
	nsFDCmnUodk6koCaQJcO3Wyn2o8cHYVBrQ2gZGrktkvEljp6DoBIMMf5fvn+xcecMcIMux1mF8L4i
	s4eVr6qA1OBTug/IviVQm1jKv6qHRotP3fOv6Oe1L6QAa5tK9Q0UXypIbuzr0Crzr0nB4czzZ0Hpp
	SId7cSxC/WY+FhKU+r3yP4tuYr/pBca4KmmD3nwUpoHxzWJqVrqQXSmtM3zpPaGYWg4oqxYxSSktQ
	WO982NJyEUUbBr2U05P7pXcipMt97yTaJI6PEpnaAmVLQgq3DoTMOPiLt6xbXYqHRowxWSR37L8U9
	s7/S9HPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJpT-0000000BSkn-3GWM;
	Thu, 03 Jul 2025 13:18:19 +0000
Date: Thu, 3 Jul 2025 06:18:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH 3/4] pNFS: Add prepare commit trace to block/scsi layout
Message-ID: <aGaDG0NmUjptc6G5@infradead.org>
References: <20250630183537.196479-1-sergeybashirov@gmail.com>
 <20250630183537.196479-4-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630183537.196479-4-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


