Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A02A4BB8F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfFSOcf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:32:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37591 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSOce (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:32:34 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so38708741iok.4;
        Wed, 19 Jun 2019 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RoYWbLS5V85E/aQ+Ne39iQTtjQ1k/eY7h10EvjMrTds=;
        b=FdACUJ80NAtit0oz5LfMpGEQ7Yv6ZKtBz/2+eQCe7nTA8HEkck05efQ8cgBEHCwpD3
         VpG59noOn6+lJDpD0llv3Jo8nA5pDj9GWWzjtU/T7vA9c3jmvXaZZ85qWmn5bgqd1sF4
         Y4CdZg+OW+lPj/yGtCJOqWrJFLlqUcgvJQ2Vsu3Pky/V5lEf59beKkQ7O9auK4VLhZAX
         TB4C8ik+tk/OG3RS/FQEpbdn/NM+bdYGI9Z034c1d4Ae9Aet36JIyE82NffM8Z73qAHQ
         MRB5VkEpWaj0cLWZp8GcIKf5DwfleDvGdyIIAedlHmQoM4lbJqgZMYztWgAynDoDxcYZ
         nLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=RoYWbLS5V85E/aQ+Ne39iQTtjQ1k/eY7h10EvjMrTds=;
        b=aapeynsOGfbsbKAxJqiF7VgRqrg3HyALCet4hUPpZ8DRAfuFkulhjG4yDfFW+88QC9
         gtnYHUrJG3nc6eg6Fie7tyXHC1ynFhN0goBSBD7XJUu0iio6TSpFJ3riMrNbRbarmr4p
         v+wFeXJpbMAUiwUebKxw5UGkKWEzaV7OokVVPyHFXQnmJc92L2LotgXGiBaKiSlFbC1W
         Z1bt4YtRdXgcj+gOOflrstut08gIyk9jWMuG7YwYG+kv2aGhzpgFh9L2Wq2XFUPCTnZW
         sS9ZogIs7LYOWwDpp0KGfOR8JR7JDXy4WDyY3XMkGDVg5sWxHzMmll9i+FsWx8II3ebi
         M1vg==
X-Gm-Message-State: APjAAAWDr03CGVQvJPxXj9PhC62+xKtzihS81jwEjgcmbdDu77OGSiCd
        UiTHTyKoen0MtoFUcJRICKg1xyKh
X-Google-Smtp-Source: APXvYqycKmZd+pYW5FINkMco4EOPU5AgkGpGMov2inqMAi+swfs1+VXRP2qWdinJd0bkw1Wje+KY5A==
X-Received: by 2002:a05:6602:220a:: with SMTP id n10mr11051548ion.205.1560954753927;
        Wed, 19 Jun 2019 07:32:33 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c2sm13061348iok.53.2019.06.19.07.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:32:33 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEWW3Z004494;
        Wed, 19 Jun 2019 14:32:32 GMT
Subject: [PATCH v4 01/19] xprtrdma: Fix a BUG when tracing is enabled with
 NFSv4.1 on RDMA
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:32:32 -0400
Message-ID: <20190619143232.3826.51965.stgit@manet.1015granger.net>
In-Reply-To: <20190619143031.3826.46412.stgit@manet.1015granger.net>
References: <20190619143031.3826.46412.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A backchannel reply does not set task->tk_client.

Fixes: 0c77668ddb4e ("SUNRPC: Introduce trace points in ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index df9851cb..f0678e3 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -559,7 +559,8 @@
 		const struct rpc_rqst *rqst = &req->rl_slot;
 
 		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		__entry->client_id = rqst->rq_task->tk_client ?
+				     rqst->rq_task->tk_client->cl_clid : -1;
 		__entry->req = req;
 		__entry->num_sge = req->rl_sendctx->sc_wr.num_sge;
 		__entry->signaled = req->rl_sendctx->sc_wr.send_flags &

