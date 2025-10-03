Return-Path: <linux-nfs+bounces-14943-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D3FBB6244
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 09:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6973A87F9
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 07:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934EE1A3165;
	Fri,  3 Oct 2025 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y7WkQQVb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E08C238176
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475371; cv=none; b=OzPDgsuWiewYR0IeFIiWUznlP9Wn7d487T958vPzy0wfv8rUtblnlxbyEKyCTxgKS00lBTkAflBPpZlQtHd+rmWZ9J3ev94kABWykuj/6mMQK+oOy1nPeTsfvDAdiEYSFcaJA1V2mzNeB4aG9OdSDs6YAKbdXAvW1Nz8VIYdsfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475371; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UERJBD+EqUPDVCsaoZMoPlLN26FufYdhj2voXmLK1RYizzgibxNL0m7opSrE0ciShvSXsgno8Q0KtJzwvIIg3XtsfzBdaK/iaD/J6iMCnkUx9rl0IafacrV9xHuzLpvlnkwfNXqiuC2Kz3tkfGhU6/pHM7qPohr5Q511nt7OHT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y7WkQQVb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Y7WkQQVbdl7ShmYFidhHVzan+C
	GxHx9t+bC1OnyhWmOmvoCEF0ST2+zYbIIIUM4f9397E1H1ky/DB/Rf1t4J3DLP3z/8DByJyqMUUTK
	HpKg9gcbLUo0RyXWdeN06hNorNLf8sm3icXl50wD3VtA1rxGinBBDBq6/aLhk/aD0JT/IuzZPBD5l
	DL948Yl/x8KlEHWzzchyypZh8JRMNectBZxn+gJBplq+lbTfpNjfX+rEjvf3POGeWuda10sjRwzV+
	RP6BNDw6sGw0t5vNi1jPtvu30eIi8kAvM1LQOiGyZznv0GiOSLHN092qED2pf/M1h3Qj/A0v3IQFT
	SFkbN3kg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4Zux-0000000BnFb-0a5a;
	Fri, 03 Oct 2025 07:09:27 +0000
Date: Fri, 3 Oct 2025 00:09:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v5 1/6] NFSD: filecache: add STATX_DIOALIGN and
 STATX_DIO_READ_ALIGN support
Message-ID: <aN92pylvEeuv3lD6@infradead.org>
References: <20250929155646.4818-1-cel@kernel.org>
 <20250929155646.4818-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929155646.4818-2-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


