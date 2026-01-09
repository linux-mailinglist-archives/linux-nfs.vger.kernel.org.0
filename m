Return-Path: <linux-nfs+bounces-17686-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5B9D085C5
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 10:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 092AC300941D
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 09:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A764332EA5;
	Fri,  9 Jan 2026 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UIheB3C+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1069B330B0E;
	Fri,  9 Jan 2026 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952534; cv=none; b=SGGycxzeSKycpVQtZDdnPID9OL0zCdcAL6ZE6LnQLaMFHKrgEsBbfgM/US+L9k8Nd5nrxLt3ntMTXnwAsx92z+oo5ZSL0Sw9Sv0Qmi6GyZ9cBZPLJPHMCeXED/kjsARtYCUE65+OQCM0h+E0d5R6Ga6VqKD5vHseDmPEMELe40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952534; c=relaxed/simple;
	bh=j5axSlwHet7l1SGYJ4MCQ3nwMWXjXkvA11ZCaTJdiIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soGXRnCsLDAL1zBT9cnidFAv45UhQ/T+zJwXSAv70lCVdaIUZRduEloNX+18+4L6e9yIGTdMj+Wgn2unCcqK20z6ZRX2IYVSI4dqGGZei9BtOSeYG5pp23fA+K9t52Pu/rQD71j4FgX7N/aBwaRKBj132/RV1/TnFnk8pjz02jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UIheB3C+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635AEC4CEF1;
	Fri,  9 Jan 2026 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767952533;
	bh=j5axSlwHet7l1SGYJ4MCQ3nwMWXjXkvA11ZCaTJdiIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UIheB3C+njgPnw+CYupC2VyTmym9XJDWy2176O4VigfDPebfpqBczN/KsGZrOnbhW
	 lnAtSf/d03qCC04hWlL6a0A4L5dpt0oYNyoJ+sAUCmc6tSe4ciAd69wl2Mjpkdm/97
	 +6yrBeSf4ODqcKWfKj8rnpCC+J6k404bmSasG4Wc=
Date: Fri, 9 Jan 2026 10:55:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <cel@kernel.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6.6.y v2 1/4] nfsd: convert to new timestamp accessors
Message-ID: <2026010958-defiance-equate-955f@gregkh>
References: <2025122941-civic-revered-b250@gregkh>
 <20260108191002.4071603-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108191002.4071603-2-cel@kernel.org>

On Thu, Jan 08, 2026 at 02:09:59PM -0500, Chuck Lever wrote:
> From: Jeff Layton <jlayton@kernel.org>
> 
> [ Upstream commit 11fec9b9fb04fd1b3330a3b91ab9dcfa81ad5ad3 ]
> 
> Convert to using the new inode timestamp accessor functions.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Link: https://lore.kernel.org/r/20231004185347.80880-50-jlayton@kernel.org
> Stable-dep-of: 24d92de9186e ("nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()")
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/blocklayout.c | 4 +++-
>  fs/nfsd/nfs3proc.c    | 4 ++--
>  fs/nfsd/nfs4proc.c    | 8 ++++----
>  fs/nfsd/nfsctl.c      | 2 +-
>  fs/nfsd/vfs.c         | 2 +-
>  5 files changed, 11 insertions(+), 9 deletions(-)

Adds a build warning, which breaks the build:

fs/nfsd/blocklayout.c: In function ‘nfsd4_block_commit_blocks’:
fs/nfsd/blocklayout.c:123:16: error: unused variable ‘new_size’ [-Werror=unused-variable]
  123 |         loff_t new_size = lcp->lc_last_wr + 1;
      |                ^~~~~~~~
cc1: all warnings being treated as errors

try a 3rd version?

thanks,

greg k-h

