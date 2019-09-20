Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B94B8EF4
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 13:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438180AbfITL0H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 07:26:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40436 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438179AbfITL0H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Sep 2019 07:26:07 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so15276858iof.7
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2019 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/GVnqkPBoCv5U4dJF5GCvANtn9QnHDChOd9TrjN6yM=;
        b=sYjAxxLpC/LlUJ+bj3BSCbHLMivh+PBEPoG59tTC+BZIdR+GLdv1QHKTYFbri8sWlD
         hGqzitV0A6NXGLgL+gDuVy+VB1EoWvaMgPMiqt/Mxmz4ERT51bRp3jH/P5S10cnqSvkZ
         f50QazNDGpccN6izCkUaoo6SmfJ4bWmMHkEC0uEkkno37oDxWwI5XJUtuTRrgBC4heIs
         Vf0pdTZ4e6ukVqm7AAsBQjCAWav3vp5tIIh3QWP5CFsFJqwALea/XAsXgJQTDKzSxMAa
         pcYl+flUnLr2OF2o4I+IHvel8Wjpuo9+GbjvvkalwMZr3W38MP2Q8WDQDYYfwLbP4+NU
         kGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/GVnqkPBoCv5U4dJF5GCvANtn9QnHDChOd9TrjN6yM=;
        b=QKHuvYzNbllEmPPtI61AxQVMfPsRA3ssktWEGhOGThxQqMgdeYLFDCvlEC7Mpcw+mo
         fceRNbGSe9S9LuMNKkRgVPcnCxDe7+xVTRqR+ndg+9kcWh1118RUVzi+2iaYgAeQmyQG
         R9ddNU+B6u1V0ceqOGyu+oa+Nal6ZpF/kzVGZvICZbPYVW01YHVz/6kOHTuud/+rHw4v
         tCeQTAT608pYgi5UY6UKuOdKrfavY7nUpzceRzhW080dr3go1CHon0liQSD7nuixoOT0
         H4aJkf9zv4YJlkPMlD/bxjMZ5pfNQ3INskQZmqhqqISLhig2rmpMGWPRBnCCio16fOp2
         gvyQ==
X-Gm-Message-State: APjAAAWL9Xaihe69GbJobIR+eDG7SjgbmJ8ly0tteHDio3l9hFN/AZ4S
        cQlMxPw9d3YVWBGKibw8QA==
X-Google-Smtp-Source: APXvYqyaRoi/XdiVjra3MX6cYTtq/I70T7eOCUTG3advkWgwJSGMyfoDhHR0JwMNRN+gLZ1wzi7emg==
X-Received: by 2002:a6b:1606:: with SMTP id 6mr20043034iow.108.1568978766426;
        Fri, 20 Sep 2019 04:26:06 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q74sm1308736iod.72.2019.09.20.04.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 04:26:05 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/9] NFSv4: Handle NFS4ERR_DELAY correctly in return-on-close
Date:   Fri, 20 Sep 2019 07:23:42 -0400
Message-Id: <20190920112348.69496-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920112348.69496-3-trond.myklebust@hammerspace.com>
References: <20190920112348.69496-1-trond.myklebust@hammerspace.com>
 <20190920112348.69496-2-trond.myklebust@hammerspace.com>
 <20190920112348.69496-3-trond.myklebust@hammerspace.com>
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

