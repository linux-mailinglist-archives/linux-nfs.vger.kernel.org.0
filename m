Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54734D68EB
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Mar 2022 20:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351049AbiCKTIT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Mar 2022 14:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351052AbiCKTIS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Mar 2022 14:08:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E6D41B400C
        for <linux-nfs@vger.kernel.org>; Fri, 11 Mar 2022 11:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647025632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XeQeD4ppDNhrdjXJvghzYtboPY6efwTRGGKo6zsEAY=;
        b=DmM/3WEwJVf67mkspJj8C5Bjh2NqZP72Q+BchLDbqKJYDON7JBs8NknR23nwiol93GzFNP
        Tgi4xPgKqQhXpEa/udoCY/aVlfY8mMiV+ugCTqcdCrRusFA2X9j3l168ggh0YKWoAfX/C2
        mO2OKQGz31UVIQ8fEU5H3RShgB77b5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-m7bU32W5PzS_eyRdV0LRfQ-1; Fri, 11 Mar 2022 14:07:10 -0500
X-MC-Unique: m7bU32W5PzS_eyRdV0LRfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A25AB1854E21;
        Fri, 11 Mar 2022 19:07:09 +0000 (UTC)
Received: from nyarly.rlyeh.local (ovpn-116-72.gru2.redhat.com [10.97.116.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94F9C60BF4;
        Fri, 11 Mar 2022 19:06:59 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [RFC v2 PATCH 6/7] readahead: add mountpoint and fstype options
Date:   Fri, 11 Mar 2022 16:06:16 -0300
Message-Id: <20220311190617.3294919-7-tbecker@redhat.com>
In-Reply-To: <20220311190617.3294919-1-tbecker@redhat.com>
References: <20220311190617.3294919-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add ways to configure the system by mountpoint or fstype.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Becker <tbecker@redhat.com>
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

