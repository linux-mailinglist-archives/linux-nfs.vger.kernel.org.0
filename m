Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC0D46879
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2019 22:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfFNUA1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jun 2019 16:00:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34413 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfFNUA1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jun 2019 16:00:27 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so8504360iot.1
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2019 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OMSnhxhLm9jAGT4vNx3iX0q57Vtf9G2yxU8MZWSWriQ=;
        b=l3w81jtf5zdB17HLXR6jKiRFjvke9d6LsUITregWjWHRXvJsIVeN6MZF/eR/SXXyt2
         QpUatvfYQRevPrFtNbuP3TksABwAnm3pd5VDfqD7+jSCfDGIKFLaS7lkkXDQ3f9aGcaX
         ltZOq+b4799AhJCBJtufbPdqRtbSXRtzIhNl5Q5vFqUwmg67Ij8RPEvTxA/+TomXBfRf
         Cu1zuqSho3d0o2cwgTv45qpPvRHBAe+YzuEr+Jtm64E60ner82e3OaA4gDveRu6P+Uyt
         uh1dTvGYuSQYOaATgbb6BWITI/nTsfi9LVjMBnuwkOUybAtP90sGVWw7y9dOEjTCWDA9
         iyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OMSnhxhLm9jAGT4vNx3iX0q57Vtf9G2yxU8MZWSWriQ=;
        b=a510c7VOO1aE5v6pCSsQa89P2LqK2mRdYe0RKSLmJCO/6MkvnQNJ6BCaa2vmuzXAhS
         8Q0Pn4CdkeVwBvqmPjsSBsGFmtR3nvmxW2Kgg3uh9peWedE7k1+aZFXzgCwW4mEjXXjc
         1ToOQpqjaJeqjFtnvDCs8bor3fdNNa77zFO5IbH8jIkjPOnFKcbG2rr1YJRN2pCio6Vn
         CUd5UmzvGk/JrsS7nFhRC+w4wzM41jBvEOQjLtjCBhKTlp2BTwtNXIghtH/ZNMKIgcd6
         KBjgY7GI15OEtkx3HHzxlV4BqsIrQkQqQwJDGhj4ouHIFuHdEYiFaRTSbYz1iYq5yQfx
         E7kg==
X-Gm-Message-State: APjAAAWn5G8Jya4dhOM55CpBrxOB9iC1DcXxpIc5nh6ZtNP59yGn7znX
        ayWxemxw/pRcgxvjL8ZlIRewmUAgioQ=
X-Google-Smtp-Source: APXvYqySgs8eLdvj7WCRpyM1JjXDvafZwiYXOtOUKgpvS0G/SgGnNK0DwNKN5gLB/cmgU0cTsYN01g==
X-Received: by 2002:a6b:ed01:: with SMTP id n1mr2082915iog.255.1560542426157;
        Fri, 14 Jun 2019 13:00:26 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id p63sm4623407iof.45.2019.06.14.13.00.25
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:00:25 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 08/11] NFS: COPY handle ERR_OFFLOAD_DENIED
Date:   Fri, 14 Jun 2019 16:00:13 -0400
Message-Id: <20190614200016.12348-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
References: <20190614200016.12348-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If server sends ERR_OFFLOAD_DENIED error, the client must fall
back on doing copy the normal way. Return ENOTSUPP to the vfs and
fallback to regular copy.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index f8ebd77..705fe69 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -393,7 +393,8 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 			args.sync = true;
 			dst_exception.retry = 1;
 			continue;
-		} else if (err == -ESTALE &&
+		} else if ((err == -ESTALE ||
+				err == -NFS4ERR_OFFLOAD_DENIED) &&
 				!nfs42_files_from_same_server(src, dst)) {
 			nfs42_do_offload_cancel_async(src, &args.src_stateid);
 			err = -EOPNOTSUPP;
-- 
1.8.3.1

