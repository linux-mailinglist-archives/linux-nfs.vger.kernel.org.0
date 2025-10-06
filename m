Return-Path: <linux-nfs+bounces-15002-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C283CBBF7D8
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 22:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6EE4B34AE08
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 20:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88294258CC0;
	Mon,  6 Oct 2025 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED+fnBuh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA91DE2D7;
	Mon,  6 Oct 2025 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759784305; cv=none; b=tGw6G4HXOh7DQaT2+wnEUYGjby4yzbp9Tut95swWKFLjhiIzascJ6F3SVgpthzIUTzB2XXzojS5iZJClQW/ZBIuNxWQy2drBvZ996QGarGRt41u8s1V8NiXMWhl4zKOiyjlBvMQXuyLOoQHjC4ChSTjeLGl9pMrdSKfEKaWkTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759784305; c=relaxed/simple;
	bh=hklacsREQOjXIvE2pwhv3opzzHrR7jdcgp9qeYjOpsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+UzdnIBZqu+4+2I+t1Dye7Eoc0Xi8C0xaDOGbMyPlD7BTSrixOERaCw9SFcDMY6x8wFn58unSJ4Vgc9s8MK3xB14NN2ki6d4ycQil59z/oiccCwxYpS7b6C/CnmOb7o/xI1jU+Og+ycbHs2y8RNb5bAF966LgumPnxrKDunufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED+fnBuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C95C116B1;
	Mon,  6 Oct 2025 20:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759784304;
	bh=hklacsREQOjXIvE2pwhv3opzzHrR7jdcgp9qeYjOpsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ED+fnBuhHPVzjaZtBwcjbsUJkfrbj/81NWqWwD9S0br+ltxooOxg5Xo7968ui9hgW
	 8Sc7pQLEwvWXK1jEFL4SBlHc0M9EfkR/GI5THhu7v4Pw75FCP9V9VsXwWyR2qDjOPk
	 e0J09gZ5IykikLDrv7RmI7cxTwmODWf7fg1kSYlxn9aro1LE5uUZyZUi7SvtnZj+rh
	 bhKOcacPPP6MNrpYMUkTm0OMCPgQJmWVS134b3yTu1ce6YKnql41MNBoy8tMe8sRPJ
	 7Zh3ODgMSuq2ZCwbw/a2UvKjQVnNAoCZ2gWQXxjuED9Ty6K6wq1wI3GFocU7ohWc+l
	 afA6ubptPyd2w==
Message-ID: <26c34ef2-8309-4625-9bee-bb3e5c056568@kernel.org>
Date: Mon, 6 Oct 2025 16:58:22 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] NFSD changes for v6.18
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>
References: <20251006135010.2165-1-cel@kernel.org>
 <CAHk-=wiH4-v3YxzN9_obL8Z_d9+TiFOdXwiDAauHqO-1vymY-w@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <CAHk-=wiH4-v3YxzN9_obL8Z_d9+TiFOdXwiDAauHqO-1vymY-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 4:51 PM, Linus Torvalds wrote:
> On Mon, 6 Oct 2025 at 06:50, Chuck Lever <cel@kernel.org> wrote:
>>
>> One potential merge conflict has been reported for nfsd-6.18.
> 
> No problem, this is the simple kind of explicit conflict (famous last
> words before I mess one of those things up).
> 
> Anyway, the reason I'm replying is actually that I notice that you
> added that ATTR_CTIME_SET flag in <linux/fs.h> in commit afc5b36e29b9
> ("vfs: add ATTR_CTIME_SET flag").
> 
> No complaints about it, but it looks a bit odd with ATTR_{A,M}TIME_SET
> in bits 7 and 8, and then the new ATTR_CTIME_SET is in bit 10 with the
> entirely unrelated ATTR_FORCE in between them all.

Oof. We should have gotten Acks for "vfs: add ATTR_CTIME_SET flag". My
bad.


> So I'm thinking it would look cleaner if we just swapped
> ATTR_CTIME_SET and ATTR_FORCE around - these are all just our own
> kernel-internal bits (and the reason bit 10 was unused is that it used
> to contain the odd ATTR_ATTR_FLAG that was never used).
> 
> Danger Will Robinson: hostfs has odd duplicate copies of all these, including a
> 
>    #define HOSTFS_ATTR_ATTR_FLAG   1024
> 
> of that no-longer existing flag.
> 
> But hostfs doesn't use ATTR_FORCE (aka HOSTFS_ATTR_FORCE), so
> switching those two bits around wouldn't affect it either, even if you
> were to have a version mismatch between the client and host when doing
> UML (which I don't know
> 
> Adding Christian to the participants list, because I did *not* do that
> cleanup thing myself, because I'm slightly worried that I'm missing
> something. But it would seem to be a good thing to do just to have the
> numbering make more sense, and Christian is probably the right person.
> 
> And adding Johannes Berg due to the UML connection, just to see that I
> haven't misread that odd hostfs situation.
> 
> Comments?
> 
>             Linus


-- 
Chuck Lever

