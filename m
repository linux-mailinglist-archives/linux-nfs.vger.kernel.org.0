Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AED43056F
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhJPWsf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJPWse (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:48:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB29560FDC;
        Sat, 16 Oct 2021 22:46:25 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 01/14] SUNRPC: Update the show_svc_xprt_flags() macro
Date:   Sat, 16 Oct 2021 18:46:24 -0400
Message-Id:  <163442438467.1001.7912306583109421204.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2062; h=from:subject:message-id; bh=hpL6npqoll09jET3oulo4+vroEYozBTXJ8/tFrYcNVg=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1ZA4ocvgJBn/lmhV+FT597k280CaoPHIHsi3uns 14PXgziJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWQAAKCRAzarMzb2Z/lz//EA Cz+RfLCx13YkogX1oRK+9IeS7rqZQZf6JZWx3Mc9x93iu3RAsmcVxnvo3cdicCyHrcS1+2886+w5jl SGyBfx0Z1ORJvtcW7mpSIWuuS/cL9IQwNMOJ3gU1npPFyj/uiuxRF+zCe5PWhLe1CBvXqmdb81zhod Lfj+s6hghhEvHNtowDx8kT/SSfHdkRqfs6SS5NR7tNoPYpGDFa1uZGAIN/xNlz0GeE3OpRf58IxdV/ DDoGsUxdzaYmco8/+tG30iGYcXR8QAcofa81QIka2w2v4NFCrz+sLP4rOSSwLzEdf/LYpNvce76DiF WEF4zPTYvWfoBHup/03Epcpr5SGwqAomffkh85t0rgVQEvqoS6WMyGQ5e6FKkktlmiELfvnEPg6q6W jy4Ojl2TYS7JwJ8GQkj/ABNaXE4sy9GxzSZpHIjoaz+T6eL+54xSjQHtqaR2BtldoS9NvLpfOpvYJx J2Pzece74FcI9dQiOazhNCZ4lDXEdulyr7nnBBe7wDRiGx2VHWPKlm/4JERUybGznWbPOjZUOflvKU F9FZQzrIeT4Zqrk6MkX4SZQhcV6pCWjFszO71WdVbtoc5z+ClOJCgomRnzvZgkimOKbfouPg3DWRJ4 2mzKPSI8SF76D266SeTnPnAzrRS0bis4Hi4jQYd6CffSN42TuKaN2xkRJT+g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use BIT() instead of open-coding the bit shift. Also, compact the
information that is displayed in the log by removing the redundant
"XPT_" string from each symbolic name.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 9ea59959a2fe..23b0964e0425 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1705,22 +1705,22 @@ DEFINE_EVENT(svc_rqst_status, svc_send,
 	TP_PROTO(struct svc_rqst *rqst, int status),
 	TP_ARGS(rqst, status));
 
-#define show_svc_xprt_flags(flags)					\
-	__print_flags(flags, "|",					\
-		{ (1UL << XPT_BUSY),		"XPT_BUSY"},		\
-		{ (1UL << XPT_CONN),		"XPT_CONN"},		\
-		{ (1UL << XPT_CLOSE),		"XPT_CLOSE"},		\
-		{ (1UL << XPT_DATA),		"XPT_DATA"},		\
-		{ (1UL << XPT_TEMP),		"XPT_TEMP"},		\
-		{ (1UL << XPT_DEAD),		"XPT_DEAD"},		\
-		{ (1UL << XPT_CHNGBUF),		"XPT_CHNGBUF"},		\
-		{ (1UL << XPT_DEFERRED),	"XPT_DEFERRED"},	\
-		{ (1UL << XPT_OLD),		"XPT_OLD"},		\
-		{ (1UL << XPT_LISTENER),	"XPT_LISTENER"},	\
-		{ (1UL << XPT_CACHE_AUTH),	"XPT_CACHE_AUTH"},	\
-		{ (1UL << XPT_LOCAL),		"XPT_LOCAL"},		\
-		{ (1UL << XPT_KILL_TEMP),	"XPT_KILL_TEMP"},	\
-		{ (1UL << XPT_CONG_CTRL),	"XPT_CONG_CTRL"})
+#define show_svc_xprt_flags(flags)				\
+	__print_flags(flags, "|",				\
+		{ BIT(XPT_BUSY),	"BUSY" },		\
+		{ BIT(XPT_CONN),	"CONN" },		\
+		{ BIT(XPT_CLOSE),	"CLOSE" },		\
+		{ BIT(XPT_DATA),	"DATA" },		\
+		{ BIT(XPT_TEMP),	"TEMP" },		\
+		{ BIT(XPT_DEAD),	"DEAD" },		\
+		{ BIT(XPT_CHNGBUF),	"CHNGBUF" },		\
+		{ BIT(XPT_DEFERRED),	"DEFERRED" },		\
+		{ BIT(XPT_OLD),		"OLD" },		\
+		{ BIT(XPT_LISTENER),	"LISTENER" },		\
+		{ BIT(XPT_CACHE_AUTH),	"CACHE_AUTH" },		\
+		{ BIT(XPT_LOCAL),	"LOCAL" },		\
+		{ BIT(XPT_KILL_TEMP),	"KILL_TEMP" },		\
+		{ BIT(XPT_CONG_CTRL),	"CONG_CTRL" })
 
 TRACE_EVENT(svc_xprt_create_err,
 	TP_PROTO(

