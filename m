Return-Path: <linux-nfs+bounces-11902-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D03AC37FD
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 04:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A36AD7A5303
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 02:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8FE14F9D6;
	Mon, 26 May 2025 02:29:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85347260F
	for <linux-nfs@vger.kernel.org>; Mon, 26 May 2025 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748226583; cv=none; b=eIEjkTGiJAC5HUuozDyXzRbA4vr6Yu8DPy+a8yCd22Acgm+P2o9ryeri1o8qRucBlRIZYi3JzhvL6rhpFOSPJIx/fX52Etqdq0VzDA/QGVOKZxBTTfi/kqVpkdE7zGEWiVfWnpkdVj/D4hVxTHIo+JL0vxs7BeV9NP64Djrz5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748226583; c=relaxed/simple;
	bh=BmvM+72rF4HN7oNk8GIlMLEai20/zWFjN6NhDAyVGdQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=KRbHZy/So8GrnCqr9rSzWPsJiqPZU7s+wpDLMwLDER8RWDGLnEgvStlnAjv0j1JswvYBooeNT7vHcVC5fLXuT7GIGkWcNYicN8XETRXcboIserZWyYuJMOefThu7eFRdbVkw66Mi2uhDY650qaqWsinZ2ji9KpaQuc+0YeXOK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uJNar-00B2OK-44;
	Mon, 26 May 2025 02:29:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Rick Macklem" <rick.macklem@gmail.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Steve Dickson" <steved@redhat.com>, "Tom Haynes" <loghyr@gmail.com>,
 linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
In-reply-to:
 <CAM5tNy6ZJwSV9tmsyPHDjp3rLVFw6=dhs3ojxORqLNNnurGtFQ@mail.gmail.com>
References:
 <>, <CAM5tNy6ZJwSV9tmsyPHDjp3rLVFw6=dhs3ojxORqLNNnurGtFQ@mail.gmail.com>
Date: Mon, 26 May 2025 12:29:36 +1000
Message-id: <174822657684.608730.17929019810730634619@noble.neil.brown.name>

On Mon, 26 May 2025, Rick Macklem wrote:
> On Sun, May 25, 2025 at 5:09=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
> >
> > On Mon, 26 May 2025, Chuck Lever wrote:
> > > On 5/20/25 9:20 AM, Chuck Lever wrote:
> > > > Hiya Rick -
> > > >
> > > > On 5/19/25 9:44 PM, Rick Macklem wrote:
> > > >
> > > >> Do you also have some configurable settings for if/how the DNS
> > > >> field in the client's X.509 cert is checked?
> > > >> The range is, imho:
> > > >> - Don't check it at all, so the client can have any IP/DNS name (a m=
obile
> > > >>   device). The least secure, but still pretty good, since the ert. v=
erified.
> > > >> - DNS matches a wildcard like *.umich.edu for the reverse DNS name f=
or
> > > >>    the client's IP host address.
> > > >> - DNS matches exactly what reverse DNS gets for the client's IP host=
 address.
> > > >
> > > > I've been told repeatedly that certificate verification must not depe=
nd
> > > > on DNS because DNS can be easily spoofed. To date, the Linux
> > > > implementation of RPC-with-TLS depends on having the peer's IP address
> > > > in the certificate's SAN.
> > > >
> > > > I recognize that tlshd will need to bend a little for clients that use
> > > > a dynamically allocated IP address, but I haven't looked into it yet.
> > > > Perhaps client certificates do not need to contain their peer IP
> > > > address, but server certificates do, in order to enable mounting by IP
> > > > instead of by hostname.
> > > >
> > > >
> > > >> Wildcards are discouraged by some RFC, but are still supported by Op=
enSSL.
> > > >
> > > > I would prefer that we follow the guidance of RFCs where possible,
> > > > rather than a particular implementation that might have historical
> > > > reasons to permit a lack of security.
> > >
> > > Let me follow up on this.
> > >
> > > We have an open issue against tlshd that has suggested that, rather
> > > than looking at DNS query results, the NFS server should authorize
> > > access by looking at the client certificate's CN. The server's
> > > administrator should be able to specify a list of one or more CN
> > > wildcards that can be used to authorize access, much in the same way
> > > that NFSD currently uses netgroups and hostnames per export.
> > >
> > > So, after validating the client's CA trust chain, an NFS server can
> > > match the client certificate's CN against its list of authorized CNs,
> > > and if the client's CN fails to match, fail the handshake (or whatever
> > > we need to do).
> > >
> > > I favor this approach over using DNS labels, which are often
> > > untrustworthy, and IP addresses, which can be dynamically reassigned.
> > >
> > > What do you think?
> >
> > I completely agree with this.  IP address and DNS identity of the client
> > is irrelevant when mTLS is used.  What matters is whether the client has
> > authority to act as one of the the names given when the filesystem was
> > exported (e.g. in /etc/exports).  His is exacly what you said.
> Well, what happens when someone naughty copies the cert. to a different
> system?

Then you have already lost.  Certificates are like passwords.

I guess 2FA is a thing and maybe it makes sense to check both IP and
certificate.  But I certainly wouldn't want to trust only that the IP
matches the certificate.  I would want to be able to check the
certificate without even considering the IP.
Maybe:
 1/ Is the IP from a permitted subnet - if not, reject.
 2/ is the certificate for an approved CN - if not, reject.
 3/ Does the IP match the CN

1 and 3 could be optional.  2 shouldn't be.

Thanks,
NeilBrown

