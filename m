Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34734D29D9
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387857AbfJJMqd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:46:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38054 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbfJJMqc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:46:32 -0400
Received: by mail-io1-f66.google.com with SMTP id u8so13325399iom.5
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9vl9z2Pnhs9wDkK71wWFdDuvprpW05FNT6IF65lu3YE=;
        b=rYcydWy5JrXcKoU4bIJsSa5duqj9WE2ZBAKLsiIO0V7seQtDF2YOTsR4tL26MuQbUN
         FsyZ36zTgWE6F0On/5sGj+niU3ztA/Tx6IRuZ1Z7T97bMiAJfbKH+58w7sv8ajNZkriG
         3OEz25om9llbTJE/pmx1SKnK4Tt2b5wEW1kHqUPB2ZVzu0U1qZvi5mIS43BYQee3VJH8
         oiqcqWTUlLr0huuSLykEPM9sdhVtp4uoWtO16maEj6OwMoor4cbVyGy9ZSRJNkzwZ9sN
         tvQJvrwHaW6A+TBPtBlCszxrf1rukU/stgXXi1aw4ZhQyRpx+2E+dRQxi4IR61CZW99k
         a97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9vl9z2Pnhs9wDkK71wWFdDuvprpW05FNT6IF65lu3YE=;
        b=IdNKT1PZnfo6gzuUHPbSd3+XYaHqvgvXHhXfCrt4GTI3CTN2mwoDBWVZSyWvIMl7Fr
         DKSyWwFutwfNE9L/nNHTOPT+K0+o32PbTmxMcAp4dO6fm4lp4XzwN0O3ATrxWlpalngY
         lqqxYF0umULaVnzam1uf5ti7UwdgrMAtS2zzhjVaEnSRagL+NSk8ssEKu+0h3dXdx8/5
         Wfgd+DC6b+ykZBPmx35HrCZn8Xilv//VYZFnJZjANZgezhvFk8TEmz+aHsfHtlYxR+J7
         j5dUuIM56EVpydEumXhNsps10yuO+lLHbMKWG0JUYbj4jejsm8E/TIBVou4FSi9f7n18
         aOlg==
X-Gm-Message-State: APjAAAUyIUaR1/nmsZfpkc1frxpFLV7jh3GXV6IR8AreO2Y+86HtfCzQ
        RFo0K0wA3T7Zg0sQ9Ypv/Bl2TPwy
X-Google-Smtp-Source: APXvYqzD6nW3yGQBvj7HlvbQC2svn1jsYZWNYpkwS/TshIR3x06uQjzvdO/LG83pIVRqtYlHS+y8Aw==
X-Received: by 2002:a92:1011:: with SMTP id y17mr421269ill.234.1570711592113;
        Thu, 10 Oct 2019 05:46:32 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.46.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:46:31 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 06/20] NFS: for "inter" copy treat ESTALE as ENOTSUPP
Date:   Thu, 10 Oct 2019 08:46:08 -0400
Message-Id: <20191010124622.27812-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
References: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If the client sends an "inter" copy to the destination server but
it only supports "intra" copy, it can return ESTALE (since it
doesn't know anything about the file handle from the other server
and does not recognize the special case of "inter" copy). Translate
this error as ENOTSUPP and also send OFFLOAD_CANCEL to the source
server so that it can clean up state.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index e34ade8..6ed5a16 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -391,6 +391,11 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 			args.sync = true;
 			dst_exception.retry = 1;
 			continue;
+		} else if (err == -ESTALE &&
+				!nfs42_files_from_same_server(src, dst)) {
+			nfs42_do_offload_cancel_async(src, &args.src_stateid);
+			err = -EOPNOTSUPP;
+			break;
 		}
 
 		err2 = nfs4_handle_exception(server, err, &src_exception);
-- 
1.8.3.1

