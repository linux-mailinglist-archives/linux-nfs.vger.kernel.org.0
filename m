Return-Path: <linux-nfs+bounces-3483-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C485D8D45E7
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 09:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EADEB20B11
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 07:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CC64D8CC;
	Thu, 30 May 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFwl8Mcy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32997F
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053476; cv=none; b=M9f0aayhE5Z4gFv87s+/3LMIF7gWx2K8mzUi920VvGYG0Q+pYoMjOI1qLxmk3zGSeQlo5w5k1FncN0L1vz5br3VB+LowZWgQNSRLdyi290f6aMZgyQLeWF3krLrb9UwLGkzRXuFqW8r5MambKn8MoIAYVJOa4zVQli6YHFxUpLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053476; c=relaxed/simple;
	bh=reJjyPch94QfjKgJZo7cWKwkCkPcQstkfjbDsIQj+Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dcn4FDeS17wuykYWxzsqQ9Skt383BfAyNSEHKDcftPtRYFdx/wY/1dcMkcYPukimnn+OI17cgJu/00IfJpF1n5agC4UNV9Z973CbxBjHYTcMyBKphJvOd7ovx9se/AR3fW6socOgKrHj+E7ULvLAa7wYS8HaRjmvW1p8TLSflhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFwl8Mcy; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a352bbd9so85708166b.1
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 00:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717053473; x=1717658273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zr9+ioAEGHa+0b9Fk9qdvOydtRFvSKZnG/SPtPMxSyk=;
        b=bFwl8McyNQs6z0eeUU3ZdhzBUxs1LkhZVYh6h9H5VS7tW10D3pcG1npR6zk54J9fQL
         pCWC9Z3qPVsH6DCkXvIkn4FUSYE08+QK3mLRMjSGwkG+84OWsGTEkIWTexDiCsRajvmC
         hUMB6W3CiERz//fJZxUcqWwT9n7LjG2KW4Tf5of6wE34RaqufmCQ0CSBFozRhS8MYcuC
         OXxCu3SY4CoGg6NQQNAo2FQJVtvZqm7mJmq7HCnE0ACLvjeSRCysIVcYk7cdA9WXVMzi
         /6EugjGatxUFOK7GpsahrBttt0w7Mw007yJGqd5gvzZ1pY9ExE2jlgpd9r/+bIR9EKn5
         TOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717053473; x=1717658273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zr9+ioAEGHa+0b9Fk9qdvOydtRFvSKZnG/SPtPMxSyk=;
        b=tqHBGyLXkDtqz+6TMwDsKb2+y6DrU02IV+McUgdGhfp03TllQbIdb2akg5vXUi9yh9
         6LoCuZO1hnpTVAbzUfTSrgJGBbT+UUk3pX2WNz+YZd1Pz14Zzfpaw/IjTAYX5Cbopmzd
         cJK1dIGvGTcidN9m9cam9Mmj0vfpUq6kKMBlxvlHfIp37Qgoc0odJ+xar620uh0HXo5Y
         /kRXP57CLDfelJkzAWaN09FRPRezqr/bSDLDgVfdAYrXXE/iJipuN1GH+AjWR3xClkff
         z7dtuqIB7M8MLSu6jhfpb63Dn/J5nMWuCEtxxZyf+l7mlXAVqFeEq6S7hk3ShM/FDDNZ
         HmMg==
X-Gm-Message-State: AOJu0YxT3IjtgVfMF1fWfTKVBw3WxnxRwoBJNrCPUjXRSiIIJ17wxiij
	mk9TKBw0QybCpsH5gvr3Ps1wk5IMlXkT4I8uzdamUSLW3EoBlb4YYANoXTw4o6g=
X-Google-Smtp-Source: AGHT+IG7jJ2rOycoD4fI5Hk9s/2NRhoW6YV9i/qN/qlWfa80tENEWvE7pxwRvg051njbNog0g6jrQQ==
X-Received: by 2002:a17:906:4bc6:b0:a63:4bc:704d with SMTP id a640c23a62f3a-a65f090f193mr93652166b.1.1717053472987;
        Thu, 30 May 2024 00:17:52 -0700 (PDT)
Received: from localhost.localdomain ([178.132.109.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a666035881esm10545766b.133.2024.05.30.00.17.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 May 2024 00:17:52 -0700 (PDT)
From: =?UTF-8?q?Bogdan-Cristian=20T=C4=83t=C4=83roiu?= <b.tataroiu@gmail.com>
To: linux-nfs@vger.kernel.org
Cc: =?UTF-8?q?Bogdan-Cristian=20T=C4=83t=C4=83roiu?= <b.tataroiu@gmail.com>
Subject: [PATCH] Add guards around [nfsidmap] usages of [sysconf].
Date: Thu, 30 May 2024 08:17:25 +0100
Message-ID: <20240530071725.70043-1-b.tataroiu@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sysconf(_SC_GETPW_R_SIZE_MAX) and sysconf(_SC_GETGR_R_SIZE_MAX)
return -1 on musl, which causes either segmentation faults or ENOMEM
errors.

Replace all usages of sysconf with dedicated methods that guard against
a result of -1.

Signed-off-by: Bogdan-Cristian Tătăroiu <b.tataroiu@gmail.com>
---
 support/nfsidmap/gums.c             |  4 ++--
 support/nfsidmap/libnfsidmap.c      |  4 ++--
 support/nfsidmap/nfsidmap_common.c  | 16 ++++++++++++++++
 support/nfsidmap/nfsidmap_private.h |  2 ++
 support/nfsidmap/nss.c              |  8 ++++----
 support/nfsidmap/regex.c            |  9 +++++----
 support/nfsidmap/static.c           |  5 +++--
 7 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/support/nfsidmap/gums.c b/support/nfsidmap/gums.c
index 1d6eb318..e94a4c50 100644
--- a/support/nfsidmap/gums.c
+++ b/support/nfsidmap/gums.c
@@ -475,7 +475,7 @@ static int translate_to_uid(char *local_uid, uid_t *uid, uid_t *gid)
 	int ret = -1;
 	struct passwd *pw = NULL;
 	struct pwbuf *buf = NULL;
-	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	size_t buflen = get_pwnam_buflen();
 
 	buf = malloc(sizeof(*buf) + buflen);
 	if (buf == NULL)
@@ -501,7 +501,7 @@ static int translate_to_gid(char *local_gid, uid_t *gid)
 	struct group *gr = NULL;
 	struct group grbuf;
 	char *buf = NULL;
-	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	size_t buflen = get_grnam_buflen();
 	int ret = -1;
 
 	do {
diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
index f8c36480..e1475879 100644
--- a/support/nfsidmap/libnfsidmap.c
+++ b/support/nfsidmap/libnfsidmap.c
@@ -457,7 +457,7 @@ int nfs4_init_name_mapping(char *conffile)
 
 	nobody_user = conf_get_str("Mapping", "Nobody-User");
 	if (nobody_user) {
-		size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+		size_t buflen = get_pwnam_buflen();
 		struct passwd *buf;
 		struct passwd *pw = NULL;
 		int err;
@@ -478,7 +478,7 @@ int nfs4_init_name_mapping(char *conffile)
 
 	nobody_group = conf_get_str("Mapping", "Nobody-Group");
 	if (nobody_group) {
-		size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+		size_t buflen = get_grnam_buflen();
 		struct group *buf;
 		struct group *gr = NULL;
 		int err;
diff --git a/support/nfsidmap/nfsidmap_common.c b/support/nfsidmap/nfsidmap_common.c
index 4d2cb14f..310c68f0 100644
--- a/support/nfsidmap/nfsidmap_common.c
+++ b/support/nfsidmap/nfsidmap_common.c
@@ -116,3 +116,19 @@ int get_reformat_group(void)
 
 	return reformat_group;
 }
+
+size_t get_pwnam_buflen(void)
+{
+	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (buflen == -1)
+		buflen = 16384;
+	return buflen;
+}
+
+size_t get_grnam_buflen(void)
+{
+	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	if (buflen == -1)
+		buflen = 16384;
+	return buflen;
+}
diff --git a/support/nfsidmap/nfsidmap_private.h b/support/nfsidmap/nfsidmap_private.h
index a5cb6dda..234ca9d4 100644
--- a/support/nfsidmap/nfsidmap_private.h
+++ b/support/nfsidmap/nfsidmap_private.h
@@ -40,6 +40,8 @@ struct conf_list *get_local_realms(void);
 void free_local_realms(void);
 int get_nostrip(void);
 int get_reformat_group(void);
+size_t get_pwnam_buflen(void);
+size_t get_grnam_buflen(void);
 
 typedef enum {
 	IDTYPE_USER = 1,
diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
index 0f43076e..3fc045dc 100644
--- a/support/nfsidmap/nss.c
+++ b/support/nfsidmap/nss.c
@@ -91,7 +91,7 @@ static int nss_uid_to_name(uid_t uid, char *domain, char *name, size_t len)
 	struct passwd *pw = NULL;
 	struct passwd pwbuf;
 	char *buf;
-	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	size_t buflen = get_pwnam_buflen();
 	int err = -ENOMEM;
 
 	buf = malloc(buflen);
@@ -119,7 +119,7 @@ static int nss_gid_to_name(gid_t gid, char *domain, char *name, size_t len)
 	struct group *gr = NULL;
 	struct group grbuf;
 	char *buf;
-	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	size_t buflen = get_grnam_buflen();
 	int err;
 
 	if (domain == NULL)
@@ -192,7 +192,7 @@ static struct passwd *nss_getpwnam(const char *name, const char *domain,
 {
 	struct passwd *pw;
 	struct pwbuf *buf;
-	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	size_t buflen = get_pwnam_buflen();
 	char *localname;
 	int err = ENOMEM;
 
@@ -301,7 +301,7 @@ static int _nss_name_to_gid(char *name, gid_t *gid, int dostrip)
 	struct group *gr = NULL;
 	struct group grbuf;
 	char *buf, *domain;
-	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	size_t buflen = get_grnam_buflen();
 	int err = -EINVAL;
 	char *localname = NULL;
 	char *ref_name = NULL;
diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
index 8424179f..ea094b95 100644
--- a/support/nfsidmap/regex.c
+++ b/support/nfsidmap/regex.c
@@ -46,6 +46,7 @@
 
 #include "nfsidmap.h"
 #include "nfsidmap_plugin.h"
+#include "nfsidmap_private.h"
 
 #define CONFIG_GET_STRING nfsidmap_config_get
 extern const char *nfsidmap_config_get(const char *, const char *);
@@ -95,7 +96,7 @@ static struct passwd *regex_getpwnam(const char *name, const char *UNUSED(domain
 {
 	struct passwd *pw;
 	struct pwbuf *buf;
-	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	size_t buflen = get_pwnam_buflen();
 	char *localname;
 	size_t namelen;
 	int err;
@@ -175,7 +176,7 @@ static struct group *regex_getgrnam(const char *name, const char *UNUSED(domain)
 {
 	struct group *gr;
 	struct grbuf *buf;
-	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	size_t buflen = get_grnam_buflen();
 	char *localgroup;
 	char *groupname;
 	size_t namelen;
@@ -366,7 +367,7 @@ static int regex_uid_to_name(uid_t uid, char *domain, char *name, size_t len)
 	struct passwd *pw = NULL;
 	struct passwd pwbuf;
 	char *buf;
-	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	size_t buflen = get_pwnam_buflen();
 	int err = -ENOMEM;
 
 	buf = malloc(buflen);
@@ -392,7 +393,7 @@ static int regex_gid_to_name(gid_t gid, char *UNUSED(domain), char *name, size_t
 	struct group grbuf;
 	char *buf;
     const char *name_prefix;
-	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	size_t buflen = get_grnam_buflen();
 	int err;
     char * groupname = NULL;
 
diff --git a/support/nfsidmap/static.c b/support/nfsidmap/static.c
index 8ac4a398..395cac06 100644
--- a/support/nfsidmap/static.c
+++ b/support/nfsidmap/static.c
@@ -44,6 +44,7 @@
 #include "conffile.h"
 #include "nfsidmap.h"
 #include "nfsidmap_plugin.h"
+#include "nfsidmap_private.h"
 
 /*
  * Static Translation Methods
@@ -98,7 +99,7 @@ static struct passwd *static_getpwnam(const char *name,
 {
 	struct passwd *pw;
 	struct pwbuf *buf;
-	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	size_t buflen = get_pwnam_buflen();
 	char *localname;
 	int err;
 
@@ -149,7 +150,7 @@ static struct group *static_getgrnam(const char *name,
 {
 	struct group *gr;
 	struct grbuf *buf;
-	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	size_t buflen = get_grnam_buflen();
 	char *localgroup;
 	int err;
 
-- 
2.44.1


