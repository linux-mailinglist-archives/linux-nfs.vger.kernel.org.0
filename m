Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11555AC331
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393118AbfIFXgU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34502 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393113AbfIFXgU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:20 -0400
Received: by mail-io1-f67.google.com with SMTP id k13so1362154ioj.1
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NMgsPwcgWqY799nLZlYuCre0/XwCSngAA3yPJe7nzXA=;
        b=RxUQxJhUwuY6jLDSVRk4pvjmqhn546peN5aKcRxva9xyX2hSM0cgshpNM/h9TPRe0d
         D1lTs/tFXTkQMVu7cgH3+/3/eBO3SnyyyvecuzIe4VHw4gDX/P6GJ+bE4G9+YtbkaciO
         AqK9U+uQb3XcopPilRmVJskljzvRHV2Tbk3zfqbt6HT2wUsNpocGGYeTra33Ii9wLH2Z
         iwxDbO5S17Y2HEzwKR6wQnEvftYIWex27zXmdxu8aEvJS4Dy+EVDCSrCN3vEFilGXPoO
         WybOtepTWistjWUHuebNsDR3CYe9/BbWUAfGnphBVc7TAhXYuEwIT+TFXE8jb+FQk0Sj
         p/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NMgsPwcgWqY799nLZlYuCre0/XwCSngAA3yPJe7nzXA=;
        b=HFsOd5DQ5Zn5uXrTtfwi0mkfAK/E0aKYBYsQ+RJRinkRKqEgLU7l07dTG4cg5aL9bS
         YVzeWkDdlMG2ItnYI9/ctoI5cD8LspLR9xAsBbo7PSmUUbC6tsclbKoyKl3fWP7OOXs5
         jYXEkuqjJL2rs2RPtDz9xrRSUfAV05w02NemsxE+8F+2pByjt9FbW1P9INqu4psdz/8e
         HmEiGr7uQYBnwuCx1ocr2hCIhovwyaM7cduwddwYag9tLeDRXrQErZk0uAQyf7/Yj3hm
         SmvEj7IkuE+mr1pqYO+ZqgKxIcDETiWHtrLsbO/cAT9cg+Y78aGejs08o0UpfrdTu3RT
         hvFg==
X-Gm-Message-State: APjAAAXpdCepRDuqnuYhkHI1Wse1YaHH5VrRfmXPm4etwCbrru0G2GWc
        1h8eNwtezTfeb7PRfVT+jVE=
X-Google-Smtp-Source: APXvYqzEcHME0QJdzSrACRT/NLfZWudwh+1sfUEbltOvOvluvvk5oxcdJmuQBlOxs3cCfwwkjiglXQ==
X-Received: by 2002:a02:a403:: with SMTP id c3mr12322841jal.93.1567812979225;
        Fri, 06 Sep 2019 16:36:19 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:18 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 06/21] NFS: for "inter" copy treat ESTALE as ENOTSUPP
Date:   Fri,  6 Sep 2019 19:35:56 -0400
Message-Id: <20190906233611.4031-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
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
index e34ade844737..6ed5a16dc511 100644
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
2.18.1

