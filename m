Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2A239ABF9
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCUw0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 16:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFCUwZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 16:52:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C650E613BF;
        Thu,  3 Jun 2021 20:50:40 +0000 (UTC)
Subject: [PATCH 01/29] lockd: Remove stale comments
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 16:50:40 -0400
Message-ID: <162275344007.32691.5052508246831591283.stgit@klimt.1015granger.net>
In-Reply-To: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
References: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/lockd/xdr.h  |    6 ------
 include/linux/lockd/xdr4.h |    7 +------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index 7ab9f264313f..a98309c0121c 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -109,11 +109,5 @@ int	nlmsvc_decode_shareargs(struct svc_rqst *, __be32 *);
 int	nlmsvc_encode_shareres(struct svc_rqst *, __be32 *);
 int	nlmsvc_decode_notify(struct svc_rqst *, __be32 *);
 int	nlmsvc_decode_reboot(struct svc_rqst *, __be32 *);
-/*
-int	nlmclt_encode_testargs(struct rpc_rqst *, u32 *, struct nlm_args *);
-int	nlmclt_encode_lockargs(struct rpc_rqst *, u32 *, struct nlm_args *);
-int	nlmclt_encode_cancargs(struct rpc_rqst *, u32 *, struct nlm_args *);
-int	nlmclt_encode_unlockargs(struct rpc_rqst *, u32 *, struct nlm_args *);
- */
 
 #endif /* LOCKD_XDR_H */
diff --git a/include/linux/lockd/xdr4.h b/include/linux/lockd/xdr4.h
index e709fe5924f2..5ae766f26e04 100644
--- a/include/linux/lockd/xdr4.h
+++ b/include/linux/lockd/xdr4.h
@@ -37,12 +37,7 @@ int	nlm4svc_decode_shareargs(struct svc_rqst *, __be32 *);
 int	nlm4svc_encode_shareres(struct svc_rqst *, __be32 *);
 int	nlm4svc_decode_notify(struct svc_rqst *, __be32 *);
 int	nlm4svc_decode_reboot(struct svc_rqst *, __be32 *);
-/*
-int	nlmclt_encode_testargs(struct rpc_rqst *, u32 *, struct nlm_args *);
-int	nlmclt_encode_lockargs(struct rpc_rqst *, u32 *, struct nlm_args *);
-int	nlmclt_encode_cancargs(struct rpc_rqst *, u32 *, struct nlm_args *);
-int	nlmclt_encode_unlockargs(struct rpc_rqst *, u32 *, struct nlm_args *);
- */
+
 extern const struct rpc_version nlm_version4;
 
 #endif /* LOCKD_XDR4_H */


