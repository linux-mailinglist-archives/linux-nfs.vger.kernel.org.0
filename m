Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBEC6B0070
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 09:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCHID7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Mar 2023 03:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCHID6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Mar 2023 03:03:58 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADB895467
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 00:03:56 -0800 (PST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5397E3F591
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 08:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678262635;
        bh=2IYMzNnksZIP1hL57uLqalvS3Qh9IbL5iEW+1r4B2xs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=W7Te3pw1/nBxEV0X265ZxiLUR6nN1ID/bBh+rflzuAoIowtX9+7ImnYRu1hD3IS++
         oyah98UREhMJzaSDlqtAgDyYG/ewe6wtsZnbBgL3Sc+tUQ/C7fnzUGU+07DW06NLNt
         ZVhd3Qf9ATI3FxSCbmJycJKjI2hv/czkU1ROFhTv+7d9uF2zc+FU1louPVYKXtTdoi
         9Egyw8jDeYEP1D9TMMUT0769aq8gOe3ty8st2/+qZRq7dvAdXdFdWO2xS5dnVTRWy6
         qgQlMhpLz1RxAQXtVuiXCJbv91RqMBEQdARWz19GDAiBdvO7wfAa3JTm/MDWmulcO6
         csQwEDvuO/A3Q==
Received: by mail-pj1-f70.google.com with SMTP id x63-20020a17090a6c4500b00237731465feso6241602pjj.8
        for <linux-nfs@vger.kernel.org>; Wed, 08 Mar 2023 00:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678262634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IYMzNnksZIP1hL57uLqalvS3Qh9IbL5iEW+1r4B2xs=;
        b=qSF3/Ib+jKKrG2MGgBxE/8pD14gmnUw29q/AqsdNA6rCFKatFFmcolpuyVf5lMJ4R2
         HHTEbgJipjEgwIGkTqS9M43qZP/F/exICo3r9sHQBE9RCspCuYjpa1oX/QKUtS69kFwQ
         BfIUEZMMBXfu+2hQARzYSBTSrETYYJWBBkgoRFhqxV3JTNsPaq7H91hSvghONviMMYdP
         LzZX3gTusEvCDl2S2H7wke9z/OHNlLGzewEBT/H4pOucD250NmziWq04bObeIQRRuIHZ
         djN+04fK1JbxS3CUpdBwP8bO5NJJ0zRLev6u9Hagtz5XMjcP5t4TmcLvS43x0sHJ9/sv
         vN8A==
X-Gm-Message-State: AO0yUKW7ZtHqR05NdHLSpVhGLlfLS2WLcI9w05mYtKk/Dp7kSLUrxppY
        o8UgS2YG75unhdV9M61TaKrg4ecuv0A9dS6WHRQQYTAhjbKITwDu0/KMLeH6610rtgJPpNRIONr
        I8DUaejXqZjqDY/669O73hadH0TY0aT8kwE1+BQ==
X-Received: by 2002:a05:6a20:4303:b0:cc:692d:92de with SMTP id h3-20020a056a20430300b000cc692d92demr19851886pzk.44.1678262633894;
        Wed, 08 Mar 2023 00:03:53 -0800 (PST)
X-Google-Smtp-Source: AK7set/zES7EuvZZAfjAPFznv2GnHq4TUH2uu2ojZuDWdYMj39OMJnF6Pcl2po7qwBuhl5jebtzDpA==
X-Received: by 2002:a05:6a20:4303:b0:cc:692d:92de with SMTP id h3-20020a056a20430300b000cc692d92demr19851875pzk.44.1678262633609;
        Wed, 08 Mar 2023 00:03:53 -0800 (PST)
Received: from chengendu.. (111-248-104-66.dynamic-ip.hinet.net. [111.248.104.66])
        by smtp.gmail.com with ESMTPSA id f6-20020aa782c6000000b0059416691b64sm9275574pfn.19.2023.03.08.00.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:03:53 -0800 (PST)
From:   Chengen Du <chengen.du@canonical.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengen Du <chengen.du@canonical.com>
Subject: [PATCH] NFS: Correct timing for assigning access cache timestamp
Date:   Wed,  8 Mar 2023 16:03:27 +0800
Message-Id: <20230308080327.33906-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When the user's login time is newer than the cache's timestamp,
the original entry in the RB-tree will be replaced by a new entry.
Currently, the timestamp is only set if the entry is not found in
the RB-tree, which can cause the timestamp to be undefined when
the entry exists. This may result in a significant increase in
ACCESS operations if the timestamp is set to zero.

Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a41c3ee4549c..6fbcbb8d6587 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -3089,7 +3089,6 @@ static void nfs_access_add_rbtree(struct inode *inode,
 		else
 			goto found;
 	}
-	set->timestamp = ktime_get_ns();
 	rb_link_node(&set->rb_node, parent, p);
 	rb_insert_color(&set->rb_node, root_node);
 	list_add_tail(&set->lru, &nfsi->access_cache_entry_lru);
@@ -3114,6 +3113,7 @@ void nfs_access_add_cache(struct inode *inode, struct nfs_access_entry *set,
 	cache->fsgid = cred->fsgid;
 	cache->group_info = get_group_info(cred->group_info);
 	cache->mask = set->mask;
+	cache->timestamp = ktime_get_ns();
 
 	/* The above field assignments must be visible
 	 * before this item appears on the lru.  We cannot easily
-- 
2.37.2

