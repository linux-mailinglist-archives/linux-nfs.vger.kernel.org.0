Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D8068DF26
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Feb 2023 18:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjBGRl5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Feb 2023 12:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjBGRly (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Feb 2023 12:41:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70D2C145
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 09:41:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 910B6B81A63
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 17:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9805C433EF;
        Tue,  7 Feb 2023 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675791710;
        bh=NLlOzjvYsav0jnhRBiJKu+LtURlnW7UQe3kR8LUFaMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thDdyXFhL/e3j/WV9x19elWNogSXLLlRRjnDymW1I1DDruzUes+gB+klDmiYS0OsC
         GwL9SUfINb+pZmUF4W7zUMdH1G5OVG8YxaEXAclas6Lp4qzRMD2Y3UkyQ8gg+Vszdy
         GVzppgCpvRZOMZTNaFnmZsMCARgq37qyYXo30JCDOq8b58f793KU9MPa6o8xP1Dh9O
         Z3HRYZm4rQCZm/Wje9n3WDoCsBobiTVQDeEW+6JyfoXLHza8kfA0EEOUxcYXYCwVqq
         V7YlsirsdfLPbEKwjRPH4t36dMrmqfZhrltMt01TBUzVRsxKHEbrt34c5E1RrXtrzk
         idBFRz3u8Wf/Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com, trond.myklebust@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 1/2] errseq: add a new errseq_fetch helper
Date:   Tue,  7 Feb 2023 12:41:46 -0500
Message-Id: <20230207174147.205482-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207174147.205482-1-jlayton@kernel.org>
References: <20230207174147.205482-1-jlayton@kernel.org>
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

We need to be able to fetch the current value for nfsd's write
verifiers, but in the event that the value hasn't been SEEN, we don't
want to return a 0. Resurrect the old errseq_sample routine (before
Willy fixed it) and rechristen it as errseq_fetch.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/errseq.h |  1 +
 lib/errseq.c           | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/errseq.h b/include/linux/errseq.h
index fc2777770768..13a731236c9b 100644
--- a/include/linux/errseq.h
+++ b/include/linux/errseq.h
@@ -9,6 +9,7 @@ typedef u32	errseq_t;
 
 errseq_t errseq_set(errseq_t *eseq, int err);
 errseq_t errseq_sample(errseq_t *eseq);
+errseq_t errseq_fetch(errseq_t *eseq);
 int errseq_check(errseq_t *eseq, errseq_t since);
 int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
 #endif
diff --git a/lib/errseq.c b/lib/errseq.c
index 93e9b94358dc..f243b7dc36f5 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -109,7 +109,7 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 EXPORT_SYMBOL(errseq_set);
 
 /**
- * errseq_sample() - Grab current errseq_t value.
+ * errseq_sample() - Grab current errseq_t value (or 0 if it's unseen)
  * @eseq: Pointer to errseq_t to be sampled.
  *
  * This function allows callers to initialise their errseq_t variable.
@@ -131,6 +131,37 @@ errseq_t errseq_sample(errseq_t *eseq)
 }
 EXPORT_SYMBOL(errseq_sample);
 
+/**
+ * errseq_fetch() - Grab current errseq_t value
+ * @eseq: Pointer to errseq_t to be sampled.
+ *
+ * This function grabs the current errseq_t value, and returns it,
+ * and marks the value as SEEN. This differs from a "sample" in that we
+ * grab the actual value even if it has not been seen before (instead of
+ * returning 0 in that case).
+ *
+ * Context: Any context.
+ * Return: The current errseq value.
+ */
+errseq_t errseq_fetch(errseq_t *eseq)
+{
+	errseq_t old = READ_ONCE(*eseq);
+	errseq_t new = old;
+
+	/*
+	 * For the common case of no errors ever having been set, we can skip
+	 * marking the SEEN bit. Once an error has been set, the value will
+	 * never go back to zero.
+	 */
+	if (old != 0) {
+		new |= ERRSEQ_SEEN;
+		if (old != new)
+			cmpxchg(eseq, old, new);
+	}
+	return new;
+}
+EXPORT_SYMBOL(errseq_fetch);
+
 /**
  * errseq_check() - Has an error occurred since a particular sample point?
  * @eseq: Pointer to errseq_t value to be checked.
-- 
2.39.1

