Return-Path: <linux-nfs+bounces-14849-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DE9BB203A
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 00:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED311899C8E
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 22:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E535311C14;
	Wed,  1 Oct 2025 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmUejYhc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0271E2FE072;
	Wed,  1 Oct 2025 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759358700; cv=none; b=GkY/G4X54wf2idlnJWHsNe53FRicO1b9yCYZuuASRYpGx7wHpxD1t+LFL9ptQsTUU+mlgaIZEz+nOV7nrwnU4LumhHMmUz7Kjk3a34unvfXRSbj3KNwyPlzj594m1lIcwEwqn9nrgbU2bkHtkQqDiyAVo3XSyTMh9MY6tSaqG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759358700; c=relaxed/simple;
	bh=q0gcSaQKbrhUmp/AVOV9rmKhndELotdpu/zySyS644A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwuezaJCHiG+dlg6N+9bFJMi6uWYf9PGSmKLTaO1B7oOl90LO9pc9ibxS3D0lj8DmMoL9hRl+yVDLkIIZudF8T9qbyWcxIPXZECu7LzzEkWrg9n50a1WgpMK/fFasPtUw8CCo2i2ua1tzJ0Mm1i2pgb3vZwvIBpT8Z7LcK8DjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmUejYhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C60BC4CEF1;
	Wed,  1 Oct 2025 22:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759358699;
	bh=q0gcSaQKbrhUmp/AVOV9rmKhndELotdpu/zySyS644A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmUejYhcWmcwu6DX3jvTXoLlHnNuJPUQ5F37WO2wvl2dZ03IfRGXHD+vaS5RLeJ+p
	 oGqSfWJRiRT0AtMaOH1K/deoa5o4F9pCA6RHhKaDjQD6akYwYQq9IkxVa4a1sS0TzG
	 bhq4Fa2P6qMdw+kS/HqsZNeG/6nJZaD6i5dBQsaFhvRDkq+ZKS82WxVvuKS7489tCP
	 Gn1z8oDzwXhCXw4RX8eCBhvzMtdfkYLpVAU9znlpnel2eEeKzyuEdWvS4e7vZ6vZwL
	 8krFGQOzt60rN9PewWcOk5KdwZcHqbcAr+n+Mupjhabsr4V/wobxG1PsMP1cVELHJv
	 Iw7BRzy8UBk1A==
Date: Wed, 1 Oct 2025 18:44:58 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1] svcrdma: Increase the server's default RPC/RDMA
 credit grant
Message-ID: <aN2u6tt39GCNXRHO@kernel.org>
References: <20250926155235.60924-1-cel@kernel.org>
 <aN2Cnz1TrdOO74vb@kernel.org>
 <2cfc0bf3-e1ee-46ab-9fa5-de6d0e39a3db@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cfc0bf3-e1ee-46ab-9fa5-de6d0e39a3db@kernel.org>

On Wed, Oct 01, 2025 at 04:18:10PM -0400, Chuck Lever wrote:
> On 10/1/25 3:35 PM, Mike Snitzer wrote:
> > On Fri, Sep 26, 2025 at 11:52:35AM -0400, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> Now that the nfsd thread count can scale to more threads, permit
> > 
> > Just trying to appreciate which change(s) paved the way for this
> > RPCRDMA_MAX_REQUESTS change.
> > 
> > Are you referring to the netlink interface changes Jeff did earlier
> > this year or something else? (thinking "something else" but...)
> > 
> > Might be useful to update the header to convey which specific
> > commit(s) made this change possible.
> 
> The svc thread scaling change refers to the commits from
> 
> e3274026e2ec ("SUNRPC: move all of xprt handling into svc_xprt_handle()")
> 
> to
> 
> 15d39883ee7d ("SUNRPC: change the back-channel queue to lwq")
> 
> all dated about two years ago, merged in v6.7. Just checking,
> should the updated description provide more detail than that?

No, that's perfect. Thanks

