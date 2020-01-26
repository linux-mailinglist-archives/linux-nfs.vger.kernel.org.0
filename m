Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9655149D64
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2020 23:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgAZWd2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Jan 2020 17:33:28 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36904 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgAZWd1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Jan 2020 17:33:27 -0500
Received: by mail-yw1-f68.google.com with SMTP id l5so3919931ywd.4
        for <linux-nfs@vger.kernel.org>; Sun, 26 Jan 2020 14:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70ZBGN+N/QUee/VfGr8lfobsKfqqRkcAwoqpkBMlYD8=;
        b=sAF5t3bHuqvI4mWymCyDyvdaY5KJjvEg/mn+nx9E7FI5mUAo/XYdjQ4Ayj62YLqBLq
         VJZfD9HBGdq/aV/aMb9OzWdFJqSDObTSfHKj5v6uiHEEboXo5fDBChaGKV4RPcIDdogD
         OV5mvzmGP4EY5l78G3sW4U9WnjESXb1JJfwxNkDXXyjiTdixzheIgt1/rq0WaUNJy/2Z
         Pn43mx4vTn1oH203d2TwG0MuRby6GCILmGqWet8LyoSo0qMeoEn5cfMbmxBQ1ha0Lfsk
         YGCaI/bPj0xQimCNmTU8DWZiu8siZdIqRGrGeEjhZFDdctdAhHucYrG5wMLkyOAt5+YD
         rAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70ZBGN+N/QUee/VfGr8lfobsKfqqRkcAwoqpkBMlYD8=;
        b=ocIxNL+qa8rQ7iOhQ7z3aWVQ6DiSW9/HB8iXGgusJ5W+2C91AHJ+xEOjrOndVulUBU
         woGycqypsXEvo/jQLPbUaGTQOV9jKfuP4rGiuIANRQyHMi+Nub8j1OFm7uprjlfrDtK+
         rAk+0u2oh7LoNMFbuUt86rW7qAqhq2kVFMDXL74g7Wgl7KaxgPB8N+15EnaKShT4rraU
         lnJlX3OVVXms2oRce8vTaMrXSg4yfyz0QV+Nqm1F39qtfJlRtW0B6eC6GA1kL1LqS7yd
         3FlxMgSdzCIfWrj8K8HerLbCmnU/LpLki6FJ3ulpp1bTo+DrYhxoxFKjgf8e9GGQ411S
         ua+A==
X-Gm-Message-State: APjAAAVoKinElzZZyyCDcxsxTJBKVEicVL8yUpy7vDt9QdFTjXUEoAfG
        yg3GjJ+K88Mn4xHVH5+gXQ==
X-Google-Smtp-Source: APXvYqwW/2blSiG3geVJaytpEAF9cH/IbwaYOXd7+k6mUQRDJQj9OspXxlozhAyH7ZhKrBunmJGmCQ==
X-Received: by 2002:a0d:ffc2:: with SMTP id p185mr9968268ywf.256.1580078006842;
        Sun, 26 Jan 2020 14:33:26 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id d66sm4233951ywc.16.2020.01.26.14.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 14:33:26 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: nfs_access_get_cached_rcu() should use cred_fscmp()
Date:   Sun, 26 Jan 2020 17:31:14 -0500
Message-Id: <20200126223115.40476-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200126223115.40476-1-trond.myklebust@hammerspace.com>
References: <20200126223115.40476-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We do not need to have the rcu lookup method fail in the case where
the fsuid/fsgid and supplemental groups match.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index bfc66f3f00e1..6427a8a8d61a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2360,7 +2360,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	lh = rcu_dereference(nfsi->access_cache_entry_lru.prev);
 	cache = list_entry(lh, struct nfs_access_entry, lru);
 	if (lh == &nfsi->access_cache_entry_lru ||
-	    cred != cache->cred)
+	    cred_fscmp(cred, cache->cred) != 0)
 		cache = NULL;
 	if (cache == NULL)
 		goto out;
-- 
2.24.1

