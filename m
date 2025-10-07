Return-Path: <linux-nfs+bounces-15011-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF19BC14DC
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 14:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A830434EA3A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 12:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3B22D949F;
	Tue,  7 Oct 2025 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjdxudqE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A252D6E69;
	Tue,  7 Oct 2025 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838821; cv=none; b=on1t4WFrABfTIQH2S0knxUwkCcjZFBcvpT0hhVgeE4jyiHhdmmFIa85aKL5aCTzdn+F/BHq+YWHlx3MvFgJWhippZLivS0CVPz+oBYCQaR51CIFa+3oRcTFptG6z4J/8h+c3R0jOTh5LYuGGdeQD6Efc8gRnPE4Mrr+T8AcPFrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838821; c=relaxed/simple;
	bh=0IWs7kEP3eKS5Z9wqVChLMltcpO4tLuL21+2Ep/aRHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwVvW4I7Hbb8Ik0B2b3yg2ld9d1AZnngKL7hybE4DY2C6V/4bB4u8mFR9Ije3BWzrq1w+swRuuSHjtJWz+OpyZShq4KSatMJdy/b347SZhqARXETfr856T2iq9BeiVslpniCUg6EEE/Qj925h5LKNjUVEBTMdQ1DR+hu3YNiCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjdxudqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD920C4CEF1;
	Tue,  7 Oct 2025 12:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759838820;
	bh=0IWs7kEP3eKS5Z9wqVChLMltcpO4tLuL21+2Ep/aRHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GjdxudqEbWm/WCfG6PKFO1V7CH/ZRRQ5Upb0LCBnT1wOJ3fWR1tCv9HE685m+ZJSW
	 L8PuysWejHCHKcjDsN5r/XoQJ2fWc8pC6FZHLLYNRZaSGN2P+Upn7eqfnDInN8zAxK
	 sWrWxJczU85Zkp3Sa3ZlMCqjOdvRTCD/lu8kFp1s1ja0wAazP+UqYrtdVi5v/jw4oj
	 ERBINLtM8hBXtGAlvUnks4PAgITu8QU/fBN3+0RsFEkXFocHSHqdFgNFdccrOhzbbY
	 K8QqZkiyRKDEziy9WY6QIuirZf3SSOZH/t8Mt85hkHh6+eR5L9E0AiiY43zmP5QvcN
	 3D6hs/GUunMqQ==
Date: Tue, 7 Oct 2025 14:06:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [GIT PULL] NFSD changes for v6.18
Message-ID: <20251007-ausholen-wohlklang-832361d2e995@brauner>
References: <20251006135010.2165-1-cel@kernel.org>
 <CAHk-=wiH4-v3YxzN9_obL8Z_d9+TiFOdXwiDAauHqO-1vymY-w@mail.gmail.com>
 <26c34ef2-8309-4625-9bee-bb3e5c056568@kernel.org>
 <20251007-zoodirektor-widder-27776d2e7228@brauner>
 <39f56bc6833c6e25ac94cce6eba8eec3267ab5f6.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39f56bc6833c6e25ac94cce6eba8eec3267ab5f6.camel@kernel.org>

On Tue, Oct 07, 2025 at 07:47:39AM -0400, Jeff Layton wrote:
> On Tue, 2025-10-07 at 13:26 +0200, Christian Brauner wrote:
> > On Mon, Oct 06, 2025 at 04:58:22PM -0400, Chuck Lever wrote:
> > > On 10/6/25 4:51 PM, Linus Torvalds wrote:
> > > > On Mon, 6 Oct 2025 at 06:50, Chuck Lever <cel@kernel.org> wrote:
> > > > > 
> > > > > One potential merge conflict has been reported for nfsd-6.18.
> > > > 
> > > > No problem, this is the simple kind of explicit conflict (famous last
> > > > words before I mess one of those things up).
> > > > 
> > > > Anyway, the reason I'm replying is actually that I notice that you
> > > > added that ATTR_CTIME_SET flag in <linux/fs.h> in commit afc5b36e29b9
> > > > ("vfs: add ATTR_CTIME_SET flag").
> > > > 
> > > > No complaints about it, but it looks a bit odd with ATTR_{A,M}TIME_SET
> > > > in bits 7 and 8, and then the new ATTR_CTIME_SET is in bit 10 with the
> > > > entirely unrelated ATTR_FORCE in between them all.
> > > 
> > > Oof. We should have gotten Acks for "vfs: add ATTR_CTIME_SET flag". My
> > > bad.
> > 
> > Yes, indeed. I wondered why I hadn't seen this patch.
> > 
> 
> I did send it to fsdevel, but you may have missed it in the deluge. Mea
> culpa from me too -- I should have noticed that you guys hadn't acked
> this yet. Any objection?

No, it looks sane overally.

I think we should renumber. Frankly, I would also prefer for stuff like
this to be enums. It makes debugging for stuff like drgn that people use
easier and imho also looks nicer in the code. But that's a matter of
taste. And the renumbering might be the bigger win as Linus suggested.

