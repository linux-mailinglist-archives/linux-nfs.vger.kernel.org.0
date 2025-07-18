Return-Path: <linux-nfs+bounces-13142-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E504B099D5
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 04:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E723AD7AF
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 02:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196BE1A2C27;
	Fri, 18 Jul 2025 02:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ+viVfn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C23597A
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 02:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752806229; cv=none; b=c7l3azP6w93FiCVQMPvtg/IajiQbBVSdxwR7LnUDk10kg0y47S4UeUuKRBp+LVG4vX+p8QF9zS430i9U1qf7bwARKq0Ea3bvyXsHSWPXXAsq3A8G8200MiAFjyLL4eHq4TXbXYgY7DxylvvCHVKBqZEWxolQhNHA3U0tpBVUwHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752806229; c=relaxed/simple;
	bh=Xej9xmBSbEMu9DWBtPBUaVGjGp5LF1O5wkrVBzrBssc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSmXTwNBu0uJRKDEh+Az2OgfAWSCAym4zIF81ghVklLW96QdiZfu6uCox54sZuQyEJmMhtzLASAShK2LWQYUBTqcVI/9hRIqu7NGxGRm2OCj5W4EouQggT9pGUp2tU1C+ju1uLTvqfW0fKI98pDuBjubMOe+qT8xqP1KVYoOEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ+viVfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42943C4CEE3;
	Fri, 18 Jul 2025 02:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752806228;
	bh=Xej9xmBSbEMu9DWBtPBUaVGjGp5LF1O5wkrVBzrBssc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZ+viVfnu+IqeHlqEf6MmmXqa7z/qDAlOdscOtnErBMUu99QW9w9cXH23OYFpuvve
	 6aszO4gzx+0s4Y53vnR0nqduRWNiFM7kcLrtDxIx/kJ0Swv4OdgTS7oQ1ksCs4K9qs
	 fjilSw4QKaJex86CGPGHojbyCtLK9XKHKBC7iAOeGN0/vCT1xcX51kPRSCp2XGyT7O
	 C7acUeSkz7jUqewJ+ulAKkPuseq+p1vGYMaTAQnDJWbIt1aUsU0bcga7I7sww6GEXP
	 2zMI8ddfGfJ+lvsdrnKWFL8es77kPOCEU5q7EWWqO0kdAgRwFOy/TU5wXKELYBvfo/
	 QvDFhHEdikQCQ==
Date: Thu, 17 Jul 2025 22:37:07 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: avoid ref leak in nfsd_open_local_fh()
Message-ID: <aHmzU6vqIg-y82oy@kernel.org>
References: <20250718012831.2187613-1-neil@brown.name>
 <20250718012831.2187613-2-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718012831.2187613-2-neil@brown.name>

On Fri, Jul 18, 2025 at 11:26:14AM +1000, NeilBrown wrote:
> If two calls to nfsd_open_local_fh() race and both successfully call
> nfsd_file_acquire_local(), they will both get an extra reference to the
> net to accompany the file reference stored in *pnf.
> 
> One of them will fail to store (using xchg()) the file reference in
> *pnf and will drop that reference but WONT drop the accompanying
> reference to the net.  This leak means that when the nfs server is shut
> down it will hang in nfsd_shutdown_net() waiting for
> &nn->nfsd_net_free_done.
> 
> This patch adds the missing nfsd_net_put().
> 
> Reported-by: Mike Snitzer <snitzer@kernel.org>
> Fixes: e6f7e1487ab5 ("nfs_localio: simplify interface to nfsd for getting nfsd_file")
> Signed-off-by: NeilBrown <neil@brown.name>

Tested-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>

Looks really solid now, thanks!

Mike

