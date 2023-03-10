Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5C6B4B6D
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Mar 2023 16:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCJPo6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Mar 2023 10:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjCJPon (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Mar 2023 10:44:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9326A124EA3
        for <linux-nfs@vger.kernel.org>; Fri, 10 Mar 2023 07:32:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E34661A36
        for <linux-nfs@vger.kernel.org>; Fri, 10 Mar 2023 15:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0F1C433EF;
        Fri, 10 Mar 2023 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678462360;
        bh=Z8vVTszao+DZeOKTPrKV1xshZvpZxant+oPMJ7AcDt4=;
        h=From:To:Cc:Subject:Date:From;
        b=eM4Pzys4s3SHb+D5OnU6eNbe1P5UJUHnrpbZwfqYqD0qUVxCdnvUbuDi9B1IIjVoV
         Koj46Bd9n1frQKOf5c11fKUrZPWlBmHs9QA53i2tkU+FAsJBGPI4AuNTn9XbLs/iOy
         bz+P3a7Rgw3694S7xd0WwTZtCJ5uj2eQEC7UjoQpxTkT0SfX5EY3i1XkXRGkK27ClQ
         m1WwawQfl36/Dv2LNq6WccN/XJQzR9dDANmL567bVQrMLAOGNWahajHrnNi4zhW3LA
         RhflNIhzBl9VMpKUDj+mtsAiYRp4daNxcxfURW3RKlMhSYKQcwD79XCi1fxfTW8h+f
         M5pJ8yzlLz3Pw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna@kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] lockd: fix tracepoint status name definitions when CONFIG_LOCKD_V4 isn't defined
Date:   Fri, 10 Mar 2023 10:32:38 -0500
Message-Id: <20230310153238.77446-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is probably a better way to do this that doesn't repeat anything.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303071503.shUSoIpC-lkp@intel.com/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/trace.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

Chuck, I'm fine if you want to just fold this into the original
tracepoint patch too. Also, let me know if you see a way to express this
better.

diff --git a/fs/lockd/trace.h b/fs/lockd/trace.h
index 3e84e3efaf22..11f1381b566c 100644
--- a/fs/lockd/trace.h
+++ b/fs/lockd/trace.h
@@ -10,6 +10,7 @@
 #include <linux/nfs.h>
 #include <linux/lockd/lockd.h>
 
+#ifdef CONFIG_LOCKD_V4
 #define show_nlm_status(val)							\
 	__print_symbolic(val,							\
 		{ NLM_LCK_GRANTED,		"LCK_GRANTED" },		\
@@ -22,6 +23,15 @@
 		{ NLM_STALE_FH,			"STALE_FH" },			\
 		{ NLM_FBIG,			"FBIG" },			\
 		{ NLM_FAILED,			"FAILED" })
+#else
+#define show_nlm_status(val)							\
+	__print_symbolic(val,							\
+		{ NLM_LCK_GRANTED,		"LCK_GRANTED" },		\
+		{ NLM_LCK_DENIED,		"LCK_DENIED" },			\
+		{ NLM_LCK_DENIED_NOLOCKS,	"LCK_DENIED_NOLOCKS" },		\
+		{ NLM_LCK_BLOCKED,		"LCK_BLOCKED" },		\
+		{ NLM_LCK_DENIED_GRACE_PERIOD,	"LCK_DENIED_GRACE_PERIOD" })
+#endif
 
 DECLARE_EVENT_CLASS(nlmclnt_lock_event,
 		TP_PROTO(
-- 
2.39.2

