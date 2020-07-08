Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB5218C45
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 17:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgGHPuW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 11:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgGHPuW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 11:50:22 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887F1C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 08:50:21 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id u12so34829973qth.12
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+4dvGsVa2N5qZBTBY4Cn204WCS0Equmlh2E0J4FsNo=;
        b=X05PgNujsoIIBkHZamICcNiatM4uEdqVYW997F5xxwzCFUhtSH+1uh3SnuasyzYhEA
         EuYknMLY8QPExjTbEmMdQ/HTLpXBwpsZ8Rz20JbIg+B2KDXX3U/dmKIhzk7TCkKVnwus
         8HfpmkmYUD2MNC1LDg2QpAYcyfsUCmkXzqYL+nSu3zUbEBx7SkD7Q33HArjyV4KRYKuW
         zrf1jywFnzqdFyEGDJlHaOrT/q63ZP8pKAsouA77XUHSTQRby8wQhZ4NE+Z6mE3EJOmV
         6l2J51zUuN1LmD+yt36LUJvNNb6pjvUALWtoDvlfT14j69x5W/45Cd7FCASuAc0/51wv
         K1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=L+4dvGsVa2N5qZBTBY4Cn204WCS0Equmlh2E0J4FsNo=;
        b=WCCz1clKsRt/1HQx2hA/V+nP5evYsQHaBDzT+3wot+zNLkJeClAPr+xOMHef9Ck0cR
         +5AAbc+EdYP5xKj79OjovoZFQztafDS6qTof3CfSpN4vmKiEsZWD2+ltNjNYwb0OUjLF
         friy5ND8frnDGhIeCcTnL9iAxPJEC0Qu91yVny/u2hN0wLg8x+x6Q8PLIECJtuqPvhry
         D8vMGQGej1W9kEv4hQbZ7pwBh5xLjiYTFJqGB7pJA5/+dhpQIJbVfjN6bRwCRPOsrlK5
         bJEF3Fdc/4UgKi3bYT/2LP2xDQ2uZUkid3QabYX7sU5m5OputC7YNfzTD8ym87UBTRhZ
         VIGg==
X-Gm-Message-State: AOAM533ublXuGgxI0dhJIiuEcH94HnlFtFk3+lxRZf6qAO8pjSpFAMku
        DkfxZNxLmdPodG8lQ8aOhlUTZEUj
X-Google-Smtp-Source: ABdhPJzA6RNFC8sIb0aYFvViBLwsTPsl2CQ44CgAvuitFS1/4DLJkqrvappZrBKOjY2QN2v6p9Qe7w==
X-Received: by 2002:ac8:5542:: with SMTP id o2mr60488632qtr.47.1594223420287;
        Wed, 08 Jul 2020 08:50:20 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id h41sm26996qtk.68.2020.07.08.08.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 08:50:19 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v1 0/1] NFS: Fix -EREMOTEIO error on interrupted slots
Date:   Wed,  8 Jul 2020 11:50:17 -0400
Message-Id: <20200708155018.110150-1-Anna.Schumaker@Netapp.com>
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

 fs/nfs/nfs4proc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.27.0

