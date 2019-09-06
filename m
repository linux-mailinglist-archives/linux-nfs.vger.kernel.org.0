Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDEB8AC0C5
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 21:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392414AbfIFTqm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 15:46:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46801 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfIFTqm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 15:46:42 -0400
Received: by mail-io1-f66.google.com with SMTP id x4so15340322iog.13
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s6AarPquzkHm5tiN4Chfneb8capNztVCqvBC79jNDEI=;
        b=nlC9WqpGDCwS/rZm7rnEjPob+OQAoo5sI0Ike+xY3Nkg6WUk0z6LnomJsjM1rzpS32
         heA5VXzKvoWFcJNe2AO/lfciWkGgYRkWy3S3zrv5PfsI/Di5p+R9EZrmhRcgu4qud9Br
         XKrnlf0ia0Zgyv+UNPQHmMJ4xqokbYODqfqnn4DW7Bn/YRWB0auA097PhzlP/qb7Apdg
         qlzzS+dNoMdkqCoiNy52BU+4UJteW+gPkk5/zyeEK9bSU+gSN5HIh95ObLhXjPwJ4Z1g
         tLAxK0t4Dp6tG6dgHlpDIO2PgTIbXKdPcqUapfs48fh7rjnAGjaZeAgsOF/wZDCFrWW5
         SQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s6AarPquzkHm5tiN4Chfneb8capNztVCqvBC79jNDEI=;
        b=FBDanI+XeyYkdyzwW5NQ6DJBEaaAC3dNBt0OPzjlnnh9duskGnHkVZyKgPUG662xIO
         xH/4B3LqN723Z/U3kmAzYqbGWNWLwpWti16dIh2md2EXgUfPrJbQho82L0MXflS1+MZ5
         cIKFPWW/UOM0cJAznEMINW+2Y+niQWhNk6YMjQ94dCCAa+dfeu4e6KdpjCLuPldO7Ljn
         p/LpQPcz6mx95/6jfEuFdtImnaaD5jtOCSlLsPJzFYpWZ0JW+tFSWnDnCX7iA6RX2Qha
         cvFG5WzjbZwfPwewZi2UkJy99GxpsZCr2MSojiBuR0Wf31MsmTjXAQLVThP6Q7nQVOC8
         ZTEQ==
X-Gm-Message-State: APjAAAV3DvTu8vCYjFUD8vsac3PJnzZdkZwOLev+8rJuucVzOHEQFOqe
        TMNMDaoWBWQQm8cM6fd4EtzmodVA8UQ=
X-Google-Smtp-Source: APXvYqwhBd7u88D3/j9c7KO+l13CC9q6nPPTidJRVQT+f2WXTAs1B7eBsCI2pBmJuCjmc/ePS1TtEg==
X-Received: by 2002:a02:7044:: with SMTP id f65mr12084078jac.37.1567799201214;
        Fri, 06 Sep 2019 12:46:41 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i14sm5118085ioi.47.2019.09.06.12.46.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 12:46:40 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 07/19] NFS: for "inter" copy treat ESTALE as ENOTSUPP
Date:   Fri,  6 Sep 2019 15:46:19 -0400
Message-Id: <20190906194631.3216-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
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
index bbf7c1e..f8ebd77 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -393,6 +393,11 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
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

