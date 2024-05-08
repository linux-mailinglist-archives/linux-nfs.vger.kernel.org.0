Return-Path: <linux-nfs+bounces-3196-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34398BF584
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 07:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CA9281F88
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2024 05:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB9C15E90;
	Wed,  8 May 2024 05:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jnt.io header.i=@jnt.io header.b="wkba2hlV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF017BAE
	for <linux-nfs@vger.kernel.org>; Wed,  8 May 2024 05:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715145020; cv=none; b=CkFXh3n0WhOqz2TNN08DOxmB5ceonQbxpnrWmZF/uybAfmPU5BhFqQoxdCa8SgdiZv/9NPAEmMCb+InWDFls3qmTGxpsjrNQFm5U6ssVmurcdavFjj/vo1bhOimbbYcoHzUyxeekzrQ3jz3/RGEzdkSgiICnGAvmjGnPGwBe/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715145020; c=relaxed/simple;
	bh=jkvO9Gs4Pgs7yE4YTwZa0KrFQnZG/VJTpu5E5+V4M8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ls/11MTtrB/ALq7Ne/+eqZGwvIMTJ9I2EhbPxDFz/+/ZnLRQyj7fKehZTNedajB+fFKo1o0kqfpxUmT/Qm/CxUdqcAWB8kkdBKhuQEPUpXjwbV0qUp3fzTkoDJ6771/2jfeaDiC083vBhfzG7txPtCQJmDY7nu5ZbrR2kF9Vd20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jnt.io; spf=pass smtp.mailfrom=jnt.io; dkim=pass (2048-bit key) header.d=jnt.io header.i=@jnt.io header.b=wkba2hlV; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jnt.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jnt.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jnt.io; s=key1;
	t=1715145015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6xquYbe5a4rAMfH1um2vEVjfw+RX7sf5hVLDcDAG5Kw=;
	b=wkba2hlV2MV4DevW6AKzCFOSMZU32Gnxjr7W/PONI51sL7raK77hOfLKKNHkM99AciI2K9
	QXyTTvN7UW9rMvlg4wytX6c6J0oiAC2FHPXOHbUgtLZtwyHFflSyE5nNNovdLSNBm15CCz
	++Dr+riHfqxSgs5mDqwdp6Snx238TfmiMz9dhN04W4FTTQqaaEIdBHQEMjsNYe9dLYPN6Q
	fS/crBlcnH6jh9cellfBjLzNq8eHOa69vnufKxWsYZonJcyK0uangY7yhzkdbdxhtkHCbf
	JgFdt0X2BqccWLXvbJ4jggxViIg0l2IBERA6yXiEPo2a+WQU6M4rkzQRLpWHyg==
From: Jan Tatje <jan@jnt.io>
To: linux-nfs@vger.kernel.org
Cc: Jan Tatje <jan@jnt.io>
Subject: [PATCH] nfsidmap: fallback if sysconf(_SC_GET(PW|GR)_R_SIZE_MAX) doesn't exist
Date: Wed,  8 May 2024 07:09:08 +0200
Message-ID: <20240508050908.293390-1-jan@jnt.io>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On musl-libc systems _SC_GET(PW|GR)_R_SIZE_MAX does not exist.
If sysconf returns -1 start with a sane value and call
get(pw|gr)(nam|uid)_r repeatedly until it no longer returns ERANGE.

Signed-off-by: Jan Tatje <jan@jnt.io>
---
 support/nfsidmap/gums.c        | 22 +++++++++++--
 support/nfsidmap/libnfsidmap.c | 29 +++++++++++++++--
 support/nfsidmap/nss.c         | 59 +++++++++++++++++++++++++++-------
 support/nfsidmap/regex.c       | 54 +++++++++++++++++++++++++++----
 support/nfsidmap/static.c      | 22 +++++++++++--
 5 files changed, 159 insertions(+), 27 deletions(-)

diff --git a/support/nfsidmap/gums.c b/support/nfsidmap/gums.c
index 1d6eb318..caffc679 100644
--- a/support/nfsidmap/gums.c
+++ b/support/nfsidmap/gums.c
@@ -475,13 +475,25 @@ static int translate_to_uid(char *local_uid, uid_t *uid, uid_t *gid)
 	int ret = -1;
 	struct passwd *pw = NULL;
 	struct pwbuf *buf = NULL;
-	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	long scbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	size_t buflen = 1024;
+
+	if (scbuflen > 0)
+		buflen = (size_t)scbuflen;
 
 	buf = malloc(sizeof(*buf) + buflen);
 	if (buf == NULL)
 		goto out;
 
-	ret = getpwnam_r(local_uid, &buf->pwbuf, buf->buf, buflen, &pw);
+	while ((ret = getpwnam_r(local_uid, &buf->pwbuf, buf->buf, buflen, &pw)) == ERANGE) {
+		buflen = buflen * 2;
+		struct pwbuf *nbuf = realloc(buf, sizeof(*buf) + buflen);
+		if (nbuf == NULL) {
+			ret = ENOMEM;
+			goto out;
+		}
+		buf = nbuf;
+	}
 	if (pw == NULL) {
 		IDMAP_LOG(0, ("getpwnam: name %s not found\n", local_uid));
 		goto out;
@@ -501,9 +513,13 @@ static int translate_to_gid(char *local_gid, uid_t *gid)
 	struct group *gr = NULL;
 	struct group grbuf;
 	char *buf = NULL;
-	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	long scbuflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	size_t buflen = 1024;
 	int ret = -1;
 
+	if (scbuflen > 0)
+		buflen = (size_t)scbuflen;
+
 	do {
 		buf = malloc(buflen);
 		if (buf == NULL)
diff --git a/support/nfsidmap/libnfsidmap.c b/support/nfsidmap/libnfsidmap.c
index f8c36480..14cafc3d 100644
--- a/support/nfsidmap/libnfsidmap.c
+++ b/support/nfsidmap/libnfsidmap.c
@@ -457,14 +457,26 @@ int nfs4_init_name_mapping(char *conffile)
 
 	nobody_user = conf_get_str("Mapping", "Nobody-User");
 	if (nobody_user) {
-		size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+		long scbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+		size_t buflen = 1024;
 		struct passwd *buf;
 		struct passwd *pw = NULL;
 		int err;
 
+		if (scbuflen > 0)
+			buflen = (size_t)scbuflen;
+
 		buf = malloc(sizeof(*buf) + buflen);
 		if (buf) {
 			err = getpwnam_r(nobody_user, buf, ((char *)buf) + sizeof(*buf), buflen, &pw);
+			while ((err = getpwnam_r(nobody_user, buf, ((char *)buf) + sizeof(*buf), buflen, &pw)) == ERANGE) {
+				buflen = buflen * 2;
+				struct passwd* nbuf = realloc(buf, sizeof(*buf) + buflen);
+				if (nbuf == NULL) {
+					break;
+				}
+				buf = nbuf;
+			}
 			if (err == 0 && pw != NULL)
 				nobody_uid = pw->pw_uid;
 			else
@@ -478,14 +490,25 @@ int nfs4_init_name_mapping(char *conffile)
 
 	nobody_group = conf_get_str("Mapping", "Nobody-Group");
 	if (nobody_group) {
-		size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+		long scbuflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+		size_t buflen = 1024;
 		struct group *buf;
 		struct group *gr = NULL;
 		int err;
 
+		if (scbuflen > 0)
+			buflen = (size_t)scbuflen;
+
 		buf = malloc(sizeof(*buf) + buflen);
 		if (buf) {
-			err = getgrnam_r(nobody_group, buf, ((char *)buf) + sizeof(*buf), buflen, &gr);
+			while ((err = getgrnam_r(nobody_group, buf, ((char *)buf) + sizeof(*buf), buflen, &gr)) == ERANGE) {
+				buflen = buflen * 2;
+				struct group *nbuf = realloc(buf, sizeof(*buf) + buflen);
+				if (nbuf == NULL) {
+					break;
+				}
+				buf = nbuf;
+			}
 			if (err == 0 && gr != NULL)
 				nobody_gid = gr->gr_gid;
 			else
diff --git a/support/nfsidmap/nss.c b/support/nfsidmap/nss.c
index 0f43076e..ec4e9fdd 100644
--- a/support/nfsidmap/nss.c
+++ b/support/nfsidmap/nss.c
@@ -91,15 +91,27 @@ static int nss_uid_to_name(uid_t uid, char *domain, char *name, size_t len)
 	struct passwd *pw = NULL;
 	struct passwd pwbuf;
 	char *buf;
-	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	size_t buflen = 1024; /*sysconf(_SC_GETPW_R_SIZE_MAX) == 1024 on glibc*/
+	long scbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
 	int err = -ENOMEM;
 
+	if (scbuflen > 0) {
+		buflen = (size_t)scbuflen;
+	}
+
 	buf = malloc(buflen);
 	if (!buf)
 		goto out;
 	if (domain == NULL)
 		domain = get_default_domain();
-	err = -getpwuid_r(uid, &pwbuf, buf, buflen, &pw);
+	while ((err = -getpwuid_r(uid, &pwbuf, buf, buflen, &pw)) == -ERANGE) {
+		buflen = buflen * 2;
+		char* nbuf = realloc(buf, buflen);
+		if (nbuf == NULL) {
+			goto out_buf;
+		}
+		buf = nbuf;
+	}
 	if (pw == NULL)
 		err = -ENOENT;
 	if (err)
@@ -119,9 +131,14 @@ static int nss_gid_to_name(gid_t gid, char *domain, char *name, size_t len)
 	struct group *gr = NULL;
 	struct group grbuf;
 	char *buf;
-	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	size_t buflen = 1024;
+	long scbuflen = sysconf(_SC_GETGR_R_SIZE_MAX);
 	int err;
 
+	if (scbuflen > 0) {
+		buflen = (size_t)scbuflen;
+	}
+
 	if (domain == NULL)
 		domain = get_default_domain();
 
@@ -192,12 +209,14 @@ static struct passwd *nss_getpwnam(const char *name, const char *domain,
 {
 	struct passwd *pw;
 	struct pwbuf *buf;
-	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	size_t buflen = 1024;
+	long scbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
 	char *localname;
 	int err = ENOMEM;
 
-	if (buflen > UINT_MAX)
-		goto err;
+	if (scbuflen > 0) {
+		buflen = (size_t)scbuflen;
+	}
 
 	buf = malloc(sizeof(*buf) + buflen);
 	if (buf == NULL)
@@ -215,14 +234,29 @@ static struct passwd *nss_getpwnam(const char *name, const char *domain,
 			goto err_free_buf;
 		}
 
-		err = getpwnam_r(localname, &buf->pwbuf, buf->buf, buflen, &pw);
+		while ((err = getpwnam_r(localname, &buf->pwbuf, buf->buf, buflen, &pw)) == ERANGE) {
+			buflen = buflen * 2;
+			struct pwbuf *nbuf = realloc(buf, sizeof(*buf) + buflen);
+			if (nbuf == NULL) {
+				free(localname);
+				goto err_free_buf;
+			}
+			buf = nbuf;
+		}
 		if (pw == NULL && domain != NULL)
 			IDMAP_LOG(1,
 				("nss_getpwnam: name '%s' not found in domain '%s'",
 				localname, domain));
 		free(localname);
 	} else {
-		err = getpwnam_r(name, &buf->pwbuf, buf->buf, buflen, &pw);
+		while ((err = getpwnam_r(name, &buf->pwbuf, buf->buf, buflen, &pw)) == ERANGE) {
+			buflen = buflen * 2;
+			struct pwbuf *nbuf = realloc(buf, sizeof(*buf) + buflen);
+			if (nbuf == NULL) {
+				goto err_free_buf;
+			}
+			buf = nbuf;
+		}
 		if (pw == NULL)
 			IDMAP_LOG(1,
 				("nss_getpwnam: name '%s' not found (domain not stripped)", name));
@@ -301,11 +335,16 @@ static int _nss_name_to_gid(char *name, gid_t *gid, int dostrip)
 	struct group *gr = NULL;
 	struct group grbuf;
 	char *buf, *domain;
-	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	size_t buflen = 1024;
+	long scbuflen = sysconf(_SC_GETGR_R_SIZE_MAX);
 	int err = -EINVAL;
 	char *localname = NULL;
 	char *ref_name = NULL;
 
+	if (scbuflen > 0) {
+		buflen = (size_t)scbuflen;
+	}
+
 	domain = get_default_domain();
 	if (dostrip) {
 		localname = strip_domain(name, domain);
@@ -327,8 +366,6 @@ static int _nss_name_to_gid(char *name, gid_t *gid, int dostrip)
 	}
 
 	err = -ENOMEM;
-	if (buflen > UINT_MAX)
-		goto out_name;
 
 	do {
 		buf = malloc(buflen);
diff --git a/support/nfsidmap/regex.c b/support/nfsidmap/regex.c
index 8424179f..fa316660 100644
--- a/support/nfsidmap/regex.c
+++ b/support/nfsidmap/regex.c
@@ -95,7 +95,8 @@ static struct passwd *regex_getpwnam(const char *name, const char *UNUSED(domain
 {
 	struct passwd *pw;
 	struct pwbuf *buf;
-	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	long scbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	size_t buflen = 1024;
 	char *localname;
 	size_t namelen;
 	int err;
@@ -103,6 +104,9 @@ static struct passwd *regex_getpwnam(const char *name, const char *UNUSED(domain
 	int index;
 	regmatch_t matches[MAX_MATCHES];
 
+	if (scbuflen > 0)
+		buflen = (size_t)scbuflen;
+
 	buf = malloc(sizeof(*buf) + buflen);
 	if (!buf) {
 		err = ENOMEM;
@@ -139,7 +143,15 @@ static struct passwd *regex_getpwnam(const char *name, const char *UNUSED(domain
 	localname[namelen] = '\0';
 
 again:
-	err = getpwnam_r(localname, &buf->pwbuf, buf->buf, buflen, &pw);
+	while ((err = getpwnam_r(localname, &buf->pwbuf, buf->buf, buflen, &pw)) == ERANGE) {
+		buflen = buflen * 2;
+		struct pwbuf *nbuf = realloc(buf, sizeof(*buf) + buflen);
+		if (nbuf == NULL) {
+			err = ENOMEM;
+			goto err_free_name;
+		}
+		buf = nbuf;
+	}
 
 	if (err == EINTR)
 		goto again;
@@ -175,7 +187,8 @@ static struct group *regex_getgrnam(const char *name, const char *UNUSED(domain)
 {
 	struct group *gr;
 	struct grbuf *buf;
-	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	long scbuflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	size_t buflen = 1024;
 	char *localgroup;
 	char *groupname;
 	size_t namelen;
@@ -184,6 +197,9 @@ static struct group *regex_getgrnam(const char *name, const char *UNUSED(domain)
 	int status;
 	regmatch_t matches[MAX_MATCHES];
 
+	if (scbuflen > 0)
+		buflen = (size_t)scbuflen;
+
 	buf = malloc(sizeof(*buf) + buflen);
 	if (!buf) {
 		err = ENOMEM;
@@ -242,7 +258,15 @@ static struct group *regex_getgrnam(const char *name, const char *UNUSED(domain)
 	IDMAP_LOG(4, ("regexp_getgrnam: will use '%s'", groupname));
 
 again:
-	err = getgrnam_r(groupname, &buf->grbuf, buf->buf, buflen, &gr);
+	while ((err = getgrnam_r(groupname, &buf->grbuf, buf->buf, buflen, &gr)) == ERANGE) {
+		buflen = buflen * 2;
+		struct grbuf *nbuf = realloc(buf, sizeof(*buf) + buflen);
+		if (nbuf == NULL) {
+			err = ENOMEM;
+			goto err_free_name;
+		}
+		buf = nbuf;
+	}
 
 	if (err == EINTR)
 		goto again;
@@ -366,15 +390,27 @@ static int regex_uid_to_name(uid_t uid, char *domain, char *name, size_t len)
 	struct passwd *pw = NULL;
 	struct passwd pwbuf;
 	char *buf;
-	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	long scbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	size_t buflen = 1024;
 	int err = -ENOMEM;
 
+	if (scbuflen > 0)
+		buflen = (size_t)scbuflen;
+
 	buf = malloc(buflen);
 	if (!buf)
 		goto out;
 	if (domain == NULL)
 		domain = get_default_domain();
-	err = -getpwuid_r(uid, &pwbuf, buf, buflen, &pw);
+	while ((err = -getpwuid_r(uid, &pwbuf, buf, buflen, &pw)) == -ERANGE) {
+		buflen = buflen * 2;
+		char *nbuf = realloc(buf, buflen);
+		if (nbuf == NULL) {
+			err = -ENOMEM;
+			goto out_buf;
+		}
+		buf = nbuf;
+	}
 	if (pw == NULL)
 		err = -ENOENT;
 	if (err)
@@ -392,10 +428,14 @@ static int regex_gid_to_name(gid_t gid, char *UNUSED(domain), char *name, size_t
 	struct group grbuf;
 	char *buf;
     const char *name_prefix;
-	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	long scbuflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	size_t buflen = 1024;
 	int err;
     char * groupname = NULL;
 
+	if (scbuflen > 0)
+		buflen = (size_t)scbuflen;
+
 	do {
 		err = -ENOMEM;
 		buf = malloc(buflen);
diff --git a/support/nfsidmap/static.c b/support/nfsidmap/static.c
index 8ac4a398..0bb1728d 100644
--- a/support/nfsidmap/static.c
+++ b/support/nfsidmap/static.c
@@ -98,10 +98,14 @@ static struct passwd *static_getpwnam(const char *name,
 {
 	struct passwd *pw;
 	struct pwbuf *buf;
-	size_t buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	long scbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	size_t buflen = 1024;
 	char *localname;
 	int err;
 
+	if (scbuflen > 0)
+		buflen = (size_t)scbuflen;
+
 	buf = malloc(sizeof(*buf) + buflen);
 	if (!buf) {
 		err = ENOMEM;
@@ -149,10 +153,14 @@ static struct group *static_getgrnam(const char *name,
 {
 	struct group *gr;
 	struct grbuf *buf;
-	size_t buflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	long scbuflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	size_t buflen = 1024;
 	char *localgroup;
 	int err;
 
+	if (scbuflen > 0)
+		buflen = (size_t)scbuflen;
+
 	buf = malloc(sizeof(*buf) + buflen);
 	if (!buf) {
 		err = ENOMEM;
@@ -166,7 +174,15 @@ static struct group *static_getgrnam(const char *name,
 	}
 
 again:
-	err = getgrnam_r(localgroup, &buf->grbuf, buf->buf, buflen, &gr);
+	while ((err = getgrnam_r(localgroup, &buf->grbuf, buf->buf, buflen, &gr)) == ERANGE) {
+		buflen = buflen * 2;
+		struct grbuf *nbuf = realloc(buf, sizeof(*buf) + buflen);
+		if (nbuf == NULL) {
+			err = ENOMEM;
+			goto err_free_buf;
+		}
+		buf = nbuf;
+	}
 
 	if (err == EINTR)
 		goto again;
-- 
2.45.0


