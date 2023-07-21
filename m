Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B55875CAD0
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGUO6O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 10:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGUO6N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 10:58:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C77D134
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 07:58:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso17150405e9.0
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689951491; x=1690556291;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNImucjaNLeCmsiuYLvYcRiNL6dxUcfBU2q2yYk+Sqk=;
        b=e0J75bMOF5TBrsKhmcdIjD5RHjDqWJ+etcFweO+mNetFuMTGRFmXpHU2FfBxTNljba
         UV4FJ+FPlT1OlJsum3IhHpioVjPlHbC6jCBLl6Te2I6Bqvcg8ph9DyEV5uqUZIDZhfdH
         ht9B4fn6qbXeoTIezjJexs1W+3DAci9qGobmvCBteaOHpoMPspZ3LOHfLduUiofuvdI5
         IXdfXiIo/ScTlkDcD04pIYPDceXDMNxWgomZHHziDDU6WzRzpTc/xOXDN11TLT/Yw6HX
         x9XgkJ1LuG2T86QVmAVmAXKRHV/OIbV2ah4m8crEGAWBSIXUPyyZDYXmV5Wfi3FbU8GO
         HIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689951491; x=1690556291;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNImucjaNLeCmsiuYLvYcRiNL6dxUcfBU2q2yYk+Sqk=;
        b=Mq5cuzLC46haPqhpuXcDyMAr02a8ZBljzuZA0l/gpya/TyneW25BB6ZYT1ekEmMaYc
         9LU+uTkGyZSXNaqmCtU+hWYq4qzc+vrYtkhgSix6/Nzx2V0os82xKSpSU+TpPKyJSQN+
         y+QF0D3f0LS8OmmMYo7USaKnLR1hpW7P7jH8YHb/eq4lY+bBpao6SMga/YMjzGKyswRc
         nXYAM3bR0+hfdiFEFerIRuvJA6hnwX5oshrRSzX3Mm9HaWc4K4OHsT+B218kKkV9QOiF
         299RWEeKo+tkkuLhxPvm0uCIB60eJuGGHYNKJucE8sUGMv9Knu0gYI2ral//BBcJBld/
         AQ6Q==
X-Gm-Message-State: ABy/qLYHQhEboL3QrjeUBl47K4WQ9QdUGoXLVobcclb66LTWhE94tDT1
        cXzg9vBdFmKTAu76zXSLs81gBw==
X-Google-Smtp-Source: APBJJlGEkuj1I7We6C0/2twPAnua9yYsxAC+t+5a6WpR9gTNnNV22u9C2u5YnVXfaF6OB7t7l59Fjw==
X-Received: by 2002:adf:d851:0:b0:315:8f4f:81b1 with SMTP id k17-20020adfd851000000b003158f4f81b1mr1568386wrl.50.1689951490773;
        Fri, 21 Jul 2023 07:58:10 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o15-20020adfeacf000000b00313de682eb3sm4435634wrn.65.2023.07.21.07.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 07:58:09 -0700 (PDT)
Date:   Fri, 21 Jul 2023 17:58:05 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jack Wang <jinpu.wang@ionos.com>,
        Dave Chinner <dchinner@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nfs/blocklayout: Use the passed in gfp flags
Message-ID: <e655db6f-471b-4184-8907-0551e909acbb@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This allocation should use the passed in GFP_ flags instead of
GFP_KERNEL.  All the callers that I reviewed passed GFP_KERNEL as the
allocation flags so this might not affect runtime, but it's still worth
cleaning up.

Fixes: 5c83746a0cf2 ("pnfs/blocklayout: in-kernel GETDEVICEINFO XDR parsing")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/nfs/blocklayout/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 70f5563a8e81..65cbb5607a5f 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -404,7 +404,7 @@ bl_parse_concat(struct nfs_server *server, struct pnfs_block_dev *d,
 	int ret, i;
 
 	d->children = kcalloc(v->concat.volumes_count,
-			sizeof(struct pnfs_block_dev), GFP_KERNEL);
+			sizeof(struct pnfs_block_dev), gfp_mask);
 	if (!d->children)
 		return -ENOMEM;
 
@@ -433,7 +433,7 @@ bl_parse_stripe(struct nfs_server *server, struct pnfs_block_dev *d,
 	int ret, i;
 
 	d->children = kcalloc(v->stripe.volumes_count,
-			sizeof(struct pnfs_block_dev), GFP_KERNEL);
+			sizeof(struct pnfs_block_dev), gfp_mask);
 	if (!d->children)
 		return -ENOMEM;
 
-- 
2.39.2

