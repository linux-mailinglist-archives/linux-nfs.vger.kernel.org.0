Return-Path: <linux-nfs+bounces-15996-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13342C30D42
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 12:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D928E4E1852
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 11:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396802E5429;
	Tue,  4 Nov 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vd5KkTyf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D02D77E2
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257166; cv=none; b=m+IMAx1++R741CmpQwSMbion63V3IM4IdGpMr09GOys0q1aD2KFfLJl3OVyLM6xKL4PPXyr1zG1sN57MwkZjMYTOu+0/Vb/HUNHdKcfI0CxjGfOHiTesTRmRPTFBFzT709i6nG4bd6og2/1e3LmLqojQo25NgoGNSDkaW6o4pzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257166; c=relaxed/simple;
	bh=EPEkfm1rXbdnDvYPbov/F+CfFWmRkQVsGDSUewjqVPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSNemHUUtfPnJmePLiQCLO2esGX1O4YqDYtS8S24L98Q9SH2vUZOjeGfu/EzZks5dussblRMvF3NKGj5oCbad0Ntb64lrMPGH+1B8bkcUfZL+7ILZOUubI0W6wrUfGZBxEEhiUNou8P2P9ZIzRKyNGYb0EGQ9U+HHffmXApxLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vd5KkTyf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nFRvERvwT7WcuSD5qP8XPg+H92JqGv3b4T17b7HhJHM=; b=vd5KkTyfsnQdvoPPcK/eMqXFlo
	G/LBBBeGMCmpH/FRZOqgEQWc8ItcQioVB1C0snBPXU84ivc+nPGsXY0Bu6uZ9bGN0iI9ax6RHsiKq
	PYhoBYeO0N/+rZXrVVkMfGGPKzs5nDK+ggIjh2TaEpl8NXuvX8zRImcqvp91t0RO5DFcvYUHCnt5d
	7w5Ww5CAmIHHKGITOVGRizkYxK/LlgfyA6p7mAsB7QeyXgdP+0utMdRzFXn4+NVdq9k+dDZo0Y0+c
	AZQySuiCIiKb5fRNDehhR1f3hc+gBD3ZR3hL+ZOgdGduyNmutttx/waFXJIobyDyvbjUjTaGZM9zu
	JKRGnExw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGFaZ-0000000Bjyg-3hwj;
	Tue, 04 Nov 2025 11:52:39 +0000
Date: Tue, 4 Nov 2025 03:52:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v9 05/12] NFSD: Remove alignment size checking
Message-ID: <aQnpB4mYMwW9IGM0@infradead.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-6-cel@kernel.org>
 <176220902556.1793333.10293656800242618512@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176220902556.1793333.10293656800242618512@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 04, 2025 at 09:30:25AM +1100, NeilBrown wrote:
> On Tue, 04 Nov 2025, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Noted that the NFS client's LOCALIO code still retains this check.
> 
> It might be good to capture here *why* the check is removed.
> Is it because alignments never exceed PAGE_SIZE, or because the code is
> quite capable of handling larger alignments
> (I haven't been following the conversation closely..)

I'm still trying to understand why it was added in the first place :)

But I'm also completely lost in the maze of fixup patches.


