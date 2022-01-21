Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C219496540
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jan 2022 19:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiAUSuq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jan 2022 13:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiAUSu3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jan 2022 13:50:29 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37558C061744
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jan 2022 10:50:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r187so223325wma.0
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jan 2022 10:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QzwXz4OCrvfFZ3/TGNeC9Jj5eqEDnWOIs9bPsoJq4X4=;
        b=f7o2tLUFNZ1FfRj+Nc3Wr4lSyWT3Dupaca9lu5FQYRcmIJQ2Wfuv0SURexlN8f8UjV
         Rx2qNhPrVK45dgw63jVGUZ+WpOcWpyUqDGqY3Y/DhTZh+Y/7qfaJjWKAw3Gt4FlBu1zp
         WG1lvLtlxw4yV46SVUSueL95sWVlyffcaapP/S4Fvfy7W80EEFgZftCNaXhKGpWlgm7b
         IXrpingJAxzMP7cNT75CLyHdfElOUO/3DqyZ4D8roakLefFZmb5Iy6nCF08oYS1nC6La
         La+mbsJkwADO/12GUIna7eytgZNdHZIDWeUcKVsYKZFmp5yIRMDA6DcAFHFZyGe7nCKt
         p0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzwXz4OCrvfFZ3/TGNeC9Jj5eqEDnWOIs9bPsoJq4X4=;
        b=3sm9/+lnQWy2aCvV3rwa1Z0hUKn21TcDg7KuEa1wh2EMkofo43DagaHTvo/zcFLlHQ
         G+GhQbk8toc/NO+8F8KXUlw9+vumLOYYLf1AaalreGxHzKR/I9OGnxtcO7Xfx4APidty
         9EiOjLJB8ubghx2CoHlAqR+HVKsWP87OZsW8RfVONH2C+1QuJ28vgOeocwW3HHXjLK1e
         g/IVJpinGkwmwEsbuy2rPDebzz2YX9jB1+6Bkhi4hxYAF/rYqPBfCjckOT8MDkIx1SBZ
         Pja+Ibe588LBUuqevyUD/1lILMQjPqOll5i9p4as24gIvJ8Exvvazl+uombNOO2xjxnl
         dhww==
X-Gm-Message-State: AOAM532H6p7CNE13EdWaG+NP2CQUx/aaNHfIrryV97gffOhiqVXSXNDc
        456JtTbDA/3J57Wdl3APGpy9nM4+1YgGag==
X-Google-Smtp-Source: ABdhPJxJi0le0iMeKqV+c/ZRKPYexdJd7wBI7vvjApd20EBCgW0AqvSc4Nk2wc6okiKD/E6HXCGvfw==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr1915548wmh.57.1642791025807;
        Fri, 21 Jan 2022 10:50:25 -0800 (PST)
Received: from jupiter.lan ([77.125.69.23])
        by smtp.gmail.com with ESMTPSA id i8sm10536479wry.45.2022.01.21.10.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 10:50:25 -0800 (PST)
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     trondmy@kernel.org
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: trim reads past NFS_OFFSET_MAX
Date:   Fri, 21 Jan 2022 20:50:23 +0200
Message-Id: <20220121185023.260128-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <fa9974724216c43f9bdb3fd39555d398fde11e59.camel@hammerspace.com>
References: <fa9974724216c43f9bdb3fd39555d398fde11e59.camel@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Due to change 8cfb9015280d ("NFS: Always provide aligned buffers to the
RPC read layers"), a read of 0xfff is aligned up to server rsize of
0x1000.

As a result, in a test where the server has a file of size
0x7fffffffffffffff, and the client tries to read from the offset
0x7ffffffffffff000, the read causes loff_t overflow in the server and it
returns an NFS code of EINVAL to the client. The client as a result
indefinitely retries the request.

This fixes the issue at server side by trimming reads past NFS_OFFSET_MAX.

Fixes: 8cfb9015280d ("NFS: Always provide aligned buffers to the RPC read layers")
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 fs/nfsd/vfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 738d564ca4ce..754f4e9ff4a2 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1046,6 +1046,10 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32 err;
 
 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
+
+	if (unlikely(offset + *count > NFS_OFFSET_MAX))
+		*count = NFS_OFFSET_MAX - offset;
+
 	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
 	if (err)
 		return err;
-- 
2.23.0

