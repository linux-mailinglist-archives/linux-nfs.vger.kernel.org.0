Return-Path: <linux-nfs+bounces-16692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CFC7E46B
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 17:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80796347B21
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Nov 2025 16:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C352264A7;
	Sun, 23 Nov 2025 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNYv1FBD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA619C546
	for <linux-nfs@vger.kernel.org>; Sun, 23 Nov 2025 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763916197; cv=none; b=F6Kt9doC46Hed4XZXeWMWay0LduAtCAwrMcz/6XJJG323I8nCUjKgJwGLtdSU/eLvh0InDxlf22DPE3I1zeJErKFFnQaDarUT/h4PgqRBfg4Ka+ScsMhLDl4UOxBDXuU1vA3QNxjyGXUb38w84mcgQG8XLkd0kcA4cbf7zA4KB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763916197; c=relaxed/simple;
	bh=IDJ4n69gcszzl0Su+Gaf7P27pPRXbR3yikHzVoTq/0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJa27ygulmcGFEKN165ZuoxkdH4v9PK70+XLvOFaRD7TcNAvO+1jKDTcC1vUv5U2W0kfFHr1ReWjiTqnbN+ATdFlVPeF5+wLldJathO7xk76fs/629UGjy0f0gwTza2cjCNAbulqHTTdrj7zeEzM3/7Qommo5MksdoRBbE4iCuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNYv1FBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE8AC116D0;
	Sun, 23 Nov 2025 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763916196;
	bh=IDJ4n69gcszzl0Su+Gaf7P27pPRXbR3yikHzVoTq/0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNYv1FBD9bMXRiWfq2PRfbS518epRTR7jBR57tf/u4Ly1OSw3XpO8EnLo9Y7xUESx
	 fgu1b4hhdFNk5LVFEGwPW5F8FZXXCL0Jswq1VY1sVtzbCElpTDW0XPALAgN/Jk8Y05
	 uotviyWr/hF0ph9Z4qGlrxu4e3GvJO6/CRxK+T2EWoM48RhMtx3+qfCxu10qHwghqQ
	 4s7pDYVKMvBmUqn1zGmYzlwKgmaQgp/Dvp989ZG2dd8xtn9yC/2wbvhkzuMPjVzJgs
	 vULDHxyzSaDAyTVZQGcHr0i7fJUiE5vRMwxa4iDYYJF5OoRIxU8d7uVTnevFuCat0S
	 BXKvp9goPhRAw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5F50BF40071;
	Sun, 23 Nov 2025 11:43:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 23 Nov 2025 11:43:15 -0500
X-ME-Sender: <xms:ozkjacMFNEY9q25931zZH6VMzhptPHSW0e-N0uv64-X-Ge79mVe5FA>
    <xme:ozkjaVOq5QlRcCer9Yt1eoDK9rA3ZxGMZ-BwOxeS7qGd_ndl3CdOEDXg7_j0s7QNq
    8xRbW4GP9An7OK7ebA-w67uFRsJra3bQ2wm6nytZuYnKzCvTCvTqSY>
X-ME-Received: <xmr:ozkjaVjzl3fVinHPwur8fLuNjj7EGO5JmXMDzkEM9QkGTfAk-U1U-ffi9PS8mmVSDhgFDTfoHNvuWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeivdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ozkjaasaI6SbcqH2OBVkmb7jb38rkmdwpr2NwjQCWGL1_s4hv4sknQ>
    <xmx:ozkjaTTRQJQUlXLWiWFmy_f6a_MWPmq49tfOFQHipYrTKh0x82sXLQ>
    <xmx:ozkjae0qy6EUXsOOFWvmo8ZcekZ36hfO7kXgBrg3JJpWVIX0DtMziA>
    <xmx:ozkjaYuQaPh0oTtVkls6SyiHF-mLXHeBcGxTdAU5UA0gBSjt8Zhnmw>
    <xmx:ozkjaUho7w5tgphrCDN4yMViZS-o7uKdUDv98d-DImD_W2SIVViNU2Kv>
Feedback-ID: ifa6e4810:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 11:43:14 -0500 (EST)
Date: Sun, 23 Nov 2025 11:43:13 -0500
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 04/14] nfsd: allow unrecognisable filehandle for
 foreign servers in COPY
Message-ID: <aSM5oSoiw_6wDU_K@morisot.1015granger.net>
References: <20251122005236.3440177-1-neilb@ownmail.net>
 <20251122005236.3440177-5-neilb@ownmail.net>
 <aSIoEqzuT6seYiq0@morisot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSIoEqzuT6seYiq0@morisot.1015granger.net>

On Sat, Nov 22, 2025 at 04:16:02PM -0500, Chuck Lever wrote:
> On Sat, Nov 22, 2025 at 11:47:02AM +1100, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > RFC-7862 acknowledges that a filehandle provided as the source of an
> > inter-server copy might result in NFS4ERR_STALE when given to PUTFH, and
> > gives guidance on how this error can be ignored (section 15.2.3).
> > 
> > NFS4ERR_BADHANDLE is also a possible error in this circumstance if the
> > foreign server is running a different implementation of NFS than the
> > current one.
> 
> The RFC uses the terms "source" and "destination" server, fwiw.
> 
> It would be interesting to see if nfserr_badhandle can be triggered
> during an NFSD <-> NFSD copy.
> 
> 
> > This appears to be a simple omission in the RFC.
> 
> Perhaps. It might also be the result of the RFC authors giving
> implementers flexibility to innovate.
> 
> I would like to consult with the WG and possibly file an errata, or
> add this observation to the "NFSv4.2 COPY implementation experience"
> document I'm helping Olga with:
> 
> https://datatracker.ietf.org/doc/draft-cel-nfsv4-copy-implementation-experience/
> 
> They might want to consider NFS4ERR_MOVED as well.
> 
> 
> > There can be no harm in delaying a BADHANDLE error in the same situation
> > where we already delay STALE errors, and no harm in sending a locally
> > "bad" handle to a foreign server to request a COPY.
> 
> These are plausible claims. But IMO, they need firmer rationale.

My comments aren't terribly clear about this, but I agree that PUTFH
handling NFS4ERR_BADHANDLE is a concern when there is a subsequent
COPY operation in the COMPOUND.

I think we can't rely on the letter of RFC 7862, as you pointed out.
However, the spirit of RFC 7862 is that PUTFH mustn't fail if a
client presents a foreign file handle via a PUTFH that precedes a
COPY operation. The lack of BCP14 language specific to other status
codes shouldn't stop NFSD from handling other status codes as it
needs to (in fact, the absence of such language affords us the
opportunity of doing exactly that).

The reason for this potential PUTFH failure is an artifact of NFSD's
PUTFH implementation, which unconditionally invokes fh_verify.

I'm wondering if PUTFH needs to check for /specific/ status codes
from fh_verify before looking ahead in the incoming COMPOUND, or if
it ought to look ahead on /any/ failure of fh_verify.

And, is this patch a fix that needs to be backported to LTS kernels?
If so, then perhaps it needs to go before the previous patch.

(It seems like NFSv4.2 could have added a PUT_FOREIGN_FH operation
to avoid all this nonsense).

(I'll also note that now that our MAX_OPS_PER_COMPOUND has increased
and might increase again, moving the COPY look ahead checking out of
nfsd4_proc_compound is a huge bonus for handling large COMPOUNDs).


> > So extend the test in nfsd4_putfh to also check for nfserr_badhandle.
> > 
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfsd/nfs4proc.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 112e62b6b9c6..ae34b816371c 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -693,7 +693,8 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  	       putfh->pf_fhlen);
> >  	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
> >  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> > -	if (ret == nfserr_stale && inter_copy_offload_enable) {
> > +	if ((ret == nfserr_badhandle || ret == nfserr_stale) &&
> > +	    inter_copy_offload_enable) {
> >  		struct nfsd4_compoundargs *args = rqstp->rq_argp;
> >  		struct nfsd4_compoundres *resp = rqstp->rq_resp;
> >  
> > @@ -713,7 +714,11 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >  			 *  NOT return NFS4ERR_STALE for either
> >  			 *  operation.
> >  			 * We limit this to when there is a COPY
> > -			 * in the COMPOUND.
> > +			 * in the COMPOUND, and extend it to
> > +			 * also ignore NFS4ERR_BADHANDLE despite the
> > +			 * RFC not requiring this.  If the remote
> > +			 * server is running a different NFS implementation,
> > +			 * NFS4ERR_BADHANDLE is a likely error.
> >  			 */
> >  			ret = 0;
> >  		}
> > -- 
> > 2.50.0.107.gf914562f5916.dirty
> > 
> > 
> 
> -- 
> Chuck Lever
> 

-- 
Chuck Lever

