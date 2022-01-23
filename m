Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4B64970CE
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jan 2022 10:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiAWJu2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 04:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiAWJu1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 04:50:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F47C06173D
        for <linux-nfs@vger.kernel.org>; Sun, 23 Jan 2022 01:50:27 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i2so8096592wrb.12
        for <linux-nfs@vger.kernel.org>; Sun, 23 Jan 2022 01:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RuNGBK5fcLDz16QYm/SZdAAhoFtbTtCIr23eV0j1CbY=;
        b=aCUvNhOgxiv7iEllvx7gkGwDmM11Q1V7U948L9VX/bdcrZAk0EguWnp1asEjJalQAe
         j6ubcaB8PedcJnIv7Tu157M0Fis6Avz11NPksdZ/xBsfwaLTK1ftvMdTSnGa47Q2eiOa
         aYk8pmzNfmm/cj4z48QD658LAxtqNktvPKjJS6bGWelJHny1KYUJYRea1AXoOrbqvTgb
         oOY+mrkjUGoVZXTgZ7PIMBC7mjOvwkjw6yHZnVcVl5CSQP6SKEOKo3zpL3kkAmOkwAvM
         E5GcLdHg2ph+SIrdeUmtZo82+9cBOn6EEson+SYvwMifWC1GKDkk4OjUZXzQqVpRIB7d
         6D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RuNGBK5fcLDz16QYm/SZdAAhoFtbTtCIr23eV0j1CbY=;
        b=APe3JrxvYqu5KU6HvvSl87VVT/np0weoR/ldvGS2B818YrxseFI74mW5Zvsk6k33l3
         RUHEldstxEzad1smO5q2kgSsWQMmL7biy/nMKvWM6eBLiDB63RWXLdx8XkmvZ0McA2Tc
         DYR98RRRQtD1BUaksWyxuUWmELwMzEfiRdfHyxxls0y9k77+D4nZ1ywX6Fs6CTmHxwsL
         BtXe743z3ol+rPYh6lIwBvzFhBqRQNMCkzifcxWp3W5fvJDYS+kv4m3jaWDytK2fihNQ
         1/2cqlyZ+07E0blYVFTjXgA9cqvieR4l4IpE9TXItF387PdBesgfK1cS721XGhVnIKzR
         V4cA==
X-Gm-Message-State: AOAM531eJL5CIyWK/CS29yEeEBkZ2T8tO8Iav9f1Ixq9+f9M4jXT07yg
        6hqwzQiBjwfO3SSQn2fitlQSbA==
X-Google-Smtp-Source: ABdhPJx/8uQt9m559xgwEP6XRP2PrC7Kt3y0ER9D4MSUWqaFcYyBZqVDD2XFnP/n6AV71YxH3ERPmQ==
X-Received: by 2002:a5d:6510:: with SMTP id x16mr1244087wru.613.1642931425997;
        Sun, 23 Jan 2022 01:50:25 -0800 (PST)
Received: from jupiter.lan ([77.125.69.23])
        by smtp.gmail.com with ESMTPSA id v5sm15617006wmh.19.2022.01.23.01.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 01:50:25 -0800 (PST)
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     chuck.lever@oracle.com
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3] NFSD: trim reads past NFS_OFFSET_MAX and fix NFSv3 check
Date:   Sun, 23 Jan 2022 11:50:23 +0200
Message-Id: <20220123095023.2775411-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <ADEC85C2-8D72-4E25-A49B-2039C1FF82F2@oracle.com>
References: <ADEC85C2-8D72-4E25-A49B-2039C1FF82F2@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Due to commit 8cfb9015280d ("NFS: Always provide aligned buffers to the
RPC read layers") on the client, a read of 0xfff is aligned up to server
rsize of 0x1000.

As a result, in a test where the server has a file of size
0x7fffffffffffffff, and the client tries to read from the offset
0x7ffffffffffff000, the read causes loff_t overflow in the server and it
returns an NFS code of EINVAL to the client. The client as a result
indefinitely retries the request.

This fixes the issue at server side by trimming reads past
NFS_OFFSET_MAX. It also adds a missing check for out of bound offset in
NFSv3, copying a similar check from NFSv4.x.

Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 fs/nfsd/nfs4proc.c | 3 +++
 fs/nfsd/vfs.c      | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 486c5dba4b65..816bdf212559 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -785,6 +785,9 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (read->rd_offset >= OFFSET_MAX)
 		return nfserr_inval;
 
+	if (unlikely(read->rd_offset + read->rd_length > OFFSET_MAX))
+		read->rd_length = OFFSET_MAX - read->rd_offset;
+
 	trace_nfsd_read_start(rqstp, &cstate->current_fh,
 			      read->rd_offset, read->rd_length);
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 738d564ca4ce..ad4df374433e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1045,6 +1045,12 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct file *file;
 	__be32 err;
 
+	if (unlikely(offset >= NFS_OFFSET_MAX))
+		return nfserr_inval;
+
+	if (unlikely(offset + *count > NFS_OFFSET_MAX))
+		*count = NFS_OFFSET_MAX - offset;
+
 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
 	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
 	if (err)
-- 
2.23.0

