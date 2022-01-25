Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C7C49BBA5
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 19:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiAYS5T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 13:57:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54194 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiAYS4j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 13:56:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6440B81A1F
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 18:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABDFC340E0
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 18:56:34 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSD: Streamline the rare "found" case
Date:   Tue, 25 Jan 2022 13:56:33 -0500
Message-Id:  <164313699280.3172.12897171386272557403.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164313689644.3172.6086810615126935434.stgit@bazille.1015granger.net>
References:  <164313689644.3172.6086810615126935434.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209; h=from:subject:message-id; bh=F75doHNlEwCaCZ7RPcczkgYS7llc7VIwT3CMGuDOYXE=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8Efgf6q1nlJAMw7Faybc9NX1+3j93mUIngQCQyDq WjL07tGJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfBH4AAKCRAzarMzb2Z/lz3/D/ 9pwrL9WruNsljMmSNKD3OEths+HmyafExnWovf9OlcTLSI+gZPRkq1YWhP3ryvnOhhDELswz+me0u/ Tg1SYEEul+wbxw8tcebd/rzfvbz8A2muYvG7bEcGdF7ig1YOXtuuGGQ8ebZ5I2hCdVqePhgv/tYp1v rxfQGsrGJvZdGWKSxLgRx7/SHHEgAklBtSjbYR4ra20BVuPQqkb0rKu5JmIcIVQ7y6LAOktk5HAbvQ A6i06uNmCfwOvEpN74AQSjn+gxyxgLPin5zF9WDdMJGaf0r98XeDBW23OpQs8liQO5vP05aINhkxrB ip3Kq7aC889oAD6UmZrwl7vsF8yFKpomR2eUyrkUHd2QP76IvVY5eH5+OPF/wHIOztR9rtIvOGGj1e MptRKa1FKK6b7HHcVrKIUZouL9DyxYGiz+v4ItgijIsrD7Jk/YX0EumVndyr5YYE6g0zX7j7OLtwfm 9OpeE6ESJfZOnu7cO2E/Afrj9F8XL10LKfV0X+AYVMXAJ7ghnESaswH0HsllSBdm7dAvuBQfzJus/D HbM548Pu7RcbcPCqDbmJwBrdiUV4n3NEyeDzCXgjgkvKklLxJZRGh7FoHRd87rGAVRTC+i21KxmAKW cUovpIioDj1kQgf7rQ6YkVY757T7ldwQIJm4YWfN8Yq+WPoO8jUZ12n3YAGw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Move a rarely called function call site out of the hot path.

This is an exceptionally small improvement because the compiler
inlines most of the functions that nfsd_cache_lookup() calls.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 34087a7e4f93..0b3f12aa37ff 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -448,11 +448,8 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 	b = nfsd_cache_bucket_find(rqstp->rq_xid, nn);
 	spin_lock(&b->cache_lock);
 	found = nfsd_cache_insert(b, rp, nn);
-	if (found != rp) {
-		nfsd_reply_cache_free_locked(NULL, rp, nn);
-		rp = found;
+	if (found != rp)
 		goto found_entry;
-	}
 
 	nfsd_stats_rc_misses_inc();
 	rqstp->rq_cacherep = rp;
@@ -470,8 +467,10 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 
 found_entry:
 	/* We found a matching entry which is either in progress or done. */
+	nfsd_reply_cache_free_locked(NULL, rp, nn);
 	nfsd_stats_rc_hits_inc();
 	rtn = RC_DROPIT;
+	rp = found;
 
 	/* Request being processed */
 	if (rp->c_state == RC_INPROG)

