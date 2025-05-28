Return-Path: <linux-nfs+bounces-11940-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E113AC5ECA
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 03:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B560188336A
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 01:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A9C35961;
	Wed, 28 May 2025 01:24:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99310942
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395480; cv=none; b=IVO5NIEohsom0Xl4kEUZISY8x+9FhNyv169wYFGIc73N6PMsxz80KHCL/KShKfpmXFAXacvxatVLOBpuC0NRcgMwljcDrwUJ4z8Xj0MCC50/P9ZcvU6AgFwFoNyPHzKUuiCmeNctEAIunaVNGIeR6dxs0pq9lPbTwPqoWAubRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395480; c=relaxed/simple;
	bh=3Sc5Ix1Orf9pq7x/9M69mH8D7BUMtqibwpL5rALTj7k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=uU6sKUgdVknZlhO5ULdizJTbCFOppFXYSfiyCoFTBuUiLGFx2Z6ye1bxgXadN0eCgYO3isJtZ/XTNgSGNViPIEu4OLqWLvTEM6WuVFKkW2L4qYVq+frn33ItSnLxfyJEE+pdKbfzJruv1ykMzZ3LX4QVKJ/F0YAUWHgMX4nkYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uK5X1-00C9rH-B9;
	Wed, 28 May 2025 01:24:35 +0000
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
Cc: "Benjamin Coddington" <bcodding@redhat.com>,
 "Rick Macklem" <rick.macklem@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Steve Dickson" <steved@redhat.com>, "Tom Haynes" <loghyr@gmail.com>,
 linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
In-reply-to: <e6daff16-2949-4413-b801-58393d9cb993@oracle.com>
References: <>, <e6daff16-2949-4413-b801-58393d9cb993@oracle.com>
Date: Wed, 28 May 2025 11:24:34 +1000
Message-id: <174839547480.608730.18119418768033620929@noble.neil.brown.name>

On Wed, 28 May 2025, Chuck Lever wrote:
> On 5/27/25 3:18 PM, Benjamin Coddington wrote:
> > On 27 May 2025, at 11:05, Chuck Lever wrote:
> >=20
> >> On 5/25/25 8:09 PM, NeilBrown wrote:
> >>> On Mon, 26 May 2025, Chuck Lever wrote:
> >>>> On 5/20/25 9:20 AM, Chuck Lever wrote:
> >>>>> Hiya Rick -
> >>>>>
> >>>>> On 5/19/25 9:44 PM, Rick Macklem wrote:
> >>>>>
> >>>>>> Do you also have some configurable settings for if/how the DNS
> >>>>>> field in the client's X.509 cert is checked?
> >>>>>> The range is, imho:
> >>>>>> - Don't check it at all, so the client can have any IP/DNS name (a m=
obile
> >>>>>>   device). The least secure, but still pretty good, since the ert. v=
erified.
> >>>>>> - DNS matches a wildcard like *.umich.edu for the reverse DNS name f=
or
> >>>>>>    the client's IP host address.
> >>>>>> - DNS matches exactly what reverse DNS gets for the client's IP host=
 address.
> >>>>>
> >>>>> I've been told repeatedly that certificate verification must not depe=
nd
> >>>>> on DNS because DNS can be easily spoofed. To date, the Linux
> >>>>> implementation of RPC-with-TLS depends on having the peer's IP address
> >>>>> in the certificate's SAN.
> >>>>>
> >>>>> I recognize that tlshd will need to bend a little for clients that use
> >>>>> a dynamically allocated IP address, but I haven't looked into it yet.
> >>>>> Perhaps client certificates do not need to contain their peer IP
> >>>>> address, but server certificates do, in order to enable mounting by IP
> >>>>> instead of by hostname.
> >>>>>
> >>>>>
> >>>>>> Wildcards are discouraged by some RFC, but are still supported by Op=
enSSL.
> >>>>>
> >>>>> I would prefer that we follow the guidance of RFCs where possible,
> >>>>> rather than a particular implementation that might have historical
> >>>>> reasons to permit a lack of security.
> >>>>
> >>>> Let me follow up on this.
> >>>>
> >>>> We have an open issue against tlshd that has suggested that, rather
> >>>> than looking at DNS query results, the NFS server should authorize
> >>>> access by looking at the client certificate's CN. The server's
> >>>> administrator should be able to specify a list of one or more CN
> >>>> wildcards that can be used to authorize access, much in the same way
> >>>> that NFSD currently uses netgroups and hostnames per export.
> >>>>
> >>>> So, after validating the client's CA trust chain, an NFS server can
> >>>> match the client certificate's CN against its list of authorized CNs,
> >>>> and if the client's CN fails to match, fail the handshake (or whatever
> >>>> we need to do).
> >>>>
> >>>> I favor this approach over using DNS labels, which are often
> >>>> untrustworthy, and IP addresses, which can be dynamically reassigned.
> >>>>
> >>>> What do you think?
> >>>
> >>> I completely agree with this.  IP address and DNS identity of the client
> >>> is irrelevant when mTLS is used.  What matters is whether the client has
> >>> authority to act as one of the the names given when the filesystem was
> >>> exported (e.g. in /etc/exports).  His is exacly what you said.
> >>>
> >>> Ideally it would be more than just the CN.  We want to know both the
> >>> domain in which the peer has authority (e.g.  example.com) and the type
> >>> of authority (e.g.  serve-web-pages or proxy-file-access or
> >>> act-as-neilb).
> >>> I don't know internal details of certificates so I don't know if there
> >>> is some other field that can say "This peer is authorised to proxy file
> >>> access requests for all users in the given domain" or if we need a hack
> >>> like exporting to nfs-client.example.com.
> >>>
> >>> But if the admin has full control of what names to export to, it is
> >>> possible that the distinction doesn't matter.  I wouldn't want the
> >>> certificate used to authenticate my web server to have authority to
> >>> access all files on my NFS server just because the same domain name
> >>> applies to both.
> >>
> >> My thought is that, for each handshake, there would be two stages:
> >>
> >> 1. Does the NFS server trust the certificate? This is purely a chain-of-
> >>    trust issue, so validating the certificate presented by the client is
> >>    the order of the day.
> >>
> >> 2. Does the NFS server authorize this client to access the export? This
> >>    is a check very similar to the hostname/netgroup/IP address check
> >>    that is done today, but it could be done just once at handshake time.
> >>    Match the certificate's fields against a per-export filter.
> >>
> >> I would take tlshd out of the picture for stage 2, and let NFSD make its
> >> own authorization decisions. Because an NFS client might be authorized
> >> to access some exports but not others.
> >>
> >> So:
> >>
> >> How does the server indicate to clients that yes, your cert is trusted,
> >> but no, you are not authorized to access this file system? I guess that
> >> is an NFS error like NFSERR_STALE or NFS4ERR_WRONGSEC.
> >>
> >> What certificate fields should we implement matches for? CN is obvious.
> >> But what about SAN? Any others? I say start with only CN, but I'd like
> >> to think about ways to make it possible to match against other fields in
> >> the future.
> >>
> >> What would the administrative interface look like? Could be the machine
> >> name in /etc/exports, for instance:
> >>
> >> *,OU=3D"NFS Bake-a-thon",*   rw,sec=3Dsys,xprtsec=3Dmtls,fsid=3D42
> >>
> >> But I worry that will not be flexible enough. A more general filter
> >> mechanism might need something like the ini file format used to create
> >> CSRs.
> >=20
> > It might be useful to make the kernel's authorization based on mapping to=
 a
> > keyword that tlshd passes back after the handshake, and keep the more
> > complicated logic of parsing certificate fields and using config files up=
 in
> > ktls-utils userspace.
>=20
> I agree that the kernel can't do the filtering.
>=20
> But it's not possible that tlshd knows what export the client wants to
> access during the TLS handshake; no NFS traffic has been exchanged yet.
> Thus parsing per-export security settings during the handshake is not
> possible; it can happen only once tlshd passes the connected socket back
> to the kernel.
>=20
> And remember that ktls-utils is shared with NVMe and now QUIC as well.
> tlshd doesn't know anything about the upper layer protocols. Therefore
> adding NFS-specific authorization policy settings to ktls-utils is a
> layering violation.
>=20
> What makes the most sense is that the handshake succeeds, then NFSD
> permits the client to access any export resources that the server's
> per-export security policy allows, based on the client's cert.

We certainly need a mapping between content of the certificate and an
"auth_domain" as understood by net/sunrpc, then a mapping from
auth_domain and filesystem to export options - we already have the
latter.

There seem to be two option for the first mapping.
1/ tlshd can pass the "important" parts of the certificate (and the PSK
  info) to the sunrpc module much as the IP layer currently passes the IP
  address and port number to the sunrpc module.  sunrpc then passes this up to
  mountd which does whatever mapping magic we want and passes down an
  auth_domain which is then used for further lookup.

2/ tlshd can do some initial interpretation of the certificate (and PSK)
  and determine one or more tags which serve to sufficiently classify the
  certificate for local needs.  It passes them to sunrpc and thence to
  mountd which gives relevant details to nfsd.

So the core question is: what sort of info do we want to pass from tlshd
to mountd (via sunrpc) and where is the processing easiest.  Or maybe:
which part of the processing can usefully be shared with other clients
of tlshd and which are truly nfsd-specific?

I'd be inclined to keep as much understanding of the various details of
certificates in tlshd as possible.  It has to deal with some of that
complexity, and mountd really doesn't.

>=20
>=20
> > I'm imagining something like this in /etc/exports:
> >=20
> > /exports *(rw,sec=3Dsys,xprtsec=3Dmtls,tlsauth=3Dany)
> > /exports/home *(rw,sec=3Dsys,xprtsec=3Dmtls,tlsauth=3Dusers)
> >=20
> > .. and then tlshd would do the work to create a map of authorized
> > certificate identities mapped to a keyword, something like:
> >=20
> > CN=3D*                any
> > CN=3D*.nfsv4bat.org   users
> > SHA1=3D4EB6D578499B1CCF5F581EAD56BE3D9B6744A5E5   bob
>=20
> I think mountd is going to have to do that, somehow. It already knows
> about netgroups, for example, and this is very similar.

netgroups is a good example.  mountd knows what a netgroup is but
doesn't really know about the internal details.  There is a function
"innetgr()" which it calls to do the required magic.  We similarly want
a simple way for mountd to know that a given certificate matches a given
tlsgroup.  A library function would be OK.  strcmp would be good too.

We export to a netgroups as:=20
        /path @netgroup(options)
could we export to a certificate as
        /path &tlsgroup(options)
??

It's always seems weird to me have the "sec=3D" in the options list.
The authentication bit comes before the options.  An IP address or
hostname meand AUTH_SYS. A krb5 indicator means krb5 etc....=20
But that isn't the way we went .... unfortunately??

Thanks,
NeilBrown


>=20
>=20
> > I imagine more flexible or complex rule logic might be desired in the
> > future, and having that work land in ktls-utils would be nicer than having
> > to do kernel work or handling various bits of certificate logic or reverse
> > lookups in-kernel.
>=20
> I agree that the kernel will have to be hands off (or, it will act as a
> pipe between the user space pieces that actually handle the security
> policy, if you will).
>=20
>=20
> --=20
> Chuck Lever
>=20


