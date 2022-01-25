Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492C549BBA4
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 19:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiAYS5R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 13:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiAYS4d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 13:56:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB37C06173E
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 10:56:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2A40B81A1F
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 18:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD1DC340E0
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 18:56:27 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSD: Skip extra computation for RC_NOCACHE case
Date:   Tue, 25 Jan 2022 13:56:26 -0500
Message-Id:  <164313698596.3172.14876464742908606484.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164313689644.3172.6086810615126935434.stgit@bazille.1015granger.net>
References:  <164313689644.3172.6086810615126935434.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347; h=from:subject:message-id; bh=+BSILMlNnjV8DzwTdiK70U0ahmqz8RgoPO5XupmelN0=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8Efar+uJJpvL5Tp6vprHc2Q5c+hy0arg7if7nsX7 2UDeyimJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfBH2gAKCRAzarMzb2Z/lwqWD/ 93Tfa5a+O1ngnj0q677m1tR16aaL0VgVV/HlYTX0CA3ZUg+lQRUT0G2YJ6Ci+vLK+xxhbLVdCM1unF gpNX4Z51YK0/yTauU8F4Stq9MZcCdwoNVOJp5v9h/5CzTUaEXmASni4d9HfhB8Flyn7hAzx0EqEOzr fFbhFod9ZM9Fi77hHIqYxdRedWBCbtPjLx0w9AODMR5r+UN4MVgLnRnawBBRNXBycN1dJpJcQbamy+ fTl4aJOOfsWZGti4lNePeelxS65Vd/YjnbftqJopaZs3ANP72OOUYRnJWXH8z+4OovzHynr49HPbg9 hm/JOd9D9xald2Jkvj3wvXg8txPZs1hpD7nPW0Ora6NHHmvb44CGtsiskYcLUSM6ZGDAXct5x30OPD CWAEIp0khXoEysv2HKbCgvN5E2c5SgM4ChvJIJx7seK0UXWBOkbOpuMOGAsbC1v7QTVwC2Z+99GY5S ayRPrk5tdITF4K5+OmUOzkLK5E9sZiuoWxpfkKpimQ8uHi6ddoLwfa43JqrYVgJghS/w02T86IybPj odcAmSb7xyxzf+5Mi0ya9E2XnUmtcgqqI21XQZ1qU6qZEJ3zqsOcsOgbTxJk7wlVKNHMtK7Qgg9udI NR4J37zqkVIJj507lBdSLD/G/I0RDq9X5TrurgcwmQzdoYH2OrWLyM5DYxlw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Force the compiler to skip unneeded initialization for cases that
don't need those values. For example, NFSv4 COMPOUND operations are
RC_NOCACHE.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index f79790d36728..34087a7e4f93 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -421,10 +421,10 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
  */
 int nfsd_cache_lookup(struct svc_rqst *rqstp)
 {
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfsd_net		*nn;
 	struct svc_cacherep	*rp, *found;
 	__wsum			csum;
-	struct nfsd_drc_bucket	*b = nfsd_cache_bucket_find(rqstp->rq_xid, nn);
+	struct nfsd_drc_bucket	*b;
 	int type = rqstp->rq_cachetype;
 	int rtn = RC_DOIT;
 
@@ -440,10 +440,12 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 	 * Since the common case is a cache miss followed by an insert,
 	 * preallocate an entry.
 	 */
+	nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	rp = nfsd_reply_cache_alloc(rqstp, csum, nn);
 	if (!rp)
 		goto out;
 
+	b = nfsd_cache_bucket_find(rqstp->rq_xid, nn);
 	spin_lock(&b->cache_lock);
 	found = nfsd_cache_insert(b, rp, nn);
 	if (found != rp) {

