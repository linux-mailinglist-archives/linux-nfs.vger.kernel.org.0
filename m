Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6645752948
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jul 2023 19:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjGMRCp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jul 2023 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGMRCo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jul 2023 13:02:44 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660AD2701
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 10:02:41 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-345d2b936c2so540855ab.0
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689267761; x=1689872561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wo+TZdf6AKS0RNwecMo4C4DQY633MA6WzwIn1hrEqWI=;
        b=ecgUCbl3Cmn7KMhu1E35OlmWlsnrAlgxGHJ4Fr5eT0AnXTblnGSmUFbOxSoBYDA8Iu
         rsm+OHn9agDb3A+9RA7I3tWBRTU1dCk48M3A+MNWvNeWtEOmN+nFTP6pB5pMfp5h1Icp
         dW32HJ0TM7YcMiXcG9EDu0/ucdVEDRMUPnzvcWJfayNtuqxP1z77El1gaOOtIxfse1vY
         ZhbfYvKNL92V88LL4p50rdd9gTCcHxrNyvop5UL+mIv9SQGq2Q/spOXS5LbaiNuOZBpZ
         vvU8BTvNu6qI/matp0EqJ1b4cvt00yKKnDAmq1atXcUDrl/AnFlOqUV4m/tbBDMAsy6n
         pW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267761; x=1689872561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wo+TZdf6AKS0RNwecMo4C4DQY633MA6WzwIn1hrEqWI=;
        b=MLbQiBch+r53+qcTIzVC1CskXR0sWaU/VzBFrkJWsYTX0DKKiffiy+FAZbX52S3zEB
         Vn7JMHUOmnXXCiM9DMrYUzAT7oR/3Scjd4HqC8JvqxjQkvWn3JWRGWE/UsXOXhz5Wf05
         TON/gG/J+FscNdwKOk+G+onQ8eGe4Tl61gol+5LHB538to51DBn8bd6D36t1WI3clt9p
         VCn3Qx0lP4CpksDER/Ymrygp2hBMPfMRclYpt8FQPlVU4js7hpQ6fST9WEYFo+ZlfWIe
         M7oCvL8LqiUEM0HizJSFZVsXGYJL+ztJWmtw9Vfds/shbeCM6JPIxQ9ipB1ZUAGtKzSx
         1nLw==
X-Gm-Message-State: ABy/qLaSdmBmITzFzxrs3VfRszRED84bWaCEvP00pKQ8uzYP6Lew7MU1
        ra4NnUt7uzYheAARgmA6RpXmGhp2igw=
X-Google-Smtp-Source: APBJJlGEAKmxUhdE5USP+Mw9xFyT0vptO2dIomPydTi9NPs/m8xOeGRmELx44uZPZoFH1+6JS1IEmw==
X-Received: by 2002:a92:c212:0:b0:346:4eb9:9081 with SMTP id j18-20020a92c212000000b003464eb99081mr1420424ilo.3.1689267760635;
        Thu, 13 Jul 2023 10:02:40 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:e116:c73f:66fd:3d1b])
        by smtp.gmail.com with ESMTPSA id 17-20020a0566380a5100b0042b3f0c94d9sm2079396jap.107.2023.07.13.10.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:02:39 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: use EXCHGID4_FLAG_USE_PNFS_DS for DS server
Date:   Thu, 13 Jul 2023 13:02:38 -0400
Message-Id: <20230713170238.23108-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

After receiving the location(s) of the DS server(s) in the
GETDEVINCEINFO, create the request for the clientid to such
server and indicate that the client is connecting to a DS.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4client.c | 3 +++
 fs/nfs/nfs4proc.c   | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index d9114a754db7..27fb25567ce7 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -232,6 +232,8 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 	__set_bit(NFS_CS_DISCRTRY, &clp->cl_flags);
 	__set_bit(NFS_CS_NO_RETRANS_TIMEOUT, &clp->cl_flags);
 
+	if (test_bit(NFS_CS_DS, &cl_init->init_flags))
+		__set_bit(NFS_CS_DS, &clp->cl_flags);
 	/*
 	 * Set up the connection to the server before we add add to the
 	 * global list.
@@ -1007,6 +1009,7 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
+	__set_bit(NFS_CS_DS, &cl_init.init_flags);
 	/*
 	 * Set an authflavor equual to the MDS value. Use the MDS nfs_client
 	 * cl_ipaddr so as to use the same EXCHANGE_ID co_ownerid as the MDS
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e1a886b58354..8edc610dc1d3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8792,6 +8792,8 @@ nfs4_run_exchange_id(struct nfs_client *clp, const struct cred *cred,
 #ifdef CONFIG_NFS_V4_1_MIGRATION
 	calldata->args.flags |= EXCHGID4_FLAG_SUPP_MOVED_MIGR;
 #endif
+	if (test_bit(NFS_CS_DS, &clp->cl_flags))
+		calldata->args.flags |= EXCHGID4_FLAG_USE_PNFS_DS;
 	msg.rpc_argp = &calldata->args;
 	msg.rpc_resp = &calldata->res;
 	task_setup_data.callback_data = calldata;
@@ -8869,6 +8871,8 @@ static int _nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cre
 	/* Save the EXCHANGE_ID verifier session trunk tests */
 	memcpy(clp->cl_confirm.data, argp->verifier.data,
 	       sizeof(clp->cl_confirm.data));
+	if (resp->flags & EXCHGID4_FLAG_USE_PNFS_DS)
+		set_bit(NFS_CS_DS, &clp->cl_flags);
 out:
 	trace_nfs4_exchange_id(clp, status);
 	rpc_put_task(task);
-- 
2.39.1

