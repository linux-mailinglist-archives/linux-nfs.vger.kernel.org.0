Return-Path: <linux-nfs+bounces-15966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F765C2E1F8
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 22:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6133BB778
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D31715530C;
	Mon,  3 Nov 2025 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcDYoS2G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787EC1DFF7
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204579; cv=none; b=dBVMR3BxmzcGZoxm4pe0jb9cYJJdFUEQz8Lv55lmiOv2S61losC56dSE02II2BzEi6yqKCNqeokqQu6JnhNlko5IGr2u+Kb07YIyWJrqsNVw8qMoFN9am/Z1JCzC/5kqFwoykXpblNy0VpNG4Iz6NgHzyiV86Gcg77SunuRTkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204579; c=relaxed/simple;
	bh=Y+o/+c+Ib42NSfqZHPCGY6QKJJlli3YTjIaOHWhFEiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkodmeK4NLizaA9EUSZTPOcfkfH2ChreRTcrAd4pmrGp3WEmd5xMonbg81n0hav4wronKDs6wYjaFwqgs9CKHg+xxUKooDwv4toMU4L8rBxA5aXOAl6iVoy3QMLh87joHUS0ghX2Uc/9RNB7NYpLDb5/I6Wqk1w9Uch234MXO0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcDYoS2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA9AC4CEE7;
	Mon,  3 Nov 2025 21:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762204579;
	bh=Y+o/+c+Ib42NSfqZHPCGY6QKJJlli3YTjIaOHWhFEiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcDYoS2GKBkW11lYu4Ec/ny9jhQhDM4puShgysG7BHdUTFZ+JI6QBPSDgwmLqhW04
	 85XDCUff/JA6srjoQnNjNQ7BiegIG5WKTrm4dbOgXmsF8ySJijPQZbwRxibyiyDYTj
	 g5TXYUoCWvu8US8jZnpVENVcvotuYiP13JjxME9Jfym92m9nsqw/Muyb97dZaf63z7
	 7a1mK2+mNAKpu/9QWa3QTq3RzAQwd4uDI9SBAx5zc+NSlR2y7C73lcnOgdWqLV3ycg
	 3eCvEd3dLWnowAfunlsSBfV+rlwtFdtz03JHA8u/4EM0D3HjTjM/a2Fm7fxYvPEx1k
	 aj6kEIFzmRZLA==
Date: Mon, 3 Nov 2025 16:16:17 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 05/12] NFSD: Remove alignment size checking
Message-ID: <aQkboW8o53o4Ff9p@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103165351.10261-6-cel@kernel.org>

On Mon, Nov 03, 2025 at 11:53:44AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Noted that the NFS client's LOCALIO code still retains this check.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

