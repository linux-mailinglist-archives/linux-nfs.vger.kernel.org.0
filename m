Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F158D379326
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 17:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhEJPym (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 11:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231753AbhEJPyk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 May 2021 11:54:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81C13615FF;
        Mon, 10 May 2021 15:53:35 +0000 (UTC)
Subject: [PATCH RFC 19/21] NFSD: Add a couple more nfsd_clid_expired call
 sites
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 10 May 2021 11:53:34 -0400
Message-ID: <162066201472.94415.18189179652391526329.stgit@klimt.1015granger.net>
In-Reply-To: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Improve observation of NFSv4 lease expiry.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 52e03e9ab021..a61601fe422a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2667,6 +2667,8 @@ static void force_expire_client(struct nfs4_client *clp)
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	bool already_expired;
 
+	trace_nfsd_clid_expired(&clp->cl_clientid);
+
 	spin_lock(&clp->cl_lock);
 	clp->cl_time = 0;
 	spin_unlock(&clp->cl_lock);
@@ -4076,6 +4078,7 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 				goto out;
 			status = mark_client_expired_locked(old);
 			if (status) {
+				trace_nfsd_clid_expired(&old->cl_clientid);
 				old = NULL;
 				goto out;
 			}


