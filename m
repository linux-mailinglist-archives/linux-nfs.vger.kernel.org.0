Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D40F264F87
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Sep 2020 21:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgIJTpW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Sep 2020 15:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgIJTpR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Sep 2020 15:45:17 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A98C061757
        for <linux-nfs@vger.kernel.org>; Thu, 10 Sep 2020 12:45:16 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t20so5828080qtr.8
        for <linux-nfs@vger.kernel.org>; Thu, 10 Sep 2020 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gVB+CP2df8D3vNUKNfDeFpJJku1gvf+U2vV0gEGbmDo=;
        b=jgTyipaSSYcDGH+Kzl72kCU1ByV/3nvRsquoibTP4z8BLvPgXNseLOFRwdc5vDX4qi
         v5aH++3aaHmGqd3keGWBvBJ0SNuFkzLPgz47HHU382vBhIoW0zGuuOjkdfsTiqMbf6zG
         KATXeqefKaecS3Ly1A2giFujjNrgg99NE14QRL4/jO/uJWJLZSxCfC7iQka00O7/8DEC
         M0WX9e0Lj17DFIyWKqq02939AVXFdSIQjSILGzM0Vuhf2h/ipMRUerHtfDtknuds/suP
         e0NgPxHgRWowh+OUdMkydnIFHupwEl4CFslk8gFIDXq9JlpnADjfSOyjfJNfE6EKfpXO
         xxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gVB+CP2df8D3vNUKNfDeFpJJku1gvf+U2vV0gEGbmDo=;
        b=VYVfLzhEgle3sTHICl/BLzSAW2O19XSlj1a/lIHmMi670V9h35boCPjyEdd2DioSR4
         7yrwvUwI176QnaYwL5CFxAaF1dV20fQqeQtyuMOtXTwAZV5wb2svXf43Skl5IjLL80C9
         ExNpNWQ8ZyHbriJ12I2JYOuVyWpD31er6XVtBoqCa4uHSpMfmwi1B6nOBIHGk5zuKC/t
         QMxjcq7/sBWhbvCFNL5G6EH1tL58MoIoC9UQGRTGHAc9NK5pC1dSw5DYH0dqtOHl3n8j
         GwgHBQVcWJsz8sP3BYrwVRoY0K5nYLEgB/+ioLSL6re3yOYcvhN5xWHIyYQMmpOcA0LY
         sPkA==
X-Gm-Message-State: AOAM533wHPozJqmnb7i1IlfJKACoqMNU2dmW2E4wjK4LzU1fGfBMgQPZ
        +/Uok6YEFOhdmFDSYcT541E=
X-Google-Smtp-Source: ABdhPJwgb69FwhdwDiju8fgliNLpXF/d021Cv+E+90P6jMBdzVwtWQ6Tox83u/q1rt2OK20dVD9X6g==
X-Received: by 2002:ac8:2be8:: with SMTP id n37mr9841004qtn.107.1599767116156;
        Thu, 10 Sep 2020 12:45:16 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g14sm7485085qkk.38.2020.09.10.12.45.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 12:45:14 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08AJjChm030345;
        Thu, 10 Sep 2020 19:45:12 GMT
Subject: [PATCH RFC] NFSD: synchronously unhash a file on NFSv4 CLOSE
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, trond.myklebust@primarydata.com,
        jlayton@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 10 Sep 2020 15:45:12 -0400
Message-ID: <159976711218.1334.14422329830210182280.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I recently observed a significant slowdown in a long-running
test on NFSv4.0 mounts.

An OPEN for write seems to block the NFS server from offering
delegations on that file for a few seconds. The problem is that
when that file is closed, the filecache retains an open-for-write
file descriptor until the laundrette runs. That keeps the inode's
i_writecount positive until the cached file is finally unhashed
and closed.

Force the NFSv4 CLOSE logic to call filp_close() to eliminate
the underlying cached open-for-write file as soon as the client
closes the file.

This minor change claws back about 80% of the performance
regression.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3ac40ba7efe1..0b3059b8b36c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -613,10 +613,14 @@ static void __nfs4_file_put_access(struct nfs4_file *fp, int oflag)
 		if (atomic_read(&fp->fi_access[1 - oflag]) == 0)
 			swap(f2, fp->fi_fds[O_RDWR]);
 		spin_unlock(&fp->fi_lock);
-		if (f1)
+		if (f1) {
+			nfsd_file_close_inode_sync(locks_inode(f1->nf_file));
 			nfsd_file_put(f1);
-		if (f2)
+		}
+		if (f2) {
+			nfsd_file_close_inode_sync(locks_inode(f2->nf_file));
 			nfsd_file_put(f2);
+		}
 	}
 }
 


