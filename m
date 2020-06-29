Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2636520D849
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbgF2Thx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 15:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbgF2Tho (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:37:44 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2A3C02F012;
        Mon, 29 Jun 2020 07:50:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id e11so15483715qkm.3;
        Mon, 29 Jun 2020 07:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=iMbjs/ZxMdipgAkk/S73vGtZHgmrBteQhlWmQZhE0NU=;
        b=LbKcMKEM9t/wu5u4c8VgKlMW0qHbEXmR8kBcgjKdWfF2JZ3sMlge+VK8w6OYnxTQf6
         q4ypIkxRUV3CJBAAnkFwch+WGSmodkT0VPxUkfnFHyXsOzWzpIxQy71K5aFEKcuGB9xv
         b23cfFnFHIdM6R9s7dEC0qnKKbejkpuF71h2J2xe8W11VHyxfG5ZGaH7PNqDuS3DqSWt
         kFRiRIVC2bLKgR0ZXAbkcNnS+l4jxQA+EcSZ6IZSGV+FMs9is86obZiUFGgUitwpQGkD
         sRHfzxV2MxWvscVqzcWbkfIDs2fLaIF51NfF7xFXPCVUqgnqqVLyZmVc18MBzYkVsTb+
         Ra5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iMbjs/ZxMdipgAkk/S73vGtZHgmrBteQhlWmQZhE0NU=;
        b=q6fKOUW4kkdcWrRUtCYRNzdkQfWhygbP5bmJSEV0v1EE3cP5zd6I6GoT6umNVZJ5xt
         Uoknpa8cGdPSu/1/X28bofWoDWdtffjwp0CII/4mEVPk/A1Bbj331uv1CyMb632UZQWD
         fIp41G8CkCf8sfKPfSNHiPA7w/sC7k/qzCCr7my9fDTDELZIC138bKICsf0k0Nc7wW8D
         x/osIdrep+Pl1bLAO4wckXQf+tTCnVxQqXGcuN8dL3HKlduFJRkW1DV95VbpIbHWz6VG
         O5KAsOEBF+OENQ1KhUa+z0TldDY5jrEJXV6X8rHeyTY3mNbu/z3TcRhU21iqOmrH7k1r
         oTuQ==
X-Gm-Message-State: AOAM531tOTbZ1TEf29xMjghOlzfaawV4a0tuL9/0YYK5+ULkipZJ3IRs
        LxNNS0mSOf6BXdaWgNg1lOkztkpU
X-Google-Smtp-Source: ABdhPJyz51gMYgeszopA4knBz1PZDuZpsFbuAFDjtpj1wdDDOTxQorZ2fHqwOiIyc1fXKQFcBjK5jQ==
X-Received: by 2002:a37:4050:: with SMTP id n77mr15097002qka.431.1593442199454;
        Mon, 29 Jun 2020 07:49:59 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z18sm9463076qta.51.2020.06.29.07.49.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:49:58 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEnvHh006182;
        Mon, 29 Jun 2020 14:49:57 GMT
Subject: [PATCH v2 0/8] Refactor path that sends error responses
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:49:57 -0400
Message-ID: <20200629144802.15024.30635.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There are currently two paths in the server's RPC/RDMA implementation
for sending error responses. De-duplicate these two into one set of
helpers.

I mistakenly did not send the full set last week. The only change
since v1 of this series is two additional patches at the end of the
series.

---

Chuck Lever (8):
      svcrdma: Fix page leak in svc_rdma_recv_read_chunk()
      svcrdma: Remove save_io_pages() call from send_error_msg()
      svcrdma: Add @rctxt parameter to svc_rdma_send_error() functions
      svcrdma: Add a @status parameter to svc_rdma_send_error_msg()
      svcrdma: Eliminate return value for svc_rdma_send_error_msg()
      svcrdma: Make svc_rdma_send_error_msg() a global function
      svcrdma: Consolidate send_error helper functions
      svcrdma: Clean up trace_svcrdma_send_failed() tracepoint


 include/linux/sunrpc/svc_rdma.h         |  4 ++
 include/trace/events/rpcrdma.h          |  7 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 59 +++--------------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   | 87 +++++++++++++++++--------
 4 files changed, 75 insertions(+), 82 deletions(-)

--
Chuck Lever
