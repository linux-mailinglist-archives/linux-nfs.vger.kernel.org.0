Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC57AC332
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393125AbfIFXgV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37832 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393113AbfIFXgV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:21 -0400
Received: by mail-io1-f68.google.com with SMTP id r4so16637754iop.4
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hf/20/zgdRrBxlarA02mT/b6DodVKxI+tbzEDBpNpDw=;
        b=f968fSXJHaLp9VMmLQQKwIVm9lBxGwynMgckMRwfx7GjUllpqFaQd/Rj7cUitUEc2N
         wruXS04rOP+N+WUm8TBCsM6wl0kKmlLWxtjZ1mbD14L09BxAK0vA0AEoqF4Pxv3hi8N7
         /AyI3pvqUiQWW0CYH4ORNnKCtz00c2dlR3HesqfP/xrLI2poLCzmlgvD8PRnJ+sfQzM6
         QSVGVO8cM4zv7NOV9HbJkVZLrNhPR+P2iGmpaGQtQks9rtULHmeDf2YkacOKTMm8P4V5
         zLY9Nduhpfhu3Ocfao8pOohwzZmb8e+DL4koLd0rYDrVIDyXLP2e2CuecknAF9fp/J6+
         1/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hf/20/zgdRrBxlarA02mT/b6DodVKxI+tbzEDBpNpDw=;
        b=iWgoiEJUVCf5uwX7I+ycX38ScqGWUAabfIQfty4XBNiVeBkQ4LHGhx59y5Wr+lHNii
         K4uMYXxuP2y0c0uUSnoBCxET26vCorJnLHkSbK0e7Tdzp/CX6J4w2ApUqdtyytXA6uJ5
         jViPXcPMCD5ATgbgIj8RN9Zft+31AOpJfXk9XJLVL5bAac8mc6G0/2s1Vrpx6gRmMvRO
         R4J6bBxwyRy4AvGOcHoWrGoKnk+TIK4feNEzKLUWjgg3TMs4rfeHCm9+7/zu7KvJFYh1
         da2YiG/vOM8LE66PBlQGNH9wP/D3mqaflbNYQ2oFnEHdpwc6EYPAe6vQq8EuFTspYMS/
         u2Ww==
X-Gm-Message-State: APjAAAWgiFl9wn8mtcKUlqrsy1mac7Xnn29WyALVTuLu47xe/uqsK3yn
        xpS/Y5SZ+aHoicphU7Vv9WQ=
X-Google-Smtp-Source: APXvYqwzLSA6xp5yr0Z2hnd6sHz9ruul/8ideD1iFJAhu4uMVPsBDxYW4V8vIwYOFtBUV72CQf/dZg==
X-Received: by 2002:a02:354b:: with SMTP id y11mr13133991jae.53.1567812980160;
        Fri, 06 Sep 2019 16:36:20 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:19 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 07/21] NFS: COPY handle ERR_OFFLOAD_DENIED
Date:   Fri,  6 Sep 2019 19:35:57 -0400
Message-Id: <20190906233611.4031-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
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
index 6ed5a16dc511..50538b975aba 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -391,7 +391,8 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
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
2.18.1

