Return-Path: <linux-nfs+bounces-13050-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AEBB04101
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162F116B2D6
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98B2220F37;
	Mon, 14 Jul 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkVD7L1n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985AA250BEC
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502129; cv=none; b=hWk0Qn7skc7fNXKvNk5b0FVOOXrqELaIKJp6G4im+QiyvVBMOZOw6ArM7cLv4RS2g7IwaRRpQJVl4xlXRhVhmvoCxkSakeA64nsV2t3d7zq5KMQ3AXtrpmCThIqxS3jYX9hZOQP0aHl1pp/S46P8gWqh8K8FALWroJKzA+yMUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502129; c=relaxed/simple;
	bh=WhkJJLa67xe+oOtYbF79AEllvACuw+AI1zXnmAswAnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4stmH1PP4/kSqCp7suq/Q0iTRv3Fm/qMwbH3r56QZoL5MZ4GD7UInVxFdl2cx1sAocFjPm5R+Bl5BgHRNStIDnAVay0g3c7OxOClwlorgwr93jRBfLMfQozF+dVKGcaWN5DtS1jBzoolk4x3SR2AClllfI/NSweTQDrt8zv/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkVD7L1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0E9C4CEF0;
	Mon, 14 Jul 2025 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752502129;
	bh=WhkJJLa67xe+oOtYbF79AEllvACuw+AI1zXnmAswAnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkVD7L1nKxOiKNt1dspvLKbfRwbbZ0bfHpAl9pbkxBdP1551AZVTxbSdRHMo4oF6+
	 pqvag72DsWbVkr0XqIPEI40ZlFXlAzuhOhxDzPN3zq8tzXRvyPAVK6ttc7UQg/iaNA
	 BzP8bkS6lLPdNbjd4gurynZI7zPHkMq+h5GnAe6m6fOucBRcQUTg8GXRg6jM6nTdyy
	 w6MqaFtdKOvGmqVWFyqhoJmlZYjV0ky0ZsZUKgf6QqrTeQ2okpm41JCSZJ+eoBI9BA
	 O0T4IPEfdi6mTZyT5XrWR9JbyNoe44A4dcQXaiCBEqQjvOlVKqQq3QHFPQe7qFVlaY
	 SrWJYW8hwubOA==
Date: Mon, 14 Jul 2025 10:08:46 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [for-6.16-final PATCH 9/9] nfs/localio: add localio_async_probe
 modparm
Message-ID: <aHUPbnWDlacUFGuP@kernel.org>
References: <20250714031359.10192-1-snitzer@kernel.org>
 <20250714031359.10192-10-snitzer@kernel.org>
 <175246700631.2234665.18042187680516755344@noble.neil.brown.name>
 <579139f6eaaf3f807991e041f509db14d2ffc721.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <579139f6eaaf3f807991e041f509db14d2ffc721.camel@kernel.org>

On Mon, Jul 14, 2025 at 08:28:22AM -0400, Jeff Layton wrote:
> On Mon, 2025-07-14 at 14:23 +1000, NeilBrown wrote:
> > On Mon, 14 Jul 2025, Mike Snitzer wrote:
> > > From: Mike Snitzer <snitzer@hammerspace.com>
> > > 
> > > This knob influences the LOCALIO handshake so that it happens
> > > synchronously upon NFS client creation.. which reduces the window of
> > > opportunity for a bunch of IO to flood page cache and send out over to
> > > NFSD before LOCALIO handshake negotiates that the client and server
> > > are local.  The knob is:
> > >   echo N > /sys/module/nfs/parameters/localio_async_probe
> > 
> > I understand why you are adding this but ....  yuck.  Tuning knobs are
> > best avoided.
> > 
> > Maybe we could still do the probe async, but in mount wait for 200ms,
> > or for the probe to get a reply.   That should make everyone happy.
> > 
> > NeilBrown
> > 
> 
> Agreed. I'd prefer to not need a tuning knob for this. Doing a short
> wait in the mount for localio negotiation would be a lot more
> reasonable.

OK.

> That said, why is the LOCALIO negotiation taking so long? Shouldn't
> that be basically instantaneous during the mount? Do we really have
> applications that are hammering reads and writes just after the mount
> returns but before the localio negotiation completes?

Yes, buffered IO in particular brings the hammer via a storm of page
cache IO that takes a while to be complete before LOCALIO ever gets an
opportunity to service NFS client IO.

Mike

