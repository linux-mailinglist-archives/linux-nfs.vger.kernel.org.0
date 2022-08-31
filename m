Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179615A7FF9
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 16:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiHaOUN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 10:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiHaOUL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 10:20:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B1212767;
        Wed, 31 Aug 2022 07:20:08 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z187so14531714pfb.12;
        Wed, 31 Aug 2022 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=r5FNvAArY6+DdrbAQV5xtFM8Ev5kRn4IOzR0SYGzbj0=;
        b=mq0v4aefcKxyHDKOrJY7nVXJonHJdssNVod4gMrwThyeGIzUXie3BRr754Ir8/Acas
         IM6HYsYuTSvt2fp/NT37jDmpOLjpa2cY7gMbD1K5iXq/eyVQU3Ryg8sfOz2Eq3775Duh
         8O9nO5tlAOEZxA2l6UCKQH1UO/6+HCSUv/heJ6Eg4dhBwD27YOKXktCrwDiYtOMG42TI
         uez1usV9liro/wQYzkci59J7kqtZQoLUaS+N13yTp17pccK5qOKIHDxQCbadKzVklyI8
         QYQsIHpl2Bb1brStypWoi15y72tr6FvcZn0+JF+NB1MpXspcou16gIyADO7VH2N3UeRT
         JP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=r5FNvAArY6+DdrbAQV5xtFM8Ev5kRn4IOzR0SYGzbj0=;
        b=L70WePOkosG8T3SPjYWuElEnJwOXauhqYpwJjxNe1XGY9N50ra2iy9o5tgRb8Lgypa
         8HrMsdKMOASShg3lg+LNel76fFVumJ04LMPvAnCF0aICHYnP6CMF14N5yc4henGWOya9
         g+bjD4espDLtR54VcL4BrlWMgWcbJDtYH5YcXKrLoCZ4zN+bW8osACjHsxTXaE7Wo+9J
         TUfXydNkG7bcttneeJwdtZAQU/WhY3vGzYMSCaHPAKLORssh1PnJgy1jXtThjL9Bj2Gs
         VEO2ZxdxWQ7HBTq3QT5L9Pdeh3SOh7LP7FkeJQ3kwsvmK9UIEjx7v3kRIVbrF9wwKixj
         6hhg==
X-Gm-Message-State: ACgBeo3uhDx7nBR6/KJqzGc+zkQFWKS+yU7w774pD2A6qusfpdy12qn2
        qtuJ3ZWngq4sRgr70XC+rAk=
X-Google-Smtp-Source: AA6agR6RNWAuJ0eD9Dee7RHzeg1Cu4VYl42HG/gjhcJFDDUJwfX+y9F5CMTkRgA0RhjORZ4aAYpMAA==
X-Received: by 2002:a65:6c10:0:b0:41b:ab8f:ff71 with SMTP id y16-20020a656c10000000b0041bab8fff71mr21921409pgu.308.1661955608030;
        Wed, 31 Aug 2022 07:20:08 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a990100b001fdcfe9a731sm1342117pjp.50.2022.08.31.07.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 07:20:07 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] NFSD: remove redundant variable status
Date:   Wed, 31 Aug 2022 14:20:02 +0000
Message-Id: <20220831142002.304176-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Return value directly from fh_verify() do_open_permission()
exp_pseudoroot() instead of getting value from
redundant variable status.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 fs/nfsd/nfs4proc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 757d8959f992..7055e1c91d0e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -141,7 +141,6 @@ fh_dup2(struct svc_fh *dst, struct svc_fh *src)
 static __be32
 do_open_permission(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open, int accmode)
 {
-	__be32 status;
 
 	if (open->op_truncate &&
 		!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
@@ -156,9 +155,7 @@ do_open_permission(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfs
 	if (open->op_share_deny & NFS4_SHARE_DENY_READ)
 		accmode |= NFSD_MAY_WRITE;
 
-	status = fh_verify(rqstp, current_fh, S_IFREG, accmode);
-
-	return status;
+	return fh_verify(rqstp, current_fh, S_IFREG, accmode);
 }
 
 static __be32 nfsd_check_obj_isreg(struct svc_fh *fh)
@@ -454,7 +451,6 @@ static __be32
 do_open_fhandle(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, struct nfsd4_open *open)
 {
 	struct svc_fh *current_fh = &cstate->current_fh;
-	__be32 status;
 	int accmode = 0;
 
 	/* We don't know the target directory, and therefore can not
@@ -479,9 +475,7 @@ do_open_fhandle(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, str
 	if (open->op_claim_type == NFS4_OPEN_CLAIM_DELEG_CUR_FH)
 		accmode = NFSD_MAY_OWNER_OVERRIDE;
 
-	status = do_open_permission(rqstp, current_fh, open, accmode);
-
-	return status;
+	return do_open_permission(rqstp, current_fh, open, accmode);
 }
 
 static void
@@ -668,11 +662,9 @@ static __be32
 nfsd4_putrootfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
-	__be32 status;
-
 	fh_put(&cstate->current_fh);
-	status = exp_pseudoroot(rqstp, &cstate->current_fh);
-	return status;
+
+	return exp_pseudoroot(rqstp, &cstate->current_fh);
 }
 
 static __be32
-- 
2.25.1

