Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2913BE947
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jul 2021 16:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhGGOGh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jul 2021 10:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhGGOGh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jul 2021 10:06:37 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF045C06175F
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jul 2021 07:03:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id m15so1115721plx.7
        for <linux-nfs@vger.kernel.org>; Wed, 07 Jul 2021 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWNFrdwm6dcxTY21QGy8ATtNEyVg7/urw+nLZear+zs=;
        b=o4LRhO72WAxkjFpfvMzD3o/1FAAsCDu5aCw510DNs2eBNaSjlYrIpkFykrCVLDKL1U
         s59iySE/2R0meVkyYsRh5/aDMK2bs5d4t0ndd2qReWnaVYQegobQk7Cl2U686PIlSYjm
         pdbAwpEjOIaO8QJgjaarjHwHNjQdodwuy5TII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWNFrdwm6dcxTY21QGy8ATtNEyVg7/urw+nLZear+zs=;
        b=SiMMoMxDHW4+x1WQgwcQ4eVztRgbUnC+zcfzIVB+yVYo1Y5OOgj2RJFa9dUcdXgoqD
         sTeFIq7C3HmpAE3aWFbSaArcVBh5QLO363Fie08SSJWiSi63oXHfOUsRwztwutO/loiS
         Wrf283H/gsvWE4I5BP5eWO+XpQjG1jsXCPh2Ui56Ciaq+KeMMZopykCoBnPRQc1nqLq/
         fu55WkrNr4SvgCvHnv1fO1libNaWn9rbncljasRGLnCVvp3/3pHG4RpDpbFTTwokRVrF
         wXiYEk/B4oRYh3mkbubK5Dqm584YAlfGhQ9NQLKetyWRPbl+LcjVRhFA+QY7xikgEi/E
         Aw6Q==
X-Gm-Message-State: AOAM532bFzyI6rRBjek0Znt+2rA2SrvPhOJmao7ax/CrjI8hXcYR4CgN
        4iEt+V5xIhYc1VLrr/xgFtopeAUAoxoXr8e0ngCDGA==
X-Google-Smtp-Source: ABdhPJzYp4Rxfp2XxhR8boKcjXa39jZOtwTV1136/jM2Fr+/Zu+vKcUvF1dLgCaH0tcVOYCbMrw1b4sciZnGYydNn9s=
X-Received: by 2002:a17:902:7b8c:b029:129:5733:2e3b with SMTP id
 w12-20020a1709027b8cb029012957332e3bmr21491990pll.4.1625666636278; Wed, 07
 Jul 2021 07:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <004d01d76cd3$18db1830$4a914890$@lucidpixels.com> <CB1159AE-7C7F-402C-9F52-954FFAEAAEE8@oracle.com>
In-Reply-To: <CB1159AE-7C7F-402C-9F52-954FFAEAAEE8@oracle.com>
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Wed, 7 Jul 2021 10:03:44 -0400
Message-ID: <CAO9zADz9S1MhnWbA3OA5hJ6vkbu3-2Hakk86orR=92AWBvkQnQ@mail.gmail.com>
Subject: Re: linux 5.13 kernel regression for NFS server
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 29, 2021 at 9:01 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Hi Justin-
..
> > --- config-20210628.1624867695  2021-06-28 04:08:15.152781940 -0400
> > +++ config-20210628.1624867962  2021-06-28 04:12:42.591981706 -0400
> > @@ -1,6 +1,6 @@
> > #
> > # Automatically generated file; DO NOT EDIT.
> > -# Linux/x86 5.13.0-rc7 Kernel Configuration
> > +# Linux/x86 5.13.0 Kernel Configuration
> > #
> > CONFIG_CC_VERSION_TEXT="gcc (Debian 10.2.1-6) 10.2.1 20210110"
> > CONFIG_CC_IS_GCC=y
>
> It's likely this regression is due to a last minute change to
> alloc_pages_bulk_array() done just before v5.13. See:
>
> https://lore.kernel.org/linux-nfs/20210629081432.GE3840@techsingularity.net/T/#t
>
> for details.
>
> --
> Chuck Lever

Hello, thank you!  Confirmed that 5.13.1 includes the fix and it is working.

Justin.
