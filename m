Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9393B79BEAA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbjIKV6r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbjIKJrz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 05:47:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF42E4E
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 02:47:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c3aa44c0faso1784715ad.1
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425670; x=1695030470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+dyOdEpvdrL2eUxAXXyGxIB/NcoZnEV+TKBfmBMmgQ=;
        b=fPaC9EAUYalffszD3hRRgazLNMEK9qm4ndUZC6m65bAdOtNemq0DISEDKQnkDoLF63
         2VnYneZGKHtMaWTF4GywyKohNXZkwEehmSPYhN7wnwJBkf+QEtT/syKn7AHVbDea/z5w
         YsjsqlHEoTm442ae6vU9iirPQFH5h9TmOSN3xWQxUPsuupD8/q0wek/7/bVGJGkVHlls
         Od9ws817GuViLEFSzgSc/NTphiXMk3zdIcSpf48tUyw3hYdkGstq+srxvWh6LxJuO54w
         VGz89I3HZfLpm47+TffPhew9jYk4YyyU7gBM4Ej0VllMBtXU4353yQ7qjEm/g19ZEMG3
         vL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425670; x=1695030470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+dyOdEpvdrL2eUxAXXyGxIB/NcoZnEV+TKBfmBMmgQ=;
        b=FBNqyzeuF7FmL46dZxT9vcAPc2Xj+EBaWicdKI6UYArFAoi+icm3aXdH7v3YaexQrA
         tgTG6SeYBxxr7c9okmDPk2VeoUgJyG0Yyl28vAZEneDqwroO6mE4u9ZpS6pP6kB5o51H
         /OUYdPrqPeQApVJnQTf7F+/kbNvNtZb0O4rtLYi9ygSzDivlXwIsEugQ0Q/vPCEvIDHy
         ixA4eY4XCkCUyajJgDhOcFfwePYh415kOPJ5EttIWDDzor+4P3kDQxPauH7zfm+wyVmY
         BhxgckysEsnGtoLeVb+TzMn/d3ziW1Saua2bqw6Q0kOKs0dMz+a76rSyHwpiNQ78TnhG
         N3dQ==
X-Gm-Message-State: AOJu0YwTS8NVdPk88QTlNo8ILUsfMVyXxF5/WzXCm+t246LN2pFkjgZf
        8PHbsBKfmCxa1K8g/UNA1E4NbA==
X-Google-Smtp-Source: AGHT+IFJHaBKDBa9FsHXtzux2UkvFgC3UTp4BhhdsEjv8fCLAr/6/KNue5g8DvDfgdf99+Ek70M0DA==
X-Received: by 2002:a17:902:ec8b:b0:1c0:cbaf:6939 with SMTP id x11-20020a170902ec8b00b001c0cbaf6939mr11608160plg.3.1694425670620;
        Mon, 11 Sep 2023 02:47:50 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:47:50 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v6 18/45] sunrpc: dynamically allocate the sunrpc_cred shrinker
Date:   Mon, 11 Sep 2023 17:44:17 +0800
Message-Id: <20230911094444.68966-19-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use new APIs to dynamically allocate the sunrpc_cred shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>
CC: Olga Kornievskaia <kolga@netapp.com>
CC: Dai Ngo <Dai.Ngo@oracle.com>
CC: Tom Talpey <tom@talpey.com>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: Anna Schumaker <anna@kernel.org>
CC: linux-nfs@vger.kernel.org
CC: netdev@vger.kernel.org
---
 net/sunrpc/auth.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 2f16f9d17966..c9c270eececc 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -861,11 +861,7 @@ rpcauth_uptodatecred(struct rpc_task *task)
 		test_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags) != 0;
 }
 
-static struct shrinker rpc_cred_shrinker = {
-	.count_objects = rpcauth_cache_shrink_count,
-	.scan_objects = rpcauth_cache_shrink_scan,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *rpc_cred_shrinker;
 
 int __init rpcauth_init_module(void)
 {
@@ -874,9 +870,17 @@ int __init rpcauth_init_module(void)
 	err = rpc_init_authunix();
 	if (err < 0)
 		goto out1;
-	err = register_shrinker(&rpc_cred_shrinker, "sunrpc_cred");
-	if (err < 0)
+	rpc_cred_shrinker = shrinker_alloc(0, "sunrpc_cred");
+	if (!rpc_cred_shrinker) {
+		err = -ENOMEM;
 		goto out2;
+	}
+
+	rpc_cred_shrinker->count_objects = rpcauth_cache_shrink_count;
+	rpc_cred_shrinker->scan_objects = rpcauth_cache_shrink_scan;
+
+	shrinker_register(rpc_cred_shrinker);
+
 	return 0;
 out2:
 	rpc_destroy_authunix();
@@ -887,5 +891,5 @@ int __init rpcauth_init_module(void)
 void rpcauth_remove_module(void)
 {
 	rpc_destroy_authunix();
-	unregister_shrinker(&rpc_cred_shrinker);
+	shrinker_free(rpc_cred_shrinker);
 }
-- 
2.30.2

