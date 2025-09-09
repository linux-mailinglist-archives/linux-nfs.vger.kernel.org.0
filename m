Return-Path: <linux-nfs+bounces-14152-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE7EB50911
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 01:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC374E6B76
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 23:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F632853F1;
	Tue,  9 Sep 2025 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdPNAeOV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73431D382
	for <linux-nfs@vger.kernel.org>; Tue,  9 Sep 2025 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757459771; cv=none; b=PetLDi3qHk8/Zduj2LihbwIR3Wx/wr4FFyu2svCbljRvv0krhEaBsLg6WR0HqFKuoXW8n8Uo8L8vY2julEWrlXejBBed0yZlP1pPnK8UfHpDlpL+d3s46BuI/roxYa6MX+q5uWv4W339Zmtn0+C/VHeuQOJhPBxCsddmuFFmOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757459771; c=relaxed/simple;
	bh=mRU4RLXb5GrBKGFvQqoEJZKDqYDPigNl711BohSTGtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtnTvj2TThmwqhKRxvzCEm9gnEU0tq8SfEs204XTV2PkaHaTzorTfQpWoFLzj5Af+4saQRM178SAqgQgBdbRBY8AH8MaT8svQQ1XSaiKFFcMHVJ2wmJfWcvX65EKtwWLc/Qz/wavgS5w1K1qaq0f37RCHCssfPROF8E5Ye51VQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdPNAeOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCDAC4CEF4;
	Tue,  9 Sep 2025 23:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757459770;
	bh=mRU4RLXb5GrBKGFvQqoEJZKDqYDPigNl711BohSTGtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdPNAeOVa8JlPkCoLZa+4i2gJ1UhXGhGyoUrWZN7Qh1Y8jiEU/FhdqcrC+zopciWz
	 aiX/9I9YzLxFvyBcNw/HPA4BL+FL04DlYTeVLV7F+/QcNYQlitql1JD5pFgXMP6QBv
	 I7RlT/XdXOymNm6Tn0yfMtW0imOf3LYaNq8TfdusVrqhYU3PyVy8AhmCCO4QXZgFii
	 /ud3RdbPSk61sUXZJMNYbo3RlgfKYkRR6h/igSXhfuucq44julYrXiqWfPVs80yPDe
	 9bUKFrFl/ve9x5AU4DMvLYiMmDeX/8LpTbS0+lMBc59c5FG+z/wYy/tvdMYwZcVw4e
	 BbdGJstvtqlsQ==
Date: Tue, 9 Sep 2025 19:16:09 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
Message-ID: <aMC1OcH3E01w6LWD@kernel.org>
References: <20250909190525.7214-1-cel@kernel.org>
 <20250909190525.7214-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909190525.7214-4-cel@kernel.org>

On Tue, Sep 09, 2025 at 03:05:25PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Add an experimental option that forces NFS READ operations to use
> direct I/O instead of reading through the NFS server's page cache.
> 
> There are already other layers of caching:
>  - The page cache on NFS clients
>  - The block device underlying the exported file system
> 
> The server's page cache, in many cases, is unlikely to provide
> additional benefit. Some benchmarks have demonstrated that the
> server's page cache is actively detrimental for workloads whose
> working set is larger than the server's available physical memory.
> 
> For instance, on small NFS servers, cached NFS file content can
> squeeze out local memory consumers. For large sequential workloads,
> an enormous amount of data flows into and out of the page cache
> and is consumed by NFS clients exactly once -- caching that data
> is expensive to do and totally valueless.
> 
> For now this is a hidden option that can be enabled on test
> systems for benchmarking. In the longer term, this option might
> be enabled persistently or per-export. When the exported file
> system does not support direct I/O, NFSD falls back to using
> either DONTCACHE or buffered I/O to fulfill NFS READ requests.
> 
> Suggested-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

