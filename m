Return-Path: <linux-nfs+bounces-16851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E88DCC9C070
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 16:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6CC94E055B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F70321441;
	Tue,  2 Dec 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dUPFZtzz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F71245005;
	Tue,  2 Dec 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690681; cv=none; b=QX5bYye5G1uuVCDV7exm06n8ub4so0euPfFWFKGgn4L+lyMa3bmfjdSZExm6qBQUIzPlDqJ2zs/4o6cpPlRMR3NFAEPidj/f9Ow2MOVL3dy2DtkGFn/gjLrJcFnlMcTZfEK5t56G8X70Nxf/Fa8NgK8V7JBQy1nbnVMkF3GcJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690681; c=relaxed/simple;
	bh=CGnunB09lXs1PGQMquVlhnjDRgopcnbuXFOqRCg9gdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E15LAGf3ZAikHLRzkhjkYRq8oc0RZNdUHIkxb82l+Bz/z3LQ/va0/mxXq5M7mGBH6HMTwicqtzvMratIsvj9t94+irKBGAI3tCjDu+OvNHZa6DCOKdLD+7NN2lFION51MWR9PD+BxPtRJCWKHzRPElQnO2x67IgRcoO37+gK1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dUPFZtzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B48C4CEF1;
	Tue,  2 Dec 2025 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764690680;
	bh=CGnunB09lXs1PGQMquVlhnjDRgopcnbuXFOqRCg9gdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUPFZtzzkFvlTrMc99DmYJXbbHUdnnPANCVf768+o/C5BozHLSvihSGs/waqlzpx9
	 3zAtEnQ4/KNcnI64aVPpacu356U3s2MGM0vfYhwTFwU+P3IWgdNYI461OC1He3Q8Fw
	 wKmZDABXshts+C4q60hqbVpn86iZTL2Q1rtnr8Lc=
Date: Tue, 2 Dec 2025 16:51:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever <cel@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	linux-kernel@vger.kernel.org, speedcracker@hotmail.com,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	david.laight.linux@gmail.com,
	Andrew Morten <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v1 v6.12.y] nfsd: Replace clamp_t in nfsd4_get_drc_mem()
Message-ID: <2025120202-appetizer-pushy-6b96@gregkh>
References: <20251114211922.6312-1-cel@kernel.org>
 <8bd5a144-1d67-447c-b33e-388ef27b1176@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bd5a144-1d67-447c-b33e-388ef27b1176@kernel.org>

On Mon, Dec 01, 2025 at 02:28:50PM -0500, Chuck Lever wrote:
> On 11/14/25 4:19 PM, Chuck Lever wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > A recent change to clamp_t() in 6.1.y caused fs/nfsd/nfs4state.c to fail
> > to compile with gcc-9. The code in nfsd4_get_drc_mem() was written with
> > the assumption that when "max < min",
> > 
> >    clamp(val, min, max)
> > 
> > would return max.  This assumption is not documented as an API promise
> > and the change caused a compile failure if it could be statically
> > determined that "max < min".
> > 
> > The relevant code was no longer present upstream when commit 1519fbc8832b
> > ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")
> > landed there, so there is no upstream change to nfsd4_get_drc_mem() to
> > backport.
> > 
> > There is no clear case that the existing code in nfsd4_get_drc_mem()
> > is functioning incorrectly. The goal of this patch is to permit the clean
> > application of commit 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for
> > the lo < hi test in clamp()"), and any commits that depend on it, to LTS
> > kernels without affecting the ability to compile those kernels. This is
> > done by open-coding the __clamp() macro sans the built-in type checking.
> > 
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c0
> > Signed-off-by: NeilBrown <neil@brown.name>
> > Stable-dep-of: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4state.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > Changes since Neil's post:
> > * Editorial changes to the commit message
> > * Attempt to address David's review comments
> > * Applied to linux-6.12.y, passed NFSD upstream CI suite
> > 
> > This patch is intended to be applied to linux-6.12.y, and should
> > apply cleanly to other LTS kernels since nfsd4_get_drc_mem hasn't
> > changed since v5.4.
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 7b0fabf8c657..41545933dd18 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1983,8 +1983,10 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
> >  	 */
> >  	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> >  
> > -	avail = clamp_t(unsigned long, avail, slotsize,
> > -			total_avail/scale_factor);
> > +	if (avail > total_avail / scale_factor)
> > +		avail = total_avail / scale_factor;
> > +	else if (avail < slotsize)
> > +		avail = slotsize;
> >  	num = min_t(int, num, avail / slotsize);
> >  	num = max_t(int, num, 1);
> >  	nfsd_drc_mem_used += num * slotsize;
> 
> Is something else needed from me to get this applied to v6.12 and older
> LTS kernels?

Oops, sorry about that, now queued up.

greg k-h

