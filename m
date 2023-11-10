Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDFA7E760B
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 01:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjKJAsb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Nov 2023 19:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKJAsb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Nov 2023 19:48:31 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A2A30EA
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 16:48:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50931355d48so1932516e87.3
        for <linux-nfs@vger.kernel.org>; Thu, 09 Nov 2023 16:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699577307; x=1700182107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ki/MAD9irLGvvLHxr5/U5c9xo4Z+oX1KyqBb8vcY6QQ=;
        b=WeM988EeNbByTIaceaLtc/16VgMvPMVEcmfEJnhAba1LQzq7klCI9usoUP5dG2UZS2
         mUqfovV/CR6/NEmZZr1NSS9HfXcMg8lR9deomSNb5k41snP2hckylP5t/ZY0pNaUi6tp
         KeaA3Hze8dZau7JmTUtOC2N2+qA5X3SjaMnOppzeXzezG3Twc3716uHSAWyWXc+gyQEE
         6KeRxEs1afTgCJQNLTciUWW2XU72g7AamIAFC533poWCKCT4qQ2eU5dzwrCs/RkEB+hl
         r/Prel/lxSWshoPmrXnj5mF8t2M8Z7Pp7heb/j6Q1iLpP2otYx/5MyqLMPIHZL5WCT5w
         XJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699577307; x=1700182107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ki/MAD9irLGvvLHxr5/U5c9xo4Z+oX1KyqBb8vcY6QQ=;
        b=dOLmfwKmRfZ2+N2L3XWDm2A7fJvUhyB2rK5EyQKBFqM8jonp4EZCQJalrFNNrxJsIr
         lKhf+XKj9qhMOsLAeBSeaSwDUXoGfapikotY2vviNOOU0LDzFGc1/GfHt9ijL9P/dq81
         L5jYZcYosHkEyDB3pJxjVCQToqrX9yytFyNGys/4hLKIx1JFiK1rw8a3zg15iBm8UTNI
         KdA+d9RUAWdwx/WUN73V6UAP8K5VxigZe3MzShgiplF1oTyDXrH1QYisPucOZJKcelHA
         JcZUjr/k7nwThZqBicTnSc7xLfm+hu7Kd6rq1tkKRXCjnZnP1XPXGhSjvSp2QQKqKVE9
         m5SQ==
X-Gm-Message-State: AOJu0YxhksMDEKuAJwskaL6iJEOnB3pypQlioepD9twC90x7ffLyqQWl
        5n77XUiSOsM80iWCrfCriUwOITlv9KQTNd6pEnIKsqI9
X-Google-Smtp-Source: AGHT+IETna02FfPEdduuhyR5hcRyhLBtrqSnBglqW0K0prRx/cHm1kG0H9ORxJW3Ky/vFBLKCHuQAyootyYOi52/H/E=
X-Received: by 2002:a05:6512:2002:b0:506:8d2a:5653 with SMTP id
 a2-20020a056512200200b005068d2a5653mr2389480lfb.47.1699577306635; Thu, 09 Nov
 2023 16:48:26 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com> <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
In-Reply-To: <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Fri, 10 Nov 2023 01:47:50 +0100
Message-ID: <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
Subject: Re: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 10 Nov 2023 at 01:37, Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Nov 9, 2023, at 7:05 PM, Cedric Blancher <cedric.blancher@gmail.com> wrote:
> >
> > On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@gmail.com> wrote:
> >>
> >> Good morning!
> >>
> >> Does anyone have examples of how to use the refer= option in /etc/exports?
> >
> > Short answer:
> > To redirect an NFS mount from local machine /ref/baguette to
> > /export/home/baguette on host 134.49.22.111 add this to Linux
> > /etc/exports:
> >
> > /ref *(no_root_squash,refer=/export/home@134.49.22.111)
> >
> > This is basically an exports(5) manpage bug, which does not provide
> > ANY examples.
>
> That's because setting up a referral this way is deprecated.

Why did you do that?

> The
> preferred way to do it is to use nfsref(8).

nfsref(8) is not shipped by ANY Linux distribution. The configure
switch in nfs-utils to build it is OFF by default, and the
distribution maintainers refuse to enable it because it can be
"dangerous", or may be "experimental". I got many excuses why they
dont want to enable that damn configure option.

Also, stable and oldstable Debian do not have it enabled either.

Seriously, why was refer= in exports(5) depreciated? There is no
realistic replacement, unless you fix every damn Linux distro first.

PS: Sorry for being moody, but I tried to get nfsref(5) working for a
month on Debian bullseye, and it just didn't work.

>
> > Plus, /ref must not be a dir controlled by the automounter, or a Linux
> > 6.6 kernel will panic
>
> Can you open a bug report at bugzilla.linux-nfs.org <http://bugzilla.linux-nfs.org/> (product "kernel"
> component "server") and provide the details of the panic?

Yes, I can

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
