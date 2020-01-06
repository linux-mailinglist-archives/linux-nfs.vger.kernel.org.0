Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B557D131952
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAFU12 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:28 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45022 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFU11 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:27 -0500
Received: by mail-yw1-f68.google.com with SMTP id t141so22415252ywc.11
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qaen0ufwEJUB0Fs5mUM2TOjyjCuqbGSEbjqXbGFQrT4=;
        b=khgcauH4hu8vaTBoO0tgG3F5OHDPz30KOocgVg03VxlohkhsItLOerA/PtpwBj1gAH
         FxziM0FvF8CsgBvlXzt/gwPMRkvOLsXvwgPvTwSPE/dfgIo+/6pkU1RyZAKZiAORQhNc
         hjuD1WitQr80QAHqYrcqjYhLz0Hw4Qtv3AuT8DKlpcu8dP/H2mKzLJd6H4uEWzZce0Yz
         saQCcqz+ODXnKSoT5G+Z9EghT84UD/un65FyjNQzMDY4v6hJHF1XfueAQUYQUt3+Iyvm
         vMe4gMXX0uUnipEpq6HXegE8yHm9M8+9TZT+REjuUycPVt7dl0FWAK7vjog7eQ/1ebE5
         TsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qaen0ufwEJUB0Fs5mUM2TOjyjCuqbGSEbjqXbGFQrT4=;
        b=uMXjDxKo2HoXNAB8B69xBIAmVjmepP8Ymq2VwvzeeUv6g8vNoBOi2+E4hP/RyegrxO
         /pVoGho6lGW++3UUiyPDCKWmcAehRNEbQD1sEdXdkoA8LmBtiiHydWXkXsvdE85kELkI
         8RpRtfe1bjIetJxUCN5Lv49G4EDzWepiCFQJ/fF5J3xaCtblrncnUVaO02S/kAgQtVPW
         Cuzk1zx5vhrV5kt50MmUg4G57aBOcfQGF2JmawGCiMk+0pZdI5gUC+xnuUH9ApOWlzFE
         CwLIHCF9gKLAwAHyfx3Mgg+yxCRGEt81SSpNpE9ezBwUKnVBQRbWO/10woFxNU9qgZ70
         Nk4w==
X-Gm-Message-State: APjAAAVqR8EcxHYfCTQqyCeKml11yHFRaQ/NyR/RBWvWycg0n4+1qxUa
        UG1sO2FAhKggyNkX0oTiZQ==
X-Google-Smtp-Source: APXvYqxCAlHFIpJOG3wAz44pe2kLI4FcWCrFy8wlvY26zUk4K0+9oBDnaDee6aSsOnuO0zrh4UQFUQ==
X-Received: by 2002:a81:6785:: with SMTP id b127mr82129080ywc.56.1578342446484;
        Mon, 06 Jan 2020 12:27:26 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:25 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 01/15] NFS: Revalidate the file size on a fatal write error
Date:   Mon,  6 Jan 2020 15:25:00 -0500
Message-Id: <20200106202514.785483-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we suffer a fatal error upon writing a file, which causes us to
need to revalidate the entire mapping, then we should also revalidate
the file size.

Fixes: d2ceb7e57086 ("NFS: Don't use page_file_mapping after removing the page")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 52cab65f91cf..f5170bc839aa 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -243,7 +243,15 @@ static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int c
 /* A writeback failed: mark the page as bad, and invalidate the page cache */
 static void nfs_set_pageerror(struct address_space *mapping)
 {
+	struct inode *inode = mapping->host;
+
 	nfs_zap_mapping(mapping->host, mapping);
+	/* Force file size revalidation */
+	spin_lock(&inode->i_lock);
+	NFS_I(inode)->cache_validity |= NFS_INO_REVAL_FORCED |
+					NFS_INO_REVAL_PAGECACHE |
+					NFS_INO_INVALID_SIZE;
+	spin_unlock(&inode->i_lock);
 }
 
 static void nfs_mapping_set_error(struct page *page, int error)
-- 
2.24.1

