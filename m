Return-Path: <linux-nfs+bounces-12893-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4ACAF8998
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 09:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB42B17F693
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 07:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB3275B02;
	Fri,  4 Jul 2025 07:35:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6746260572;
	Fri,  4 Jul 2025 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614520; cv=none; b=qeZ8vX6zjQ4wGPTlhaI5lD+LNtEiyWHOWBzE8625nAbQFgH75fihBvxhlaySn+tNTljNUYtUe+Cm6+ZlARJhFJT+zZAiPwIu3K/uauMxVc9HqQDLxBrrk9fczWjcxL/fgcvwQ5syejNlAkOSEuycharGT1A2tkijpG7YLjtR+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614520; c=relaxed/simple;
	bh=J22onrbDL63ztIzfTyZRwTuoB/+v29eZAD1UlVeYANE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JoaRmib1RamI9W6nCGZKcYZsWyqc4ItBAtIyMx3rF9AsKsCuVGgBgHF6dO0vJCl7ChNUYh3Iz/7+So5sKUNIc21Yo8k4nOdzCBUw4HhCqvqY5jZ/z8pGNYb9m642beiwJgtJxwvLUI+tCt0Bi5u4iBgG1/3W2vNWpiF9QiFa0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uXawj-001kVS-O2;
	Fri, 04 Jul 2025 07:34:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH RFC 0/2] nfsd: issue POSIX_FADV_DONTNEED after READ/WRITE/COMMIT
In-reply-to: <c7268db3-ee38-425a-b524-da38cceb02ff@oracle.com>
References: <>, <c7268db3-ee38-425a-b524-da38cceb02ff@oracle.com>
Date: Fri, 04 Jul 2025 17:34:49 +1000
Message-id: <175161448993.565058.9950023351466537449@noble.neil.brown.name>

On Fri, 04 Jul 2025, Chuck Lever wrote:
> On 7/3/25 7:16 PM, NeilBrown wrote:
> > On Fri, 04 Jul 2025, Jeff Layton wrote:
> >> Chuck and I were discussing RWF_DONTCACHE and he suggested that this
> >> might be an alternate approach. My main gripe with DONTCACHE was that it
> >> kicks off writeback after every WRITE operation. With NFS, we generally
> >> get a COMMIT operation at some point. Allowing us to batch up writes
> >> until that point has traditionally been considered better for
> >> performance.
> > 
> > I wonder if that traditional consideration is justified, give your
> > subsequent results.  The addition of COMMIT in v3 allowed us to both:
> >  - delay kicking off writes
> >  - not wait for writes to complete
> > 
> > I think the second was always primary.  Maybe we didn't consider the
> > value of the first enough.
> > Obviously the client caches writes and delays the start of writeback.
> > Adding another delay on the serve side does not seem to have a clear
> > justification.  Maybe we *should* kick-off writeback immediately.  There
> > would still be opportunity for subsequent WRITE requests to be merged
> > into the writeback queue.
> 
> Dave Chinner had the same thought a while back. So I've experimented
> with starting writes as part of nfsd_write(). Kicking off writes,
> even without waiting, is actually pretty costly, and it resulted in
> worse performance.

Was this with filemap_fdatawrite_range_kick() or something else?

> 
> Now that .pc_release is called /after/ the WRITE response has been sent,
> though, that might be a place where kicking off writeback could be done
> without charging that latency to the client.

Certainly after is better.  I was imagining kicking the writeback
threads, but they seems to only do whole filesystems.  Maybe that is OK?

I doubt we want more than one thread kicking off write for any given
inode at a time.  Maybe it would be best to add a "kicking_write" flag
in the filecache and if it is already set, then just add the range to
some range of pending-writes.  Maybe.
I guess I should explore how to test :-)

NeilBrown

