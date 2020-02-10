Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4FB6158363
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2020 20:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgBJTQO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Feb 2020 14:16:14 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38757 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgBJTQO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Feb 2020 14:16:14 -0500
Received: by mail-yw1-f68.google.com with SMTP id 10so3953250ywv.5
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2020 11:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wP5YOVIjUJKkKgcFCczFDbdtOGhanuwuabMb8PE+9gM=;
        b=muYkk6iD0s63CwNio7un27SozL0/ereKoBI7rD1jiP1HQI2Euxg4aI8BM1teHumlrc
         tjmyNewXvffNl2aTlqxyH1ndKvhDHUQj5oQ0PqQ9JerbnxeD2YSbAdj9Jy2QfyoKz6TC
         gG4wP7sEqA4IkDp0YHEQ9DytWt73RFbxNjXCiaUTwOtbu/QeMovOUYvqYdqKO6X/sbbW
         o6Jxksm2Ysl2S0o65gjdhi4mwgpOcPNrxZvoQQYDzdbzc60VU4J7VWprGIvi34JQe3te
         3ZYNFXWCWAfHU9hbIWrPVvo6qG9WBU4qfGq29LwfSGDzjiiaA1g8IFeU6gQDlTrpBKFA
         uDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wP5YOVIjUJKkKgcFCczFDbdtOGhanuwuabMb8PE+9gM=;
        b=dAszKNEK/MIfp1uOvvl0p68IrlVWhXXzM3RbduJ7mfGPHZHfOBY+pMW+Qy8YXXTS2J
         qw/thKVF221zfhDLd10FRAK18wCxRpIwdMckqiClyn41ZFuWZ566W90afRUqBpfWGyUm
         EGXmBMsiHmu7j6xu8KheKewFcKG4Z4Cbevm2ekGWEUhT/IWUGlxIzkaOlu8yYiY5lffk
         fgZ7x7aq37tf5drBLNSRYlht0P0gUWaLNCObm40ehAUwl2a6ddHAN7nzIl4Sel+rEev0
         t1P1xjHsWkDi/bQwbO1U3NON/iABXltdQ/nK/7Ch33wlHLWW2lXDIjbRq41vvL9bXBDp
         d7FQ==
X-Gm-Message-State: APjAAAXrh606ij7DQU6usZVkuD46j8MJtSG9P1OKgTS2w8EWcT5iw/4F
        SwHs0jlsBJWxmz+pfqS4KwyX1x2O4Q==
X-Google-Smtp-Source: APXvYqyLOt8lyvdi20M10OtL7xdHzDy/96z6xILqrnv1dNNSsEP0LpwFc6HX8P7x2/RRA00iyTWrFQ==
X-Received: by 2002:a81:52d6:: with SMTP id g205mr2310010ywb.179.1581362171942;
        Mon, 10 Feb 2020 11:16:11 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o4sm660222ywd.5.2020.02.10.11.16.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:16:11 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 8/8] NFS: Limit the size of the access cache by default
Date:   Mon, 10 Feb 2020 14:13:45 -0500
Message-Id: <20200210191345.557460-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210191345.557460-8-trond.myklebust@hammerspace.com>
References: <20200210191345.557460-1-trond.myklebust@hammerspace.com>
 <20200210191345.557460-2-trond.myklebust@hammerspace.com>
 <20200210191345.557460-3-trond.myklebust@hammerspace.com>
 <20200210191345.557460-4-trond.myklebust@hammerspace.com>
 <20200210191345.557460-5-trond.myklebust@hammerspace.com>
 <20200210191345.557460-6-trond.myklebust@hammerspace.com>
 <20200210191345.557460-7-trond.myklebust@hammerspace.com>
 <20200210191345.557460-8-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, we have no real limit on the access cache size (we set it
to ULONG_MAX). That can lead to credentials getting pinned for a
very long time on lots of files if you have a system with a lot of
memory.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 09bcbdc67135..133bf23430e8 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2307,7 +2307,7 @@ static DEFINE_SPINLOCK(nfs_access_lru_lock);
 static LIST_HEAD(nfs_access_lru_list);
 static atomic_long_t nfs_access_nr_entries;
 
-static unsigned long nfs_access_max_cachesize = ULONG_MAX;
+static unsigned long nfs_access_max_cachesize = 4*1024*1024;
 module_param(nfs_access_max_cachesize, ulong, 0644);
 MODULE_PARM_DESC(nfs_access_max_cachesize, "NFS access maximum total cache length");
 
-- 
2.24.1

