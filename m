Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF40B6E9CF7
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 22:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjDTUUy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 16:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjDTUUw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 16:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2712D5B
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682022006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbzfUE8fYwbKvInbkIXAGWwcJgA5j8cy5aE4T5fjle8=;
        b=cB8HTJsjyYPSYhjddCOHgkBL+XrQrd0MImBwoa/6hqGsbebECu2IWxBRDuka5yb0Fy1/yK
        xoAccFOxCWczoHhlPgDV6CBwhrErtng3mIoICiiyqLPf42VqSUae47iOl8DDaALPdtB6+t
        jxJungHnxJhqnv7vBnKNanL/10jeANA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-H3X0Z3c8Ne6z5jUkdfeHrw-1; Thu, 20 Apr 2023 16:20:05 -0400
X-MC-Unique: H3X0Z3c8Ne6z5jUkdfeHrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08E19811E7B;
        Thu, 20 Apr 2023 20:20:05 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.16.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F118B63A5D;
        Thu, 20 Apr 2023 20:20:04 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 9A6291A27F3; Thu, 20 Apr 2023 16:20:04 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     linux-nfs@vger.kernel.org, keyrings@vger.kernel.org
Subject: [RFC PATCH 1/5] keys: export keyring_ptr_to_key()
Date:   Thu, 20 Apr 2023 16:20:00 -0400
Message-Id: <20230420202004.239116-2-smayhew@redhat.com>
In-Reply-To: <20230420202004.239116-1-smayhew@redhat.com>
References: <20230420202004.239116-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We want to be able to garbage collect keyrings using a custom select
iterator, which will need to use keyring_ptr_to_key().

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 include/linux/key.h     | 2 ++
 security/keys/keyring.c | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 8dc7f7c3088b..3f4c6d6df921 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -417,6 +417,8 @@ extern int key_move(struct key *key,
 extern int key_unlink(struct key *keyring,
 		      struct key *key);
 
+extern inline struct key *keyring_ptr_to_key(const struct assoc_array_ptr *x);
+
 extern struct key *keyring_alloc(const char *description, kuid_t uid, kgid_t gid,
 				 const struct cred *cred,
 				 key_perm_t perm,
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 4448758f643a..c57f3cef32fa 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -37,11 +37,14 @@ static inline bool keyring_ptr_is_keyring(const struct assoc_array_ptr *x)
 {
 	return (unsigned long)x & KEYRING_PTR_SUBTYPE;
 }
-static inline struct key *keyring_ptr_to_key(const struct assoc_array_ptr *x)
+
+inline struct key *keyring_ptr_to_key(const struct assoc_array_ptr *x)
 {
 	void *object = assoc_array_ptr_to_leaf(x);
 	return (struct key *)((unsigned long)object & ~KEYRING_PTR_SUBTYPE);
 }
+EXPORT_SYMBOL_GPL(keyring_ptr_to_key);
+
 static inline void *keyring_key_to_ptr(struct key *key)
 {
 	if (key->type == &key_type_keyring)
-- 
2.39.2

