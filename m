Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D144DEAA2
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Mar 2022 21:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbiCSU2o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Mar 2022 16:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbiCSU2o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Mar 2022 16:28:44 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F1A3B2AC;
        Sat, 19 Mar 2022 13:27:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qa43so22911152ejc.12;
        Sat, 19 Mar 2022 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VGxWHsF0l6QOLRvoK1qDbHJpSJXfQp744oL+APmEugU=;
        b=fYIotTdxW6p7sVethgLNoepfoAgl9kujqCc00BSAtC92+kgSQJK0KSBWhiz3SMpH00
         gCFTtcbE3pN84kLMGUp33VY5EaZIs34z0l7RGQC8uieHsat7B3AwgFRfYHMBwtKgKqkL
         8iTpK1mBZGsGt9IU+/btC2d1ZjuqabaEU1rAwF3fhL5G9nTEEjis1m45/4Xh91PhZeVS
         BcmhTChokPozfNCdCX1p8tfMZ78hJfMdvhXwikmDuXfxjnbN8V1ppnntI8nLKnB211sO
         whpWmJvUQYrLV3HrK010vI+Xc0VSsRbkG5tyiUhTd1vEicm5NhUbiCPR40f0X3CNBAj/
         +ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VGxWHsF0l6QOLRvoK1qDbHJpSJXfQp744oL+APmEugU=;
        b=xyw16V5XSOW4ZU2LJIOTw1ucPAf80Z0/VFM/sQsQLMw74aVPL1yzLsAk4/VseYba0j
         v0sTGG/95/efPY0bV4LrV2GDyKYIb1uyrNGTmS0Lp14hZpf+L+LGMRJpo4/a5/wauvAh
         YLVjctAPZ/SANCZ9mA0fXk88v1DuCY4v9LUGnvU/a2rUSBi2RV9AjSQcPlcwnmq/5xBN
         770hNqeWYXvwTIg8FGZtOpjpbBF/bRFi4/6wNdU+8J3nuZ45Yo1mcmOg2JL5KXOf0ey5
         xMRopn7FOK6s60jkojmBL6pRlOzwopNPyVZfZuQwEmljRs9HwW3XbhZPUGGG0XS4Pwdg
         wevg==
X-Gm-Message-State: AOAM532BGXmzJpMCS/tz19D0pui4/hNma5onPFs3DDn4OWz/JoNYmUM+
        2LdjtAwgTESI1shqp4JP77Q=
X-Google-Smtp-Source: ABdhPJwYrT9qOtjUUBN7PPlfGnjF1/qqt9hS5k+KowyxOVy6TyveAip5dpiaW/mNV6L33LNqgNVq8A==
X-Received: by 2002:a17:907:7f1c:b0:6db:5e0f:1ac3 with SMTP id qf28-20020a1709077f1c00b006db5e0f1ac3mr14590294ejc.358.1647721641512;
        Sat, 19 Mar 2022 13:27:21 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id m3-20020a17090679c300b006cf9ce53354sm5137856ejo.190.2022.03.19.13.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:27:21 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH] nfsd: fix using the correct variable for sizeof()
Date:   Sat, 19 Mar 2022 21:27:04 +0100
Message-Id: <20220319202704.2532521-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While the original code is valid, it is not the obvious choice for the
sizeof() call and in preparation to limit the scope of the list iterator
variable the sizeof should be changed to the size of the destination.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/nfsd/nfs4layouts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 6d1b5bb051c5..2c05692a9abf 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -422,7 +422,7 @@ nfsd4_insert_layout(struct nfsd4_layoutget *lgp, struct nfs4_layout_stateid *ls)
 	new = kmem_cache_alloc(nfs4_layout_cache, GFP_KERNEL);
 	if (!new)
 		return nfserr_jukebox;
-	memcpy(&new->lo_seg, seg, sizeof(lp->lo_seg));
+	memcpy(&new->lo_seg, seg, sizeof(new->lo_seg));
 	new->lo_state = ls;
 
 	spin_lock(&fp->fi_lock);

base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
-- 
2.25.1

