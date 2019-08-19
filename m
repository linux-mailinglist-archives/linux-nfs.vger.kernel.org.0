Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 317F2950E5
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfHSWiP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:38:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44482 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfHSWiP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:38:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id k22so2597539oiw.11;
        Mon, 19 Aug 2019 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=hgHtWU4sAHy10ecYDRHFxG9KkrfPY8CSPtGGStpLVYw=;
        b=BXXTLHchIy/c4RbPtg8BMoLS14JswsGA/ilPtziWZpFe3JSLy8ZoB6bWb3y2bOODIK
         yWaPLCc3d5bVJzIpyHeHtGX1Hc2w0RCIRAjno1VZE3neAGz52+SV1xDgKIbfHqdk8IIE
         ve2WWQ2LIkNa9ORlL31wGKa8uWHkqxcyeNzOVICi0we4FXFalsrNadwBcZV1udKpxizs
         wWSskVNZDg0FYYTNHP7Y0Adx6H9NS03nUw6aIL5nK8B0fVA5rjC75h2dTKxpxoMbhEBt
         CUomNyFvRID992pNwastj0p1N+lNv5emCmKMMzZ18KsNxDfWPfoop146aADmBjYTvjG3
         IoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=hgHtWU4sAHy10ecYDRHFxG9KkrfPY8CSPtGGStpLVYw=;
        b=M2mufifC29qRG7vpktP6Ulw+BrJ+cJ7AgiVvpcWX+51X8FmATdS7L7EHsTLQqtCyx/
         MSP8VXUX3AqxoSe1u1rwaI5+pa6I9U2NbRFtB8PKdFC/eD7OIlBGmomtIX8JmjC5NnKI
         r6B6IhSURtSnJNSd+5b3N1iJpLsiBa2/noI59vYBx1UOxjFZoUuXZS/V2R0YHRS66gXR
         ktoR0WTa5+BtdWpao86t4o/iAeVOA4xsL03Xj82luQUTcA+n2pOE+pTGdujDroqy6+1E
         6Or6zn3ctG9+2VNFukn6asW62Yhy/TlIDtMWkyBD9B3onkeV0+uK3yMqHmlX5yDJxTn+
         tEAw==
X-Gm-Message-State: APjAAAVg8LvNrur6vrzdyNYv4vB3PHxapTqgO2zp/eZk7ZhJQ8HMGCAI
        SlC0vUv5JSo+zC8Eg0NaoPjqh4c1
X-Google-Smtp-Source: APXvYqw9lGMuBEzap6KCcuRzBXEXOccZ/VkzBnE91dG029oqm89Wy9HthEEYQd1Za/WCKO0FR8KvxQ==
X-Received: by 2002:aca:2104:: with SMTP id 4mr15217357oiz.12.1566254293472;
        Mon, 19 Aug 2019 15:38:13 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id b10sm5920111oti.61.2019.08.19.15.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:38:13 -0700 (PDT)
Subject: [PATCH v2 03/21] xprtrdma: Refresh the documenting comment in
 frwr_ops.c
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:37:52 -0400
Message-ID: <156625425207.8161.7734951575643318770.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Things have changed since this comment was written. In particular,
the reworking of connection closing, on-demand creation of MRs, and
the removal of fr_state all mean that deferring MR recovery to
frwr_map is no longer needed. The description is obsolete.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |   66 +++++++++++-----------------------------
 1 file changed, 18 insertions(+), 48 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 0b6dad7580a1..a30f2ae49578 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -7,67 +7,37 @@
 /* Lightweight memory registration using Fast Registration Work
  * Requests (FRWR).
  *
- * FRWR features ordered asynchronous registration and deregistration
- * of arbitrarily sized memory regions. This is the fastest and safest
+ * FRWR features ordered asynchronous registration and invalidation
+ * of arbitrarily-sized memory regions. This is the fastest and safest
  * but most complex memory registration mode.
  */
 
 /* Normal operation
  *
- * A Memory Region is prepared for RDMA READ or WRITE using a FAST_REG
+ * A Memory Region is prepared for RDMA Read or Write using a FAST_REG
  * Work Request (frwr_map). When the RDMA operation is finished, this
  * Memory Region is invalidated using a LOCAL_INV Work Request
- * (frwr_unmap_sync).
+ * (frwr_unmap_async and frwr_unmap_sync).
  *
- * Typically these Work Requests are not signaled, and neither are RDMA
- * SEND Work Requests (with the exception of signaling occasionally to
- * prevent provider work queue overflows). This greatly reduces HCA
+ * Typically FAST_REG Work Requests are not signaled, and neither are
+ * RDMA Send Work Requests (with the exception of signaling occasionally
+ * to prevent provider work queue overflows). This greatly reduces HCA
  * interrupt workload.
- *
- * As an optimization, frwr_unmap marks MRs INVALID before the
- * LOCAL_INV WR is posted. If posting succeeds, the MR is placed on
- * rb_mrs immediately so that no work (like managing a linked list
- * under a spinlock) is needed in the completion upcall.
- *
- * But this means that frwr_map() can occasionally encounter an MR
- * that is INVALID but the LOCAL_INV WR has not completed. Work Queue
- * ordering prevents a subsequent FAST_REG WR from executing against
- * that MR while it is still being invalidated.
  */
 
 /* Transport recovery
  *
- * ->op_map and the transport connect worker cannot run at the same
- * time, but ->op_unmap can fire while the transport connect worker
- * is running. Thus MR recovery is handled in ->op_map, to guarantee
- * that recovered MRs are owned by a sending RPC, and not one where
- * ->op_unmap could fire at the same time transport reconnect is
- * being done.
- *
- * When the underlying transport disconnects, MRs are left in one of
- * four states:
- *
- * INVALID:	The MR was not in use before the QP entered ERROR state.
- *
- * VALID:	The MR was registered before the QP entered ERROR state.
- *
- * FLUSHED_FR:	The MR was being registered when the QP entered ERROR
- *		state, and the pending WR was flushed.
- *
- * FLUSHED_LI:	The MR was being invalidated when the QP entered ERROR
- *		state, and the pending WR was flushed.
- *
- * When frwr_map encounters FLUSHED and VALID MRs, they are recovered
- * with ib_dereg_mr and then are re-initialized. Because MR recovery
- * allocates fresh resources, it is deferred to a workqueue, and the
- * recovered MRs are placed back on the rb_mrs list when recovery is
- * complete. frwr_map allocates another MR for the current RPC while
- * the broken MR is reset.
- *
- * To ensure that frwr_map doesn't encounter an MR that is marked
- * INVALID but that is about to be flushed due to a previous transport
- * disconnect, the transport connect worker attempts to drain all
- * pending send queue WRs before the transport is reconnected.
+ * frwr_map and frwr_unmap_* cannot run at the same time the transport
+ * connect worker is running. The connect worker holds the transport
+ * send lock, just as ->send_request does. This prevents frwr_map and
+ * the connect worker from running concurrently. When a connection is
+ * closed, the Receive completion queue is drained before the allowing
+ * the connect worker to get control. This prevents frwr_unmap and the
+ * connect worker from running concurrently.
+ *
+ * When the underlying transport disconnects, MRs that are in flight
+ * are flushed and are likely unusable. Thus all flushed MRs are
+ * destroyed. New MRs are created on demand.
  */
 
 #include <linux/sunrpc/rpc_rdma.h>

