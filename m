Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B86B42C4
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391556AbfIPVOE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44102 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391553AbfIPVOE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:04 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so2379753iog.11
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OMSnhxhLm9jAGT4vNx3iX0q57Vtf9G2yxU8MZWSWriQ=;
        b=C06Y5NQ/yRI6FRYi4g4Tywc4Zwck84tN7rpN+e+x81RtbTtyUirdiohgfWuzt8BkWB
         KxSrs8P6appBirUjG2YxO/ebkw3ewAvG4FeixIKYFoPJnSD/yEyDTKA8l2zW3zOoMFSd
         PDCj6m9+9at9gHu3kdFT/JdpGdkwowrecsyHwT2gy83dytyih7MO5bSfJHKicbwJIC2+
         EUc6CrF63j07H2oolPS+pgQUwx1Kw74VMP+Ht8Tbt7p4sAm/gAvlpgw4DZknw5Gq/0uy
         BzNPYQPJK7blwXSrLQi7FW6zm+u2+Rq1uo3B1FkJlCpVC6cvfTtnSlz9LHutWHimmfSc
         0RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OMSnhxhLm9jAGT4vNx3iX0q57Vtf9G2yxU8MZWSWriQ=;
        b=tPjDyTTno4k+pOYT5x4eK3eljWtCtzxzFq3v8R2GkpkBtcEcakZ8HTus2FXE4Ju2Ng
         OFjiqrXV6PqnSY+8qMq2TYoL12Ne+5PQ1/V4lzyH/QGaTlEl2DKaarDQOVnnRTK4PY4L
         xTJCxv5DQcfrM7SZKsGu/hRL3DbKzhVrzbRy9g4wXEnBaDv0IpG5+8ul/tzdt3KeYTYL
         V4iY32ZBDuE27AYaMJMXglmI4Tqf3bF53i9Aib3p9XhMeN0YFY2fw7l522gxgxIdTh8R
         0RGJoIKVwS+9kMuG+OF0zFsl0580YugGTIU3kll/PKq03v24SJLg6n/aQel/VFcAJAlB
         1J8g==
X-Gm-Message-State: APjAAAWUIEUaF6fnbSo/B/vq0B/3emYwZqEurCKRUrzOG0DH7mSn6nBo
        BZMwu/e4yhzTJ7/EFUJzySw=
X-Google-Smtp-Source: APXvYqy7VXkbqDW+MPnfUFQ+VtRlvsMg8PobW5sL9GcqEghhsQa1RH1On4LvWsfYUbCmbHhGTsfa2Q==
X-Received: by 2002:a5e:d50a:: with SMTP id e10mr329921iom.273.1568668443589;
        Mon, 16 Sep 2019 14:14:03 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.14.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:03 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 08/19] NFS: COPY handle ERR_OFFLOAD_DENIED
Date:   Mon, 16 Sep 2019 17:13:42 -0400
Message-Id: <20190916211353.18802-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
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

