Return-Path: <linux-nfs+bounces-5901-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F11AE9636E5
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 02:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933421F23AAF
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 00:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE25C125;
	Thu, 29 Aug 2024 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsnAcXKZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0FDDC5;
	Thu, 29 Aug 2024 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724891413; cv=none; b=J/wm729bzZ02atKwiFIdrVyXQjX7lgBr3tTB/utQdRvnKZS5UydE0qZ01RhMjkIwS+itZhV/Z5hicXFG+z4ihlxdtkmTbNdVhFKywH2APvJKPZWQ82mtoo02Yhj+9Qcy9fih+0kgB2bXJgqeWYPiIUBkVzfoVpGz73IHnc1gOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724891413; c=relaxed/simple;
	bh=5BaSTKCGeoYXxKbl8H2007adXY8sJdQfF5NDgHn4OOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdIQQ3kCrF181sfs7+oIKzGwfimzNHBpMuOeMqZ9MUc9BoiKoC6dG2q2QnckqhWFXUgpS61uLW4XwOKpKg3oaAmErRGT/8rzQH5E7M5O0/Ws2T/as2qt/WnxfG1aAlahP7CjSFQti17UpzekoR+L/SW9HfRXc4vwjTlntaESbdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsnAcXKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69CFC4CEC0;
	Thu, 29 Aug 2024 00:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724891412;
	bh=5BaSTKCGeoYXxKbl8H2007adXY8sJdQfF5NDgHn4OOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsnAcXKZqMAWZ66mdIY2SX6jedojdT+cIL4ZxuNjOyE6qhGR8g3rdZEn2nYirjDo7
	 Lo+fZNWFlpBxd1Mlog9z+h22hj7kmA0TZ1w56LuiER/+bkbyXBbeXK8wUbhCq8xqxO
	 R3MCpU+I3VGrYslEhYgAwS1vUgegrWUMWxnZ9LWoCqJKeRMqMFsejCgyrBP+Kvj9GS
	 R7JSeVgBlXt9X7QKs6VNYHcwlcIWN909cCHBSw1BF/kJtf+Jx4CsIFBpXQFX/mmE3f
	 5t2u6D3I3pTbGSM38kPLsEypJBFGDP3/dgSZwzE+F0ys0hM0dasTNw5GNiOInle2nM
	 f26p75DyudTTw==
Date: Wed, 28 Aug 2024 20:30:11 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 04/19] nfsd: factor out __fh_verify to allow NULL
 rqstp to be passed
Message-ID: <Zs_BE4l-fNqtjlcB@kernel.org>
References: <>
 <ZstOonct0HiaRCBM@tissot.1015granger.net>
 <172462948890.6062.12952329291740788286@noble.neil.brown.name>
 <Zs9XzSHGysK4eCJO@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs9XzSHGysK4eCJO@tissot.1015granger.net>

On Wed, Aug 28, 2024 at 01:01:01PM -0400, Chuck Lever wrote:
> On Mon, Aug 26, 2024 at 09:44:48AM +1000, NeilBrown wrote:
> > On Mon, 26 Aug 2024, Chuck Lever wrote:
> > > See comment on 5/N: since that patch makes this a public API again,
> > > consider not removing this kdoc comment but rather updating it.
> > 
> > What exactly do you consider to be a "public API"??  Anything without
> > "static"?  That seems somewhat arbitrary.
> > 
> > I think of __fh_verify() as a private API used by fh_verify() and
> > nfsd_file_acquire_local() and nothing else.
> > 
> > It seems pointless duplication the documentation for __fh_verify() and
> > fh_verify().  Maybe one could refer to the other "fh_verify is like
> > fh_verify except ....."
> > 
> > ??
> > 
> > > 
> > > 
> > > > -__be32
> > > > -fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> > > > +static __be32
> > > > +__fh_verify(struct svc_rqst *rqstp,
> 
> An alternative would be to leave __fh_verify() as a static, and then
> add an fh_verify_local() API, echoing nfsd_file_acquire_local(), and
> then give that API a kdoc comment.
> 
> That would make it clear who the intended consumer is.

I ran with this idea, definite improvement, you'll find the changes
folded in to the relevant patch (with the same subject) in v14.

Thanks,
Mike

