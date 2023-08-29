Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B2E78CD79
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Aug 2023 22:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbjH2UTe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 16:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240524AbjH2UTN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 16:19:13 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3E11BE
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 13:19:09 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-79293ebfaf2so14493239f.1
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 13:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693340349; x=1693945149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D5Kvm1BHqxw7OkRLtU/qxcvETM83IthKpPkvjPcRF4=;
        b=acn2ynI+g56d77V7Yftl82OcGzGCWtXlbBmvt1zbmA0zI1neAyxPRhYPsrEbaA3jh6
         1aHKYzGbxg+X06r2IKnfOsGbqLUwSlT2p0UI0YuX78XoASm4Cwq173/f4hzRrZRkF1Q1
         4HI8L5r1nEkL1yoxYk/fLRwigWOo3mQcSLPVTKOXtiiq+G1oWbr3fJa6Y2OCpdh5tzkJ
         VruCTXLSf1Y5iaAahrwyBHjMn4HkxdAG5Po4y+j2dvr7HIMI4918buvjNv/aoq5Xlxvg
         NIMKoc58b8GKr0+UVOOTIRAb4c7DIGPDHftOrNJsJLSAL37qj0aXZ1ZSCkzOSeBc3mJT
         Mefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693340349; x=1693945149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5D5Kvm1BHqxw7OkRLtU/qxcvETM83IthKpPkvjPcRF4=;
        b=AkfwTrNEa9bdKNBDhDf6W+oK3wvfF6gterp1PuEZ+ekSQQW3u5I4bhlIFOhcO9DzTl
         6VAheUbCdmsQ0yF788lYuil+CwMJ/rXzjgXUn0lQemlvGd5xSLWFW5MJp1hKK/9ybqKN
         0jCYpB5qM4X29FQ0lK0+eBda1Wa3kPx64TOy2Vev4uVPaIuOG8j4lWzqTGoiDyk4DqFu
         b6cRZw2tTjjsTGP0LIVOdp1qQ8H5YGmv3FGDCW4bDJRNXqnZrrCOBay+d58V17o5j8D2
         DYo3OsaRMOBpQmA8LpIlwcTW7Uw78MUf7hbFo2bnGOxN5LnS3jemFESD/orjYBj3+0de
         VTmg==
X-Gm-Message-State: AOJu0Yz30mBvZY6Dij/uWQy3S3Gi1t2oKEr+kN3HZBvp6yg470CMNlZH
        ZXtPcG0eSy58tMmXiZXpbHdEe/t+I0I=
X-Google-Smtp-Source: AGHT+IE2sS+1bLzGskB5/N1GihLbYvh7VrHxsDA5H1i0FI6stisuxH5dgK9lhhasfKZfD126QIXojw==
X-Received: by 2002:a6b:e512:0:b0:792:6be4:3dcb with SMTP id y18-20020a6be512000000b007926be43dcbmr368732ioc.2.1693340349112;
        Tue, 29 Aug 2023 13:19:09 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b9e5:28ab:6ad7:257e])
        by smtp.gmail.com with ESMTPSA id gk8-20020a0566386a8800b0042b2f0b77aasm3300798jab.95.2023.08.29.13.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:19:08 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] nfs-utils: gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for user credentials
Date:   Tue, 29 Aug 2023 16:19:02 -0400
Message-Id: <20230829201902.63036-5-olga.kornievskaia@gmail.com>
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

Unlike the machine credential case, we can't throw away the ticket
cache and use the keytab to renew the credentials. Instead, we
need to remove the service ticket for the server that returned
KRB5_AP_ERR_BAD_INTEGRITY and try again.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 utils/gssd/gssd_proc.c |  2 ++
 utils/gssd/krb5_util.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 utils/gssd/krb5_util.h |  1 +
 3 files changed, 45 insertions(+)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index e5cc1d98..a96647df 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -419,6 +419,8 @@ create_auth_rpc_client(struct clnt_info *clp,
 			if (cred == GSS_C_NO_CREDENTIAL)
 				retval = gssd_refresh_krb5_machine_credential(clp->servername,
 					"*", NULL, 1);
+			else
+				retval = gssd_k5_remove_bad_service_cred(clp->servername);
 			if (!retval) {
 				auth = authgss_create_default(rpc_clnt, tgtname,
 						&sec);
diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index f6ce1fec..6f66ef4f 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -1553,6 +1553,48 @@ gssd_acquire_user_cred(gss_cred_id_t *gss_cred)
 	return ret;
 }
 
+/* Removed a service ticket for nfs/<name> from the ticket cache
+ */
+int
+gssd_k5_remove_bad_service_cred(char *name)
+{
+        krb5_creds in_creds, out_creds;
+        krb5_error_code ret;
+        krb5_context context;
+        krb5_ccache cache;
+        krb5_principal principal;
+        int retflags = KRB5_TC_MATCH_SRV_NAMEONLY;
+        char srvname[1024];
+
+        ret = krb5_init_context(&context);
+        if (ret)
+                goto out_cred;
+        ret = krb5_cc_default(context, &cache);
+        if (ret)
+                goto out_free_context;
+        ret = krb5_cc_get_principal(context, cache, &principal);
+        if (ret)
+                goto out_close_cache;
+        memset(&in_creds, 0, sizeof(in_creds));
+        in_creds.client = principal;
+        sprintf(srvname, "nfs/%s", name);
+        ret = krb5_parse_name(context, srvname, &in_creds.server);
+        if (ret)
+                goto out_free_principal;
+        ret = krb5_cc_retrieve_cred(context, cache, retflags, &in_creds, &out_creds);
+        if (ret)
+                goto out_free_principal;
+        ret = krb5_cc_remove_cred(context, cache, 0, &out_creds);
+out_free_principal:
+        krb5_free_principal(context, principal);
+out_close_cache:
+        krb5_cc_close(context, cache);
+out_free_context:
+        krb5_free_context(context);
+out_cred:
+        return ret;
+}
+
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
 /*
  * this routine obtains a credentials handle via gss_acquire_cred()
diff --git a/utils/gssd/krb5_util.h b/utils/gssd/krb5_util.h
index 62c91a0e..7ef87018 100644
--- a/utils/gssd/krb5_util.h
+++ b/utils/gssd/krb5_util.h
@@ -22,6 +22,7 @@ char *gssd_k5_err_msg(krb5_context context, krb5_error_code code);
 void gssd_k5_get_default_realm(char **def_realm);
 
 int gssd_acquire_user_cred(gss_cred_id_t *gss_cred);
+int gssd_k5_remove_bad_service_cred(char *srvname);
 
 #ifdef HAVE_SET_ALLOWABLE_ENCTYPES
 extern int limit_to_legacy_enctypes;
-- 
2.39.1

