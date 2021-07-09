Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CAB3C27C9
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jul 2021 18:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhGIQyJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Jul 2021 12:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhGIQyI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Jul 2021 12:54:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124FAC0613DD
        for <linux-nfs@vger.kernel.org>; Fri,  9 Jul 2021 09:51:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f30so24512777lfj.1
        for <linux-nfs@vger.kernel.org>; Fri, 09 Jul 2021 09:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POScCYO3L5Ni7K5IJDMuBcM7y+WItrME8kkxfvws3ek=;
        b=EU9r8vWEoGkrd+oqDc3JWjks89a7hhBpvolnGLsELcbw9Mngci6v80+RhlCzO/9AuJ
         6y4vqC5jmWJIR3TGTQPajSJ+RDQ79o+gDU/OXoYJEEi5kNfzsC4wkJef/dYIjwbAebTc
         NQhsy0KfaPm+ob3cOAdYCFnxPDMPTYrSeg8gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POScCYO3L5Ni7K5IJDMuBcM7y+WItrME8kkxfvws3ek=;
        b=DdXgPJSSOcvN+Xn9pUNTgljrY4KWv/uftvp9wPleE4CHQHH/uNCuhnWJT4fj1ZIZTt
         n4wJTjPJmSzEHghZxGeOfP+V3T0O3T2nMW3Kgnhg63xY9iPiZQOA6G5PNYYc3Tg63yA0
         3e9oei1l1HUv/WmBeqbDuTUKcxMvyreIlLuKJPmXAIcdJavz8ngXUOrTZrJxXwOjkuSD
         btuJgjfFQWlETc/avVO+ggLAJYC26BSYcg887w+hAFCkr31MFoktwlu9Kje7AlS95I0N
         GNS3iHaGvwV1TUThTGAhU9jBvYQTg4QPMVjvKhAEotKkISMeudfyLbXtFv5l+/iDRdX/
         LbTA==
X-Gm-Message-State: AOAM532jheR4fIC6Pco36vieulcxg2sDI5bNNbjrBLNhmeM7WU+Fwttq
        ki54fmsVbq3Zxfp8XxThccdoM+dcP885TiGcRrs=
X-Google-Smtp-Source: ABdhPJx/LphWGw2d/AeY4Dwe4Q5U2Xqb6s7YXwDf4Jc5a+jzL0C8+Z+gaPHSBRzDNUUAqTPwa0q83A==
X-Received: by 2002:a05:6512:1328:: with SMTP id x40mr28766936lfu.589.1625849482248;
        Fri, 09 Jul 2021 09:51:22 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id a24sm506314lfk.121.2021.07.09.09.51.21
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 09:51:21 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id b40so8987393ljf.12
        for <linux-nfs@vger.kernel.org>; Fri, 09 Jul 2021 09:51:21 -0700 (PDT)
X-Received: by 2002:a2e:a276:: with SMTP id k22mr29161691ljm.465.1625849481318;
 Fri, 09 Jul 2021 09:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <6809750d3e746fb0732995bb9a0c1fa846bbd486.camel@hammerspace.com>
In-Reply-To: <6809750d3e746fb0732995bb9a0c1fa846bbd486.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Jul 2021 09:51:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvNb9GVdbWz+xxY274kuw=xkYBoBYHHHO7tscr1V0YAQ@mail.gmail.com>
Message-ID: <CAHk-=wjvNb9GVdbWz+xxY274kuw=xkYBoBYHHHO7tscr1V0YAQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for 5.14
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 8, 2021 at 11:16 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> Please note that this branch was rebased today. The reason was I discovered
> that one of the topic branches that was merged contained some duplicated patches
> from the main branch (mea culpa). So the rebase simply removed those duplicates
> from the topic branch.

Please don't rebase just for pointless details like this.

Duplicate patches aren't a problem, and we have them all the time.

Yes, they can cause annoying merge conflicts (not on their own -
identical patches will merge just fine - but if there are then *other*
changes to the same area). But it's seldom all that big of a deal, and
if there's just a couple of duplicates, then rebasing is much _worse_
than the fix.

If there were *tons* of duplicate patches, and you have some workflow
issue, that's one thing - and then you need to fix the workflow. But
particularly for just a couple of patches, rebasing and losing all the
testing is really entirely the wrong thing to do.

In other words: only rebase for *catastrophic* stuff. Only yo fix
things that are actively broken. Not for some minor technical issue.

I've pulled this, but please avoid this in the future.

               Linus
