Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D7364BB9E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 19:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbiLMSIx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 13:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiLMSIf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 13:08:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F4823EA7
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 10:08:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5518616C2
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 18:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8545C433D2;
        Tue, 13 Dec 2022 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670954908;
        bh=6SDQILrM0JrWEcHg3kg062g1euBvj/ePblfHudnvGAM=;
        h=From:To:Cc:Subject:Date:From;
        b=l15D1PPCW0+jKQtLfAHDIRa+7QFTG9HLe+dAW8vf820H7YxDDL0AnDQhKVhFOb1jN
         AYpf85RgFxsAp6scTfUjRBYsWvzNWmNfwjU8yDQsJNau2nY7GDy1R6SIre2y34el3p
         LfRqb1ZbG1wZ96epkqsPUQFFsS6X72wc94piEpIG85ZCITALHJmg2R9G9MV8wxZO+Q
         MkrF3x18JFW9xfelljxoii2YLedB6tjQ/VN4GbwYGpDWC3WK7sish0D1FbTnK08axK
         fCRu60AOG17UlsPUQkubhzlT37F1/OWNUgFj07tmFbMEw6CNS9mnuDfIELbC3r8e6P
         hemq2hJTtk+IA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        JianHong Yin <yin-jianhong@163.com>
Subject: [PATCH] nfsd: fix handling of readdir in v4root vs. mount upcall timeout
Date:   Tue, 13 Dec 2022 13:08:26 -0500
Message-Id: <20221213180826.216690-1-jlayton@kernel.org>
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

If v4 READDIR operation hits a mountpoint and gets back an error,
then it will include that entry in the reply and set RDATTR_ERROR for it
to the error.

That's fine for "normal" exported filesystems, but on the v4root, we
need to be more careful to only expose the existence of dentries that
lead to exports.

If the mountd upcall times out while checking to see whether a
mountpoint on the v4root is exported, then we have no recourse other
than to fail the whole operation.

Cc: Steve Dickson <steved@redhat.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216777
Reported-by:  JianHong Yin <yin-jianhong@163.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2b4ae858c89b..984528ce8d68 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3588,6 +3588,7 @@ nfsd4_encode_dirent(void *ccdv, const char *name, int namlen,
 	struct readdir_cd *ccd = ccdv;
 	struct nfsd4_readdir *cd = container_of(ccd, struct nfsd4_readdir, common);
 	struct xdr_stream *xdr = cd->xdr;
+	struct svc_export *exp = cd->rd_fhp->fh_export;
 	int start_offset = xdr->buf->len;
 	int cookie_offset;
 	u32 name_and_cookie;
@@ -3629,6 +3630,17 @@ nfsd4_encode_dirent(void *ccdv, const char *name, int namlen,
 	case nfserr_noent:
 		xdr_truncate_encode(xdr, start_offset);
 		goto skip_entry;
+	case nfserr_jukebox:
+		/*
+		 * The pseudoroot should only display dentries that lead to
+		 * exports. If we get EJUKEBOX here, then we can't tell whether
+		 * this entry should be included. Just fail the whole READDIR
+		 * with NFS4ERR_DELAY in that case, and hope that the situation
+		 * will resolve itself by the client's next attempt.
+		 */
+		if (exp->ex_flags & NFSEXP_V4ROOT)
+			goto fail;
+		fallthrough;
 	default:
 		/*
 		 * If the client requested the RDATTR_ERROR attribute,
-- 
2.38.1

