Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2317B869E
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 19:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243433AbjJDRcs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 13:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbjJDRcs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 13:32:48 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854E6A6
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 10:32:44 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a29359c80bso112339f.0
        for <linux-nfs@vger.kernel.org>; Wed, 04 Oct 2023 10:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696440764; x=1697045564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5M5nZmgd0eT5+pfJkgYu11F2ceb5YStJf+SJwFlEFc=;
        b=cfhEvJDhI+NuD1aNwQC90mrOqlHT/NUoUK7TCWi/Q3Pw3/zsqf1foKQ+fNZ6DLTg2k
         58k4YWYPY7Ix2VfQbXiTiRzlvFViPokJ2Eir71qXDGE7P20G60anLODuv+wA+EUvQgg2
         4zhn5HEonCpkab8aSW5Z64bMVTXmQMs1+hNYddpkjjElFOpWe6TxX15WhWFlFWTXAI5+
         +jV4Qn+PwnaTm6HhmFDRhPdebFcskDoR3q3Saufp3t6djE7L4jjdHHYNasxhrOWa5vbB
         ftD/VUcH5apGHU2XnIM3oFjZJflFQhmxI7qbvFHTKqYAaI+b21ui09QzUGwmORO/yne0
         jIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440764; x=1697045564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5M5nZmgd0eT5+pfJkgYu11F2ceb5YStJf+SJwFlEFc=;
        b=pQit0Mjj4hxqZcDU2ea7Z5vELaySCIMGfHG2HeukRzufQa9f8UAzS1LkpO4M6n3pIE
         t9bSEIEY41lS+Kn+89PYFAhklv1od55Nd+ipc27OAIZyru5MP4Dm028ckfAzvqs1Jqrk
         JLzXLZcSYqIcrB2ouqLUxw4+IMnJIugAvZmjcAA4a5pBIbCJUrMXPoaaC+IExnEqnhoe
         no+f+nldXf33SRjDm4Dv+tYPu1mqZU0SRrlbu+L+27EcA3NhHIZ7AxUKITvbZQvvrrNi
         CvCbNK1zSQOEZau4jg1dt7IDpbUUqoJZ23NBvWjO5d6duxpoIbojogiPV481zQyAMETD
         XxvQ==
X-Gm-Message-State: AOJu0YxkpvC6l58ezTQjNkHpVtOpyT+BXSivY08CdNB5htaTUfsX13+3
        vmdroipAgnp7T41FRlj1sux06VORWYg=
X-Google-Smtp-Source: AGHT+IHqkOB8dt2Pt4Wt0ooF4YzLxGMJQqCdtkla03F/QWxvYnwGLxkHoGsq272zlL4k6GufhRn0aA==
X-Received: by 2002:a05:6602:1a07:b0:79d:1c65:9bde with SMTP id bo7-20020a0566021a0700b0079d1c659bdemr3401342iob.1.1696440763843;
        Wed, 04 Oct 2023 10:32:43 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:d99c:94dd:ccd6:fb22])
        by smtp.gmail.com with ESMTPSA id u23-20020a6be417000000b007870289f4fdsm1066598iog.51.2023.10.04.10.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 10:32:43 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] gss-api: expose gss major/minor error in authgss_refresh()
Date:   Wed,  4 Oct 2023 13:32:36 -0400
Message-Id: <20231004173240.46924-2-olga.kornievskaia@gmail.com>
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

When the client calls into the libtirpc to establish security
context, the errors that occurred are squashed. Instead, extend
authgss_refresh to propagate back the gss major/minor error
codes to the caller.

--- v2 fix a compiler warning reported by Steve Dickson

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 src/auth_gss.c       | 14 ++++++++------
 tirpc/rpc/auth_gss.h |  2 ++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/auth_gss.c b/src/auth_gss.c
index e317664..3127b92 100644
--- a/src/auth_gss.c
+++ b/src/auth_gss.c
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
 
@@ -619,12 +624,9 @@ _rpc_gss_refresh(AUTH *auth, rpc_gss_options_ret_t *options_ret)
 }
 
 static bool_t
-authgss_refresh(AUTH *auth, void *dummy)
+authgss_refresh(AUTH *auth, void *ret)
 {
-	rpc_gss_options_ret_t ret;
-
-	memset(&ret, 0, sizeof(ret));
-	return _rpc_gss_refresh(auth, &ret);
+	return _rpc_gss_refresh(auth, (rpc_gss_options_ret_t *)ret);
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

