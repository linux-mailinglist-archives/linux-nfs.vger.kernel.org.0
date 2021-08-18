Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504083EF78E
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Aug 2021 03:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhHRBdc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Aug 2021 21:33:32 -0400
Received: from p3plsmtpa07-07.prod.phx3.secureserver.net ([173.201.192.236]:49657
        "EHLO p3plsmtpa07-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235913AbhHRBdc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Aug 2021 21:33:32 -0400
Received: from [192.168.0.100] ([68.239.50.225])
        by :SMTPAUTH: with ESMTPSA
        id GARsmSFfWjPrbGARsmgQnx; Tue, 17 Aug 2021 18:32:57 -0700
X-CMAE-Analysis: v=2.4 cv=H9Uef8Ui c=1 sm=1 tr=0 ts=611c6349
 a=Rhw2r8FBodfaBxRKvGSZLA==:117 a=Rhw2r8FBodfaBxRKvGSZLA==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=v6UmensoNeAhzW2F1V4A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
From:   Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH RFC] xprtrdma: Move initial Receive posting
To:     Chuck Lever <chuck.lever@oracle.com>, haakon.bugge@oracle.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
References: <162922469165.515267.14848799693507242987.stgit@manet.1015granger.net>
Message-ID: <cbc92df6-ed85-de7f-0589-fb03cef49060@talpey.com>
Date:   Tue, 17 Aug 2021 21:32:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162922469165.515267.14848799693507242987.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIsI1Q+XCrexVKBaFgWBYHfxLUnPNW2ErgeNbt8rJF1zo763+yQaBlf98Jyw9ULsFcJQUmbqFENlPyhyoEyXjPPcszwxy5CEpKVSk8HIxlPO7yE6KDrs
 IqT1lS9NfLBTvzNLO1jrjqx/47izMigRQGS04XJ2XjCgGEBVTbfi5KEJ54KlzOydr2TfQhLjNaoQl8As1n8e3WeYXdU4qq17kW3Q+EQCAmZ+fMydpfugq7we
 m6E0Y/ddD4IoPd49lJKsAiZHxrJyxBJOnkm+8rmNIh1RHVr8OZ7wjqNnTJnhXrZDknmgn5jfHjF9jlYqQWCOIw==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> The first available moment after cm_send_req where xprtrdma can post
> Receives is when the RDMA core reports the QP connection has been
> established.

This has significant implications to upper layer protocols. It
means that the listener cannot safely send the first message on
a new connection. This constrains the upper layer protocol to
be client/server style, with the active-side ULP first to send.

If the CM is changed in the way described here, peer-to-peer
protocols will be rendered unusable, as the passive side cannot
reliably send the first message since the connection will have
no receive posted. The MPA Extensions in RFC6581 discuss this,
and support peer-to-peer connection models with the "A" flag
(section 9.2) enabling passive-first ULPs.

Posting receives and awakening client processing as proposed below
does not close this race. A passive-side-first protocol will have
already begun to send, regardless of this rearrangement. It's an
inherent race and will not interoperate reliably.

Why change the CM API? The IB spec is not authoritative on this,
and there currently is no bug, right?

Tom.

On 8/17/2021 2:24 PM, Chuck Lever wrote:
> Håkon Bugge points out that rdma_create_qp() is not supposed to 
> return a QP that is ready for Receives to be posted. It so happens 
> that ours does that, but the IBTA spec (12.9.7.1) states that a 
> transition to INIT happens only after REQ has been sent.
> 
> In future kernels, QPs returned from rdma_create_qp() might not be in
> a state where posting Receives will succeed. This patch is a
> pre-requisite to changing the legacy behavior of rdma_create_qp().
> 
> The first available moment after cm_send_req where xprtrdma can post
> Receives is when the RDMA core reports the QP connection has been
> established.
> 
> Note that xprtrdma has posted Receives just after rdma_create_qp() 
> since 8d4fb8ff427a ("xprtrdma: Fix disconnect regression"). To avoid 
> regressing 8d4fb8ff427a, xprtrdma needs to ensure that initial 
> Receive WRs are posted before pending RPCs are awoken. It appears 
> that the current logic does provide that guarantee.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com> --- 
> net/sunrpc/xprtrdma/verbs.c |   12 ++++++------ 1 file changed, 6
> insertions(+), 6 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/verbs.c
> b/net/sunrpc/xprtrdma/verbs.c index aaec3c9be8db..87ae62cdea18
> 100644 --- a/net/sunrpc/xprtrdma/verbs.c +++
> b/net/sunrpc/xprtrdma/verbs.c @@ -520,12 +520,6 @@ int
> rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt) 
> xprt_clear_connected(xprt); rpcrdma_reset_cwnd(r_xprt);
> 
> -	/* Bump the ep's reference count while there are -	 * outstanding
> Receives. -	 */ -	rpcrdma_ep_get(ep); -	rpcrdma_post_recvs(r_xprt, 1,
> true); - rc = rdma_connect(ep->re_id, &ep->re_remote_cma); if (rc) 
> goto out; @@ -539,6 +533,12 @@ int rpcrdma_xprt_connect(struct
> rpcrdma_xprt *r_xprt) goto out; }
> 
> +	/* Bump the ep's reference count while there are +	 * outstanding
> Receives. +	 */ +	rpcrdma_ep_get(ep); +	rpcrdma_post_recvs(r_xprt, 1,
> true); + rc = rpcrdma_sendctxs_create(r_xprt); if (rc) { rc =
> -ENOTCONN;
> 
> 
> 
