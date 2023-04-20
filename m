Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0708E6E9D05
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 22:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjDTUVs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 16:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjDTUVl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 16:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B9140CD
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682022008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KwkENu1/w9CSbhYifjW/+CifPchvjicIQbIAA0wBC68=;
        b=a9E5Cu66vSfKFCBR3Kb4xhS17XpqfaK0zmLHFAVyOAXHxteRrAlk3YgJxHU2MXzT70LRIZ
        ovdLZYbi6uqK1KeRmRIyC0wZvGFs73axcO3ZQ6JQVmO3LAVytGhnk1Kt78CtrnlwAxBLgj
        pk2fsM54DmLWVB5+1gFUHiNZ0FIop04=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-liYMcpHcOqeIcQOtz5SSUw-1; Thu, 20 Apr 2023 16:20:05 -0400
X-MC-Unique: liYMcpHcOqeIcQOtz5SSUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15877380607A;
        Thu, 20 Apr 2023 20:20:05 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.16.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A686C16024;
        Thu, 20 Apr 2023 20:20:05 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id A1B121A27F8; Thu, 20 Apr 2023 16:20:04 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     linux-nfs@vger.kernel.org, keyrings@vger.kernel.org
Subject: [RFC PATCH 3/5] keys: add dest_keyring parameter to request_key_with_auxdata()
Date:   Thu, 20 Apr 2023 16:20:02 -0400
Message-Id: <20230420202004.239116-4-smayhew@redhat.com>
In-Reply-To: <20230420202004.239116-1-smayhew@redhat.com>
References: <20230420202004.239116-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We want to store GSS creds in user keyrings.  Add a dest_keyring
parameter to request_key_with_auxdata() so we can do that.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/nfs4idmap.c          | 2 +-
 include/linux/key.h         | 3 ++-
 security/keys/request_key.c | 5 +++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 25a7c771cfd8..15d4fc30bf50 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -292,7 +292,7 @@ static struct key *nfs_idmap_request_key(const char *name, size_t namelen,
 	if (IS_ERR(rkey)) {
 		mutex_lock(&idmap->idmap_mutex);
 		rkey = request_key_with_auxdata(&key_type_id_resolver_legacy,
-						desc, NULL, "", 0, idmap);
+						desc, NULL, "", 0, idmap, NULL);
 		mutex_unlock(&idmap->idmap_mutex);
 	}
 	if (!IS_ERR(rkey))
diff --git a/include/linux/key.h b/include/linux/key.h
index 6cfc60aca505..009dfd3d27b0 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -333,7 +333,8 @@ extern struct key *request_key_with_auxdata(struct key_type *type,
 					    struct key_tag *domain_tag,
 					    const void *callout_info,
 					    size_t callout_len,
-					    void *aux);
+					    void *aux,
+					    struct key *dest_keyring);
 
 /**
  * request_key - Request a key and wait for construction
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 07a0ef2baacd..1424a6fa4c9d 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -735,14 +735,15 @@ struct key *request_key_with_auxdata(struct key_type *type,
 				     struct key_tag *domain_tag,
 				     const void *callout_info,
 				     size_t callout_len,
-				     void *aux)
+				     void *aux,
+				     struct key *dest_keyring)
 {
 	struct key *key;
 	int ret;
 
 	key = request_key_and_link(type, description, domain_tag,
 				   callout_info, callout_len,
-				   aux, NULL, KEY_ALLOC_IN_QUOTA);
+				   aux, dest_keyring, KEY_ALLOC_IN_QUOTA);
 	if (!IS_ERR(key)) {
 		ret = wait_for_key_construction(key, false);
 		if (ret < 0) {
-- 
2.39.2

