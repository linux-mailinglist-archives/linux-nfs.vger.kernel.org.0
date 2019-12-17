Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18A0123A5A
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2019 23:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLQW6i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Dec 2019 17:58:38 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:40386 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfLQW6i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Dec 2019 17:58:38 -0500
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Dec 2019 17:58:37 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 47ctf52kb7z9vYwC
        for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2019 22:50:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vq_wT4rWr0ik for <linux-nfs@vger.kernel.org>;
        Tue, 17 Dec 2019 16:50:53 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 47ctf51bDVz9vYw1
        for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2019 16:50:52 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id a190so6413938ywe.15
        for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2019 14:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQI/3o46QTkpBu3QKMA5BleVhXZfhU7Xm3Wn0FysZY8=;
        b=ftYRHw2iSFBHJUU538asJywbx36G+pFGYfFVcK7r1aZ0bpi9oWu19KGOSNibZm4HgV
         eUFdEqVmriCVgmFK3wBwHnMkDHSW5SL9DKBz5YJS5wdzok2WwSunIHhYV0blLgbNZ8Sl
         00L5ZzydanXqYkYq17yH1nE61gMimzYCgsROikcNLQ39Jy6go8Q8nXV0VMQrD5RnSrxA
         rpK6Of24PFGXgH5VYzcbcQvBxX5pnJj1qozaaYZEx1Q3Bog6nwT2QoZOA+0OMrNwwbj7
         mlOQABHdojh2+Fg2WHUECH7K9IfE9m2rLC8K5x5F0Mam0YXfNCY+X9TiBGDDzCjsauX7
         Gm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQI/3o46QTkpBu3QKMA5BleVhXZfhU7Xm3Wn0FysZY8=;
        b=Xmkcp+fxkBecgOADnEt0Bx2Yi2h6Tb4+KelOmFa4Dvd69Z2k0g8KzGrplruqkmVh1i
         gc64vZ7QZxSvDpO6luQdGiBw6eGR9ToyXmm5LRqYTH8IoV0PM8CtDI596BbfRfHuvpEl
         Zd1Rp2ldJ9X+HP2flT2xhMvLau/BL3xEFZukTpttoJAiki8d1SdR6LS8lKpkOsmuDaep
         oIbfldUIv7TjnfL//nuVQ/7OBN6Rux/YdNfo+9POXS1Ts4oAfuDMToJL0z4/W4RSBKHF
         wkG0G8n0+d6JJCAAhvXMoo3dw0pYoBzjavJ68RhMSms4FxXITET+xockj7ZOZ/DwkY1l
         ycOA==
X-Gm-Message-State: APjAAAU0NpEhKys/v+iQjNzMoQ1Ad0Do4e6dNumr5YTPiKgynSuEsTho
        qmUjYbbPas3QWQ6jRFqgEaN3wp+momHirLv+fusPSOkB1qasKmoCUDNGfwdalGrgb2LKqKfT5qY
        JcIN5Vp0AvO89xeG4oxT0+Hz6
X-Received: by 2002:a25:7451:: with SMTP id p78mr472595ybc.22.1576623052025;
        Tue, 17 Dec 2019 14:50:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcdfKJfOCr5lNQA1daYm5XnEIRWKbkgY77t7JSl9qjnnSLaxc3Sj0TtYDq+OzJoTelJ+SaBg==
X-Received: by 2002:a25:7451:: with SMTP id p78mr472586ybc.22.1576623051796;
        Tue, 17 Dec 2019 14:50:51 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id p191sm114665ywp.86.2019.12.17.14.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 14:50:51 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: remove unnecessary assertion in nfsd4_encode_replay
Date:   Tue, 17 Dec 2019 16:50:47 -0600
Message-Id: <20191217225048.3411-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The replay variable is set in the only caller of nfsd4_encode_replay.
The assertion is unnecessary and the patch removes this check.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 fs/nfsd/nfs4xdr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d2dc4c0e22e8..fb2433676376 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4500,8 +4500,6 @@ nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op)
 	__be32 *p;
 	struct nfs4_replay *rp = op->replay;
 
-	BUG_ON(!rp);
-
 	p = xdr_reserve_space(xdr, 8 + rp->rp_buflen);
 	if (!p) {
 		WARN_ON_ONCE(1);
-- 
2.20.1

