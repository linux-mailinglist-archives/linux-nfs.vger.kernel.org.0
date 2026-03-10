Return-Path: <linux-nfs+bounces-19975-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCFpL5kqsGlHgwIAu9opvQ
	(envelope-from <linux-nfs+bounces-19975-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 15:28:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A8251F6D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 15:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50C2233581D6
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 13:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BA12D978B;
	Tue, 10 Mar 2026 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2IZB0CLI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5FC40DFD8;
	Tue, 10 Mar 2026 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148283; cv=none; b=tEABEEvqDqa0V7+ESDSq5kmLYcyaOJHELbUu/r5qwWJrzOw1Xw73QwWs6BfwZ+00IHzw7bpJoQbUm0f1cVvNQ2z61Q+UKECAR3uTIkXpjaFGoAvSlWaNs3cu0JlVPLnl6tfuqp4yckFPOSTdn9UO1fmQOTdv2g2C51zD3t3ba/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148283; c=relaxed/simple;
	bh=5c5DIHV4hT2SeTfqSM2LG61yHypW02KyRFmvcmJdQnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbMLsg79aoUQgPLSqaMQHq+6phSGmNFKqhjEBsbqyWbEDSV5tzgJL5+dFXN1DuzMvJkHXBnOR1izy3ISkSS+LrfWnHcXhezTj1/QNdDbze8PNNttWzPhQFL+6HNinqs4lr0eeZXLFannlPzFyrLE9YSR1EuZWcmrPczPyo+eXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2IZB0CLI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l4GpPH3ubmx3aruEVyuRzz3DC1ibbOvvKhNccLuCdJw=; b=2IZB0CLIMhRCWLDyZPKVLAP3Zi
	vkxq5N+BauqfWJ2D08pYk2yJx04ORVTcyKmDDrK6LuqW8XMpcwg6np0wljWMF5F1kr01sH+Q+jTrq
	xDq8JKn+NuwXEQgsNA7+BSOA7KRyX1wksWfz9wKmL9hYInXwz8XUG9LBohaI66rEoRupv9ltfhBxQ
	B67SFwm+9VlBJyWk6UVQWx2m2KvS0cFVxa8tSFUpKwxJS1FIprhUVpsGM4inI8xOeVYE3OTfvQkpq
	d83SjBx8OUeAWD15fpQ3CkfgrZHzJdUM6o/iIAO634R5cNSd9paceV9MYix4ApeSzSnk0L+NmiwTZ
	zlAStFSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzwrl-00000009Yu9-2fbO;
	Tue, 10 Mar 2026 13:11:17 +0000
Date: Tue, 10 Mar 2026 06:11:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-nfs@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH] kthread: remove kthread_exit()
Message-ID: <abAYdbtYE2tHPNnM@infradead.org>
References: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com>
 <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
 <aaroReSCj1qXUeQb@infradead.org>
 <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
 <aa7qson15uJpL-BL@infradead.org>
 <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 347A8251F6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19975-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,vger.kernel.org,googlegroups.com,suse.com,google.com,atomlin.com,oracle.com,brown.name,redhat.com,talpey.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,arm.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,infradead.org:email,infradead.org:mid]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:37:26AM -0700, Linus Torvalds wrote:
> On Mon, 9 Mar 2026 at 08:43, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Because it can't f&*^ up the state of random tasks.
> 
> Christoph, you make no sense.

Thanks, I always appreciated rational and detailed answers.

> 
> "do_exit()" cannot mess up random tasks. It can only exit the
> *current* task. The task that is running right now in that module.

Yes.  And random code should not be able to end arbitrary tasks.

> So what is the actual problem? No more random rants. Explain yourself
> without making wild handwaving gestures.

Wow, you're a bit aggressive, aren't you?  Maybe take your meds in the
morning to stay a bit calmer.  As said before I don't think allowing
random code (and module is a proxy for that) do exit a task.  They
really should not be exiting random kthreads either, but certainly
not more than that.

> Now, there are real exports in this area that are actually strange and
> should be removed: for some historical reason we export 'free_task()'
> which makes no sense to me at all (but probably did at some point).
> 
> Now *that* is a strange export that can mess up another task in major ways.

No argument about that, but that's not the point here.


