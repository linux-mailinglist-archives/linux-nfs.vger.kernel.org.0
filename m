Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933DE3CD87B
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jul 2021 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbhGSOWn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 10:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241738AbhGSOVc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Jul 2021 10:21:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5FBF611C1;
        Mon, 19 Jul 2021 15:01:54 +0000 (UTC)
Subject: [PATCH 3/3] NFSD: Use new __string_len C macros for nfsd_clid_class
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     rostedt@goodmis.org
Date:   Mon, 19 Jul 2021 11:01:54 -0400
Message-ID: <162670691408.60572.2483516312081665117.stgit@klimt.1015granger.net>
In-Reply-To: <162670659736.60572.10597769067889138558.stgit@klimt.1015granger.net>
References: <162670659736.60572.10597769067889138558.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 52a43acd546c..538520957a81 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -606,7 +606,7 @@ DECLARE_EVENT_CLASS(nfsd_clid_class,
 		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
 		__field(unsigned long, flavor)
 		__array(unsigned char, verifier, NFS4_VERIFIER_SIZE)
-		__dynamic_array(char, name, clp->cl_name.len + 1)
+		__string_len(name, name, clp->cl_name.len)
 	),
 	TP_fast_assign(
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
@@ -616,8 +616,7 @@ DECLARE_EVENT_CLASS(nfsd_clid_class,
 		__entry->flavor = clp->cl_cred.cr_flavor;
 		memcpy(__entry->verifier, (void *)&clp->cl_verifier,
 		       NFS4_VERIFIER_SIZE);
-		memcpy(__get_str(name), clp->cl_name.data, clp->cl_name.len);
-		__get_str(name)[clp->cl_name.len] = '\0';
+		__assign_str_len(name, clp->cl_name.data, clp->cl_name.len);
 	),
 	TP_printk("addr=%pISpc name='%s' verifier=0x%s flavor=%s client=%08x:%08x",
 		__entry->addr, __get_str(name),


