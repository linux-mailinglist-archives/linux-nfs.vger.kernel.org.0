Return-Path: <linux-nfs+bounces-18164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD08FD3C542
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 11:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 331E04AAA16
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 10:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5AC3ECBC9;
	Tue, 20 Jan 2026 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1VJUoDT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3488833A9D4;
	Tue, 20 Jan 2026 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904465; cv=none; b=YILI6cILRslMpNVqGsGXjZksoV01icoAjEbVJRsMoVj9JmxwlNxjy4gMqwO1ZQkB+rsLCDPrpP5iVZr+A8LeimAJmkfon8GKnpwvtUSkRhIP51oSkyOngj3EWiFB5ovRnI1RPKXO79nDOAbxSxLurYVziF4ZWA5RcuaJnBZyYpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904465; c=relaxed/simple;
	bh=E5xOvww2YbwFgWAJy3KVLziGMsctGa0Tjs9kastx5yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPYTkZAEE15rlojP3qQW8gZ4L1rSlc6Zy7QO9g4O+Kcf7CiXWnRFFxrTkqtiXJJ3qnlna3t99Z4Yyz762W+NCygnQo9nJgercOwbPAi13AnvRdwQCRejnEfBkJGDDLAz8PfOIp7VaC4wyajCG94MzHvo3zTn/QRT4xWQaZKpjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1VJUoDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D04C16AAE;
	Tue, 20 Jan 2026 10:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768904463;
	bh=E5xOvww2YbwFgWAJy3KVLziGMsctGa0Tjs9kastx5yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1VJUoDTE1bE4Axag2MVvCjZi3r3nQzWpAiQ9pDGyo0sT1kLEez8SxjJA0+W7GZR2
	 V5YDMRac/SRcvQhLgXtiSpTTy+Y+6KwKcUePNdU3l3VIPeWkRflL0On5H7JgnSBCVi
	 bhHLMKxmmoOVWNLHR9NDC0PK0yECWuTxNH+IAbgD+56K4WQuXEevgg2GAOQJ9vLlCH
	 c8SFVqfXZ5SelWF7ZE5iPDwIx9mKUHaxV2alJCPRxY7wAxpvIejQC3q3yqF0yNObbG
	 WJpV9jEBSZ0iheGUF1G6ZpjKzos9QxsQvxnThJ/w5cDFBqlHkoIwXn0DtH1kUhI1PV
	 h8y6DL4dovYpw==
Date: Tue, 20 Jan 2026 11:20:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Benjamin Coddington <bcodding@hammerspace.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
Message-ID: <20260120-irrelevant-zeilen-b3c40a8e6c30@brauner>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <20260119-reingehen-gelitten-a5e364f704fa@brauner>
 <176885678653.16766.8436118850581649792@noble.neil.brown.name>
 <20260120-tratsch-luftfahrt-d447fdd12c10@brauner>
 <176890236169.16766.7338555258291967939@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176890236169.16766.7338555258291967939@noble.neil.brown.name>

On Tue, Jan 20, 2026 at 08:46:01PM +1100, NeilBrown wrote:
> On Tue, 20 Jan 2026, Christian Brauner wrote:
> > > You don't need signing to ensure a filehandle doesn't persist across
> > > reboot.  For that you just need a generation number.  Storing a random
> > > number generated at boot time in the filehandle would be a good solution.
> > 
> > For pidfs I went with the 64-bit inode number. But I dislike the
> > generation number thing. If I would have to freedom to completely redo
> > it I would probably assign a uuid to the pidfs sb and then use that in
> > the file handles alongside the inode number. That would be enough for
> > sure as the uuid would change on each boot.
> 
> What you are calling a "uuid" in "the pidfs sb" is exactly what I am
> calling a "generation number" - for pidfs it would be a "generation

"generation number" just evokes the 32-bit identifier in struct inode
that's overall somewhat useless. And a UUID has much stronger
guarantees.

> number" for the whole filesystem, while for ext4 etc it is a generation
> number of the inode number.
> 
> So we are substantially in agreement.

Great!

> 
> Why do you not have freedom to add a uuid to the pidfs sb and to the
> filehandles now?

Userspace relies on the current format to get the inode number from the
file handle:
https://github.com/systemd/systemd/blob/main/src/basic/pidfd-util.c#L233-L281

And they often also construct them in userspace. That needs to continue
to work. I also don't think it's that critical.

