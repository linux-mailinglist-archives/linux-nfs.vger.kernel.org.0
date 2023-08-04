Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8B7770393
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjHDOxK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 10:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjHDOxJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 10:53:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DFD49C1
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691160743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BPOk4LAQU+258S8hwj/BFHvWoB3AgduJ/PxmSqV8SXE=;
        b=DCjMyBAZp73HW3eldqGrWAJgBzY7BiRtWo6fY7hxJhg0yTIks3IUK1+efpluY70AA4KvE4
        FSVE4GgtPAThUOraydsTG6ipcC3f+VmR++EHIHBGfOkb26ffHf0PtCvGn0/Qz7dM2c0PBh
        QSgJm8OO8O7fq+ccB5Exi9j2/Ze0YMg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-qFJvPsM6MC27C5lfYtdbSA-1; Fri, 04 Aug 2023 10:52:22 -0400
X-MC-Unique: qFJvPsM6MC27C5lfYtdbSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 996CA3C025D3;
        Fri,  4 Aug 2023 14:52:21 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.50.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 295A040C206F;
        Fri,  4 Aug 2023 14:52:21 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Fix race to FREE_STATEID and cl_revoked
Date:   Fri,  4 Aug 2023 10:52:20 -0400
Message-Id: <c0fe2b35900938943048340ef70fc12282fe1af8.1691160604.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We have some reports of linux NFS clients that cannot satisfy a linux knfsd
server that always sets SEQ4_STATUS_RECALLABLE_STATE_REVOKED even though
those clients repeatedly walk all their known state using TEST_STATEID and
receive NFS4_OK for all.

Its possible for revoke_delegation() to set NFS4_REVOKED_DELEG_STID, then
nfsd4_free_stateid() finds the delegation and returns NFS4_OK to
FREE_STATEID.  Afterward, revoke_delegation() moves the same delegation to
cl_revoked.  This would produce the observed client/server effect.

Fix this by ensuring that the setting of sc_type to NFS4_REVOKED_DELEG_STID
and move to cl_revoked happens within the same cl_lock.  This will allow
nfsd4_free_stateid() to properly remove the delegation from cl_revoked.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2217103
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2176575
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3aefbad4cc09..daf305daa751 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1354,9 +1354,9 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 	trace_nfsd_stid_revoke(&dp->dl_stid);
 
 	if (clp->cl_minorversion) {
+		spin_lock(&clp->cl_lock);
 		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
 		refcount_inc(&dp->dl_stid.sc_count);
-		spin_lock(&clp->cl_lock);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
 		spin_unlock(&clp->cl_lock);
 	}
-- 
2.40.1

