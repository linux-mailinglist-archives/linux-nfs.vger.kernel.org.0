Return-Path: <linux-nfs+bounces-6427-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 144D097746B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 00:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258CBB241A6
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 22:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1713E1C1AB5;
	Thu, 12 Sep 2024 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayR8Ap7H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B6319CC25;
	Thu, 12 Sep 2024 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180744; cv=none; b=Ll28MlgfhprSeeWIgUtHvXUcYfecCCNhxMzJ/VWeNURGQE9bnkJLsPYTptdnYRWPkL5t9B3CAeROx/KPlsbePkaHql42acrMcD78NobcB85dXQDc1fEplr21fiOKKBopWUDS6GlhGS5AnUtwuS4+8CL6X3T65thC8AI7AElQ1IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180744; c=relaxed/simple;
	bh=HS0Fz4UcdCMOfXAWEEjEPfy3Pa3H3KF5rs8HsT0AUj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjUbqz1A4vmEggeHZt4pqEj6/Y5e7OSidvXvPaorF/LDHWORkEHakCwxuqnzy0unsbuttf+Vaydsp9IF8rVSjaGb6xfKsOChbKfyTAQrHF9KQxvyhEjYALIf41hWZqTapzsAjCRQKFMv2tp7GfHY8zJzHTdLsdrW0Xa6y1IgI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayR8Ap7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52668C4CEC6;
	Thu, 12 Sep 2024 22:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726180743;
	bh=HS0Fz4UcdCMOfXAWEEjEPfy3Pa3H3KF5rs8HsT0AUj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayR8Ap7H6af7Yuhp3gz1SUMGoGs5l33UouR6zHki3wRrq4axwvurklP8CR1bnzCzH
	 nJXyaGF4pd0c7hNH6weHpzuadrVfcBJyQZEcil04/pDdn7L453jgOuKl7OR+Rz1Fck
	 VMrd25ecIUX4cn37K4CeB1mZe1coEqvreohCtMZDf2rOpvMEjn1kifb66I/IN1Wa6s
	 aarYnOZelkGw+lQtkQG9sHpud53B664D/olTEqkWjfweLE7PeKkhGE5fa7b58Bdwwo
	 /6niGbO15fVyzoSp0dCHWFQbY3y+7gjwBTtpddJvT+HbmFwu1AR302a8o7tHAogjKs
	 OxE6W6nhLKPPg==
Received: by pali.im (Postfix)
	id 96B1E5E9; Fri, 13 Sep 2024 00:38:58 +0200 (CEST)
Date: Fri, 13 Sep 2024 00:38:58 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix nfs4_disable_idmapping option
Message-ID: <20240912223858.22qibyh3xwk2pqw5@pali>
References: <20240912220659.23336-1-pali@kernel.org>
 <172617996236.17050.1069184645717662362@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172617996236.17050.1069184645717662362@noble.neil.brown.name>
User-Agent: NeoMutt/20180716

On Friday 13 September 2024 08:26:02 NeilBrown wrote:
> On Fri, 13 Sep 2024, Pali Rohár wrote:
> > NFSv4 server option nfs4_disable_idmapping says that it turn off server's
> > NFSv4 idmapping when using 'sec=sys'. But it also turns idmapping off also
> > for 'sec=none'.
> > 
> > NFSv4 client option nfs4_disable_idmapping says same thing and really it
> > turns the NFSv4 idmapping only for 'sec=sys'.
> > 
> > Fix the NFSv4 server option nfs4_disable_idmapping to turn off idmapping
> > only for 'sec=sys'. This aligns the server nfs4_disable_idmapping option
> > with its description and also aligns behavior with the client option.
> 
> Why do you think this is the right approach?

I thought it because client has same configuration option, client is
already doing it, client documentation says it and also server
documentation says it. I just saw too many pieces which agreed on it and
just server implementation did not follow it.

And to make mapping usable, both sides (client and server) have to agree
on the configuration.

So instead of changing also client and client's documentation it is
easier to just fix the server.

> If the documentation says "turn off when sec=sys" and the implementation
> does "turn off when sec=sys or sec=none" then I agree that something
> needs to be fixed.  I would suggest that the documentation should be
> fixed.
> 
> From the perspective of id mapping, sec=none is similar to sec=sys.

It is similar, but quite different. With sec=sys client sends its uid
and list of gids in every (RPC) packet and server authenticate client
(and do mapping) based on it. With sec=none client does not send any uid
or gid. So mostly uid/gid form is tight to sec=sys.

> NeilBrown
> 
> 
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  fs/nfsd/nfs4idmap.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
> > index 7a806ac13e31..641293711f53 100644
> > --- a/fs/nfsd/nfs4idmap.c
> > +++ b/fs/nfsd/nfs4idmap.c
> > @@ -620,7 +620,7 @@ numeric_name_to_id(struct svc_rqst *rqstp, int type, const char *name, u32 namel
> >  static __be32
> >  do_name_to_id(struct svc_rqst *rqstp, int type, const char *name, u32 namelen, u32 *id)
> >  {
> > -	if (nfs4_disable_idmapping && rqstp->rq_cred.cr_flavor < RPC_AUTH_GSS)
> > +	if (nfs4_disable_idmapping && rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)
> >  		if (numeric_name_to_id(rqstp, type, name, namelen, id))
> >  			return 0;
> >  		/*
> > @@ -633,7 +633,7 @@ do_name_to_id(struct svc_rqst *rqstp, int type, const char *name, u32 namelen, u
> >  static __be32 encode_name_from_id(struct xdr_stream *xdr,
> >  				  struct svc_rqst *rqstp, int type, u32 id)
> >  {
> > -	if (nfs4_disable_idmapping && rqstp->rq_cred.cr_flavor < RPC_AUTH_GSS)
> > +	if (nfs4_disable_idmapping && rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)
> >  		return encode_ascii_id(xdr, id);
> >  	return idmap_id_to_name(xdr, rqstp, type, id);
> >  }
> > -- 
> > 2.20.1
> > 
> > 
> 

