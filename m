Return-Path: <linux-nfs+bounces-11488-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81640AAC633
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F0D7BCD1C
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA8A284688;
	Tue,  6 May 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3U0UJIBM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84EF284679;
	Tue,  6 May 2025 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538163; cv=none; b=fFsYRubWe4awI/W4G2V5hznvkzbCE2wrTGucFJESbJ8a6K1JlOIuh7LxyRcr/ogAUM/FSNi+ulCCX28cuEWN2GT34T1oy7DTwIHck87yarBQbkgzrNfJOHdWOrSlBSsVUBHWudAMLP97Xaskg7kAMLQCxnS9+i+EETzNG/QnVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538163; c=relaxed/simple;
	bh=ErC/tezv9jqPHw/uOg9BENIoafe1MeyfD8wemdyYYHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrSZE9iowH0aYZP+UXnb7ZwcZyOP/f9l2580l4x73YvE7UOExObhlG/yBZ5mdTdz1x1RUeabZuUimVnIc+uXntTfOWXG+V1IUx6JINoNwiyJw/m0+FKr5wI8S/Wc4ije0d5xM3fs49YpMp30BPMlLaO2Ch3HGhyiqMfCacwHWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3U0UJIBM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zLnPM0YGI/tNp1jVm6EELDBEp5kXp4CW/BLeGFizPh0=; b=3U0UJIBMDTUCbWYuVjGWrcs43S
	MtJK0e9sh5Rgo8HU9JYdr3PetodZqSNFie4q0uWpbP5i1E2ftvMiytRC/zBqXjZKGFWS/L3ADObBB
	r7cMOUDBfdjWELAWQLHJc7CS3zYKw3ckTeptBiBZIL6MPsXgKlrRkeVJ4NMHTVJxIqfQKjTS8L5X8
	Nh3/psueth+V/DPysprmWDLhZlEjPOYGyIbVY/YpHMiJCLqpSoksCq2VnPJfmLcmMFKFUnj3ZUGca
	uePRRkdAgMMHdJYv8iq6adOoQyL4l89VaF645SG7PK99MpZEY0GtvkKcljEDXJ3i5ISPaEmo8zg+T
	Tbx9oRAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIMJ-0000000C7Xf-2aRI;
	Tue, 06 May 2025 13:29:19 +0000
Date: Tue, 6 May 2025 06:29:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 05/14] sunrpc: Replace the rq_vec array with
 dynamically-allocated memory
Message-ID: <aBoOr0wZ5rqE6Erl@infradead.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428193702.5186-6-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 28, 2025 at 03:36:53PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> As a step towards making NFSD's maximum rsize and wsize variable at
> run-time, replace the fixed-size rq_vec[] array in struct svc_rqst
> with a chunk of dynamically-allocated memory.
> 
> The rq_vec array is sized assuming request processing will need at
> most one kvec per page in a maximum-sized RPC message.
> 
> On a system with 8-byte pointers and 4KB pages, pahole reports that
> the rq_vec[] array is 4144 bytes. This patch replaces that array
> with a single 8-byte pointer field.

The right thing to do here is to kill this array.  There is no
reason to use kvecs in the VFS read/write APIs these days, we can
use bio_vecs just fine, for which we have another allocation.

Instead this should use the same bio_vec array as the svcsock code.

And given that both are only used by the server and never the client
maybe they should both only be conditionally allocated?


