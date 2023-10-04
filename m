Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C117B86A0
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 19:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbjJDRcv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 13:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243498AbjJDRcu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 13:32:50 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2950A9
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 10:32:45 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35264dff796so136885ab.0
        for <linux-nfs@vger.kernel.org>; Wed, 04 Oct 2023 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696440765; x=1697045565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vtD2wllK/RrJHf1gxhgLPe7cHGISOLeuFKmzdk1jsI=;
        b=GPOeQARu/5CgaEuCHDGme+X9MN0xXwusofyUjupHdbvIZXf2oUVGVaA7hzCLK5AtVx
         sdzb7PAN6qeWtgH+8ds5cHxBsvdtJDjSRP5+cPIyPpu6Xo3VofFHHS4raJlj9kziCeLr
         G2e8qRTcD2X5FeLziRXfpO7FjIGZqWpTyV4p392HHQFlRA6cxOrV5oQtYI3f7jwPqp/b
         AEP3HCbk1rCtPrbut5NjO0ZbGgTFJjP7QaxzgdIkFNILix8zK7A5m0JBnclng0mtFHZm
         Hig5xV/WiGfEl8kZKWQjZmODPSLFgGM9SqNA84yW4AYB34pIyM6yzgTf+PVGNWGZdaXl
         HpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440765; x=1697045565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vtD2wllK/RrJHf1gxhgLPe7cHGISOLeuFKmzdk1jsI=;
        b=beyXW70flMRLdEkypaEJ0HLcXwWUzy4WerCsdxQ+Of3zzyjK45K0agXWWD0cY5/s5E
         Pc+t9f/tzXPa+iMfLMeBMmHfEhphkrFXnRGAn53/RroHld39wPk4HcMRIQwoxg28gxtn
         sidqVL/4YbrnPbxkky4rsARTzFIx0IYpQsYdNxtJ1v/a0FBfl48IshlfFk95GiVOjHrn
         iIIYUaahFdAKX1LCyrboDCK61KM5U1HNw20RF1bVLWSE7En9ZPSuZje9Q2sGIFF7Arut
         0DYUGuRpLemG2XN/AtXqHigCeZ6a4Ab7mBITUAvTjZipdrEROa4i/eeYgXx4sRbo4o2n
         KGxA==
X-Gm-Message-State: AOJu0YyKurBmK4jBUrynijiwLf81UvuvU+Uhh18I4bK0MyziQt9oZ3Q8
        /WeZa5qShMulVMyCfcfSd2LhRu1dZrI=
X-Google-Smtp-Source: AGHT+IHyVE34PTrKSzvE6KZQMrN7H3m4/bjIP6EanDB+ihsyk9C2koyFKEPIau8trGapZvzeWxvoOQ==
X-Received: by 2002:a05:6602:2e03:b0:792:6068:dcc8 with SMTP id o3-20020a0566022e0300b007926068dcc8mr3851138iow.2.1696440764919;
        Wed, 04 Oct 2023 10:32:44 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:d99c:94dd:ccd6:fb22])
        by smtp.gmail.com with ESMTPSA id u23-20020a6be417000000b007870289f4fdsm1066598iog.51.2023.10.04.10.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 10:32:44 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] nfs-utils: gssd: enable forcing cred renewal using the keytab
Date:   Wed,  4 Oct 2023 13:32:37 -0400
Message-Id: <20231004173240.46924-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20231004173240.46924-1-olga.kornievskaia@gmail.com>
References: <20231004173240.46924-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a new function parameter "force_renewal" that callers could
set to force service ticket renewal even if one exists already.

This is needed in preparation for handling
KRB5_AP_ERR_BAD_INTEGRITY when service's keytab changes while
the client holds valid service ticket in the cache.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 utils/gssd/gssd_proc.c |  2 +-
 utils/gssd/krb5_util.c | 20 ++++++++++++--------
 utils/gssd/krb5_util.h |  3 ++-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index ae568f15..4fb6b72d 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -571,7 +571,7 @@ krb5_use_machine_creds(struct clnt_info *clp, uid_t uid,
 
 	do {
 		gssd_refresh_krb5_machine_credential(clp->servername,
-						     service, srchost);
+						     service, srchost, 0);
 	/*
 	 * Get a list of credential cache names and try each
 	 * of them until one works or we've tried them all
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index e3f270e9..f6ce1fec 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -165,7 +165,7 @@ static int select_krb5_ccache(const struct dirent *d);
 static int gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
 		const char **cctype, struct dirent **d);
 static int gssd_get_single_krb5_cred(krb5_context context,
-		krb5_keytab kt, struct gssd_k5_kt_princ *ple);
+		krb5_keytab kt, struct gssd_k5_kt_princ *ple, int force_renew);
 static int query_krb5_ccache(const char* cred_cache, char **ret_princname,
 		char **ret_realm);
 
@@ -391,7 +391,8 @@ gssd_check_if_cc_exists(struct gssd_k5_kt_princ *ple)
 static int
 gssd_get_single_krb5_cred(krb5_context context,
 			  krb5_keytab kt,
-			  struct gssd_k5_kt_princ *ple)
+			  struct gssd_k5_kt_princ *ple,
+			  int force_renew)
 {
 #ifdef HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS
 	krb5_get_init_creds_opt *init_opts = NULL;
@@ -421,7 +422,7 @@ gssd_get_single_krb5_cred(krb5_context context,
 	 */
 	now += 300;
 	pthread_mutex_lock(&ple_lock);
-	if (ple->ccname && ple->endtime > now && !nocache) {
+	if (ple->ccname && ple->endtime > now && !nocache && !force_renew) {
 		printerr(3, "%s(0x%lx): Credentials in CC '%s' are good until %s",
 			 __func__, tid, ple->ccname, ctime((time_t *)&ple->endtime));
 		code = 0;
@@ -1155,7 +1156,8 @@ err_cache:
 static int
 gssd_refresh_krb5_machine_credential_internal(char *hostname,
 				     struct gssd_k5_kt_princ *ple,
-				     char *service, char *srchost)
+				     char *service, char *srchost,
+				     int force_renew)
 {
 	krb5_error_code code = 0;
 	krb5_context context;
@@ -1221,7 +1223,7 @@ gssd_refresh_krb5_machine_credential_internal(char *hostname,
 			goto out_free_kt;
 		}
 	}
-	retval = gssd_get_single_krb5_cred(context, kt, ple);
+	retval = gssd_get_single_krb5_cred(context, kt, ple, force_renew);
 out_free_kt:
 	krb5_kt_close(context, kt);
 out_free_context:
@@ -1344,7 +1346,7 @@ gssd_get_krb5_machine_cred_list(char ***list)
 		pthread_mutex_unlock(&ple_lock);
 		/* Make sure cred is up-to-date before returning it */
 		retval = gssd_refresh_krb5_machine_credential_internal(NULL, ple,
-								       NULL, NULL);
+								       NULL, NULL, 0);
 		pthread_mutex_lock(&ple_lock);
 		if (gssd_k5_kt_princ_list == NULL) {
 			/* Looks like we did shutdown... abort */
@@ -1456,10 +1458,12 @@ gssd_destroy_krb5_principals(int destroy_machine_creds)
  */
 int
 gssd_refresh_krb5_machine_credential(char *hostname,
-				     char *service, char *srchost)
+				     char *service, char *srchost,
+				     int force_renew)
 {
     return gssd_refresh_krb5_machine_credential_internal(hostname, NULL,
-							 service, srchost);
+							 service, srchost,
+							 force_renew);
 }
 
 /*
diff --git a/utils/gssd/krb5_util.h b/utils/gssd/krb5_util.h
index 2415205a..62c91a0e 100644
--- a/utils/gssd/krb5_util.h
+++ b/utils/gssd/krb5_util.h
@@ -16,7 +16,8 @@ int  gssd_get_krb5_machine_cred_list(char ***list);
 void gssd_free_krb5_machine_cred_list(char **list);
 void gssd_destroy_krb5_principals(int destroy_machine_creds);
 int  gssd_refresh_krb5_machine_credential(char *hostname,
-					  char *service, char *srchost);
+					  char *service, char *srchost,
+					  int force_renew);
 char *gssd_k5_err_msg(krb5_context context, krb5_error_code code);
 void gssd_k5_get_default_realm(char **def_realm);
 
-- 
2.39.1

