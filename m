Return-Path: <linux-nfs+bounces-4113-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5267090F95C
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 00:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA6328199D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 22:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A2E77F10;
	Wed, 19 Jun 2024 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atOrr1uq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A85763EE
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837193; cv=none; b=b+7/sPyTQucgQaLyEtugHwYtBcAaGlXAfYvKGz6ZCIyabhCcnETUi9/s3XoU9w6dIRRV6wPRDj+qM0bLFnoi2ewEq719OjotWiy3cx/29sUozqUmM12ZKghLh+kd8MEGP7lq5P8kDrlIXB2X87hzXucjc5Rn5/qd1yXgdH9d0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837193; c=relaxed/simple;
	bh=7yvowPv00rg79u+sHhtwCcCrSvoibL3NycUMR5+PXxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi29/XTDj5VjoNlSAmFOkBDTWSs1UI7jRxGinX6St6nQDqpyB1J37VPAYvel6K/L6Zr87hpgcus30pfCmH1g5JZO+z+g1VYqgmwkXXLvi0M91B2+Fz/VW+gWUdAeX+h1PYtooBiCbi2jYV9lf5/xGDkyzHi8IE6PYLV5EvdqJiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atOrr1uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045F9C2BBFC;
	Wed, 19 Jun 2024 22:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718837193;
	bh=7yvowPv00rg79u+sHhtwCcCrSvoibL3NycUMR5+PXxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atOrr1uqzReb74S7UAD5CFm7C66whSiCoUTmcRqUrfccdlg91dL4AfPErkPebqmWs
	 +6acGoR/3ABkIMkxXk55ymVcM0C3zfGK8+XEuYvupyjzShtbc+nrJ2r8LVgElic8p7
	 LktJAcEzRLIoggmU4pV4FByl5S5qoZiijnRw2Z+J3+Gx2z7BU4Xh0GMGaGWZ8GfBSY
	 tGS7SdSHcHZSvwtk3BR2zfAMrIzZLkWo/eH8BdTd+Wv+epnTphjR1oWDAKeZ6ujoss
	 ewxZWOX0hNXc6j5kF9z0woM/u2oJphoCkXxAq/vqj6M4YwldACTYdCNRTgg5LPn636
	 5P1DXFPepOlUA==
Date: Wed, 19 Jun 2024 18:46:32 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v5 00/19] nfs/nfsd: add support for localio
Message-ID: <ZnNfyNkzOcoVnHL5@kernel.org>
References: <>
 <23aa79999595e0ec5af04795be315de73ec5cfe0.camel@kernel.org>
 <171883136311.14261.10658469664795186377@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171883136311.14261.10658469664795186377@noble.neil.brown.name>

On Thu, Jun 20, 2024 at 07:09:23AM +1000, NeilBrown wrote:
> On Wed, 19 Jun 2024, Jeff Layton wrote:
> > On Wed, 2024-06-19 at 17:10 +1000, NeilBrown wrote:
> > > On Wed, 19 Jun 2024, Christoph Hellwig wrote:
> > > > What happened to the requirement that all protocol extensions added
> > > > to Linux need to be standardized in IETF RFCs?
> > > > 
> > > > 
> > > 
> > > Is that requirement documented somewhere?  Not that I doubt it, but it
> > > would be nice to know where it is explicit.  I couldn't quickly find
> > > anything in Documentation/
> > > 
> > > Can we get by without the LOCALIO protocol?
> > > 
> > > For NFSv4.1 we could use the server_owner4 returned by EXCHANGE_ID.  It
> > > is explicitly documented as being usable to determine if two servers are
> > > the same.
> > > 
> > > For NFSv4.0 ... I don't think we should encourage that to be used.
> > > 
> > > For NFSv3 it is harder.  I'm not as ready to deprecate it as I am for
> > > 4.0.  There is nothing in NFSv3 or MOUNT or NLM that is comparable to
> > > server_owner4.  If krb5 was used there would probably be a server
> > > identity in there that could be used.
> > > I think the server could theoretically return an AUTH_SYS verifier in
> > > each RPC reply and that could be used to identify the server.  I'm not
> > > sure that is a good idea though.
> > > 
> > 
> > My idea for v3 was that the localio client could do an O_TMPFILE create
> > on the exported fs and write some random junk to it (a uuid or
> > something). Construct the filehandle for that and then the client could
> > try to issue a READ for that filehandle via the NFS server. If it finds
> > that filehandle and the contents are correct then you're on the same
> > host. Then you just close the file and it should clean itself up.
> 
> I can't see how this would work, but maybe I don't have a good enough
> imagination.
> 
> The high-level view of the proposed protocol is:
>   - client asks remote server to identify itself.
>   - server returns an identity
>   - client uses local-sideband to ask each local server if it has the
>     given identity.
> 
> I don't see where an O_TMPFILE could fit into this, or how a different
> high-level approach would be any better.
> 
> For NFSv3 the client could ask with a new Program or Version or
> Procedure, or all three.  Or it could ask with a new file-handle or path
> name.  I imagine using a webnfs (rfc2054) multi-component lookup on the
> public filehandle for "/linux/config/server-id" and getting back a
> filehandle which encodes the server ID somehow.  All these seem credible
> options and it is not clear than any one is better than any other.
> 
> For NFSv4.1 I think that LOCALIO looks a lot like trunking and so using
> exactly the same mechanism to determine if two servers are the same is a
> good idea.
> But then LOCALIO also looks a lot like a new pNFS/DS protocol so maybe
> we should specify that protocol and use GETDEVICELIST or GETDEVICEINFO
> to find the identity of the server.

Easy enough to switch the RPC call used.  If either GETDEVICELIST or
GETDEVICEINFO can convey a UUID it sounds fine to me.  But for v4
EXCHANGE_ID already exists.

> > This is a little less straightforward and efficient than the localio
> > protocol that Mike is proposing, but requires no protocol extensions.
> 
> I think that if we use anything other than the server-id in the
> EXCHANGE_ID response, then we are defining a new protocol as it is a new
> request which we expect existing servers to ignore or fail, even though
> they have never been tested to ignore/fail that particular request.
> 
> Of all the options I would guess that a new version for an existing
> protocol would be safest as that is the most likely to have been tested.
> A new RPC program is probably conceptually simplest.  A little hack in
> LOOKUPv3 to detect the public filehandle etc is probably the easiest to
> code, and a new pnfs/ds protocol is probably the cleanest overall
> except that it doesn't support NFSv3.

NFSv3 support is pretty important. So when faced with no options for
v3, I decided to implement LOCALIO (with Trond's encouragement) and
just have both NFS versions use it.

I _can_ frame the v4 support in terms of EXCHANGE_ID (and have already
implemented it before writing LOCALIO, patches aren't on the internet
but I can unearth that work if needed).  But I'd still maintain the
nfsd_uuids list, and have nfs_localio's nfsd_uuid_is_local() lookup
the UUID that was embedded in the v4 EXCHANGE_ID payload...

But yes, we'd still need LOCALIO's GETUUID rpc for v3.  So EXCHANGE_ID
really doesn't buy much (because we'd still need an IANA registered
rpc program number).

> My purpose in all this is not to replace Mike's LOCALIO protocol, but to
> explore the solution space to ensure there is nothing that is obviously
> better.  As yet, I don't think there is.

Thanks, I really appreciate your professionalism and attention to
detail.  Pleasure working with you again Neil!

Mike

