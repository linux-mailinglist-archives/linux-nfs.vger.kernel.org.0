Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451DC21A693
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2020 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGISFs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jul 2020 14:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGISFs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Jul 2020 14:05:48 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23192C08C5CE
        for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2020 11:05:48 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id u12so2339110qth.12
        for <linux-nfs@vger.kernel.org>; Thu, 09 Jul 2020 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=svXVbihCBGsQXqiD3nzmMjGxIgSeIrXBW/KSnNWYnPg=;
        b=aJJHXE+3biSGuZtb7+tGF3FbPK/G0M1KpVHyRkSznDoc0nu6gn/vjIW4vwY8PtoIf5
         JLRDR00QsMzjUqfouNmAcHjI0+ZHg1TO9hlrCjQUshxtkNMY6D66nJ9+QUVqgBHGsugA
         Rn8DksThDBjg6S5d0TZJofA6DfEOUsdUCUD6/qSt9HD55m1ekSLfr7foXsqasRMwNa1t
         WQC0LVL8gpApBI+8gHtWf6LLywIgmtrNAwMu0baPzdYar0eqfjmSJMtrrZ4MwxrbKX0B
         rf27IcUE2goCLBIzijBMpEewpO2l3wD5eQ+wJ1gLIgoUp49zojtA6b+1s81Qsd8cw6m3
         q4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=svXVbihCBGsQXqiD3nzmMjGxIgSeIrXBW/KSnNWYnPg=;
        b=JIGU+Acj5EnELv+clx1DHuLW9JlQ0Z48NPv0RzRDbjWU6lAqbfKQ9Z34SdSYPg130+
         zf8K9n50KLW2of335vePqZFzU2dEABeYAyveaoYDSLGJYbyH2WwgJ2S//TsSY1z7ApjE
         tSZWQRQJTQi3enzlBkS4hJjEpG6Wqt18k0PJFH94q56B/w76Z0+F+dztvNZJ9KGFcK1N
         y22NZoZTMMTMUqXd38e9xT6PNorNJWqJHffPwC/9yIy9iD3QWlaXn0+MNiSIef9Q8xje
         f0OuTI9ur7dGKodGTY10JU/NxNHkb2IJyfeLO5Vuh3URBWBfXbIP446vpXq0EB0GjNl8
         B/hg==
X-Gm-Message-State: AOAM533aIEyXOgX1KHVHQ1kDgYtK7XEYntkQntgAdLiWq3fzSLW+8RMr
        RAzPrpBH3v5JCBc203pxwiKb2UPb
X-Google-Smtp-Source: ABdhPJxFWbzdemE+ISfYiKP7GoBhG9IG5WkzeDMixjPYFwj87ao8e8HqekmmoomwfJFi4EC1yGGiVw==
X-Received: by 2002:ac8:1c42:: with SMTP id j2mr41084366qtk.323.1594317946699;
        Thu, 09 Jul 2020 11:05:46 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id v134sm4532707qkb.60.2020.07.09.11.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:05:46 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 0/1] NFS: Fix -EREMOTEIO error on interrupted slots
Date:   Thu,  9 Jul 2020 14:05:44 -0400
Message-Id: <20200709180545.903715-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

The scenario is as follows:
 - The client attempts to remove a file on the server, but the remove is
   interrupted AFTER the server receives it.
 - At the same time, another thread removes the same file on the server
   before NFSD has a chance to remove it
 - The client then attempts another NFS operation with the same slot.

Because another thread removed the file the vfs returns -ENOENT to NFSD,
which causes NFSD to reply to the next operation on the same slot with
the result of the REMOVE (even if we asked for an OPEN). The client
detects the mismatched operations during decoding, and returns
-EREMOTEIO to the application.

The timing is tricky to get right on this, so I added a 3-second sleep
to nfsd4_remove() before calling nfsd_unlink():

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a09c35f0f6f0..bd93be50eaa8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -851,6 +851,8 @@ nfsd4_remove(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (opens_in_grace(SVC_NET(rqstp)))
 		return nfserr_grace;
+
+	ssleep(3);
 	status = nfsd_unlink(rqstp, &cstate->current_fh, 0,
 			     remove->rm_name, remove->rm_namelen);
 	if (!status) {


I'm able to hit this every time using the following script combined with
the artifical delay on the server:

#!/bin/bash
SERVER=192.168.111.200
SERVER_DIR=/srv/test
CLIENT_DIR=/mnt/test

ssh $SERVER "echo test > $SERVER_DIR/test1"
rm -v $CLIENT_DIR/test1 &
sleep 1
killall -9 rm
ssh $SERVER "rm $SERVER_DIR/test1"
echo "test2" > $CLIENT_DIR/test2


I was able to solve the issue by sending a SEQUENCE using the same slot.
The server replies to this with NFS4ERR_SEQ_FALSE_RETRY instead of an
operation from the reply cache, and we are able to recover from here.

Thoughts?
Anna

Anna Schumaker (1):
  NFS: Fix interrupted slots by sending a solo SEQUENCE operation

 fs/nfs/nfs4proc.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.27.0

