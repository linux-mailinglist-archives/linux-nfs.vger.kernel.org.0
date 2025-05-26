Return-Path: <linux-nfs+bounces-11899-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7F5AC3768
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 02:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9C03B4416
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 00:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092EC10F9;
	Mon, 26 May 2025 00:09:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E910E9
	for <linux-nfs@vger.kernel.org>; Mon, 26 May 2025 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748218189; cv=none; b=dmXjuWd+auWE1RmvlUI/3fIZX5gc8VaiLArt53sqwYYYbAhSpnOKtEhvDZSzW2dVloCeZj0g+HdRkPa4a7RKJUt6rl7nJNaTybpJu8g+gclZNioXZeRjMewZ5cZ6ak7NaA19ShWyBpOqqZ+cN+LcJs+VoinCdNT11vx4eIQO3EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748218189; c=relaxed/simple;
	bh=/g0SczXyIfVX9mkzXQivsF8Xy8FhYDetU/bir/b419k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HyRxXf1nRoECj8toup3hBBkm2VyBFlX+5PxG8p3sUXquqWUzbVYoG9aF3sUM3s9Rb98khv8sTeW6FkIqJ5nAbGZhQu3hZxnK22Iyx6a4gDWDyFE3EUmHwQ2M7KGzV76+jpnmbrUSOrE1z5tY/aVuyFzgo4g7Kj5K74QBAzpgQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uJLPN-00AyND-Ep;
	Mon, 26 May 2025 00:09:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Rick Macklem" <rick.macklem@gmail.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Steve Dickson" <steved@redhat.com>,
 "Tom Haynes" <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
In-reply-to: <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com>
References: <>, <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com>
Date: Mon, 26 May 2025 10:09:36 +1000
Message-id: <174821817646.608730.16435329287198176319@noble.neil.brown.name>

On Mon, 26 May 2025, Chuck Lever wrote:
> On 5/20/25 9:20 AM, Chuck Lever wrote:
> > Hiya Rick -
> >=20
> > On 5/19/25 9:44 PM, Rick Macklem wrote:
> >=20
> >> Do you also have some configurable settings for if/how the DNS
> >> field in the client's X.509 cert is checked?
> >> The range is, imho:
> >> - Don't check it at all, so the client can have any IP/DNS name (a mobile
> >>   device). The least secure, but still pretty good, since the ert. verif=
ied.
> >> - DNS matches a wildcard like *.umich.edu for the reverse DNS name for
> >>    the client's IP host address.
> >> - DNS matches exactly what reverse DNS gets for the client's IP host add=
ress.
> >=20
> > I've been told repeatedly that certificate verification must not depend
> > on DNS because DNS can be easily spoofed. To date, the Linux
> > implementation of RPC-with-TLS depends on having the peer's IP address
> > in the certificate's SAN.
> >=20
> > I recognize that tlshd will need to bend a little for clients that use
> > a dynamically allocated IP address, but I haven't looked into it yet.
> > Perhaps client certificates do not need to contain their peer IP
> > address, but server certificates do, in order to enable mounting by IP
> > instead of by hostname.
> >=20
> >=20
> >> Wildcards are discouraged by some RFC, but are still supported by OpenSS=
L.
> >=20
> > I would prefer that we follow the guidance of RFCs where possible,
> > rather than a particular implementation that might have historical
> > reasons to permit a lack of security.
>=20
> Let me follow up on this.
>=20
> We have an open issue against tlshd that has suggested that, rather
> than looking at DNS query results, the NFS server should authorize
> access by looking at the client certificate's CN. The server's
> administrator should be able to specify a list of one or more CN
> wildcards that can be used to authorize access, much in the same way
> that NFSD currently uses netgroups and hostnames per export.
>=20
> So, after validating the client's CA trust chain, an NFS server can
> match the client certificate's CN against its list of authorized CNs,
> and if the client's CN fails to match, fail the handshake (or whatever
> we need to do).
>=20
> I favor this approach over using DNS labels, which are often
> untrustworthy, and IP addresses, which can be dynamically reassigned.
>=20
> What do you think?

I completely agree with this.  IP address and DNS identity of the client
is irrelevant when mTLS is used.  What matters is whether the client has
authority to act as one of the the names given when the filesystem was
exported (e.g. in /etc/exports).  His is exacly what you said.

Ideally it would be more than just the CN.  We want to know both the
domain in which the peer has authority (e.g.  example.com) and the type
of authority (e.g.  serve-web-pages or proxy-file-access or
act-as-neilb).
I don't know internal details of certificates so I don't know if there
is some other field that can say "This peer is authorised to proxy file
access requests for all users in the given domain" or if we need a hack
like exporting to nfs-client.example.com.

But if the admin has full control of what names to export to, it is
possible that the distinction doesn't matter.  I wouldn't want the
certificate used to authenticate my web server to have authority to
access all files on my NFS server just because the same domain name
applies to both.

Thanks,
NeilBrown

