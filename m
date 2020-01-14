Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8724413B02F
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2020 18:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgANRCc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jan 2020 12:02:32 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43450 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANRCc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jan 2020 12:02:32 -0500
Received: by mail-yw1-f66.google.com with SMTP id v126so9599785ywc.10
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2020 09:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XJzOwwa46IxUxZN6OzSr2hsV41A8UOkH+Mu7jcmN8k=;
        b=NsBSr6t7SuaaitiXPz2uPSbUjbBAc+r/BhomyX8jaleYN+xJCQRrC4mTIUWWqVPljq
         5/Xx22TmsgzlEG/fPG3Lbr/zAm10mi1oSY9c9M9cd/62dH8dmkfNaFsMQW9v1Og9xT8W
         ZsK7LZgDthE8EwpZ6Pw2oUCIZN8ZWN9RoDZUf9atqlsoTSlUNbQe7Bx56InC1rEJ6beN
         yS7eOq/7/cKrwUmj+yly89TwI/QxL5e7n0xTR3y78c0OOCGTHYNmJkzB+zp0IbR2k3LB
         AcBNBzJQ+J0FRKlfQOdqYhbBh5yQx4gNo+Qjk9+FyiqC0lXQlfXTsZ+3Bj7GKXOeWhbT
         3Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XJzOwwa46IxUxZN6OzSr2hsV41A8UOkH+Mu7jcmN8k=;
        b=tiEMaVEUosr1oW+8C9dr8n5mjb8jFTSayiEsfRCTSLcE45G4KgDFcAv0gYtqIcT3st
         ChLd4kGa5szmtw+eUCWlHnORgRltP0Swk7h7fcoNPV23guPvGsiyZtiTECLovcE5Se5S
         yWim4gKKlwOgN8VqE3rEvkd5OT7mYGyKxOKljYc4fX9DKlOsv3BRYulxw7jLBi+rihmf
         apYDbxFft9nJm/vXwgqozZlsnvwb+7TTyhlCdsOO2r44pPiHMJxM09rXz1lQ4bj1jdxq
         fcqauW6wyzb7Em9n4g55oSrW9odnMMQN8GJPl5dkbB5BFJTTMs0MtOtEuCJ6TwufhIvQ
         mFLw==
X-Gm-Message-State: APjAAAVeDJUaPReJGMxyEoPLPxtQvLbZFAUO19MWwuOM7aket8cpTv7p
        tcu1oCXPu3bSk2yExKE8xRDsKfk=
X-Google-Smtp-Source: APXvYqx8M9Wzvs2DQ8wEFblWmIOW9spp//VgiPskb+BA36XjrYa6vfA1M2G4Y4nFKe+JcP2v7niVUg==
X-Received: by 2002:a81:b1c3:: with SMTP id p186mr13943258ywh.398.1579021351626;
        Tue, 14 Jan 2020 09:02:31 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q185sm6926930ywh.61.2020.01.14.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 09:02:31 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsd: Fix a perf warning
Date:   Tue, 14 Jan 2020 12:00:21 -0500
Message-Id: <20200114170022.923083-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

perf does not know how to deal with a __builtin_bswap32() call, and
complains. All other functions just store the xid etc in host endian
form, so let's do that in the tracepoint for nfsd_file_acquire too.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/trace.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index ffc78a0e28b2..b073bdc2e6e8 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -228,7 +228,7 @@ TRACE_EVENT(nfsd_file_acquire,
 	TP_ARGS(rqstp, hash, inode, may_flags, nf, status),
 
 	TP_STRUCT__entry(
-		__field(__be32, xid)
+		__field(u32, xid)
 		__field(unsigned int, hash)
 		__field(void *, inode)
 		__field(unsigned int, may_flags)
@@ -236,11 +236,11 @@ TRACE_EVENT(nfsd_file_acquire,
 		__field(unsigned long, nf_flags)
 		__field(unsigned char, nf_may)
 		__field(struct file *, nf_file)
-		__field(__be32, status)
+		__field(u32, status)
 	),
 
 	TP_fast_assign(
-		__entry->xid = rqstp->rq_xid;
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
 		__entry->hash = hash;
 		__entry->inode = inode;
 		__entry->may_flags = may_flags;
@@ -248,15 +248,15 @@ TRACE_EVENT(nfsd_file_acquire,
 		__entry->nf_flags = nf ? nf->nf_flags : 0;
 		__entry->nf_may = nf ? nf->nf_may : 0;
 		__entry->nf_file = nf ? nf->nf_file : NULL;
-		__entry->status = status;
+		__entry->status = be32_to_cpu(status);
 	),
 
 	TP_printk("xid=0x%x hash=0x%x inode=0x%p may_flags=%s ref=%d nf_flags=%s nf_may=%s nf_file=0x%p status=%u",
-			be32_to_cpu(__entry->xid), __entry->hash, __entry->inode,
+			__entry->xid, __entry->hash, __entry->inode,
 			show_nf_may(__entry->may_flags), __entry->nf_ref,
 			show_nf_flags(__entry->nf_flags),
 			show_nf_may(__entry->nf_may), __entry->nf_file,
-			be32_to_cpu(__entry->status))
+			__entry->status)
 );
 
 DECLARE_EVENT_CLASS(nfsd_file_search_class,
-- 
2.24.1

