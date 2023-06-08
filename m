Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED77B728324
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jun 2023 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjFHO6G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Jun 2023 10:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbjFHO6F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Jun 2023 10:58:05 -0400
X-Greylist: delayed 483 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Jun 2023 07:58:03 PDT
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [IPv6:2001:638:700:1038::1:9c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6DD1FFE
        for <linux-nfs@vger.kernel.org>; Thu,  8 Jun 2023 07:58:03 -0700 (PDT)
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [131.169.56.166])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 03D2F6080E
        for <linux-nfs@vger.kernel.org>; Thu,  8 Jun 2023 16:49:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 03D2F6080E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1686235797; bh=EoygC3UwgPv0k+4St30V54OcFcr1iVnkdlE4VkvPQ5I=;
        h=From:To:Cc:Subject:Date:From;
        b=IpAWSdzFKSkAQsOTYVqA9bDewEtX0tNPB0X9iL1d6TqKjQCsywj5ATzlDwIXkeCR6
         jAJt8xVjQkIfZomr+kBJZ3XC5DGvyrrFNi/iub6wPe7q9trsh9sZ1YApL9BS+SJXD+
         XNeSjq24xmz9mUSm6h/+SLr4isjXaiRdYYI2m4mE=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [131.169.56.131])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id EE8DEA00B3;
        Thu,  8 Jun 2023 16:49:56 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
        by smtp-m-3.desy.de (Postfix) with ESMTP id E57B260211;
        Thu,  8 Jun 2023 16:49:56 +0200 (CEST)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=131.169.56.83; helo=smtp-intra-2.desy.de; envelope-from=tigran.mkrtchyan@desy.de; receiver=<UNKNOWN> 
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [131.169.56.83])
        by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 2C3A1220043;
        Thu,  8 Jun 2023 16:49:56 +0200 (CEST)
Received: from ani.desy.de (zitpcx21033.desy.de [131.169.185.213])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 142B0100077;
        Thu,  8 Jun 2023 16:49:56 +0200 (CEST)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] nfs4: don't map EACCESS and EPERM to EIO
Date:   Thu,  8 Jun 2023 16:49:33 +0200
Message-Id: <20230608144933.412664-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

the nfs4_map_errors function converts NFS specific errors to userland
errors. However, it ignores NFS4ERR_PERM and EPERM, which then get
mapped to EIO.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 fs/nfs/nfs4proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d3665390c4cb..795205fe4f30 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -171,12 +171,14 @@ static int nfs4_map_errors(int err)
 	case -NFS4ERR_LAYOUTTRYLATER:
 	case -NFS4ERR_RECALLCONFLICT:
 		return -EREMOTEIO;
+	case -NFS4ERR_PERM:
 	case -NFS4ERR_WRONGSEC:
 	case -NFS4ERR_WRONG_CRED:
 		return -EPERM;
 	case -NFS4ERR_BADOWNER:
 	case -NFS4ERR_BADNAME:
 		return -EINVAL;
+	case -NFS4ERR_ACCESS:
 	case -NFS4ERR_SHARE_DENIED:
 		return -EACCES;
 	case -NFS4ERR_MINOR_VERS_MISMATCH:
-- 
2.40.1

