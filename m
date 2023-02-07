Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B268DF72
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Feb 2023 18:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjBGRyF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Feb 2023 12:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjBGRyD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Feb 2023 12:54:03 -0500
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 09:53:57 PST
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F12C6
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 09:53:57 -0800 (PST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
        by smtp-o-2.desy.de (Postfix) with ESMTP id B6F2F1610D9
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 18:46:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de B6F2F1610D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1675792000; bh=eePQpZI6P9LnzN/JZTOx8/SYciN1D3C63B7zosi3VSI=;
        h=From:To:Cc:Subject:Date:From;
        b=TrKr3Mx0nHu6rBTrPjotPzN82htp3/O6/B/ktOX1nGkUp3HxdqOEBACAU+3dLGx2o
         hbQ2XOENXlzT7k6yejN+IPFncn066q4v1g3xtroG8Mepj3a3ijhwItSBHtkUWgAhoZ
         AT7SQxQy0wn0U0Mu8ywSWWz5B9hLqXefxWbzbiNw=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id ABEF41A00F5;
        Tue,  7 Feb 2023 18:46:40 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
        by smtp-m-2.desy.de (Postfix) with ESMTP id A5D73120131;
        Tue,  7 Feb 2023 18:46:40 +0100 (CET)
Received: from nairi.fritz.box (VPN0164.desy.de [131.169.253.163])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 64F94100077;
        Tue,  7 Feb 2023 18:46:40 +0100 (CET)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     linux-nfs@vger.kernel.org
Cc:     anna@kernel.org, trond.myklebust@hammerspace.com,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] nfs42: do not fail with EIO if ssc returns NFS4ERR_OFFLOAD_DENIED
Date:   Tue,  7 Feb 2023 18:46:35 +0100
Message-Id: <20230207174635.348527-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The NFSv4.2 server even if supports intra-SSC might prefer that for
a particular file a classic copy is performed. As returning ENOTSUPP
will clear the SSC capability of the server by the client, server
might return NFS4ERR_OFFLOAD_DENIED (well, spec talks about remote
servers there).

Update nfs42_proc_copy to handle NFS4ERR_OFFLOAD_DENIED as ENOTSUPP,
but without clearing NFS_CAP_COPY bit.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 fs/nfs/nfs42proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index ecb428512fe1..93e306bf4430 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -460,7 +460,8 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 
 		if (err >= 0)
 			break;
-		if (err == -ENOTSUPP &&
+		if ((err == -ENOTSUPP ||
+				err == -NFS4ERR_OFFLOAD_DENIED) &&
 				nfs42_files_from_same_server(src, dst)) {
 			err = -EOPNOTSUPP;
 			break;
-- 
2.39.1

