Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B018A696648
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 15:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjBNOPr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 09:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjBNOPl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 09:15:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E41526B;
        Tue, 14 Feb 2023 06:15:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id hg24-20020a05600c539800b003e1f5f2a29cso1322522wmb.4;
        Tue, 14 Feb 2023 06:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fN0HsQBeTzPwMed5PupJcQefwKI7QfP4v9v/v9W2LxI=;
        b=UFaRySGiv/0XDhI+9JMU/apFJCQZZUwpHqeYYYfKT6uFj0y4cNTT2ahKjCtWHWnknt
         8SlXyNDZRVpNjivo8F7Z3BI7mdJ7IKfhvNtYuElpfa+zvH75OyD6uXWa7da2pvmcCJkx
         Mojc94U7XVWwqjzaSFOmGcoZ8bNXB4gNWCXC6Xj+SGE5dS7RTkAvJljvIbIDXunVkHWT
         QLsXNOozZgq+r+T3nhGg/pPKX1kmtr5KTmpqBusl6RdefCYc00Gw2sKUng+tMxTzmolk
         eEo6b3i87GEq6jDtbYDyIj2XohOLo0kT2//narlDGgT3jDNlzM5abkHlEJ1qOqKf52wa
         F1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fN0HsQBeTzPwMed5PupJcQefwKI7QfP4v9v/v9W2LxI=;
        b=PnJmLejpwpFMQwlheCa1nkjlgmNgYo1/Sz2GYYOwGwehtMCstNcu0RWzUjJWTpVFT1
         OTj3draNm58PMRRX/z3y6N9ICCubbJ1/uFalcwk2ESI1cIekL5qrPGHh5RWY57MWRzw3
         53fFSrYbbHPjEktuyh3rPXyi7WPuH6oveVz+k2KdbjJNdBJtPlh4vxp9o02PAN0Qgh1A
         SDvVE4Or0bRVnilIvy6krqI41EFsgGE5RZD/vh0/BtgLfJfr1Z9GAojmQ7BNHWATWsED
         /m8pIWPA3MrGQKl4hjAXOaa+m19W+MsgMz1PT5ewp/kls6h0D9b52sfQjJQAl/XoFVx3
         WZRw==
X-Gm-Message-State: AO0yUKUfXVkUZti57rF7AAvXfVnhspbTatLS4Bjfb1Y9cEYlX3xtKTuy
        jICWnvdSG3JnxEO3Wv19uWU04cFoEWsF4XP2
X-Google-Smtp-Source: AK7set8xfol8iOAuE9Uz+t4fyhTxWBj+dfG5LfPISwLrecWhbMm8j9QEeStmI5TGuUB+ez4xaqFoMQ==
X-Received: by 2002:a05:600c:4927:b0:3df:f2a5:49fb with SMTP id f39-20020a05600c492700b003dff2a549fbmr2148871wmp.7.1676384069688;
        Tue, 14 Feb 2023 06:14:29 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t13-20020adfe44d000000b002c557f82e27sm5881010wrm.99.2023.02.14.06.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:14:29 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] nfsd: remove redundant assignment to pointer dentry
Date:   Tue, 14 Feb 2023 14:14:28 +0000
Message-Id: <20230214141428.301121-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The pointer dentry is assigned a value that is never read, the
assignment is redundant and can be removed.

Cleans up clang-scan warning:
fs/nfsd/nfsctl.c:1231:2: warning: Value stored to 'dentry' is
never read [deadcode.DeadStores]
        dentry = ERR_PTR(ret);

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/nfsd/nfsctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 04474b8ccf0a..5946064cd794 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1228,7 +1228,6 @@ static void nfsd_symlink(struct dentry *parent, const char *name,
 	return;
 out_err:
 	dput(dentry);
-	dentry = ERR_PTR(ret);
 	goto out;
 }
 #else
-- 
2.30.2

