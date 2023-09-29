Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC177B3AA1
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 21:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjI2TXT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjI2TXS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 15:23:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73D01B1
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 12:23:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5cd27b1acso130438505ad.2
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015396; x=1696620196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uITMbz4SVXsN3h2p6aW3e9TM2Nhes+MRerhsiPaKZNY=;
        b=AbbVozCPWIk1zV6cZUH5CSaZpt7rK1BnPE1Ux7/ha8/NLhTBab64ak5Ad8jvl/S1B3
         ICGZ37cXj0jZVuWNTfPmWfj1RQFV9x0WyHo0YD+W3qc9g6qfxrIFEgkTeBTdGv6IBV3X
         c+F/oyGPtFczP67f76G7q3J3LJkIOJ/HYe+EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015396; x=1696620196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uITMbz4SVXsN3h2p6aW3e9TM2Nhes+MRerhsiPaKZNY=;
        b=ppX7GsHUqFXvg0clA6wX4tlP/9iY7H1ZzUrKjqq++Wm95Gh+Isoef3RU1YK/KOjUbh
         S3azUyR4gHN/DAr5hKxNXHyjietQoYDuUUxelIxjweq6lCUNNTgicMyB/MYZYS8vineV
         dKRZDYRSOQdcFm9Efp4qBSb3lze8Upm4tv7hcUn6FD/e7/7h09+GJm3JjGKD/n5D3ABS
         8s7uEd+i9eq5o7vBApCKQpbX31ZEMPOsq7mDUmTLQM5ztp+mGa7L/lIA4PXYxtMoivJ5
         t5aRCNC3b25bsy9+A5aAC8/hA+NSy4PHBnP9HwtBnZ2LYPJdWq3xkAlH7L6SFsOZKV1v
         wMlg==
X-Gm-Message-State: AOJu0Yy5NfRSTu4TN8F/g16sBCA+8SqSPRg1zGJep36t47wq+mWY4AnZ
        H8q2vsgyLWLIbVQ92bpQmHn9Yg==
X-Google-Smtp-Source: AGHT+IEl0LvVWNhM9XEtVBHF0eypOkjX2wKUhmTs9VMGSa1/dOxPXszHikcyziAnfqiFcWEiXhH1Og==
X-Received: by 2002:a17:902:bd94:b0:1b8:4f93:b210 with SMTP id q20-20020a170902bd9400b001b84f93b210mr4598464pls.45.1696015396110;
        Fri, 29 Sep 2023 12:23:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709026b4a00b001b8a2edab6asm17138005plt.244.2023.09.29.12.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:23:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Anna Schumaker <anna@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-nfs@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nfs41: Annotate struct nfs4_file_layout_dsaddr with __counted_by
Date:   Fri, 29 Sep 2023 12:23:13 -0700
Message-Id: <169601539363.3014051.18337419689508974314.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915201427.never.771-kees@kernel.org>
References: <20230915201427.never.771-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 15 Sep 2023 13:14:27 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nfs4_file_layout_dsaddr.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] nfs41: Annotate struct nfs4_file_layout_dsaddr with __counted_by
      https://git.kernel.org/kees/c/4d8e2b2fb0cf

Take care,

-- 
Kees Cook

