Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CCB752B3F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jul 2023 21:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjGMTyV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jul 2023 15:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjGMTyU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jul 2023 15:54:20 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EF11BEB
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 12:54:18 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-785d3a53ed6so13710639f.1
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 12:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689278058; x=1689882858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c60Mg0p3hGYklaicOReAWS1Ob8XDdVbh//WtK15Mp70=;
        b=emv7VEO/lDz+ymw3Pzh9qHBVCGoJ/ik+H55ylnxE1bBULrqdPdlO5W8Buacj84jVFK
         lp0j0RShRWmZcm8Fclir0HxFZE1sQ3wy2+qIxdXbMkupMYbsL1h8WaS2nkR5zHmQVyRS
         IPOa3NcR7T3iyNvSdgLleoNhNzB87owxfw91nWoXGUQAabyy4x/R/z2ucxgE9alYV+cE
         /SvfccUEyUYLhFqa8p0ZmZ3LCpKSVRoYSVHdJfs+2QlWAOMrpcDtcKPWyBD6eMv/FsAC
         sz9NP7zO9wGJSOO9QpPOP215r/9tTRhD/LvlaIShbO9tLdhUGzNxaKImdjst4vEtCW0W
         UhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689278058; x=1689882858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c60Mg0p3hGYklaicOReAWS1Ob8XDdVbh//WtK15Mp70=;
        b=WLeovITLst5b7Ou/ZkYRFhxrtZKJgj2w+UN0XM7CINwFSUXWhcpYo4udxrgUN3ogi0
         xBl4rtKpxh408kLz5E4cXIzTyaDgEvsRWa8U6XSmn92dMU2y4nUyFD1xPtBdjXCySu/F
         GuNbkt2MPPTYkHDspSgccga8UAVSbPrzWNowJlEyGOskXcottJcQ1PhLKaQvVGrMKffk
         pzOgI2j7+Y+Ii1cGqbqFlZzDZDSNHJ5ekHsrYSL/lR3ryetRdfQvFwkJ28vVizNDbU23
         sERvxwalU0eYv0RvQ8aNO+5GH6UVQ0FMGcpRHpdV1zp2Tg1wEZ+syPYsSpAJ+y2foMwV
         pudw==
X-Gm-Message-State: ABy/qLbGy36gpwSBWXRR4L6P2xUjg3pujEnSUFR79bjUX9E5mrHlnP8Y
        MhjvoZV1yWU1+nOiLRXOMrU=
X-Google-Smtp-Source: APBJJlEHYNfP5PtHrN+K1Jt8uGsQVF4nPTjYgCOJLhTemhANbw55r603+PKb1GghR7XDBKxVzPvGAg==
X-Received: by 2002:a05:6602:2762:b0:780:d65c:d78f with SMTP id l2-20020a056602276200b00780d65cd78fmr2906083ioe.2.1689278057908;
        Thu, 13 Jul 2023 12:54:17 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:e116:c73f:66fd:3d1b])
        by smtp.gmail.com with ESMTPSA id f2-20020a056638118200b0042b2cecd3cfsm2107203jas.29.2023.07.13.12.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 12:54:17 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: fix zero value filehandle in post open getattr
Date:   Thu, 13 Jul 2023 15:54:16 -0400
Message-Id: <20230713195416.30414-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Currently, if the OPEN compound experiencing an error and needs to
get the file attributes separately, it will send a stand alone
GETATTR but it would use the filehandle from the results of
the OPEN compound. In case of the CLAIM_FH OPEN, nfs_openres's fh
is zero value. That generate a GETATTR that's sent with a zero
value filehandle, and results in the server returning an error.

Instead, for the CLAIM_FH OPEN, take the filehandle that was used
in the PUTFH of the OPEN compound.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 8edc610dc1d3..0b1b49f01c5b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2703,8 +2703,12 @@ static int _nfs4_proc_open(struct nfs4_opendata *data,
 			return status;
 	}
 	if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
+		struct nfs_fh *fh = &o_res->fh;
+
 		nfs4_sequence_free_slot(&o_res->seq_res);
-		nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr, NULL);
+		if (o_arg->claim == NFS4_OPEN_CLAIM_FH)
+			fh = NFS_FH(d_inode(data->dentry));
+		nfs4_proc_getattr(server, fh, o_res->f_attr, NULL);
 	}
 	return 0;
 }
-- 
2.39.1

