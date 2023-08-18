Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C286878144D
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 22:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379974AbjHRUZV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 16:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380005AbjHRUZD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 16:25:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A794218
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 13:25:00 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68879c7f5easo1136057b3a.1
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 13:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692390299; x=1692995099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKjBP6hN7INqNwDmWxh7eEodgLwdBsbDZDvaG7+HpeE=;
        b=egJ39qsdNDnaP8eBPC82Q2jt0LO0zgNc95KY2wtH+1V9wbBTLh1Ky6jQ8rTauBiJ/b
         ht64aXi61KNBL+Y8bEkkcaHZ81EwY79cKy4mJrPXZWraEd9SsbYba8O66Uznhj9BPFlo
         Uapx6baXCoHKgND+281kPb5nFph/dYaduliqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692390299; x=1692995099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKjBP6hN7INqNwDmWxh7eEodgLwdBsbDZDvaG7+HpeE=;
        b=BbANCmVwMpF1XPb9P7miaRRwEVTXPh6cueA61iZEYlIpTvW2rOW6kqkCdDs7xCgDrd
         D+0BDAy48WAx4OFEEQj5gxPnUcI3P29DhgMdUeBfxIC2hDwfPMBGxg5N2XVYcRfMoAw3
         fD3U+qswMwdlqstaJ/V0CmDT7KbxH8DIjKKf9RKpw1mr1TABqRd4elbIkTGSkW70fLop
         JT8crE+37kMht62YzxeQMq0ePa9NuQdEZdrsIj5qD59HTc+kWxPEY3GKHCqxzUp6/jnk
         m5KDSOqSdlcYH+B0N0MEKXRpVKAmavfwcivpp00cWnLJNB1mL6nn9xBdXzLoOE1slL/1
         B0FA==
X-Gm-Message-State: AOJu0YyS44EKSymrwFATzJugVgJvRqsaMTexhMdq/X1SaY1gEUVykqvy
        9fTID5o0lmodP2PLLtWNhwRZ7g==
X-Google-Smtp-Source: AGHT+IFzZ5xua6284VP9UIz+L1TCJGOBeZWzRVDjkLYvOiLi5m1A3dBrZZ7aSqweUnt5zS1+NUVOeA==
X-Received: by 2002:a05:6a00:24c6:b0:687:3022:9c1a with SMTP id d6-20020a056a0024c600b0068730229c1amr298176pfv.28.1692390299149;
        Fri, 18 Aug 2023 13:24:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b0056428865aadsm1755227pgp.82.2023.08.18.13.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 13:24:58 -0700 (PDT)
Date:   Fri, 18 Aug 2023 13:24:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-hardening@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
Message-ID: <202308181317.66E6C9A5@keescook>
References: <20230818041740.gonna.513-kees@kernel.org>
 <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
 <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
 <202308181146.465B4F85@keescook>
 <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
 <e5234e7bd9fbd2531b32d64bc7c23f4753401cee.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5234e7bd9fbd2531b32d64bc7c23f4753401cee.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 18, 2023 at 04:10:49PM -0400, Jeff Layton wrote:
> [...]
> extra checks (supposedly) compile down to nothing. It should be possible
> to build alternate refcount_t handling functions that are just wrappers
> around atomic_t with no extra checks, for folks who want to really run
> "fast and loose".

No -- there's no benefit for this. We already did all this work years
ago with the fast vs full break-down. All that got tossed out since it
didn't matter. We did all the performance benchmarking and there was no
meaningful difference -- refcount _is_ atomic with an added check that
is branch-predicted away. Peter Zijlstra and Will Deacon spent a lot of
time making it run smoothly. :)

-Kees

-- 
Kees Cook
