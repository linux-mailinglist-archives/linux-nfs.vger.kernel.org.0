Return-Path: <linux-nfs+bounces-4459-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B1F91D731
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 06:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C560C1F2165D
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 04:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A028229AB;
	Mon,  1 Jul 2024 04:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P9Yaxpqc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB6710A09;
	Mon,  1 Jul 2024 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719809142; cv=none; b=fT4j93menmNk/AEd4mb19p5vA5kR7OdFppSMPd0XoSV8AwHRddYY9NRi2+SN+Yl3OIm2yKI75yu7FYV0hkp+vGxEOC+KLE5hKiqq+Bu/7D9TRIWH5BC9XUVucDxbFXp96HJFJbQpeJo3GjpUs82WfS2ta1w6j55X4Cv4HNP1Y9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719809142; c=relaxed/simple;
	bh=H0J2kaz9+6SpeWzW9E0vSPVty6jO8RgOaLDmVHaPQAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLEwdD74fbJYnU8znaGOtAF1mjm8Q5Pb4GDWzlL4chmg8pfe8StTLaT8FRzYJWSK2w1S6KfnjmLgt9pvu8OO44lThfU0lSl/Yj2OfZb51uRT8g289TBvI/mljYicrtQTNisGyt0G/p0QHWCNYLWIuJzkin4rvJ6JL00GcmVWSuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P9Yaxpqc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u9K2lBHdE8OP+qvlVN2VkQaHZ1cF96b2/Y5P3mBV0TA=; b=P9YaxpqcZ1EfwvEL/CWC98wcgU
	bzAwfL2/4d9HDuxlz5ESR5tCkXijigzhDKFwkB1Uo15uR5A66HeCssKxjZXD8bSoNhraq+nW70eLY
	vuaBnZNZ0qUag6Z184WZniM9pw6+vZ1jjZpmEGcz/Lc09IRTx8tIzfSyFYzURvvglmtto9gZMp0cU
	uT4x1JYc1Qp5i+0T+mmkld2jhe1CIVoTIMEWEJR87b7KtbGJNpHHI7K2/i5IRZk8lxij++kJYi+zv
	SG+Ns1QarHEKVr/y2aI1FhVI8eFPr006hd1Jnw9e8Z59EBvL5xfw23eO7kRUrEbRcdE6u2Btt1Dsl
	+WD1YALA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO8v6-00000001gKi-0wHJ;
	Mon, 01 Jul 2024 04:45:40 +0000
Date: Sun, 30 Jun 2024 21:45:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-xfs@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Message-ID: <ZoI0dKgc8oRoKKUn@infradead.org>
References: <Zn7icFF_NxqkoOHR@kernel.org>
 <ZoGJRSe98wZFDK36@kernel.org>
 <ZoHuXHMEuMrem73H@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoHuXHMEuMrem73H@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 01, 2024 at 09:46:36AM +1000, Dave Chinner wrote:
> Oh, that's nasty.

Yes.

> We now have to change every path in every filesystem that NFS can
> call that might defer work to a workqueue.

Yes.  That's why the kernel for a long time had the stance that using
network file systems / storage locally is entirely unsupported.

If we want to change that we'll have a lot of work to do.


