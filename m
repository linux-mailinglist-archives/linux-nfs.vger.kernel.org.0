Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179FE3B4F66
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jun 2021 18:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFZQMZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Jun 2021 12:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFZQMY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Jun 2021 12:12:24 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AD0C061574
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:10:01 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o6so22577128qkh.4
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jun 2021 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NxI2is3Iv3dnXBkmQ7htNCEMaScbMxxzbk1XUvUBKfw=;
        b=h00eHusbwN3I4AXlLayN94SErEp7Y/DgVWm8hbTBX7HzESUfb3IvJoY6lCjUxG3vjM
         mC3ULzmc4Z36LEb/lxHSYhy7MGTtcROfw/ltR8LTIdXYuRB7d1U30+K72sscPZLuafbw
         7qwsPXeO8+YgFE6hgVQ3wW7V+b6pb8h4OW3SkYi8iohRvADzWYc44oycn9xr08nAS/Rt
         eMoE9GnYi/G5BxBHVmQIOLbnPpPeqvrbF+G+G+yAhqBkfrS+/2vOC0w47vqfpveiVBLh
         ZcRp8RqzKqZadqKlS0L0MwLO93n8isRcFMQV2Iz9+XjARJT/3RJ6pWu65u/v3kTdJlyd
         KXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxI2is3Iv3dnXBkmQ7htNCEMaScbMxxzbk1XUvUBKfw=;
        b=COZCbF9kLrY4gm6XZScTlEFOLovj4havXsJlIkeYI8kXMKpv56Agp7QfYHCqMibmsQ
         Cks3/oSsk/KLOPY3ceSR7mxeTYuMEV1vJ2pfaBsX1iFh3l6t2U8LNP93RznrSKkEjrOV
         BPgyuv9tqtjXAzhlUrma0daxqq3Kr261wHcZmU0sZhMxjN/3AsQE/J1fPDeMc9s0IEhy
         wdK3i1I/XGwLFgY5yKfsO6D6yE/kZmSuj/V6hNhsvnXg0fiRV91P732hZqaB25jg5cwf
         XYevAgb8MqwTMTK/Dj1MWHZerQzHayPjCoR3d5u2ci9Rms4WNNXWwM/BamsF+EOuX65j
         GOpA==
X-Gm-Message-State: AOAM532QJaCu/qOyodAP+viwcaibYhLFrk0NErUOfB5LU7MciBBapRjL
        o30VIb3IW8yM79KYuL1Hrbd48oerhwmW
X-Google-Smtp-Source: ABdhPJxbM2VJs2b+Jl4b1A7Ej1pwKXji4wq/mE/iZRh8bCXKQrIjRu35B9pTGRgg43Cfm1Sr73MunQ==
X-Received: by 2002:a05:620a:109a:: with SMTP id g26mr17026131qkk.450.1624723800351;
        Sat, 26 Jun 2021 09:10:00 -0700 (PDT)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id s8sm2995141qke.72.2021.06.26.09.09.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 09:09:59 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4: Just don't cache negative dentries on case insensitive servers
Date:   Sat, 26 Jun 2021 12:09:56 -0400
Message-Id: <20210626160956.323472-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210626160956.323472-2-trond.myklebust@hammerspace.com>
References: <20210626160956.323472-1-trond.myklebust@hammerspace.com>
 <20210626160956.323472-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the directory contents change, we cannot rely on the negative dentry
being cacheable.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1a6d2867fba4..eda0d816cbd1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1438,6 +1438,9 @@ int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry,
 		return 0;
 	if (NFS_SERVER(dir)->flags & NFS_MOUNT_LOOKUP_CACHE_NONEG)
 		return 1;
+	/* Case insensitive server? Revalidate negative dentries */
+	if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
+		return 1;
 	return !nfs_check_verifier(dir, dentry, flags & LOOKUP_RCU);
 }
 
-- 
2.31.1

