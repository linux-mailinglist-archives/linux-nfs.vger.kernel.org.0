Return-Path: <linux-nfs+bounces-4870-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DD392FCB5
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 16:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00753B224B8
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EACA16F83D;
	Fri, 12 Jul 2024 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfohMUU+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7DB1482EE
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jul 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795061; cv=none; b=l+eOQOOyvAvmoFYSkSp+Qr/0XOw4We+FyewV2hX8wFCLegWRr5FVK9DORXMVP939lVxVppHj9VZjK4lIciMt2yFlR/BOgt9dZGbCtLBvDryk3hxEWyjXYk2hLBfDbtTKMyTmly7wQZQWwEIxc6qIPiKPXmeoimeaT/EJEx0VRBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795061; c=relaxed/simple;
	bh=kMa69oHFwyTcSDxv2R+a64PUZd8TYus2JMIwvFEpO5E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CqNR2zU2TJ2hIhsWbvKW3Olkf1h/2FUJ0T9BkdWCBTXf7et+2mrlq/LV0PcI8iNeImnH2gOXvjv0fgrFLZYZ4oDquuvxW3jhMdRa+xcgJoy+Gjj/LI9srewE6WnGfxQO1WHawZ4PkK1V1b8N8+pOJshWzlULBfRqPM1cMXhJGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfohMUU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375ACC32782;
	Fri, 12 Jul 2024 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720795060;
	bh=kMa69oHFwyTcSDxv2R+a64PUZd8TYus2JMIwvFEpO5E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AfohMUU+o5WpHnXSiJMbHRlwDcsCw3qfOMdB8OF1ot2j4ohCNbOTcpfr44+TleyQR
	 6Af7y1Z5HYGAgjgIrHGJQH+jA82qSNPbVqIf/GPozaNQVWNtrPP4GC+TvfvO99DGKj
	 u7cKqnS6JLAhdk07CyyS0T6WpXgKic94T/TpMQkeYiAz552ON4IPXBJYRJ8jmtTfme
	 Ca4UFGQEqUzsectr4uBglfnZSTHM2VP7VNvzvqGdoeYs/mm859NzovLt5sisWeiP6s
	 HHkqAC/54T2xcts6UKc+eCnpbaKt2EQ1WJxbYfavDTPtXtd6hNTL1/wXPYDe4tb8NX
	 Jvbqv/Fs41e+w==
Message-ID: <8d879d69848464b7e67d0e04a1b61cc66e739fb5.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix a race to wake a sync task
From: Jeff Layton <jlayton@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>, Trond Myklebust
	 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Date: Fri, 12 Jul 2024 10:37:38 -0400
In-Reply-To: <4c1c7cd404173b9888464a2d7e2a430cc7e18737.1720792415.git.bcodding@redhat.com>
References: 
	<4c1c7cd404173b9888464a2d7e2a430cc7e18737.1720792415.git.bcodding@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-12 at 09:55 -0400, Benjamin Coddington wrote:
> We've observed NFS clients with sync tasks sleeping in __rpc_execute
> waiting on RPC_TASK_QUEUED that have not responded to a wake-up from
> rpc_make_runnable().=C2=A0 I suspect this problem usually goes unnoticed,
> because on a busy client the task will eventually be re-awoken by
> another
> task completion or xprt event.=C2=A0 However, if the state manager is
> draining
> the slot table, a sync task missing a wake-up can result in a hung
> client.
>=20
> We've been able to prove that the waker in rpc_make_runnable()
> successfully
> calls wake_up_bit() (ie- there's no race to tk_runstate), but the
> wake_up_bit() call fails to wake the waiter.=C2=A0 I suspect the waker is
> missing the load of the bit's wait_queue_head, so waitqueue_active()
> is
> false.=C2=A0 There are some very helpful comments about this problem abov=
e
> wake_up_bit(), prepare_to_wait(), and waitqueue_active().
>=20
> Fix this by inserting smp_mb() before the wake_up_bit(), which pairs
> with
> prepare_to_wait() calling set_current_state().
>=20
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
> =C2=A0net/sunrpc/sched.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index 6debf4fd42d4..34b31be75497 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -369,8 +369,11 @@ static void rpc_make_runnable(struct
> workqueue_struct *wq,
> =C2=A0	if (RPC_IS_ASYNC(task)) {
> =C2=A0		INIT_WORK(&task->u.tk_work, rpc_async_schedule);
> =C2=A0		queue_work(wq, &task->u.tk_work);
> -	} else
> +	} else {
> +		/* paired with set_current_state() in
> prepare_to_wait */
> +		smp_mb();
> =C2=A0		wake_up_bit(&task->tk_runstate, RPC_TASK_QUEUED);
> +	}
> =C2=A0}
> =C2=A0
> =C2=A0/*

Nice catch!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

