Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B02FE62952
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391658AbfGHTYu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:24:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44496 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391667AbfGHTYu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:24:50 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so37836330iob.11
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yo9sLYVGIpnI5eQhl4Hmyu40q9FnCAike73i03d2rRI=;
        b=rI9vZrH1Rv9A+8HtuhI7Ouvhd1DmxDu2dcPEDLNBJe8FSihO4AJJZlkQvZTu6Eb9o6
         +Q79YG/EgQLpQXSXqN3RLDlpCi1GkowN78mFm9o3d1hYSxRWFWkPz76hsExr0rq+dyOn
         tX7d1fwZx7lAmkDSeK+xnSr/+wowB3pFpblIjQKcugScWaS0qrm6nllUoHwO7lnOt6I3
         tN7SWLWEIiXCW/5zH1fmRuJ+MB6S5CNMubxQVZfK35N+HKmea6WhfAXO2qmNSGj/PPN2
         5lpcL09PvLNx3h6npLsduVNf9mekGVZWxNoFp7WoI21g+9k6hntEcT41IiOVqY2x7Hjk
         tWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yo9sLYVGIpnI5eQhl4Hmyu40q9FnCAike73i03d2rRI=;
        b=oDosbn7Qm7B4Ls+QX2zBCQCeduh/ayjABjzbzbZnDXNM/jk7ZK7vti69Ahcb/sa+ic
         sa7azx9tSfvz89PVYGngjuMZtVhZOJGF7VkZTG2r8CzMx6UYjLwpKRTQkJ0C63eTtC9Y
         00RWZM+fHPXNBbyPIQkQTLEC/7uLC8bZdpuSuR6HVlAVYlHuiTxyV3jq3W2mQtmAmvl2
         7IdpuS5scyCWdryIAe1r+Ol5SWdhSAhMLp7H36VXiApt093pw/gaIBCenNRh+0SqcrK/
         8Mu7Kq/K4A3tD8WMDhekpozST2qeSLuqt9kWpde/neAltqLyk6zbveqaTtAxJMnTiOoL
         LsfA==
X-Gm-Message-State: APjAAAXJLucMB2Kok4yliFhEmoc9D7rJ0s24+eGrOAPN+70Sjn4r6xkw
        NmYPJiQiv0mC4FNbPCRMtPU=
X-Google-Smtp-Source: APXvYqw4jRl+5ZMZL7srLmkj0L31Orryo7FxtLaKDCxzS5whOYHAU7AAiUfyxwLYO23fIsqUXp+E+A==
X-Received: by 2002:a6b:3102:: with SMTP id j2mr1018846ioa.5.1562613889954;
        Mon, 08 Jul 2019 12:24:49 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n17sm17026554iog.63.2019.07.08.12.24.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:24:49 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 08/12] NFS: also send OFFLOAD_CANCEL to source server
Date:   Mon,  8 Jul 2019 15:24:40 -0400
Message-Id: <20190708192444.12664-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
References: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
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

