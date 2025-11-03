Return-Path: <linux-nfs+bounces-15963-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D081FC2E1C8
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 22:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3CB3A9FA4
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 21:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B552C21D0;
	Mon,  3 Nov 2025 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LokHeuZF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF626F2BB
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204415; cv=none; b=gq//ruEzVEkJ+Qv7BbQPswPDXpVJ01nAEtr6jUVJnuCE8fWf0DdVcOQS6Y3dC12RcahwKYm0gEZ+Y6XDZdQCk4T64dd8QB3NGwwbHTpmdhsf30VWZ41sjGyrCtHLVDTbfFiGSC3vxYF3c9cK1QnkSiUtWLQ0+aM7VL0bq8cIRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204415; c=relaxed/simple;
	bh=JFcSsP0JEGjOCCZiS/jF1Rgu7ExRXC8jg8Wqm3UJMaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkohNV0j4P5MSOOUL+vQTY6rk5EkHmo6mwBWxvelwEzLsbM5kR51Zr9VZ4fkn19uRH2+WzcH52E3GvY3kaKqau5Ah3kOl9NThlAhvEZH4h/+LcRX0zN7vapDdPRpzmHhBWaAJqHJMJDBRXQ32lLJ6J0Dl7ZK6b8Ukw/LbArG0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LokHeuZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B811C4CEF8;
	Mon,  3 Nov 2025 21:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762204415;
	bh=JFcSsP0JEGjOCCZiS/jF1Rgu7ExRXC8jg8Wqm3UJMaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LokHeuZF6SVOiA4v1G8lMp76tmbcgxoJz7Xd+FaK3MBgJfvx2KTA1e7NqYXqwoHT7
	 S7q3TZjRk/864ba0yT+ddgkJnUPg0i3+m/xVRyDYXRUQig592oLtcvKm+G1V4wCN+O
	 4qr9cgeXplnHH3KE0GezTzuG9iy4xGWFaHIus/m89NYYRBzl3oVpdGoYTIDjl28pWy
	 UA8pzLD8WpkT2pCMh7WyrcLjEqp3TnxByStJHX2SwKEpqqtosKbonYHhclVS7IcysT
	 RhU5VKNrRfDpARLWq28WbY52CewB3YTuEdvoLJrBMdLrMvQZC7+JV7L9ZJh7g4+wj/
	 efxaHqebcDItg==
Date: Mon, 3 Nov 2025 16:13:33 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v9 08/12] NFSD: Simplify nfsd_iov_iter_aligned_bvec()
Message-ID: <aQka_Qgdwnv2mRTx@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103165351.10261-9-cel@kernel.org>

On Mon, Nov 03, 2025 at 11:53:47AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Pages in the RPC receive buffer are contiguous. Practically
> speaking, this means that, after the first bvec, the bv_offset
> field is always zero.
> 
> The loop in nfsd_iov_iter_aligned_bvec() also sets "skip" to zero
> after the first bvec is checked. Thus, for bvecs following the first
> one, bv_offset = 0 and skip = 0, and the check becomes:
> 
>   (0 + 0) & addr_mask = 0
> 
> This always passes regardless of the alignment mask.
> 
> Since all bvecs after the first one start at bv_offset zero (page-
> aligned), they are inherently aligned for DIO. Therefore, only the
> first bvec needs to be checked for DIO alignment.
> 
> Note that for RDMA transports, the incoming payload always starts on
> page alignment, since svcrdma sets up the RDMA Read sink buffers
> that way. For RDMA, this loop visits every bvec in each payload, and
> never finds an unaligned bvec.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Very welcome improvement!

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

