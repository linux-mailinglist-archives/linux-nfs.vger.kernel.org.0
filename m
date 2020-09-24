Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346C8276F2C
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Sep 2020 13:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgIXLAF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Sep 2020 07:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgIXLAF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Sep 2020 07:00:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E659C0613CE;
        Thu, 24 Sep 2020 04:00:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z4so3329108wrr.4;
        Thu, 24 Sep 2020 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5L6vOsF3jF4xqgAq9jpu8Af6OIIQz2u9qhusAgnAuqw=;
        b=ZvijhYyjIJTiuNZkFuzq/jY38dyGFFNTjvMDkSnLori7HTuu+m+RbA20+HsCjw9ec9
         Dv2Rcy/OCVeInIGqhMjMrJFxPN+Kmgog5lYS4ZbiLxVaZ6fV9QVIOaWAGimyiy/W+a+p
         LIe1OlUvLlO4sMxLori4K4H/fgcn0AXr00d0+7lEYLPQXHbbHDvLiYbPjs8C3IpggyyA
         +ab/RgilynOiU+EwjbdKy+15CGLQFke6LDHZs6DemEmd5948KU+6gpB7ZD7CbZC6WJt+
         ROpasHHtm5gvXwqb+jdaEwfgnZzDxX1aocee/zfOSAcfxcJaH9lSNf8lcuXz85bkXLmW
         4RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5L6vOsF3jF4xqgAq9jpu8Af6OIIQz2u9qhusAgnAuqw=;
        b=q1tjBs974NMStuT3GxnyN2dgf7Os6BggxDM1J7GGzaXY96GZ5cDkP9fWQY4fIeZijR
         +quTrAb9Dio3FDJD34EnW9wBrdhRSiR29U+QFFTGXTqWZxEoYn3eecVoAQLaqumWt4I5
         +PFQMq3WHOnmMS1OafdN1SRPj25dYzVhwnD02Mubmmn1ld1MsQJpsAJGtxzaYJVFNF3k
         gwLsjmGfs7081eKdLpg8LnTYQBy9Wgrz2zQMHPksc0ZnZbTlCRyRNaP1Sk8vZzfvyZXr
         eBbA4vG+YsYLxzW2P1eqgH7b2TVAYGszaN6PtyDyqAqMMHaTXyFUKgAQGu9l6Zabo/9R
         tsVg==
X-Gm-Message-State: AOAM532CvqxpZ7EtWVKi7/v0zpSWHtN8tW7AYL93Pit0Byrb2UMLRrGU
        zzcbN24+YcGhaz2h6ISr1XE=
X-Google-Smtp-Source: ABdhPJwP3+SenwNrOVmpV1NO2snBarBljCGmAfrSUjGpBCLY5ysNcHysY+0ggrAZ21+GZ55nOmixlg==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr4464129wro.250.1600945203934;
        Thu, 24 Sep 2020 04:00:03 -0700 (PDT)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id u66sm3056012wme.12.2020.09.24.04.00.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 04:00:03 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] nfs: use 'break' instead of 'fallthrough'
Date:   Thu, 24 Sep 2020 11:58:02 +0100
Message-Id: <20200924105802.31987-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The fallthrough attribute should only be used in a switch statement,
after a preceding statement and before a logically succeeding case
label, or user-defined label.

But here, it is used in the last 'switch-case' with no other 'case' where
it can fallthrough. So, use break instead of fallthrough.

Fixes: cf65e49f89f2 ("nfs: Convert to use the preferred fallthrough macro")
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 fs/nfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index d20326ee0475..eb2401079b04 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -889,7 +889,7 @@ static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
 		default:
 			if (rpcauth_get_gssinfo(flavor, &info) != 0)
 				continue;
-			fallthrough;
+			break;
 		}
 		dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", flavor);
 		ctx->selected_flavor = flavor;
-- 
2.11.0

