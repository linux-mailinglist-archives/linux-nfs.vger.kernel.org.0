Return-Path: <linux-nfs+bounces-2591-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC228946C9
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 23:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C939DB2350A
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 21:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D2535B7;
	Mon,  1 Apr 2024 21:54:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8379C53E35
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008469; cv=none; b=q8aYoo4YPGt8H4gzQSgpGfHDw8ZBWCjTDthLFA97pA3v9gBzjGDSt2bFrsNZr72wVX2lzDF5X0KU0HhI2OfZ1zKPqZeZn963fWj3E5As78lAjiZ9DA6kwTAbgO5VxgPnVzATnpR8v6nZRs3Vv8QVlyVv9lRqaHND/kHFOu7ROHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008469; c=relaxed/simple;
	bh=hETYXcTE89ubuaNW4NILM/poNOMUFKjmFiyco46f/yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLifrmVvwky2/sO7O1SLIwarDLSus52yIX0okQfFV7jNiFMTV+Gdj1+Bnq+si5pvbZO986cwf3y4482FRGbjSzu5ewTBzaap5i4h+JcEzVEg8STz4QHxFFYxqaWXZJD/Rm9n0w2g4SCJWqHL0tmNAW/+vhGEpxiyaDXZRTb3684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=usask.ca; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=usask.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c8b777ff8bso149890139f.0
        for <linux-nfs@vger.kernel.org>; Mon, 01 Apr 2024 14:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008466; x=1712613266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7CzgP1bLkiOLwyLhv3LwtCJ1+QPQAdktwkQTwvhFeE=;
        b=Pcg1UYgX+PPM4QWxT4NHYQ1Zsm4/Q4g2xPerFdF38kvvrEZqWSO8a9qCvxtrJCThvo
         hAje2uR7E1eNkgktacRc3lTh9SES2IahHGFoU4IYPHB035hSsYbrz/HOwIAe3Kp5YKKJ
         DEBd44nbU4nLwLDBxBXzk61OfzyyyT5mFFz3/khtSmgYGXDIOtnGcTQfwdszjUHTuOwo
         nWB5i1mb3mYWrn6Fj2IzqyBj+S9o4DlFa29SVlASfnICGmZdY0zpL7V10HgwxrM4ZYYx
         1GBmf70iTY7doAwxw9t2zl+NnvslDONLaa/+Jc5cCChNTDIAyE4VAo0h6tW2FrVe/8LE
         HDHw==
X-Gm-Message-State: AOJu0Yyplu0H++fBXDRluvBs7Fm7y7spEPMXra4ZL+5s6BGLX8svmZUy
	gfV6hxqTOuJatwgmEor4rJXCC+gdG2so7aTwX6uNuXWLuAf9NXMF/kS8R5NHla8=
X-Google-Smtp-Source: AGHT+IE4DiEYajZDKmYT/rsDfkLNZgS8N4IrGaEXCtxYXIp+IvTNUs7nQJSOFjG2pOxUDn9MaxnNkw==
X-Received: by 2002:a6b:4e18:0:b0:7d0:86da:8511 with SMTP id c24-20020a6b4e18000000b007d086da8511mr11796492iob.14.1712008466352;
        Mon, 01 Apr 2024 14:54:26 -0700 (PDT)
Received: from nebuchadnezzar.home.arpa ([204.83.204.143])
        by smtp.gmail.com with ESMTPSA id v12-20020a056638358c00b0047682d75c04sm2835964jal.96.2024.04.01.14.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:54:26 -0700 (PDT)
From: Dan McGregor <dan.mcgregor@usask.ca>
To: linux-nfs@vger.kernel.org
Cc: Dan McGregor <dan.mcgregor@usask.ca>
Subject: [PATCH] gssd: use printf format specifiers in printerr
Date: Mon,  1 Apr 2024 15:54:13 -0600
Message-ID: <20240401215413.1188898-1-dan.mcgregor@usask.ca>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The printerr function takes a printf format specifier, tell the compiler
about that. This adds the ability for GCC to warn about misuses, and
prevents Clang from warning on the implementation.

Signed-off-by: Dan McGregor <dan.mcgregor@usask.ca>
---
 utils/gssd/err_util.h     |  2 +-
 utils/gssd/gss_names.c    |  4 ++--
 utils/gssd/gss_util.c     |  2 +-
 utils/gssd/gssd.c         |  4 ++--
 utils/gssd/gssd_proc.c    |  8 ++++----
 utils/gssd/krb5_util.c    | 10 +++++-----
 utils/gssd/svcgssd_proc.c |  8 ++++----
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/utils/gssd/err_util.h b/utils/gssd/err_util.h
index 6fa9d3d7..61f5a31f 100644
--- a/utils/gssd/err_util.h
+++ b/utils/gssd/err_util.h
@@ -32,7 +32,7 @@
 #define _ERR_UTIL_H_
 
 void initerr(char *progname, int verbosity, int fg);
-void printerr(int priority, char *format, ...);
+void printerr(int priority, char *format, ...) __attribute__ ((format (printf, 2, 3)));
 int get_verbosity(void);
 char * sec2time(int);
 
diff --git a/utils/gssd/gss_names.c b/utils/gssd/gss_names.c
index 982b96f4..0548c33f 100644
--- a/utils/gssd/gss_names.c
+++ b/utils/gssd/gss_names.c
@@ -65,7 +65,7 @@ get_krb5_hostbased_name(gss_buffer_desc *name, char **hostbased_name)
 	if (strchr(name->value, '@') && strchr(name->value, '/')) {
 		if ((sname = calloc(name->length, 1)) == NULL) {
 			printerr(0, "ERROR: get_krb5_hostbased_name failed "
-				 "to allocate %d bytes\n", name->length);
+				 "to allocate %zd bytes\n", name->length);
 			return -1;
 		}
 		/* read in name and instance and replace '/' with '@' */
@@ -102,7 +102,7 @@ get_hostbased_client_name(gss_name_t client_name, gss_OID mech,
 	}
 	if (name.length >= 0xffff) {	    /* don't overflow */
 		printerr(0, "ERROR: get_hostbased_client_name: "
-			 "received gss_name is too long (%d bytes)\n",
+			 "received gss_name is too long (%zd bytes)\n",
 			 name.length);
 		goto out_rel_buf;
 	}
diff --git a/utils/gssd/gss_util.c b/utils/gssd/gss_util.c
index a4b27779..7d41a94d 100644
--- a/utils/gssd/gss_util.c
+++ b/utils/gssd/gss_util.c
@@ -304,7 +304,7 @@ gssd_acquire_cred(char *server_name, const gss_OID oid)
 				target_name, &pbuf, NULL);
 		if (ignore_maj_stat == GSS_S_COMPLETE) {
 			printerr(1, "Unable to obtain credentials for '%.*s'\n",
-				 pbuf.length, pbuf.value);
+				 (int)pbuf.length, (char *)pbuf.value);
 			ignore_maj_stat = gss_release_buffer(&ignore_min_stat,
 							     &pbuf);
 		}
diff --git a/utils/gssd/gssd.c b/utils/gssd/gssd.c
index 10c731ab..d7a28225 100644
--- a/utils/gssd/gssd.c
+++ b/utils/gssd/gssd.c
@@ -559,9 +559,9 @@ scan_active_thread_list(void)
 					do_error_downcall(info->fd, info->uid, -ETIMEDOUT);
 				} else {
 					if (!(info->flags & UPCALL_THREAD_WARNED)) {
-						printerr(0, "watchdog: thread id 0x%lx running for %ld seconds\n",
+						printerr(0, "watchdog: thread id 0x%lx running for %lld seconds\n",
 								info->tid,
-								now.tv_sec - info->timeout.tv_sec + upcall_timeout);
+								(long long int)(now.tv_sec - info->timeout.tv_sec + upcall_timeout));
 						info->flags |= UPCALL_THREAD_WARNED;
 					}
 				}
diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index 7629de0b..2ad84c59 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -171,7 +171,7 @@ do_downcall(int k5_fd, uid_t uid, struct authgss_private_data *pd,
 
 	if (get_verbosity() > 1)
 		printerr(2, "do_downcall(0x%lx): lifetime_rec=%s acceptor=%.*s\n",
-			tid, sec2time(lifetime_rec), acceptor->length, acceptor->value);
+			tid, sec2time(lifetime_rec), (int)acceptor->length, (char *)acceptor->value);
 	buf_size = sizeof(uid) + sizeof(timeout) + sizeof(pd->pd_seq_win) +
 		sizeof(pd->pd_ctx_hndl.length) + pd->pd_ctx_hndl.length +
 		sizeof(context_token->length) + context_token->length +
@@ -287,14 +287,14 @@ populate_port(struct sockaddr *sa, const socklen_t salen,
 
 	port = nfs_getport(sa, salen, program, version, protocol);
 	if (!port) {
-		printerr(0, "ERROR: unable to obtain port for prog %ld "
-			    "vers %ld\n", program, version);
+		printerr(0, "ERROR: unable to obtain port for prog %lu "
+			    "vers %lu\n", (long unsigned int)program, (long unsigned int)version);
 		return 0;
 	}
 
 set_port:
 	printerr(2, "DEBUG: setting port to %hu for prog %lu vers %lu\n", port,
-		 program, version);
+		 (long unsigned int)program, (long unsigned int)version);
 
 	switch (sa->sa_family) {
 	case AF_INET:
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 57b3cf8a..d7116d93 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -307,9 +307,9 @@ gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
 				score++;
 
 			printerr(3, "CC '%s'(%s@%s) passed all checks and"
-				    " has mtime of %u\n",
+				    " has mtime of %llu\n",
 				 buf, princname, realm, 
-				 tmp_stat.st_mtime);
+				 (long long unsigned)tmp_stat.st_mtime);
 			/*
 			 * if more than one match is found, return the most
 			 * recent (the one with the latest mtime), and
@@ -344,10 +344,10 @@ gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
 				}
 				printerr(3, "CC '%s:%s/%s' is our "
 					    "current best match "
-					    "with mtime of %u\n",
-					 cctype, dirname,
+					    "with mtime of %llu\n",
+					 *cctype, dirname,
 					 best_match_dir->d_name,
-					 best_match_stat.st_mtime);
+					 (long long unsigned)best_match_stat.st_mtime);
 			}
 			free(princname);
 			free(realm);
diff --git a/utils/gssd/svcgssd_proc.c b/utils/gssd/svcgssd_proc.c
index b4031432..7fecd1aa 100644
--- a/utils/gssd/svcgssd_proc.c
+++ b/utils/gssd/svcgssd_proc.c
@@ -102,10 +102,10 @@ do_svc_downcall(gss_buffer_desc *out_handle, struct svc_cred *cred,
 	qword_addint(&bp, &blen, cred->cr_uid);
 	qword_addint(&bp, &blen, cred->cr_gid);
 	qword_addint(&bp, &blen, cred->cr_ngroups);
-	printerr(2, "mech: %s, hndl len: %d, ctx len %d, timeout: %d (%d from now), "
+	printerr(2, "mech: %s, hndl len: %zd, ctx len %zd, timeout: %lld (%lld from now), "
 		 "clnt: %s, uid: %d, gid: %d, num aux grps: %d:\n",
 		 fname, out_handle->length, context_token->length,
-		 endtime, endtime - time(0),
+		 (long long int)endtime, (long long int)(endtime - time(0)),
 		 client_name ? client_name : "<null>",
 		 cred->cr_uid, cred->cr_gid, cred->cr_ngroups);
 	for (i=0; i < cred->cr_ngroups; i++) {
@@ -232,7 +232,7 @@ get_ids(gss_name_t client_name, gss_OID mech, struct svc_cred *cred)
 	}
 	if (name.length >= 0xffff || /* be certain name.length+1 doesn't overflow */
 	    !(sname = calloc(name.length + 1, 1))) {
-		printerr(0, "WARNING: get_ids: error allocating %d bytes "
+		printerr(0, "WARNING: get_ids: error allocating %zd bytes "
 			"for sname\n", name.length + 1);
 		gss_release_buffer(&min_stat, &name);
 		goto out;
@@ -360,7 +360,7 @@ handle_nullreq(char *cp) {
 	if (in_handle.length != 0) { /* CONTINUE_INIT case */
 		if (in_handle.length != sizeof(ctx)) {
 			printerr(0, "WARNING: handle_nullreq: "
-				    "input handle has unexpected length %d\n",
+				    "input handle has unexpected length %zd\n",
 				    in_handle.length);
 			goto out_err;
 		}
-- 
2.41.0


