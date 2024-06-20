Return-Path: <linux-nfs+bounces-4128-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B6A90FC2E
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 07:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D76B22176
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 05:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F33A1CFA9;
	Thu, 20 Jun 2024 05:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AnpY9MU4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2EF1CD2F
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718861240; cv=none; b=V4dfO0Ne/hx+fIaIJv9gOFVIELh/EhyN/subOFeUPDP5N1eirigfm6P5MLWeV3OIK3uAX3aurR8yPQS+GlILDN2iHl/me5NCouUIYJ033seipovi5SYtZf228CqLhRtxFmYIYmZZbjAQoGgHLz1E7M/U1cEyjPRyfziZZzjGKnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718861240; c=relaxed/simple;
	bh=8LZlw6/R8VQK+Vq0OokZF0jF0XR/CrczoodazJAxIHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbhZ7Cyhe6YL1M7RDvcfhqTwNRvEdcW8Sdius0WkfrswLKbqdxV8w8GFUVEttcTLfMwDisBdg8pXHuBodGYsrkgjpTnlZCUkzn4Js7EqriO5JQuRy2n2n8sqz2BbKzh/RPduCDl1qbOCQOqum+9H603UL3qmGvNPV2Yfid6yCXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AnpY9MU4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=idRETg2U1pGFt7SM75Oxx2hxCh0s3g8Q6dWFTSCzG84=; b=AnpY9MU4C48M2W6R307WM0flWP
	JZP04fskxzJUZdkJTTGSiNkIBEmdb70KVuLaG2Uo2B/JXFwZmCW/A1b7vOKYi5C1GGQ6KgaL2NEZo
	8Xf9QBM8r+KTDwk9VnIJrIBUdylWErYmgYAM4NHaA80nDeX4MHnCewpytqyaWStmVboswXpXFLc4/
	Lp/7QzkJ2pzpu5/MIcAqVYjmc0v5NBwySmixiZ5hsBMBgvt3ytK9lrNBtdH9d0FwKazjP1vcsKHDQ
	qD9SRvv35Ji4jxbaFMnKAmY2p65myIXSey0VFZHi8mqaRMzDIkAEBGrpyljt8kH1ZciHUJj2Q1K4D
	2WznwbTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKAKM-00000003gJh-3S28;
	Thu, 20 Jun 2024 05:27:18 +0000
Date: Wed, 19 Jun 2024 22:27:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	"dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
Message-ID: <ZnO9toGg3ARR3e8V@infradead.org>
References: <20240618153313.3167460-1-dan.aloni@vastdata.com>
 <d2f48ca233f85da80f2193cd92e6f97feb587a69.camel@hammerspace.com>
 <ae298053-bdee-4a8a-b6a9-e57de79abc97@grimberg.me>
 <5366ff2a4f731dbd93a56e109d6809a5348cf080.camel@hammerspace.com>
 <50f63382-eeb1-4615-a0ac-987afee11902@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f63382-eeb1-4615-a0ac-987afee11902@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 19, 2024 at 05:31:08PM +0300, Sagi Grimberg wrote:
> > buffered I/O model. So this would allow the user or sysadmin to specify
> > at file creation time that this file will be used for purposes that are
> > incompatible with caching.
> 
> user/sysadmin as in not the client? setting this out-of-band?
> That does not work where the application and the sysadmin do not know about
> each other (i.e. in a cloud environment).
> 
> The use-case that is described here cannot be mandated by the server because
> the file usage pattern is really driven by the application.

The way I understood Trond is that it is set on the client, but the
application or and out of band tool.  Think of the attributes set by
chattr.


