Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247E457A1BA
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jul 2022 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbiGSOgb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jul 2022 10:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbiGSOgP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jul 2022 10:36:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C3E4AD62
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jul 2022 07:28:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a5so21839902wrx.12
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jul 2022 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBA7nGE+JU0OhCcxwdj/llRcg6HJZxzIH6X1zrDXAFI=;
        b=KSdwB8yGUhQ/W7IK9/DKppLkN/sSxecSAlPKxcJjdomINDQUMfBubwHx34okCoYmOn
         t11NTeZL4KiDfs99RYq1t5C1Qs18dUwG++46EHaa6MZzxOaAYrP+YFMeDFBxifn01Wsx
         NW9ZWsOqjklp0UIkeDNqVPdg5MpwfrmFQuD0eWa8EmYBac+OyuknL2Bz9nPVcN93S04Y
         iwp/2++IDWDctCyXRaCgvdAj+7ofe34yt2J7k0S3sjuZ2ys+KCSVWRb3N5oDbe0G2LVL
         /Dy76IRcObNjO85G2S3KwtaxEbQFWLoHhxGY1qAI3qn1Q9t27FIcwBvawe6gCGNprVWr
         xaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBA7nGE+JU0OhCcxwdj/llRcg6HJZxzIH6X1zrDXAFI=;
        b=qWelhSIUpvwdOO0ONx0QTAgxxkVOJK8Zb/uwckBPdzEHB+32dxAAVTUh8zWbDa/I1f
         bTh0yX09j4yxQphgSk67zp4uc25jWJjIgKLdCrJl43qnFqDDzlRAkAznsNazrk7PHR9g
         IfYXCgiyE1SBph8aLg22qbkQRmlJRbT4WKDPbomoJhuXyZIPg3bZIU/83lRR/2Pq/tKG
         c5yGSVqA/Gcm2sAZC9OLd0RFBml0g3p540QHQXRfkAqXbl+rCEKY2OFQYDcgLzlwcScc
         l9nKhCVGW/SQmlA0+EQ9pmu7rvBQvDjS3+Yn5X0amsAxPHc10hCZQZrQscMBSorcU0sv
         uieg==
X-Gm-Message-State: AJIora/EXR0iQcFVJjNBJer3psJBaOATRnABagAo8fY2+AtYUvmEGfcs
        wKvnI+7ZeJVK0SnaZcAJXkt704xQq3B3/5NSJHiWUWT4
X-Google-Smtp-Source: AGRyM1uEbDr7kkazRbnIgvajIIFmh3y7/ddYL1/xjRb6gjZf2QKUXDbPSU77p2eoAyAcYR721iPnBOgpLe5IxiCpsGA=
X-Received: by 2002:a5d:42c4:0:b0:21e:2cd4:a72e with SMTP id
 t4-20020a5d42c4000000b0021e2cd4a72emr3797477wrr.249.1658240925028; Tue, 19
 Jul 2022 07:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <165815281251.8395.9611588593452344848.stgit@klimt.1015granger.net>
 <YtYqNZCazm64S/Di@infradead.org> <4936C3D6-AE4B-4F7F-89D1-17CBF38A5CD5@oracle.com>
In-Reply-To: <4936C3D6-AE4B-4F7F-89D1-17CBF38A5CD5@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 19 Jul 2022 10:26:41 -0400
Message-ID: <CAFX2Jfm5pcAkf7k+DT4RFY1EDhMCDKFQT8B5XTdMwqZ2Z++_3w@mail.gmail.com>
Subject: Re: [PATCH] NFSD: Remove CONFIG_SUNRPC_GSS_MODULE
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 19, 2022 at 10:10 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jul 18, 2022, at 11:51 PM, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Jul 18, 2022 at 10:00:12AM -0400, Chuck Lever wrote:
> >> Clean up: I cannot find CONFIG_SUNRPC_GSS_MODULE anywhere.
> >
> > CONFIG_SUNRPC_GSS_MODULE is set if SUNRPC_GSS is built as a module.
> > CONFIG_*_MODULE is Kconfig-generated magic.
>
> I can drop this patch, but I still have questions (and I know you are
> just the messenger, you might not know the answers).
>
> Where is this convention documented?
>
> When would CONFIG_SUNRPC_GSS_MODULE be defined but CONFIG_SUNRPC_GSS isn't?

There is a macro "IS_ENABLED()" that evaluates as true if something is
either compiled in or compiled as a module. That's probably what you
want to change the "#if defined()" options to.

Anna

>
>
> --
> Chuck Lever
>
>
>
