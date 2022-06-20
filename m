Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2835520C1
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbiFTP0G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242342AbiFTPZ0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:25:26 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8FBB75
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:45 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 88so12811540qva.9
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fRVISB0NdIuXGCNg5DG78rIz0nv0rsDBtLdW1M5C4To=;
        b=nxxrdC5LZu7hzoqFtoTRUJ+a/BqLFHti6XMnSqzoYxH2+R/Ns1SldP/cV59f/azDwU
         IcqR4vzCP9/dy0s7JIdvyW0009wS6BYBzstATyBL3Ug0j5vs8FqYZXgO5vW0BLmfFNNn
         p+jkVodDsFEPcetuNXReq6l15AOIDZneK//Xyqj3iU3REfVeKLp3JaYQeZzuiNZrNoGC
         HfRQtsaE8LWCzAMR7XsGs6PJzg+vTqUF1PqPO0vabbEOcdU4eQeJG1DSoYllMN+57otd
         tBxk1MfWQWxCfyAJffR9e8U75VdakUntt1loDjQWdVQXGTB2+UUmmCIfKZRSjKqLvxgD
         mymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRVISB0NdIuXGCNg5DG78rIz0nv0rsDBtLdW1M5C4To=;
        b=grtBhZqouVG7AtVOw0M6FsXSfubix72mwxVE8sY2WfQcpcIOhtypimlILsKrsF5une
         RV6NASwARL1BU9uBxDBLcqHIsqZ9XiNb8VWBgiAosjfgRiADdq+cFzO+OE3A3xM8eiVZ
         3Dka2ER6pcVaW6NDW13I04PqG/vqHsI3HOZJbJ1m/5DRJEJ1Uu41xDpLH3lzOam86Y9I
         dSk006mYw1KTdlnsWwd268N+Z8liRmiyqDgX/0ykJgdAcW/Pa3cI6HEXMJXcjWnCS1e3
         x+JOC0zkupjcJNQN9edfPD0981TeBcTmcYtPs5gxVIbcUIeEzN4nenEKmPv88LLNCVS1
         SHig==
X-Gm-Message-State: AJIora+NrrBQ9Z8g9L8hT3XutmBkTiLdDw+XNTExSKJwtCpbBvYm4KsE
        RzMXmHlu8VGIwwUlWQbi6Eo=
X-Google-Smtp-Source: AGRyM1v/8jqRRIDKg2H0UT0zWjHe5+etA2k34Ixx7s6PfEV6QdUqmg/Ntj92ooeWty2eITMcicpKfw==
X-Received: by 2002:a05:6214:2422:b0:467:d777:7cda with SMTP id gy2-20020a056214242200b00467d7777cdamr19631672qvb.118.1655738685052;
        Mon, 20 Jun 2022 08:24:45 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:48cb:6eb8:1da1:a5c0])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm12517862qko.133.2022.06.20.08.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:24:44 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 12/12] NFSv4.1 probe offline transports for trunking on session creation
Date:   Mon, 20 Jun 2022 11:24:07 -0400
Message-Id: <20220620152407.63127-13-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
References: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Once the session is established call into the SUNRPC layer to check
if any offlined trunking connections should be re-enabled.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 00778f351283..6bf21bc8c074 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9244,6 +9244,13 @@ int nfs4_proc_create_session(struct nfs_client *clp, const struct cred *cred)
 	int status;
 	unsigned *ptr;
 	struct nfs4_session *session = clp->cl_session;
+	struct nfs4_add_xprt_data xprtdata = {
+		.clp = clp,
+	};
+	struct rpc_add_xprt_test rpcdata = {
+		.add_xprt_test = clp->cl_mvops->session_trunk,
+		.data = &xprtdata,
+	};
 
 	dprintk("--> %s clp=%p session=%p\n", __func__, clp, session);
 
@@ -9260,6 +9267,7 @@ int nfs4_proc_create_session(struct nfs_client *clp, const struct cred *cred)
 	ptr = (unsigned *)&session->sess_id.data[0];
 	dprintk("%s client>seqid %d sessionid %u:%u:%u:%u\n", __func__,
 		clp->cl_seqid, ptr[0], ptr[1], ptr[2], ptr[3]);
+	rpc_probe_trunked_xprts(clp->cl_rpcclient, &rpcdata);
 out:
 	return status;
 }
-- 
2.27.0

