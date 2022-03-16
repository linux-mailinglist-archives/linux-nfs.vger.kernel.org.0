Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6934DBA25
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Mar 2022 22:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347530AbiCPVdC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Mar 2022 17:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358207AbiCPVco (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Mar 2022 17:32:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E04F2F006
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 14:31:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e599f0c613so29782487b3.3
        for <linux-nfs@vger.kernel.org>; Wed, 16 Mar 2022 14:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5OneduaV2OXxq5CcxBruCxPc/Swfi9F6sRQ7+F/Zn1I=;
        b=MRL/HERqsHGSzx7y32S51BGQMoiBHeB6Cac8hgvSAKrK13IeqgqUD0pF+IS1FNw2cu
         jzx0VSzjCKMVY/v/1HF3qvNOqzulYYGxRKPwzym+fFTaatGnenQgu/BlhganrO3lc7pa
         iAlJdEMkfkTkIh4RyCP48yTbZOApgrxxBPps7Knw6Gfxn9nl/Vce0Qx1CNuTpXFnz/IM
         zo7DjxNlX39rtwjd0dbKZyovA7jTL6mFEoVM4PB6Lz6LUITgS0k9hc7ZWzp8J3VUTp3K
         Az6bpTViSCQUih3Fu8fspJosmAoqOqh3ZyxiBmT8utrrzoWhmtq0pDnkPq/OGvgqnBKY
         1srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5OneduaV2OXxq5CcxBruCxPc/Swfi9F6sRQ7+F/Zn1I=;
        b=y9OYM5HIguSXk3S7SpLhY9tk5A0rzymTYCk3fAN5kvDLICtkEnsUvL78jDuiMuJpe0
         KuVHvWSTa0tWZOpGElndCefRIDH3V6BIR18DV55eKL50OJqQqpHr8SyXE783b5Lp0Kt4
         YiL67bbWrC3IuwMilz2iFUm+pvuMV5GYiyq8etAgAP0na1cKz5U4JHx4Idf1+llDzvWU
         cR8IEdH05rcUJ+Xzx0S07aTDg15EZuY6fy+AJQ1aHzRSLxTxOWHDLvWuLex7c/f1gOeU
         O3qP0gZtMrePB/sAbWB+rDEQFmpC9B5N0n7R4f0WjmLDUtAvpImWPsyADSxMfoWrMTfE
         NEVw==
X-Gm-Message-State: AOAM530uuLP8DOzpcTt1Hw5iaQOE9E42rpV1OJGFVaFMztpRlj6tYZ8f
        rvDDRj1noveDPOTnxZTh4PiP1IdU
X-Google-Smtp-Source: ABdhPJyTwqZyQZ2E7Cpqu4oUlQxwPrDN5wlJTROylLffKhLFiErEmY9B2AIxfLeeJ8g38ybOZntyYvfoiw==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:7dae:6503:2272:5cd1])
 (user=morbo job=sendgmr) by 2002:a5b:34c:0:b0:61e:1cd0:c93f with SMTP id
 q12-20020a5b034c000000b0061e1cd0c93fmr2113282ybp.269.1647466285413; Wed, 16
 Mar 2022 14:31:25 -0700 (PDT)
Date:   Wed, 16 Mar 2022 14:31:22 -0700
Message-Id: <20220316213122.2352992-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH] nfsd: use correct format characters
From:   Bill Wendling <morbo@google.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When compiling with -Wformat, clang emits the following warnings:

fs/nfsd/flexfilelayout.c:120:27: warning: format specifies type 'unsigned
char' but the argument has type 'int' [-Wformat]
                         "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
                             ~~~~              ^~~~~~~~~
                             %d
fs/nfsd/flexfilelayout.c:120:38: warning: format specifies type 'unsigned
char' but the argument has type 'int' [-Wformat]
                         "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
                                  ~~~~                    ^~~~~~~~~~~
                                  %d

The types of these arguments are unconditionally defined, so this patch
updates the format character to the correct ones for ints and unsigned
ints.

Link: ClangBuiltLinux/linux#378
Signed-off-by: Bill Wendling <morbo@google.com>
---
 fs/nfsd/flexfilelayout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index 2e2f1d5e9f62..070f90ed09b6 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -117,7 +117,7 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, struct svc_rqst *rqstp,
 
 	da->netaddr.addr_len =
 		snprintf(da->netaddr.addr, FF_ADDR_LEN + 1,
-			 "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
+			 "%s.%d.%d", addr, port >> 8, port & 0xff);
 
 	da->tightly_coupled = false;
 
-- 
2.35.1.723.g4982287a31-goog

