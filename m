Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917977A5C54
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Sep 2023 10:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjISIS6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Sep 2023 04:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjISISz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Sep 2023 04:18:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0E7102
        for <linux-nfs@vger.kernel.org>; Tue, 19 Sep 2023 01:18:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-402d0eda361so58503625e9.0
        for <linux-nfs@vger.kernel.org>; Tue, 19 Sep 2023 01:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695111528; x=1695716328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+wCHIzCyfEvs4AM6zK3GKbsAFgsIIPQRu0jrjTdhgs=;
        b=G/g/RpYRSbRVxX2yo5b7MFQEa5GckhzUjYC64KNyOaRyJ1gkEVFapJ+aylrT1W55ys
         jIHmOXbeGF0bFSI1rxQI3CPGbUsNTbQRcc0JpokO99q7i3dtIIhCIELTRP+sp+gUSPId
         B3dL+JEqicQ6Mmr9UX5Ij7eu8I9d+/iYwPrn63A2AtlyIVLAsUIfI+SHLGp/Hy8hklI6
         s94WmIbY+W8EOxBmTZuwrQyOy1wjkoCyAgeDSMO58/RZUU3QvQmDMJFbyDgWaGuDLgWK
         YYwhK/AJk8DAmbuWEB/H+3u+Y2aA1eQmHN9mEdxad81+e1FJxbYDT1aDcbG89FuWfv0O
         IQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695111528; x=1695716328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+wCHIzCyfEvs4AM6zK3GKbsAFgsIIPQRu0jrjTdhgs=;
        b=A2ClGsp1IwBZKZ+G7FZQ5p69b2XkcyxiOYG0GMVGLdEDR8q6gzIP0mtPrr2MtkyFXn
         ZznJ9Lf2AQrLf9eAAecc5jbVN6TnvlUxG0E39WKz+jWT4iQuPf0gkm5hEUWCH9PQbB/a
         HtljK2pi58Na5pQSv4AWXlz0EuMyRw+Dg9Qh5cLMoZsrXeykkRULtePqJy4MuNPJA4qY
         wQ50/EUc5QzhdE+T5e/xDAbMoAaDqWFjVZ6x356l+cuM05c2YLKfhm178VENmK4UmSOf
         m2Cui2PFmwBbQp6EqAAP05YRzq5Aea6g7jsRUru2LOzJ7lrRZFy3++pGfkhvfbiihutU
         Tv9g==
X-Gm-Message-State: AOJu0YyBHOwcaAjQjleqH/3+RCes12bthaTuWdbvp1cx1wjsZptomUio
        fwuL5EWPeTlWqWn7W2p6O+rfJw==
X-Google-Smtp-Source: AGHT+IHEV2O4XGsf35LqTv0FhrmFGfe1icqH1CrFMUp1Q1RiZsPjfqFCcMFLM44ZaeuR8y5V8PCrLQ==
X-Received: by 2002:a05:600c:152:b0:401:bcb4:f119 with SMTP id w18-20020a05600c015200b00401bcb4f119mr11605148wmm.3.1695111527914;
        Tue, 19 Sep 2023 01:18:47 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id p14-20020a1c740e000000b003fe407ca05bsm17424445wmc.37.2023.09.19.01.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:18:47 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        "J . Bruce Fields" <bfields@redhat.com>, stable@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfs/super: check NFS_CAP_ACLS instead of the NFS version
Date:   Tue, 19 Sep 2023 10:18:44 +0200
Message-Id: <20230919081844.1096767-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This sets SB_POSIXACL only if ACL support is really enabled, instead
of always setting SB_POSIXACL if the NFS protocol version
theoretically supports ACL.

The code comment says "We will [apply the umask] ourselves", but that
happens in posix_acl_create() only if the kernel has POSIX ACL
support.  Without it, posix_acl_create() is an empty dummy function.

So let's not pretend we will apply the umask if we can already know
that we will never.

This fixes a problem where the umask is always ignored in the NFS
client when compiled without CONFIG_FS_POSIX_ACL.  This is a 4 year
old regression caused by commit 013cdf1088d723 which itself was not
completely wrong, but failed to consider all the side effects by
misdesigned VFS code.

Reviewed-by: J. Bruce Fields <bfields@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/nfs/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 0d6473cb00cb..051986b422b0 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1064,14 +1064,19 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 		 * The VFS shouldn't apply the umask to mode bits.
 		 * We will do so ourselves when necessary.
 		 */
-		sb->s_flags |= SB_POSIXACL;
+		if (NFS_SB(sb)->caps & NFS_CAP_ACLS) {
+			sb->s_flags |= SB_POSIXACL;
+		}
+
 		sb->s_time_gran = 1;
 		sb->s_time_min = 0;
 		sb->s_time_max = U32_MAX;
 		sb->s_export_op = &nfs_export_ops;
 		break;
 	case 4:
-		sb->s_flags |= SB_POSIXACL;
+		if (NFS_SB(sb)->caps & NFS_CAP_ACLS) {
+			sb->s_flags |= SB_POSIXACL;
+		}
 		sb->s_time_gran = 1;
 		sb->s_time_min = S64_MIN;
 		sb->s_time_max = S64_MAX;
-- 
2.39.2

