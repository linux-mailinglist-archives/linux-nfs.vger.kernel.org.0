Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D10B6067F2
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Oct 2022 20:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJTSKb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Oct 2022 14:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiJTSK1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Oct 2022 14:10:27 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847F49B62
        for <linux-nfs@vger.kernel.org>; Thu, 20 Oct 2022 11:10:15 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id e15so85160qvo.4
        for <linux-nfs@vger.kernel.org>; Thu, 20 Oct 2022 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mkMthEm2w0aWOa9HYP74wfwhuMeK5omBYFuu27xFlQU=;
        b=cACv2TqaQIvZr0DwJs0ElQVefpREW93nhJoayfLqodLHdKiwQgPWd2cmx+3OtTXEKH
         S70Y2qCNerUeDd8p/CKyY5c63CotrkdsHeyfmjrC0Y/xMuIDQY51XZl6iX8xCqIbjoce
         thSdFCDg47wk7NWr1Jpze9fioSRAXr3m6iGG3mik5c/kxY19uEdMBuu5k0G/ni1SgePp
         rGaRDGKaPY0Sh3W0+X8+8y9ZOOCgP/aVDmaAKhrnPq5QC26akQ96KBygT5+JVrXcOcuQ
         SgbXhSjEpT3o2zH/36BTqKrETqRvA42/GmkYwbcxgmhUqxcqbBTJcvIYeChl58AmZ8Vh
         kWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkMthEm2w0aWOa9HYP74wfwhuMeK5omBYFuu27xFlQU=;
        b=XvPw+bUDhuf8Z9az2tx/ECEAJgdDUmezi4UZc022fGBShaxHP0hyxFwAEUia9vldkd
         Fpczgr5IFm3daGW9cHwBFWz5sMDpMLr/cLPFaeOY8HxSqmfODxDfeKpTZLlpwWyrSbbk
         V2CqqEJm5kDD+j1eHm6zctIIAOs2T43mH643ZiFqGFF95r5bfNO7bzkFQv/Xmlpg59Oi
         xt+SED3n19j0s6mCF6vkC6oB1HfqgzCHLpLD8lZw2lQqpHrX7XfsgrP7+HZcFhXXPSBq
         SHPu0zGW61MjCPFuGdN/QPmyIdAnpM7EwWAvTM28CEPrwafKKzLdwUwrGGISxTp+zldc
         42Rw==
X-Gm-Message-State: ACrzQf1FxLH+18bPXKgD1JkDCc+iTf5ytruACy6fPP4QE1mnGZzPIIQw
        W3vdCA4VSa1iFkZa1fARALaTnS+4+oOo3N5z0x0=
X-Google-Smtp-Source: AMsMyM45RUervJIZ1x557wV9NTz8vA8CjatIYJvJzJvpSCCqEL8fIUy/7SL5041PP7eEtcVAWM0WWOdFdJkq/sshaqY=
X-Received: by 2002:a0c:8086:0:b0:4b1:cfa1:3c35 with SMTP id
 6-20020a0c8086000000b004b1cfa13c35mr12843879qvb.47.1666289356390; Thu, 20 Oct
 2022 11:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <166525550985.1954655.13884581337321315995.stgit@morisot.1015granger.net>
 <7AADFC73-5748-4D80-BED3-CF8D6A92D510@oracle.com>
In-Reply-To: <7AADFC73-5748-4D80-BED3-CF8D6A92D510@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 20 Oct 2022 14:09:00 -0400
Message-ID: <CAFX2Jf=zCF5_5q1yDMWgEABvgqQb9_HyDJ=5sRw1+6W4bAG33g@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: Fix crasher in gss_unwrap_resp_integ()
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Wed, Oct 19, 2022 at 11:50 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Oct 8, 2022, at 2:58 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > If a zero length is passed to kmalloc() it returns 0x10, which is
> > not a valid address. gss_unwrap_resp_integ() subsequently crashes
> > when it attempts to dereference that pointer.
> >
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>
> Hi, is there a plan to merge this patch, or does the fix need
> a different approach?

Thanks for following up. I'm planning to include it in my next
bugfixes pull request.

Anna

>
>
> > ---
> > net/sunrpc/auth_gss/auth_gss.c |    2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> > index a31a27816cc0..7bb247c51e2f 100644
> > --- a/net/sunrpc/auth_gss/auth_gss.c
> > +++ b/net/sunrpc/auth_gss/auth_gss.c
> > @@ -1989,7 +1989,7 @@ gss_unwrap_resp_integ(struct rpc_task *task, struct rpc_cred *cred,
> >               goto unwrap_failed;
> >       mic.len = len;
> >       mic.data = kmalloc(len, GFP_KERNEL);
> > -     if (!mic.data)
> > +     if (ZERO_OR_NULL_PTR(mic.data))
> >               goto unwrap_failed;
> >       if (read_bytes_from_xdr_buf(rcv_buf, offset, mic.data, mic.len))
> >               goto unwrap_failed;
> >
> >
>
> --
> Chuck Lever
>
>
>
