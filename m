Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4886776013
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2019 09:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfGZHtD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jul 2019 03:49:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41332 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfGZHtD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jul 2019 03:49:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so14025427pgg.8;
        Fri, 26 Jul 2019 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kcgszSF7SGtgqO6asgJThdzix30vjkYpL3SbX1/l9qM=;
        b=S7RL3sF6fAAr9nSJCxX1I5CGfHi1fZoq29/8Y54vKt9NparzqgxH+MGASsRXFFoxRl
         2Fa4CXdwa7Np8frIwhdLT58oINTZHixHw7sNI3++angdf18SrkoXmFL/TKmBDvvrosy7
         Rf9LKx39nkzYqiLmGfOzD7jsIMpAIqOMdHeQFWjLPuzKKykongz1Q+rlUuU16JMD4Vki
         NR/n72P4rqeKrE6lSYZ9yqfT18Tod6vlUlgRTkZjMAjxdVdLElVOT5ugS77UDQGSuXXR
         gvDITDQvTuzSYc9p0BhUL4k9rebf7Akf/1Ns+TkYLy9/UkUHpeSCbUgv2nNsu3TycBz0
         d7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kcgszSF7SGtgqO6asgJThdzix30vjkYpL3SbX1/l9qM=;
        b=DFb3YNftGgQX3TPU97jBBgFNdvbUsUj+BzSuWGi0txFrbXMHFwM49xwhQKZbl/x6Bz
         ZH5S7SeW6SiSxKqtMSeHoNfrGI+lXpXp6h9jYT+cPDGkbHl5bulQrxAWlAUslHsnW5fT
         WxNbPE0zNXwIAxbvj+PdaS1BcBcglx0Mf2od5F1XYDSJ2iEUseVXmPgxf/6qaIGMKpWw
         NcwOe+pTycilWoqVoJgjMzp72nIX1OsFyzQ9SVw5WXb1ba7bVLyq4MfWNT/hhqUzErIG
         nU0zyhfNld334oho6T4Btto38vtFm4xv9UHa9vxZRZcmzQUnn5vsT1w6z6PlCR6os0iY
         suyw==
X-Gm-Message-State: APjAAAU19ZZGAFQMwSs6mCu061kjfF00JhY1TvoH2t6OU6zqM8JDJZrk
        q3TUITKszdUEdbaeOpKwBV8=
X-Google-Smtp-Source: APXvYqyUMP+4sSF7o4NruHmGvkqW8wtGgdw1FRL5qBY15mdUudM8NAGVvMoaZ6ejYN6ZaQ6gWffilg==
X-Received: by 2002:a17:90a:898e:: with SMTP id v14mr96717906pjn.119.1564127342368;
        Fri, 26 Jul 2019 00:49:02 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id u70sm14888349pgb.20.2019.07.26.00.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 00:49:01 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: nfs: Fix possible null-pointer dereferences in encode_attrs()
Date:   Fri, 26 Jul 2019 15:48:53 +0800
Message-Id: <20190726074853.4160-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In encode_attrs(), there is an if statement on line 1145 to check
whether label is NULL:
    if (label && (attrmask[2] & FATTR4_WORD2_SECURITY_LABEL))

When label is NULL, it is used on lines 1178-1181:
    *p++ = cpu_to_be32(label->lfs);
    *p++ = cpu_to_be32(label->pi);
    *p++ = cpu_to_be32(label->len);
    p = xdr_encode_opaque_fixed(p, label->label, label->len);

To fix these bugs, label is checked before being used.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/nfs/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 46a8d636d151..ab07db0f07cd 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1174,7 +1174,7 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 		} else
 			*p++ = cpu_to_be32(NFS4_SET_TO_SERVER_TIME);
 	}
-	if (bmval[2] & FATTR4_WORD2_SECURITY_LABEL) {
+	if (label && (bmval[2] & FATTR4_WORD2_SECURITY_LABEL)) {
 		*p++ = cpu_to_be32(label->lfs);
 		*p++ = cpu_to_be32(label->pi);
 		*p++ = cpu_to_be32(label->len);
-- 
2.17.0

