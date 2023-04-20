Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD64F6E9CF8
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 22:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjDTUU6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 16:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDTUU5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 16:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F53B1FC2
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682022006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nGvMVEVk9J5qTPhR4eBGzSGkQnY+kIy7JXmod53nkE=;
        b=VFRhSC1Sasx82NAwVHspaSMtaI7G/sYm6lv/2Oe4bYi/iVZ72DGBS3kNVOhQM+a8GFueHN
        jtgMiQ64wrFEdpjNuJHhZvK6WFdZkMwkWNeJnc1Q7HI5gsZQ3PAt5zcoshpI93V3i6Kbii
        mGMbioMaw7mw68yT0rT5bSN36ESQ1mg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-cuvJ8IkoMgu9fr7aec0_hw-1; Thu, 20 Apr 2023 16:20:05 -0400
X-MC-Unique: cuvJ8IkoMgu9fr7aec0_hw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1966F101A531;
        Thu, 20 Apr 2023 20:20:05 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.16.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D26F492C3E;
        Thu, 20 Apr 2023 20:20:05 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id A594C1A27F9; Thu, 20 Apr 2023 16:20:04 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     linux-nfs@vger.kernel.org, keyrings@vger.kernel.org
Subject: [RFC PATCH 4/5] keys: add the ability to search user keyrings in search_cred_keyrings_rcu()
Date:   Thu, 20 Apr 2023 16:20:03 -0400
Message-Id: <20230420202004.239116-5-smayhew@redhat.com>
In-Reply-To: <20230420202004.239116-1-smayhew@redhat.com>
References: <20230420202004.239116-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We want to store GSS creds in user keyrings.  Make
search_cred_keyrings_rcu() search the user keyring if it exists so that
keys containing GSS creds will be found.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 security/keys/internal.h     |  1 +
 security/keys/process_keys.c | 78 ++++++++++++++++++++++++++++++------
 2 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index 3c1e7122076b..524178802406 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -149,6 +149,7 @@ extern key_ref_t search_process_keyrings_rcu(struct keyring_search_context *ctx)
 extern struct key *find_keyring_by_name(const char *name, bool uid_keyring);
 
 extern int look_up_user_keyrings(struct key **, struct key **);
+extern struct key *get_user_keyring_rcu(const struct cred *);
 extern struct key *get_user_session_keyring_rcu(const struct cred *);
 extern int install_thread_keyring_to_cred(struct cred *);
 extern int install_process_keyring_to_cred(struct cred *);
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index b5d5333ab330..c78b13a0c5a2 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -179,13 +179,12 @@ int look_up_user_keyrings(struct key **_user_keyring,
 }
 
 /*
- * Get the user session keyring if it exists, but don't create it if it
- * doesn't.
+ * Get a keyring if it exists, but don't create it if it doesn't.
  */
-struct key *get_user_session_keyring_rcu(const struct cred *cred)
+static struct key *get_keyring_rcu(const struct cred *cred, key_serial_t id)
 {
 	struct key *reg_keyring = READ_ONCE(cred->user_ns->user_keyring_register);
-	key_ref_t session_keyring_r;
+	key_ref_t keyring_r;
 	char buf[20];
 
 	struct keyring_search_context ctx = {
@@ -201,15 +200,47 @@ struct key *get_user_session_keyring_rcu(const struct cred *cred)
 	if (!reg_keyring)
 		return NULL;
 
-	ctx.index_key.desc_len = snprintf(buf, sizeof(buf), "_uid_ses.%u",
-					  from_kuid(cred->user_ns,
-						    cred->user->uid));
+	switch (id) {
+	case KEY_SPEC_USER_KEYRING:
+		ctx.index_key.desc_len = snprintf(buf, sizeof(buf),
+						  "_uid.%u",
+						  from_kuid(cred->user_ns,
+							    cred->user->uid));
+		break;
+	case KEY_SPEC_USER_SESSION_KEYRING:
+		ctx.index_key.desc_len = snprintf(buf, sizeof(buf),
+						  "_uid_ses.%u",
+						  from_kuid(cred->user_ns,
+							    cred->user->uid));
+		break;
+	default:
+		return NULL;
+		break;
+	}
 
-	session_keyring_r = keyring_search_rcu(make_key_ref(reg_keyring, true),
-					       &ctx);
-	if (IS_ERR(session_keyring_r))
+	keyring_r = keyring_search_rcu(make_key_ref(reg_keyring, true), &ctx);
+
+	if (IS_ERR(keyring_r))
 		return NULL;
-	return key_ref_to_ptr(session_keyring_r);
+	return key_ref_to_ptr(keyring_r);
+}
+
+/*
+ * Get the user keyring if it exists, but don't create it if it
+ * doesn't.
+ */
+struct key *get_user_keyring_rcu(const struct cred *cred)
+{
+	return get_keyring_rcu(cred, KEY_SPEC_USER_KEYRING);
+}
+
+/*
+ * Get the user session keyring if it exists, but don't create it if it
+ * doesn't.
+ */
+struct key *get_user_session_keyring_rcu(const struct cred *cred)
+{
+	return get_keyring_rcu(cred, KEY_SPEC_USER_SESSION_KEYRING);
 }
 
 /*
@@ -421,7 +452,7 @@ void key_fsgid_changed(struct cred *new_cred)
  */
 key_ref_t search_cred_keyrings_rcu(struct keyring_search_context *ctx)
 {
-	struct key *user_session;
+	struct key *user_session, *user;
 	key_ref_t key_ref, ret, err;
 	const struct cred *cred = ctx->cred;
 
@@ -519,6 +550,29 @@ key_ref_t search_cred_keyrings_rcu(struct keyring_search_context *ctx)
 		}
 	}
 
+	/* search the user keyring */
+	if ((user = get_user_keyring_rcu(cred))) {
+		key_ref = keyring_search_rcu(make_key_ref(user, 1),
+					     ctx);
+		key_put(user);
+
+		if (!IS_ERR(key_ref))
+			goto found;
+
+		switch (PTR_ERR(key_ref)) {
+		case -EAGAIN: /* no key */
+			if (ret)
+				break;
+			fallthrough;
+		case -ENOKEY: /* negative key */
+			ret = key_ref;
+			break;
+		default:
+			err = key_ref;
+			break;
+		}
+	}
+
 	/* no key - decide on the error we're going to go for */
 	key_ref = ret ? ret : err;
 
-- 
2.39.2

