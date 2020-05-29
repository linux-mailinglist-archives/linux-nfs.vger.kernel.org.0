Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F391E866B
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2020 20:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgE2SOq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 May 2020 14:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2SOq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 May 2020 14:14:46 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EC1C03E969
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2020 11:14:46 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m81so361863ioa.1
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2020 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lWtmAafBlM+j5hB/eJ+L7sxf3w0FFmwsrj30GwJ5dSc=;
        b=GDt8BFs4rg9AwJKq70L46CTUxro9WHxw6V1gCXIkpYQ7Tiygx9obEUFgLUEYeJH43n
         osAq+vajjhb0BFmEqfPeIGIIyXp2BRFhoIv296qWditbks0SJEH/YYyv5V5gL0wMBBDN
         1/erOu+14y259Wxegs5h6raoiS0ZS5B3dNwATvou/ZYlJ9GIlPYWRVEUbm04tfTPmk/Z
         dy0Ye+jj8cdVfy+92K2QjBbOaOD6i/jXaWcuAepfqETSxZEDpxVqPtr8p5he9gx5eVZL
         m/aV6KrfeapHZn9SHSiDrj/ZMyauFd0XqLKyowP7+DcXM5vrkTrdSpfCS4wD4q8PRLXu
         g9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lWtmAafBlM+j5hB/eJ+L7sxf3w0FFmwsrj30GwJ5dSc=;
        b=F/tgKr23KnpFrazTQ4AFGWLDLzHb/SSL5m3fmRZO45YsWcy9sM08AOE/s+4wFUumEY
         xwXJ1P3MOjg1L/kwX8R5WgC8V6C3fuWRPEe7p/yMZC90z9mqvY17uSKJUbFy0Z046NAb
         AvJT6Bj3bqNqRm5cUR2MCSVs/45k4w57GKVfWzyVIKW+Po9xLaDYuW5DZDErWV9/CHNU
         kyGvfI2otZcKXgl1x5Zj3VcejB9/EQnSXRb/qVQupKi8Tc5vgL/+jE5TOOvjci6h0Y+i
         a1K15XowJs52bQaZjzcKoBYIngacZZg91+ENGZKCji0/p5du9S89jBOoyg7s3sQlIOFo
         Mkdw==
X-Gm-Message-State: AOAM533OOpmsieZEQ9uHhbc1T/eW7UD5/5ocLjCBmQKDs/kGTwnWMZEP
        Iax4BhMTcvc2FRqqrR+DpP0=
X-Google-Smtp-Source: ABdhPJxVQ2w4elTg8J6n86xlc/eePaqwNVA5+UKJZVbAc2ujJddwgpQcX9gLltbmXt2t+JE53SVOeQ==
X-Received: by 2002:a05:6602:2427:: with SMTP id g7mr7823476iob.209.1590776085479;
        Fri, 29 May 2020 11:14:45 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s71sm5289466ilc.32.2020.05.29.11.14.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 11:14:44 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04TIEevh030812;
        Fri, 29 May 2020 18:14:41 GMT
Subject: [PATCH v1] NFS: Fix direct WRITE throughput regression
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 29 May 2020 14:14:40 -0400
Message-ID: <20200529181440.2510.45116.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I measured a 50% throughput regression for large direct writes.

The observed on-the-wire behavior is that the client sends every
NFS WRITE twice: once as an UNSTABLE WRITE plus a COMMIT, and once
as a FILE_SYNC WRITE.

This is because the nfs_write_match_verf() check in
nfs_direct_commit_complete() fails for every WRITE.

Buffered writes use nfs_write_completion(), which sets req->wb_verf
correctly. Direct writes use nfs_direct_write_completion(), which
does not set req->wb_verf at all. This leaves req->wb_verf set to
all zeroes for every direct WRITE, and thus
nfs_direct_commit_completion() always sets NFS_ODIRECT_RESCHED_WRITES.

This fix appears to restore nearly all of the lost performance.

Fixes: 1f28476dcb98 ("NFS: Fix O_DIRECT commit verifier handling")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/direct.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index a57e7c72c7f4..d49b1d197908 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -731,6 +731,8 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 		nfs_list_remove_request(req);
 		if (request_commit) {
 			kref_get(&req->wb_kref);
+			memcpy(&req->wb_verf, &hdr->verf.verifier,
+			       sizeof(req->wb_verf));
 			nfs_mark_request_commit(req, hdr->lseg, &cinfo,
 				hdr->ds_commit_idx);
 		}

