Return-Path: <linux-nfs+bounces-16848-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED8CC9BAAC
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 14:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB4F84E3418
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F5731A7F8;
	Tue,  2 Dec 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1DHjj3v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793883115BD;
	Tue,  2 Dec 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764683378; cv=none; b=KwkG1rNf3DFobh6C6vXmnZg5OjCJ0DMSAgBUSMQ0teqf+qQOP9OrKkF/2Ecnnby8L1Q4vj3BxF8KOutlXgYc8xSrIcUx317E3A/qg3lB/THGcNgr6R/edDB1dk0id3od7ZI7/Zg7yDBmp7tcIeFd5z314YNTLWiSmmspb1w9ZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764683378; c=relaxed/simple;
	bh=+k6IKNHwyDdeRTStkY5MAPDxxoHM3AKMvpgF0ZW5rLg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X0n3WDERiFI8srcb7/WpMpzmTR20VoaVnUEDb35cxkYeewL9E7dAnsOf5zPxxeO1pKhd+rOPTt4mIWC4Z/FOZwT1NbN/aJo2FJ25QEsrXOeEeeBOviFW7ANDoWU7i4hN4SgzzZg8sQdMCQhz8wFLCvN4CdSjiswGOePQi27laso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1DHjj3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B32C113D0;
	Tue,  2 Dec 2025 13:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764683378;
	bh=+k6IKNHwyDdeRTStkY5MAPDxxoHM3AKMvpgF0ZW5rLg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Q1DHjj3vO+WgIuWMmF2sfel+ikrQJMwJkBpJlWQ/pc3pBcbOpa5HmjbytMUiB1DRj
	 ADYqix0irgqg80KkxkbB/LSoSCXGTRBtTLJiIq8e+dgQjC6aAePFpqohyNW3u8tUc2
	 dx48KcdwWTPauE5FEynWh/IIFP1S9bXq9jpC3WKt2ZJNbj/6ZL4H4q+dzMTdgigPer
	 LSLEYnfY8xEKnWyplf4cRp1v+bDO/Dr5lFNu3eWR3IICrFIGXjhcsleicNcIBNDIZR
	 bPU0KZuVIgDhAnwJ5+r/Teit++jzetszLneUPVr/OGpnXeIy+pAua3guLB9UUX5JDX
	 ZUBhHKcqUrU5A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B15BCF4007F;
	Tue,  2 Dec 2025 08:49:36 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 02 Dec 2025 08:49:36 -0500
X-ME-Sender: <xms:cO4uabX4rRqLAF8911zqMXEORtCjsQKXWq531zCnZxZ6TedFFoBVvA>
    <xme:cO4uaeZW8MHuDlbIGGBdRh7wTXq6XbcQBegCGHhdwEHYF1Ye8jvYg-2zZDNKFRMG1
    3sAymyPROPDwiQ-zr1c0QbvstMAeYuuDty2QhjeyqsxfXTKS7n53PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghkucfn
    vghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhephf
    ffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvg
    hvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheel
    qdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghlihhsthgrihhrvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrghhise
    hgrhhimhgsvghrghdrmhgvpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdp
    rhgtphhtthhopehhrghrvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgsuhhstg
    hhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnvhhmvgeslhhishht
    shdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthhlshdqhh
    grnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehhtghh
    sehlshhtrdguvgdprhgtphhtthhopehktghhsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:cO4uaZ18EOCh4eaxjtPxseWol4MMiABA-hHsO_BvIcXrWLkkfinFHg>
    <xmx:cO4uacbmN-ujhZi6be-rzXACSehX7XGzIJy88iyrDt-hnya3Mrm8QA>
    <xmx:cO4uabjIoIxgTC7q7JMUfRDBMcE1VDe11Fs8AWQSNPoWZwXqtKfEbA>
    <xmx:cO4uaT-FrzfKGHAUQBo1TQBfLmhxC6Mbta9Hkc374-aj8AwtNa35jg>
    <xmx:cO4uaRPyZ6LKxRuJQ55kTv38cCee-Ua_s0d0wIS4OqGyvTXuDcINuSiD>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 32AA078006C; Tue,  2 Dec 2025 08:49:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: At8y7R5pevGF
Date: Tue, 02 Dec 2025 08:49:12 -0500
From: "Chuck Lever" <cel@kernel.org>
To: alistair23@gmail.com, "Chuck Lever" <chuck.lever@oracle.com>,
 hare@kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, hare@suse.de, "Alistair Francis" <alistair.francis@wdc.com>
Message-Id: <962da16d-b16c-461f-bb35-75c58d89fe3a@app.fastmail.com>
In-Reply-To: <20251202013429.1199659-3-alistair.francis@wdc.com>
References: <20251202013429.1199659-1-alistair.francis@wdc.com>
 <20251202013429.1199659-3-alistair.francis@wdc.com>
Subject: Re: [PATCH v6 2/5] net/handshake: Define handshake_req_keyupdate
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Dec 1, 2025, at 8:34 PM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Add a new handshake_req_keyupdate() function which is similar to the
> existing handshake_req_submit().
>
> The new handshake_req_keyupdate() does not add the request to the hash
> table (unlike handshake_req_submit()) but instead uses the existing
> request from the initial handshake.
>
> During the initial handshake handshake_req_submit() will add the request
> to the hash table. The request will not be removed from the hash table
> unless the socket is closed (reference count hits zero).
>
> After the initial handshake handshake_req_keyupdate() can be used to re-use
> the existing request in the hash table to trigger a KeyUpdate with
> userspace.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v6:
>  - New patch
>
>  net/handshake/handshake.h |  2 +
>  net/handshake/request.c   | 95 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>
> diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
> index a48163765a7a..04feacd1e21d 100644
> --- a/net/handshake/handshake.h
> +++ b/net/handshake/handshake.h
> @@ -84,6 +84,8 @@ void handshake_req_hash_destroy(void);
>  void *handshake_req_private(struct handshake_req *req);
>  struct handshake_req *handshake_req_hash_lookup(struct sock *sk);
>  struct handshake_req *handshake_req_next(struct handshake_net *hn, int 
> class);
> +int handshake_req_keyupdate(struct socket *sock, struct handshake_req 
> *req,
> +			 gfp_t flags);
>  int handshake_req_submit(struct socket *sock, struct handshake_req 
> *req,
>  			 gfp_t flags);
>  void handshake_complete(struct handshake_req *req, unsigned int status,
> diff --git a/net/handshake/request.c b/net/handshake/request.c
> index 274d2c89b6b2..916caab88fe0 100644
> --- a/net/handshake/request.c
> +++ b/net/handshake/request.c
> @@ -196,6 +196,101 @@ struct handshake_req *handshake_req_next(struct 
> handshake_net *hn, int class)
>  }
>  EXPORT_SYMBOL_IF_KUNIT(handshake_req_next);
> 
> +/**
> + * handshake_req_keyupdate - Submit a KeyUpdate request
> + * @sock: open socket on which to perform the handshake
> + * @req: handshake arguments, this must already be allocated and exist
> + * in the hash table, which happens as part of handshake_req_submit()
> + * @flags: memory allocation flags
> + *
> + * Return values:
> + *   %0: Request queued
> + *   %-EINVAL: Invalid argument
> + *   %-EBUSY: A handshake is already under way for this socket

Or, an initial handshake hasn't been done yet. Perhaps that
deserves its own errno value...

Thanks for considering this idea!


> + *   %-ESRCH: No handshake agent is available
> + *   %-EAGAIN: Too many pending handshake requests
> + *   %-ENOMEM: Failed to allocate memory
> + *   %-EMSGSIZE: Failed to construct notification message
> + *   %-EOPNOTSUPP: Handshake module not initialized
> + *
> + * A zero return value from handshake_req_submit() means that
> + * exactly one subsequent completion callback is guaranteed.
> + *
> + * A negative return value from handshake_req_submit() means that
> + * no completion callback will be done and that @req has been
> + * destroyed.
> + */
> +int handshake_req_keyupdate(struct socket *sock, struct handshake_req *req,
> +			    gfp_t flags)
> +{
> +	struct handshake_net *hn;
> +	struct net *net;
> +	struct handshake_req *req_lookup;
> +	int ret;
> +
> +	if (!sock || !req || !sock->file) {
> +		kfree(req);
> +		return -EINVAL;
> +	}
> +
> +	req->hr_sk = sock->sk;
> +	if (!req->hr_sk) {
> +		kfree(req);
> +		return -EINVAL;
> +	}
> +	req->hr_odestruct = req->hr_sk->sk_destruct;
> +	req->hr_sk->sk_destruct = handshake_sk_destruct;
> +
> +	ret = -EOPNOTSUPP;
> +	net = sock_net(req->hr_sk);
> +	hn = handshake_pernet(net);
> +	if (!hn)
> +		goto out_err;
> +
> +	ret = -EAGAIN;
> +	if (READ_ONCE(hn->hn_pending) >= hn->hn_pending_max)
> +		goto out_err;
> +
> +	spin_lock(&hn->hn_lock);
> +	ret = -EOPNOTSUPP;
> +	if (test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags))
> +		goto out_unlock;
> +	ret = -EBUSY;
> +
> +	req_lookup = handshake_req_hash_lookup(sock->sk);
> +	if (!req_lookup)
> +		goto out_unlock;
> +
> +	if (req_lookup != req)
> +		goto out_unlock;
> +	if (!__add_pending_locked(hn, req))
> +		goto out_unlock;
> +	spin_unlock(&hn->hn_lock);
> +
> +	test_and_clear_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags);
> +
> +	ret = handshake_genl_notify(net, req->hr_proto, flags);
> +	if (ret) {
> +		trace_handshake_notify_err(net, req, req->hr_sk, ret);
> +		if (remove_pending(hn, req))
> +			goto out_err;
> +	}
> +
> +	/* Prevent socket release while a handshake request is pending */
> +	sock_hold(req->hr_sk);
> +
> +	trace_handshake_submit(net, req, req->hr_sk);
> +	return 0;
> +
> +out_unlock:
> +	spin_unlock(&hn->hn_lock);
> +out_err:
> +	trace_handshake_submit_err(net, req, req->hr_sk, ret);
> +	handshake_req_destroy(req);
> +	return ret;
> +}
> +EXPORT_SYMBOL(handshake_req_keyupdate);
> +
>  /**
>   * handshake_req_submit - Submit a handshake request
>   * @sock: open socket on which to perform the handshake
> -- 
> 2.51.1

-- 
Chuck Lever

