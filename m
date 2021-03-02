Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DDF32B748
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Mar 2021 12:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbhCCKwp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 05:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581832AbhCBT1O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 14:27:14 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB774C061756
        for <linux-nfs@vger.kernel.org>; Tue,  2 Mar 2021 07:48:38 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 59F651C81; Tue,  2 Mar 2021 10:48:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 59F651C81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614700118;
        bh=PoU6Jm21uiDYByZZf+xG78ujmB2iDcWgJjiajIuG1Uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C72+yKsWu/GIDurlAHT/fmdM4HJQmtHnO7IzycvYY9vXxCCb/zmfdIRqrfbYBVb0A
         jbkOjBTjLLTESF4NHhKsTtWzTYHqK76jnbdGURQnm64YvnvTVdtHl5DPmUufFOwIzX
         C6NXdBO5XPzejH6c3/Qq+l1S8EgkWwF0d0rGRdUs=
Date:   Tue, 2 Mar 2021 10:48:38 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Daniel Kobras <kobras@puzzle-itc.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] rpc: fix NULL dereference on kmalloc failure
Message-ID: <20210302154838.GB2263@fieldses.org>
References: <20210226230437.jfgagcq5magzlrtv@tuedko18.puzzle-itc.de>
 <C2704113-2581-4B58-806B-BB65148AC14B@oracle.com>
 <20210301162820.GB11772@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301162820.GB11772@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

I think this is unlikely but possible:

svc_authenticate sets rq_authop and calls svcauth_gss_accept.  The
kmalloc(sizeof(*svcdata), GFP_KERNEL) fails, leaving rq_auth_data NULL,
and returning SVC_DENIED.

This causes svc_process_common to go to err_bad_auth, and eventually
call svc_authorise.  That calls ->release == svcauth_gss_release, which
tries to dereference rq_auth_data.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

On Mon, Mar 01, 2021 at 11:28:20AM -0500, Bruce Fields wrote:
> Possibly orthogonal to this problem, but: svcauth_gss_release
> unconditionally dereferences rqstp->rq_auth_data.  Isn't that a NULL
> dereference if the kmalloc at the start of svcauth_gss_accept() fails?

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index bd4678db9d76..6dff64374bfe 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1825,11 +1825,14 @@ static int
 svcauth_gss_release(struct svc_rqst *rqstp)
 {
 	struct gss_svc_data *gsd = (struct gss_svc_data *)rqstp->rq_auth_data;
-	struct rpc_gss_wire_cred *gc = &gsd->clcred;
+	struct rpc_gss_wire_cred *gc;
 	struct xdr_buf *resbuf = &rqstp->rq_res;
 	int stat = -EINVAL;
 	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
 
+	if (!gsd)
+		goto out;
+	gc = &gsd->clcred;
 	if (gc->gc_proc != RPC_GSS_PROC_DATA)
 		goto out;
 	/* Release can be called twice, but we only wrap once. */
@@ -1870,10 +1873,10 @@ svcauth_gss_release(struct svc_rqst *rqstp)
 	if (rqstp->rq_cred.cr_group_info)
 		put_group_info(rqstp->rq_cred.cr_group_info);
 	rqstp->rq_cred.cr_group_info = NULL;
-	if (gsd->rsci)
+	if (gsd && gsd->rsci) {
 		cache_put(&gsd->rsci->h, sn->rsc_cache);
-	gsd->rsci = NULL;
-
+		gsd->rsci = NULL;
+	}
 	return stat;
 }
 
-- 
2.29.2

