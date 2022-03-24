Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F0E4E5F30
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 08:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiCXHR0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 03:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240759AbiCXHRZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 03:17:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CA26D191;
        Thu, 24 Mar 2022 00:15:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dr20so7288783ejc.6;
        Thu, 24 Mar 2022 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qtk1F+/RcewfRlkavajgmEHuldQD1UQ67dEq9fT21cQ=;
        b=UYB/rxWolVwBw0LXMd6E1ckTSHp1TKUwpQEp7u0k9G1sLs3GyRXNbD8fUyF2A3zK65
         vlDe9S0dlb37E7moBH7/7dJJk5prkJfnrpsZEWlsgvoNvK2EcLCZWnKTLnrcPZaOgmln
         w3YVYRYE+Fc9/7c7vCnrqO6swH2N1K0M5gQXIGQNXG7yiGSZI5HRP46AksuZ9n7JiZFN
         ZMeLN6jXSwSLbUmiehmtnCqpOFBGnO1+hTkg1RR3TvzmrAijmZrCRnzB5y7AnEqpwHjl
         HK+Y9rk9SXowi/8Bbq7prKKbSKtrmSmOzhRlcCovZio92dxoTFv67/hbqIFlh1A1I0NT
         7M1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qtk1F+/RcewfRlkavajgmEHuldQD1UQ67dEq9fT21cQ=;
        b=WWn8NU7p1IrDnADeFB/bA3DepDwcyarh07q9x+2HBzzLf0WXTd9+214pUeXFmE/vtJ
         yUEtoQqzpTTykh2NJycZe0bV/l4slo1lttyxausMQokLp85mxfQDQS6+8tEvL+abzfJF
         HCz+QfmgvL5eV4OGM1Rw5y4HcKQzCUgeDfBs3N0kmuLFhSa67b8CRNmeU1CyBGoAgyZt
         2Gb2CQBgHHBoBenpWjX0TeRFCfPcG0re3uGGK23snkdXYzzOAtWalVqutAx8u44X7UGt
         XfKvtHk2R2itd03e7J+KNpOMLNusrDZcAnhz5dAM8HWMy8sV0EdZynXVg5YmaLGLknQA
         Rcuw==
X-Gm-Message-State: AOAM532oyICVdtVt8lmHcuGy8bx8m4Crl57cF5GHIjdENhM6ahMeV3dL
        0LzY3DhlQ6xMbHAJ0wtmB/pHQKolzAlKqFDN
X-Google-Smtp-Source: ABdhPJxSqv9Us/Jq/crn7Pb+NXPd8OHMkUp+j7pbZoA2Z9jYqO0Qa4iefkDzVICf9HoLqOtRVAIbKg==
X-Received: by 2002:a17:906:17db:b0:6da:f8d8:ab53 with SMTP id u27-20020a17090617db00b006daf8d8ab53mr4141771eje.274.1648106152784;
        Thu, 24 Mar 2022 00:15:52 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id u4-20020a170906780400b006ce69ff6050sm769300ejm.69.2022.03.24.00.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:15:52 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] NFS: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:15:23 +0100
Message-Id: <20220324071523.60797-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/nfs/nfs42proc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 32129446beca..f2aa0f8bbc1b 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -175,9 +175,8 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 			     nfs4_stateid *src_stateid,
 			     bool *restart)
 {
-	struct nfs4_copy_state *copy, *tmp_copy;
+	struct nfs4_copy_state *copy, *tmp_copy = NULL, *iter;
 	int status = NFS4_OK;
-	bool found_pending = false;
 	struct nfs_open_context *dst_ctx = nfs_file_open_context(dst);
 	struct nfs_open_context *src_ctx = nfs_file_open_context(src);
 
@@ -186,17 +185,17 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 		return -ENOMEM;
 
 	spin_lock(&dst_server->nfs_client->cl_lock);
-	list_for_each_entry(tmp_copy,
+	list_for_each_entry(iter,
 				&dst_server->nfs_client->pending_cb_stateids,
 				copies) {
-		if (memcmp(&res->write_res.stateid, &tmp_copy->stateid,
+		if (memcmp(&res->write_res.stateid, &iter->stateid,
 				NFS4_STATEID_SIZE))
 			continue;
-		found_pending = true;
-		list_del(&tmp_copy->copies);
+		tmp_copy = iter;
+		list_del(&iter->copies);
 		break;
 	}
-	if (found_pending) {
+	if (tmp_copy) {
 		spin_unlock(&dst_server->nfs_client->cl_lock);
 		kfree(copy);
 		copy = tmp_copy;

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

