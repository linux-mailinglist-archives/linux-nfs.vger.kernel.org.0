Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D65261F247
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 12:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKGL6x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 06:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKGL6p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 06:58:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95CA1ADB0
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 03:58:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1414260FF8
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 11:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF424C433C1;
        Mon,  7 Nov 2022 11:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667822323;
        bh=0Io8a4DUlk1r8Hbz4lpDkEn6BQuIG7hR++/IpDnBxmo=;
        h=From:To:Cc:Subject:Date:From;
        b=o33P5lWtXtFfl30xmkLN3nJVOgI3EKILZyKAEIzR63ZyBKxG9QwiDlBcdVOZb2m0b
         r37u9PhiDVnofF6AIMzV8s4Sq3l8zu/uRDIdGCi8yGTHQic3FxpP99JXV9cJ2KalFd
         W7VMtImhBJjSXhbOCG+Obb6ETSK0lv444X1HFcwnoT8MHg4nW8x4NdYsCklX81cxyD
         rgwycyS9dq/TGN0QL8+aAyThn9SzQqOUW2M+uw+f2Ok/bD6spjMXRDgTkf4GJFISTc
         xS6PFO6/YMCt4HireSzg2PvgW30T2OSpnOaQn+X9DSQvnZGkI65qu2ucxTjN5RbxQV
         eS8X+gFluNbaQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
        Yongcheng Yang <yoyang@redhat.com>
Subject: [PATCH] nfsd: return error if nfs4_setacl fails
Date:   Mon,  7 Nov 2022 06:58:41 -0500
Message-Id: <20221107115841.26380-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

With the addition of POSIX ACLs to struct nfsd_attrs, we no longer
return an error if setting the ACL fails. Ensure we return the na_aclerr
error on SETATTR if there is one.

Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
Cc: Neil Brown <neilb@suse.de>
Reported-by: Yongcheng Yang <yoyang@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6f7e0c5e62d2..a6173677b766 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1135,6 +1135,8 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				0, (time64_t)0);
 	if (!status)
 		status = nfserrno(attrs.na_labelerr);
+	if (!status)
+		status = nfserrno(attrs.na_aclerr);
 out:
 	nfsd_attrs_free(&attrs);
 	fh_drop_write(&cstate->current_fh);
-- 
2.38.1

