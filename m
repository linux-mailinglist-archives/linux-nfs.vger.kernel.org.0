Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47203659452
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Dec 2022 04:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbiL3DFI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Dec 2022 22:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiL3DFH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Dec 2022 22:05:07 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C14E11C3C
        for <linux-nfs@vger.kernel.org>; Thu, 29 Dec 2022 19:05:06 -0800 (PST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 80CC7445AE
        for <linux-nfs@vger.kernel.org>; Fri, 30 Dec 2022 03:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1672369504;
        bh=lwvEOmEMF0O/z3RmuxwF6rUwUcUS81nDydZThS1Yl7w=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Rcaeir3RSP+vcwnvGxQN8vzWaqqLNPzo6MTif0k6Dci5ek21BXIKZH7C6gNE1YIsh
         NMtGHxlOvCI6moFMxiDwoWW1seooTDS89/nglf+rD+HHiTt3LCX+v68HtHhe6k9N0a
         XEyanAv3Z2VCsNSHM96DUTy+alj2mosbnuyUzZef6kM/UKb8fJlNofSTIysen2aXGo
         ZTcfQKIwsztyDNH+r6SolKeNAFS/AIsG+Tfxh5yFpIUGs38P28OSDON+iXz4MiDUFo
         APhOb+CIiXiWZwhT1z5/RgWd5s+Vfrqh7+85ouJMLtXlWjjIrRbAD58mMdMIkBQwsR
         mjUn01+HtHrLg==
Received: by mail-pl1-f197.google.com with SMTP id o18-20020a170902d4d200b00189d4c25568so14997370plg.13
        for <linux-nfs@vger.kernel.org>; Thu, 29 Dec 2022 19:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwvEOmEMF0O/z3RmuxwF6rUwUcUS81nDydZThS1Yl7w=;
        b=4nFiBnSurEE1xKk7GWZhCL9raHg2AStT6AiRF+LOo8Fp6shNPLXJ9eoI8YERub98QP
         8oQynKpr8Aad7J+bAfxsMng+BjYlyZAmZ2xUWbC9R1P75841DkmlYQUPTVp93M0MGZLo
         q4J2sJwdyK8hELJQRLcUxpAeCjac14jTRKBgKvhllTg9EHftkkhJBSZWp9xTgZYHKxQZ
         Pi2gzFj1yTOMW9XsOetEO64WNYRuMZN+n52syoOy/sdRCtvpwWkn7gORq3ZuqXa3bAwW
         nMeHf/z0zOvniZoZMRpqbWAK+00jwbVjwHBQPfKwwXChK9oDWdEVNVN9d0LLfLD/DtRU
         dukQ==
X-Gm-Message-State: AFqh2kpa3MCokZiljQC2Rj5I1J4trOHbHGuuqf6GczB35MQeBXT8+Jt3
        vTCmV3llVc1jffMEvAj0EtBSEqGZ48nO1uItvE0jeECeDDHc2J8Cl0S/4fQCUm4bRUBQvjsJnEJ
        TuqQ1VPyeLvvGmHufLjhH+soI40S43ieuNb0CSQ==
X-Received: by 2002:a17:902:b205:b0:185:441e:224a with SMTP id t5-20020a170902b20500b00185441e224amr29785084plr.69.1672369502889;
        Thu, 29 Dec 2022 19:05:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuOX0hwNCD1uwfltxofFg6zTdEbzIdHHCh+wxMcGtvo9ZU54GvehkMaV9Bibf4xJtTfC0YPxQ==
X-Received: by 2002:a17:902:b205:b0:185:441e:224a with SMTP id t5-20020a170902b20500b00185441e224amr29785069plr.69.1672369502673;
        Thu, 29 Dec 2022 19:05:02 -0800 (PST)
Received: from chengendu.. (111-248-115-10.dynamic-ip.hinet.net. [111.248.115.10])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b00189f2fdc178sm13643520plh.177.2022.12.29.19.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 19:05:02 -0800 (PST)
From:   Chengen Du <chengen.du@canonical.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengen Du <chengen.du@canonical.com>
Subject: [PATCH] NFS: Judge the file access cache's timestamp in rcu path
Date:   Fri, 30 Dec 2022 11:04:32 +0800
Message-Id: <20221230030432.38908-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the user's login time is newer than the cache's timestamp,
we expect the cache may be stale and need to clear.
The stale cache will remain in the list's tail if no other
users operate on that inode.
Once the user accesses the inode, the stale cache will be
returned in rcu path.

Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 fs/nfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ea1ceffa1d3a..d490d64a9ebd 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -3023,6 +3023,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	 * but do it without locking.
 	 */
 	struct nfs_inode *nfsi = NFS_I(inode);
+	u64 login_time = nfs_access_login_time(current, cred);
 	struct nfs_access_entry *cache;
 	int err = -ECHILD;
 	struct list_head *lh;
@@ -3037,6 +3038,8 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 		cache = NULL;
 	if (cache == NULL)
 		goto out;
+	if ((s64)(login_time - cache->timestamp) > 0)
+		goto out;
 	if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_ACCESS))
 		goto out;
 	*mask = cache->mask;
-- 
2.37.2

