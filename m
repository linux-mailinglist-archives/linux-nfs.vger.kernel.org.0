Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A944D3A8E1A
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 03:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFPBM1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 21:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhFPBM1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 21:12:27 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90808C061574
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:21 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r7so574771qta.12
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tc2zBWsP5SICZ7IcIxQSVb38r0cPHyPwbwo/tclHPvc=;
        b=HovIgOySUEnxTTrc4WGZ4x8cqKFkltE54qarxpXRRz/JR3xIW1tBZjTeEzhkVsW+cC
         HptFKc5oVFGfb3Mcx9+zc56KGbTO7kuFlMAlQkbCF6Q7kU7XjSfM0EfHHD60lkBB6SRp
         6rfSqql09SlscUmUrQAEJRRCvEYvwdOVtCe4OdC67Fe21jMC1e9ct43rb76lTJ7JR6KY
         omq272LByg178e67j91iigZfOmVF2IacfFUAgQ7/SMzCz672vn20jRgAf2gbW5fhB5iJ
         l2lVm0rqKG4ipx4wSTDYA0K5VXWLNeyvSC7ohbR0SgwpBdMlo1thZNdywDLT7XIMjvlo
         55Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tc2zBWsP5SICZ7IcIxQSVb38r0cPHyPwbwo/tclHPvc=;
        b=L7VNEo2DVye2og3dQrpZS8Ux8nqA7MnXVjR4ZyvPznwJA4rWF0dhT/D0S6ShRudBfF
         oD6A9M2BrdNUQI3TvXEv+7xFGr4s3GPkhLia8XYGOjxFv0SPtn9a4BGh75QZZ6kNjoXE
         El/aoo5/JWwn5D3EYn2bQEpEl3/g0fbKdtKiQ4x9olIOTQpBa6LiTmyaHR8sZ/B/HyQO
         tr+kgd58jw2R9BXcxhoSbbqBLuQGlOlScLC9prvbWPSOrhNOI3DPEwK4HON1IwGZDnDo
         3cU1Zw2keWlvMHiuaDuyvB1K/7XcYT483s77SUZ11fpQ/weoeeTcDDzVfe6UrWcM4MJI
         vgfA==
X-Gm-Message-State: AOAM531oGZM+FRwebC+UDJEwTdaTPPAuLY9nVBTtflIGbuO+lmGzSVPA
        BzQ9s7l4MU36vVHS3p5FB76xSLOPGvdPqA==
X-Google-Smtp-Source: ABdhPJw8UwYmaUYwrMcTumo+F7gcEAbbtlOwXxVVDx+TjOls7cbGgkVxBw0VHfN+hLgHRBL6IzjvuQ==
X-Received: by 2002:ac8:7399:: with SMTP id t25mr2515654qtp.228.1623805820774;
        Tue, 15 Jun 2021 18:10:20 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m189sm546007qkd.107.2021.06.15.18.10.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 18:10:20 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 4/6] SUNRPC enforce creation of no more than max_connect xprts
Date:   Tue, 15 Jun 2021 21:10:11 -0400
Message-Id: <20210616011013.50547-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
References: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If we are adding new transports via rpc_clnt_test_and_add_xprt()
then check if we've reached the limit. Currently only pnfs path
adds transports via that function but this is done in
preparation when the client would add new transports when
session trunking is detected. A warning is logged if the
limit is reached.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/client.c             | 1 +
 include/linux/sunrpc/clnt.h | 2 ++
 net/sunrpc/clnt.c           | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 486dec59972b..23e165d5ec9c 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -541,6 +541,7 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 
 	clnt->cl_principal = clp->cl_principal;
 	clp->cl_rpcclient = clnt;
+	clnt->cl_max_connect = clp->cl_max_connect;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_create_rpc_client);
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 8b5d5c97553e..0bbf873b225a 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -81,6 +81,7 @@ struct rpc_clnt {
 		struct work_struct	cl_work;
 	};
 	const struct cred	*cl_cred;
+	unsigned int		cl_max_connect; /* max number of transports not to the same IP */
 };
 
 /*
@@ -135,6 +136,7 @@ struct rpc_create_args {
 	char			*client_name;
 	struct svc_xprt		*bc_xprt;	/* NFSv4.1 backchannel */
 	const struct cred	*cred;
+	unsigned int		max_connect;
 };
 
 struct rpc_add_xprt_test {
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index e6801a481d02..4d8fd9d9c264 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2749,6 +2749,15 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 	struct rpc_cb_add_xprt_calldata *data;
 	struct rpc_task *task;
 
+	if (xps->xps_nunique_destaddr_xprts + 1 > clnt->cl_max_connect) {
+		rcu_read_lock();
+		pr_warn("SUNRPC: reached max allowed number (%d) did not add "
+			"transport to server: %s\n", clnt->cl_max_connect,
+			rcu_dereference(xprt->address_strings[RPC_DISPLAY_ADDR]));
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+
 	data = kmalloc(sizeof(*data), GFP_NOFS);
 	if (!data)
 		return -ENOMEM;
-- 
2.27.0

