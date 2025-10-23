Return-Path: <linux-nfs+bounces-15562-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1645BBFF5E0
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 08:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA2814E31F8
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 06:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2601F3D56;
	Thu, 23 Oct 2025 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CEcmkq3q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1866279784
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201528; cv=none; b=N/d140Kx1RLB9w06CQs+oGoWGRAZg6VyvPP8wuTh5cKqownhkwRy+VOsfzEiDRkC7dqeaqSo45OdS7mOC3uHJgQKfOSOjmFSlqQEYH9AqINjR34KGlxXjctjekoNT2C1+dm/FagZf+sRHKE3ooSjAqfwz5/OJaFW2MqUly0S3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201528; c=relaxed/simple;
	bh=b/ak0B6mC9ZY+AIS9/Xq491lBKV3hqYJCoSk0Wv5OAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO8yJ3cGNZKEkyAh56ybtb93q2FZ2jZqvtpC1hBOkAsNIviuekmtJPcFGrQnKjtePBhg2wXOJFG/9ZKISXShrJ4cLEOlWQvAZKQTDTVxJaHu1/AGOfRU9b9S+uK/iuybOQspiGbl3Cjvccfa/gRdzO7LP+R5m6GvDC2ZWLcNi4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CEcmkq3q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7ru3QJZKWszzI8a9yr2ZDgcPPwkvJNLr7qqdl8RwUMo=; b=CEcmkq3qvktebGs8hf/2H7tSi8
	9PQ1ai/7WSSmropycErd6enOpAoKnx/SQo63aeDp2WuDxs9Z7GB/Upg7NTKK0K8ON/qT15mcB0O6o
	pfzfPOBRhAb1MgASpuZL+zV4V+jl89LxwkbXdkCHNlEPnRytRETLEtn+tvP7RL8MxLq0rEphoa/d1
	uGEveg++FItKNo8tM9LnXGvnfwBu34++OsngQ6QtwnTF+oxAV2oUb581Qh36K981SRuCymkJFePU4
	jDjeexvfc6AFnALHJRVlPsOztP9TKUqtag45mqwkTR/XKgyf7Ftjx1/R8g0FVcTwnXuwDjUwopcWJ
	3Ox4geDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBoyC-00000005ETl-2JfB;
	Thu, 23 Oct 2025 06:38:44 +0000
Date: Wed, 22 Oct 2025 23:38:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [RFC PATCH] NFSD: Make FILE_SYNC WRITEs comply with spec
Message-ID: <aPnNdLg-tSIH0r5E@infradead.org>
References: <20251022162237.26727-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022162237.26727-1-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 22, 2025 at 12:22:37PM -0400, Chuck Lever wrote:
> -		kiocb.ki_flags |= IOCB_DSYNC;
> +		kiocb.ki_flags |=
> +			(stable == NFS_FILE_SYNC ? IOCB_SYNC : IOCB_DSYNC);

IOCB_SYNC without IOCB_DSYNC is always wrong, see my reply to the
previous thread.


