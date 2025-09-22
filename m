Return-Path: <linux-nfs+bounces-14621-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB04BB933DD
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 22:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9257A7A84DD
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 20:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105C825F975;
	Mon, 22 Sep 2025 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz9sxOtF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDB25F7A5
	for <linux-nfs@vger.kernel.org>; Mon, 22 Sep 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573260; cv=none; b=qXaUklpv+abe6JsjeAUqhKTVuZs+sX3Et0Fy1EVEvkUorEB0WkI2YxQi3nS7eTYrR5BGTa6QUBqfe5Rx19YGsKIgoiUfp8qQyYooCXErL4lONPp9m88UerR8wkqw1DYh4VFyhkbjk1H7CwoZbDUsD+iCknc+rIFpUpXQLvPJ1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573260; c=relaxed/simple;
	bh=VdgYDkWF9ZTTQ3v5i1Vu72+WHiBaB7IsFtCSx35WV5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR6D8G3n6x/zOEmixF0rdOwOwZPgw5y/PV7BHGzpIJfihp8aM3yIiUFEhlKpNlXerST/+DPdRKPA+sqABWc37kVEmQIk01TYI53lhlRZBeXxmz1uHav19ScJyolMPlBK3rUO7GiFCPSIWIigtEv4wxxpuuES8kvfd2Dr+npmn40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz9sxOtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E559C4CEF0;
	Mon, 22 Sep 2025 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758573259;
	bh=VdgYDkWF9ZTTQ3v5i1Vu72+WHiBaB7IsFtCSx35WV5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dz9sxOtF8i7gVufqOrDa8ohwLXb3hcFEYNgVevNqmpO4ZSa6mcbfHPki9CP5FFJSx
	 jkBGdsZrpvEQJORiR5X2Z1sKLHPom2+0yxfGlsQb1gOJ4DJFSHM2ssDuDzkxMd4EvD
	 Sul4DQcFxa8yIM6YEgqg37KZGAN8G1gx5ThFyhQpjDH+XR2d9EBYiIrbpPC+ZQhm1B
	 yRXmLF5tZw9Uto5Pr9dkfewxPMWNn+yeDkypTUyQBuxEJRwcqVEKUq4+GEi/S/WJEO
	 sfxe5a7zOr7ufIXT3mpDtgH8gMXoVugj+kjpSLUrY6PxglPXVy+Rl4YJlkRvtHAhtZ
	 XHwUa5qHPbmcw==
Date: Mon, 22 Sep 2025 13:34:15 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jonathan Curley <jcurley@purestorage.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH v3 6/9] NFSv4/flexfiles: Commit path updates for
 striped layouts
Message-ID: <20250922203415.GA2873812@ax162>
References: <20250918133310.508943-1-jcurley@purestorage.com>
 <20250918133310.508943-7-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918133310.508943-7-jcurley@purestorage.com>

Hi Jonathan,

On Thu, Sep 18, 2025 at 01:33:07PM +0000, Jonathan Curley wrote:
...
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
> index 79700c18762c..b061e7a576cf 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -605,6 +605,26 @@ ff_layout_free_lseg(struct pnfs_layout_segment *lseg)
>  	_ff_layout_free_lseg(fls);
>  }
>  
> +static u32 calc_mirror_idx_from_commit(struct pnfs_layout_segment *lseg,
> +				       u32 commit_index)
> +{
> +	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(lseg);
> +	u64 mirror_idx = commit_index;
> +
> +	do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
> +
> +	return mirror_idx;
> +}
> +
> +static u32 calc_dss_id_from_commit(struct pnfs_layout_segment *lseg,
> +				   u32 commit_index)
> +{
> +	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(lseg);
> +	u64 mirror_idx = commit_index;
> +
> +	return do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
> +}
> +

This change is in -next as commit 67ee714244df ("NFSv4/flexfiles: Commit
path updates for striped layouts"), where it causes warnings for 32-bit
platforms:

  In file included from arch/arm/include/asm/div64.h:114,
                   from include/linux/math.h:6,
                   from include/linux/kernel.h:27,
                   from include/linux/uio.h:8,
                   from include/linux/socket.h:8,
                   from include/uapi/linux/in.h:25,
                   from include/linux/in.h:19,
                   from include/linux/nfs_fs.h:22,
                   from fs/nfs/flexfilelayout/flexfilelayout.c:10:
  fs/nfs/flexfilelayout/flexfilelayout.c: In function 'calc_mirror_idx_from_commit':
  include/asm-generic/div64.h:183:35: error: comparison of distinct pointer types lacks a cast [-Werror=compare-distinct-pointer-types]
    183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
        |                                   ^~
  fs/nfs/flexfilelayout/flexfilelayout.c:685:9: note: in expansion of macro 'do_div'
    685 |         do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
        |         ^~~~~~
  In file included from include/linux/array_size.h:5,
                   from include/linux/kernel.h:16:
  include/asm-generic/div64.h:195:32: error: right shift count >= width of type [-Werror=shift-count-overflow]
    195 |         } else if (likely(((n) >> 32) == 0)) {          \
        |                                ^~
  include/linux/compiler.h:76:45: note: in definition of macro 'likely'
     76 | # define likely(x)      __builtin_expect(!!(x), 1)
        |                                             ^
  fs/nfs/flexfilelayout/flexfilelayout.c:685:9: note: in expansion of macro 'do_div'
    685 |         do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
        |         ^~~~~~
  include/asm-generic/div64.h:199:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Wincompatible-pointer-types]
    199 |                 __rem = __div64_32(&(n), __base);       \
        |                                    ^~~~
        |                                    |
        |                                    u32 * {aka unsigned int *}
  fs/nfs/flexfilelayout/flexfilelayout.c:685:9: note: in expansion of macro 'do_div'
    685 |         do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
        |         ^~~~~~
  arch/arm/include/asm/div64.h:24:45: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'u32 *' {aka 'unsigned int *'}
     24 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
        |                                   ~~~~~~~~~~^
  fs/nfs/flexfilelayout/flexfilelayout.c: In function 'calc_dss_id_from_commit':
  include/asm-generic/div64.h:183:35: error: comparison of distinct pointer types lacks a cast [-Werror=compare-distinct-pointer-types]
    183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
        |                                   ^~
  fs/nfs/flexfilelayout/flexfilelayout.c:696:16: note: in expansion of macro 'do_div'
    696 |         return do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
        |                ^~~~~~
  include/asm-generic/div64.h:195:32: error: right shift count >= width of type [-Werror=shift-count-overflow]
    195 |         } else if (likely(((n) >> 32) == 0)) {          \
        |                                ^~
  include/linux/compiler.h:76:45: note: in definition of macro 'likely'
     76 | # define likely(x)      __builtin_expect(!!(x), 1)
        |                                             ^
  fs/nfs/flexfilelayout/flexfilelayout.c:696:16: note: in expansion of macro 'do_div'
    696 |         return do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
        |                ^~~~~~
  include/asm-generic/div64.h:199:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Wincompatible-pointer-types]
    199 |                 __rem = __div64_32(&(n), __base);       \
        |                                    ^~~~
        |                                    |
        |                                    u32 * {aka unsigned int *}
  fs/nfs/flexfilelayout/flexfilelayout.c:696:16: note: in expansion of macro 'do_div'
    696 |         return do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
        |                ^~~~~~
  arch/arm/include/asm/div64.h:24:45: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'u32 *' {aka 'unsigned int *'}
     24 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
        |                                   ~~~~~~~~~~^
  cc1: all warnings being treated as errors

do_div() should only be called with a 64-bit dividend. I don't see why
this needs a division helper because mirror_idx and ->dss_count are both
u32?

It seems like the following diff would be sufficient to resolve this if
I am understanding correctly but I am not familiar with this code. Could
even eliminate *flseg as well, it would fit within 80 characters.

Cheers,
Nathan

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 0eca9367b610..c726309bfbe1 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -680,20 +680,16 @@ static u32 calc_mirror_idx_from_commit(struct pnfs_layout_segment *lseg,
 				       u32 commit_index)
 {
 	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(lseg);
-	u32 mirror_idx = commit_index;
 
-	do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
-
-	return mirror_idx;
+	return commit_index / flseg->mirror_array[0]->dss_count;
 }
 
 static u32 calc_dss_id_from_commit(struct pnfs_layout_segment *lseg,
 				   u32 commit_index)
 {
 	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(lseg);
-	u32 mirror_idx = commit_index;
 
-	return do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
+	return commit_index % flseg->mirror_array[0]->dss_count;
 }
 
 static void

