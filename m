Return-Path: <linux-nfs+bounces-17453-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE89CF5061
	for <lists+linux-nfs@lfdr.de>; Mon, 05 Jan 2026 18:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFC95301EFDE
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D33932E729;
	Mon,  5 Jan 2026 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFYLqccG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829F33ADA1
	for <linux-nfs@vger.kernel.org>; Mon,  5 Jan 2026 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634822; cv=none; b=t3PDK0LQK4phRF8vchRLaHieqiJaSkjWHBTX1sbFC7ekfjO3uKzJKVzu4HyQlDxvBm2SEIYxx0cx3AE+zQL/pDYQryVVA9TECCi4OnifpV6zDg1YMITwJM/80hhyGG/6K437ayMlFgSRbUMcg8h6USpy7doe2NdyU+zzRh+ZyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634822; c=relaxed/simple;
	bh=up27p87HTaJ2OylM6AgvVi0VRxqlxC6O8wd6sQaSOaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZiRKpYNQQqliOVKjctLuT7cLTjTiMFs4lX7VroVQGkudBoI+RaBRaPyykB8KlaQE5/lug19ygMrqODEbeak5aOC3rRPcPxK7ITioW8hBtKHU766srcXnoYUhMM9P+V6Ekz0sk7VrBiJgq2JrttkR3PUgH7jQHIxIFUjJnGZOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFYLqccG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FD7C19421;
	Mon,  5 Jan 2026 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767634821;
	bh=up27p87HTaJ2OylM6AgvVi0VRxqlxC6O8wd6sQaSOaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uFYLqccGchcceD0+Ej9WU/uhy6Qh5vNu+0FvE5NTuAwCz156hFhUrRiY8lQhkJs/M
	 lbmTYF9ET7yKD05z34RlzTk74nsq9zeI0EOmDasPLudQ6VBVAty07WE+XiTuBIIa2Y
	 44F6jZDe72oLfcAIUXgFQzjAzR2ogLvqA/tzsFHKG9oILQ3ERYjpzAfF3rqCNw6ZeK
	 ahuqH5E4SJxduT3wsRk1Bk2kvRBQbT/c1cF6EMaIeVKfomrEBgKCbBx3x9JiHFSrZv
	 aagOeJxJmcjyVN6TIFscipXXyVSjLzbaAxTs1BSfq37BfZ68Wik1Tj72/3zRHP43WK
	 wLFck49vsgC2A==
Date: Mon, 5 Jan 2026 12:40:20 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/4] NFS/localio: Deal with page bases that are >
 PAGE_SIZE
Message-ID: <aVv3hHmeRmChS6NR@kernel.org>
References: <cover.1767459435.git.trond.myklebust@hammerspace.com>
 <f7d976f25972708d6b79b48d411e6b3273354c00.1767459435.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7d976f25972708d6b79b48d411e6b3273354c00.1767459435.git.trond.myklebust@hammerspace.com>

On Sat, Jan 03, 2026 at 12:14:58PM -0500, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> When resending requests, etc, the page base can quickly grow larger than
> the page size.
> 
> Fixes: 091bdcfcece0 ("nfs/localio: refactor iocb and iov_iter_bvec initialization")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

This was bound to happen given the "No functional change." in the
header for commit 091bdcfcece0 -- wasn't purely a refactor, ugh.

Should the implications of not having this fix be made clearer in this
patch header?

In any case, very nice catch:

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

