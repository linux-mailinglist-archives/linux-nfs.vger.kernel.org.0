Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99C5F12E39E
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2020 09:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgABIEf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jan 2020 03:04:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33438 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgABIEf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jan 2020 03:04:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id z16so21723504pfk.0
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jan 2020 00:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=j2iODv6cj8h3jFOpQ8/xB7IGAL0+9R1SoQHtryU9yXo=;
        b=epRw1uocfyEc+KMqx0CEH/rsumELdKMhpsRRtxhJH6+jEPspfzBVvkvuuqLZCRYi96
         l7wf84pP6jm42a7l3IkdirOhiYIfskmS234Ub+DIJGg556MOR1AD2Ye4/VWzKanDWh9i
         EAwNvMubyJC+CTTMnGQjEsWzvs0f2+yvprNn09XdVOEOgOCyhlfA5IhDo1AscnTaRM6Z
         oS7uBdC4VxOv+ajNFdCQIGl6PrQ0osq+k3nIC6h6ygr5gv3+E6QaXqHRa0NH/JjaEPvE
         OP9WR3Hiaz5fuZ95srT210N3FQB35U8O+V4FzNo3S1aRipkfJXTK86yUm6yavjqSDvqU
         KJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=j2iODv6cj8h3jFOpQ8/xB7IGAL0+9R1SoQHtryU9yXo=;
        b=s4yiqgEIYMTZmXHq88XMH+voA6Y0Uebz56LU+ZcImMrTe1/TUzEx2ht3sXTZ4cCC32
         aw4kRuvjFDK/T/9cmIgHFsrWGemoDdLRJgeKKrURehEpz4KTtcRr5WI/Nvwy3/EOIs6A
         /pKH8KUebnkINPCGsKPK7JsudEr9A+0Qq8N4YWmvTwWNQM6WpBXhW63g6r3vDC8CX4f+
         SFOhBxrQ1hZCENDp4n9dAh9dB2avCVbYqS4d1gyqWstdnsQyJIBT/c8JnSJoPC2WtFQj
         HOd2uJijbw/QmTAxauTKWQplcWLP4vI0I2MqenPkevw2ay5ZnTUq+RnDioM3a9YdUul5
         pzYw==
X-Gm-Message-State: APjAAAW0tzryVK+xAqpbFwZBI63DYufjO/GyqbdxZXZQdfLkLNRNSjpi
        c+CNXiydbWPUonkvdXwekOODTX6p
X-Google-Smtp-Source: APXvYqxIJyvfPRyew79UG4si6/eaUqDyOxRfEF0aoES1nKGGcggHLPTFwfmrF18ZAtQzls1XKzdrdg==
X-Received: by 2002:a63:6d0e:: with SMTP id i14mr90853844pgc.12.1577952274702;
        Thu, 02 Jan 2020 00:04:34 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 20sm41820877pfn.175.2020.01.02.00.04.33
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 00:04:34 -0800 (PST)
Date:   Thu, 2 Jan 2020 16:04:26 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] fs/nfs, swapon: check holes in swapfile
Message-ID: <20200102080426.byzq4rrdilr2qxx6@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

swapon over NFS does not go through generic_swapfile_activate
code path when setting up extents. This makes holes in NFS
swapfiles possible which is not expected for swapon.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 fs/nfs/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8eb731d..ccd9bc0 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -489,7 +489,19 @@ static int nfs_launder_page(struct page *page)
 static int nfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 						sector_t *span)
 {
+	unsigned long blocks;
+	long long isize;
 	struct rpc_clnt *clnt = NFS_CLIENT(file->f_mapping->host);
+	struct inode *inode = file->f_mapping->host;
+
+	spin_lock(&inode->i_lock);
+	blocks = inode->i_blocks;
+	isize = inode->i_size;
+	spin_unlock(&inode->i_lock);
+	if (blocks*512 < isize) {
+		pr_warn("swap activate: swapfile has holes\n");
+		return -EINVAL;
+	}
 
 	*span = sis->pages;
 
-- 
1.8.3.1

