Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B1E379327
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhEJPyt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 11:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231753AbhEJPyr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 May 2021 11:54:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1418615FF;
        Mon, 10 May 2021 15:53:41 +0000 (UTC)
Subject: [PATCH RFC 20/21] NFSD: Rename nfsd_clid_class
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 10 May 2021 11:53:40 -0400
Message-ID: <162066202093.94415.13015338146767016745.stgit@klimt.1015granger.net>
In-Reply-To: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up in preparation for subsequent patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 9567840f8580..523045c37749 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -537,7 +537,7 @@ DEFINE_EVENT(nfsd_net_class, nfsd_##name, \
 DEFINE_NET_EVENT(grace_start);
 DEFINE_NET_EVENT(grace_complete);
 
-DECLARE_EVENT_CLASS(nfsd_clid_class,
+DECLARE_EVENT_CLASS(nfsd_reclaim_class,
 	TP_PROTO(const struct nfsd_net *nn,
 		 unsigned int namelen,
 		 const unsigned char *namedata),
@@ -556,15 +556,15 @@ DECLARE_EVENT_CLASS(nfsd_clid_class,
 		__entry->boot_time, __entry->namelen, __get_str(name))
 )
 
-#define DEFINE_CLID_EVENT(name) \
-DEFINE_EVENT(nfsd_clid_class, nfsd_clid_##name, \
+#define DEFINE_RECLAIM_EVENT(name) \
+DEFINE_EVENT(nfsd_reclaim_class, nfsd_clid_##name, \
 	TP_PROTO(const struct nfsd_net *nn, \
 		 unsigned int namelen, \
 		 const unsigned char *namedata), \
 	TP_ARGS(nn, namelen, namedata))
 
-DEFINE_CLID_EVENT(find);
-DEFINE_CLID_EVENT(reclaim);
+DEFINE_RECLAIM_EVENT(find);
+DEFINE_RECLAIM_EVENT(reclaim);
 
 TRACE_EVENT(nfsd_clid_cred_mismatch,
 	TP_PROTO(


