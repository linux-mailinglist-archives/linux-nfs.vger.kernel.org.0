Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41BDD62951
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391666AbfGHTYu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:24:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35228 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391658AbfGHTYt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:24:49 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so28392231ioo.2
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hf/20/zgdRrBxlarA02mT/b6DodVKxI+tbzEDBpNpDw=;
        b=jxFIO9ay0UFIutz8wc1fDf0y2S4XgJGgDH19BfvKTPbIcCWm/W+CoUJxK3oIIiYvSW
         HOnP0C8DbS8TmgX0Y9XwZSU7PymutoJMcanmFOJlz6w/PDw8rYsWuv41hK0sVDKb1CY9
         kpVKviOjlqzZRMogtZfQJ3zcOwgnEKblRRhq0LmjLQWfnojm7KbPGQo4Tja4aiKTpIlQ
         YzjsxneWGGjhFCMF0z0D1PWtfmSGkmf5JKKKflNRjaNCmGl1rkIEBR4sGCToXiCp22DZ
         ed2M2oLUPpTjdnSJmaV7P3EWuF2l06HGeg/vZ91aofj+d4svxAvkq8Qb6/+ut8cl71Nu
         bpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hf/20/zgdRrBxlarA02mT/b6DodVKxI+tbzEDBpNpDw=;
        b=JDN7garOR0a6G8XcTVDrJEDhLnCZ5xYeROMJvmbx6Rv/Vx0wJILveyPjD8ZL7neJ2K
         qmaOlEpV+50eun1050XsbazLiHPCh7Hee+PBx/5Tl+P1VvsQ1WwEBCyKR4DcnGqKwQJK
         lZwjw8whcNcBPPNkvSAM5GQEiRORmMH5JPwpoifDE0gFtlsPXXK8u28ZPDvtHCpNecRX
         bJQbXr+MYFU0yZJHUPHk8iW0hFJoVxa0If8Bhzt4HSqhLMnkeVVzjLR/nS93EuNJtZ+n
         sFh2zWb6Bff0PrECGSVJ+0CTfJHlmy+W98/09/DY3ZsUMLVIAiA70RIV+YrlGFe1PFJ1
         jzEQ==
X-Gm-Message-State: APjAAAUh2zdAtzsgF03KX/412URjyXLK5x1da775i2zzSg2VYEAxEvCa
        SkEGu1URVYXMcQatH7mGHCU=
X-Google-Smtp-Source: APXvYqy2DQB1YjnCfIzKNX6wLHSN0qozvcL0NxKXAzRydBwK9G8eeJBB4q0OfnnEnAjpsJ7pRw1sXg==
X-Received: by 2002:a6b:5106:: with SMTP id f6mr19008107iob.15.1562613889108;
        Mon, 08 Jul 2019 12:24:49 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n17sm17026554iog.63.2019.07.08.12.24.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:24:48 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 07/12] NFS: COPY handle ERR_OFFLOAD_DENIED
Date:   Mon,  8 Jul 2019 15:24:39 -0400
Message-Id: <20190708192444.12664-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
References: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
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
index 6ed5a16dc511..50538b975aba 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -391,7 +391,8 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
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
2.18.1

