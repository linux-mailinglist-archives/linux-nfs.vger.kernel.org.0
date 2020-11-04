Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C422A69A6
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbgKDQ1L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDQ1K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:10 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3844DC0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:10 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id w5so10147779qvn.12
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cQWnqdY1gDuNcCekRbuBF1v/3ZoPLijNeC7jWYYnvtc=;
        b=db5F/CTl9J2G9prXbl50VGBnX2gnu7dekvyQWA8kj/T3eSRLuh8Gyb1u80WAr3Jgsy
         70emfNd4aETR5W02qSGspedDqFNQA9S0Y+ggRss946lAODF5sG+zGbYvI6q6D2DI4Yyu
         LH9cB0sPNe+TlnKlGjH0MiId7sudQPmkZhr+GDpd0d1n+X/bFtoCMbHXwZYFDceXB5p6
         NbY/lR2YJd0cIk+hEeFpJyuWPKuFXRikqUc9QoVZbb2cZGWVIqbMIE9FalgY1O2UGuqK
         Vy60HEFjd2MDkBKts85BaR4Bi+lx4Qhu8EUKOP6+9oaHceWiz7IMT3qo3ePpbrF4LGEw
         e6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQWnqdY1gDuNcCekRbuBF1v/3ZoPLijNeC7jWYYnvtc=;
        b=V3hR/SZ+uR+3NI7TpXUR+AbXuqt/l45aB1oWhcvNS8fkZQdEFbrXv3ShkELe2ygoqh
         qdHclx6UECI5KAiyAEFrSqcbezs9jV4RAh39sRVgrlrGDbDGvAxlS2kuiW2KRaSopfOc
         9ajC71Tqa0GMAdknhnu28mPPX+fXcufdwOI6GgxSlXBmiasIqY+nipFezfUVQwQ6VOdt
         IMX026INCrvC4IvJKrDL4krGtmAbMcPZFzA3GCXP2eMHKbGSBVy96KWqu4bKiQOn7Ydh
         o4gUFdebTlLhyDb2dyh3qR3qjEKnPDR/Y4+lTiGRPVRTcCnke6lg/Oaed8IHBdVxUpwI
         2/ig==
X-Gm-Message-State: AOAM531qdmACLQ+E9q5tKxCaYjkHBCvAfb7Yf9UFwN3HmnjgFQLrmYDy
        pKTqfISNFDXOmG9EkRJUBclHW/3snh6L
X-Google-Smtp-Source: ABdhPJyO4rB0tRS6uW3MczgcdLTfXRRC3D60NornRhqtzAS/fsxmTM5JSyH4LRvE5y8dQzp87cErbg==
X-Received: by 2002:a0c:ecc8:: with SMTP id o8mr32915864qvq.54.1604507229119;
        Wed, 04 Nov 2020 08:27:09 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.08
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:08 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 07/17] NFS: Replace kmap() with kmap_atomic() in nfs_readdir_search_array()
Date:   Wed,  4 Nov 2020 11:16:28 -0500
Message-Id: <20201104161638.300324-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-7-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
 <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com>
 <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com>
 <20201104161638.300324-7-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e8b0fcc1bc9e..b9001123ec84 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -447,7 +447,7 @@ int nfs_readdir_search_array(nfs_readdir_descriptor_t *desc)
 	struct nfs_cache_array *array;
 	int status;
 
-	array = kmap(desc->page);
+	array = kmap_atomic(desc->page);
 
 	if (desc->dir_cookie == 0)
 		status = nfs_readdir_search_for_pos(array, desc);
@@ -459,7 +459,7 @@ int nfs_readdir_search_array(nfs_readdir_descriptor_t *desc)
 		desc->current_index += array->size;
 		desc->page_index++;
 	}
-	kunmap(desc->page);
+	kunmap_atomic(array);
 	return status;
 }
 
-- 
2.28.0

