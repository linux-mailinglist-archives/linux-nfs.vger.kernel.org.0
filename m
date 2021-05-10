Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C8737931F
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhEJPyE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 11:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231213AbhEJPyD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 May 2021 11:54:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 866CC6161E;
        Mon, 10 May 2021 15:52:58 +0000 (UTC)
Subject: [PATCH RFC 13/21] NFSD: Update nfsd_cb_args tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 10 May 2021 11:52:57 -0400
Message-ID: <162066197782.94415.7100951801455614120.stgit@klimt.1015granger.net>
In-Reply-To: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
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
index 18f65a403260..dd4df6655322 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -808,9 +808,9 @@ TRACE_EVENT(nfsd_cb_args,
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


