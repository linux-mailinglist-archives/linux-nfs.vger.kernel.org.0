Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB6B21BB28
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2020 18:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGJQjU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jul 2020 12:39:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52481 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726920AbgGJQjU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jul 2020 12:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594399159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cV6ZwytJy9ukH+GFGjzRhyoRphGRe/Q6NSvOCB+KPI=;
        b=DBoLW6Hlnxt9x9Jp9AWiOcGmDr1X5L0E8XJOuzsSDawJLxUDpaxDZXAKKMny4Cnwhv9oyn
        afr4kfwo2qPpk6u3q8TdOW6GgMmQlOokiSk8fqQOY4bgIqlC9HDS9gLRlMCha5BPH3B3lL
        lpJTr+RXcbd1L3Wp5jfE1hoeaFsfHoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-6PaaxWd_MQyoa2y3C6JRKw-1; Fri, 10 Jul 2020 12:39:17 -0400
X-MC-Unique: 6PaaxWd_MQyoa2y3C6JRKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 968DD1015DA7
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2020 16:39:16 +0000 (UTC)
Received: from ovpn-112-86.ams2.redhat.com (ovpn-112-86.ams2.redhat.com [10.36.112.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BAB7B60E1C;
        Fri, 10 Jul 2020 16:39:15 +0000 (UTC)
Message-ID: <21c590d9d1064ed7940322b688f3da3e0e1094a4.camel@redhat.com>
Subject: [PATCH 1/4] nfs-utils: Factor out common structure cleanup calls
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     Steve Dickson <steved@redhat.com>
Date:   Fri, 10 Jul 2020 17:39:13 +0100
In-Reply-To: <5a84777afb9ed8c866841471a1a7e3c9b295604d.camel@redhat.com>
References: <5a84777afb9ed8c866841471a1a7e3c9b295604d.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


 support/nfs/conffile.c | 84 +++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index 3d13610e..aea35917 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -128,6 +128,39 @@ conf_hash(const char *s)
 	return hash;
 }
 
+/*
+ * free all the component parts of a conf_binding struct
+ */
+static void free_confbind(struct conf_binding *cb)
+{
+	if (!cb)
+		return;
+	if (cb->section)
+		free(cb->section);
+	if (cb->arg)
+		free(cb->arg);
+	if (cb->tag)
+		free(cb->tag);
+	if (cb->value)
+		free(cb->value);
+	free(cb);
+}
+
+static void free_conftrans(struct conf_trans *ct)
+{
+	if (!ct)
+		return;
+	if (ct->section)
+		free(ct->section);
+	if (ct->arg)
+		free(ct->arg);
+	if (ct->tag)
+		free(ct->tag);
+	if (ct->value)
+		free(ct->value);
+	free(ct);
+}
+
 /*
  * Insert a tag-value combination from LINE (the equal sign is at POS)
  */
@@ -143,11 +176,7 @@ conf_remove_now(const char *section, const char *tag)
 				&& strcasecmp(cb->tag, tag) == 0) {
 			LIST_REMOVE(cb, link);
 			xlog(LOG_INFO,"[%s]:%s->%s removed", section, tag, cb->value);
-			free(cb->section);
-			free(cb->arg);
-			free(cb->tag);
-			free(cb->value);
-			free(cb);
+			free_confbind(cb);
 			return 0;
 		}
 	}
@@ -167,11 +196,7 @@ conf_remove_section_now(const char *section)
 			unseen = 0;
 			LIST_REMOVE(cb, link);
 			xlog(LOG_INFO, "[%s]:%s->%s removed", section, cb->tag, cb->value);
-			free(cb->section);
-			free(cb->arg);
-			free(cb->tag);
-			free(cb->value);
-			free(cb);
+			free_confbind(cb);
 			}
 		}
 	return unseen;
@@ -567,11 +592,7 @@ static void conf_free_bindings(void)
 		for (; cb; cb = next) {
 			next = LIST_NEXT(cb, link);
 			LIST_REMOVE(cb, link);
-			free(cb->section);
-			free(cb->arg);
-			free(cb->tag);
-			free(cb->value);
-			free(cb);
+			free_confbind(cb);
 		}
 		LIST_INIT(&conf_bindings[i]);
 	}
@@ -635,11 +656,7 @@ conf_cleanup(void)
 	for (node = TAILQ_FIRST(&conf_trans_queue); node; node = next) {
 		next = TAILQ_NEXT(node, link);
 		TAILQ_REMOVE (&conf_trans_queue, node, link);
-		if (node->section) free(node->section);
-		if (node->arg) free(node->arg);
-		if (node->tag) free(node->tag);
-		if (node->value) free(node->value);
-		free (node);
+		free_conftrans(node);
 	}
 	TAILQ_INIT(&conf_trans_queue);
 }
@@ -1005,14 +1022,7 @@ conf_set(int transaction, const char *section, const char *arg,
 	return 0;
 
 fail:
-	if (node->tag)
-		free(node->tag);
-	if (node->arg)
-		free(node->arg);
-	if (node->section)
-		free(node->section);
-	if (node)
-		free(node);
+	free_conftrans(node);
 	return 1;
 }
 
@@ -1038,10 +1048,7 @@ conf_remove(int transaction, const char *section, const char *tag)
 	return 0;
 
 fail:
-	if (node && node->section)
-		free (node->section);
-	if (node)
-		free (node);
+	free_conftrans(node);
 	return 1;
 }
 
@@ -1062,8 +1069,7 @@ conf_remove_section(int transaction, const char *section)
 	return 0;
 
 fail:
-	if (node)
-		free(node);
+	free_conftrans(node);
 	return 1;
 }
 
@@ -1094,15 +1100,7 @@ conf_end(int transaction, int commit)
 				}
 			}
 			TAILQ_REMOVE (&conf_trans_queue, node, link);
-			if (node->section)
-				free(node->section);
-			if (node->arg)
-				free(node->arg);
-			if (node->tag)
-				free(node->tag);
-			if (node->value)
-				free(node->value);
-			free (node);
+			free_conftrans(node);
 		}
 	}
 	return 0;
-- 
2.18.1


