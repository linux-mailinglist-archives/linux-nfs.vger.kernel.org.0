Return-Path: <linux-nfs+bounces-187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7177FE89B
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 06:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7761C20DD2
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 05:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A97317752;
	Thu, 30 Nov 2023 05:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LeEyo3x3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D456910DB
	for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 21:23:11 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-4644802fc41so196706137.1
        for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 21:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1701321791; x=1701926591; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=clFTnP7WTvR4bhtzJugwDlc26tk+lAvUCjVSn38Mq5k=;
        b=LeEyo3x3qSRvFz0+YGHMY1sCt6vl2g50/MFUsA3cSbGMnIeS5Q6aIWuWaelCzCGuTp
         frz7NQay+ueNF/mJwJsv/srN5Hle/IIlhmkub+AXEf/IHCz3sUaYYsUJmRezFYgs6RYd
         OKcI64KB7msrZCmo8G3jYyM6T5YscoDVHFDeCHtghqQCxCuPLFZPxsxuS6K01Vsg9CeK
         Lb4m7xaGwP7fla8jhyznyaeIcK/rSR+2+RBaiPBR2f5sskNgb2NwmqiNA5RC/X4Vhs2M
         LDcMB1GaepqThxMhlz+tTVt4W0J7+Sdh6QspmNqlOkp9MQPr0Bq84wZSz40ZBKV3jvW+
         WsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701321791; x=1701926591;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clFTnP7WTvR4bhtzJugwDlc26tk+lAvUCjVSn38Mq5k=;
        b=pm6FGspt0aqPZ+78Z3hOdAdYcoR9EA5IzpV0ExpRU1fLeUGm0SboRJSlV76UgxlFy/
         wutA/rQLM94+b5ItZX+EInL6QFYNId9LG3nMgxt6OmCHwFtFCil+PiFEt1vfBfMqC8SZ
         1aSr5s4ZdRC/nRiEFaFW41XdG27bkXcBeR4+x9g8FIR4Im2T+BxaKLRUC+Z4HU2yN5aU
         O219mxK790y5zngLdebth8rGFF+vbmK6WRlL/BY37MI99/VTwPpHgtRvqo910dRKZ0Te
         NF5BS4vsJMyA2mMqiOLnxdc8xOFjsHwijtYAk+VdgiHg7TBcgf8geBy6DJMpgiPWlWTz
         M9+w==
X-Gm-Message-State: AOJu0Yzc3Sf+dJggW8WAIiEUQTB3p6kFn/L7j09BkiS8KmpLybvOvQO/
	eJQ6iCt36kQwXFbusyCDfMd0qI4rZuP1MrxYci/RNTPvbwvvW6w5qJs=
X-Google-Smtp-Source: AGHT+IHr+3RGP8i6pFy3S4XWobbeKKXx/g2JH1465WwYMYSVJeQRudIR5kCg34TzFPPzoknIjsVQSqghRbE96/sqOKk=
X-Received: by 2002:a67:fe4d:0:b0:462:85e1:c46e with SMTP id
 m13-20020a67fe4d000000b0046285e1c46emr20582006vsr.29.1701321790833; Wed, 29
 Nov 2023 21:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Sukruth Sridharan (he/him)" <susridharan@purestorage.com>
Date: Thu, 30 Nov 2023 10:52:59 +0530
Message-ID: <CAMyEAb9XbL55taNXD_MrTxJz62s6ByDWiK8m1Nxj1_G3pg-M6A@mail.gmail.com>
Subject: Hung task panic as part of NFS RDMA Disconnect due to possible bug on
 6.2.0-34-generic client
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I notice the following hung task panic on 6.2.0-34 kernel during RDMA disconnect

[Wed Nov  1 08:03:54 2023] INFO: task kworker/u16:5:2274646 blocked
for more than 120 seconds.
[Wed Nov  1 08:03:55 2023]       Tainted: G        W  OE
6.2.0-34-generic #34-Ubuntu
[Wed Nov  1 08:03:55 2023] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Wed Nov  1 08:03:55 2023] task:kworker/u16:5   state:D stack:0
pid:2274646 ppid:2      flags:0x00004000
[Wed Nov  1 08:03:55 2023] Workqueue: xprtiod xprt_autoclose [sunrpc]
[Wed Nov  1 08:03:55 2023] Call Trace:
[Wed Nov  1 08:03:55 2023]  <TASK>
[Wed Nov  1 08:03:55 2023]  __schedule+0x2aa/0x610
[Wed Nov  1 08:03:55 2023]  schedule+0x63/0x110
[Wed Nov  1 08:03:55 2023]  schedule_timeout+0x157/0x170
[Wed Nov  1 08:03:55 2023]  wait_for_completion+0x88/0x150
[Wed Nov  1 08:03:55 2023]  rpcrdma_xprt_disconnect+0x33f/0x350 [rpcrdma]
[Wed Nov  1 08:03:55 2023]  xprt_rdma_close+0x12/0x40 [rpcrdma]
[Wed Nov  1 08:03:55 2023]  xprt_autoclose+0x5c/0x120 [sunrpc]
[Wed Nov  1 08:03:55 2023]  process_one_work+0x225/0x430
[Wed Nov  1 08:03:55 2023]  worker_thread+0x50/0x3e0
[Wed Nov  1 08:03:55 2023]  ? __pfx_worker_thread+0x10/0x10
[Wed Nov  1 08:03:55 2023]  kthread+0xe9/0x110
[Wed Nov  1 08:03:55 2023]  ? __pfx_kthread+0x10/0x10
[Wed Nov  1 08:03:55 2023]  ret_from_fork+0x2c/0x50
[Wed Nov  1 08:03:55 2023]  </TASK>

The flow which induced the bug is as follows:
1. Client initiates connection
2. Server hands off the response to the first RPC on the connection to
the NIC (Mellanox ConnectX-5)
3. NIC tries to send the response around 6 times and fails the response with RNR
4. Client issues disconnect (possibly because it didn't receive a response)
5. Server cleans up the connection state
6. Client runs into the above panic as part of disconnect while draining the IOs

It looks like re_receiving is set only in rpcrdma_post_recvs, and the
reason why it wouldn't be reset is if memory-region allocation code
fails.
That is possible if disconnect on the client somehow blocks allocation.

void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
{
        // ... (some initialization code)

    if (atomic_inc_return(&ep->re_receiving) > 1)
        goto out;

        // ... (some allocation code)

    if (!wr) // <<<<<<<<<<<<<<<<<< PROBLEM HERE >>>>>>>>>>>>>>>>>>>
        goto out;

        // ... (post recv code, and some error handling)

    if (atomic_dec_return(&ep->re_receiving) > 0)
        complete(&ep->re_done);

out:
    trace_xprtrdma_post_recvs(r_xprt, count);
    ep->re_receive_count += count;
    return;
}

static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
{
    struct rpcrdma_ep *ep = r_xprt->rx_ep;
    struct rdma_cm_id *id = ep->re_id;

    /* Wait for rpcrdma_post_recvs() to leave its critical
     * section.
     */
    if (atomic_inc_return(&ep->re_receiving) > 1) //
<<<<<<<<<<<<<<<<<<< This is not reset, so wait gets stuck
>>>>>>>>>>>>>>>>>
        wait_for_completion(&ep->re_done);

    /* Flush Receives, then wait for deferred Reply work
     * to complete.
     */
    ib_drain_rq(id->qp);

    /* Deferred Reply processing might have scheduled
     * local invalidations.
     */
    ib_drain_sq(id->qp);

    rpcrdma_ep_put(ep);
}

Can you help conclude if the above theory around the bug being in the
client code is right? If not, can you help with steps/data points
required to debug this further?

Thanks in advance.
Sukruth

