Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928823DADF9
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jul 2021 22:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhG2U74 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jul 2021 16:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhG2U74 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jul 2021 16:59:56 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B66C061765
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jul 2021 13:59:52 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 184so7383575qkh.1
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jul 2021 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cuhQ2h40XFn8maWZ+fhgOap2rvIGruMHRWRFAKpE1r4=;
        b=hI73O2XyFw/dWa7eDCgBcjvx7yDB2u+Z2kU11WfbS9B7Yg1l3cxo/aAIWtvus20spS
         bZE+NsJWVvwIUErvcMI38xK+CH+y9SeJJVSxm8vviEzkTm98qSI20XErNW3LPQFrhZlV
         ox5r3tbZid+hDmR6vcRRNz3r/VL+Gayu8CqJe5dzyZiYnKxYqerYpTVK07ZlnFxBPEhl
         dQ4edNxq/HD2Uusr93Rbe43r5EqlB/dDjDiCCFfInIyYM2uIJbe7rGnpqkRuHudDq0ys
         Y/eil1YzDpqOLfcUuP0c+NlSm0esQEMuq1NMVuSRC9DfvWmjFf2UIZL7OA0t2UqaJgQR
         SJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cuhQ2h40XFn8maWZ+fhgOap2rvIGruMHRWRFAKpE1r4=;
        b=AfMcgAbeXcWiTWyfjCsBoSL/6PYE/YvnHk/4iq/Gs8WY7mPbul+4wPEvCxiE6CQDhc
         I3gGGGQE8++psXmDoWTdgs+LmdNC7Zjstjw+uD3J/KNyOTHs7OgO9j+p1NSUSp+evrX1
         Omf/xXMdpT8g/lwI6LHaOWjqFMyiXTukRmHkt4QwUCKG8LBGErXXlrWDEBJ9b40kG3UD
         2W8S56EJ83Q78RKfFXXRFsqqnDsOie//gzxwDYhQimfCbD8NiIMx8PKA4ikx16du661x
         FljhgvcM0oEAxYx8Kyfb8FDpp4txdffraa8697PsMAs+/LQVdszS7OJryhm4keW/4j3n
         JUiA==
X-Gm-Message-State: AOAM532middkWsKO7n8Y8vfyy/BHUnXxn2banhrkeJg4DvZRgswfXRvR
        a7pEY8FUi5hr9s1RlL80UBM=
X-Google-Smtp-Source: ABdhPJzOWs4ZvCDYrK4G/PWNslYGoobvL6P46JoycYW0mfnHN8oCCQwVVfqTDYK+6ym/DkQ0bmLqFA==
X-Received: by 2002:a37:618a:: with SMTP id v132mr7276887qkb.382.1627592391151;
        Thu, 29 Jul 2021 13:59:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id j3sm2268529qka.96.2021.07.29.13.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 13:59:50 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 2/2] SUNRPC: Add dst_port to the sysfs xprt info file
Date:   Thu, 29 Jul 2021 16:59:47 -0400
Message-Id: <20210729205947.162599-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729205947.162599-1-Anna.Schumaker@Netapp.com>
References: <20210729205947.162599-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This is most likely going to be 2049 for NFS, but some servers might be
configured to export on a non-standard port. Let's show this information
just in case somebody needs it.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 2e7a53504974..414c664a3199 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -136,14 +136,16 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 		       "max_num_slots=%u\nmin_num_slots=%u\nnum_reqs=%u\n"
 		       "binding_q_len=%u\nsending_q_len=%u\npending_q_len=%u\n"
 		       "backlog_q_len=%u\nmain_xprt=%d\nsrc_port=%u\n"
-		       "tasks_queuelen=%ld\n",
+		       "tasks_queuelen=%ld\ndst_port=%s\n",
 		       xprt->last_used, xprt->cong, xprt->cwnd, xprt->max_reqs,
 		       xprt->min_reqs, xprt->num_reqs, xprt->binding.qlen,
 		       xprt->sending.qlen, xprt->pending.qlen,
 		       xprt->backlog.qlen, xprt->main,
 		       (xprt->xprt_class->ident == XPRT_TRANSPORT_TCP) ?
 		       get_srcport(xprt) : 0,
-		       atomic_long_read(&xprt->queuelen));
+		       atomic_long_read(&xprt->queuelen),
+		       (xprt->xprt_class->ident == XPRT_TRANSPORT_TCP) ?
+				xprt->address_strings[RPC_DISPLAY_PORT] : "0");
 	xprt_put(xprt);
 	return ret + 1;
 }
-- 
2.32.0

