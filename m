Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD26E9CF6
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 22:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjDTUUx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 16:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjDTUUw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 16:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0341330E8
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682022007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qyFPVwt4CpZKgdznFtXhQ6xNm/sItUwbxA9SIwDjbtc=;
        b=i/wjuB/oUlHB7blLvCkCHkPgjD64WgVgAIfL1oZr50D9ZYuQPor1FJWrqpC2UBFpLfhxAO
        JFG0xpuM9mvKHR4Swp5gloz8JFgTN8s/jCadiQy5ztj1xoBLmuMIsGyfyGxZMVL6r+tlz4
        8Q5cDCvjLc32jsfKVzX1iY5n22M0G5k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-d4UN-0suNROhkQ-f4gKgAg-1; Thu, 20 Apr 2023 16:20:05 -0400
X-MC-Unique: d4UN-0suNROhkQ-f4gKgAg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FCB9800B35;
        Thu, 20 Apr 2023 20:20:05 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.16.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0365D1121315;
        Thu, 20 Apr 2023 20:20:05 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 9DC671A27F7; Thu, 20 Apr 2023 16:20:04 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     linux-nfs@vger.kernel.org, keyrings@vger.kernel.org
Subject: [RFC PATCH 2/5] keys: add keyring_gc_custom()
Date:   Thu, 20 Apr 2023 16:20:01 -0400
Message-Id: <20230420202004.239116-3-smayhew@redhat.com>
In-Reply-To: <20230420202004.239116-1-smayhew@redhat.com>
References: <20230420202004.239116-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Allow a keyring to be garbage collected using a custom select iterator.

This will be used to destroy all the GSS creds for a particular RPC
client when that RPC client is shut down.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 include/linux/key.h     |  4 ++++
 security/keys/keyring.c | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/key.h b/include/linux/key.h
index 3f4c6d6df921..6cfc60aca505 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -433,6 +433,10 @@ extern int restrict_link_reject(struct key *keyring,
 
 extern int keyring_clear(struct key *keyring);
 
+extern void keyring_gc_custom(struct key *keyring,
+			      bool (*iterator)(void *object, void *iterator_data),
+			      void *iterator_data);
+
 extern key_ref_t keyring_search(key_ref_t keyring,
 				struct key_type *type,
 				const char *description,
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index c57f3cef32fa..8e93f1bbd7f1 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1795,3 +1795,14 @@ void keyring_restriction_gc(struct key *keyring, struct key_type *dead_type)
 
 	kleave(" [restriction gc]");
 }
+
+void keyring_gc_custom(struct key *keyring,
+		       bool (*iterator)(void *object, void *iterator_data),
+		       void *iterator_data)
+{
+	down_write(&keyring->sem);
+	assoc_array_gc(&keyring->keys, &keyring_assoc_array_ops,
+		       iterator, iterator_data);
+	up_write(&keyring->sem);
+}
+EXPORT_SYMBOL_GPL(keyring_gc_custom);
-- 
2.39.2

