Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61041191ED
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2019 21:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfLJU3q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Dec 2019 15:29:46 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37188 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLJU3q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Dec 2019 15:29:46 -0500
Received: by mail-yw1-f66.google.com with SMTP id v84so1484718ywa.4
        for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2019 12:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9z0I4z27omUwUY16yCeHYxB+5qzZFnDqr3pTad5jvg=;
        b=Ra7wfKfo5lKntPVufclepjjeZyQCKXncT2TmnnGn9K0+O3KoNgaBD/B94deKEs2dBP
         rcfs+oki22DsEw3txRP4DKVCMKEqRcfhe3lb0uQClFdb1ExWAqqlKRcAO0R7Tinh6mIg
         WWBBsmllmzS/fVJhA2BIm9YtJc8zfYSlFIa2P2C+4GYyvzm4dcP7sHEN19xPG+oC9qK7
         +QuIgKjTM7AM8QoZ8daVbJ0Dc4H44VWY1gctisSeKf3La1LL7XTdebJFJmcOp6GGG348
         F6N/f+k9gMZ806TTrE2IQZ0xK8VAtS8kj4avQcKwoza9rs3Ell9UTQ1DoWwx5aSGpsf2
         HDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9z0I4z27omUwUY16yCeHYxB+5qzZFnDqr3pTad5jvg=;
        b=TPHt3exM8stZTtez8d4JT9YNsVR4LGdTpm21ozSrdAie1FT3EZ5989Iuy4tvrT5hiM
         LHblneU1lMTqPwzeRS0hEoQq4/+9oxvjbCjDAE7u1R7bfC6pQRY2HqZY8DYN2mDwKM4v
         Xo5JewhwYCaP0Ion2U3kllJeck5kJ/YLG4oxV+4TeaKDy5/SlNnbjOIvXcIQNXg+XU+Q
         dL5CDmGxyMCc/1oTvRgINHWfp42IjWJ8lGzbggz8nbqa6Z4s3AhJ36mpBn+ZGGB5DFcq
         vSLKVnPszOEfUOpDwxEiQ27p4dP5T7XcQCMh8x5xhUcJy7FQ72MHnV6Q2/4PRpUwTi0l
         yTPQ==
X-Gm-Message-State: APjAAAUNeMNXrXrT5mcEx25+KX26QfGRG7TZs3eHjC4mn4YIwvJihHDw
        g1gs5pduTcilzvqke5+3fpe1udg=
X-Google-Smtp-Source: APXvYqyQ9JDhIDueQW9WzAtfJD57N3MhpRMVaBemQLIdoYtlYuK5KMy46g6ti43ejI/EyGyU0e6jlQ==
X-Received: by 2002:a81:f81:: with SMTP id 123mr26137811ywp.268.1576009785702;
        Tue, 10 Dec 2019 12:29:45 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id x84sm1947508ywg.47.2019.12.10.12.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:29:45 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 1/6] nfsd: fix filecache lookup
Date:   Tue, 10 Dec 2019 15:27:30 -0500
Message-Id: <20191210202735.304477-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210202735.304477-1-trond.myklebust@hammerspace.com>
References: <20191210202735.304477-1-trond.myklebust@hammerspace.com>
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
2.23.0

