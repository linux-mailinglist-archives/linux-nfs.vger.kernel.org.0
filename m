Return-Path: <linux-nfs+bounces-16901-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FBECA3EE8
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Dec 2025 15:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E239301AD20
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Dec 2025 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95641E9915;
	Thu,  4 Dec 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yo2LRBOF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C4320A34
	for <linux-nfs@vger.kernel.org>; Thu,  4 Dec 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764856392; cv=none; b=n4dQdPzlMbzhXh800SLhpMsBk1y10CtryZwchJWFBL64lUcEVjR1AOJxBQmiDtFnvpkMhpjY+9Qcc0QSdpAzYbb4toTbMxjB1H0787kiJBVUs8s44sTS9lWXvDN4VAu6bwR79Z9Br4JomF4QTSGAxy0b1RrDi1fyUDNHpYuf2dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764856392; c=relaxed/simple;
	bh=+wkgqtB1gZpHa5ETxGm3XQRKsl8HEXkWqtCGCWZMHAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANFg5HWfztCbWYUS2RGAXjZ3NfHp1Y5BBNUx4smEkdQm4kSEcHzNg7xdAz51VSXz64SgL4TgoUljmYPfhRUv94oMXz0/FKfL9kIgz/iDHxbcwEtlrdc4Rg+eVnQQBAJ5Dn/XG1YDPuDrvik73C2wUB3uLLKQJobNn4jjpzN5UvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yo2LRBOF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764856389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYHzJkA0HvD4jLB3LUvRrKReSIouTc9ggv6QgwqaH5I=;
	b=Yo2LRBOFXVD1hb7iEV1hB7jzqfKyV5d9r9icevyvlIEz0JrFZfMXi0HrX40vcqE3Lo5XNy
	kUMMpmEgoHkapE5iuC56B3GyjeKfFWN8bZYmijL1jnLSiqX5zz8mhqZYNvHLnfUGqpv0vS
	KMiDvCVuRzVG4VkUygvQT4ZWEyBAAkE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-sExXSmw2Mq-SX086aE7Plw-1; Thu,
 04 Dec 2025 08:53:05 -0500
X-MC-Unique: sExXSmw2Mq-SX086aE7Plw-1
X-Mimecast-MFC-AGG-ID: sExXSmw2Mq-SX086aE7Plw_1764856384
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C57BF19560B2;
	Thu,  4 Dec 2025 13:53:04 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FD051953986;
	Thu,  4 Dec 2025 13:53:04 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id F30DC548BFE; Thu, 04 Dec 2025 08:53:02 -0500 (EST)
Date: Thu, 4 Dec 2025 08:53:02 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: anna@kernel.org, chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] SUNRPC: Check if we need to recalculate slack
 estimates
Message-ID: <aTGSPl66JCYjlt6W@aion>
References: <20251120121252.3724988-1-smayhew@redhat.com>
 <305f38b14cec83b79921d5e1552ace515db59f24.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <305f38b14cec83b79921d5e1552ace515db59f24.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, 03 Dec 2025, Trond Myklebust wrote:

> Hi Scott,
>=20
> On Thu, 2025-11-20 at 07:12 -0500, Scott Mayhew wrote:
> > If the incoming GSS verifier is larger than what we previously
> > recorded
> > on the gss_auth, that would indicate the GSS cred/context used for
> > that
> > RPC is using a different enctype than the one used by the machine
> > cred/context, and we should recalculate the slack variables
> > accordingly.
> >=20
> > Link: https://bugs.debian.org/1120598
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> > =A0net/sunrpc/auth_gss/auth_gss.c | 12 ++++++++++++
> > =A01 file changed, 12 insertions(+)
> >=20
> > diff --git a/net/sunrpc/auth_gss/auth_gss.c
> > b/net/sunrpc/auth_gss/auth_gss.c
> > index 5c095cb8cb20..bff5f10581a2 100644
> > --- a/net/sunrpc/auth_gss/auth_gss.c
> > +++ b/net/sunrpc/auth_gss/auth_gss.c
> > @@ -1721,6 +1721,18 @@ gss_validate(struct rpc_task *task, struct
> > xdr_stream *xdr)
> > =A0	if (maj_stat)
> > =A0		goto bad_mic;
> > =A0
> > +	/*
> > +	 * Normally we only recalculate the slack variables once
> > after
> > +	 * creating a new gss_auth, but we should also do it if the
> > incoming
> > +	 * verifier has a larger size than what was previously
> > recorded.
> > +	 * When the incoming verifier is larger than expected, the
> > +	 * GSS context is using a different enctype than the one
> > used
> > +	 * initially by the machine credential. Force a slack size
> > update
> > +	 * to maintain good payload alignment.
> > +	 */
> > +	if (cred->cr_auth->au_verfsize < (XDR_QUADLEN(len) + 2))
> > +		__set_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth-
> > >au_flags);
> > +
> > =A0	/* We leave it to unwrap to calculate au_rslack. For now we
> > just
> > =A0	 * calculate the length of the verifier: */
> > =A0	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth-
> > >au_flags))
>=20
> What's the status here? Are you planning to put out a new version with
> the non-atomic __set_bit() -> atomic set_bit() change?

No.  After discussing with Chuck and Jeff I'm not sure this is the
right approach.

I was under the impression that the slack and ralign values were more
like estimates and we could afford to be conservative, i.e. I was
thinking that as long as we were accommodating the enctype with the
largest space requirements then we'd be okay.  But if that's not the
case, then  updating the values when a user cred is using a SHA2
enctype would mean the values are incorrect if the machine cred is using
a SHA1 enctype.

Maybe we should instead just emit some sort of a warning when we
encounter a verifier with a different size that what we previously
recorded on the auth handle?

>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com
>=20


