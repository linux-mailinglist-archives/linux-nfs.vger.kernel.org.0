Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010A51C1D34
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 20:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgEASbA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 14:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730036AbgEASa7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 14:30:59 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2FFC061A0E
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 11:30:58 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b2so3426860ljp.4
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3/eq4U4mb3aT65X9LT4kh52VMeKsD/VdbN6I08Rkuk=;
        b=LJlZaEg8IFjmSO6QYRnwiO26xGWcL4y2lrFsC/rMf4cK0+zQg/3tTA/nV3AFpw54kf
         oCo9Q24bJ5Mbhk/bCAPWNE+2RisaAi0QY/khLrM+su9grRTjly+zNpD//Vlk/0yob4fE
         MrrXuIYbOt+S2+zWY3QB80+bUS/u0x9LACdKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3/eq4U4mb3aT65X9LT4kh52VMeKsD/VdbN6I08Rkuk=;
        b=OkVJm1yWlNl2iep3+spvX5mH6yneUOh13T7pPj4GLYP0huCGAqDjF2baIZICv9KjDH
         qfdhPPuDrX+8yt2+tskhEPV8cdHVNxJ1cMT/PC9yCSqmD9dt+TTW0juYABbbw5gVA97R
         06Kob8qYuzrGrKBaznc3gLIFFx6Z5JiDs1pOTd+2m3WuLfH0ZIVNESjM/GmbZKQb5FGY
         c4WiByi09Ve9Bh+HpHoeFnrjCmMfYo4x8K8xjuRIIe2yePRox82PBWaWllHGwIi3+lYg
         ESxhKsr8pItO7R8zKfc6+q05CLmEWw2giWTJB4F/6YsqL6NYg1d4aAquderhYQ+Vpt9u
         wzvA==
X-Gm-Message-State: AGi0PuavBn/Dz6AJ7YxrxuH1YqioNv2n4VVFTX9o7W9Ql0IW8CD2QOgh
        NGxdVleiytHd3CbxorT41ETfeTsht/g=
X-Google-Smtp-Source: APiQypLK1sPhgLbaxkVjsQRNTOWDqib6SWD4+U+jCxKGMM99vO+nqEWURvdYQQ+ZMr7nsQMBLs3Fbg==
X-Received: by 2002:a2e:2a82:: with SMTP id q124mr3216142ljq.155.1588357856219;
        Fri, 01 May 2020 11:30:56 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id l8sm2376769ljo.5.2020.05.01.11.30.54
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 11:30:55 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id u15so3437232ljd.3
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 11:30:54 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr3284912ljj.265.1588357854595;
 Fri, 01 May 2020 11:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com> <20200501182154.GG5462@mtj.thefacebook.com>
In-Reply-To: <20200501182154.GG5462@mtj.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 May 2020 11:30:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgB=PDdMX=uwsSrcERgSyyNW83Hj=WTWWjKp9dyriEzVQ@mail.gmail.com>
Message-ID: <CAHk-=wgB=PDdMX=uwsSrcERgSyyNW83Hj=WTWWjKp9dyriEzVQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
To:     Tejun Heo <tj@kernel.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Shaohua Li <shli@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 1, 2020 at 11:22 AM Tejun Heo <tj@kernel.org> wrote:
>
> Looks fine to me too. I don't quite understand the usecase tho. It looks
> like all it's being used for is to tag some kthreads as belonging to the
> same group. Can't that be done with kthread_data()?

I _think_ Bruce wants the signal handling unification too, because
nfsd wants to react to being shut down with signals.

But you're right, more explanation of why nfsd wants/needs a separate
grouping is a good idea.

                    Linus
