Return-Path: <linux-nfs+bounces-13415-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F8CB1A98A
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 21:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877D218964A2
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 19:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC61F2163BD;
	Mon,  4 Aug 2025 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9S6HX15"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976EE218AA3
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335278; cv=none; b=V7T6aGH4j57eQS/B8Od6QjEopyNUzT/LRVG7fvxif7eBTgntnQ5xYFTUf1EhP9gw5I/YhMOc/GBID2m6j4KVL2gFVCeUKROKHlZSmQvKod/NghtZYPfNVmCy4gHXJV1ROm6TcHKjSH5ki+nnVrK3GvUBzNTxCiXQP5bd+06Xcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335278; c=relaxed/simple;
	bh=WbNim+Ei2/c6hR2aPVbWmBz7VtfygljhZ7bO06sQEls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W3ZjYR68unKz/czGvKWc6/FUlLCC9ztImoOcoFFlSMSn6hlOYzb3/8E4EshpwteRoM401qwG8fdPYpZT/GxcebsUB+lHAeJJVhyrMNJyJXviFUJdfqnk76ZIhgWWdD/b8/UbG3iaqGxLkzvGhS8rM3ES6QGRYCY2dj6fOsPzM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9S6HX15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C436FC4CEE7;
	Mon,  4 Aug 2025 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754335276;
	bh=WbNim+Ei2/c6hR2aPVbWmBz7VtfygljhZ7bO06sQEls=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=a9S6HX15Iflt2cR/KmdkqYepkxVtezTzxIyZARQobOWZ3p4LV0C1cD1qAKNhM5prk
	 65sgwne/KU4pRXyquj0l+m3qdjHY4Q9L6s6cJEMKbYo+doi/R+dF3kx2c2B2A1IGTr
	 D67qx9XK2FjfeI4sGZ9132AIOF1BlKQfqFDUF/R7v807wWfAsLOEPQxia+Pu/ifnEZ
	 EFyAuKWXY2B38YlgJsM7xk948rjc/b58uoFxniF1Uvpht9BOxSt0lw6PUx7TGuPai/
	 dvDEs/wPk0VXgSfZIWYsjtjzKNvFvtcgASSlo+i1RkwFsxNp9S0zZxgm76yzADoygz
	 idROveGpByqsQ==
Message-ID: <48287a80e639d61eb507175ceb44d216e8032510.camel@kernel.org>
Subject: Re: [PATCH 1/1] SUNRPC: call_connect_status needs to destroy
 transport on ETIMEDOUT before retry
From: Trond Myklebust <trondmy@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Mon, 04 Aug 2025 12:21:14 -0700
In-Reply-To: <1754334505-65027-1-git-send-email-dai.ngo@oracle.com>
References: <1754334505-65027-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-04 at 12:08 -0700, Dai Ngo wrote:
> Currently, when an RPC connection times out during the connect phase,
> the task is retried by placing it back on the pending queue and
> waiting
> again. In some cases, the timeout occurs because TCP is unable to
> send
> the SYN packet. This situation most often arises on bare metal
> systems
> at boot time, when the NFS mount is attempted while the network link
> appears to be up but is not yet stable.
>=20
> This patch addresses the issue by updating call_connect_status to
> destroy
> the transport on ETIMEDOUT error before retrying the connection. This
> ensures that subsequent connection attempts use a fresh transport,
> reducing the likelihood of repeated failures due to lingering network
> issues.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> =C2=A0net/sunrpc/clnt.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 21426c3049d3..701b742750c5 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2215,6 +2215,7 @@ call_connect_status(struct rpc_task *task)
> =C2=A0	case -EHOSTUNREACH:
> =C2=A0	case -EPIPE:
> =C2=A0	case -EPROTO:
> +	case -ETIMEDOUT:
> =C2=A0		xprt_conditional_disconnect(task->tk_rqstp->rq_xprt,
> =C2=A0					=C2=A0=C2=A0=C2=A0 task->tk_rqstp-
> >rq_connect_cookie);
> =C2=A0		if (RPC_IS_SOFTCONN(task))
> @@ -2225,7 +2226,6 @@ call_connect_status(struct rpc_task *task)
> =C2=A0	case -EADDRINUSE:
> =C2=A0	case -ENOTCONN:
> =C2=A0	case -EAGAIN:
> -	case -ETIMEDOUT:
> =C2=A0		if (!(task->tk_flags & RPC_TASK_NO_ROUND_ROBIN) &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 (task->tk_flags & RPC_TASK_MOVEABLE) &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 test_bit(XPRT_REMOVE, &xprt->state)) {

Why is this needed? The ETIMEDOUT is supposed to be a task level error,
not a connection level thing.

Oh... Is this because of TLS? If so, then please fix that to use a more
appropriate error.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

