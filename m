Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7711C8BB8C
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2019 16:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfHMOaT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Aug 2019 10:30:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40156 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbfHMOaT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Aug 2019 10:30:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id c34so33196526otb.7
        for <linux-nfs@vger.kernel.org>; Tue, 13 Aug 2019 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JghjEh3a0dlK8vQPtuVSZDHMvcywHIeqQMVlMe6XsHs=;
        b=IbqUw0j8V1j2Qcbi+/Zazhr2BoR8DPkUL5MYR4husAfsAip8l0NC3GcQ3jztxiKZaS
         URPoNakrfNDNztWhiJlWiKU0AUs2GzGRizrGraYuFad/gbYwBet+zn3KA3kls6LBX6cA
         Hc8pQrsOtV+hEZ66F4oL2L2xLBjbFWU4Ds7HDzA8RsjwLe0pLIQ5TDEanbFTV0vlcEqf
         /zUIGMVcCqod9aX1N0ZaRXazrbC/yioTBcrzHZL0625rdIlC3Pf2z2wHZ5aaAAG5l7Mf
         Sg3660Q03b1Jdsci11m8y2CYWipeNXbT9vNMM16ciy1ywtnMxxBdnFT/wZ/p52IdCEvO
         ib4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JghjEh3a0dlK8vQPtuVSZDHMvcywHIeqQMVlMe6XsHs=;
        b=qWdrQbGHSJ08MxNWPD4qf2lTbD63d77Wxuymz4qgprGRZo8GFJvDQ+rZnQDM17hcSB
         CQszZSm5ba7Asucxd1d8hc65IqSpKwd4zjNGrRqYX3FsIF8kB1yW8wuNTZwBnna2IE2E
         NQKI/ezzCaeUvb1PYusU57TKdhxB/Rt/TQLGVyRb1OuFf4OlAN+SQ4kOcdnobgh4280i
         9n9ouBDD9JUrRW92wa4NZyowVsmb7d7chhT1bn+LhQf0KWQopgHxxQ0zS3NEX0+vKJKn
         eoI8OqF++KoCNwnabMGac1Is/Y5ar/gCXp16tmn/VbCM61P6Y8LmDkpnmf0Q6Q8Cxopi
         ExPg==
X-Gm-Message-State: APjAAAV46GpaqRx1efX3/pknxGGLA8Fn+knxGV6ORtyd/FE29aucFahw
        4JmiXP3WbGLJ26mbBER+YLPamJY=
X-Google-Smtp-Source: APXvYqyG0KB8WUu/sB5V57IPZY0XkhwEfLyAZSo3A43gs8ZnXU7IATtjXzNIFM5s31cZtx6IYBfPTw==
X-Received: by 2002:a5d:9747:: with SMTP id c7mr7477131ioo.244.1565706617562;
        Tue, 13 Aug 2019 07:30:17 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o6sm9429161ioh.22.2019.08.13.07.30.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 07:30:16 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] NFSv4/pnfs: Fix a page lock leak in nfs_pageio_resend()
Date:   Tue, 13 Aug 2019 10:28:05 -0400
Message-Id: <20190813142806.123268-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813142806.123268-3-trond.myklebust@hammerspace.com>
References: <20190813142806.123268-1-trond.myklebust@hammerspace.com>
 <20190813142806.123268-2-trond.myklebust@hammerspace.com>
 <20190813142806.123268-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the attempt to resend the pages fails, we need to ensure that we
clean up those pages that were not transmitted.

Fixes: d600ad1f2bdb ("NFS41: pop some layoutget errors to application")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.5+
---
 fs/nfs/pagelist.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index ed4e1b07447b..15c254753f88 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1251,20 +1251,22 @@ static void nfs_pageio_complete_mirror(struct nfs_pageio_descriptor *desc,
 int nfs_pageio_resend(struct nfs_pageio_descriptor *desc,
 		      struct nfs_pgio_header *hdr)
 {
-	LIST_HEAD(failed);
+	LIST_HEAD(pages);
 
 	desc->pg_io_completion = hdr->io_completion;
 	desc->pg_dreq = hdr->dreq;
-	while (!list_empty(&hdr->pages)) {
-		struct nfs_page *req = nfs_list_entry(hdr->pages.next);
+	list_splice_init(&hdr->pages, &pages);
+	while (!list_empty(&pages)) {
+		struct nfs_page *req = nfs_list_entry(pages.next);
 
 		if (!nfs_pageio_add_request(desc, req))
-			nfs_list_move_request(req, &failed);
+			break;
 	}
 	nfs_pageio_complete(desc);
-	if (!list_empty(&failed)) {
-		list_move(&failed, &hdr->pages);
-		return desc->pg_error < 0 ? desc->pg_error : -EIO;
+	if (!list_empty(&pages)) {
+		int err = desc->pg_error < 0 ? desc->pg_error : -EIO;
+		hdr->completion_ops->error_cleanup(&pages, err);
+		return err;
 	}
 	return 0;
 }
-- 
2.21.0

