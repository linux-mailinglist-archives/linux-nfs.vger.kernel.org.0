Return-Path: <linux-nfs+bounces-14821-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96787BAE34A
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 19:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A527A843C
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAF630CB50;
	Tue, 30 Sep 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHgovN5T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795BC30CB37
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253720; cv=none; b=AxzRB9Jo+auHYI57BduMMYj3uNUapPYgqb9OY13Hu8E1nXF7B3IspuD9hHxNmO+rfHrEenOXeOOMb3YFTMPfCz42S6zIOQ4Ri/Q0+s2IPoz18GFrOoZF7G382ohaB0IV40t+HMGkPO6v7wieNkmo0K0SEs1UKSlUD0Wiyu4PyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253720; c=relaxed/simple;
	bh=3ztszwEiCN5HrHXfvBOub7eQQ50Vg7YefRgvVkL4l+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSKx0NUUVS5ZnCtDgpxNzXKG5Pue/U+KQJ+DVIbLVJbmOKXuDJN2DoGTbPgKfx1pW/HHBrfFvXKAW1QrgPmhvkWFZi3eHb1sKVP63Ody6TWPnA5TU33VKa9p0PFhiHQMdiUraPsY2LIEaq3nVlsz3RBejyiuv/TnjxWT9QsYcQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHgovN5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D929C116B1;
	Tue, 30 Sep 2025 17:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759253720;
	bh=3ztszwEiCN5HrHXfvBOub7eQQ50Vg7YefRgvVkL4l+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHgovN5TpZIbyyU5xKQlkKgv8VWcw3CYLRbsmDC6X84AVpNE2m1KNucBZKQ1RNTRj
	 Z1L5JiFgyK9LDlzVfpBXU47xEZtMRX1dRVbkRkuZid0PxfaJW83jQcu1GzBg2fW/UB
	 Urwmyj4jxBh9qlErRl7GXHdvgYcDxLCWg1yUqX7JIQ9DQ5RqbdhJhGX/NC8ttyJmum
	 f8TGJvgOmPUqbkqCf0X7hy1XYIOR8QF7VXCQBRoG1FP5E0G/IvNXKEfIkxcxTebbW0
	 1CwxzVyXP7l94hLO+VL7+r8GJsP/U89C8aa416WDaoUN5xYcaEzd83wu/kyNBEc3hr
	 6KJBG7M2G6aYw==
Date: Tue, 30 Sep 2025 13:35:19 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>
Subject: Re: [GIT PULL] NFS LOCALIO O_DIRECT changes for Linux 6.18
Message-ID: <aNwU16Yi4V_ztHY2@kernel.org>
References: <20250915154115.19579-1-snitzer@kernel.org>
 <aMiMpYAcHV8bYU4W@kernel.org>
 <aNLfroQ8Ti1Vh5wh@kernel.org>
 <aNQqUprZ3DuJhMe4@kernel.org>
 <aNgSOM9EzMS_Q6bR@kernel.org>
 <aNwEo7wOMrwcmq9b@kernel.org>
 <178769c5-e29d-48d6-91df-4bb45c48aae1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178769c5-e29d-48d6-91df-4bb45c48aae1@oracle.com>

On Tue, Sep 30, 2025 at 01:15:06PM -0400, Chuck Lever wrote:
> On 9/30/25 12:26 PM, Mike Snitzer wrote:
> > Hi Anna,
> > 
> > Given that my NFS LOCALIO O_DIRECT changes depend on NFSD changes
> > which will be included in the NFSD pull request for 6.18, I figured it
> > worth proposing a post-NFSD-merge pull request for your consideration
> > as the best way forward logistically (to ensure linux-next coverage,
> > you could pull this in _before_ Chuck sends his pull to Linus).
> > 
> > If you were to pull this into your NFS tree it'd bring with it Chuck's
> > nfsd-next (commit db155b7c7c85b5 as of now) followed by my dependant
> > NFS LOCALIO O_DIRECT changes.
> > 
> > You'll note that I folded 3 commits from Chuck's current nfsd-testing
> > branch into a single "NFSD: filecache: add STATX_DIOALIGN and
> > STATX_DIO_READ_ALIGN support", the commits from cel/nfsd-testing are:
> > 
> >  9cc8512712b11 NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
> >  e5107ff95c56d NFSD: Prevent a NULL pointer dereference in fh_getattr()
> >  ed7edd1976c04 NFSD: Ignore vfs_getattr() failure in nfsd_file_get_dio_attrs()
> I strongly prefer that the second and third patch above be permitted to
> soak in nfsd-testing before being merged. These two modify very hot code
> paths in NFSD, and therefore deserve proper test experience.
> 
> Please don't push NFSD patches through other trees without at least an
> Acked-by from the NFSD maintainers. The first patch has been acked, as
> you requested, and is ready to be applied to the NFS client tree. That
> Ack does not apply to the second and third patches above.

Please explain why you're in favor of NFS picking up an NFSD commit
with known Fixes?

And why didn't you fold your fixes into the original to begin with?

(This is just useful info to know, I fully expect my pull to be moot,
been trying to communicate with Anna for nearly 2 weeks but haven't
heard back).

