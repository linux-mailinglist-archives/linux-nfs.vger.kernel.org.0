Return-Path: <linux-nfs+bounces-11551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF9AAD83F
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 09:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E3E465C81
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 07:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DB8210186;
	Wed,  7 May 2025 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sWax+VhP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C30219A94;
	Wed,  7 May 2025 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603291; cv=none; b=k8JKnSbN44SHfM8YfsUn9DFfYGFsJRFGDI0Vvc+i+Z0TaajNRKMuP/9x1HfDnytUb0KtJGHRL4sMDDUVRL4El+JAnc+CJD//bPRoBduGpprnnLm8T57tomwbAbE+G37Vyldegr0d+Q/hQ0Kb+OmZ8FvjghmanQ8Ppzryi16HsL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603291; c=relaxed/simple;
	bh=FRJMIxuItrqlBH6hD1fxtf5iWOAq9HO1NS/4YNco+gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZoBaNJhRfHfSnR3YtQ7MTeAxtG1w2QgXBYyMlacJj7476h/hjfZI1fjL/DUas9k5FW1bkJjDuNyE93FAUVMWYrhfMg1TsG5ILWIU8HY1MfGCgVWhF0UAyhjhNKNTkhqrLpcPyTFrnkgrT3xWeJFjyVz++7uDli7WLA/T9YsHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sWax+VhP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VB7GNqcHALqFt6+2NfxKfelVFxEvl27IRcoTg3hyhkk=; b=sWax+VhP6L2w+Pn1r9NwJ5QH2P
	uowq+8HWGtTwz7W8Vu1iQR95h1LgMc140DSvomcDM+J8y0/CQv0+mwPy9ovQsDV79g+9zeeAcdRHx
	4p2PBoSAfYyVSDcCT0x0XkDGCkWh0CPg2wdEqoHXDjcirohJyfTciGrVtiomYmEDPSemgkBN+fqaN
	6Fup8ac4qMk05Tw+efPNzOvf84X9o3eNG2LGWZ7++6c84Ndm2RkQWcTaqRaKsHgvEYBuO1F4RgmNt
	ku5n7OKA3bYpnRupTnt2AmmC7YTb2gP+D2/feGTNZLdB1P9GEJeC8M92mzGZUWsLlghQT8/dl6l6O
	SlFuN2zQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZIm-0000000EYNS-1Mvz;
	Wed, 07 May 2025 07:34:48 +0000
Date: Wed, 7 May 2025 00:34:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 05/14] sunrpc: Replace the rq_vec array with
 dynamically-allocated memory
Message-ID: <aBsNGHoahR2FJKA1@infradead.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-6-cel@kernel.org>
 <aBoOr0wZ5rqE6Erl@infradead.org>
 <1ad45c3b-8882-4583-9cb2-afbc232e08d7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad45c3b-8882-4583-9cb2-afbc232e08d7@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 06, 2025 at 12:31:37PM -0400, Chuck Lever wrote:
> > And given that both are only used by the server and never the client
> > maybe they should both only be conditionally allocated?
> 
> Not sure I follow you here. The client certainly does make extensive use
> of xdr_buf::bvec.

Yeah.  It doesn't use rq_bvec, but that's because that is in a
server-only structure..


