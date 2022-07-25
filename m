Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C47E57FFEF
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiGYNdB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbiGYNcv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:32:51 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C55DDEB3
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:48 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id x125so10659952vsb.13
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rqgp4NaqHB0e2b8gTbaEiPmf7V2zMSWAxg7BtypCeKw=;
        b=IOpVavvFo98KTDOOv4PjzLWf+NpfOG6iG2NNbiEyxD2EbJnxRUy9VD3x5dC3I8bSTv
         VBst9dXzJua4Cx95jTLbkGKf5GC3clIhhASy3gL+I+b1YGjdzMRNJGlzmO0VixsxCKWN
         bl3PzJD7yiJA9YzjQV9+GchLUhYXydWIW1XEkvz3tEbUMY/IdFt0sMId0de9Vqnh9F+m
         jGWgwAvtZ110vrOpKZfxu5A9MToKH8zoAZwSOu7cxNrzr3HIfDhtTjw1vSnL1SdDwMSY
         lPKETzYISxB/NppSdWBC0zAc0GJOD6AJsgXbf5FSA/uUA55ZWI7dTBV4zPY8nhFT1noZ
         kXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqgp4NaqHB0e2b8gTbaEiPmf7V2zMSWAxg7BtypCeKw=;
        b=dZVHiCyDDFv806/WFAbY3860M5qf+lWtZPmSMMjUe/159b/+GhAHwsiet+4jwQGnmG
         /N75IHhEl8R6ZH8xZjTskn88fPvoE+AUSnH8kua6XkxbAmepJxubvx3ykpEDxk/EpmA/
         FygMqwxTzZTKdYS67XCJRZWfAjW+5sNeL4Lt0QpxZCCV2XWfU2lRV9JB8BCV3jTpFcXN
         2S2XAmZrAqKBSET08QhXkeiL4jFYq+WSsRpIC1+EszwSgon7e7CNkWAa0OP+VKnD4XVs
         rdEGZbtPsj3K6hPcCYBvv65m4tbp9CVeVYm/tcdo7Rk36wzqQI/110ANLYpJUKSxxOsH
         5knw==
X-Gm-Message-State: AJIora/k0sDcBAqRZcuTDMZdF8Jj+236flzy5AfI4bFM7ZVVH21j3w6P
        +yDSqjS/iSmSfOcgkL72XFw=
X-Google-Smtp-Source: AGRyM1tDOYb/Mdoy0tQxrpFnf1K2kKjNJUUkad9xmXKE01fyEKraagApn4TV1UIDNBtiuKyZBLXFoQ==
X-Received: by 2002:a05:6102:518:b0:358:5d65:907e with SMTP id l24-20020a056102051800b003585d65907emr1347689vsa.87.1658755966858;
        Mon, 25 Jul 2022 06:32:46 -0700 (PDT)
Received: from localhost.localdomain (071-047-011-047.res.spectrum.com. [71.47.11.47])
        by smtp.gmail.com with ESMTPSA id a6-20020ab06306000000b00383aeb53100sm2128826uap.16.2022.07.25.06.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:46 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 11/11] NFSv4.1 probe offline transports for trunking on session creation
Date:   Mon, 25 Jul 2022 09:32:31 -0400
Message-Id: <20220725133231.4279-12-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
References: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Once the session is established call into the SUNRPC layer to check
if any offlined trunking connections should be re-enabled.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4850e29904e6..5f59de55ac84 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9249,6 +9249,13 @@ int nfs4_proc_create_session(struct nfs_client *clp, const struct cred *cred)
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
 
@@ -9265,6 +9272,7 @@ int nfs4_proc_create_session(struct nfs_client *clp, const struct cred *cred)
 	ptr = (unsigned *)&session->sess_id.data[0];
 	dprintk("%s client>seqid %d sessionid %u:%u:%u:%u\n", __func__,
 		clp->cl_seqid, ptr[0], ptr[1], ptr[2], ptr[3]);
+	rpc_clnt_probe_trunked_xprts(clp->cl_rpcclient, &rpcdata);
 out:
 	return status;
 }
-- 
2.27.0

