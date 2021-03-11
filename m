Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C0D33788B
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Mar 2021 16:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbhCKPzH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Mar 2021 10:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhCKPzD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Mar 2021 10:55:03 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A107EC061574
        for <linux-nfs@vger.kernel.org>; Thu, 11 Mar 2021 07:55:03 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id g27so22438769iox.2
        for <linux-nfs@vger.kernel.org>; Thu, 11 Mar 2021 07:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+Pxbk1TXPSmNzj4flwxE5qc7/OCrK9FlcQ2xhPjIRI=;
        b=azDheVsdh8Ih1rZeFWmfxrfTlW68VbkU77C6JnSXvPsouDyNkpfo3KedgWfKE8uV8y
         C+bSge9yuscAsibLRMcyRmr0vh2odMtS0LMECxsQUMRH+fBKK/I8kezLoLERHbVweShj
         nac782pXZVdbbw+5/BY0bi2XBq1CdLxUK/tos1QKwNxn2qfNpV8pxtMgtVvoStqOJJVf
         NIk7PDvJMN9xDw+1ZBaA7TJ1HXYtpv7PAlaFlDiYqQGIn1d2iX4aEmGF9/Bk+bNtoSTx
         1mWv8I2kok6Qaq59fC/IXHzNiO0+EcobPpgWGMkTyxINpcKx+tIkCu2aLmWWrAOIYXMY
         3i4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+Pxbk1TXPSmNzj4flwxE5qc7/OCrK9FlcQ2xhPjIRI=;
        b=ptUiDbnvE9qroRkOB2AQF8j8NOOHBGsjO2N2CHlDDdYQZW5BV1/7weU6Cf7ZX8kAAd
         Sl3/6YW4M2csQFCCZWOEStKYKys860QTqITc4SQpPHQiowU7JDvVceziqsPS/TeHf0U0
         MRWwxb+6OFxrcba1JRFOJlt7P7xASud6D+1VZoguQ6WhnvrRq3do/2M6nRYaZUzeGTNx
         G+BYdzHqdudYVbXvn9kLob9FsKIsDD7j64QrL9QM0vY3hze0XwFISWrZbENnKIGDFkr7
         BBGHvw5Qj+goodGesaGC1uvqVbwoKW9AG4QuJg7knEZ+ICswes5mK4f5A4NUEwOcilGB
         E5zA==
X-Gm-Message-State: AOAM530WBlPSPcIDFa2emrk6e7HONKwN8QbTTkyNkQfR35GvXM2n5rRA
        r71DZJ1nK1CYI2PejIypzbIVFz5XS0k=
X-Google-Smtp-Source: ABdhPJzCq/dYHDfj54dA7JjmqLx5+rDIp2yK59zGQvfIsNX4GdC8A2UpRTKC9lEzp6fgB8a7i89cfA==
X-Received: by 2002:a05:6638:614:: with SMTP id g20mr4263650jar.85.1615478103055;
        Thu, 11 Mar 2021 07:55:03 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:9d25:d302:519b:843b])
        by smtp.gmail.com with ESMTPSA id b19sm1546256ioj.50.2021.03.11.07.55.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 07:55:02 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/1] NFSD: fix error handling in NFSv4.0 callbacks
Date:   Thu, 11 Mar 2021 10:55:00 -0500
Message-Id: <20210311155500.14209-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

When the server tries to do a callback and a client fails it due to
authentication problems, we need the server to set callback down
flag in RENEW so that client can recover.

Suggested-by: Bruce Fields <bfields@redhat.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4callback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 052be5bf9ef5..7325592b456e 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 		switch (task->tk_status) {
 		case -EIO:
 		case -ETIMEDOUT:
+		case -EACCES:
 			nfsd4_mark_cb_down(clp, task->tk_status);
 		}
 		break;
-- 
2.18.2

