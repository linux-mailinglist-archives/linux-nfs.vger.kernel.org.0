Return-Path: <linux-nfs+bounces-11962-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 941C9AC7211
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 22:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE302188FB95
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 20:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7617D21CC4A;
	Wed, 28 May 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pY367jxZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733F220F46;
	Wed, 28 May 2025 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748463491; cv=none; b=i/IwLTml9SVWS22iGx1qCc2EmLEHw/ak9pcLHjrL5LV65UzvLdB3SwedihA4scTPwZO6CWkrLWJlmVA2HgLrwe5b1SGCtBlKivcgoX6nJg0wXARkO8wvIJYE/+GgofaicqgdbE+mNmLt76CAtMAj+TyiDKdLnSSCSxehdVyiEO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748463491; c=relaxed/simple;
	bh=G6RFgAo1ZkDxSZSJIJw1rPFOk7/9WLkdD/wqr5J3kIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnAf8LahgjwC/PPbHJfq6GKa4dklw6gafjiouzFlpUhuIKqpHmh+jq40x9P9c4GfBLOt/xrj49JlHfpEplcPo/3+LNEjJCRwFpi685PjkU2iORUiquFIijRjZTiv6ttP/ddUnDyVW1Et+kwSzv5JOae8G2vxL2Xy+CFuq0xd4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pY367jxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BDDC4CEE3;
	Wed, 28 May 2025 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748463489;
	bh=G6RFgAo1ZkDxSZSJIJw1rPFOk7/9WLkdD/wqr5J3kIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pY367jxZjE+ylU5eP3nMO28+7LZZNHe9V7tC36cr3+Vza7x2p2shCPRK3Y5sXpIeh
	 jEAo0FjXXAUg4+ccG/tgREy4dXqSeAZl6s4y9BMGU2CG9lHQRrGiH0cxA9ah+Uwq7b
	 SSndB3u1oSCoyY4Nl2Dt6P/6IQ8s3cVZ1FZ73F4Q=
Date: Wed, 28 May 2025 16:18:08 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chuck Lever <cel@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [GIT PULL] NFSD changes for v6.16
Message-ID: <20250528-wise-platinum-pony-ea6f62@lemur>
References: <20250527141706.388993-1-cel@kernel.org>
 <CAHk-=wggC6PP9ZNwKY7sEzdsC7h8qySA7pjqAchrYowniADUQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wggC6PP9ZNwKY7sEzdsC7h8qySA7pjqAchrYowniADUQg@mail.gmail.com>

On Wed, May 28, 2025 at 12:38:58PM -0700, Linus Torvalds wrote:
> Can you fix your kernel.org email sending setup so that you have a
> real name, not just your login name?
> 
> This is not your fault, btw. I think the kernel.org email sending
> documentation is actively misleading and wrong, with
> 
>     https://korg.docs.kernel.org/mail.html
> 
> and the 'getsmtppass' output saying that you should do things like
> 
>     from  = "[username]@kernel.org"
> 
> in your git config (or mutt settings), like you were some kind of bot
> that didn't have an actual name.
> 
> Konstantin, can we please get the kernel.org documentation and
> getsmtpass output fixed? We had somebody else who also ended up being
> nameless (Ingo, I think) due to following the documentation a bit too
> slavishly.

I've updated it to say:

    from = "Your Name <[username]@kernel.org>"

So, if you receive mail from a bunch of people called "Your Name", at least
you'll know that they are reading the documentation (and still following it a
bit too slavishly). :)

-K

