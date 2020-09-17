Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2236D26E789
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 23:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgIQVp7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Sep 2020 17:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQVp7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Sep 2020 17:45:59 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AE3C06174A
        for <linux-nfs@vger.kernel.org>; Thu, 17 Sep 2020 14:45:59 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f4so2396360qvw.15
        for <linux-nfs@vger.kernel.org>; Thu, 17 Sep 2020 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IhKMP2yDqla4bVCkJ4x51hskFiR/f7svOYkmrG2KUNE=;
        b=TWVIG1xeekErrOWhlV/nnA95BVALmStjr90hXy/egUz8wcg3E7GRjsC/6lUH7WXmVS
         WP2xLDEH9zdJ5H4JOeOjACFo4v6PzBNl+fPBYMRsvX7ScJZsTnym7BQ0WaAkujxIH1bo
         ZNGnhG2+/3JenN40EmcHrLeuN/YJX72pwiec2eiHBdeLk+dNhqI06ADPH6+oBcsAhOMN
         ORyP4k58pVw5u+A8aaljsWgSm5XhiljRIH54YphSCpJaJ5cWx5Nq//cFJZiLGnp3GzfU
         g3nphqn8pyMDlyMqyBmSX6J/BIRswGQd8FExW3fSz6/JX1Hfz3VjXJcNIEXWkfnsm9D2
         mw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IhKMP2yDqla4bVCkJ4x51hskFiR/f7svOYkmrG2KUNE=;
        b=lKGJDXIMIVadbitAe+mpO/2skXsDQpm40S7rWR1ZcuiVCdED91Dl0TDEtaz1JKHqSk
         dACmI3nzpgpWht4fHsKOLVpV7nAFLjXONnyn0QYEquzks/JuEaunguy7SGzB/VvHNxy5
         dKwa6ZsZW6HJ6EF4O4PdNOErK8VqMdvsTqqsJH5SVd9ikSKvkm807mNH0NRzLNCxL+0I
         8CHzhfoyH/bOfIlspoD0wUtEhSigF78l84tyg1qvmrzCffg5aTYdvNDN/lDWR02JhTq/
         5hubnVIbW/iyNgu+jPYrhuThICphtO2YXLimdQNYthDMIMt6hlfr5gaiNCZuJqJ3DSSS
         fUGQ==
X-Gm-Message-State: AOAM532zTIo2Uzu96s+S+IbRcr5OfOC2ulD5NrBNzePou9x7WS/cUVul
        450pvv98DDpcSCpf01Xm+JiixLfa0GglQJ//27I=
X-Google-Smtp-Source: ABdhPJzHIimFKFdpvNlyjrJFZoq+9sht5as+u3dxKNL5X6CgRp/ja15bbH7/Fz9n2O8EwngZkHNGrzkGuL4Rca57TYE=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:5745:: with SMTP id
 q5mr30422692qvx.29.1600379158156; Thu, 17 Sep 2020 14:45:58 -0700 (PDT)
Date:   Thu, 17 Sep 2020 14:45:45 -0700
In-Reply-To: <ce28bb9bc25cb3f1197f75950a0cfe14947f9002.camel@perches.com>
Message-Id: <20200917214545.199463-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <ce28bb9bc25cb3f1197f75950a0cfe14947f9002.camel@perches.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3] nfs: remove incorrect fallthrough label
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hongxiang Lou <louhongxiang@huawei.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is no case after the default from which to fallthrough to. Clang
will error in this case (unhelpfully without context, see link below)
and GCC will with -Wswitch-unreachable.

The previous commit should have just replaced the comment with a break
statement.

If we consider implicit fallthrough to be a design mistake of C, then
all case statements should be terminated with one of the following
statements:
* break
* continue
* return
* fallthrough
* goto
* (call of function with __attribute__(__noreturn__))

Fixes: 2a1390c95a69 ("nfs: Convert to use the preferred fallthrough macro")
Link: https://bugs.llvm.org/show_bug.cgi?id=47539
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v3:
* update the commit message as per Joe.
* collect tags.

Changes v2:
* add break rather than no terminating statement as per Joe.
* add Joe's suggested by tag.
* add blurb about acceptable terminal statements.

 fs/nfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index d20326ee0475..eb2401079b04 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -889,7 +889,7 @@ static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
 		default:
 			if (rpcauth_get_gssinfo(flavor, &info) != 0)
 				continue;
-			fallthrough;
+			break;
 		}
 		dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", flavor);
 		ctx->selected_flavor = flavor;
-- 
2.28.0.681.g6f77f65b4e-goog

