Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8915722244B
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jul 2020 15:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgGPNx1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jul 2020 09:53:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26786 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728479AbgGPNx1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jul 2020 09:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594907605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkYJ5KfgHbSCoDDgLkSLIkmRMOC5WDOdKgNR4CVCR3w=;
        b=bpFbAzVx7OTDgv/NHAER0IWbZv8vzWpRQnkhBkrzWBTTITOtB3KUFaq80cG2nfYtkwoGSW
        m3z+TR+eXBbb8Z2DE4WJHum2uAgzAH5lT4UACVkHk2ZjnUI7y0A05RNmNzveFLuLKiVqHt
        YVa5qLJ4idRx5v5s7rSExkaiEm+y0ug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-AAd25KdUNHWKsIXOzdn9QQ-1; Thu, 16 Jul 2020 09:53:20 -0400
X-MC-Unique: AAd25KdUNHWKsIXOzdn9QQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80EE519200C0
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jul 2020 13:53:19 +0000 (UTC)
Received: from ovpn-112-45.ams2.redhat.com (ovpn-112-45.ams2.redhat.com [10.36.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 946767011D;
        Thu, 16 Jul 2020 13:53:18 +0000 (UTC)
Message-ID: <84306391396559759440c6948c64c2b276f74424.camel@redhat.com>
Subject: [PATCH v2 1/4] nfs-utils: Factor out common structure cleanup calls
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     Steve Dickson <steved@redhat.com>
Date:   Thu, 16 Jul 2020 14:53:16 +0100
In-Reply-To: <c6571aecaaeff95681421c1684814a823b8a087e.camel@redhat.com>
References: <c6571aecaaeff95681421c1684814a823b8a087e.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Factor out common structure cleanup calls

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
---
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


