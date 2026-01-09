Return-Path: <linux-nfs+bounces-17675-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2CFD06AE8
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 02:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD5C2301D0F1
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 01:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FB81A23A4;
	Fri,  9 Jan 2026 01:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJYhCf1g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AE719DFAB
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920852; cv=none; b=B1MtVkenig9b9LQ/T70/7ZXUNt1BJKIceASQubrTqjUJTbD/1a/BtCDIutuXKpnBo4F0Gubl9FvkFo/CAEwt3UuGWt8h207zUN636/rH/ss1ppI32bqdLL+4PVeQA09CSUKlPV0nS7zB62/yL4cFnxOZ/J8mXJXHM5X5PJGcrf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920852; c=relaxed/simple;
	bh=TnVmwvugLE/+GZ9c9UacQ37HOh0gjfyTWGh1IF3Cvzo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gd9JDxcGzmqN8g1/THIW0WRC3+oEw/GJrfUIQfcgZFaxAXL96mJeC5GSbmZBNxzc8/kDZdsA8olDCA8AG4gE7ZIjONOIH/tD+qQv4+qPJBWiwDEAFNTjLhcww6wKT7y4vhZaTJhQFd21WucN6THVb8ouuZvcKcO2dnHJJ29PkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJYhCf1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2F8C116C6;
	Fri,  9 Jan 2026 01:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767920851;
	bh=TnVmwvugLE/+GZ9c9UacQ37HOh0gjfyTWGh1IF3Cvzo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=oJYhCf1gLlPMEOsjYqmSWnlFi/T8JrxUx8FSyolJivQAgbHGE0Z9puL1rBISRUd56
	 kIvBCIIuxrqjtTG4OyL9dxrXdapo+RS5JDFD3/R92rIJxk6K3435B778O3gmr2n6//
	 Coun/+yKbfX8m2M2CFzug0uiSyELXy4NSY0iyAkIHHsHirlbOsuNNz8uKpcXktpolt
	 xpTqDBKRbZp7taNDH9Zua7TUmolf3dYh220YxkfO+kYCOwl1SGxVvi5UnVsv5o9N0S
	 UYPa+jqbGnOxeD2FS6XZBKrZhLacUVankpaJjloyeapHOUhzhTSlP63AbwMM3WnJbf
	 1nOQQa5lKl0SQ==
Message-ID: <8598e161ce18337022eefce71e7b8d35753cc735.camel@kernel.org>
Subject: Re: add a LRU for delegations
From: Trond Myklebust <trondmy@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <cel@kernel.org>, 
 Christoph Hellwig
	 <hch@lst.de>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Date: Thu, 08 Jan 2026 20:07:30 -0500
In-Reply-To: <5ae5ed3a-5351-4dc1-98e4-0f31653ee2b6@grimberg.me>
References: <20260107072720.1744129-1-hch@lst.de>
	 <0b0b21c1-0bfd-4e2e-9deb-f368a66f5e9c@app.fastmail.com>
	 <20260107162202.GA23066@lst.de>
	 <ea31c230-1ace-4721-872e-2313b497214f@grimberg.me>
	 <45ba87f3-2322-424b-95b1-9129a2537545@app.fastmail.com>
	 <5ae5ed3a-5351-4dc1-98e4-0f31653ee2b6@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-09 at 02:30 +0200, Sagi Grimberg wrote:
>=20
>=20
> On 08/01/2026 16:34, Chuck Lever wrote:
> >=20
> > On Wed, Jan 7, 2026, at 2:22 PM, Sagi Grimberg wrote:
> > > And, in general, I think that the server is in a much better
> > > position
> > > to solicit preemptive delegation recalls as opposed
> > > to the client voluntarily return delegations when crossing a
> > > somewhat
> > > arbitrary delegation_watermark.
> > The server and client have orthogonal interests here, IMO.
>=20
> They both share the interest of reducing rpc calls...
>=20
> >=20
> > The server is concerned with resource utilization -- memory
> > consumed,
> > slots in tables, and so on -- that other active clients might
> > benefit
> > from having freed. The server doesn't really care which delegations
> > are returned.
> >=20
> > A client wants to keep delegation state that applications are
> > using,
> > and it knows best which ones those are. It can identify specific
> > delegations that are not being actively used and return those.
>=20
> Yes, I agree to some extent. However arguably the client may want
> keep=20
> delegation
> states around for as long as it can "just in case" the application
> opens=20
> the file again (the client
> doesn't know the nature of the workload) assuming they fit in client=20
> memory. It doesn't know
> anything about other clients nor the server resources.
>=20
> The server on the other hand, has the knowledge of what delegations=20
> conflict (or may conflict)
> and act accordingly (not grant or recall).

You can't just assume this: it really depends heavily on the workload.
Imagine an 'rm -rf' operation if you have to recall delegations from
various clients on all the files in the tree because they are caching
read delegations 'just in case'.

The current behaviour is based on the assumption that if your
application has not locally reopened the file for several minutes, then
that RPC call to reopen it on the server is by comparison not
particularly expensive.
Yes, there are some exceptions to that rule too, but by and large it is
a reasonable expectation, particularly so since the clients can all
still cache the file data for as long as the change attribute remains
the same. Any attempts to change the file would in any case trigger
delegation recalls, with delays to the writer while the server waits
for those recalls to complete.

IOW: Before agreeing to change the delegation expiration times, I'd
like to see actual data that justifies caching for longer as a general
rule, rather than just relying on peoples' assumptions that this is the
case.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

