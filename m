Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21C552EB56
	for <lists+linux-nfs@lfdr.de>; Fri, 20 May 2022 13:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348899AbiETL6L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 May 2022 07:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348904AbiETL6H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 May 2022 07:58:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9008343AE4;
        Fri, 20 May 2022 04:57:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id rs12so3441697ejb.13;
        Fri, 20 May 2022 04:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JPzY3rG4aAiGP4Adx8qp4zYUH//ThardXl1nVOzIKwg=;
        b=jCPS7ml3TGMhhu8lNLCaV/PUeGvhBdasFiSPsWXogU170UjHCU3us9XoBdap4NaULV
         dt5mfbhndQnfJfwiEdf6qUIVs8yNIdn5z+pFlw/qBuGUYEO3y02jTKQCfKBsnCFPiyM4
         tb+Yw7mrSzDGgYRCyCv+VdpIvCO3bNaggokkLzGYif5m5ryLY9Abl4gnFDxdp+zMsImt
         4qvl/37kIO2UhFY8GIoao4yWDnGFO1fM+Efl6Qn/AqGhZhnOF+DPoL4WNCSG7S4tvuTD
         1Z8EjX+LY/AXDH5SqRZ07pRCJhO+OlsLNaBpuoJp0gujMecG/qvIgqWIHihJTeYAjOOe
         H51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JPzY3rG4aAiGP4Adx8qp4zYUH//ThardXl1nVOzIKwg=;
        b=iDLdn6/ArBVapUuqojt3y911o9uaY+ZDE/XlPkfA8Uo2yqrmJVao1xomMmEJhr9ovS
         nsKZx2ExP7Z0oRO6Hqbv4qnVx5iwsUlfLYa93ImM8bApv+1/9HDcyqhUESqFEJIuBXo+
         mBIBxT/fwPTIZNkAwvM1Qs+uEaJOnKKPXYgpZoVhl67kNosBxydMpKw6WJ91f3Gp0A5W
         HpQTqK71EtlbAF51BcsQz99wAWMg8eR3jDJmtS/hJfjgUf+cWjYT24Qkp2W1UcD/N/5n
         RGiSneY36BESAxAGj9Tad8SUzi2AKInzhRmbviKPtMis/11nID9UHQwddeXilJdwMMrb
         I8EQ==
X-Gm-Message-State: AOAM53192hgDv5RgpNAArSE1ZyAZ/NsNPvZ2uCag9aoyFaU5S+A3E5rb
        8ZCL4qRGql+Zmld9c/RDnWMSrHEtajw=
X-Google-Smtp-Source: ABdhPJw3J7+OdXRHM+j5hLfP9q6N7a+WUYPDb3oEqiwVpUjB58HVoQEg2A6NCMEHbgqBSPi1FTJipw==
X-Received: by 2002:a17:906:c14c:b0:6f4:6e30:9ace with SMTP id dp12-20020a170906c14c00b006f46e309acemr8315896ejc.678.1653047862167;
        Fri, 20 May 2022 04:57:42 -0700 (PDT)
Received: from localhost.localdomain ([195.55.223.2])
        by smtp.googlemail.com with ESMTPSA id h8-20020a170906530800b006fa8c685af1sm3100687ejo.163.2022.05.20.04.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:57:41 -0700 (PDT)
From:   Javier Abrego <javier.abrego.lorente@gmail.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier.abrego.lorente@gmail.com
Subject: [PATCH] FS: nfs: removed goto statement
Date:   Fri, 20 May 2022 13:57:14 +0200
Message-Id: <20220520115714.47321-1-javier.abrego.lorente@gmail.com>
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

In this function goto can be replaced. Avoiding goto will improve the
readability

Signed-off-by: Javier Abrego<javier.abrego.lorente@gmail.com>
---
 fs/nfs/nfs42xattr.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index e7b34f7e0..78130462c 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -747,20 +747,18 @@ void nfs4_xattr_cache_set_list(struct inode *inode, const char *buf,
 		return;
 
 	entry = nfs4_xattr_alloc_entry(NULL, buf, NULL, buflen);
-	if (entry == NULL)
-		goto out;
-
-	/*
-	 * This is just there to be able to get to bucket->cache,
-	 * which is obviously the same for all buckets, so just
-	 * use bucket 0.
-	 */
-	entry->bucket = &cache->buckets[0];
-
-	if (!nfs4_xattr_set_listcache(cache, entry))
-		kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
+	if (entry != NULL) {
+	       /*
+		* This is just there to be able to get to bucket->cache,
+		* which is obviously the same for all buckets, so just
+		* use bucket 0.
+		*/
+		entry->bucket = &cache->buckets[0];
+
+		if (!nfs4_xattr_set_listcache(cache, entry))
+			kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
+	}
 
-out:
 	kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
 }
 
-- 
2.25.1

