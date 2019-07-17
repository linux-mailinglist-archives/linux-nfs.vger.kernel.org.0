Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74F076C0D4
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2019 20:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbfGQSKl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jul 2019 14:10:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43482 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfGQSKl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Jul 2019 14:10:41 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so47199547ios.10
        for <linux-nfs@vger.kernel.org>; Wed, 17 Jul 2019 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWknZRopD8p9OMK8Koi/AQBMww+znmZ7JvQh1SBVqGc=;
        b=po67loUhSPSqi0yEkBq+dtDeprojwCjor5vjOo3sQcMTWkL17uhg/JSZ0varkhXio9
         eqju4icnQjl+jpM6gFZN8Ql1rbm2ByHWwu8J/pVSJ8+QbyIT/RvQOTyN6b1JVbvW4C/K
         znk36kXA1AtXb13E2hvtwrHE0yTFoYjjQU5mpQRnpEmrDHhQuJ1yeMoXwZ2YEfy9SL4C
         RA0VdrUcEkdsj1dODmrgjufz2Sn/hxTCARbhs+5ghSTZHWTSwZl2eJwlfrTgAfFdD/s3
         DNTkDXFf/RL9HjeLWpARNq4/ePBYwPf12TudHSf2fA/M8ChkNisnyOtjF3yQUbMR1W7+
         KjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWknZRopD8p9OMK8Koi/AQBMww+znmZ7JvQh1SBVqGc=;
        b=XvqA+GcBYacpH2N+33chOXgVZosSmZ71h7kXnx/rjbPnpYLfCM68gTQwDYB8Hn/tJM
         Evv30+PTyYrgV5M14wIsJdsSKMj1gllcAoORTd57e9iDDs5NMhTmi5YmJSmfuD33fkw+
         XLIFB/jJ9G8dqpYI+gqKXxk9XSNhZMw3MkPbUb+9NYn4qZHSQV9VAZFhybffrnzh1BZe
         +lJ+M0se2K1v8wdCwkNskaNW7b/20rxnFV+vdrBW+GKhjRuCX8D8S2ixc269dRW5amFV
         0B8qtJA8bCRB015o4NKrDIqwuSYDz6ys5lfsp/nIu9kSpFjldnL3PkN5sIaV6nInR4CP
         rqMA==
X-Gm-Message-State: APjAAAXsrduIo4vhJSvnDuIj7sfqOFAr/VISXxEiRTTeSy6312o82Nvq
        EYqfke6ZaeQAM4awg0/Rq/CRUXI=
X-Google-Smtp-Source: APXvYqzBk82jo4WSgxytZiUYRpp/6Rfwglt3vJ0hF7DX7asiQ3UBYcTQRy9Hgfk0qF+jdj3EyBtd5w==
X-Received: by 2002:a5d:960f:: with SMTP id w15mr1870339iol.24.1563387039430;
        Wed, 17 Jul 2019 11:10:39 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id h18sm19923913iob.80.2019.07.17.11.10.38
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 11:10:38 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] pnfs/flexfiles: Fix PTR_ERR() dereferences in ff_layout_track_ds_error
Date:   Wed, 17 Jul 2019 14:08:31 -0400
Message-Id: <20190717180831.48651-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

mirror->mirror_ds can be NULL if uninitialised, but can contain
a PTR_ERR() if call to GETDEVICEINFO failed.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index 19f856f45689..3eda40a320a5 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -257,7 +257,7 @@ int ff_layout_track_ds_error(struct nfs4_flexfile_layout *flo,
 	if (status == 0)
 		return 0;
 
-	if (mirror->mirror_ds == NULL)
+	if (IS_ERR_OR_NULL(mirror->mirror_ds))
 		return -EINVAL;
 
 	dserr = kmalloc(sizeof(*dserr), gfp_flags);
-- 
2.21.0

