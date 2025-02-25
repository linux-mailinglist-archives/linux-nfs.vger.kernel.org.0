Return-Path: <linux-nfs+bounces-10340-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED4A4473D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 18:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50477171A25
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F17158520;
	Tue, 25 Feb 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeyHXwan"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E1156677
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502956; cv=none; b=pvTwjxGF5vYNX6kZM7o4B/uUvDqxSms6Ppm53UEdrWv8kZMAmM4/rgQZuPxVXCINAqJhx8txFYBH5LDyC0UCDYJfUJ0loqwaZ1G51kO61g9X6lNivMSjHV87V1bTXBLnV1dxqa3GUdci1ijCrXGoA6cU0oSvL+cf84+5V/aDzq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502956; c=relaxed/simple;
	bh=iV+Cx8bJ8bdFma4U9kZOHVp0eYMx9ZgmUxEj/sTdonY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmNCbararpsjMsFp5n3NXyMIADDA+gtOwGK5MTHYSAXRM1B7GrEzfalG7swb++TQyGlt4+xcTWi6l2lCO3YrVunYeg6wl7aaSHIER/FAKjYDuHMhfYPZvN4U1rInnj6qfGrM37getZPTqI23omeI7Xi1fozvNf3ReyogKfmEw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeyHXwan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC044C4CEDD;
	Tue, 25 Feb 2025 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740502955;
	bh=iV+Cx8bJ8bdFma4U9kZOHVp0eYMx9ZgmUxEj/sTdonY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BeyHXwan0QGQgMyCLwlgpkzsQ2Abg6MjWHDOsnacG+6Y7Z6NKHjMWhybJQ906/PL9
	 pbrOq0ykIjQMcgA71HObGkcEOXq7t0Pe18t7AlcLTauIjhlnMtO2Q9zKsLI3rQOsFb
	 JaO4/Sg8BbgsQXeb5An3Wj84VCDJJIxVWeWi257a60tt07e+Nby5Mn7Oslr2edJovz
	 Tjcuxdh4K3ymR6D0Dc0WS806S4TYsxql1Gsnh+47zlJy8qCbXYevfxM/BJxPZlyk8I
	 Vhb1rksFH9THB6EUiFUr9GUTEiYONgMi8Y/TDuRq5mgx3mN3m0DtGhrmrr1GewS4ak
	 ho814PAwoePCQ==
Date: Tue, 25 Feb 2025 12:02:34 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 for-akpm for-6.14-rcX] NFS: fix nfs_release_folio() to
 not deadlock via kcompactd writeback
Message-ID: <Z733qhxzJyoIN41J@kernel.org>
References: <20250225003301.25693-1-snitzer@kernel.org>
 <20250225022002.26141-1-snitzer@kernel.org>
 <20250224225306.fb08838ac74f42f1c621fd19@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224225306.fb08838ac74f42f1c621fd19@linux-foundation.org>

On Mon, Feb 24, 2025 at 10:53:06PM -0800, Andrew Morton wrote:
> On Mon, 24 Feb 2025 21:20:02 -0500 Mike Snitzer <snitzer@kernel.org> wrote:
> 
> > Add PF_KCOMPACTD flag and current_is_kcompactd() helper to check for
> > it so nfs_release_folio() can skip calling nfs_wb_folio() from
> > kcompactd.
> > 
> 
> --- a/mm/compaction.c~a
> +++ a/mm/compaction.c
> @@ -3182,7 +3182,7 @@ static int kcompactd(void *p)
>  	long default_timeout = msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC);
>  	long timeout = default_timeout;
>  
> -	tsk->flags |= PF_KCOMPACTD;
> +	current->flags |= PF_KCOMPACTD;
>  	set_freezable();
>  
>  	pgdat->kcompactd_max_order = 0;
> @@ -3239,7 +3239,7 @@ static int kcompactd(void *p)
>  			pgdat->proactive_compact_trigger = false;
>  	}
>  
> -	tsk->flags &= ~PF_KCOMPACTD;
> +	current->flags &= ~PF_KCOMPACTD;
>  
>  	return 0;
>  }
> 
> I am of course concerned about how well tested this was!

Understandable, the patch was created and tested against v6.12.16.
Sincere apologies, I didn't rebase before submitting.

I'll rebase, retest and then send v3 today.

Thanks,
Mike

