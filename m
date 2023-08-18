Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA607812BF
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 20:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379384AbjHRSSs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 14:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379466AbjHRSSi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 14:18:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E22D7D
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 11:18:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so10565e9.0
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692382712; x=1692987512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3j4Mqn/PbeNoccarhbs+EdB7Fu2ck9H3LC4u5W/k/o=;
        b=NHuGuvQVCXo1QS1pE+nZc/9rYhs+1IJwmwoSCY6rdKHSK61HzJrCDuO7aEL5x4uNwL
         a7A6bHEhYKjE5qjg9dTUsTTrtMBmzrlVo/MTjNdAb/S6l3ovkXRFpb+fTlbV6woR9G5l
         GSZzg7HdUJTo7VHEkeXUvGIvP+15UKjOILSYNKGaTmWuXI/mQjYVSZ7t8ZJxS2KZIg4z
         gHu+D091lYezJYa48+Xh+k7boUNygg2PFF0D5rbLQ/wUoUp2jpC0opS3S6ZXMLTqL1uY
         AQtgF5sL8zAjxdxNO6M93RrFv/vlGa5Kc1I6wyKTJZN+X/nnBGKfv8VtB+ECbiEyrhvA
         H2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692382712; x=1692987512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3j4Mqn/PbeNoccarhbs+EdB7Fu2ck9H3LC4u5W/k/o=;
        b=V//aQWVGCNDyIBneuce6cqWzMoDIqsfAN6ifEA1pgdPiu+94ITx4vmQBVG4erwWuS+
         mK3xhrvNYKkT0mrRBuMEiJVdbHLJ6pURsbbg76Zk0j2DsMVuUI3y9SCuA1pUO+QMyCV1
         JKpiJAqXGlI7rBp2yWF3SFldUc5J+3OR3FbcMTXcBTsZZSnm+AquDT7mueWkJhzfdnx6
         H0GoSRi2vENL12QRjr4PHWC6cIrdNx/k398ZFLwN4uDA7r5OHNYVJQCDXlVSeUvCtuzI
         EG/HIo8koo+jKYnhJc3XTJjRZpNF5WD6DYUXdBzBRKyhMHIMBgXZbdPuLlYKsJw7cljk
         F0SQ==
X-Gm-Message-State: AOJu0YyvBvSna1jLL0ggZ2ijqc2jPl+HeK/CPK/Jn2GHeUQuN+23D1Ve
        0IVw3PIhJFzb9aQPPsW6aBDyIumSGLvOyZQI4JDWhw==
X-Google-Smtp-Source: AGHT+IE2bnr83EpQmRKVuas2woPVovHkWEaZ3QEqDJfRlcyK67dVgTIbS1ftqyNCMU8/OGRnxXNOu738uWH7fudiVGY=
X-Received: by 2002:a05:600c:1907:b0:3f4:fb7:48d4 with SMTP id
 j7-20020a05600c190700b003f40fb748d4mr106532wmq.3.1692382712518; Fri, 18 Aug
 2023 11:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230818041740.gonna.513-kees@kernel.org> <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
In-Reply-To: <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Aug 2023 20:17:55 +0200
Message-ID: <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 18, 2023 at 7:56=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> On Thu, 17 Aug 2023 21:17:41 -0700 Kees Cook <keescook@chromium.org> wrot=
e:
>
> > From: Elena Reshetova <elena.reshetova@intel.com>
> >
> > atomic_t variables are currently used to implement reference counters
> > with the following properties:
> >  - counter is initialized to 1 using atomic_set()
> >  - a resource is freed upon counter reaching zero
> >  - once counter reaches zero, its further
> >    increments aren't allowed
> >  - counter schema uses basic atomic operations
> >    (set, inc, inc_not_zero, dec_and_test, etc.)
> >
> > Such atomic variables should be converted to a newly provided
> > refcount_t type and API that prevents accidental counter overflows and
> > underflows. This is important since overflows and underflows can lead
> > to use-after-free situation and be exploitable.
>
> ie, if we have bugs which we have no reason to believe presently exist,
> let's bloat and slow down the kernel just in case we add some in the
> future?

Yeah. Or in case we currently have some that we missed.

Though really we don't *just* need refcount_t to catch bugs; on a
system with enough RAM you can also overflow many 32-bit refcounts by
simply creating 2^32 actual references to an object. Depending on the
structure of objects that hold such refcounts, that can start
happening at around 2^32 * 8 bytes =3D 32 GiB memory usage, and it
becomes increasingly practical to do this with more objects if you
have significantly more RAM. I suppose you could avoid such issues by
putting a hard limit of 32 GiB on the amount of slab memory and
requiring that kernel object references are stored as pointers in slab
memory, or by making all the refcounts 64-bit.
