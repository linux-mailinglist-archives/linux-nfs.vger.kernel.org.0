Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168827A27E1
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbjIOUPl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 16:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbjIOUPX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 16:15:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8378E30F9
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 13:14:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68fb2e9ebbfso2124298b3a.2
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808883; x=1695413683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qkNg/tr3QrWcASJiKwsE4eOsWfikvegDZMItdS4GDes=;
        b=dIQOpXFoq7qZUoDMH78/jDAu7QDLIHf9v1h6hsKjkbz++dZ0k9P4oD5/vgxC1n3nVT
         wr8oXmowHzs4IUtHkHa5KEPIS1vcVsfMDu6dn0pQmENHED2eF8rTHpTZl1ymO7V0/j7Z
         orTAjy3qNvmbSbm06uR5uoseLw4HWbVpmuPb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808883; x=1695413683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkNg/tr3QrWcASJiKwsE4eOsWfikvegDZMItdS4GDes=;
        b=ItWxry/v62bGWgPH/nECqJiAoOXDZFm8HUJfmJYHsMHovFflcgi+ixuabJ7gyXjMEb
         woKyaM8B8ssc8/bVxOpMDkNioMZuaW/xoISq0EiowPAVBz6o5CD38WrlXeduNv3RwqlM
         ejSqy+9I4EshKcYTR1+MugGq0LiL7/4lupqK+zb8Pj/gGQn8vDjhOUqyoUiZ8pIy7Y4c
         dRvTopXrZuGD4M7iIgDhMXSxAKSvOyjvXLG1w2Oqiu1iKfuySKSollzbhRENh1zAd2WD
         azxKlAkrXLriKZ+AMuG1lkiYo42wy3F5R610MV+4EXY/VUXv1mmELZd9SCTTNN7O5syv
         m3UQ==
X-Gm-Message-State: AOJu0YxhCMswxdwsSuP40kiPAGVS4ks+DTx3Pb9+hfpz1rzaP0VZuaun
        KYBMKHWjwJB+sZAVUq/ERBM3tw==
X-Google-Smtp-Source: AGHT+IHXhNmupyTLfTSXdb+UWAhDBj1zLCfg6DkMECc3KJ4exjVmqGLfno7q2nbXMLL41tgfhLkLTQ==
X-Received: by 2002:a05:6a00:851:b0:690:42d5:4332 with SMTP id q17-20020a056a00085100b0069042d54332mr3152371pfk.6.1694808883096;
        Fri, 15 Sep 2023 13:14:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j16-20020aa79290000000b0068c90e1ec84sm3339012pfa.167.2023.09.15.13.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:14:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] NFS/flexfiles: Annotate struct nfs4_ff_layout_segment with __counted_by
Date:   Fri, 15 Sep 2023 13:14:39 -0700
Message-Id: <20230915201434.never.346-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ulAteUUegKxPPNYcaO1yT0Twc5GfPCHdyqd9WNVKmuo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLsvlYHxhP8rtZTlzFEmT5U4B5FDD5sjM+zNr
 VMPn0lzxlKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS7LwAKCRCJcvTf3G3A
 JmiKD/4okdWMQlAOtNFwJ5mpfcjcBIwyOr+dV6DW3brxCulz1Sx4uB9/LXER2a9gfv2tvVAyMTN
 XDHT5U46yT61zFXmmVQf/Q9Nehs9mPTBDRUtUKKyXbWpS22DzSZk7/SryP81AV8cUxtmHjeEMQ8
 SIIQWiIXzvgA8rHMvY55qzEpxrmQx/6ohJ+0kHCBHeXs9EShu05fPwnSBsnIBHZr75zsBnwmOm8
 13zVz+dn1HrkVfnCsslNOCgU8cn5bVggkWqCay62gJOsZYDmxSJnm1dFKZWbG6FTxKb7snRjksj
 lHjd5yQIavBmZ40R9L1Lk0AidCSNvx+gsnNWBBtKSl2MgbUaEtBG/MtCprtSz66r0GOsdbpq6lQ
 m7O8dnOtI1Dl7WesCrgz71xVvQNjsfdRARa8OYvPAI6oEs+lzIKgA6M+gOkLtgSupQF0+NrakmA
 hPHiFJ2PB5Svo/IJLQeDi3ORyPTvLwKditTekz3tO6GvCAS49b6iZQzdsYtiFZXwKR/UUPCVFLZ
 /DTJbTPdOig5sA4lEhna5M0qUCZMrnWrPg4lxywbU8dzKDw0xnz2Pqpgq+e2JzjuA91/l79teeM
 EHTB/zq59KZrmd4W+bfACwlCKDRRRfg4kpqnimfoBZIL7lm5T6G1yQa5tdjYyHJVsJfsxLVreHY
 LP1DxLZ uPAY/z3g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct nfs4_ff_layout_segment.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index 354a031c69b1..f84b3fb0dddd 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -99,7 +99,7 @@ struct nfs4_ff_layout_segment {
 	u64				stripe_unit;
 	u32				flags;
 	u32				mirror_array_cnt;
-	struct nfs4_ff_layout_mirror	*mirror_array[];
+	struct nfs4_ff_layout_mirror	*mirror_array[] __counted_by(mirror_array_cnt);
 };
 
 struct nfs4_flexfile_layout {
-- 
2.34.1

