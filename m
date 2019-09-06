Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E05AC333
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393129AbfIFXgW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34507 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393122AbfIFXgW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:22 -0400
Received: by mail-io1-f67.google.com with SMTP id k13so1362277ioj.1
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yo9sLYVGIpnI5eQhl4Hmyu40q9FnCAike73i03d2rRI=;
        b=ELpZx1u9oKfvDXq0zamD/j+INSkz9F8cmovopIvF5KtJtoT/8EAtZIpfAzmW/t0QmI
         UerDcfSSnBJLXZexLdCHes5sEjhP5nWu9v+eXBg5OlIhiW/Iz7YBkX9zf4d72DRnAg/W
         k+c2+1Kt46BZ3sgiJq84wG7G2eWWCIG9xfovmkZsLCeVnvQkRBc1up9QZBqX1Z79Qhfs
         QrtbqFBlEcOFRCXq/CQVeeSkMVyWsoGaKfcMf0B5pvvzDKIfsznLUEW7k+lrluNsFyNs
         sxppUN1uCWJiUSz8llVAYbVW5P2urSutgebE4Qo+KDAPkwYoGc2WEX89WtzbIbcPUfFS
         yIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yo9sLYVGIpnI5eQhl4Hmyu40q9FnCAike73i03d2rRI=;
        b=KjQAweC4RLeUj0rnra38bGF1yd4d7hMRzfdx/ZYyfSzEWb+GB3s+YBneIlqmdtIshv
         EQ6BIj6GisnTpGjOKO0/Pj7lzWu6qY04QQJkH7FLK+lro1wA8wG0cQqPI5TtvDxSjPWx
         N7h2TYwKoKBw29oIgtT8coOPdQq6OfVEbJg2irt0FLDpMudhi9WDvAvMUWDB3QgudqPU
         ijBTcuvkm13CIVdn+JhQqnlbNtDba+XbtjAFyc5gUaHMmj2nFe+6CWUPGaxTIvitA0UK
         JHjm+31GCR/xQ+Uh0pvPJAg8RH75grbpra6ZdlRXnG8c86LYakBXuGoRlbWvvvU/2UHs
         5S6Q==
X-Gm-Message-State: APjAAAXeN0uXnb9/+2tuO8qSwuAKaV6QYEOz4gsbitbR/M2zc5aJeXC/
        AwSb9it+YEqqiSqQHueEGZk=
X-Google-Smtp-Source: APXvYqwSZxo5K/N+DhrzJiaB/BWcgKBTyLvpOWrKm28VvS6sqCjQ/KaOPoCRaH6fmvdBMqyao7+fFQ==
X-Received: by 2002:a02:a909:: with SMTP id n9mr12573415jam.57.1567812981080;
        Fri, 06 Sep 2019 16:36:21 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.20
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:20 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 08/21] NFS: also send OFFLOAD_CANCEL to source server
Date:   Fri,  6 Sep 2019 19:35:58 -0400
Message-Id: <20190906233611.4031-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In case of copy is cancelled, also send OFFLOAD_CANCEL to the source
server.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 50538b975aba..5d833f5748e9 100644
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
@@ -381,7 +383,8 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 
 		if (err >= 0)
 			break;
-		if (err == -ENOTSUPP) {
+		if (err == -ENOTSUPP &&
+				nfs42_files_from_same_server(src, dst)) {
 			err = -EOPNOTSUPP;
 			break;
 		} else if (err == -EAGAIN) {
@@ -392,7 +395,8 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 			dst_exception.retry = 1;
 			continue;
 		} else if ((err == -ESTALE ||
-				err == -NFS4ERR_OFFLOAD_DENIED) &&
+				err == -NFS4ERR_OFFLOAD_DENIED ||
+				err == -ENOTSUPP) &&
 				!nfs42_files_from_same_server(src, dst)) {
 			nfs42_do_offload_cancel_async(src, &args.src_stateid);
 			err = -EOPNOTSUPP;
-- 
2.18.1

