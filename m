Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B874A66E84C
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jan 2023 22:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjAQVSC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Jan 2023 16:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjAQVRJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Jan 2023 16:17:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C6E4B8A6
        for <linux-nfs@vger.kernel.org>; Tue, 17 Jan 2023 11:38:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E96FEB81331
        for <linux-nfs@vger.kernel.org>; Tue, 17 Jan 2023 19:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29643C433F0;
        Tue, 17 Jan 2023 19:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673984314;
        bh=6BqqGRpNk8STl+XORN7sXJknHb7+UR5U39I2avkv/6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uH5gJalco4aspg5xWpYt4xgk4Tpx9WfXjKYKPruKmK9f9mAHqXAqURERj1IErmZtE
         EUA6/ogtIptTd5MLPs0cPYxrmB2vjpnEJorubL35xuThkVYPLAINfaajCItMvgqqlf
         EJWKymlLktdDL9huyx/9K66N4CmxS+kS+Pvba4dSdEtnYgayC23aiFM5r0ftPhM3L+
         gWikqPmKZ8NU8MarwM1MeBwPcke/kWa9FpBB0nrvQyzcBh0EL0kqderTPSOepVPAyP
         0zKC0o1hRAQPXeqlD67pP8KDktRpPuVqGGMq4/8/cOrGoagTiovbT74RoAyUUIqNS4
         CoinfzAW7/qgA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, dai.ngo@oracle.com, aglo@umich.edu
Subject: [PATCH 1/2] nfsd: zero out pointers after putting nfsd_files on COPY setup error
Date:   Tue, 17 Jan 2023 14:38:30 -0500
Message-Id: <20230117193831.75201-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117193831.75201-1-jlayton@kernel.org>
References: <20230117193831.75201-1-jlayton@kernel.org>
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

At first, I thought this might be a source of nfsd_file overputs, but
the current callers seem to avoid an extra put when nfsd4_verify_copy
returns an error.

Still, it's "bad form" to leave the pointers filled out when we don't
have a reference to them anymore, and that might lead to bugs later.
Zero them out as a defensive coding measure.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index dbaf33398c82..37a9cc8ae7ae 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1214,8 +1214,10 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status;
 out_put_dst:
 	nfsd_file_put(*dst);
+	*dst = NULL;
 out_put_src:
 	nfsd_file_put(*src);
+	*src = NULL;
 	goto out;
 }
 
-- 
2.39.0

