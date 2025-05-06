Return-Path: <linux-nfs+bounces-11489-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA354AAC650
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDED4A2D36
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1B28151F;
	Tue,  6 May 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dFV7/92t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DF280A58;
	Tue,  6 May 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538267; cv=none; b=ncIzR0CUZsu0B7bhTqE5yvoTxjDWqkouk6Ku8rCtdYdfM8V/x2rbJDlXsPqAF+DoU/CRF8OMPx2gTOTdLTK0tl1lsfIMEjvKYp5dQP37BWYQEDeVN1u37VxXS578FENMxi2q98meGwugnYpfS2SMo7n8BVfZnc32otWCdvzvLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538267; c=relaxed/simple;
	bh=JtzzWX6YeQZV7EzG6OFEFuSjgpICec4qxVAndJy9b60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGaxUqakVvsjDNV118rZUEWY2DJtt3mNme4IUf8Ycm+flFLlm9OaqY2OdaNNlz1uPtcIAcpHTS2X81NWD5hoHpETLEIgUTYaeeYk/1m6YoQRlOnIL7IbXgwUa+pMRZ1bgbdDWbK+7c/uv1qTkk7MJOYDgA9TVcmlUukhYC8QjgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dFV7/92t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EIZ8PxGh7GJPm8/iN5juQ/Dk1g2OGRQeWQM3DJpxcu4=; b=dFV7/92twk8ZmEVheWwN9LqCfC
	eKNFV+99uFFH9NrvgolyqnrycOhMpI8ETPK9Of2YYsh5NC1TqH4S2WMQYc+oysJgX9TtK04li/e5j
	d2ql9vzF4J+oAlXnlI/hzL+DOxjVF9pSae3Bqdd2rW2OSKCgboh7JhHCRm+vjXvTH5LER6YC6Rmff
	Ks+wO5BfKInXv97W+fu5P3dDu7cypczW6Q6ghAayYWUdZenRDnGghKH5RQKVffZegzLCEZZ4s8FS1
	pfz1h3YU8Lrd7gQwLUtdT9FK9IH3d/JMXY5qwnS1UrClBrqKtuoLYPmSta5G+9CotXVQy541LCum5
	Gxc7L37A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIO0-0000000C81k-0Et3;
	Tue, 06 May 2025 13:31:04 +0000
Date: Tue, 6 May 2025 06:31:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 08/14] svcrdma: Adjust the number of entries in
 svc_rdma_recv_ctxt::rc_pages
Message-ID: <aBoPGNyGg0YPenm4@infradead.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428193702.5186-9-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 28, 2025 at 03:36:56PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Allow allocation of more entries in the rc_pages[] array when the
> maximum size of an RPC message is increased.

Can we maybe also look into a way to not allocate the pages in the
rqst first just to free them when they get replaced with those from the
RDMA receive context?  Currently a lot of memory is wasted and pointless
burden is put on the page allocator when using the RDMA transport on
the server side.


