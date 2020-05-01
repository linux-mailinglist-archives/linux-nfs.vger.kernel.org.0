Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398831C1C08
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgEARka (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729218AbgEARk3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:40:29 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D84C061A0C;
        Fri,  1 May 2020 10:40:29 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s9so7253474qkm.6;
        Fri, 01 May 2020 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cuE11oJunFaCfYoWBiHv+QENeEzVDO03vSJepfy6QB0=;
        b=mgcaIJ+CM7wu4E4N6XUfhOkZ9lIuJQnxXu+NZZC+xMlTH3EPQOqwxzz8Kv8IrLB5YN
         vi6E9VL4Nk1QrlZWxeqDRgm3yplb8vGemwUCknGqTSbFHWPweXYgHANCTfYfeVNgbXT0
         DjmvpZv4l7U7wsVtI6qKub0eM90Lsc394egC1Q5VQXeyjc3PIAn6LlGSVmtvmgCgixzT
         5PEq1rNGtSJPX8yinvwSQmS8VcSUUQHoaLvr9bvbZhZo5KpenPGrST6METSq4bMtdf2n
         PC39eVxx0FHbeeHMyvXnPMZCnq1iipeMlvSz9iK/7foJw+tU0Jb358AD/Gsn4vycb1pP
         Ae4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cuE11oJunFaCfYoWBiHv+QENeEzVDO03vSJepfy6QB0=;
        b=j6gT/RwWqiWSQD7v8dcVFBOEQukjysqWLomCnLtZqNnLhQdl9GLAIlXZjXqioW++2E
         4qupZD2s3/9zztI+NODsqvx1XmogbD8ert7gGjBq7NB0TrL9UC3n/9oc3WdWH8bB8L9i
         VPsFPhuwfb89sddpM4y6N3wZzKZ6ikU2m/BtTMjzqGf3H9XOPE5z6njLEMYsIKl3neIP
         5IxOuDGkGNKuzSS0f97yWZzk7EXqwNLCHvKpeaSx/FQfJ6Wcub5VM4WcDhqP4oM3sJ+6
         YYYWzmWs++tC2klLln7U1EBlOtHv49fq+S0HwFZrQUS09jM/YsgmrOeSd+Vptxu3Ad/6
         UJpA==
X-Gm-Message-State: AGi0PubTxJeCSyadowxXoldjzBEDDbsap+FPQbZoOg+Myh+RZtWVA/uI
        sJ7jpFuMTCEgF4AiuRAsRv+r195y
X-Google-Smtp-Source: APiQypKqD9BeZsaEurrdD2iyA1Vo2U+ohW0AUP8iJ/s//xb3r25QwVduW1/7+n8W/jp0LzNo/KPenw==
X-Received: by 2002:a37:9f4a:: with SMTP id i71mr4693510qke.132.1588354828368;
        Fri, 01 May 2020 10:40:28 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g8sm3125308qkb.30.2020.05.01.10.40.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:40:27 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HeQq2026762;
        Fri, 1 May 2020 17:40:26 GMT
Subject: [PATCH v1 0/7] svcrdma observability improvements
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:40:26 -0400
Message-ID: <20200501173903.3899.31567.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

(cc: linux-rdma and linux-nfs)

These are minor clean-ups in the svcrdma code that I found while
addressing other issues.

---

Chuck Lever (7):
      svcrdma: Clean up the tracing for rw_ctx_init errors
      svcrdma: Clean up handling of get_rw_ctx errors
      svcrdma: Trace page overruns when constructing RDMA Reads
      svcrdma: trace undersized Write chunks
      svcrdma: Fix backchannel return code
      svcrdma: Remove backchannel dprintk call sites
      svcrdma: Rename tracepoints that record header decoding errors


 include/linux/sunrpc/svc_rdma.h            |  5 +-
 include/trace/events/rpcrdma.h             | 90 +++++++++++++++++++++-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 86 ++++-----------------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    | 21 +++--
 net/sunrpc/xprtrdma/svc_rdma_rw.c          | 36 ++++-----
 5 files changed, 129 insertions(+), 109 deletions(-)

--
Chuck Lever
