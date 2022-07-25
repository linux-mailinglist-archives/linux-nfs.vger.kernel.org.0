Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6D45805E1
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 22:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbiGYUmg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 16:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiGYUme (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 16:42:34 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880B222BDF
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 13:42:33 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id g1so9615819qki.7
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cfa.harvard.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBgOCZVjCfLSrGPma3nuECbYEVoJ2GP0xe2GTjQBAmA=;
        b=UHWAeq7284Wg5A7tu2wd/NGckBLidB7/OT/bNipjcoWH/fWfSMWvs+8BKYM8hzo7g4
         gKxSUwoHrjymxB134vOfVAaQt7inTe+qwzzgOYScpmUffftMToAxz1v9ieyabqzilqs0
         d8U2bWuUxxsnaYC/5x4X0xs1Hihc4gSvMbPplpIfrxzbN90S9Jcuh8MUI1l5TKfBQwSP
         Cj2oC0u95NNKe4tH1j1mcc6j+kj00QDeLQshDXOwINW6mMvpBaa3efzpo9pYcliQDOB6
         h3KvFg8sqV7oBFJDmui/uwRDV2fwtZxyZUNhyh2GTOeWCCeKaUBM9ZjaRCwMtUE4AGbr
         rFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBgOCZVjCfLSrGPma3nuECbYEVoJ2GP0xe2GTjQBAmA=;
        b=KDHN6ACyhouqqI9KgjqN1qBP0qqJGU6C9TiV9zUaaY+R67EZPYfPz97euz0AkcpTe6
         jlW7UMnm7VyjaDlnjTaJMERRXamKDcxcgyuiAulhDQfihDu/v24zqkWSJZNrNMpK61NE
         ix5Fj0Gr4I7OBOC6+iMQEVOfkrAgM39kA/I7ljGs4CK+CciudNhLBkDy8oO/k2G3puxp
         Da84nslRyOJhWK1X94PK66yGeKtwdWstfYO74XRJK/EmTqHTZnIy7aKB9RaEvTlygO/E
         cQ3ZIbeH9oISuqvlC+Qds8fCGnztK7SAMMsJ4cXmoYFoIR8qktiwLuAWATiv3ysZIkQF
         nNVA==
X-Gm-Message-State: AJIora9IOD8XqyhWIgz4UHeMMuzJq7BXwecash2gGedKiA1Nu7wZM5BH
        NJlZohyoqH/LUiZM6YLzMk47mum2976v6A==
X-Google-Smtp-Source: AGRyM1vLFrJFnhMO64BhW6J+O9Qs2mEg8TnurEF0z+SQ02bWQMi2cW11xJTAAhSbx9bKxq8NBBx3Yw==
X-Received: by 2002:a37:8043:0:b0:6b6:214f:157d with SMTP id b64-20020a378043000000b006b6214f157dmr10334095qkd.371.1658781752531;
        Mon, 25 Jul 2022 13:42:32 -0700 (PDT)
Received: from pihe ([65.112.10.207])
        by smtp.gmail.com with ESMTPSA id a187-20020ae9e8c4000000b006b4689e3425sm9275434qkg.129.2022.07.25.13.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:42:32 -0700 (PDT)
Received: from pihe (localhost [127.0.0.1])
        by pihe (8.17.1/8.17.1) with ESMTPS id 26PG7oct015744
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 12:07:50 -0400
Received: (from pumukli@localhost)
        by pihe (8.17.1/8.17.1/Submit) id 26PG7o7W015620;
        Mon, 25 Jul 2022 12:07:50 -0400
From:   Attila Kovacs <attila.kovacs@cfa.harvard.edu>
To:     Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/2] clnt_dg_freeres() uncleared set active state may deadlock.
Date:   Mon, 25 Jul 2022 12:06:45 -0400
Message-Id: <20220725160646.15610-1-attila.kovacs@cfa.harvard.edu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Attila Kovacs <attipaci@gmail.com>

In clnt_dg.c in clnt_dg_freeres(), cu_fd_lock->active is set to TRUE, with no 
corresponding clearing when the operation (*xdr_res() call) is completed. This 
would leave other waiting operations blocked indefinitely, effectively 
deadlocking the client. For comparison, clnt_vd_freeres() in clnt_vc.c does not
set the active state to TRUE. I believe the vc behavior is correct, while the 
dg behavior is a bug. 

Signed-off-by: Attila Kovacs <attipaci@gmail.com>
---
 src/clnt_dg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/clnt_dg.c b/src/clnt_dg.c
index 7c5d22e..b2043ac 100644
--- a/src/clnt_dg.c
+++ b/src/clnt_dg.c
@@ -573,7 +573,6 @@ clnt_dg_freeres(cl, xdr_res, res_ptr)
 	mutex_lock(&clnt_fd_lock);
 	while (cu->cu_fd_lock->active)
 		cond_wait(&cu->cu_fd_lock->cv, &clnt_fd_lock);
-	cu->cu_fd_lock->active = TRUE;
 	xdrs->x_op = XDR_FREE;
 	dummy = (*xdr_res)(xdrs, res_ptr);
 	thr_sigsetmask(SIG_SETMASK, &mask, NULL);
-- 
2.37.1

