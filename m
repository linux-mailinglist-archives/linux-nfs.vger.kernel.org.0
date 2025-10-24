Return-Path: <linux-nfs+bounces-15619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A48C07A20
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 20:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23AC61C829FC
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 18:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E2B3375DD;
	Fri, 24 Oct 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt+1lCLO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4022DF6E3
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328883; cv=none; b=VQKn5pnDvjb1mGy43WqkHEXizPp3TMNhbNKD3GO3EcqQl8/PnGFHS/mUfsFzJMmiCSJSoQnvnv1BzMsDGO/YtQ6MqFndali0gUyTYs0oHEz3TcxFPSzO2tVPv6JOwygBQ787R913AY3IPydyuVpbTW5xk8uAUOTWTkpnLH/H+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328883; c=relaxed/simple;
	bh=duladpfOekkqRDA9ztX9ZlW/NqFaI3W2l6Lp2fWlzdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F25LdJPnASQyxerwHzfi6owKfajsxDHVuaH3H3TfY+4YchMBJtDgjo2Tk0klk5G/XU5i+Oq4RNdrOMunCikpQo6u4CCdZLXCQh3DkQraHuB4QZR6nXjt0qjz07MCpmtctuTo10YDpWto/d+rVXYsrdpT7NjO1kxHC+zgtKvvk4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt+1lCLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D2EC4CEF1;
	Fri, 24 Oct 2025 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761328883;
	bh=duladpfOekkqRDA9ztX9ZlW/NqFaI3W2l6Lp2fWlzdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nt+1lCLOy6+3ZjQJs9DsTlnsQldZhE7BW11toF0da6CaBDWzpGGvy2QK+6EdcEefp
	 a1B5/BDiuSzeGStXvfj6MHB72EyaUslnyn0Z61J8IVAxMXYRdL31VSu66EXhPly/Y8
	 MpQIHJcMJI/SFpK2X9LiJAxzCnBHjOjeT72sv7DzzCAGTDQEpbNEQbeXXx86ry+RRg
	 OJ5kdj+jZNWw7A2atazUaXmOnMer3QuP0icH3E6nv3f5T+zNPxJS4wi+0smaBOqXfu
	 hg7ZPJjtemLul6kxrQnmAHw2g2zZmRDBVVvYKWcSCJW+ORHtbcd8vxRt2I6uWtlwZ2
	 ERNlwJubTV9Gg==
Date: Fri, 24 Oct 2025 14:01:21 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 13/14] NFSD: Clean up direct write fall back error flow
Message-ID: <aPu-8W-8epzPy2ns@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-14-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024144306.35652-14-cel@kernel.org>

On Fri, Oct 24, 2025 at 10:43:05AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Clean up: Use the usual error flow form:
> 
> 	if (uncommon condition) {
> 		handle it;
> 		return;
> 	}
> 	do common thing;
> 
> in nfsd_direct_write(). Now there is a single place where the direct
> write path falls back to a single cached write.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Definitely cleaner, thanks.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

