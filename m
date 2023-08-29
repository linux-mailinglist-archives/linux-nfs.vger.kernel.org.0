Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BF878CD77
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Aug 2023 22:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbjH2UTd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 16:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjH2UTL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 16:19:11 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F31BF
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 13:19:07 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34bbc394fa0so3969715ab.1
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693340347; x=1693945147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vtD2wllK/RrJHf1gxhgLPe7cHGISOLeuFKmzdk1jsI=;
        b=L/yh/eR7Echrc2jr2p2M+CPXwWkWhU+boqc2Z4a672pN/1DLFML4Xm+lnPqayTci1L
         ISwfzQrOpOoMfaeVdMEtx3LxjnC5RRMKqyGOkU+mv6KwiM4PZNjfJCDRHOYDtKOIQIAv
         tyZbGznjj5/gmvdm5ft9SgBHTZnAnwlRFW5gnSRXxhhSMB6gJnNHBYWoI72Ud/DSzGCs
         jrb0LmFAE0EvPwjqB5U6sbJDnTjoFMjurdXFJRqpGvtx8LDXAGmyWki3znEQlbN6HbaU
         B5oq8RfHMmBKKQ2sWkhS4BsuUJg6l1Sprjmz33rXHYpYes6oZlHqXKY8FTb/DXDKYiwP
         mlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693340347; x=1693945147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vtD2wllK/RrJHf1gxhgLPe7cHGISOLeuFKmzdk1jsI=;
        b=GOhZjQZrBE0XDbBUiEWmXoyF84z92ELi2dEKeYQ3MgBWPfj4/oEubm2UQ8QxSRlxnL
         LtPSK/Pgdp7tSalp61yasiBuchb+BrjiacH0smHdXtMvlsUtEWbMNKwn1JgRbfA516gO
         zqPzWKEJwT58/GiYzXhAZu7h5EM2+KeXBIiX+B9B00/wcOehOv0GML8399SD7bWDnuPF
         YfIzs+MVRsyuLiF0KlKcAO1MoFBNrBiLxU92PowmqWGNyfK3Dow2oUueevIvucVDs2Xx
         AJv5YYGNJHUtxVrgh/4Fb7M4zWKKxFqC/Dl3NkaUJC+5rfi3HjzFfXOydBmbQ7alazI+
         LMtQ==
X-Gm-Message-State: AOJu0YxKE7uLhTCPyfe4sC6po0SuPfjbY56xU43Kp5lz4XYRL0J0r3Ru
        dLhxeO2iwIVzk9hCRmxq/kbMkt7ENrU=
X-Google-Smtp-Source: AGHT+IHPIPUHU4RyG6Wo6BtI97GEZxsT3Kd9RzUkiACRvbXNhV3n/raUbwYPve3mVV106IdrbxKj1w==
X-Received: by 2002:a6b:2ac2:0:b0:795:172f:977a with SMTP id q185-20020a6b2ac2000000b00795172f977amr342859ioq.1.1693340346932;
        Tue, 29 Aug 2023 13:19:06 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b9e5:28ab:6ad7:257e])
        by smtp.gmail.com with ESMTPSA id gk8-20020a0566386a8800b0042b2f0b77aasm3300798jab.95.2023.08.29.13.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:19:06 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] nfs-utils: gssd: enable forcing cred renewal using the keytab
Date:   Tue, 29 Aug 2023 16:19:00 -0400
Message-Id: <20230829201902.63036-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20230829201902.63036-1-olga.kornievskaia@gmail.com>
References: <20230829201902.63036-1-olga.kornievskaia@gmail.com>
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

