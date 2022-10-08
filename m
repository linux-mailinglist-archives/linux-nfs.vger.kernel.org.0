Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B01D5F8700
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Oct 2022 21:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJHTF4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 8 Oct 2022 15:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHTFz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 8 Oct 2022 15:05:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC59B37404
        for <linux-nfs@vger.kernel.org>; Sat,  8 Oct 2022 12:05:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b15so6893792pje.1
        for <linux-nfs@vger.kernel.org>; Sat, 08 Oct 2022 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKva1pFsfuqgoIJb+srIILrjXqoJtPS42tfHzEkNmrc=;
        b=CekR7HaUaBPxfQ7jIF3CdVMYLrp3EIW/Nv4aOnq6ugjdifExc4l1670DEpXlb7J1el
         oTum84aSYvNN3vIOC+8qPw8+axphBiFvfIX4G8Wnwci1VPuVg+K6YN/tBUPzybMIKnhk
         z+p3AilNoTy9XqurCjJBK/3g5vTiI0NOEMjoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKva1pFsfuqgoIJb+srIILrjXqoJtPS42tfHzEkNmrc=;
        b=WzD4bRKDe2MxwvVVWDsGGsC3sD7C5gZCvaDAByR12iEEJhun+vpcdJ332mTmKrfSGw
         n5cyZoS3bwUlKmUwuTm2yj+F3Ws5AXgWGpJ8I1sojbEkpW37+WEmR5voarjtr4AQ8gah
         tXCkGNz1+58Z5fsNT4P/O7K+0LDVt7DFB/DDJaHajEfDz0185fCFV12Aln/6kCxT++ja
         5Do9msMRJJbwEXo7MGFPR+b5Qk5hERp4SfxUGZDyjDyJED09LE+90XhxR9yj5ihHg5FA
         d68ePJQewFNxQFyly520YrtKPZoFwxIRXd7GCERSnrbtZUEXoObdFCnV5Fq9zig1fW4e
         dBqg==
X-Gm-Message-State: ACrzQf3eGCSGTIm4zLQeAp+J1SyIAvKW2Hx8JalzJt+/+LA8DxMjRWzl
        vWmatkQpinR/6Fhe4V0RIHbE7Q==
X-Google-Smtp-Source: AMsMyM4UBsuJabmxb5/cuTD/P98spHaqugs9ZabVRImOU1a77F2+tRJxGpP88jsl5skt4oeD745W3A==
X-Received: by 2002:a17:902:ec89:b0:178:3ea4:2960 with SMTP id x9-20020a170902ec8900b001783ea42960mr11228973plg.160.1665255953317;
        Sat, 08 Oct 2022 12:05:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902d41300b001754cfb5e21sm3651784ple.96.2022.10.08.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 12:05:52 -0700 (PDT)
Date:   Sat, 8 Oct 2022 12:05:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Avoid clashing function prototypes
Message-ID: <202210081204.BE88541@keescook>
References: <20221007235406.2951724-1-keescook@chromium.org>
 <7AC81CF2-2D64-452D-83FC-33E5BEA82209@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7AC81CF2-2D64-452D-83FC-33E5BEA82209@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Oct 08, 2022 at 03:49:45PM +0000, Chuck Lever III wrote:
> > On Oct 7, 2022, at 7:54 PM, Kees Cook <keescook@chromium.org> wrote:
> > 
> > When built with Control Flow Integrity, function prototypes between
> > caller and function declaration must match. These mismatches are visible
> > at compile time with the new -Wcast-function-type-strict in Clang[1].
> > 
> > There were 97 warnings produced by NFS. For example:
> > 
> > fs/nfsd/nfs4xdr.c:2228:17: warning: cast from '__be32 (*)(struct nfsd4_compoundargs *, struct nfsd4_access *)' (aka 'unsigned int (*)(struct nfsd4_compoundargs *, struct nfsd4_access *)') to 'nfsd4_dec' (aka 'unsigned int (*)(struct nfsd4_compoundargs *, void *)') converts to incompatible function type [-Wcast-function-type-strict]
> >        [OP_ACCESS]             = (nfsd4_dec)nfsd4_decode_access,
> >                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > The enc/dec callbacks were defined as passing "void *" as the second
> > argument, but were being implicitly cast to a new type. Replace the
> > argument with a variable the desired to perform the casting in the
> > function body. There are no resulting binary differences.
> 
> Hi Kees, thanks for the patch. I agree this internal API could be
> cleaner and more type-safe. A few things I noticed:
> 
> - Your patch does not apply to HEAD probably because it conflicts with
> 3fdc54646234 ("NFSD: Reduce amount of struct nfsd4_compoundargs that
> needs clearing")

Ah! Thanks, I will refresh.

> - A union type might be a better fit for this application, as that
> would avoid casting through an anonymous pointer. NFSD has a union
> type, union nfsd4_op_u, that is ideal for this.

Perfect, yes. There are similar conversions that used similar.

> Would it make sense to use "union nfsd4_op_u *", such as is done in
> fs/nfsd/current_stateid.h, in the definition of nfsd4_dec and nfsd4_enc ?

Yup; I think that'll be perfect.

> With regard to timing, I would prefer to queue this change for the
> v6.2 merge window through the nfsd tree, if that's OK with you?

Yeah, for sure. No rush. :)

-- 
Kees Cook
