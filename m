Return-Path: <linux-nfs+bounces-15009-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657A7BC1336
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 13:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0847C3AFD21
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70FA2D7DE1;
	Tue,  7 Oct 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcKHKTjF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18D823DD;
	Tue,  7 Oct 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836366; cv=none; b=Pkr9CkQk+5WEiHWeVQ2ZExpMQ5MD+jQM6YEiIC2QKNzZTjelS6+2JOVy+PICUA57DkMKRbIyreB0ZPf26tFPyi1yrWHc5KP5iJK80v19EN0obIUmzMOXbGxW+Ww8w57rzVATnZNaxwmJ7bSVn7scVgxFj9GiUutNTg7+kmdBYRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836366; c=relaxed/simple;
	bh=q9pv4C4FRTY6WhDpMUIPdlbgJVU3rkCad+bKpkYtuco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVGwGWSmR1Heyl8idR8bh9Gfefr7GA6tf4tJ5M/gXeI9sK5WY5Ryqf1ZsJyzuPsUzBKb8hF9XMroRc1TzhSHzvA6qrqH+HHq1zvcT8mQsHV4Bwpj7vqe7Br7IInJ/ol8mIan0d/cn63RU9FdVSq1Js1CLQmVd0DyON8BI++3Vw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcKHKTjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6873CC4CEF1;
	Tue,  7 Oct 2025 11:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759836365;
	bh=q9pv4C4FRTY6WhDpMUIPdlbgJVU3rkCad+bKpkYtuco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcKHKTjF7tkdUSoPpG6wqySRz90fWZMlvOjG1hRVG9VzzSWHoFeUkPpf/2kGax7nP
	 kv9pnNQmi3JUGK4iPq2y+QVQ3psB9Qjy49TgfzcQVTKOES8ATidcAUmAHFWd5ZyccZ
	 ozKOZKOtp1uo+WpU2tHg0rWo1XVWqOwJVC+6pwdNsWgYgIJ/ylR92HTHb3zH1+Hptu
	 4edSGFb26JWfv2zQ2UxD6ChRtXrtB1P1AQt2TVhldCsC8c4ILaC3Z6xoTgyhSzh9Fk
	 QhyrFHIaMN8rOt0jMp2NglpqnAycX9LeBBlosKV/PmptH7fXUukdSRxRCILzORHLyk
	 uDMAZQsegzGrw==
Date: Tue, 7 Oct 2025 13:26:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [GIT PULL] NFSD changes for v6.18
Message-ID: <20251007-zoodirektor-widder-27776d2e7228@brauner>
References: <20251006135010.2165-1-cel@kernel.org>
 <CAHk-=wiH4-v3YxzN9_obL8Z_d9+TiFOdXwiDAauHqO-1vymY-w@mail.gmail.com>
 <26c34ef2-8309-4625-9bee-bb3e5c056568@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26c34ef2-8309-4625-9bee-bb3e5c056568@kernel.org>

On Mon, Oct 06, 2025 at 04:58:22PM -0400, Chuck Lever wrote:
> On 10/6/25 4:51 PM, Linus Torvalds wrote:
> > On Mon, 6 Oct 2025 at 06:50, Chuck Lever <cel@kernel.org> wrote:
> >>
> >> One potential merge conflict has been reported for nfsd-6.18.
> > 
> > No problem, this is the simple kind of explicit conflict (famous last
> > words before I mess one of those things up).
> > 
> > Anyway, the reason I'm replying is actually that I notice that you
> > added that ATTR_CTIME_SET flag in <linux/fs.h> in commit afc5b36e29b9
> > ("vfs: add ATTR_CTIME_SET flag").
> > 
> > No complaints about it, but it looks a bit odd with ATTR_{A,M}TIME_SET
> > in bits 7 and 8, and then the new ATTR_CTIME_SET is in bit 10 with the
> > entirely unrelated ATTR_FORCE in between them all.
> 
> Oof. We should have gotten Acks for "vfs: add ATTR_CTIME_SET flag". My
> bad.

Yes, indeed. I wondered why I hadn't seen this patch.

> 
> 
> > So I'm thinking it would look cleaner if we just swapped
> > ATTR_CTIME_SET and ATTR_FORCE around - these are all just our own
> > kernel-internal bits (and the reason bit 10 was unused is that it used
> > to contain the odd ATTR_ATTR_FLAG that was never used).
> > 
> > Danger Will Robinson: hostfs has odd duplicate copies of all these, including a
> > 
> >    #define HOSTFS_ATTR_ATTR_FLAG   1024
> > 
> > of that no-longer existing flag.
> > 
> > But hostfs doesn't use ATTR_FORCE (aka HOSTFS_ATTR_FORCE), so
> > switching those two bits around wouldn't affect it either, even if you
> > were to have a version mismatch between the client and host when doing
> > UML (which I don't know
> > 
> > Adding Christian to the participants list, because I did *not* do that
> > cleanup thing myself, because I'm slightly worried that I'm missing
> > something. But it would seem to be a good thing to do just to have the
> > numbering make more sense, and Christian is probably the right person.
> > 
> > And adding Johannes Berg due to the UML connection, just to see that I
> > haven't misread that odd hostfs situation.
> > 
> > Comments?
> > 
> >             Linus
> 
> 
> -- 
> Chuck Lever

