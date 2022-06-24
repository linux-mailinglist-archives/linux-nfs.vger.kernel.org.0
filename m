Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3699F559D94
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jun 2022 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiFXPrl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jun 2022 11:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiFXPrl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jun 2022 11:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C584ECDE
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jun 2022 08:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC6546223F
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jun 2022 15:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A035AC34114;
        Fri, 24 Jun 2022 15:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656085659;
        bh=TS+CxZ0WqrhvWZjuAMgnLJ6o6ro4DxzTwBC26BXgoHs=;
        h=From:To:Cc:Subject:Date:From;
        b=GDkiBTZQl0i44Fl4HEYoQM26C8mTfVQ/oU0VslBoNd1jTk+VAKEi6IoIawFFxgW8I
         y0fMndcnrlnQAmLUGR3hu7IZX9I/k1299O/NwC4iDfhMiU+H8LJB5Hr6WiwhycKGY+
         /7DsbEel5TE4AtUF5kL0wQvBfFvWZ5w9ck4i1cDY1z+V3Q7oQlcpS22zXrAEChGtjq
         WhHPPfvzX7MXvX2H0m6DfkvF8jXw1/jXx6XyQEzoiihFl21dKHh8IBfdWI24c2CmFV
         jF1XYfSBoAGsZybIOMTMOBmUZr2Jq4Xvl2gg7YXgZ9Od+c4Rtn5tQXSqd1EqbgTDU0
         RthRFPl1GnMVQ==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org, bfields@fieldses.org
Subject: [PATCH] NFSD: Don't continue encoding if READ_PLUS gets confused
Date:   Fri, 24 Jun 2022 11:47:37 -0400
Message-Id: <20220624154737.1387850-1-anna@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

If we were in a HOLE segement, but vfs_llseek() claimed we were encoding
DATA then we would switch over to the DATA encoding function. This
conflicts with Chuck's latest xdr cleanup patches and can result in a
crash or silent hang. Let's just return nfserr_io if we find we are in
this situation, which will cause the encoder to return to the client
with the number of segments already encoded. The client can then try the
READ_PLUS call again.

Fxes: 6c254bf3b637 (SUNRPC: Fix the calculation of xdr->end in xdr_get_next_encode_buffer())
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 61b2aae81abb..dc97d7c7e595 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4792,7 +4792,7 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
 	if (data_pos == -ENXIO)
 		data_pos = f_size;
 	else if (data_pos <= read->rd_offset || (data_pos < f_size && data_pos % PAGE_SIZE))
-		return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size);
+		return nfserr_io;
 	count = data_pos - read->rd_offset;
 
 	/* Content type, offset, byte count */
-- 
2.36.1

