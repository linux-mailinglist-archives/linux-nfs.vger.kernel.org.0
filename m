Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303984DCDD0
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Mar 2022 19:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbiCQSoS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Mar 2022 14:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiCQSoR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Mar 2022 14:44:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55CD89312
        for <linux-nfs@vger.kernel.org>; Thu, 17 Mar 2022 11:43:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a3-20020a5b0ac3000000b006288f395b25so5084020ybr.18
        for <linux-nfs@vger.kernel.org>; Thu, 17 Mar 2022 11:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=59Falx1QipnOpVp+g67QBMvE6iYq8zxhlBnPf1xrsxQ=;
        b=N9TuMKj7xgqUZ3w1thOjgIC6B1a9mU9wqKlyUDCUE6axRDNhTLl3QHlAQHvfY6P1B4
         +f2G848IBwedRiX7eYfwzVdKPUKb7+MIlD/ml8SvIC3lcSQLVyBGP60QzosdJlsTdrFz
         7NvWsyCj1jzHGPi16UJTf2W1HbNWraHB62Td18Jnxaqbsu892Lj4KjLrT33LqEG7BdMl
         k6QdsrJjV9jmUssm4k7pPiRH3+TyKSb3BSjzL1L97RdkhYjToWVIHhWiQIPyf2ALSB2X
         kHedd8YuXuVhC0jI9Ry2r2AkujCUR/sVFg9YfMNRsZodlZaxs2qa5x/gqhSyM5tL+orq
         AAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=59Falx1QipnOpVp+g67QBMvE6iYq8zxhlBnPf1xrsxQ=;
        b=b9SOQ8ei95ChwzFBVOYsgrJLTSwOUmxffWRtycR+bJUQyl7HgKLtiFsi//IkhOfAFa
         V9LUH6r/MnzqzeKIkCXVWPfS7n7I3svqXs2/rrG3tXvR4udXuHGfZuNaDnh8SK+0STZg
         Hfk4pa6NiXnwf6Tr5Ahtj7n6T+Dt8LmRWonTSg49vHdVZFkIziKLydStQkTsQ3XyDLMH
         DuoOT3aC5/AIgm5NP9ruYQ8FPpN2gaVAOf9bF+g5JAyRWUyOcul32e//D2ETcWX6O7zL
         BoPReoGJrAQlwSgFn6uL69ksrDl7hQRTOACknITBJZ+FRLnoTE1qwvFh0DMOPAtHWzi2
         FQKw==
X-Gm-Message-State: AOAM532s+H3DZUG6R1JY51IouzRCtLSH7BkM+q4ifM7ZFTcXNQSb1Elh
        wRdz89p7qzMPJy/t07fePBZ4/gSE
X-Google-Smtp-Source: ABdhPJwMI+lrhJ9gVYsW67xnAL2ERDzGLQuxxvJw3le7MyfdvotLE0WONGhwnwOAR8S6H/0BgopV4mC2Vw==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:7dae:6503:2272:5cd1])
 (user=morbo job=sendgmr) by 2002:a5b:b92:0:b0:633:406:db3c with SMTP id
 l18-20020a5b0b92000000b006330406db3cmr6622995ybq.547.1647542580016; Thu, 17
 Mar 2022 11:43:00 -0700 (PDT)
Date:   Thu, 17 Mar 2022 11:42:22 -0700
In-Reply-To: <20220316213122.2352992-1-morbo@google.com>
Message-Id: <20220317184222.2476811-1-morbo@google.com>
Mime-Version: 1.0
References: <20220316213122.2352992-1-morbo@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v2] nfsd: use correct format characters
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

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Bill Wendling <morbo@google.com>
---
v2 - Fixed "Link" to be a valid URL.
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

