Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D5575ED17
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 10:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGXIJC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 04:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjGXII6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 04:08:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011ED115
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 01:08:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-314172bac25so2802273f8f.3
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 01:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690186129; x=1690790929;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LpBqm+jOoJG0wfkhuGS0lLXKJysvSQDazVNFzfkOiJY=;
        b=Ufz0zY6WkOuDS6QEqwHLOxV1T9LPiofO2WZsu/T5u57nyQeCg9eSnn3a6B8vagQDUq
         c86AX0g07urNlx3AB+9QO8CcUQNLYomLJp8KZwC5ZEz456SImCFmNjw4u3Z1KIuM4DPK
         fmr+uCKP1UoZg0pKyrooOAyDmszbWnXRnvHDdNtktKsQn+ncYUi364Fg7mL7ELG+aL0y
         0EwOwqLrFQGLiQ2qzfYV+djadJbXe+aUHN3jIJ82yh8pahmW33mAGJDffNg20fcVfCzM
         ZjBk++Z+cHJR+Svxm8kTcVXrVkEtZeLH6dTNZNNVmgIUjSNI8InJq0yj0Va3GZk6Y661
         uKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186129; x=1690790929;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpBqm+jOoJG0wfkhuGS0lLXKJysvSQDazVNFzfkOiJY=;
        b=Soa8yAp+lLwmDxUryDQmjjepVCW/nHVpPmCn+3Mqz0sPoQHRvs9+gWkd7ebmVFVZSo
         BfcVX+4nSC6wTdHABV4QAXepDi/Ls2vZRQxMAqgiYH0hQZcTN76oYNoflgThFwILqnnU
         1i5F1z1DQCLoUQCFlNCEg43nbkz44hX4KoNjS+J+Iuxd26O0UAUGESNLITbPSotH7f/0
         R9arOwEZsnReRO7D28qzOOzQUo8dnFZFgMui2+NH6pW5SChrHpcuZVeqT21mADjY4auo
         zIwvNF7OGrBdq0YhnopmjXJKJxioZqcyD6PY+fh0TtxDcrYofnshp45Jw5+lmKsZ6xdl
         1JyA==
X-Gm-Message-State: ABy/qLbQoBHfSg9pfzNOvxjtLIj1KM0pc+3hT+nZ5o6FtnRyo4SMIJZA
        tfXKgdXLfpvM1BuM9gWfgM/vyQ==
X-Google-Smtp-Source: APBJJlGny1xjzIq1T4tv/TtTFc/KImmPGcvaRYEJwG6Pejg8EHR/9Ino5n3agxUq4I+07tcGg8Saog==
X-Received: by 2002:a5d:680c:0:b0:317:2574:c2b1 with SMTP id w12-20020a5d680c000000b003172574c2b1mr6594879wru.30.1690186129526;
        Mon, 24 Jul 2023 01:08:49 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m12-20020adff38c000000b003145559a691sm12079882wro.41.2023.07.24.01.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:08:49 -0700 (PDT)
Date:   Mon, 24 Jul 2023 11:08:46 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jack Wang <jinpu.wang@ionos.com>,
        Dave Chinner <dchinner@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] nfs/blocklayout: Use the passed in gfp flags
Message-ID: <ZL4xjgy15cnLvG+U@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This allocation should use the passed in GFP_ flags instead of
GFP_KERNEL.  One places where this matters is in filelayout_pg_init_write()
which uses GFP_NOFS as the allocation flags.

Fixes: 5c83746a0cf2 ("pnfs/blocklayout: in-kernel GETDEVICEINFO XDR parsing")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Update the commit message as pointed out by Christophe JAILLET.

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
