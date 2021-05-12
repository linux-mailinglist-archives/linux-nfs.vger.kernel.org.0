Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B428037CB06
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 18:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbhELQdz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 12:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239372AbhELQH4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:07:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CA4C61C5C;
        Wed, 12 May 2021 15:37:40 +0000 (UTC)
Subject: [PATCH v2 25/25] NFSD: Update nfsd_cb_args tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org, rostedt@goodmis.org
Date:   Wed, 12 May 2021 11:37:39 -0400
Message-ID: <162083385925.3108.6918634457696790506.stgit@klimt.1015granger.net>
In-Reply-To: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean-up: Re-order the display of IP address and client ID to be
consistent with other _cb_ tracepoints.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 4b916fb4a388..eba5b51a08e7 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -854,9 +854,9 @@ TRACE_EVENT(nfsd_cb_args,
 		memcpy(__entry->addr, &conn->cb_addr,
 			sizeof(struct sockaddr_in6));
 	),
-	TP_printk("client %08x:%08x callback addr=%pISpc prog=%u ident=%u",
-		__entry->cl_boot, __entry->cl_id,
-		__entry->addr, __entry->prog, __entry->ident)
+	TP_printk("addr=%pISpc client %08x:%08x prog=%u ident=%u",
+		__entry->addr, __entry->cl_boot, __entry->cl_id,
+		__entry->prog, __entry->ident)
 );
 
 TRACE_EVENT(nfsd_cb_nodelegs,


