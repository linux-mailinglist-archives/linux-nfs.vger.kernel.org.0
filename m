Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90683AC0C1
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 21:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392221AbfIFTqj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 15:46:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41443 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfIFTqj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 15:46:39 -0400
Received: by mail-io1-f65.google.com with SMTP id r26so15344877ioh.8
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 12:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qbMlSBpf06q9f17aggELxyyLLTxlNI3h6Qh/Z4qZNW4=;
        b=bUwu4sk+0MImOxqv79lWM1M6IyvQRdSROOTwn+LEs4r8SCvAXGMw0aOKgMIrONlI/G
         ASRQrQgcMbNPQeOmGZjIyzCrJQ25QbERiyyf9FMFdkhKF/mf7phavv3/tqJLL+DnSXxL
         56giWW0Ich5diR0ZWfF0sJ4lhY5iZxxcNOvgKF09+kp6c9miF62jnXkrh81UrWSUvAld
         c+3zlPeM0Lyeck9Jq8y4Nk/mwT2jCh9k7rGk9T9cJQpW+WuuLHodDYT0ut2xKv5DSkjM
         84o4FMvPq61EJdRveCwwt4BgDgYHL9DD/7FG/ZunbDmeByuUfbiPwiS4OxXT5JKm6hU3
         X92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qbMlSBpf06q9f17aggELxyyLLTxlNI3h6Qh/Z4qZNW4=;
        b=NYXFih2egvj4xlGqHmUFVR2p3zlTytlP3iopXkWM64ut7YMkOgimD0NH+ZsA9zH4EM
         9QaccDqGJOXIbeqTjuqI0UYXEG1nEd/pidE7AYFGwZWJFGqbvm7uzCHH5Hv5D3FXiOo4
         2fZE7aNcQupU+u5P//5heZlz9mdYtBc239OPETIt4r6CUnxasEKSITmAJWUUEu85asWa
         gKXqWthxnZZmhQGePJ/xhmRVzjsg/5i+rVx9cqqW8hOFssiMKNd/Y9SWp0ZRmuHumpWT
         V8IbOmh0upc0JYsacB83LcTda61NZIdbONbGp4HPxCu5rBIXfQzt4G0AqO148kbHQNzs
         p1nw==
X-Gm-Message-State: APjAAAVnsSzgMUlfUMivE+kD1w+ULaXjvzhZ5bUMz2YBQMU/SmvRYypV
        1vuuag0XuZdpgca+HBv9VpI=
X-Google-Smtp-Source: APXvYqyRcwEGbaHiIfWvFRr2EWCdyNN4Zy2jYSCbj8+UindlFghkglKfjFtPAY4EvhsmmlipazhmrA==
X-Received: by 2002:a02:a516:: with SMTP id e22mr11859833jam.77.1567799198190;
        Fri, 06 Sep 2019 12:46:38 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id i14sm5118085ioi.47.2019.09.06.12.46.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 12:46:37 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 04/19] NFS: also send OFFLOAD_CANCEL to source server
Date:   Fri,  6 Sep 2019 15:46:16 -0400
Message-Id: <20190906194631.3216-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In case of copy is cancelled, also send OFFLOAD_CANCEL to the source
server.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index e34ade8..bbf7c1e 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -206,12 +206,14 @@ static int handle_async_copy(struct nfs42_copy_res *res,
 	memcpy(&res->write_res.verifier, &copy->verf, sizeof(copy->verf));
 	status = -copy->error;
 
+out_free:
 	kfree(copy);
 	return status;
 out_cancel:
 	nfs42_do_offload_cancel_async(dst, &copy->stateid);
-	kfree(copy);
-	return status;
+	if (!nfs42_files_from_same_server(src, dst))
+		nfs42_do_offload_cancel_async(src, src_stateid);
+	goto out_free;
 }
 
 static int process_copy_commit(struct file *dst, loff_t pos_dst,
-- 
1.8.3.1

