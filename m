Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44C735FA5A
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 20:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351719AbhDNSJA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 14:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234472AbhDNSI7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 14:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618423717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsouOU8zyOOx+wxkCbPTK0hBOcc15DhOMQfLZVoHO2g=;
        b=eFW03uva37Sgd81wrGzkYp2zNQbR4TFagkX8hyGtYZfpJ52Nr/Qv9IwmOTFM97aBqb6rps
        1lw54vuDZmprjyVa3oQBEoK2gexSowI+9/s1xtTEe7d72/DZVJo5Zm+9NOk8iuqb+Jbqkm
        Cb92omBHg2xEHhjWneZIeJaW9u36F8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-vxF9mEIeMGCwAnrviJT-Wg-1; Wed, 14 Apr 2021 14:08:34 -0400
X-MC-Unique: vxF9mEIeMGCwAnrviJT-Wg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BADB801814
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 18:08:33 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-83.phx2.redhat.com [10.3.112.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29E0860862
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 18:08:33 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/3] nfs-utils: Add support for further ${variable} expansions in nfs.conf
Date:   Wed, 14 Apr 2021 14:10:39 -0400
Message-Id: <20210414181040.7108-3-steved@redhat.com>
In-Reply-To: <20210414181040.7108-1-steved@redhat.com>
References: <20210414181040.7108-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Alice Mitchell <ajmitchell@redhat.com>

This adds support for substituting in the systems machine_id or
the hostname as the unique id, and caches the results

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/nfs/conffile.c | 260 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 249 insertions(+), 11 deletions(-)

diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index fd4a17ad..d03de012 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -40,6 +40,7 @@
 #include <sys/stat.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <linux/if_alg.h>
 #include <ctype.h>
 #include <fcntl.h>
 #include <stdio.h>
@@ -114,12 +115,66 @@ struct conf_binding {
   char *tag;
   char *value;
   int is_default;
+  char *cache;
 };
 
 LIST_HEAD (conf_bindings, conf_binding) conf_bindings[256];
 
+typedef char * (*expand_fn_t)(void);
+struct expansion_types {
+	const char *name;
+	expand_fn_t func;
+};
+
+typedef struct {
+	uint8_t bytes[16];
+} id128_t;
+
+/*
+ * Application ID for use with generating a machine-id string
+ */
+static id128_t nfs_appid = {.bytes = {0xff,0x3b,0xf0,0x0f,0x34,0xa6,0x43,0xc5, \
+                                       0x93,0xdd,0x16,0xdc,0x7c,0xeb,0x88,0xc8}};
+
 const char *modified_by = NULL;
 
+static __inline__ char
+hexchar(int x) {
+	static const char table[16] = "0123456789abcdef";
+	return table[x & 15];
+}
+
+static __inline__ int
+unhexchar(char h)
+{
+	if (h >= '0' && h <= '9')
+		return h - '0';
+	if (h >= 'a' && h <= 'f')
+		return h - 'a' + 10;
+	if (h >= 'A' && h <= 'F')
+		return h - 'A' + 10;
+	return -1;
+}
+
+static char *
+tohexstr(const unsigned char *data, int len)
+{
+	int i;
+	char *result = NULL;
+
+	result = calloc(1, (len*2)+1);
+	if (!result) {
+		xlog(L_ERROR, "malloc error formatting string");
+		return NULL;
+	}
+
+	for (i = 0; i < len; i++) {
+		result[i*2] = hexchar(data[i] >> 4);
+		result[i*2+1] = hexchar(data[i] & 0x0F);
+	}
+	return result;
+}
+
 static __inline__ uint8_t
 conf_hash(const char *s)
 {
@@ -132,6 +187,193 @@ conf_hash(const char *s)
 	return hash;
 }
 
+static int
+id128_from_string(const char s[], id128_t *ret)
+{
+	id128_t t;
+	unsigned int n, i;
+	for (n=0, i=0; n<16; ) {
+		int a, b;
+		a = unhexchar(s[i++]);
+		if (a < 0)
+			return 1;
+		b = unhexchar(s[i++]);
+		if (b < 0)
+			return 1;
+
+		t.bytes[n++] = (a << 4) | b;
+	}
+	if (s[i] != 0)
+		return 1;
+	if (ret)
+		*ret = t;
+	return 0;
+}
+
+/*
+ * cryptographic hash (sha256) data into a hex encoded string
+ */
+static char *
+strhash(unsigned char *key, size_t keylen, unsigned char *data, size_t dlen)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_alg alg;
+	} sa;
+	int sock = -1;
+	int hfd = -1;
+	uint8_t digest[129];
+	int n;
+	char *result = NULL;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.alg.salg_family = AF_ALG;
+	strcpy((char *)sa.alg.salg_type, "hash");
+	strcpy((char *)sa.alg.salg_name, "hmac(sha256)");
+
+	sock = socket(AF_ALG, SOCK_SEQPACKET|SOCK_CLOEXEC, 0);
+	if (sock < 0) {
+		xlog(L_ERROR, "error creating socket");
+		goto cleanup;
+	}
+
+	if (bind(sock, (struct sockaddr *)&sa.sa, sizeof(sa)) < 0) {
+		xlog(L_ERROR, "error opening khash interface");
+		goto cleanup;
+	}
+
+	if (key && keylen > 0) {
+		if (setsockopt(sock, SOL_ALG, ALG_SET_KEY, key, keylen) < 0) {
+			xlog(L_ERROR, "Error setting key: %s", strerror(errno));
+			goto cleanup;
+		}
+	}
+
+	hfd = accept4(sock, NULL, 0, SOCK_CLOEXEC);
+	if (hfd < 0) {
+		xlog(L_ERROR, "Error initiating khash: %s", strerror(errno));
+		goto cleanup;
+	}
+
+	n = send(hfd, data, dlen, 0);
+	if (n < 0) {
+		xlog(L_ERROR, "Error updating khash: %s", strerror(errno));
+		goto cleanup;
+	}
+
+	n = recv(hfd, digest, sizeof(digest), 0);
+	if (n < 0) {
+		xlog(L_ERROR, "Error fetching khash: %s", strerror(errno));
+		goto cleanup;
+	}
+
+	result = tohexstr(digest, n);
+cleanup:
+	if (sock != -1)
+		close(sock);
+	if (hfd != -1)
+		close(hfd);
+	if (hfd != -1)
+		close(hfd);
+
+	return result;
+}
+
+/*
+ * Read one line of content from a file
+ */
+static char *
+read_oneline(const char *filename)
+{
+	char *content = conf_readfile(filename);
+	char *end;
+
+	if (content == NULL)
+		return NULL;
+
+	/* trim to only the first line */
+	end = strchr(content, '\n');
+	if (end != NULL)
+		*end = '\0';
+	end = strchr(content, '\r');
+	if (end != NULL)
+		*end = '\0';
+
+	return content;
+}
+
+static char *
+expand_machine_id(void)
+{
+	char *key = read_oneline("/etc/machine-id");
+	id128_t mid;
+	char * result = NULL;
+	size_t idlen = 0;
+
+	if (key == NULL)
+		return NULL;
+
+	idlen = strlen(key);
+	if (!id128_from_string(key, &mid)) {
+		result = strhash(mid.bytes, sizeof(mid), nfs_appid.bytes, sizeof(nfs_appid));
+		if (result && strlen(result) > idlen)
+			result[idlen]=0;
+	}
+	free(key);
+	return result;
+}
+
+static char *
+expand_hostname(void)
+{
+	int maxlen = HOST_NAME_MAX + 1;
+	char * hostname = calloc(1, maxlen);
+
+	if (!hostname)
+		return NULL;
+	if ((gethostname(hostname, maxlen)) == -1) {
+		free(hostname);
+		return NULL;
+	}
+	return hostname;
+}
+
+static struct expansion_types  var_expansions[] = {
+	{ "machine-id", expand_machine_id },
+	{ "hostname", expand_hostname },
+};
+
+/* Deal with more complex variable substitutions */
+static char *
+expand_variable(const char *name)
+{
+	size_t len;
+
+	if (name == NULL || name[0] != '$')
+		return NULL;
+
+	len = strlen(name);
+	if (name[1] == '{' && name[len-1] == '}') {
+		char *varname = strndupa(&name[2], len-3);
+
+		for (size_t i=0; i<sizeof(var_expansions); i++) {
+			if (!strcasecmp(varname, var_expansions[i].name)) {
+				return var_expansions[i].func();
+			}
+		}
+		xlog_warn("get_conf: Unknown variable ${%s}", varname);
+	} else {
+		/* expand $name from [environment] section,
+		* or from environment
+		*/
+		char *env = getenv(&name[1]);
+		if (env == NULL || *env == 0)
+			env = conf_get_section("environment", NULL, &name[1]);
+		return env;
+	}
+	return NULL;
+}
+
 /*
  * free all the component parts of a conf_binding struct
  */
@@ -147,6 +389,8 @@ static void free_confbind(struct conf_binding *cb)
 		free(cb->tag);
 	if (cb->value)
 		free(cb->value);
+	if (cb->cache)
+		free(cb->cache);
 	free(cb);
 }
 
@@ -921,7 +1165,7 @@ char *
 conf_get_section(const char *section, const char *arg, const char *tag)
 {
 	struct conf_binding *cb;
-retry:
+
 	cb = LIST_FIRST (&conf_bindings[conf_hash (section)]);
 	for (; cb; cb = LIST_NEXT (cb, link)) {
 		if (strcasecmp(section, cb->section) != 0)
@@ -933,19 +1177,13 @@ retry:
 		if (strcasecmp(tag, cb->tag) != 0)
 			continue;
 		if (cb->value[0] == '$') {
-			/* expand $name from [environment] section,
-			 * or from environment
-			 */
-			char *env = getenv(cb->value+1);
-			if (env && *env)
-				return env;
-			section = "environment";
-			tag = cb->value + 1;
-			goto retry;
+			if (!cb->cache)
+				cb->cache = expand_variable(cb->value);
+			return cb->cache;
 		}
 		return cb->value;
 	}
-	return 0;
+	return NULL;
 }
 
 /*
-- 
2.30.2

