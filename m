Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC805832EE
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 21:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbiG0THd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 15:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiG0THK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 15:07:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A827458B55
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 11:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B493B821E5
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C52C433C1
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:40:17 +0000 (UTC)
Subject: [PATCH v2 03/13] NFSD: Shrink size of struct nfsd4_copy_notify
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 27 Jul 2022 14:40:16 -0400
Message-ID: <165894721620.11193.18315530218658312788.stgit@manet.1015granger.net>
In-Reply-To: <165894669884.11193.6386905165076468843.stgit@manet.1015granger.net>
References: <165894669884.11193.6386905165076468843.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
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

struct nfsd4_copy_notify is part of struct nfsd4_op, which resides
in an 8-element array.

sizeof(struct nfsd4_op):
Before: /* size: 2208, cachelines: 35, members: 5 */
After:  /* size: 1696, cachelines: 27, members: 5 */

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    4 ++--
 fs/nfsd/nfs4xdr.c  |   12 ++++++++++--
 fs/nfsd/xdr4.h     |    4 ++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4a09cb473378..dca4c6b8f74c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1953,9 +1953,9 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	/* For now, only return one server address in cpn_src, the
 	 * address used by the client to connect to this server.
 	 */
-	cn->cpn_src.nl4_type = NL4_NETADDR;
+	cn->cpn_src->nl4_type = NL4_NETADDR;
 	status = nfsd4_set_netaddr((struct sockaddr *)&rqstp->rq_daddr,
-				 &cn->cpn_src.u.nl4_addr);
+				 &cn->cpn_src->u.nl4_addr);
 	WARN_ON_ONCE(status);
 	if (status) {
 		nfs4_put_cpntf_state(nn, cps);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9b8091c177bc..06a9d7632552 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1952,10 +1952,17 @@ nfsd4_decode_copy_notify(struct nfsd4_compoundargs *argp,
 {
 	__be32 status;
 
+	cn->cpn_src = svcxdr_tmpalloc(argp, sizeof(*cn->cpn_src));
+	if (cn->cpn_src == NULL)
+		return nfserr_jukebox;
+	cn->cpn_dst = svcxdr_tmpalloc(argp, sizeof(*cn->cpn_dst));
+	if (cn->cpn_dst == NULL)
+		return nfserr_jukebox;
+
 	status = nfsd4_decode_stateid4(argp, &cn->cpn_src_stateid);
 	if (status)
 		return status;
-	return nfsd4_decode_nl4_server(argp, &cn->cpn_dst);
+	return nfsd4_decode_nl4_server(argp, cn->cpn_dst);
 }
 
 static __be32
@@ -4898,7 +4905,8 @@ nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 	*p++ = cpu_to_be32(1);
 
-	return nfsd42_encode_nl4_server(resp, &cn->cpn_src);
+	nfserr = nfsd42_encode_nl4_server(resp, cn->cpn_src);
+	return nfserr;
 }
 
 static __be32
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 6e6a89008ce1..f253fc3f4708 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -595,13 +595,13 @@ struct nfsd4_offload_status {
 struct nfsd4_copy_notify {
 	/* request */
 	stateid_t		cpn_src_stateid;
-	struct nl4_server	cpn_dst;
+	struct nl4_server	*cpn_dst;
 
 	/* response */
 	stateid_t		cpn_cnr_stateid;
 	u64			cpn_sec;
 	u32			cpn_nsec;
-	struct nl4_server	cpn_src;
+	struct nl4_server	*cpn_src;
 };
 
 struct nfsd4_op {


