Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0C5131762
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 19:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgAFSUZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 13:20:25 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41618 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFSUZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 13:20:25 -0500
Received: by mail-yb1-f193.google.com with SMTP id k5so2949279ybf.8
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+DoU9c16qOJBTwhodTBS9tAvwt3McnxPZo6WbuuM4s=;
        b=XoROECx0J9seBlfxwv93TVEW3amti3VRyvP6zyqQF86P13CFH9wNp+FnZPz9kgDsHx
         3EYZ2BMcfTZusNUL225jcZBLuPVRHtZ4Foqhfas9BpIj1t3ZCIEK1711HyzBfxRrfrMe
         02JmcpsxqYXFJikLfEMkRlhrOZTT3aB46a2Sgc7YxCGsdzxZJY9RmPAHTo5Iep3QP5bb
         R7ZRqja/L1kERvzmaPjuU7zj4dD9sjLpapzm3qHHZGf7+T+wXW1eRVI47f35T0015ZTv
         C5h30Bv2yxmc6pjbycJ5V1ZFPyj4DuOY7XJQprWr72UHzveR41IlWLXT/N0pu37zU/Nx
         tCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+DoU9c16qOJBTwhodTBS9tAvwt3McnxPZo6WbuuM4s=;
        b=Fdqxg8h9L+paCxQ42eGVuKXCwB+/S8PM/LQfovewRHwfx+h2PpgK7f1Gj78gy0pOir
         Y2OQ6Dmovs2U/vjregL+5xdZInd7TuvKaERCYmibXwseqVoFRqTDVkwKQWR6RVq1h0Mg
         hI/nqisLPj5221V5FWbwU57+ubw0WAkJB9LVh0LK1ntjbNaec189wtHJEOnjPscOKfrD
         wvlPo60i4gux9PlcUcoC8Q8sLVPejUOV6WK9fKI28OedFf0zrWBPO8Ri33pxnaTG0Vom
         WpY/ok5TBRoyUj2oYWYsK+qa5YzR2FIcyKPrjUAVsSj/mnVh4RtB3tVxALd+cVXIX+mA
         l4jA==
X-Gm-Message-State: APjAAAXSM8RZ2fUCdfvmHBE4G0IoMIgVrRsYcTnh8LM0sjru0Fg4/4JV
        3sXRr56BRgyQw773GFhMAFaM4PAaug==
X-Google-Smtp-Source: APXvYqz139j6u32yBB4/DHz0YJ4yKLIfuK8oqFvWhQiINi3S394kYGpRWv8SKILirce/Rn7zEh/Tlg==
X-Received: by 2002:a25:d2c6:: with SMTP id j189mr79374296ybg.374.1578334823589;
        Mon, 06 Jan 2020 10:20:23 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id r31sm24800524ywa.82.2020.01.06.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:20:23 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RESEND 1/6] nfsd: fix filecache lookup
Date:   Mon,  6 Jan 2020 13:18:03 -0500
Message-Id: <20200106181808.562969-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106181808.562969-1-trond.myklebust@hammerspace.com>
References: <20200106181808.562969-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the lookup keeps finding a nfsd_file with an unhashed open file,
then retry once only.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 32a9bf22ac08..0a3e5c2aac4b 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -789,6 +789,7 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct nfsd_file *nf, *new;
 	struct inode *inode;
 	unsigned int hashval;
+	bool retry = true;
 
 	/* FIXME: skip this if fh_dentry is already set? */
 	status = fh_verify(rqstp, fhp, S_IFREG,
@@ -824,6 +825,11 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	/* Did construction of this file fail? */
 	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+		if (!retry) {
+			status = nfserr_jukebox;
+			goto out;
+		}
+		retry = false;
 		nfsd_file_put_noref(nf);
 		goto retry;
 	}
-- 
2.24.1

