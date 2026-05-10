Return-Path: <linux-nfs+bounces-21454-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHxzHv6vAGqBLgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21454-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 10 May 2026 18:19:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84E50511F
	for <lists+linux-nfs@lfdr.de>; Sun, 10 May 2026 18:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 638CC301465D
	for <lists+linux-nfs@lfdr.de>; Sun, 10 May 2026 16:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B990F39FCDD;
	Sun, 10 May 2026 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZm4KVRX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965CA3822B1
	for <linux-nfs@vger.kernel.org>; Sun, 10 May 2026 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778429922; cv=none; b=nqw2bfzUUnTg9tXFbVlRp9HRQTgu7Q4D++do79gmCu8WikDALJgMtkUTX16j78L1NiMbG4ZYHBSRJ78YpIUehqAF00H62j52xaGSc7yyZEMTNb2pUIc8naJwkAMJp7nfVJ32Nnj9e9/ARP7Q7D/uxGFVHpXC2dYjmRymj775LpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778429922; c=relaxed/simple;
	bh=jaJiobhqmBEatYVZgeUjteznE9wyQENeyYC4HU+GyGU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UCQrNHvYbR/TABRhObVnIi98wC7wFDVJukI78jN8JyI+L5XS0Fch+tQK0Mj0b4EGUlkZK8p70Vdy6+YLUDpXqltgnA6v5x1JMOwsAdgAG/THBndnhXqhm/ULP8ja4O6kdxsG4BwbnHKOfqFhH9n5CArLIzxhEdpxAotq8/CNdNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZm4KVRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4393C4AF09;
	Sun, 10 May 2026 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778429922;
	bh=jaJiobhqmBEatYVZgeUjteznE9wyQENeyYC4HU+GyGU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EZm4KVRXkoccaP+Ymy4ZtKqUKWkFnzD30i2DcTSqr1BGvmaShmmkfqbRrnWXZTmI9
	 e9W2jJRT0YcfRsm6JJXFWknAKLUjUAI9KLbVsrETyg7sJF0a1Gkzj5jfDEFgIWTFOs
	 bBi0OTjttzKqBgOYSYHV+CZPlyMvJrjrMv+11QqY8AYCTwS02XGJm5U6NbLg1pnPDR
	 2lqqV2X8QtdtKKAnswBZvMGTXjoJjGruwjleqCP7hj6jaakFupc1I/jxpU7N4LwE8U
	 35eIV5gTFJQue7va0CdhZrFLxGvYPzXnP0QkRi/XzRBKrT+8/78H6XpS0XqK4V7gAi
	 Cse3T7oHTkfhg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BA4AEF4006E;
	Sun, 10 May 2026 12:18:40 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 10 May 2026 12:18:40 -0400
X-ME-Sender: <xms:4K8AaoTS1H-o2WIxXsoTMV4uLsq_zFiGJOSRjR3Rn4E4GhPvlOBXwA>
    <xme:4K8AagkO_wdfQuBYSs-ryndrRBU9aRePkrwwtlX5XzzS0SfqTbwOndblSG5ndSw79
    jU_M6_1lOxw1vaAjCsFWZohtnmS_xMxSJX1bd8IQEhUs-rlXFxOQt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudeiheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgv
    rdgtohhmpdhrtghpthhtoheptghhvghnghiihhhihhgrohdusehhuhgrfigvihdrtghomh
    dprhgtphhtthhopehlihhlihhnghhfvghnghefsehhuhgrfigvihdrtghomhdprhgtphht
    thhopeihrghnghgvrhhkuhhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopeihihdrii
    hhrghngheshhhurgifvghirdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4K8AamYDBxeDvGo973MQ3_570dACMkFPM8RsdQu3RgP0jDwVi7hprg>
    <xmx:4K8AavgaQUx4puxTBa3AR1q6oiwLOw52ZdtipVb_0tuu7VMyUsJKfg>
    <xmx:4K8AamjzTo0RTswzF9ZvNxRjhYKLLyCCp8pOF9-5L8Mqpg3XN_4iuw>
    <xmx:4K8AasCwUvPg0w8bvqbHn8ITxBP4bzUmqZ-EPE4ZkGoEXRyMLk18Fw>
    <xmx:4K8Aau-IbnEwi48kJ_NSo_dyhWsC74Evaw4CDhwRM14873oIKvrHATCX>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8B621780070; Sun, 10 May 2026 12:18:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxcNF55tVgJk
Date: Sun, 10 May 2026 12:18:20 -0400
From: "Chuck Lever" <cel@kernel.org>
To: yangerkun <yangerkun@huawei.com>,
 "Misbah Anjum N" <misanjum@linux.ibm.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 yi.zhang@huawei.com, "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Li Lingfeng" <lilingfeng3@huawei.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <98268bb4-2e97-4728-96a6-37b2a4a3ae5d@app.fastmail.com>
In-Reply-To: <4ee398d0-d2ec-45b2-8214-6e35520fca2d@huawei.com>
References: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
 <c45779f6-fe6c-4037-bb1c-01cfbbaa8aac@huawei.com>
 <76a10e49-54a6-4813-8b58-b7cd0820fdc6@app.fastmail.com>
 <4bb9ed6b-1a64-406a-9239-b0560ca963cc@huawei.com>
 <05f93fc4-59d7-4735-bc7d-a00d1497687a@huawei.com>
 <10019b42-4589-4f9f-8d5b-d8197db1ce3c@huawei.com>
 <39819ad4-3105-4802-b5e2-79e131b25984@huawei.com>
 <f4caa4fa-f15f-4c95-8318-d4ec216e6090@app.fastmail.com>
 <4ee398d0-d2ec-45b2-8214-6e35520fca2d@huawei.com>
Subject: Re: [PATCH 0/6] SUNRPC: Address remaining cache_check_rcu() UAF in cache
 content files
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CC84E50511F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21454-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hi Erkun -

On Sat, May 9, 2026, at 5:41 AM, yangerkun wrote:
> Hmm... /proc/net is always a symlink to /proc/self/net. After opening
> /proc/net/rpc/<cache>/content and attempting to read it, the
> proc_reg_read function calls use_pde before pde_read. This sequence can
> prevent a race condition because nfsd_export_shutdown leads to
> cache_unregister_net, which calls remove_cache_proc_entries, then
> proc_remove, and eventually proc_entry_rundown. The proc_entry_rundown
> function waits until unuse_pde is called in proc_reg_read. Therefore,
> I'm not sure if forgetting to call get_net when opening
> /proc/net/rpc/<cache>/content is the root cause of the null pointer in
> c_show.

Walked the synchronization. You're right.

cache_unregister_net() calls remove_cache_proc_entries(),
which runs proc_remove(); remove_proc_subtree() then invokes
proc_entry_rundown() on each per-cache file. Rundown does
atomic_add_return(BIAS, &de->in_use), where BIAS = -1U << 31.
No active readers means the post-add value equals BIAS and
rundown returns at once. Readers present means the value
exceeds BIAS, and wait_for_completion() blocks until the last
unuse_pde() decrements the counter to exactly BIAS and signals
the completion. atomic_inc_unless_negative() in use_pde() then
fails, so any later read() on a still-open userspace fd
returns -EIO without touching cd. close_pdeo() forces release
on the remaining openers while cd is still valid.
cache_destroy_net() runs only after that whole sequence has
finished, so cd->hash_table is freed once no reader can be
inside cache_seq_*_rcu() and no fd can dereference cd through
a release callback.

The 5/6 changelog overstates the window. Your reproducer
opens /proc/fs/nfs/exports through exports_nfsd_open(), which
bypasses use_pde() and is the path e7fcf179b82d closed. The
sunrpc cache files reach c_show through proc_reg_read(), which
goes through use_pde()/unuse_pde() and is covered by rundown.
5/6 doesn't close the hazard its changelog describes.

Patch 3/6 is what matches Misbah's reproducer. Pre-series
ip_map_put() drops auth_domain_put() synchronously, with only
the ip_map free deferred:

    auth_domain_put(&im->m_client->h);   /* synchronous */
    kfree_rcu(im, m_rcu);

A reader walking auth.unix.ip/content under rcu_read_lock()
can dereference im->m_client after the auth_domain has been
freed. Same shape as 48db892356d6's svc_export fix, applied
to ip_map. 3/6 moves auth_domain_put() into a deferred
ip_map_release() scheduled via queue_rcu_work(), so the
sub-object free waits for the grace period.

For v2: re-test Misbah's reproducer with patches 1-4 and 6
only and see whether 3/6 alone closes the crash. If it does,
drop 5/6; if it doesn't, reframe 5/6 as a consistency change
without the UAF claim (and without the behavioral change that
pins a netns alive while a debug fd is open). Either way, the
cover letter needs a rewrite to match.

Thanks for your analysis and review.

-- 
Chuck Lever

