Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5139C621945
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Nov 2022 17:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiKHQXS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Nov 2022 11:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKHQXR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Nov 2022 11:23:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F15A1AE
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 08:23:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBB7AB81BA7
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 16:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156CBC433C1;
        Tue,  8 Nov 2022 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667924593;
        bh=nz5VGkOq8B2GHyY4UZcHdVJ2ElHwQ71fq2QNhGZrjpE=;
        h=From:To:Cc:Subject:Date:From;
        b=cYE5s1yUXJFERYophrNfsSTMpCJm+TPoarNmqwzAEPznyyxESc2+L8hPqQgcs6ScD
         ZQ2Wf8EvTu6jvL/ybGdvA9Xgk4GmktfWHcayMeeLpwB9Bju9iIbDXk6OoW16zodt3m
         lSgQsiPBMiiGGxeoXM8KB6e6VTGbKvzFXetXZpIAzeKFMLnHpkZMxKf+M3t6/RNeV4
         I6oUD5issLrO7LSGXH/SixQ13c6XK6/sKEJGfhJ9Pv4XXOCyKiPlUVXLuexRi9r1g/
         ikx83ThJ5dNLytmioy8FLRFJ8k/COdxfOHYcI3YeulOGnW2j/SydyUwaUPLwi55CU1
         F38tjeT1mLZsw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Yongcheng Yang <yoyang@redhat.com>
Subject: [PATCH] nfsd: put the export reference in nfsd4_verify_deleg_dentry
Date:   Tue,  8 Nov 2022 11:23:11 -0500
Message-Id: <20221108162311.320755-1-jlayton@kernel.org>
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

nfsd_lookup_dentry returns an export reference in addition to the dentry
ref. Ensure that we put it too.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2138866
Fixes: 876c553cb410 ("NFSD: verify the opened dentry after setting a delegation")
Reported-by: Yongcheng Yang <yoyang@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 554c4e50caf8..2ec981fd2985 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5407,6 +5407,7 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *open, struct nfs4_file *fp,
 	if (err)
 		return -EAGAIN;
 
+	exp_put(exp);
 	dput(child);
 	if (child != file_dentry(fp->fi_deleg_file->nf_file))
 		return -EAGAIN;
-- 
2.38.1

