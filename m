Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097662AC516
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgKITjO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgKITjN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:39:13 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCAEC0613CF;
        Mon,  9 Nov 2020 11:39:13 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id i12so6871810qtj.0;
        Mon, 09 Nov 2020 11:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=t5vKQ3DBurhpHWsk+vZ6IgAWtNSB/Q9LOTiLdC1uhQo=;
        b=F1G08VjwVl89rLcvQ/Bo90S9O3GMLCZDMzsKG5Aip65ActQxx53Oig2H84ALM2ai4H
         zJ4IVOM9Wm2AnSAvsnkphP9uQ1xs67f0zqZy/VAIunAJsj55mS/uDT2jtW0uRirOKjbG
         3e4SnpJ9+y5frZpdoLJBpTPVfmpX31iAZQ2uCqamNnePb4FV9PDwdbybx7Zj8t1ZP8oK
         o6l7ofEsK4Tj6ZuKwQDG7Oa3DfE1akHfJJyyE/yjM+BzUKC1zjqnFwitoisU2Ox8DU7F
         rbw80vn6ceWZHAh2j+XHkoyCozfxEEC7srutvKDC3xXMomNqE5iXiMNHNvVlhd3/62v8
         j8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=t5vKQ3DBurhpHWsk+vZ6IgAWtNSB/Q9LOTiLdC1uhQo=;
        b=iEaiwXclYMzuy+15vYjwgdOr+beGdUD4TfqET98jU4ELVyNVGnBgVSgB07fqJWqF8n
         H164tZYoewE3AMJv8ZmJdDkWga3SauwzSTtjECIkgvswbnZN8zIhF3LsKXglZg/2Tlw3
         E+ExMOac5Sa63aMl8snFjPug5Zl9gLOuqJ+o171L113xmhXM3ZWDnn1yU1XT9irWBVuP
         rDwg+6rE6SSGmAV3xJaEazp9mNfUfI0BlsR4RipymVDleslaCJKzAShmrsEyRKUunfAh
         rnJ/u5O1hAreUR+iWzfKOaPxlJErOsrDii4b8GfIgyJ2sqrHJYUlFcqhYNmfls9JWYc+
         ElBw==
X-Gm-Message-State: AOAM530LbpRPSVyo1jjQ8Spezf/qvq7yFqlufQ5yVNkKrQVYJgTSmN7J
        Z0FLA4rb6EbadTHNslKlgosGKhmj9Ao=
X-Google-Smtp-Source: ABdhPJxjN1vnTOfHdJWvWrs6S1IRXoNizg3Ndl5Q7joCS+neJGA5tg+VQnWUuWXaLQ+wqlz+Msn8Cg==
X-Received: by 2002:aed:36a9:: with SMTP id f38mr14196217qtb.81.1604950752399;
        Mon, 09 Nov 2020 11:39:12 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p1sm6659370qkc.100.2020.11.09.11.39.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:39:11 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9JdALa021788;
        Mon, 9 Nov 2020 19:39:10 GMT
Subject: [PATCH v1 00/13] xprtrdma tracepoint cleanup
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:39:10 -0500
Message-ID: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

A similar set of patches was recently merged on the server side to
remove the use of raw kernel memory addresses in the tracepoints
defined for svcrdma. This set makes the same change in the client
RPC/RDMA transport implementation.

---

Chuck Lever (13):
      xprtrdma: Replace dprintk call sites in ERR_CHUNK path
      xprtrdma: Introduce Receive completion IDs
      xprtrdma: Introduce Send completion IDs
      xprtrdma: Introduce FRWR completion IDs
      xprtrdma: Clean up trace_xprtrdma_post_linv
      xprtrdma: Clean up reply parsing error tracepoints
      xprtrdma: Clean up tracepoints in the reply path
      xprtrdma: Clean up xprtrdma callback tracepoints
      xprtrdma: Clean up trace_xprtrdma_nomrs()
      xprtrdma: Display the task ID when reporting MR events
      xprtrdma: Trace unmap_sync calls
      xprtrdma: Move rpcrdma_mr_put()
      xprtrdma: Micro-optimize MR DMA-unmapping


 include/trace/events/rpcrdma.h    | 402 +++++++++++-------------------
 net/sunrpc/xprtrdma/backchannel.c |   6 +-
 net/sunrpc/xprtrdma/frwr_ops.c    |  81 ++++--
 net/sunrpc/xprtrdma/rpc_rdma.c    |  19 +-
 net/sunrpc/xprtrdma/transport.c   |   7 +-
 net/sunrpc/xprtrdma/verbs.c       |  30 +--
 net/sunrpc/xprtrdma/xprt_rdma.h   |   9 +-
 7 files changed, 234 insertions(+), 320 deletions(-)

--
Chuck Lever

