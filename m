Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C12620ACF3
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 09:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgFZHXZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 03:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgFZHXZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 03:23:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379CCC08C5C1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2020 00:23:25 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so8365288ejc.8
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2020 00:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YqzsgpankSjyC6Zm1GoJe0Pp+/Tqbn2CkkH2X/Xsq8=;
        b=ScISZwzOC2hVxOohFc95Ne6NHWuU33rZHyxJ0GUyDnyt3I2tQcEDKsJUT+NxUX5hVx
         xkiVW+5/mfh7DwmQ3f2UrLCs7VA7NLan+5AngdQGusKSvwG4jvSbFTfZVNytfECEwWnN
         ZG8f+hLT15bdiqFLBKOKEH1AE8wg0rls7sNm/hJ+dImG1gKl9sYKE6/1jsFXPxM27rJB
         zHBTVVvna/OCTFR+a7XEbmtV3OIvEPjH0erg9Nf/GNUyrpxd2yIGCaP1GSl29YgvDmxn
         NaF3tX7fwqFQMMV22kp3W0f66RLRxgZYoQQjpkOgYNrpZ0uro/SuPe+Jgu+K8yEZl87L
         SEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YqzsgpankSjyC6Zm1GoJe0Pp+/Tqbn2CkkH2X/Xsq8=;
        b=mCiDhuNiHtC/yh5gFMn3z1dC8DGW/zLrefGiF35OugDGpAfJtqMu2k3EZKHcuXhxBe
         OVkXofeLzjAAFfogTrItJdHjHH6sqruRqOdx9DYWsr24ZUWEVrnBNfFxCU3HAzAX0W8F
         JkaXkC6kzMqpzadQl+OxyHnxgnyH4HXGOSySj3MSfiV9QmMT8Ae6aaxMAtUzgrmEq5wn
         YMs3SJjKx2FptAYxQxwKta6vmgzRlzPiZnq9pV4hwJVk+095HZE5V9O5+ftgbu0nZFva
         mUXBjDKe7Y5JfQf2arr8w3CURjzUk5oi7TT6wpxO3PUYLvMCI7NkT7m2FlJMULUjKxOi
         PygQ==
X-Gm-Message-State: AOAM530fgoNQeC84ZWigsWrClBVf2lNGj4Uhfn123UOWfKLeIX2aXuur
        /d8rsQcujcsUxxLwstzi+sV/gZLtx28=
X-Google-Smtp-Source: ABdhPJy2DD+bz6nK2nJabeMSf5PRm5U5k813cvNgjA4lAybzYQ/DhVyYSEro0IMf7Pe5F/IZ2roLhg==
X-Received: by 2002:a17:906:6499:: with SMTP id e25mr1382269ejm.352.1593156203996;
        Fri, 26 Jun 2020 00:23:23 -0700 (PDT)
Received: from jupiter.home.aloni.org ([141.226.169.176])
        by smtp.gmail.com with ESMTPSA id m16sm10636067eji.23.2020.06.26.00.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:23:23 -0700 (PDT)
From:   Dan Aloni <dan@kernelim.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] sunrpc: destroy rpc_inode_cachep after unregister_filesystem
Date:   Fri, 26 Jun 2020 10:23:16 +0300
Message-Id: <20200626072316.39504-1-dan@kernelim.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Better to unregister the file system before destroying the kmem_cache
cache of the inodes, so that the inodes are freed before we are trying
to destroy it. Otherwise, kmem_cache yells that some objects are live.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 net/sunrpc/rpc_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 39e14d5edaf1..111f0b2e174f 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1509,6 +1509,6 @@ int register_rpc_pipefs(void)
 void unregister_rpc_pipefs(void)
 {
 	rpc_clients_notifier_unregister();
-	kmem_cache_destroy(rpc_inode_cachep);
 	unregister_filesystem(&rpc_pipe_fs_type);
+	kmem_cache_destroy(rpc_inode_cachep);
 }
-- 
2.25.4

