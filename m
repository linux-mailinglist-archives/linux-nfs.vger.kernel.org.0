Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D60639839
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Nov 2022 21:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKZUzm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Nov 2022 15:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKZUzm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Nov 2022 15:55:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A70117AA6
        for <linux-nfs@vger.kernel.org>; Sat, 26 Nov 2022 12:55:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9CF73CE0A28
        for <linux-nfs@vger.kernel.org>; Sat, 26 Nov 2022 20:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1C8C433C1
        for <linux-nfs@vger.kernel.org>; Sat, 26 Nov 2022 20:55:37 +0000 (UTC)
Subject: [PATCH 4/4] SUNRPC: Make the svc_authenticate tracepoint conditional
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 26 Nov 2022 15:55:36 -0500
Message-ID: <166949613683.106845.7204415829221885801.stgit@klimt.1015granger.net>
In-Reply-To: <166949601705.106845.10614964159272504008.stgit@klimt.1015granger.net>
References: <166949601705.106845.10614964159272504008.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Simplify the tracepoint's only call site.

Also, I noticed that when svc_authenticate() returns SVC_COMPLETE,
it leaves rq_auth_stat set to an error value. That doesn't need to
be recorded in the trace log.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    4 +++-
 net/sunrpc/svc.c              |    3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index f48f2ab9d238..e29d99c32891 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1666,11 +1666,13 @@ TRACE_DEFINE_ENUM(SVC_COMPLETE);
 #define SVC_RQST_ENDPOINT_VARARGS \
 		__entry->xid, __get_sockaddr(server), __get_sockaddr(client)
 
-TRACE_EVENT(svc_authenticate,
+TRACE_EVENT_CONDITION(svc_authenticate,
 	TP_PROTO(const struct svc_rqst *rqst, int auth_res),
 
 	TP_ARGS(rqst, auth_res),
 
+	TP_CONDITION(auth_res != SVC_OK && auth_res != SVC_COMPLETE),
+
 	TP_STRUCT__entry(
 		SVC_RQST_ENDPOINT_FIELDS(rqst)
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 34383c352bc3..8f1b596db33f 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1280,8 +1280,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	/* Also give the program a chance to reject this call: */
 	if (auth_res == SVC_OK && progp)
 		auth_res = progp->pg_authenticate(rqstp);
-	if (auth_res != SVC_OK)
-		trace_svc_authenticate(rqstp, auth_res);
+	trace_svc_authenticate(rqstp, auth_res);
 	switch (auth_res) {
 	case SVC_OK:
 		break;


