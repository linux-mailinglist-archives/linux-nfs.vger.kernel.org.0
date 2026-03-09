Return-Path: <linux-nfs+bounces-19875-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ILaAwSWrmnRGQIAu9opvQ
	(envelope-from <linux-nfs+bounces-19875-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 10:42:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65213236612
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 10:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1DD0304C7FF
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12222379ED8;
	Mon,  9 Mar 2026 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpQNRM7s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22213368B9;
	Mon,  9 Mar 2026 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773049023; cv=none; b=b8o3g+53DVKYLFhZ8/c4S3uzBFq7Mmnt/i/LqrbLdP4q7ZdbmmobpcvuJrVJ2HkBS+yZYPJoIy6ClJYpSQ7jf0wTimTb013cRI6K0j7t8S53ojId4PRusKZvWQzcnv8aJgQQ+s8wGY+wZN9lihpNq+SzlSGynq140pb0bD0xijQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773049023; c=relaxed/simple;
	bh=hfPMNYiI0Us/JfLHm+ZntEVlSNqxT57YtFaci0q7bNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMrJmc5my6zh2xbsRFYqsXm5bSXelfq7MKHFI2iXi+9mRAG0E0TkFfqNICPMVHvB2nICXg+KRjNSWuXzNqZTayM6QR2OZer97NmgrEs4K12RPrSszN264vh1KZEyII+ZWbmAlnkGMargIoKK5mszvQ8TROImkC4k40lS54EN/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpQNRM7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D427C4CEF7;
	Mon,  9 Mar 2026 09:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773049022;
	bh=hfPMNYiI0Us/JfLHm+ZntEVlSNqxT57YtFaci0q7bNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpQNRM7sGBhSX5hthsHBYeMFJmze9uxAMn31l1oMxMFAKQjdsg/pNF2zJbSVHQn1j
	 vyQUlVy9Mm6LeU7hdFn2DsK7cGaUUr52bONPlYECFFPBjT4Sjkg/kGDtwGB6G4rhlC
	 KWkAvxmwTJXAzeGskhx05BwsxLPsufLGXlXKNhQzgjGVVhDa5AEFa7Fz90/35kcRLp
	 Zi2XEf95RJySyl6WHerOFLSOSgKXh3IceA6FvLS0cc1zO9fz3BxK7ZZMxcAOQIBroy
	 wH9rUYWq56/XtkrEvy4Hng0Jj4rDyTFY3h+NDBkCaVe/45tiDkKWKuKZu7UNohu+Xb
	 /kXhfGNw2xRTg==
Date: Mon, 9 Mar 2026 10:36:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-nfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>, 
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH] kthread: remove kthread_exit()
Message-ID: <20260309-aufrechnung-flugzeit-f8e22786a8b2@brauner>
References: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com>
 <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
 <aaroReSCj1qXUeQb@infradead.org>
 <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
X-Rspamd-Queue-Id: 65213236612
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19875-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[infradead.org,vger.kernel.org,googlegroups.com,kernel.org,suse.com,google.com,atomlin.com,oracle.com,brown.name,redhat.com,talpey.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.421];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 10:27:26AM -0800, Linus Torvalds wrote:
> On Fri, 6 Mar 2026 at 06:44, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > More a comment on the previous patch, but I think exporting do_exit
> > which can work on any task is a really bad idea.
> 
> What is the advantage of a module only being able to do
> kthread_exit(), and not able to do a regular do_exit()?
> 
> I think the only real advantage of having a "kthread_exit()" is that
> it's a nicer name.
> 
> Because if that's the main issue, then I agree that "do_exit()" is
> really not a great name, and it matches a very traditional "this is an
> internal function" naming convention, and not typically a "this is
> what random modules should use".
> 
> So kthread_exit() is a much better name, but it basically *has* to act
> exactly like do_exit(), and adding a limitation to only work on
> kthreads doesn't actually seem like an improvement.
> 
> Why make a function that is intentionally limited with no real
> technical upside? It's not like there's any real reason why a module
> couldn't call exit - we may not have exported it before, but we do
> have code that looks like it *could* be a module that calls do_exit()
> today.
> 
> For example, I'm looking at kernel/vhost_task.c, and the only users
> are things that *are* modules, and it's not hugely obvious that
> there's a big advantage to saying "that task handling has to be
> built-in for those modules".
> 
> So my reaction is that "no, do_exit() is not a great name, but there's
> no real technical upside to havign a separate kthread_exit()"
> function.
> 
> If it's just about naming, maybe we could just unify it all and call
> it "task_exit()" or something?

I have that as a follow-up series... But I didn't want to muddle the two
patches as this one was meant as a clean-up for the kthread_exit()
leftover. Now that you've applied the fixup for the BTF thing directly I
can send both at the same time. Give me a few minutes.

And no, we should definitely not keep kthread_exit() as a separate thing
around. That just seems weird and clearly that has led to bugs before.

The vhost example is good for another reason: the line between a task
acting as a proper kthread and something that is aking to a kthread is
very very blurry by now. Let's ignore usermodehelpers for a minute
(ugh). There's io workers or more generalized - like vhost - user
workers which are hybrid workers that aren't clearly completely
userspace conceptually but also aren't clearly kthreads so I'd not want
to have special-cases for any of them. task_exit() just should to the
right thing no matter what exactly exits. We also have way to many
cleanup hooks that need to be called depending on what precisely exists
to split this over different helpers.

