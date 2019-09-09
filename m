Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5E9ADAAA
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405066AbfIIODS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Sep 2019 10:03:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35012 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405119AbfIIODS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Sep 2019 10:03:18 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so28185074ion.2
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2019 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=owbPNNcxjT5XKu6v3G4mEstWx8051g6tPkh8ytztNTM=;
        b=ia67wefXuFxZMgxGJMvrs1gqh8QiaCeHbp2Cvfxt+89TJyUrmNgJqGeohFnCxx5zGG
         HyIZZI0svLnBGlnZHJxHFFw56qka1Sbsnf6YIsbZX5ZSMjpsUJ/kUGFNYJS56Trw24qr
         GaLwep7yVriBxxDpFab0LMuUGF/j476Lb0SSzwos5yLjWk4wveJsno1yyFGG7QTxH/t0
         y4eUlWekYJ4XozUK1EiOZ1nW+fxJxBLRPO8g6m7QU82UoYs7s2zxaD4GFo7ucaEDnIkC
         wC5c0qJdFWQAE6/Vu0Qchn1d94hFwugnabwDAtT44joqMOtIgBoGuVRS/Rjjx8oz9LdC
         ZCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owbPNNcxjT5XKu6v3G4mEstWx8051g6tPkh8ytztNTM=;
        b=alLsCYVTzrOTjg/NjIvjHj8UWH5uoANfJuuWSVDKEZpW0w0yvD61574giOHoDg8hOV
         rRU70fjKERW0iBL/oFzEFE+5rlnmKzTGFkp8of5AhQV3JWZ3pedfV8D+9Xckpd2hissB
         DFRcJY8Lx/yucjGEkn/9xyxbk5HNTV9oxL1Gi72WCtgHki0Q/syOpElbeOTOOatzWDBN
         NQUVogdALKkn8seudNoVAyEcKoZf3D0vOSSBCM6/EZXegHsw4ii2GpsKhYCv2mAXyxYA
         YxmENYBjI14RfbtgRNSn8gzGkP2ozXhblaSKFQEZ0J/Ys/ccSyaWVF9QGNZ1jFIgolxZ
         hvkA==
X-Gm-Message-State: APjAAAU68kS7LDh6IlFe/dKwWj5JOoybvq1MoimeNQsX+pbCeDZ6cEa7
        M+lmLYD0Mk0ruFaTj1cRLOfUW9CeMw==
X-Google-Smtp-Source: APXvYqz3w6/AFTGe9IlQeGhQPVKcJfeY5C8H+2s9giEPu3vlWQAshz9FWU6TgLhAC+N19s3lWvPfeQ==
X-Received: by 2002:a05:6638:681:: with SMTP id i1mr25367999jab.127.1568037796898;
        Mon, 09 Sep 2019 07:03:16 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id h70sm33727176iof.48.2019.09.09.07.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:03:16 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/9] NFSv4: Add a helper to increment stateid seqids
Date:   Mon,  9 Sep 2019 10:01:00 -0400
Message-Id: <20190909140104.78818-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909140104.78818-4-trond.myklebust@hammerspace.com>
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
 <20190909140104.78818-2-trond.myklebust@hammerspace.com>
 <20190909140104.78818-3-trond.myklebust@hammerspace.com>
 <20190909140104.78818-4-trond.myklebust@hammerspace.com>
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

