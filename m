Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803577BE3BC
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Oct 2023 16:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjJIO7L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 10:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346526AbjJIO7K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 10:59:10 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF0A6
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 07:59:04 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3526ac53d43so2336555ab.1
        for <linux-nfs@vger.kernel.org>; Mon, 09 Oct 2023 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696863544; x=1697468344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ok2DjIbFG7A8epVRtB4kmkJ5bwyHdKOkaHte8NfvPGI=;
        b=DMG55/VtoW+o/Q/UkHrRsjdAlwASuQIao/z9hJfP6XC63HQJ1xBnRHpq+7fXQUw52M
         3dvaToktWArewfiCs7ako1ELjjrTGfCqVS7TlrtWgsMFM9yV8e/QP3O6TVxfQCHg4XYm
         /aEMdgc5LsFyLZ7UODi/NVCpMmWBMuoU7zzsqjkxwp6R3AcP1xgf5t9wbjiaWSYY1Wff
         B0C2M1R768aBPJqwKGBc9GpC+Q/g/nQWwVNRDclRXIqxavwKNUCWayd6dxwVguqyrxy/
         MNkC01JSUi1fC18w3yNbJEjXQfqp3aQRFfW3QzsyqK9dKcFC1v2c5oqlAHEZPKJ58Wbv
         j1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696863544; x=1697468344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ok2DjIbFG7A8epVRtB4kmkJ5bwyHdKOkaHte8NfvPGI=;
        b=tZGVOwQr3sRymfgd8iJWAEB4uFkw33qt5yL9mg3oiKry9cbvS8HVaJxRoCOSlFJKt8
         NpkAQWqEuHQsM/k5O+jSe8agRXybVUMdTatLs54Hp21GNdhSHHRrAxaRMUcxI0oiqhrP
         SrQWl7a5blolyUV0sdiei5V28jFx7fRrCH6/qxh63wKAHq41AhyyPsfPONtPjuYt8+/k
         pdqxt331TzMsmbojPaKea+feLBHVaF+y57fTKo6R5lnrl0o/LdM7ITpn5AJp4t23d8P7
         /MkpfaKrr0DzQcZl5WkPNVHWhiaYnY7cRufdX+CjIaflMF7Od3H5C7PRLckfcEl7jOFe
         plIw==
X-Gm-Message-State: AOJu0Yw3pmzYiTd3jbdRwResMJsGsLD6C5vteHr9Rxj4gR6v+ytZCiJi
        qHDEJuEEix53zarZp5rtVkY=
X-Google-Smtp-Source: AGHT+IH8AYFmGX+avDnA8X1Cqc6HosFR87heyuEM2nQuhyHC4If3U1aIQQ2ULcNVoXU55K5ZNmfYeQ==
X-Received: by 2002:a92:c847:0:b0:352:a3f5:6314 with SMTP id b7-20020a92c847000000b00352a3f56314mr13478212ilq.0.1696863543933;
        Mon, 09 Oct 2023 07:59:03 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:1407:9e63:e404:9c97])
        by smtp.gmail.com with ESMTPSA id m2-20020a92cac2000000b0035261fc619bsm3000948ilq.44.2023.10.09.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 07:59:03 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: fixup use EXCHGID4_FLAG_USE_PNFS_DS for DS server
Date:   Mon,  9 Oct 2023 10:59:01 -0400
Message-Id: <20231009145901.99260-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This patches fixes commit 51d674a5e488 "NFSv4.1: use
EXCHGID4_FLAG_USE_PNFS_DS for DS server", purpose of that
commit was to mark EXCHANGE_ID to the DS with the appropriate
flag.

However, connection to MDS can return both EXCHGID4_FLAG_USE_PNFS_DS
and EXCHGID4_FLAG_USE_PNFS_MDS set but previous patch would only
remember the USE_PNFS_DS and for the 2nd EXCHANGE_ID send that
to the MDS.

Instead, just mark the pnfs path exclusively.

Fixes: 51d674a5e488 "NFSv4.1: use EXCHGID4_FLAG_USE_PNFS_DS for DS
server"
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7016eaadf555..5ee283eb9660 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8870,8 +8870,6 @@ static int _nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cre
 	/* Save the EXCHANGE_ID verifier session trunk tests */
 	memcpy(clp->cl_confirm.data, argp->verifier.data,
 	       sizeof(clp->cl_confirm.data));
-	if (resp->flags & EXCHGID4_FLAG_USE_PNFS_DS)
-		set_bit(NFS_CS_DS, &clp->cl_flags);
 out:
 	trace_nfs4_exchange_id(clp, status);
 	rpc_put_task(task);
-- 
2.39.1

