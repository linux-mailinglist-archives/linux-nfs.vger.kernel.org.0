Return-Path: <linux-nfs+bounces-7939-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBB49C7986
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 18:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 434A8B24CDF
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 16:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2502309AC;
	Wed, 13 Nov 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRvoPRhS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764521632E5
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516688; cv=none; b=NxDKokXMujMPOhzCQihnjiD91pi8cfS0sd59op1dO6ty8ZsqThNL3+QDWO4b9tXrHeRom/81L6zdGUDV+dwOEWLSPIp3YFRC1aBEmkNlglO8udMVSPNBF1NRf299+nHzsTrjGIkfDy2Q6s9ougI5n8yjQKzLpuZjwOHxX7hU8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516688; c=relaxed/simple;
	bh=Cf5BqVgeTNIHyLzJHQPi81q5ELfR37Zl4MtkwpXcWLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSvpJdk0tNBAJXxrTbu78meyRA3SeXRGAjZT3PY5cblgnHl9AX7Ce7M8WIRwphWnxq89ymsxlkyIKujAyiVe2fKGlKupXL9KNDNtdZo+p5xlCenI2VWkDRPDEnDhDNsTyIXArzlgOlJNLv2B++J9I+0Qo8NSNdal8W6fF+g1g/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRvoPRhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA648C4CEC3;
	Wed, 13 Nov 2024 16:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731516688;
	bh=Cf5BqVgeTNIHyLzJHQPi81q5ELfR37Zl4MtkwpXcWLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRvoPRhSJ96nUN/vUWPNapbEy7jOeQ3MP06iUwG6OTy8NuLFnQC1oEDOTlZDxx85p
	 EXr0OxfC+pg5KmhRKY048IuTNAH4j90Arfny8BuaS7unKiBNn9JbkBVX9scWz1bhLt
	 L4Iqgb5NMU3692A9exbyig66mJGi20jzKTYMeZ6pe2GKm275qtG2zpCX+6H/3ffj++
	 bD3iKtZa/om2OcdT9z1zvETG8p71lGLgZCp64dxVUtSKMjodjnqRNXuZW5sJhOFOiA
	 xH8ayGywz7ek9j0aeczuBlGkxp6YGeJAMf4xHqkCbvIKLSk11ZX9nLB/ZqF2oLNn3F
	 C4Wm8+IFIn1yA==
Date: Wed, 13 Nov 2024 11:51:26 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Subject: Re: [for-6.13 PATCH 02/19] nfs_common: must not hold RCU while
 calling nfsd_file_put_local
Message-ID: <ZzTZDmE7dblUr07y@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
 <20241108234002.16392-3-snitzer@kernel.org>
 <c184b8e3e62595714fbcee993011951616ee3a1a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c184b8e3e62595714fbcee993011951616ee3a1a.camel@kernel.org>

On Wed, Nov 13, 2024 at 09:58:28AM -0500, Jeff Layton wrote:
> 
> I think this probably needs to go into v6.12 (or very early into v6.13
> and backported). It should also probably get:
> 
>     Fixes: 65f2a5c36635 ("nfs_common: fix race in NFS calls to nfsd_file_put_local() and nfsd_serv_put()")
> 
> You can also add:
> 
>     Reviewed-by: Jeff Layton <jlayton@kernel.org>

OK, I've added these.  I'm about to send out v2 of this series that
includes the other tags and suggested changes others have provided.

Thanks,
Mike

