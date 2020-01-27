Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5626D14A6B6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 16:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA0PAc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 10:00:32 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39402 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgA0PAb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 10:00:31 -0500
Received: by mail-yw1-f68.google.com with SMTP id h126so4829413ywc.6
        for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2020 07:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+53wEaO9sr3iZGt29UZUjIeOI2BiLFw4FnrTlFPrmzw=;
        b=ImeWTxbUub3NObJ3gOMyvkm7X1mmxnBIfqC6QcmU1nOd0UMvqqOisl4pca/tnvO1Md
         eL0VDvHaYn9gIcnO5OxsTOSvN+ZhmfmSj3A+c/bcxxAImdKca2+kisJq47b1KLyLvXwt
         dbrtDzbuKPeiskp31Hx95kVyXxKZ4tH4BsaYbxbwjSwwbjlXGPEKywu/0w8gD7y4yzqn
         fqnRYs7tr9H8IqE6+L4q4LlwDCRwg/69ZLESSwU+M7ZgHLdFAQMdNma/z+3FKTbZB7Ug
         1eEk4skv8knjHLdUl8cBnUWf+ob68l3+N7JIFkNqMH/9oC/GJC21JP3CuVOYbIjQtzNz
         qtkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+53wEaO9sr3iZGt29UZUjIeOI2BiLFw4FnrTlFPrmzw=;
        b=o6v7apnidQHyI7IJ2WDEiRvyxsvRWfAq8mGQ7SMeybq9jm9ABJOJWBHZxUrcnaCa9M
         Fk5ss7WzRH84in88SPgnsfhVwuBWIYBYydK+lV6ZtTVZ1bpPkqTm30FgKmhZew534mga
         eQ8bIyT7tN3g6ked8rQJy/fXTcZgOdc7xYDCeVUmmEvanYn4Tr1qOYtep4uTY/XfzXpA
         7nZTB9ahiGRqmgtU+kD8qLF2VRjABCBCYF1UEyFHGJRZEDXrIcTeUNOGA8Qho14UjMOM
         nCRJD//GlCgoxtsnpYZColqhhXpsAPoiIg0HmPbgPIZ+SU+BF45jT97Bj4tOnPspVm2L
         nwGA==
X-Gm-Message-State: APjAAAWmZaFel+MhYvVXl7Askw95m9d/NWe0cB/FXgRN00omjX0BUTM+
        lED0+3ctRzcBb/PmvJP1C3YUNzQ97g==
X-Google-Smtp-Source: APXvYqwTTSreqaZWTJnS+SAtUI3lAl7QzAbA6pMSTAS7bLeWScMYkMsrRsqXguDisZ3ouRHDFGfsvQ==
X-Received: by 2002:a0d:d850:: with SMTP id a77mr12581529ywe.464.1580137229830;
        Mon, 27 Jan 2020 07:00:29 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id d186sm6809096ywe.0.2020.01.27.07.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:00:29 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/5] NFSv4: nfs_inode_evict_delegation() should set NFS_DELEGATION_RETURNING
Date:   Mon, 27 Jan 2020 09:58:15 -0500
Message-Id: <20200127145819.350982-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127145819.350982-1-trond.myklebust@hammerspace.com>
References: <20200127145819.350982-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In particular, the pnfs return-on-close code will check for that flag,
so ensure we set it appropriately.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index fe57b2b5314a..a7e42725c3b1 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -607,6 +607,7 @@ void nfs_inode_evict_delegation(struct inode *inode)
 
 	delegation = nfs_inode_detach_delegation(inode);
 	if (delegation != NULL) {
+		set_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
 		set_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags);
 		nfs_do_return_delegation(inode, delegation, 1);
 		nfs_free_delegation(delegation);
-- 
2.24.1

