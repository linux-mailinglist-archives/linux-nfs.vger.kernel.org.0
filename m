Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A04332C6E
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 17:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhCIQmm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 11:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhCIQmc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 11:42:32 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F3CC06174A
        for <linux-nfs@vger.kernel.org>; Tue,  9 Mar 2021 08:42:32 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id n132so14638223iod.0
        for <linux-nfs@vger.kernel.org>; Tue, 09 Mar 2021 08:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qaP35OolCuh0JJuDAfWuBYmqQlAoAW6aR7EacpzqKaA=;
        b=kciBaUb60gt6Eogdd9b3P0CQiLWafkrvUDl85pIgLmvPi6JZzcnBiaNnK0iEdhDSdp
         Myw+WHb3tXbkImjjDSRzVnuxuBdUNep5/DDU8K4H53bc8eoKU/71E47qMXVyd3wSiy+Y
         rL9CezCBIWqgepJKmBMhvJlMrmaMTUEpgjjp9ADTUOHXixjgsMYKrrSbDKhznxDR8S/R
         5s245PrD0tebgcpxvkf+rXwwhgIfV4r3bd5+ouFioGQ50okXvEWhMb5W4cQFOoMkbyj1
         +EePjPYkIV+jGWCwY13tLlbAIaB0DzruROUpMspgyHRL9QY6m0LFND2Tgdoumc4GtitN
         41kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qaP35OolCuh0JJuDAfWuBYmqQlAoAW6aR7EacpzqKaA=;
        b=lr5uCj9ZC7b40dyLe8uWlinquzpWHW96s2IoryYhkMC32LRQGBKluOuwzgjcR3/Qcq
         5exlXi5koqV9PwWd+6mBeJmw40e5SWCrwVnAuqtaf4QCwm3+j9EfGkIdPCF5nn0LsCpP
         7jaq8DltCNlP5yMSajhh51YPwWeQqte8wCcVLFUIOF2X9t2+kPyd6Ie/kFIV9v2hNlsv
         v2Ig8Kba14m4NenLZsCGDoeZmELBWoUuv9/KoPM5m0xz8auzUco01olFDNyUQLsbN5lO
         wVoYwPxhtkRErRf7oJL+rBSFU966tvZqDDJBplXH/yV97naaJHqXke5zjpNSDfNEZW7w
         sOeg==
X-Gm-Message-State: AOAM531FaJ+FQR/lOtCkxeJLXfJk1V6hnGRyxiOMdR4E5gNaTEfD2g91
        LcGGqQIR+TWvZ7hK6nwBi88=
X-Google-Smtp-Source: ABdhPJyPKVKqDf7TntFFu+GLTdCNy5nd9D+iqCGyZgVRcp7yBLil+rwScHLErnkElzXKJB8k5gmVhQ==
X-Received: by 2002:a6b:610d:: with SMTP id v13mr23517997iob.132.1615308151506;
        Tue, 09 Mar 2021 08:42:31 -0800 (PST)
Received: from kolga-mac-1.lan (50-124-244-195.alma.mi.frontiernet.net. [50.124.244.195])
        by smtp.gmail.com with ESMTPSA id d3sm8090314ilo.32.2021.03.09.08.42.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 08:42:31 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSD: fix error handling in NFSv4.0 callbacks
Date:   Tue,  9 Mar 2021 11:42:29 -0500
Message-Id: <20210309164229.60153-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When the server tries to do a callback and a client fails it due to
authentication problems, we need the server to set callback down
flag in RENEW so that client can recover.

Suggested-by: Bruce Fields <bfields@redhat.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4callback.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 052be5bf9ef5..f436d2ca5223 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1186,11 +1186,8 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 		rpc_restart_call_prepare(task);
 		return;
 	case 1:
-		switch (task->tk_status) {
-		case -EIO:
-		case -ETIMEDOUT:
+		if (task->tk_status)
 			nfsd4_mark_cb_down(clp, task->tk_status);
-		}
 		break;
 	default:
 		BUG();
-- 
2.27.0

