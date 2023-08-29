Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225BB78CD75
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Aug 2023 22:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbjH2UTb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 16:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240517AbjH2UTK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 16:19:10 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78274CC0
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 13:19:06 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77dcff76e35so50235239f.1
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693340346; x=1693945146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFalNfo88635XzIIWVYrfOYkVYq3q2qXKvQLV3zSROA=;
        b=EKmTxbUvHMMvRXVRJsipyHcdilSbgZSRmRcSTN79kWj0jWtoVR6whsLi/YW6D/1cjd
         ZxWCdm40c0rg4y+4iHT1SJrg22TEtEZ8gkl6mmRFFeakFcUcKRHRRbZnxgQ339XHVvvx
         KQh4vYWWcfYOHDd7w4sQaYjBvXK5QJgZtItVctC0KXdIaGvl2NmiaTQ1rh6xcrUaFBLY
         4TJT9NMMiJumIaIB9BtkIFTDHrVU4Do1zeomav6SpqFasf0qxqxmQcirFuubuPH3TnM8
         fTeiqSDzBH8JA/ayxUg7yhRNABLZSzFdr4SiEWr95lqA6IejSd8Ci4fdIN4MtgL/mG23
         EURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693340346; x=1693945146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFalNfo88635XzIIWVYrfOYkVYq3q2qXKvQLV3zSROA=;
        b=DITiClCDp8PJDqJQF2vXWXfEZe82txW/z/rXrjrm31xwJDDlZOL6eiZzXjHN2LaCxo
         EEoC9IP04W0s3GAR11erlIs73qh6NU4s1pcBnHoNukHRRIBLlCHfF5XOwqfVdPTXkOuO
         TlL6eJW9r2ltre2UPjwHPSju5LmmBL9gWp0jW3Wms+2j923M73rCcmWoC9OEEn5oa5ED
         eP/lIUhRUYZ4g+gwG0BDPL3OiY1zHFUfV7NO3ENBRT9VL2nbFs9MuX6wmgtHrzS+8zel
         M8XqkxNnREbymw98zomCMAHdfbCLHjIsALs0uOkT84dt25+9CA3hLjPcl6Lr3R2qcLwM
         4StQ==
X-Gm-Message-State: AOJu0Yx5qnJ5lBQznVc6nkhRdl7Hj5/gpQehw6ZNmG56vIw3PvpRzpa/
        X5CtpnfhahN/ebTgBZyLV+4I07+91Xc=
X-Google-Smtp-Source: AGHT+IHHiWXduepJHA5LG5bHHO/3MRVo2H87pNkQOg2yjfga5JuSexuGyvHNYPkmJp98RZbewhqfpw==
X-Received: by 2002:a05:6602:3789:b0:794:da1e:b249 with SMTP id be9-20020a056602378900b00794da1eb249mr412250iob.1.1693340345774;
        Tue, 29 Aug 2023 13:19:05 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b9e5:28ab:6ad7:257e])
        by smtp.gmail.com with ESMTPSA id gk8-20020a0566386a8800b0042b2f0b77aasm3300798jab.95.2023.08.29.13.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:19:05 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] libtirpc: gss-api: expose gss major/minor error in authgss_refresh()
Date:   Tue, 29 Aug 2023 16:18:59 -0400
Message-Id: <20230829201902.63036-2-olga.kornievskaia@gmail.com>
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

When the client calls into the libtirpc to establish security
context, the errors that occurred are squashed. Instead, extend
authgss_refresh to propagate back the gss major/minor error
codes to the caller.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 src/auth_gss.c       | 17 +++++++++--------
 tirpc/rpc/auth_gss.h |  2 ++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/src/auth_gss.c b/src/auth_gss.c
index e317664..fa96acd 100644
--- a/src/auth_gss.c
+++ b/src/auth_gss.c
@@ -54,7 +54,7 @@
 
 static void	authgss_nextverf(AUTH *);
 static bool_t	authgss_marshal(AUTH *, XDR *);
-static bool_t	authgss_refresh(AUTH *, void *);
+static bool_t	authgss_refresh(AUTH *, rpc_gss_options_ret_t *);
 static bool_t	authgss_validate(AUTH *, struct opaque_auth *);
 static void	authgss_destroy(AUTH *);
 static void	authgss_destroy_context(AUTH *);
@@ -184,6 +184,7 @@ authgss_create(CLIENT *clnt, gss_name_t name, struct rpc_gss_sec *sec)
 	AUTH			*auth, *save_auth;
 	struct rpc_gss_data	*gd;
 	OM_uint32		min_stat = 0;
+	rpc_gss_options_ret_t	ret;
 
 	gss_log_debug("in authgss_create()");
 
@@ -229,8 +230,12 @@ authgss_create(CLIENT *clnt, gss_name_t name, struct rpc_gss_sec *sec)
 	save_auth = clnt->cl_auth;
 	clnt->cl_auth = auth;
 
-	if (!authgss_refresh(auth, NULL))
+	memset(&ret, 0, sizeof(rpc_gss_options_ret_t));
+	if (!authgss_refresh(auth, &ret)) {
 		auth = NULL;
+		sec->major_status = ret.major_status;
+		sec->minor_status = ret.minor_status;
+	}
 	else
 		authgss_auth_get(auth); /* Reference for caller */
 
@@ -265,7 +270,6 @@ authgss_create_default(CLIENT *clnt, char *service, struct rpc_gss_sec *sec)
 	}
 
 	auth = authgss_create(clnt, name, sec);
-
 	if (name != GSS_C_NO_NAME) {
 		LIBTIRPC_DEBUG(3, ("authgss_create_default: freeing name %p", name));
  		gss_release_name(&min_stat, &name);
@@ -619,12 +623,9 @@ _rpc_gss_refresh(AUTH *auth, rpc_gss_options_ret_t *options_ret)
 }
 
 static bool_t
-authgss_refresh(AUTH *auth, void *dummy)
+authgss_refresh(AUTH *auth, rpc_gss_options_ret_t *ret)
 {
-	rpc_gss_options_ret_t ret;
-
-	memset(&ret, 0, sizeof(ret));
-	return _rpc_gss_refresh(auth, &ret);
+	return _rpc_gss_refresh(auth, ret);
 }
 
 bool_t
diff --git a/tirpc/rpc/auth_gss.h b/tirpc/rpc/auth_gss.h
index f2af6e9..a530d42 100644
--- a/tirpc/rpc/auth_gss.h
+++ b/tirpc/rpc/auth_gss.h
@@ -64,6 +64,8 @@ struct rpc_gss_sec {
 	rpc_gss_svc_t	svc;		/* service */
 	gss_cred_id_t	cred;		/* cred handle */
 	u_int		req_flags;	/* req flags for init_sec_context */
+	int		major_status;
+	int		minor_status;
 };
 
 /* Private data required for kernel implementation */
-- 
2.39.1

