Return-Path: <linux-nfs+bounces-16674-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425E2C7D7EA
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 22:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D2D3AAD45
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 21:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433B513B7A3;
	Sat, 22 Nov 2025 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNRli1Y8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6C1D555
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763846166; cv=none; b=RUY7fcD27MSNJ0tfZlfk386BFDTc16nbTIF31Wrlz/aPuR9WyFgvKuqXIeYX9CuAbGtgiGDwW2rC4MlZKVaEy6X566k0XIbIMDdNh66aI5VUr++HyhuVlbv/i6yHkG73US5p0O3y+yIQvHHZArBG3fvECqLVT+KkSVRCH8jSbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763846166; c=relaxed/simple;
	bh=UqqVdf6W5QHw/+WI4aPWtGoUGFJQH6QkRcd1kOOutHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIICPMi8wb7yrVKqp2MHxs7Mxg+nNXxauTAjZsIZn8BBiGFmrZqftw9734u8QVzjwEJAWaRuFmdRQqxLhVO1HRY+j6MWaUROIqjEQp+1CBJMIVoSMncn0VP9LakQ5K7X+SLW5RvT60xamXdUYWp46I6v4F7lum5fvu6kPM40oM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNRli1Y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2924AC4CEF5;
	Sat, 22 Nov 2025 21:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763846165;
	bh=UqqVdf6W5QHw/+WI4aPWtGoUGFJQH6QkRcd1kOOutHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vNRli1Y8+cbeUtc/g5jncnU9SmCGaoz5IeWKvsQrp0P0nYfHZYcMe8IWi1j4oCmzu
	 1t+z7hzl0MDaVZZUpkYHaSYM4vdmNNcVl3XGSmvF7wnQECUYEL9y3tFNsfdHE2CXPl
	 +6sUih6ch/hJ7UE/MnS/bVrPSHxmJhaUmqjOhGtfv8vH3x8KgiQy6Dj35xbeNXo/Gn
	 wwEzWacMpR4s3PRYr0BFYv9fYeLh335E3zie4Zj3JtGoo7PR7OE/j41lXtLmTCcdP1
	 z5Nhz/cZqi/78GN+oLgClyNTScK90Z7gpDjVMVgwAWElvDnviVAY0nG8nqtf1toDC3
	 l3Md8IB7nOKkg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 51EA8F40080;
	Sat, 22 Nov 2025 16:16:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 22 Nov 2025 16:16:04 -0500
X-ME-Sender: <xms:FCgiaUoPsbaPZbNpBaeNJXdLiztH2qTvqvUrjYB17Kqznzd6-wcGcA>
    <xme:FCgiac4CJiAZtLgDmmBjGQIYiCtUnmw534NV-PxeQ2Ec6iD0l-kRJfnBu9_IneMRV
    ky9Fw5HY3Vozwwv4XXVZOZwrlOBEIloSHiEtX4sY5sJLivlWwURDA>
X-ME-Received: <xmr:FCgiabch4PusMV3xO3zcfckUa6uTRVWHMnoXvVci4VZizP_NqX2WDxB5amrblD25WI5VxGz5XhgwBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeefledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvehhuhgtkhcu
    nfgvvhgvrhcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepue
    ehleetvdfhjeekheduteevieehkeeivdejvddvtdduhfeiheejieefvdegffffnecuffho
    mhgrihhnpehivghtfhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqdgtvghlpeepkhgvrh
    hnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepjedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprh
    gtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehokhhorhhnihgvvh
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgt
    ohhmpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FCgiaR4zHPJNWn9FDegmC-n_PkzPAkN-iItFOG5AcBGj2ZAGqr-WyA>
    <xmx:FCgiaSuMS9cBBGCw2OKId4yhbLxPIgZRAXQqEu-30nKrYkxSfImnZw>
    <xmx:FCgiaRiwCl-qfau2QLIeKXp39Usjy876deCcLLPlYG4fwsJsqzIjQA>
    <xmx:FCgiadrlvKuEjb4uOuV-szzUbWERj-rxAzLUrLXqyd6xEDCQRBDrGA>
    <xmx:FCgiaeu0UFUqxC072xhZOTKAhFWzdEiiLglWa8OoJuc6ORW7bJWbV6fJ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Nov 2025 16:16:03 -0500 (EST)
Date: Sat, 22 Nov 2025 16:16:02 -0500
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 04/14] nfsd: allow unrecognisable filehandle for
 foreign servers in COPY
Message-ID: <aSIoEqzuT6seYiq0@morisot.1015granger.net>
References: <20251122005236.3440177-1-neilb@ownmail.net>
 <20251122005236.3440177-5-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122005236.3440177-5-neilb@ownmail.net>

On Sat, Nov 22, 2025 at 11:47:02AM +1100, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> RFC-7862 acknowledges that a filehandle provided as the source of an
> inter-server copy might result in NFS4ERR_STALE when given to PUTFH, and
> gives guidance on how this error can be ignored (section 15.2.3).
> 
> NFS4ERR_BADHANDLE is also a possible error in this circumstance if the
> foreign server is running a different implementation of NFS than the
> current one.

The RFC uses the terms "source" and "destination" server, fwiw.

It would be interesting to see if nfserr_badhandle can be triggered
during an NFSD <-> NFSD copy.


> This appears to be a simple omission in the RFC.

Perhaps. It might also be the result of the RFC authors giving
implementers flexibility to innovate.

I would like to consult with the WG and possibly file an errata, or
add this observation to the "NFSv4.2 COPY implementation experience"
document I'm helping Olga with:

https://datatracker.ietf.org/doc/draft-cel-nfsv4-copy-implementation-experience/

They might want to consider NFS4ERR_MOVED as well.


> There can be no harm in delaying a BADHANDLE error in the same situation
> where we already delay STALE errors, and no harm in sending a locally
> "bad" handle to a foreign server to request a COPY.

These are plausible claims. But IMO, they need firmer rationale.


> So extend the test in nfsd4_putfh to also check for nfserr_badhandle.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4proc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 112e62b6b9c6..ae34b816371c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -693,7 +693,8 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	       putfh->pf_fhlen);
>  	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
>  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> -	if (ret == nfserr_stale && inter_copy_offload_enable) {
> +	if ((ret == nfserr_badhandle || ret == nfserr_stale) &&
> +	    inter_copy_offload_enable) {
>  		struct nfsd4_compoundargs *args = rqstp->rq_argp;
>  		struct nfsd4_compoundres *resp = rqstp->rq_resp;
>  
> @@ -713,7 +714,11 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  			 *  NOT return NFS4ERR_STALE for either
>  			 *  operation.
>  			 * We limit this to when there is a COPY
> -			 * in the COMPOUND.
> +			 * in the COMPOUND, and extend it to
> +			 * also ignore NFS4ERR_BADHANDLE despite the
> +			 * RFC not requiring this.  If the remote
> +			 * server is running a different NFS implementation,
> +			 * NFS4ERR_BADHANDLE is a likely error.
>  			 */
>  			ret = 0;
>  		}
> -- 
> 2.50.0.107.gf914562f5916.dirty
> 
> 

-- 
Chuck Lever

