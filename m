Return-Path: <linux-nfs+bounces-4127-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D98D90FC2D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 07:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63541F252C9
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 05:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D681CFA9;
	Thu, 20 Jun 2024 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T+fK1puM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F41CD2F
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718861186; cv=none; b=Gp9NbW/w1YlnYnktQR8w9J5bV4XkeeeVP2vsc7mm2EuwRxUzZZ6RR+7TZfcvQCudq3wM1hwRTCH3p/c0yQTDv9JV8mhVurEXuJJBDrf/b5uAWLdQo3RG7Z2c8cre8dXFRTHlOhXMKJZJaDMJvdLpfdpDWwI+SvcsF/4h3Khw/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718861186; c=relaxed/simple;
	bh=0ABZ5YqhxrdelrFpUosq8JlxmriRG5n1e7hERBPcvaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2il4XcJFABCox9sfPFdi6w6p726ERwhylA5kW/6bPTGFE0BOtYUSGzjPo1Cfvuo9EA8ST/rESUlI5CjMbTofdTtsYXkv6KuoSmWf6mkG699DdEKL/4ycRuS+61g9lmUuXPVhjLV902Ggdbo01HVTs++O9jEaO95obl4ORTgOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T+fK1puM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N0gchst5yWvErJUKB9QZxyzI63wV9XxUBgE8WVKD7H8=; b=T+fK1puMZ0j7qUljQ2j6gK+e0A
	7ofAzdVEIr4QM80wxQBCVFqlQisNhmNVoJ6McxxFm5WyRz39gBJb6EifJRdT++ukS4y8oj3mu57XR
	HtuSAiY7GE7R9kSUGhd8ce0WJkiLOgwj0vVFeMHsAxe82OMSVxVb6DntY1SNcyEMx29UkcID4kNC2
	uquM5Eu1C50189Ry4+/YS5YKC8nxTAsMhGAfP2mKGqXDL1ruM/DXQ4OhSk14eViJ+U+EQB0piBTmu
	49Gqi+WfHm5RXXCI2LIZ/K7M4UQcvsO8/lTFBvYIDnpejuXpx8dqm8HWQzb3VlO4KhV0XbB4mC6LY
	R6vGxDPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKAJU-00000003gDA-1I9z;
	Thu, 20 Jun 2024 05:26:24 +0000
Date: Wed, 19 Jun 2024 22:26:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
Message-ID: <ZnO9gBD4-P1bsEmN@infradead.org>
References: <20240618153313.3167460-1-dan.aloni@vastdata.com>
 <d2f48ca233f85da80f2193cd92e6f97feb587a69.camel@hammerspace.com>
 <ae298053-bdee-4a8a-b6a9-e57de79abc97@grimberg.me>
 <5366ff2a4f731dbd93a56e109d6809a5348cf080.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5366ff2a4f731dbd93a56e109d6809a5348cf080.camel@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 19, 2024 at 02:15:16PM +0000, Trond Myklebust wrote:
> BTW: We've been asked about the same issue from some of our customers,
> and are planning on solving the problem by adding a new per-file
> attribute to the NFSv4.2 protocol.
> 
> The detection of that NOCACHE attribute would cause the client to
> automatically choose O_DIRECT on file open, overriding the default
> buffered I/O model. So this would allow the user or sysadmin to specify
> at file creation time that this file will be used for purposes that are
> incompatible with caching.

Can we please come up with coherent semantics for this on the fsdevel
list?  We've had quite a few requests for something similar for local
file systems as well.  The important fine points are things like keeping
the cache coherent if there already is one and only bypassing it
for new data (or alternatively writing it back / invalidating it
beforehand), and the lack of alignment requirements that O_DIRECT
usually has (although that doesn't apply to NFS).


