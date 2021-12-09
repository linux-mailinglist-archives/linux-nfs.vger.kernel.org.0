Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876F446F450
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 20:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhLIT5Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 14:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhLIT5N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 14:57:13 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D5FC061746
        for <linux-nfs@vger.kernel.org>; Thu,  9 Dec 2021 11:53:39 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 14so7956242ioe.2
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 11:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wETAeGy7W2wwlJkHGrZYM2gQKo8gGqneSHIIprrf6UU=;
        b=HRcZ/zAYzCuhD0jX9SBmaA4kH2Vh4KaE3odamnrLBvXNKR5FWaBIGH/z9LZgsvHvl/
         8qRkJQTPiopHOXrKtwvcRbaTI9Tz3CAKQtAwTuvitB1w9SdNnTfgXbSTi4rtzaFKblxx
         qymlqXnDvJDBosoZA9ut9nmcyVDd+iQTa+1/HnTEDKY79IP6cBx6MP3GtdhOrMwHgdJP
         Dn45SzaGuZm/iNfpqb0DMtRDE9HJ3hFcq0HcotqHNj8hBIy5lwKrbfDqem58vc7TGXnt
         0fh2j3G7TTDRqThY93Y6CzA3TP5ijYgLJ7kIBVchyLc35IjKM5FzhBLdq4xV5uHX4+/H
         nyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wETAeGy7W2wwlJkHGrZYM2gQKo8gGqneSHIIprrf6UU=;
        b=diNKhudyBu7pvV2CcCeR8o1QCxXkr/XU4yiIDfTPsujFOmOQvxOd5OQKuVLutAvrvg
         Ki7m27gr0t9w4a2WBytAAwmhGdsheDX7RSv45oEm5PW+/vw40P4LbRFXU03ZRHFurq+u
         S8mUcd9TrPLHvOXVfvcRIB/OGKuWhHpyRdoqimyxEj4FPOazeccHR7qvjXJyAwbjB0nj
         jFaBVFwAhQGa1cdmgjCmiePF5+cez/QWO8L6LxhjYspfMdr/4DrKXN3mULR80Rc2M4CA
         DC7NPvmMXsLhmbsl+qC0NJRh5K+Icx34/uHQFsv7XrguTNMOe/b/K0DsaZb0v8OQMIk5
         r1tA==
X-Gm-Message-State: AOAM532SB3kbH0g4F9EyHXtkgPXyxUzbSSAmMxYMAR1X25qorwaOy7/k
        PFMD9IXe9nhSQlR9tBwuos4=
X-Google-Smtp-Source: ABdhPJw+mP/6c6LsyciS//e5850ieMNokfjfnj0Iz+rVsYptUpSSFgX1hQ5PFxDtOreFzShMc9MUzA==
X-Received: by 2002:a05:6602:15cf:: with SMTP id f15mr17901928iow.129.1639079619217;
        Thu, 09 Dec 2021 11:53:39 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:554d:272f:69a0:1745])
        by smtp.gmail.com with ESMTPSA id k9sm383541ilv.61.2021.12.09.11.53.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:53:38 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/7] NFSv4 remove zero number of fs_locations entries error check
Date:   Thu,  9 Dec 2021 14:53:29 -0500
Message-Id: <20211209195335.32404-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
References: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Remove the check for the zero length fs_locations reply in the
xdr decoding, and instead check for that in the migration code.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4state.c | 3 +++
 fs/nfs/nfs4xdr.c   | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f63dfa01001c..f3265575c28d 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2106,6 +2106,9 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 	}
 
 	result = -NFS4ERR_NXIO;
+	if (!locations->nlocations)
+		goto out;
+
 	if (!(locations->fattr.valid & NFS_ATTR_FATTR_V4_LOCATIONS)) {
 		dprintk("<-- %s: No fs_locations data, migration skipped\n",
 			__func__);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 801119b7a596..71a00e48bd2d 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -3696,8 +3696,6 @@ static int decode_attr_fs_locations(struct xdr_stream *xdr, uint32_t *bitmap, st
 	if (unlikely(!p))
 		goto out_eio;
 	n = be32_to_cpup(p);
-	if (n <= 0)
-		goto out_eio;
 	for (res->nlocations = 0; res->nlocations < n; res->nlocations++) {
 		u32 m;
 		struct nfs4_fs_location *loc;
-- 
2.27.0

