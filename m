Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08447B4243
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 22:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfIPUqc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 16:46:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39180 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733156AbfIPUqc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 16:46:32 -0400
Received: by mail-io1-f65.google.com with SMTP id a1so2296946ioc.6
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=owbPNNcxjT5XKu6v3G4mEstWx8051g6tPkh8ytztNTM=;
        b=MyHmdb/n26VD6LgAUwgE/tpuztM2eJ8jOk9xRQ5awqpVNLVb1tAos7V+hO3s1DXLol
         UhzRyhdLyOq7iT1buBndKffWNb2y1HmV07nNfrFqS9TF+xkDoRN77+9KTTY36q98RsFu
         Jy42EKPJbUE5LxjCtycj5e3SrmmRSK1KSlUdI18B7UFC4OYi55kBANV08dcHe8MOq41n
         UGQ+eKEqR+EgVJ784NvDlqooQOJIVvdw4GBUm9bChpuiZwHJeIo6PyNQvFzCJiGIGORC
         FP0D37lSXxc8znysvwmCXcOOOj+J/82UaXqaf+6cbNAQNsQaObjZeMJh4nDpZ4ba9rWI
         d4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owbPNNcxjT5XKu6v3G4mEstWx8051g6tPkh8ytztNTM=;
        b=gyYb64X/yVkp7Ev3dusn8xsxuMROy9sEIYnaNbKVMEvhfQ0FR7Cgb2o61uqFy4THTc
         geUNcxCCdfyRmYnpAAb6tgu1hfRhtldJ8bLcxEq/stPOyBPRtxShmdXZnRPcYKHFjz09
         I6p83eUEJlqMLRlrCnPrp2isfnkG8L/f9wJlRiT8jyU8zQyN/OAB6YB1cebWUxDFR6P9
         51SHsaJFrQhlNeUHBmuVNpBC+kBeU5+qKY+Z8eYNZJ2YTazq/esX2CP3/u/0hEgmi5QE
         EooZEleJRlczMeY4cIaicVkl/tiDP618GeYSLiU0MwEU5Ik2TlHVqjk6Ia/CwGjrT3Rr
         7WIQ==
X-Gm-Message-State: APjAAAX3SfcQLhFu1YZBQ9+rL1ooFw7f5oYO4pfoSbixUjTtNGX4R6vW
        g0+P36Etq8o0TMISJScioA==
X-Google-Smtp-Source: APXvYqwCFaLI1q4hXtXBp94pCVD7+ywIvJooeTd/Sa/mFdhTRwhwjP6D0LZPGeBjuGT+pMsoqjnwBQ==
X-Received: by 2002:a6b:4a01:: with SMTP id w1mr232275iob.222.1568666791419;
        Mon, 16 Sep 2019 13:46:31 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c6sm3528iom.34.2019.09.16.13.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:46:30 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 5/9] NFSv4: Add a helper to increment stateid seqids
Date:   Mon, 16 Sep 2019 16:44:15 -0400
Message-Id: <20190916204419.21717-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204419.21717-5-trond.myklebust@hammerspace.com>
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
 <20190916204419.21717-2-trond.myklebust@hammerspace.com>
 <20190916204419.21717-3-trond.myklebust@hammerspace.com>
 <20190916204419.21717-4-trond.myklebust@hammerspace.com>
 <20190916204419.21717-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a helper function to increment stateid seqids according to the
rules specified in RFC5661 Section 8.2.2.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4_fs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 3564da1ba8a1..e8f74ed98e42 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -574,6 +574,15 @@ static inline bool nfs4_stateid_is_newer(const nfs4_stateid *s1, const nfs4_stat
 	return (s32)(be32_to_cpu(s1->seqid) - be32_to_cpu(s2->seqid)) > 0;
 }
 
+static inline void nfs4_stateid_seqid_inc(nfs4_stateid *s1)
+{
+	u32 seqid = be32_to_cpu(s1->seqid);
+
+	if (++seqid == 0)
+		++seqid;
+	s1->seqid = cpu_to_be32(seqid);
+}
+
 static inline bool nfs4_valid_open_stateid(const struct nfs4_state *state)
 {
 	return test_bit(NFS_STATE_RECOVERY_FAILED, &state->flags) == 0;
-- 
2.21.0

