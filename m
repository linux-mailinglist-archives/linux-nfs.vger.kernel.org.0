Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A59219127
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgGHUJD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgGHUJD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:09:03 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D000AC061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:09:02 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w34so15529938qte.1
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=p5hp8EIZDWTIEQsrL+V/T4/nEmJWNqPBbpmgkR89Hpc=;
        b=tzdrK7MJkgVRtgfCyOKIKpnJ/POWhxSsjXUsuhQ47WtA0VIAWs0UcSbLrymFXo6nKl
         gZQRpGJVhioEuaEapZJr/D75EkRlGCLgrt6z+eDSbxhFToZ8/waGRk6btcYN4q6xT0u5
         xaXqU+ZtZn0v5AkONXpDgAYkBo60I09tjRp6bqlII4ZomrycbjwWnPKurxScoqF2l15P
         t+MozyeYofM9xnj/zaVE2KdQ1afu+zWyurlg40xsX+MLgNRTj+uMBrVFP9TVdjWMdgtR
         YmgTOmx94zSxqz1Tb+Y+5Ca8eqyoUIiepub+ZBYj8Fz2REGUEC2xhoB5NxqYIPpfz5cc
         BSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=p5hp8EIZDWTIEQsrL+V/T4/nEmJWNqPBbpmgkR89Hpc=;
        b=neJyDtx3O3TjcFCyKtHjJC4GkvPh13hEsy4tcANc4lQ1inIy1bMFon3y9HYZOuA6zU
         rLUmMry3WpHc9pbLhbMxx5wD3xPKEhf0QjxJOO1+z971dgnmM4jZKsNHcJQvB1zSfJIP
         gfdRrVh9F1Jk11SagSdrEwbsKy22V0kKqyPiOWd3V3Kh6pTLu1wrqp4FUwfBpO9ZUZnk
         /oZ1eJz0bnpYP73CvyTiLB2GvZ9UGrtitZ/rNiK1TgzMTLcSdm38/LyAEKj+3mfdKHRG
         dB2RyMP2JsI+PaacCWa8rQ8A/Vy4cvgXG/EpVjnay3tlhdtPj9Xh+JUd9FFvRR7gruer
         Rv8w==
X-Gm-Message-State: AOAM532HyX/5yvhNG94WD9IFA8ryqx9VzmQVMsXjBpiyLupeQ1o4luSd
        r0rEOa5BJKK8+Dxz5c2etIge41S7
X-Google-Smtp-Source: ABdhPJw8Ud1i/pUcy+RZOZNM283QT9/EgVjVPvIF+8N1DJ5HYNT3kycOVXzMeKwkOOfcrKoI3vuoYQ==
X-Received: by 2002:ac8:1809:: with SMTP id q9mr56121889qtj.107.1594238941844;
        Wed, 08 Jul 2020 13:09:01 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k14sm955881qtb.38.2020.07.08.13.09.01
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:09:01 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068K8xSL006063
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:09:00 GMT
Subject: [PATCH v1 00/22] SUNRPC: Replace dprintk calls with tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:08:59 -0400
Message-ID: <20200708200121.22129.92375.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

This series replaces many client-side RPC dprintk call sites with
tracepoints. The goals of this series are:

- Replace chatty dprintk call sites with tracepoints, which can
  handle a higher event rate, and won't get rate-limited.

- At some later point, expand the 0-64K range of RPC task IDs.
  Task IDs would be displayed only by tracepoints as 32-bit unsigned
  integers.

- Eliminate redundant tracepoints in the transport implementations.

---

Chuck Lever (22):
      SUNRPC: Remove trace_xprt_complete_rqst()
      SUNRPC: Hoist trace_xprtrdma_op_allocate into generic code
      SUNRPC: Remove debugging instrumentation from xprt_release
      SUNRPC: Update debugging instrumentation in xprt_do_reserve()
      SUNRPC: Replace dprintk() call site in xprt_prepare_transmit
      SUNRPC: Replace dprintk() call site in xs_nospace()
      SUNRPC: Remove the dprint_status() macro
      SUNRPC: Remove dprintk call site in call_start()
      SUNRPC: Replace connect dprintk call sites with a tracepoint
      SUNRPC: Mitigate cond_resched() in xprt_transmit()
      SUNRPC: Add trace_rpc_timeout_status()
      SUNRPC: Trace call_refresh events
      SUNRPC: Remove dprintk call site in call_decode
      SUNRPC: Clean up call_bind_status() observability
      SUNRPC: Remove rpcb_getport_async dprintk call sites
      SUNRPC: Hoist trace_xprtrdma_op_setport into generic code
      SUNRPC: Remove dprintk call sites in rpcbind XDR functions
      SUNRPC: Remove more dprintks in rpcb_clnt.c
      SUNRPC: Replace rpcbind dprintk call sites with tracepoints
      SUNRPC: Clean up RPC scheduler tracepoints
      SUNRPC: Remove dprintk call sites in RPC queuing functions
      SUNRPC: Remove remaining dprintks from sched.c


 include/trace/events/rpcrdma.h  |  63 -------
 include/trace/events/sunrpc.h   | 285 ++++++++++++++++++++++++++++----
 net/sunrpc/clnt.c               |  75 ++-------
 net/sunrpc/rpcb_clnt.c          | 129 +++------------
 net/sunrpc/sched.c              |  52 +-----
 net/sunrpc/xprt.c               |  22 +--
 net/sunrpc/xprtrdma/transport.c |   7 -
 net/sunrpc/xprtsock.c           |   5 +-
 8 files changed, 304 insertions(+), 334 deletions(-)

--
Chuck Lever
