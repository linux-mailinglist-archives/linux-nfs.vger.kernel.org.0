Return-Path: <linux-nfs+bounces-4123-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9411590FC1F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 07:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37AF81F243D6
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 05:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB422C6B6;
	Thu, 20 Jun 2024 05:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q0CnJbxo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823112C684
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 05:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718860400; cv=none; b=nEYnG+U/MkzQtqm7VRnYmNpxyzVRE5DemkEk3fC37v2ZxL+h0BnrpyJnrSC0LIrYZ8IXu671FDCQGBy9Z1+hd8UjX1hLvDViEjdMJovkCpD/JgVv7qqmMZqHnzdnLdyElLg40EZkkuQUT7JUdGdk0C84f+iz+0m9WG5JRmbp27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718860400; c=relaxed/simple;
	bh=NTqEa+bMYZe76Lz35GXbR0JW+Y4DLhNR9olTMpzTv7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBwiLT/lZgeY1X88b2SKn+y3fpfAyXfB2S87yxfuZluJetjPuGy5iEDJqXZDLipMXYxkebEy4mD0vdkWzfWpMxcVpVzWx/VpBXMr5ENeFB/8nyi0Gzv4QGriPZ0DFbKSTLMCSDW7cjb5lULUPOO5ThlrYLvkTJoP6ZSNvpGlF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q0CnJbxo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pJbu4xr/1jdL7Q7Qhb/uhTbEPymPcNpZ0eC7bTaHDNg=; b=Q0CnJbxo4oacQ0wwxcVQ0xneJa
	FnCAVoV9Ql5dR+At11QS7w/zZjzOooPMovu3k8JBV2dGc2L3p/uRAx/RjHBMZr9vFlZgE8XIu0O6k
	PfVlgjGhoGZF/1IcvHnNHmdyHsaImUdU54gnVQkbQVt8sw969BWxfau3KC5k7cgNm4vGL4d5nAOI2
	qMbBnIYJOaVPW0jA6L9aoZk8HNvIgeVpEpp2U1Dsk/33+Xddpyme4h09mLFNFTZLm17BtevU+nCvB
	V8vCihq9dm9kz+sH76LZfVhBd1fMvOW+a78HsckvVcvyT77I4V+I42z+8P0FtFv9oi6KxUPIFym+9
	oSrcFcKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKA6m-00000003emB-2fL2;
	Thu, 20 Jun 2024 05:13:16 +0000
Date: Wed, 19 Jun 2024 22:13:16 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: add 'noextend' option for lock-less 'lost writes'
 prevention
Message-ID: <ZnO6bAJWqqp-ESfY@infradead.org>
References: <20240618153313.3167460-1-dan.aloni@vastdata.com>
 <ZnJwTaTw5JEOnuLw@infradead.org>
 <3cd6df545d9230758db38a4b7e5921dd57089153.camel@hammerspace.com>
 <7b0eda741ac6d575db7d69da6b14799686e02c51.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b0eda741ac6d575db7d69da6b14799686e02c51.camel@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 19, 2024 at 06:03:02PM +0000, Trond Myklebust wrote:
> > So we end up compressing ~35000 RPC calls into one. Why is that not a
> > good thing?
> > 
> 
> BTW: this is not just a theoretical thing. Look at the way that glibc
> handles a size-extending fallocate() on filesystems that don't have
> native support, by writing a byte of information on every 4k boundary.
> That's not quite as dramatic as my 10 byte example above, but it still
> does reduce the number of required write RPC calls by a factor of 256.

That's a bit of a weird case to be honest, especially as it is an
invalid implementation of the fallocate semantics.  At the same time
this slows down perfectly normal log file workloads that just append
a few bytes in every call as each of them gets blown up to 4k.

Maybe we'll need a heuristic for servers that don't support ALLOCATE
to work around the broken glibc behavior, but in general blowing up
writes to include potentially huge amounts of data seems like a really
bad default.


