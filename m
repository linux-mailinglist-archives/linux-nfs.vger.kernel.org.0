Return-Path: <linux-nfs+bounces-105-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609557FA7D9
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 18:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB7B281613
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Nov 2023 17:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3629A37156;
	Mon, 27 Nov 2023 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QoBl/5Qa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA684B8
	for <linux-nfs@vger.kernel.org>; Mon, 27 Nov 2023 09:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=izdgl9OMTrve/VgGaU+Po2+ZToRQOkGAUt7Q3g9emHo=; b=QoBl/5QaMQ4O9f6rWlWCe0H7Xi
	aQHJKlqr43Tq/59Bxj5+KP6T7zHQ4s+dwhkggnLx0LOE/wtnMGowvkpjk8XVbtvXlGAMPfK1u1DlF
	79ADzYf+rWMEDIHEvgjq1CH4YGr99QvohuVvd0sb/druzoqYxDAE6yB98RSUAx1aQZC63O9uHIgpK
	bd8P3rA4jZvUkPvN7H3mzPQnAtKluNvhyiqxW3MZo2u0EPqx9gElTAtCKcQsLdjCoKZVyM3efuoQK
	D5gew1UGEc0YYlzQhuwtEz3W9FaX9+y56eycuRG0Ifv5o9nxvzJ+Gf2IJ4Mj+qBVUatynylU9BAsC
	+xFORQtg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7fGh-0037KU-3D;
	Mon, 27 Nov 2023 17:19:36 +0000
Date: Mon, 27 Nov 2023 09:19:35 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"tao.lyu@epfl.ch" <tao.lyu@epfl.ch>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question about O_APPEND | O_DIRECT
Message-ID: <ZWTPp8R6ywfT9hRS@infradead.org>
References: <c609e5f9df75438dbfe3810859935d58@epfl.ch>
 <2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
 <7d2d17e4d3904d29b75fadcfd916b2a3@epfl.ch>
 <ZWTFn0/FtJ5WuQGc@infradead.org>
 <20107e878f185628a8d498ebb046e55618abfd4f.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20107e878f185628a8d498ebb046e55618abfd4f.camel@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 27, 2023 at 05:08:22PM +0000, Trond Myklebust wrote:
> Note that APPEND would only really work with O_DIRECT, since it is
> anathema to cached I/O to not be able to control the placement of the
> data.

Yes.

> In addition, the model will always break down if someone decides they
> want to write a log entry of size > wsize. Once you have to split up
> the data, you (obviously) lose the atomicity you need in order to write
> a contiguous record.

Yes.  Note that there is work going on to define atomic I/O limits
on the various Linux lists currently.  Although in the block layer
we also have a separate limit for the maximum append size already.


