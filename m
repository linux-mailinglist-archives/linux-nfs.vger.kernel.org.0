Return-Path: <linux-nfs+bounces-18931-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uTVGGYipj2mZSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18931-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 23:45:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF324139D64
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 23:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF6FC3036ECF
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 22:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE68248880;
	Fri, 13 Feb 2026 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SulMCdlV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A427FB1C
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022725; cv=none; b=E6NrC1CuPkcpwzf/4sO7+F1tyjXaFPaPFoWYlxSGfdUnIttEQ99YFZaIKtxnZnSqQBZWP0b3wt/hgyKGvvm/BZFJH1jheH8Ni9ahaDK7jr1wQktyjFXW8C0xF2HKpOZ1i3CUKdBmH1FbZ+w4Eu/6DI+a2uUZJhQlXr5LY5HNKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022725; c=relaxed/simple;
	bh=s7CLhm0OasmFTT7eeYLC2YltpK1BsylhM1qlilZlqQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZYQU57s94NXdy6IDbtSzEzSQVJBeREpo/OCj2HlxC3/B4rTeUJdfZ2abVFkGD1QksSivjRaT7ionxPpjTcCce4yzwYJJWp5lcAGGR031Me3oJqkF74tkEEbMU14G/5aabPJADcId8B8ZGRoy2eajMWzpV2pzBzR9IHpbNnUGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SulMCdlV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771022722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U5PmaZ9/kcRtyOg8rKdLnblVUUKmJMTuD7MtPieS92A=;
	b=SulMCdlV2luRndL437/Hpp7iCSX4HeOD/MPza4AiVWryej0xDwKzPiThcTB1P+nVtWSv6X
	fP7fKROOyCVZwRwE5kgGhehnjl3sGEwv89VZLFNi9M/TiIwD7jwiVXwnZI5w3A1mJ8wLQa
	e3//S00hslkrqSVLJm5OvGfigpYcagk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-FWaWLOCzPz2X7sSL6rOloA-1; Fri,
 13 Feb 2026 17:45:19 -0500
X-MC-Unique: FWaWLOCzPz2X7sSL6rOloA-1
X-Mimecast-MFC-AGG-ID: FWaWLOCzPz2X7sSL6rOloA_1771022718
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3A001800366;
	Fri, 13 Feb 2026 22:45:17 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.127])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EB5219560B9;
	Fri, 13 Feb 2026 22:45:17 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id B88686B6A00; Fri, 13 Feb 2026 17:45:15 -0500 (EST)
Date: Fri, 13 Feb 2026 17:45:15 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, trondmy@kernel.org,
	anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Check if we need to recalculate slack estimates
Message-ID: <aY-pe7-FhRpPy5J2@aion>
References: <20251119133231.3660975-1-smayhew@redhat.com>
 <ccd7d6aa-f307-4d4a-86fd-1920580bdd79@oracle.com>
 <aVe7TOFVxckWdF1m@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVe7TOFVxckWdF1m@eldamar.lan>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18931-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AF324139D64
X-Rspamd-Action: no action

On Fri, 02 Jan 2026, Salvatore Bonaccorso wrote:

> Hi Chuck, Scott,
> 
> On Wed, Nov 19, 2025 at 10:48:47AM -0500, Chuck Lever wrote:
> > On 11/19/25 8:32 AM, Scott Mayhew wrote:
> > > If the incoming GSS verifier is larger than what we previously recorded
> > > on the gss_auth, that would indicate the GSS cred/context used for that
> > > RPC is using a different enctype than the one used by the machine
> > > cred/context, and we should recalculate the slack variables accordingly.
> > > 
> > > Link: https://bugs.debian.org/1120598
> > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > ---
> > >  net/sunrpc/auth_gss/auth_gss.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> > > index 5c095cb8cb20..6da9ca08370d 100644
> > > --- a/net/sunrpc/auth_gss/auth_gss.c
> > > +++ b/net/sunrpc/auth_gss/auth_gss.c
> > > @@ -1721,6 +1721,14 @@ gss_validate(struct rpc_task *task, struct xdr_stream *xdr)
> > >  	if (maj_stat)
> > >  		goto bad_mic;
> > >  
> > > +	/*
> > > +	 * Normally we only recalculate the slack variables once after
> > > +	 * creating a new gss_auth, but we should also do it if the incoming
> > > +	 * verifier has a larger size than what was previously recorded.
> > 
> > No quibble with the code change, but IMO the comment should work a
> > little harder to explain why the increase is needed. Something like:
> > 
> > 	* When the incoming verifier is larger than expected, the
> > 	* GSS context is using a different enctype than the one used
> > 	* initially by the machine credential. Force a slack size update
> > 	* to maintain good payload alignment.
> > 
> > I'm summarizing based on your commit message above...
> > 
> > 
> > > +	 */
> > > +	if (cred->cr_auth->au_verfsize < (XDR_QUADLEN(len) + 2))
> > > +		__set_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags);
> > > +
> > >  	/* We leave it to unwrap to calculate au_rslack. For now we just
> > >  	 * calculate the length of the verifier: */
> > >  	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags))
> 
> I was looking in Debian for the state of this and noticed this was
> later on never applied/submitted to mainline, is this correct? Did it
> felt through the cracks or is it considered not to be a problem to
> further tackle?
> 
> Thanks a lot for your work and your help!

Sorry for the delay.  After having had a chance to take a deeper look,
I think it would be better to try to address this from the rpc.gssd side
instead of trying to make the kernel cope with having to bounce around
between different encryption types.

Unfortunately I fat-fingered your email address when I sent the patches,
so here's the link:
https://lore.kernel.org/linux-nfs/20260213224012.2608126-1-smayhew@redhat.com/T/#t

-Scott
> 
> Regards,
> Salvatore
> 


