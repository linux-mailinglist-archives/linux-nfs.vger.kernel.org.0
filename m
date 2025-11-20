Return-Path: <linux-nfs+bounces-16637-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C5C7630A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 21:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A6084E193F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 20:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3214330B0E;
	Thu, 20 Nov 2025 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyAXRjn9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9903173
	for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670159; cv=none; b=UDNXNc0LIjI4RHeaGjHKq1CPZc24+HcQytsjiaRoPv7RXkb66C9q9UjRTPZjIn5Ampwp8oQ/V8ZGhTCA1kSLHbOHIjU33/N7BSQ67thmcHHPimqui/4pPTsJancR2GgIbwbWi5ADk1E1oYNKhSOlrMQ3Jg/5fdNlCwT8jkQNyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670159; c=relaxed/simple;
	bh=T8aW8ZWe82575L5jlY1j6CbOSeNcS/dxs+aehTQKLDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHs14OCj7XEDxmzZ84MKHVtQe8kBLBtDP6gX5/PZzIid0KpshejoDYJ/ylWmIOx4a4TNYbW8nooqceGD/TuCB2xPplbOLpHmq/suSQ4iKmxmgM0lMkBzTSJAVKWdaPKCponivOtTidRdDgLUEUvFZ7sgvg3ienmExem+W+jH7wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyAXRjn9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763670156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GPVwJW3BYFeE6GKw8xcEsWR5C85+JqHQyNpzBhaznsU=;
	b=KyAXRjn9sfk/P3q5OQ/kD5SrySUCYIG2+wpZKWf6IO9WIeg69j9BqbdzqlU1ynBytrFup1
	/YY3uoZnvYyqhtMpizVOpw5LbwnNgDoE0NGAw2XVa2t+Ui3vt32dJLsUTB1yLIxcFGZ4yV
	qa12qMhYc0vLMu5s+k0VikxqBL6JBcM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-0pwcEBXqMqiUuijxFZv18g-1; Thu,
 20 Nov 2025 15:22:32 -0500
X-MC-Unique: 0pwcEBXqMqiUuijxFZv18g-1
X-Mimecast-MFC-AGG-ID: 0pwcEBXqMqiUuijxFZv18g_1763670151
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79BDD1955F4A;
	Thu, 20 Nov 2025 20:22:31 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.81.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47D8430044DB;
	Thu, 20 Nov 2025 20:22:31 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 643E350C8DA; Thu, 20 Nov 2025 15:22:29 -0500 (EST)
Date: Thu, 20 Nov 2025 15:22:29 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, trondmy@kernel.org,
	anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] SUNRPC: Check if we need to recalculate slack
 estimates
Message-ID: <aR94hXJCQAKhvbXq@aion>
References: <20251120121252.3724988-1-smayhew@redhat.com>
 <02f6a095-5f64-4e06-b799-6213f207fa4c@oracle.com>
 <40af5afceb6230d881ba9814e3eed317ead8c1e1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40af5afceb6230d881ba9814e3eed317ead8c1e1.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, 20 Nov 2025, Jeff Layton wrote:

> On Thu, 2025-11-20 at 08:44 -0500, Chuck Lever wrote:
> > On 11/20/25 7:12 AM, Scott Mayhew wrote:
> > > If the incoming GSS verifier is larger than what we previously recorded
> > > on the gss_auth, that would indicate the GSS cred/context used for that
> > > RPC is using a different enctype than the one used by the machine
> > > cred/context, and we should recalculate the slack variables accordingly.
> > > 
> > > Link: https://bugs.debian.org/1120598
> > 
> > Since there is a bug link, a Fixes: tag is recommended.
> > 
> > 
> > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > ---
> > >  net/sunrpc/auth_gss/auth_gss.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> > > index 5c095cb8cb20..bff5f10581a2 100644
> > > --- a/net/sunrpc/auth_gss/auth_gss.c
> > > +++ b/net/sunrpc/auth_gss/auth_gss.c
> > > @@ -1721,6 +1721,18 @@ gss_validate(struct rpc_task *task, struct xdr_stream *xdr)
> > >  	if (maj_stat)
> > >  		goto bad_mic;
> > >  
> > > +	/*
> > > +	 * Normally we only recalculate the slack variables once after
> > > +	 * creating a new gss_auth, but we should also do it if the incoming
> > > +	 * verifier has a larger size than what was previously recorded.
> > > +	 * When the incoming verifier is larger than expected, the
> > > +	 * GSS context is using a different enctype than the one used
> > > +	 * initially by the machine credential. Force a slack size update
> > > +	 * to maintain good payload alignment.
> > > +	 */
> > > +	if (cred->cr_auth->au_verfsize < (XDR_QUADLEN(len) + 2))
> > > +		__set_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags);
> > 
> > set_bit() rather than __set_bit is a better choice for a lockless update
> > where multiple concurrent threads can have access to the flags field.
> > 
> > 
> 
> This function tests for that flag just below though. Could another task
> do the test_and_clear_bit() in gss_update_rslack(), such that the
> au_verfsize doesn't get updated below ?
> 
> If that is a possibility, maybe you should update the au_verfsize
> first, and then the flag just afterward (with a barrier between).

Yes, I suppose that is a possibility.  But in that case we are pretty
much screwed (at least in the case of krb5i and krb5p) because it's
likely that the fields used to generate the 'before' and 'after' values
passed gss_update_rslack() don't coincide with the verifier anyways.

IOW if we're going to recalculate rslack and ralign based on a larger
verifier, then it pretty much has to be done by the same task that sets
the flag in the first place.

> 
> > > +
> > >  	/* We leave it to unwrap to calculate au_rslack. For now we just
> > >  	 * calculate the length of the verifier: */
> > >  	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags))
> > 
> > Thanks for pursuing this one, Scott.
> > 
> > Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 


