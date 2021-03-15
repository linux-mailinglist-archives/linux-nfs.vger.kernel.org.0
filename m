Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E12233A94A
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Mar 2021 02:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhCOBYg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Mar 2021 21:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhCOBYb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 Mar 2021 21:24:31 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94479C061574;
        Sun, 14 Mar 2021 18:24:31 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id j17so7052215qvo.13;
        Sun, 14 Mar 2021 18:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=orU24esBfmIjzmtTPPk2+OuRTlGiyvN1neiXqqxZg/4=;
        b=E8d5lvgvEmnFYEEMG6ennvvEo/EcPgtNYO6eY3I01UIQUzklE+3nscR62jWUuThKzu
         j7kRTMTV3i3CWfZIRAQYoBS3037SLsCtyP0ibkPN6orn3rq9h1wzy0H/tCmVtWND/8uA
         C8+9SKQfbOYdTqp8b9jSRm+QVuK1VqgVJn/5OTuFoGENlQP46sp9RIlDmBDkcRN3QQuE
         DSDmPjubI5Ee3UOP96Av83kSY+5rCom6OrvdzRFwjyPhHZuIPBDhieUFjKGgf2Xz4NlJ
         ++s4cly+px59l7l0nmH547uxnXs03lK4mFldrhqpQhgbzdZab/YOO8kMeUYptuzazbY9
         bstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=orU24esBfmIjzmtTPPk2+OuRTlGiyvN1neiXqqxZg/4=;
        b=UpKvbobkdtlVOm9jxLjEJdcAqSJyD9fpdX7cjudFtPmYREHM0rouoM5F//ENN8k29K
         5Lz1Ws7jnd0gv3PmGtirPCyDg37IRa4IaY8vG515rmZ3NUFIjkTSH2guAcn57tKjKzR2
         Fd7OJRcnLLdY4vkGBHfNLUI6mS+qhBu4JHj8arYnR3ReB6LW6/2SG1IrMqSj0S1qhMtA
         ljJVVG9/47sGQ7ScCLiuGXEp5FQSzcR3QVq5gGqTMzVHKfdQfvUTB/vo5Ba/+pjsMTOA
         pKDqxKw2gILBcnCKeX0dBWwWSskMj7bcD9HH8NK3j32DQSC3WPmqsSZ2YVgiGmFtkncp
         nxOA==
X-Gm-Message-State: AOAM532vrJP7nf/7o+qzQfw47d6b/s4ywRVAxoSgyCpvD8vlMRKtqKoJ
        sucEvkhWjzVAmDz9xH/ZxGI=
X-Google-Smtp-Source: ABdhPJxmoW75eiEqwZCCGqXKXbaRONcVx9tsvpjP2LsJ2dEpUL/SJJkqyjUhee66zYKLnNbNlLWFTQ==
X-Received: by 2002:a05:6214:1a4a:: with SMTP id fi10mr22394607qvb.5.1615771470688;
        Sun, 14 Mar 2021 18:24:30 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.69])
        by smtp.gmail.com with ESMTPSA id b17sm8837935qtp.73.2021.03.14.18.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 18:24:30 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] nfs: Fix a typo in the file nfs42xattr.c
Date:   Mon, 15 Mar 2021 06:54:10 +0530
Message-Id: <20210315012410.11725-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


s/attribues/attributes/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/nfs/nfs42xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 6c2ce799150f..1c4d2a05b401 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -168,7 +168,7 @@ nfs4_xattr_entry_lru_del(struct nfs4_xattr_entry *entry)
  *	   make it easier to copy the value after an RPC, even if
  *	   the value will not be passed up to application (e.g.
  *	   for a 'query' getxattr with NULL buffer).
- * @len:   Length of the value. Can be 0 for zero-length attribues.
+ * @len:   Length of the value. Can be 0 for zero-length attributes.
  *         @value and @pages will be NULL if @len is 0.
  */
 static struct nfs4_xattr_entry *
--
2.30.2

