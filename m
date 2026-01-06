Return-Path: <linux-nfs+bounces-17516-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1625CFB17E
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 22:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53D9C300D403
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 21:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9A62C0290;
	Tue,  6 Jan 2026 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acd42J9I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F53C84039;
	Tue,  6 Jan 2026 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767734826; cv=none; b=DSpvgGtFzKO9a3OZS2pemzRhjaudkOAeYnJamd+Vr8SLmFT4LDJEhCJOzXD1wh0tdnudgmfzKoBB3n+DyOERaWDtIFt6rt1JjKpK34rSYbUlhnvbQ5w40Vggrn+QWPnjfAjf49VWOgCezgrRttpKy7h29p8GKvG8E8kFqmfltnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767734826; c=relaxed/simple;
	bh=ch+Q+y8sE/bhvqFeAXNnVj1n9zSnQh/EdWe/jE35zK8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MHVJDy4tBUYAvQUifkpEqDpvKWyQE95BhbyMFG+lbHzLZcDP4OYycH3FK5YdH58fDABrOcKSozygWXrKpX+y2KeDzCW02Ul+7x5jcT9aICqJKHyTP0r9Sc20L/CARWgK3ZMF7W1Z9VFgIolVB7CDS/qmmFKF/tIBoePVhsZkzGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acd42J9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9684CC19421;
	Tue,  6 Jan 2026 21:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767734826;
	bh=ch+Q+y8sE/bhvqFeAXNnVj1n9zSnQh/EdWe/jE35zK8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=acd42J9IL6nxh6g9do2CNAlBEwLbFyaWgVDtLbyzIj2mtvrw6CNH0Eyhw588dxtdH
	 bcsa7QW8a4AIa4BqHW687ZN/7edDFW5+u0f9QtB10Yow/eW0NI/kG8/2gZyi28dTkk
	 a3UveElq8nl+bvHf4CavMCP8Q2/RTT6aT49BsxQpCGYu5+e0JSpf4at0qk3acoi74s
	 cr1wGHVbzE4TWth02jOAoTgwal6Xyl8eGEYBdvqeQ1PSF0YoyN+o6uE6xs67Ibl6tH
	 H8YmvuGd9eMCm4m2m3FbVTWC/Ai5v7xg/QGSR0Y+CZaKSh8lpHdSNwaITU6zF+tocx
	 GuhDdf+MUVJQA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9E3F5F4006B;
	Tue,  6 Jan 2026 16:27:04 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 06 Jan 2026 16:27:04 -0500
X-ME-Sender: <xms:KH5daY-Vv01J-Wz--dzk3Erxw6Ee7UaDyi0ldULjWpe3P3OhfcJcvA>
    <xme:KH5dabj7U_jOio0eDA87I1BaP6_FO9sCNWbRX--22XU5zZkfea6GrbLAIs7UAxPm9
    ICdPYh4laV4COAINc6-h37pajKQeSOHNYQuaU6xjkoA0CQs0jcSs8NJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdduvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejvefhudehleetvdejhfejvefghfelgeejvedvgfduuefffeegtdejuefhiedukeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    pedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrd
    hnrghmvgdprhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpth
    htohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmseht
    rghlphgvhidrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KH5daQKkMtRfsM_LrIaJTlk_UKgOUyuaBTvhUN9SCmZYLCR_guQyDA>
    <xmx:KH5daWIYxJ-Rjd4y1Zcz8HgWrna5ceFOGjS2MvuO9MGJw9aD4Jsy6A>
    <xmx:KH5dabjWfj4GsmdoYF0ZCXv2v9s5q64FR0zZdxOdfHVvHNyZvMdBGA>
    <xmx:KH5daQPN_NSD4-OI74D1QM8VaTAkpQA-YjwbiNpKzdEcrS_xO5uWXQ>
    <xmx:KH5daWq-EvL2_j4ZH14TD1TX5lvjwofD2tA0JFDjhpZ3qsA26ujqD4RR>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7BF6D780054; Tue,  6 Jan 2026 16:27:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApDpzUHv5Bgo
Date: Tue, 06 Jan 2026 16:26:43 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <5081c9a2-2a2a-469d-9df8-eef6be2d05ac@app.fastmail.com>
In-Reply-To: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
References: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
Subject: Re: [PATCH v2 0/8] nfsd, sunrpc: allow for a dynamically-sized threadpool
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Jan 6, 2026, at 1:59 PM, Jeff Layton wrote:
> This version of the patchset fixes a number of warts in the first, and
> hopefully gets this closer to something mergeable.
>
> This patchset allows nfsd to dynamically size its threadpool as needed.
> The main user-visible change is the addition of new controls that allow
> the admin to set a minimum number of threads.
>
> When the minimum is set to a non-zero value, the traditional "threads"
> setting is interpreted as a maximum number of threads instead of a
> static count. The server will start the minimum number of threads, and
> then ramp up the thread count as needed. When the server is idle, it
> will gradually ramp down the thread count.
>
> This control scheme should allow us to sanely switch between kernels
> that do and do not support dynamic threading. In the case where dynamic
> threading is not supported, the user will just get the static maximum
> number of threads, just like they do today.
>
> So far this is only lightly tested, but it seems to work well. I
> still need to do some benchmarking to see whether this affects
> performance, so I'm posting this as an RFC for now.
>
> Does this approach look sane to everyone?
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v2:
> - svc_recv() now takes a timeout parameter. This should mean that
>   non-dynamic RPC services are unaffected by these changes.
> - if min_threads is larger than the max, then clamp it to the max
> - simplify SP_TASK_STARTING usage. Have same task set and clear it.
> - rework thread starting logic (EBUSY handling)
> - reorder arguments to svc_set_num_threads() and svc_set_pool_threads()
> - break up larger patches
> - Link to v1: 
> https://lore.kernel.org/r/20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org
>
> ---
> Jeff Layton (8):
>       sunrpc: split svc_set_num_threads() into two functions
>       sunrpc: remove special handling of NULL pool from 
> svc_start/stop_kthreads()
>       sunrpc: track the max number of requested threads in a pool
>       sunrpc: introduce the concept of a minimum number of threads per 
> pool
>       sunrpc: split new thread creation into a separate function
>       sunrpc: allow svc_recv() to return -ETIMEDOUT and -EBUSY
>       nfsd: adjust number of running nfsd threads based on activity
>       nfsd: add controls to set the minimum number of threads per pool
>
>  Documentation/netlink/specs/nfsd.yaml |   5 +
>  fs/lockd/svc.c                        |   6 +-
>  fs/nfs/callback.c                     |  10 +-
>  fs/nfsd/netlink.c                     |   5 +-
>  fs/nfsd/netns.h                       |   6 +
>  fs/nfsd/nfsctl.c                      |  50 ++++++++
>  fs/nfsd/nfssvc.c                      |  63 +++++++---
>  fs/nfsd/trace.h                       |  54 +++++++++
>  include/linux/sunrpc/svc.h            |  13 ++-
>  include/linux/sunrpc/svcsock.h        |   2 +-
>  include/uapi/linux/nfsd_netlink.h     |   1 +
>  net/sunrpc/svc.c                      | 210 ++++++++++++++++++++--------------
>  net/sunrpc/svc_xprt.c                 |  44 +++++--
>  13 files changed, 349 insertions(+), 120 deletions(-)
> ---
> base-commit: 83f633515af9382e7201e205112e18b995a80f70
> change-id: 20251212-nfsd-dynathread-9f7a31172005
>
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>

I'm comfortable with this series. Let me know when you are
ready for me to apply it.


-- 
Chuck Lever

