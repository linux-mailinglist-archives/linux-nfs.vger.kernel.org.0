Return-Path: <linux-nfs+bounces-361-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630A9807266
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 15:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D435281CCC
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E3F3DBBE;
	Wed,  6 Dec 2023 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIALolCK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6B3DBB4;
	Wed,  6 Dec 2023 14:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C74C433C7;
	Wed,  6 Dec 2023 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701872979;
	bh=p6rAyWHM5AqR9dUYU7vcs8xt6CGYW/tEATVQlNd09X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIALolCKEUyj+dUlp6R7K+01elMi+GaCaW1xc8iQn50VJ02Wqt7QKT9H3BACuGHqP
	 1wG/utdjNBGbz8hMoSKJK0unq2UjqvR7gNtie0gePcmDYWrgFeJgvsbXjBszKXvCrV
	 aOYvNnPhUuphOr2S5kundhGNc5TdQOgyFmYi+4O76tCmEcjHJeCfPGyoEnlGBKEH14
	 WcExRCFME9MlfVztoTO85yWPjvQP1dLgGozwZhCRty9brK0BBfW+BSfTZaQdpm36Pi
	 byrdPhFwwpzTwqOQnFzkpkeYKebE4Ekly+y4gLQC7W4JlE+nc0lfSTmu+zkms86aFl
	 srfZkrFLCOVoQ==
Date: Wed, 6 Dec 2023 15:29:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
	Oleg Nesterov <oleg@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <20231206-kribbeln-flugobjekt-2fa353faeed9@brauner>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
 <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>
 <170172377302.7109.11739406555273171485@noble.neil.brown.name>
 <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>
 <20231205-altbacken-umbesetzen-e5c0c021ab98@brauner>
 <170181169515.7109.11121482729257102758@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170181169515.7109.11121482729257102758@noble.neil.brown.name>

On Wed, Dec 06, 2023 at 08:28:15AM +1100, NeilBrown wrote:
> On Tue, 05 Dec 2023, Christian Brauner wrote:
> > On Mon, Dec 04, 2023 at 03:09:44PM -0700, Jens Axboe wrote:
> > > On 12/4/23 2:02 PM, NeilBrown wrote:
> > > > It isn't clear to me what _GPL is appropriate, but maybe the rules
> > > > changed since last I looked..... are there rules?
> > > > 
> > > > My reasoning was that the call is effectively part of the user-space
> > > > ABI.  A user-space process can call this trivially by invoking any
> > > > system call.  The user-space ABI is explicitly a boundary which the GPL
> > > > does not cross.  So it doesn't seem appropriate to prevent non-GPL
> > > > kernel code from doing something that non-GPL user-space code can
> > > > trivially do.
> > > 
> > > By that reasoning, basically everything in the kernel should be non-GPL
> > > marked. And while task_work can get used by the application, it happens
> > > only indirectly or implicitly. So I don't think this reasoning is sound
> > > at all, it's not an exported ABI or API by itself.
> > > 
> > > For me, the more core of an export it is, the stronger the reason it
> > > should be GPL. FWIW, I don't think exporting task_work functionality is
> > > a good idea in the first place, but if there's a strong reason to do so,
> > 
> > Yeah, I'm not too fond of that part as well. I don't think we want to
> > give modules the ability to mess with task work. This is just asking for
> > trouble.
> > 
> 
> Ok, maybe we need to reframe the problem then.
> 
> Currently fput(), and hence filp_close(), take control away from kernel
> threads in that they cannot be sure that a "close" has actually
> completed.
> 
> This is already a problem for nfsd.  When renaming a file, nfsd needs to
> ensure any cached "open" that it has on the file is closed (else when
> re-exporting an NFS filesystem it can result in a silly-rename).
> 
> nfsd currently handles this case by calling flush_delayed_fput().  I
> suspect you are no more happy about exporting that than you are about
> exporting task_work_run(), but this solution isn't actually 100%
> reliable.  If some other thread calls flush_delayed_fput() between nfsd
> calling filp_close() and that same nfsd calling flush_delayed_fput(),
> then the second flush can return before the first flush (in the other
> thread) completes all the work it took on.
> 
> What we really need - both for handling renames and for avoiding
> possible memory exhaustion - is for nfsd to be able to reliably wait for
> any fput() that it initiated to complete.

Yeah, I acknowledge the problem and I said I'm not opposed to your
solution I just would like to do it differently if we can.

> 
> How would you like the VFS to provide that service?

If you really don't care about getting stuck on an fput() somehow then
what Jens suggested might actually be fine.

And the proposal - queue the files on a list - isn't that already what
nfsd is kinda doing already for the file cache. That's at least the
impression I got from reading over nfsd_file_free(). It's just that it
doesn't free directly but used that flush_delayed_fput(). So really,
taking this on step further and doing the fput synchronously might work.

