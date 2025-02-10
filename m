Return-Path: <linux-nfs+bounces-10016-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD4FA2F3A7
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 17:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB29A166938
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC7C1F462D;
	Mon, 10 Feb 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CQ6KXdu7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9601F4629
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205224; cv=none; b=Jj8JwZu7QHhOZ4HAHl6Ug5aNPPnOLDi3/mayKTb8FsFRPTNwS9sVndFqAVc2Nxwrh4ZkhLYHwprUEQp9ZycFi6Oc8hYhifFmxfJSNrCgcuxE3zXIz9WfP3V3oBwwzT9eEDh25Zzv7tvY9hoaaIYhtI1jaNPi14IPgZUbomA9uDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205224; c=relaxed/simple;
	bh=NNAoRR42M4PEj7RuLxVCW6T/80RNYJMGDXcJzC7Ihcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYltsGwKsLeXtF0cvIUbUYLWasiJRP6pn3taA+ndtG0OONR8vI+kVN1xNjmi7YnynhHdvCH++4XTNe+D6AExQNGXVFP2J+VT8tW5C0wc0f0+9K5YfPcW5dcL79bgr0IP0xKMvv9wmYW8YnyDtn5ZoMnFAuDqwgaaU/KsQec8YLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CQ6KXdu7; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Feb 2025 11:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739205220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHEPg2tnYk996j50t0w/ug6RmAq9eo4vY8uZYvfHPSI=;
	b=CQ6KXdu7TqE80giktdum98OJ++d2Ak/psSmcUlLbxxBTfnBIGGEHA74ERuE8sH2T5EpbwR
	uxOrtg3wU309+cxNYewRFL4lDxGdFpxn9ZXy+FKauNxE8Uh3Gs37V5ryGUHU0V8kLRRV+w
	KJHykrhn3LtkmfJTxSYfUxCuYL8uf6o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
Message-ID: <2daod6ozirkzppfbbqe4jozw3w4u6pscjc32j6ghuu6vxme7om@abckfzrou5cl>
References: <>
 <4bxqnnpfau5sq2h7oexvrvazqqpn55e7vsjlj44epdcas2clzf@424354eeo6dl>
 <173915041509.22054.12649815796390080222@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173915041509.22054.12649815796390080222@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 10, 2025 at 12:20:15PM +1100, NeilBrown wrote:
> On Sat, 08 Feb 2025, Kent Overstreet wrote:
> > On Fri, Feb 07, 2025 at 06:30:00PM +1100, NeilBrown wrote:
> > > On Fri, 07 Feb 2025, Kent Overstreet wrote:
> > > > On Fri, Feb 07, 2025 at 05:34:23PM +1100, NeilBrown wrote:
> > > > > On Fri, 07 Feb 2025, Kent Overstreet wrote:
> > > > > > On Fri, Feb 07, 2025 at 03:53:52PM +1100, NeilBrown wrote:
> > > > > > > Do you think there could be a problem with changing the error returned
> > > > > > > in this circumstance? i.e. if you try to destroy a subvolume with a
> > > > > > > non-existant name on a different filesystem could getting -ENOENT
> > > > > > > instead of -EXDEV be noticed?
> > > > > > 
> > > > > > -EXDEV is the standard error code for "we're crossing a filesystem
> > > > > > boundary and we can't or aren't supposed to be", so no, let's not change
> > > > > > that.
> > > > > > 
> > > > > 
> > > > > OK.  As bcachefs is the only user of user_path_locked_at() it shouldn't
> > > > > be too hard.
> > > > 
> > > > Hang on, why does that require keeping user_path_locked_at()? Just
> > > > compare i_sb...
> > > > 
> > > 
> > > I changed user_path_locked_at() to not return a dentry at all when the
> > > full path couldn't be found.  If there is no dentry, then there is no
> > > ->d_sb.
> > > (if there was an ->i_sb, there would be an inode and this all wouldn't
> > > be an issue).
> > > 
> > > To recap: the difference happens if the path DOESN'T exist but the
> > > parent DOES exist on a DIFFERENT filesystem.  It is very much a corner
> > > case and the error code shouldn't matter.  But I had to ask...
> > 
> > Ahh...
> > 
> > Well, if I've scanned the series correctly (sorry, we're on different
> > timezones and I haven't had much caffeine yet) I hope you don't have to
> > keep that function just for bcachefs - but I do think the error code is
> > important.
> > 
> > Userspace getting -ENOENT and reporting -ENOENT to the user will
> > inevitably lead to head banging frustration by someone, somewhere, when
> > they're trying to delete something and the system is tell them it
> > doesn't exist when they can see it very much does exist, right there :)
> > the more precise error code is a very helpful cue...
> > 
> 
> ???
> You will only get -ENOENT if there is no ent.  There is no question of a
> confusing error message.
> If you ask for a non-exist name on the correct filesystem, you get -ENOENT
> If you ask for an existing name of the wrong filesystem, you get -EXDEV
> That all works as expected and always has.
> 
> But what if you ask for a non-existing name in a directory on the
> wrong filesystem?  
> The code you originally wrote in 42d237320e9817a9 would return
> -ENOENT because that it what user_path_at() would return.

Ahh - ok, I think I see where I misread before

> But using user_path_at() is "wrong" because it doesn't lock the directory
> so ->d_parent is not guaranteed to be stable.
> Al fixed that in bbe6a7c899e7f265c using user_path_locked_at(), but
> that doesn't check for a negative dentry so Al added a check to return
> -ENOENT, but that was added *after* the test that returns -EXDEV.
> 
> So now if you call subvolume_destroy on a non-existing name in a
> directory on the wrong filesystem, you get -EXDEV.  I think that is
> a bit weird but not a lot weird.

Yeah, we don't need to preserve that. As long as calling it on a name
that _does_ exist on a different filesystem returns -EXDEV, that's all I
care about.

So assuming that's the case you can go ahead and add my acked-by...

Nit: I would go back and stare at the patch some more, but threading got
completely fubar so I can't find anything. Doh.

> My patch will change it back to -ENOENT - the way you originally wrote
> it.
> 
> I hope you are ok with that.

Yes, sounds good.

