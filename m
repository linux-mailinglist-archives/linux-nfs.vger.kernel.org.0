Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF9C4D38CB
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 19:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiCIS2h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 13:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiCIS2g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 13:28:36 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ACC30F4F
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 10:27:37 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id k25-20020a056830151900b005b25d8588dbso2375306otp.4
        for <linux-nfs@vger.kernel.org>; Wed, 09 Mar 2022 10:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7EB0ChGWrSTKMmDWNtO9sfhVky9r/cuI00vpfX9eE4A=;
        b=DL/H78+OtxAohdJQ9kOc8Xbgmxa9GRPhv91R777rStbV7tVYMXPvtWSxn0BGZdqBtE
         3bTaLcaSasmyb4asPY1Ij7XKWZbrL8fa8ILOHUfwaNF3CXBTNq8TGkBIPG7uxIo/5gFc
         Ilhl+QVPzutDsh1EHjsNSe56mo7GuOAIIVfqEpThWTTgGO7Ze8vsYFpJfBzqEsxVfant
         TLsa4AHTKmWIULZekqOi06a0TeZMW14MgPsVL4gNTAuVZ8ZdCsVMte7f58PJfQXDOGtn
         02Figt/3NVGtaZwzPiSkYNVfm9Ad3EH61LxkFMcSZtFsnpVy2DP9udf9DzATz9WPFzR7
         +5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7EB0ChGWrSTKMmDWNtO9sfhVky9r/cuI00vpfX9eE4A=;
        b=ahmEKVLbLJoecsu/taV9bpDQI5RlSOCXnZiQt+RxlJS74FTpAmOLq+9mjt1jGYvmfX
         s71PNPIHX/f2ELxb4nib5vM9d2UFkST3Ilp3zW+/YaTQbMn3VJ+dS9f/CTE6hHp5pryU
         1FYnbtDD9dCt/vlkq6DySPJNNgi5GJPvYlrxIhwwaQXOFM98k+nM3mj70b5AaBKk6gaH
         BESdFebuwgNUhk+ZzHL2zsqrezgjlabayZXglIQIJkh+iianUAjY3tfCs6XWHgi3O7du
         ZM86qslVsA8ZEUOFXOJqgRTGxjRo2cJiv6qhXxorT0ZtVJaXCgTACXEwN3fTWPS12DXg
         UAsA==
X-Gm-Message-State: AOAM53387+I3DQ4x2u5URtXOITdASNEdJzML4zUiBQ4rt2weOrNev/UP
        dLGo478AfuK3aOazEMQ7N3wia23l1R8=
X-Google-Smtp-Source: ABdhPJyiLr+qrxmb8xXHEgkc/sNrChGHZKFs9jpogXbH4OKRjlpHXpbFqBWNORRc26VjWrF1TzZXmg==
X-Received: by 2002:a05:6830:304e:b0:5af:f66a:56ee with SMTP id p14-20020a056830304e00b005aff66a56eemr572605otr.226.1646850456259;
        Wed, 09 Mar 2022 10:27:36 -0800 (PST)
Received: from nyarly.redhat.com ([179.233.246.234])
        by smtp.gmail.com with ESMTPSA id k5-20020a056870a4c500b000d9c2216692sm1213270oal.24.2022.03.09.10.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:27:35 -0800 (PST)
From:   Thiago Rafael Becker <trbecker@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     tbecker@redhat.com, steved@redhat.com, chuck.lever@oracle.com,
        Thiago Rafael Becker <trbecker@gmail.com>
Subject: [RFC PATCH 6/7] readahead: add mountpoint and fstype options
Date:   Wed,  9 Mar 2022 15:26:52 -0300
Message-Id: <20220309182653.1885252-7-trbecker@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309182653.1885252-1-trbecker@gmail.com>
References: <20220309182653.1885252-1-trbecker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add ways to configure the system by mountpoint or fstype.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
---
 tools/nfs-readahead-udev/parser.y  | 15 +++++++++++----
 tools/nfs-readahead-udev/scanner.l |  5 +++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/nfs-readahead-udev/parser.y b/tools/nfs-readahead-udev/parser.y
index f6db05c4..5951c99d 100644
--- a/tools/nfs-readahead-udev/parser.y
+++ b/tools/nfs-readahead-udev/parser.y
@@ -10,20 +10,25 @@ extern FILE *yyin;
 void yyerror(const char *s);
 
 // This should be visible only to this file
-extern struct config_entry *config_entry_new(void);
+extern struct config_entry *config_entry_new();
 
 struct config_entry *current;
 %}
 
 %union {
+	char *sval;
 	int ival;
 }
 
+%token <sval> STRING
 %token <ival> INT
 %token EQ
 %token ENDL
 %token DEFAULT
+%token MOUNTPOINT
+%token FSTYPE
 %token READAHEAD
+%token <sval> FS
 %token END_CONFIG 0
 
 %%
@@ -35,7 +40,7 @@ line:
 	tokens endls {
 		struct config_entry *new = config_entry_new();
 		list_add(&current->list, &new->list);
-		current = new;
+		current = new;		
 	}
 
 
@@ -49,9 +54,11 @@ default:
 	DEFAULT
 
 pair:
-	READAHEAD EQ INT	{ current->readahead = $3; }
+	MOUNTPOINT EQ STRING	{ current->mountpoint = $3; }
+	| FSTYPE EQ FS		{ current->fstype = $3; }
+	| READAHEAD EQ INT	{ current->readahead = $3; }
 
-endls:
+endls: 
 	endls ENDL | ENDL
 
 %%
diff --git a/tools/nfs-readahead-udev/scanner.l b/tools/nfs-readahead-udev/scanner.l
index d1ceb90b..c6fb3f0c 100644
--- a/tools/nfs-readahead-udev/scanner.l
+++ b/tools/nfs-readahead-udev/scanner.l
@@ -5,10 +5,15 @@
 %option noyywrap
 %%
 default		{ return DEFAULT; }
+mountpoint	{ return MOUNTPOINT; }
+fstype		{ return FSTYPE; }
 readahead	{ return READAHEAD; }
+nfs4		{ yylval.sval = strdup(yytext); return FS; }
+nfs		{ yylval.sval = strdup(yytext); return FS; }
 [ \t]		;
 #[^\n]*\n	{ return ENDL; }
 \n		{ return ENDL; }
 [0-9]+		{ yylval.ival = atoi(yytext); return INT; }
+[a-zA-Z0-9/]+	{ yylval.sval = strdup(yytext); return STRING; }
 =		{ return EQ; }
 %%
-- 
2.35.1

