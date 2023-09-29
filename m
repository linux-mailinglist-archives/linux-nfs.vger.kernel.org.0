Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E79E7B3AA3
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 21:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjI2TXT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjI2TXS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 15:23:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62183113
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 12:23:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdf4752c3cso106530785ad.2
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015396; x=1696620196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj4gKoTPER+a3Rg0p9JfyBeQ5oS9hCDvDWoKv93wILE=;
        b=a/lAaXm+ejXiqc2YkN2nOdhiEaetwdPcB76bNAmtW5Jkq2jwIwukr30QxdR8eP0Jjv
         cJLA6JJ0VQ0JMF8kgcxtv8r9MxiLi8VvnF2J/L467bMD1ETKLOSMfLee5UKZB+lXqOn/
         pqx3aSQZZAkruu+EVIZ4wqu5hHA8bHGW1N0aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015396; x=1696620196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj4gKoTPER+a3Rg0p9JfyBeQ5oS9hCDvDWoKv93wILE=;
        b=fIfpMR1WdrhFVWeW8XcQDlJO1ztGMDBonri4b5J3CKbwFSDS2LL4hRbXWa931nJFEZ
         EGaFgiJvqxlRO+1oYR0loF4tRo9aPxUo4ETb30sAVXhgFhfR8w8abWfRjnFQLjTFCeEp
         +2fZj6UJf60jlrLzFHYqH3lfPYermwTukiQG3IX8cTzY55nu2tiai5FVrjFrVQhnvOrG
         rTsipQEw+9VPtn7+Sdan/2pTxVGUSOixPNVAJGIH2UwhH5S5EB/8KCCZbZCUHzsiO9Dg
         0SPF8cNf1WoGSKip4XGPnKJenAS1/7Bh36CcZ6WPnz9RoIOC1BuxhmZFx8Z1y+sBtjzR
         e6qA==
X-Gm-Message-State: AOJu0Yyz3eJ57Y/7CKWaPt3U4muETI7odAtCcekDsmOOEaA+qacCb1fI
        bbSKakn5fe2KdeUOhS3TfeIHJ6qHkEiqmLg7fsU=
X-Google-Smtp-Source: AGHT+IHeAzZLWR/XUQ0/HfggCdQEIA48Tga8bx8nr8Ck+3J+Jkxeupd6kXb/kPWfsX+RHQbRBmpodg==
X-Received: by 2002:a17:903:1207:b0:1bd:f7d7:3bcd with SMTP id l7-20020a170903120700b001bdf7d73bcdmr5832816plh.50.1696015395852;
        Fri, 29 Sep 2023 12:23:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b001adf6b21c77sm1692175plg.107.2023.09.29.12.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:23:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] NFS/flexfiles: Annotate struct nfs4_ff_layout_segment with __counted_by
Date:   Fri, 29 Sep 2023 12:23:14 -0700
Message-Id: <169601539364.3014051.4375069928549336780.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915201434.never.346-kees@kernel.org>
References: <20230915201434.never.346-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 15 Sep 2023 13:14:39 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nfs4_ff_layout_segment.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] NFS/flexfiles: Annotate struct nfs4_ff_layout_segment with __counted_by
      https://git.kernel.org/kees/c/f8ead26ffdee

Take care,

-- 
Kees Cook

