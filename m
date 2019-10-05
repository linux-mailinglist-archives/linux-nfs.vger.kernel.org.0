Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA72CC8CB
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2019 10:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfJEIbG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Oct 2019 04:31:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38942 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfJEIbF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Oct 2019 04:31:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so4263035plp.6
        for <linux-nfs@vger.kernel.org>; Sat, 05 Oct 2019 01:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6f7U8Wp2Mg3apMU8IOlMVjB8Ry7zdOHfW6vmdgYDEfg=;
        b=RMMp/3wBXOhiD67vv8sGQKP4EnVWepzvz/DhuYedlgMWH2aDjNVfjA+KbbxPTDjcE3
         VCL0iehmqFC2E2/fxLr5wa5GjuXKSZCTbwlIVbhlCAv/72d78WaZtkyMPaleMDcEy1yn
         GddZBQ6/hy/HLHg0Tif1iX+5R3Sp14FfDsAp5VIFhmEoOgUxqsMzBezh+uUa2O+wtZSm
         hP/dme+75M/PNnmWXHFpbrVVTtCLGeanedLdE23jfxUhL/5HFBXjwnfV8WuQRqOqlj4q
         XAi641rdkpKvYD5jE6dO8p8nCZE0TokdXdJaBS95EuA9EsOlMTyIQblYqGWqXq07HIDJ
         EZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6f7U8Wp2Mg3apMU8IOlMVjB8Ry7zdOHfW6vmdgYDEfg=;
        b=gCFgvR7VJv7HszoPlQ+iIkVkp4OUVFzEJPfPOiCjMiJj4uCjZXR3E6nGE4+qqo4SSn
         FaSeUTMkfSrxRGhAMCQ7SvTDTBEvbCTuM9fz5P7IYAZk+QQfuhjsnGqo+KheOSGbQQGY
         6p38HSqER2hNOmiI1CKOYQB0oFTQw9wsme/VvAwnuDtuaE6tGkEqFP9jghBQeFMlp+f9
         swC+48kttgbEVRZOu5O7dC7GjeSpvu5l77nDduHlrPmnLJqVmjpczlcZldxQ5hJrJiZV
         alZmq+5TGKsmpSx8yYkVGwxTQ1osMasJ0aMiB7M+jv6717bIrXVD76VMNzdxJvdcXXjl
         oyrA==
X-Gm-Message-State: APjAAAXrP8QjLLmjWzHwx5kba9zyimyCZprwQWmC9H+nGJzI8GxFJHoQ
        5/5zC4q6yelN7AE7Gqpqf/c=
X-Google-Smtp-Source: APXvYqyoYTZkTeZXqnlaUhMxvKuJKL0GqILxyctf/DPjr19iDAK7UCX5anGBS/EvSizqvlrGEkrnFg==
X-Received: by 2002:a17:902:fe81:: with SMTP id x1mr19183617plm.66.1570264264688;
        Sat, 05 Oct 2019 01:31:04 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1950:559a:117f:4889:e0ff:3af])
        by smtp.gmail.com with ESMTPSA id b22sm9876667pfo.85.2019.10.05.01.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 01:31:04 -0700 (PDT)
From:   aliasgar.surti500@gmail.com
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Cc:     Aliasgar Surti <aliasgar.surti500@gmail.com>
Subject: [PATCH] nfs: removed unnecessary semicolon
Date:   Sat,  5 Oct 2019 14:00:53 +0530
Message-Id: <20191005083053.31501-1-aliasgar.surti500@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Aliasgar Surti <aliasgar.surti500@gmail.com>

There are use of unneeded semicolon after the closing braces of
switch case in multiple files.
Removed the same.

Signed-off-by: Aliasgar Surti <aliasgar.surti500@gmail.com>
---
 fs/nfs/nfs4state.c | 2 +-
 fs/nfs/super.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 0c6d53dc3672..6ac0a8904bb2 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1134,7 +1134,7 @@ static void nfs_increment_seqid(int status, struct nfs_seqid *seqid)
 		case -NFS4ERR_MOVED:
 			/* Non-seqid mutating errors */
 			return;
-	};
+	}
 	/*
 	 * Note: no locking needed as we are guaranteed to be first
 	 * on the sequence list
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index a84df7d63403..8d8d04bb9d64 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1592,7 +1592,7 @@ static int nfs_parse_mount_options(char *raw,
 					dfprintk(MOUNT, "NFS:   invalid "
 							"lookupcache argument\n");
 					return 0;
-			};
+			}
 			break;
 		case Opt_fscache_uniq:
 			if (nfs_get_option_str(args, &mnt->fscache_uniq))
@@ -1625,7 +1625,7 @@ static int nfs_parse_mount_options(char *raw,
 				dfprintk(MOUNT, "NFS:	invalid	"
 						"local_lock argument\n");
 				return 0;
-			};
+			}
 			break;
 
 		/*
@@ -2585,7 +2585,7 @@ static void nfs_get_cache_cookie(struct super_block *sb,
 		if (mnt_s->fscache_key) {
 			uniq = mnt_s->fscache_key->key.uniquifier;
 			ulen = mnt_s->fscache_key->key.uniq_len;
-		};
+		}
 	} else
 		return;
 
-- 
2.17.1

