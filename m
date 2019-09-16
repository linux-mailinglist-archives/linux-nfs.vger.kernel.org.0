Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38CCB4240
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 22:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbfIPUqa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 16:46:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45443 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbfIPUqa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 16:46:30 -0400
Received: by mail-io1-f67.google.com with SMTP id f12so2197679iog.12
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/GVnqkPBoCv5U4dJF5GCvANtn9QnHDChOd9TrjN6yM=;
        b=hQceF6fhAx1xDuK/qwPYfUSsgcui+y/THlOsBNucaKBBVhJ5DmuoLAFqFcTXAbCNl3
         hEo5NlLGpe6y+PE6IjgnyH+enwCN2JUKXXmD5WOXDCpFZCUy4Moj9Rf1/7D4fJOomeEN
         V77Z9LHgUVyZa4f7AHklCaeRSsgrVcwd/C/61Xe0Dj7kFnl154KEIGyKUho08Md08r/g
         LtIaKqTAO0r3fyza3TPFtsaFggt8EB+SuM+JyzCXAeaaxnMhF5nclTV0udArZKLfV/XX
         sjPDbbEMnSV5lK4153y7MM0Lo1juH2ep81GGZOhKwbacjPaAYj9mI+Lq6XMQ2PW0gAZ/
         aeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/GVnqkPBoCv5U4dJF5GCvANtn9QnHDChOd9TrjN6yM=;
        b=jvOPq2PBBOJs4stX4BDc60EojWQgEScIscMG/QZS5/NxfH8YqY7LaF3m/I6xxu1D6f
         A/dTMUL2HE4LwajL2dKzf4IB7ZOOsOpJVurZOWwk6qvHQiLu107fEGZXCmj8Y6F6ZIP2
         sBsp2QPhX8JpKOtuvRs5nPs2Pwfb1c7Gy4pBQbb0r8rzBADthF6X+5VUcVIGLOWfGBtl
         DVFPoU0b5MP+x4vnFQ5/R9wjRaMY0vpWGGg9pYSMX192z6kmIFVZ9uNawa815aMB2E8a
         hKg/5ym9YD5VCYgnk0jj5PCbh7d1DIaEAAmELz27fEwz/VEIuEGvy1oQ1AePTsgFhC3K
         TFRA==
X-Gm-Message-State: APjAAAWm2gTq5gN6/zS0RTs8YB2U5lDQuSKUvSLVzhJ2n1f2sIlkEp3b
        jmECU5TPHwwyrX5nkjLqKw==
X-Google-Smtp-Source: APXvYqwXxqI9I2I3BLVa9C4mLjWAUGW0PaQFmpeAL/7Bn9+12oNt5wSq5BA3pCi8eel3nCD8ExbH3g==
X-Received: by 2002:a5d:861a:: with SMTP id f26mr212959iol.197.1568666789617;
        Mon, 16 Sep 2019 13:46:29 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c6sm3528iom.34.2019.09.16.13.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:46:29 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/9] NFSv4: Handle NFS4ERR_DELAY correctly in return-on-close
Date:   Mon, 16 Sep 2019 16:44:13 -0400
Message-Id: <20190916204419.21717-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204419.21717-3-trond.myklebust@hammerspace.com>
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
 <20190916204419.21717-2-trond.myklebust@hammerspace.com>
 <20190916204419.21717-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the server sends a NFS4ERR_DELAY, then allow the caller to retry.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 8769422a12f5..6436047dc999 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1455,6 +1455,10 @@ int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
 	case 0:
 		retval = 0;
 		break;
+	case -NFS4ERR_DELAY:
+		/* Let the caller handle the retry */
+		*ret = -NFS4ERR_NOMATCHING_LAYOUT;
+		return 0;
 	case -NFS4ERR_OLD_STATEID:
 		if (!nfs4_layoutreturn_refresh_stateid(&arg->stateid,
 					&arg->range, inode))
-- 
2.21.0

