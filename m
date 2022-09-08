Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3BE5B2025
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 16:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiIHOI7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 10:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiIHOI6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 10:08:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF489127559
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 07:08:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t7so21274930wrm.10
        for <linux-nfs@vger.kernel.org>; Thu, 08 Sep 2022 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=8YnQEsscvKc28+zcOfN5pH9qM6bALACDRIpMy9+L00A=;
        b=ZlsujZ+MVA5TF4XzhnjEzHs0OOdSBx30rNuwHZ64ZZL04BruP1m2ITcFkoJRFq+4Tt
         ECvzG3vJmaegE1dLTlJ7k5zRXzTE0AIVOosohguG1r74EpQjqp0sjz1VRcTgXvpvNbj7
         hMCNP3U7gNCDQbfB4HBVCrjhLompyTxgjyFaY94r+gfUAZqBYl0Pnk7PnlP1+jWeJVhL
         NpEkNJlS1Lsvnrn3dH9+Ifnloxyn1vHfINROjJF7sU+b9qu4huYaUtdaqZQ8WhzAsmTg
         6PDpEHWdc/a3PE7S5GNjWZ22ZfFlFpIyy1QvXl+/6HKJjMEJpdvdn1iMmKiv4Qt5CYZO
         db7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8YnQEsscvKc28+zcOfN5pH9qM6bALACDRIpMy9+L00A=;
        b=NySsTYwtAugS52XJJkCgngObKlCaks46EGkFEqMUfvi/tOwZGNmdx425bW5GtGaI7B
         u0X4eBqQqRABNCpKfYE03Ak7zM/UxVM523sTmW7Kl+xc7fpyhA4ZVUCGtjS7VdJAdmpA
         JQta6IPNwvhb7xPVmFBcjBTxzJhiAhrw2gAk/Kb/OsFRWeFwAr63MYUSKVAltr2hb+Za
         lUREquXNmAVx7TQ+iNhJxMI8AazKODVArESTP+bGjNMzsebxSpGJELliYZIX/lAhzTNI
         NKQZRxHoIBMSzJcIUKC6bon9eM3GPg6oUq+zekPzP9TkQJjPQClyPaE2A8H5L7PBWO0E
         tYIQ==
X-Gm-Message-State: ACgBeo2Y1qInWmxcb5yg62whlKwE0EwMM5pAEtQzO0H1LE0UmBvrJPS7
        CdoRtK7R28h+WXO7SKa2JlAzoioE/r0hBA==
X-Google-Smtp-Source: AA6agR6NK7D0fcg9Au2uYJ3spymsBBhMUMEksWSaD/8R0Vydtn5p4VLOV3BDGflrIdBecVqD9kZmRg==
X-Received: by 2002:a5d:6245:0:b0:225:3e24:e5b1 with SMTP id m5-20020a5d6245000000b002253e24e5b1mr5365346wrv.698.1662646135390;
        Thu, 08 Sep 2022 07:08:55 -0700 (PDT)
Received: from jupiter.vastdata.com ([2a00:a040:18b:8f8c:d66e:eff:fee1:90a8])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm15387538wrc.41.2022.09.08.07.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:08:54 -0700 (PDT)
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] Revert "SUNRPC: Remove unreachable error condition"
Date:   Thu,  8 Sep 2022 17:08:51 +0300
Message-Id: <20220908140851.1111552-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This reverts commit efe57fd58e1cb77f9186152ee12a8aa4ae3348e0.

The assumption that it is impossible to return an ERR pointer from
rpc_run_task() no longer holds due to commit 25cf32ad5dba ("SUNRPC:
Handle allocation failure in rpc_new_task()").

Fixes: 25cf32ad5dba ('SUNRPC: Handle allocation failure in rpc_new_task()')
Fixes: efe57fd58e1c ('SUNRPC: Remove unreachable error condition')
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 net/sunrpc/clnt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 7d268a291486..c284efa3d1ef 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2873,6 +2873,9 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 
 	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_ASYNC,
 			&rpc_cb_add_xprt_call_ops, data);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
 	data->xps->xps_nunique_destaddr_xprts++;
 	rpc_put_task(task);
 success:
-- 
2.23.0

