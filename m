Return-Path: <linux-nfs+bounces-13267-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF74B13055
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Jul 2025 18:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B233B0D61
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Jul 2025 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BF41DDA18;
	Sun, 27 Jul 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wym+EMtI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A70618C008
	for <linux-nfs@vger.kernel.org>; Sun, 27 Jul 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753632968; cv=none; b=M9o+XcPA9JZXi5FLNT4NMTJh5gmudhdbZq65jxy4eqGlzD1LiircYYuCzkGAadcEp/FhadGUMZhoZNy4b4wAGFtBT9DFCMLoVmeJYgroLsglHjyF++PB/G7uLqZs0v/1kiK6qh1tpGMGek8ptFOrVXxZ4NvIm7PBDo31Rvm7xK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753632968; c=relaxed/simple;
	bh=DBFmMkhAyj2OPn2bdgpDsHU0UEdb0DIUIywYHLc0NT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5tpOShz2TbtgZHo3Y8swR+MZ0RLuitDG91pP2TmnxRs5RJi/xicQQwL34x+9E3mLEgr7g5nu2LsV10cWnGOjewiGgLHKPbRrnygO6DwvX9RN08qcs+o7r/o6NvizYVO4STd+kK91IYKhVVXX3YncVoX1TyhB5l/5JaF1gsHfg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wym+EMtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF7CC4CEEB;
	Sun, 27 Jul 2025 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753632968;
	bh=DBFmMkhAyj2OPn2bdgpDsHU0UEdb0DIUIywYHLc0NT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wym+EMtIXnDe3v5oYzMt2nGbEUjYqKFvz3c3QhDSE85/AxynzMTmsDtHB485KyZWU
	 K4fL4orxWTP0vI3lxhTXuZjPjc5Y6cVHazZfF3bwKTN7N+TGUohhpHBpFV/axlwS0L
	 esHuVNoq32cF86qy3ZqfcJaLV9no2Lf8sNwOHKJkFAbF5RzborC7gcEhOlbKuvkQrq
	 9FgI7Y7gVsm3Kxu/A+Mh/VMx10VkV9RdG45hdcsqg9CHOu4aNkiCljd9Hykv5JKLU2
	 lif0DenaXRNLPyZ298OLDRZknoT7W73XsSZP2WXsQCwToiRTALwC4HnHWNfn7YE9vB
	 JmHNfBGUmLdQQ==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: (subset) [PATCH v5 00/13] NFSD DIRECT and NFS DIRECT
Date: Sun, 27 Jul 2025 12:16:04 -0400
Message-ID: <175363294101.59631.4885658207387773358.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724193102.65111-1-snitzer@kernel.org>
References: <20250724193102.65111-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 24 Jul 2025 15:30:49 -0400, Mike Snitzer wrote:
> Some workloads benefit from NFSD avoiding the page cache, particularly
> those with a working set that is significantly larger than available
> system memory.  This patchset introduces _optional_ support to
> configure the use of O_DIRECT or DONTCACHE for NFSD's READ and WRITE
> support.  The NFSD default to use page cache is left unchanged.
> 
> The performance win associated with using NFSD DIRECT was previously
> summarized here:
> https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
> This picture offers a nice summary of performance gains:
> https://original.art/NFSD_direct_vs_buffered_IO.jpg
> 
> [...]

Applied to nfsd-testing, thanks!

[01/13] NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
        commit: af157e09634a113da83d8ac5fff541f9e06ad653
[02/13] NFSD: pass nfsd_file to nfsd_iter_read()
        commit: 63a534c8b18642dc27318e08b77952c4d7f55628
[03/13] NFSD: add io_cache_read controls to debugfs interface
        commit: f76b72e4908c556021d94bdeca86fffce430c791
[04/13] NFSD: add io_cache_write controls to debugfs interface
        commit: a45da44bb6bade1dfef569c792ae2ee6507f4724
[05/13] NFSD: filecache: only get DIO alignment attrs if NFSD_IO_DIRECT enabled
        commit: af157e09634a113da83d8ac5fff541f9e06ad653
[06/13] NFSD: issue READs using O_DIRECT even if IO is misaligned
        commit: 6d80efb3cb6f9817bedfa460e9ddf56a916caf2f

--
Chuck Lever


