Return-Path: <linux-nfs+bounces-12441-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0B3AD9133
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 17:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919C11BC3B83
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 15:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EA71E1DE7;
	Fri, 13 Jun 2025 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdVSl1sY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BB01E32D3
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828205; cv=none; b=LAMuPGQQ5lfhCFbtsP7ZUv8GIeT2CpuqdWq/+wr3KjdYVfbw0Ju6BgmawidSTg5f5NJbFUGYkuLeRJNl4rjb1rmRIxy/UZ41kLp8AEYevojBh6yGfKDEKyDC8GqyHXMLIsU5cRNATuDKSa480koQv4FWLvuD2jm/3p0x0C+pxEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828205; c=relaxed/simple;
	bh=/hXfFYfBfbotrpQpMR/vgWRHOpzAwTsszsgRbICb1ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R84jYb7N60DvhPuC3iorWH8hnCBgxXr8lygclrYMlmpL61DD2gLIfK2Nsh3E4f+2fKpMewHhU2l95r15kCPbvnRQyVLq8nHLtXIMDKHrxDnVKk5jMft2szYGffagW73cd6sMkvfoHPlrPyJwqbWUBP95hqalo+158ljCgDP9hYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdVSl1sY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749828202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1p5HdA5CaRZpyjsJJugbtkVKQTEXEDNVElJiBH9/rEM=;
	b=cdVSl1sYWST5Aox4DYgP7yyzAEbm9uD6R1CwO0ckafg3ann2mEdWvYl0Jd9PTFPiuJx/Zg
	mF8hnRjgTr7zuC2EhWoAkMs5Lt42f6wrByYVAubIEFmLJK3+8ICtExgLCCTCBLl/kQOHdQ
	1TJt4htz3nA57wOWNTjRPzBLXPSyqZA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-C0We3tJzMne5spLZueix3g-1; Fri,
 13 Jun 2025 11:23:17 -0400
X-MC-Unique: C0We3tJzMne5spLZueix3g-1
X-Mimecast-MFC-AGG-ID: C0We3tJzMne5spLZueix3g_1749828195
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71891195609F;
	Fri, 13 Jun 2025 15:23:14 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6EEA180045C;
	Fri, 13 Jun 2025 15:23:09 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: use threads array as-is in netlink interface
Date: Fri, 13 Jun 2025 11:23:07 -0400
Message-ID: <6D3B09C4-0E35-4A98-8C29-C2EDDBD17163@redhat.com>
In-Reply-To: <df0a6fc5-6ef9-44b6-b6c2-e3cb4a2d1512@oracle.com>
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
 <20250527-rpc-numa-v1-1-fa1d98e9a900@kernel.org>
 <a8d4c4cffe1a35ea831110ce1c7beea649352238.camel@kernel.org>
 <ae18305b-167d-4f27-bc3b-3d2d5f216d85@oracle.com>
 <1cd4d07f7afbd7322a1330a49a2cc24e8ff801cd.camel@kernel.org>
 <38f1974c-f487-49b0-9447-74ed2db6ca7e@oracle.com>
 <7DCDEBE1-1416-4A93-B994-49A6D21DC065@redhat.com>
 <df0a6fc5-6ef9-44b6-b6c2-e3cb4a2d1512@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 13 Jun 2025, at 10:56, Chuck Lever wrote:

> On 6/13/25 7:33 AM, Benjamin Coddington wrote:
>> We don't consider it acceptable to allow known defects to persist in our
>> products just because they are bleeding edge.
>
> I'm not letting this issue persist. Proper testing takes time.
>
> The patch description and discussion around this change did not include
> any information about its pervasiveness and only a little about its
> severity. I used my best judgement and followed my usual rules, which
> are:
>
> 1. Crashers, data corrupters, and security bugs with public bug reports
>    and confirmed fix effectiveness go in as quickly as we can test.
>    Note well that we have to balance the risk of introducing regressions
>    in this case, since going in quickly means the fix lacks significant
>    test experience.
>
> 1a. Rashes and bug bites require application of topical hydrocortisone.

:) no rash here, this response is very soothing.

> 2. Patches sit in nfsd-testing for at least two weeks; better if they
>    are there for four. I have CI running daily on that branch, and
>    sometimes it takes a while for a problem to surface and be noticed.
>
> 3. Patches should sit in nfsd-next or nfsd-fixes for at least as long
>    as it takes for them to matriculate into linux-next and fs-next.
>
> 4. If the patch fixes an issue that was introduced in the most recent
>    merge window, it goes in -fixes .
>
> 5. If the patch fixes an issue that is already in released kernels
>    (and we are at rule 5 because the patch does not fix an immediate
>    issue) then it goes in -next .
>
> These evidence-oriented guidelines are in place to ensure that we don't
> panic and rush commits into the kernel without careful review and
> testing. There have been plenty of times when a fix that was pushed
> urgently was not complete or even made things worse. It's a long
> pipeline on purpose.

I totally understand, thanks very much for having a set of rules and
guidelines and even more for taking the time to spell them out here.

I wanted to express that Red Hat does consider all of its releases to be
important to fix and maintain. I'd like to speak against arguments about fix
urgency based on distro versions.  I think in this case we innocently crept
into these arguments as Jeff presented evidence that the problem exists in
the wild.

> The issues with this patch were:
>
> - It was posted very late in the dev cycle for v6.16. (Jeff's urgent
>   fixes always seem to happen during -rc7 ;-)
>
> - The Fixes: tag refers to a commit that was several releases ago, and
>   I am not aware of specific reports of anyone hitting a similar issue.
>
> - IME, the adoption of enterprise distributions is slow. RHEL 10 is
>   still only on its GA release. Therefore my estimation is that the
>   number of potentially impacted customers will be small for some time,
>   enough time for us to test Jeff's fix appropriately.

While this is true, I hope we can still treat every release version equally
/if/ we make any arguments about urgency based on what's currently released
in a particular distro.  Your point is a good counter-arguement to Jeff's
assertion that the problem has been widely distributed - but it does start
to creep into a space which feels like we're treating certain early versions
of a specific distro differently and didn't sit well for me.  I'd rather not
have our upstream work or decisions appear to favor a particular distro.

> - The issue did not appear to me to be severe, but maybe I didn't read
>   the patch description carefully enough.
>
> - Although I respect, admire, and greatly appreciate the effort Jeff
>   made to nail this one, that does not mean it is a pervasive problem.
>   Jeff is quite capable of applying his own work to the kernels he and
>   his employer care about.
>
<snip>
>
> It sounds like Red Hat also does not have clear evidence that links this
> patch to a specific failure experienced by your customers. This affirms
> my understanding that this fix is defensive rather than urgent.

Also true - not yet, but there's a significant lag between customers
discovering a problem and our engineers knowing about it, and during that
lag all sorts of time, money, and reputation points are lost.

> As a rule, defensive fixes go in during merge windows.
>
>> Its a real pain that we won't have an upstream commit assigned for it.
>
> It's not reasonable for any upstream maintainer not employed by Red Hat
> to know about or cleave to Red Hat's internal processes. But, if an
> issue is on Red Hat's radar, then you are welcome to make its priority
> known to me so I can schedule fixes appropriately.

Thanks!  I realize that, which is why I spoke up.

> All that said, I've promoted the fix to nfsd-fixes, since it's narrow
> and has several weeks of test experience now.

Again, thanks!  We greatly appreciate the work you're doing.

Best,
Ben


