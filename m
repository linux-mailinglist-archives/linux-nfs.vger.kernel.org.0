Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC58261A0FD
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Nov 2022 20:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiKDT2s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Nov 2022 15:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKDT2r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Nov 2022 15:28:47 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11409C58
        for <linux-nfs@vger.kernel.org>; Fri,  4 Nov 2022 12:28:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k4so3685730qkj.8
        for <linux-nfs@vger.kernel.org>; Fri, 04 Nov 2022 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VBBIkkC0B7cKiJCFaBsMnsQeSB5nLT+mGHNYuE3aMOI=;
        b=fMqJS5pWNLNSs2VwoT/NWUw7KmINcs09OTM5fjUbzDC00husAfrWPBOXzY289g930O
         QeRSsHX4y5oLR7YO8S53bYhZvwzmlWDKJzm8lI1xxgJ3O83Uzsrogc8rJgTW6iFee9y8
         Enml2NZQHp+iNGAaH3syJjXmSZuKoQ2VyBHk6YcuAXpQ0ZUxndyG4845nS/0rvHs4A8Z
         Lv/D9JhGaEA45jvAy9HA9rh+VxykcOp2lmFrefljxNqp1Ivvf+wXgcW5mLts40FO90jH
         rMx0B6wIROwmOHAJJiZx7HaO0CBWrg5bfSC4VTsvg4C0TfQpAavzmWLJ3vSObMUxHPXZ
         wTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBBIkkC0B7cKiJCFaBsMnsQeSB5nLT+mGHNYuE3aMOI=;
        b=UonDmHSrrUL5GPRYsrHIdWMV8qnhnGu9nj+4aleQxWz1gFP1GA9j+KvDeo03fLTRdr
         JYURRLHiNpp45oVL6wqOfefMkP4vnlxTeFijVuDp7Pz2QIF9PciG9iwiFbflSsSIANs1
         8JdYkLULqGDqkj0wX45cKlJ8Cn9xYJ6MagM8CRp3NoRIdEPIrZj0cK3M4CgFw2JJhuz+
         fG8BL+hCI/tDbo2gWGPwduURqkAm5Lcmg0bcHJ+3o0n+pnel/4LPCYsJjYuCN/9ZVXs9
         XUT2DnBuktjUnLLJwe5BovmIe7BFPoVVtv4F2GveLbcuK6ozI6r9rJST841pkM4Kav+I
         czSA==
X-Gm-Message-State: ACrzQf389wGjuzhqcUl+haY8pRMVFUC6/F6FYO+Z3ztYbcSt5ErJi74p
        Z4K2+NOJ8PmSVXlv6ZalNwLwlOTQgA==
X-Google-Smtp-Source: AMsMyM5yRDyfSsnWnedgu5elYZcT4USFx1fJX8/c+8Cs6n6KWrXuki7eyBlp4GzBCk3te0kGNYKr6A==
X-Received: by 2002:a05:620a:e05:b0:6fa:509f:f551 with SMTP id y5-20020a05620a0e0500b006fa509ff551mr14455186qkm.505.1667590125757;
        Fri, 04 Nov 2022 12:28:45 -0700 (PDT)
Received: from localhost.localdomain (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id ew13-20020a05622a514d00b0039cc944ebdasm96579qtb.54.2022.11.04.12.28.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:28:45 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Fix a deadlock between nfs4_open_recover_helper() and delegreturn
Date:   Fri,  4 Nov 2022 15:22:19 -0400
Message-Id: <20221104192219.396154-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.38.1
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we're asked to recover open state while a delegation return is
outstanding, then the state manager thread cannot use a cached open, so
if the server returns a delegation, we can end up deadlocked behind the
pending delegreturn.
To avoid this problem, let's just ask the server not to give us a
delegation unless we're explicitly reclaiming one.

Fixes: be36e185bd26 ("NFSv4: nfs4_open_recover_helper() must set share access")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bd89c7f06952..c002e4b69761 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2131,18 +2131,27 @@ static struct nfs4_opendata *nfs4_open_recoverdata_alloc(struct nfs_open_context
 }
 
 static int nfs4_open_recover_helper(struct nfs4_opendata *opendata,
-		fmode_t fmode)
+				    fmode_t fmode)
 {
 	struct nfs4_state *newstate;
+	struct nfs_server *server = NFS_SB(opendata->dentry->d_sb);
+	int openflags = 0;
 	int ret;
 
 	if (!nfs4_mode_match_open_stateid(opendata->state, fmode))
 		return 0;
-	opendata->o_arg.open_flags = 0;
+	/*
+	 * If we're not recovering a delegation, then ask for no delegation.
+	 * Otherwise the recovery thread could deadlock with an outstanding
+	 * delegation return.
+	 */
+	if (opendata->o_arg.u.delegation_type == 0)
+		openflags = O_DIRECT;
+
+	opendata->o_arg.open_flags = openflags;
 	opendata->o_arg.fmode = fmode;
-	opendata->o_arg.share_access = nfs4_map_atomic_open_share(
-			NFS_SB(opendata->dentry->d_sb),
-			fmode, 0);
+	opendata->o_arg.share_access =
+		nfs4_map_atomic_open_share(server, fmode, openflags);
 	memset(&opendata->o_res, 0, sizeof(opendata->o_res));
 	memset(&opendata->c_res, 0, sizeof(opendata->c_res));
 	nfs4_init_opendata_res(opendata);
-- 
2.38.1

