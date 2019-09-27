Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30772C0E19
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Sep 2019 00:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfI0WoW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Sep 2019 18:44:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36490 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI0WoV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Sep 2019 18:44:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id x80so3062116lff.3
        for <linux-nfs@vger.kernel.org>; Fri, 27 Sep 2019 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UwSSJy15lqLdjwLfpsk3R3EoKs3M3+DyuxlQmnhgzFY=;
        b=KG0GPEhB4yI2UkkiLVvvfUC0fe3KS87zi2YmU4FaAjPZyfFOSt+evL7Qdj12aTQif6
         P8S/6U3LDBPWEwma7vrvobooIFOgoeAQQ0h4EPIl6CUxBE3xFoWqxg88aemIuL+NC/Dh
         HazHKFOKb1ffKnkcbl6O7hxptqfzzMeeqaE0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UwSSJy15lqLdjwLfpsk3R3EoKs3M3+DyuxlQmnhgzFY=;
        b=KAmN6nEiH/1/+YgCWljx8VfEaqRpdAXBi7t2Cp8jE317GCCIqORO1j4nm/BmqyrKfx
         GgFhG9l71gnexk+P/PotTQQYdeMGy2vfanEo+vVaMBpzzl3k5puWMiq6amaXikwyv1tW
         VMtIQwIgtdgtqjqvPr7ffYdNiJ+d9f5uAlswsYLoICTi9cSr+Z9Zjn34pymnFCMasJKJ
         bKEMYTZYiVjiqZXFLU+2VOIIjjyshjGZUBou+POP5OVYMux5bsKtHIei898Ik97IQnmc
         CmmTczRb3rxrdAYZ8rkxPpkHG87ZZ6i0kzQtPYqA0fzQuRJFER9sm6adq8+hGBbmELyu
         ut4w==
X-Gm-Message-State: APjAAAXzTfM7lWczl44+3Qam7E7K0yItzcOspHTzZg6EfDlsBC93e6/A
        x0ecL3CADpWem2zZPlMZkrMb+Q+CU9s=
X-Google-Smtp-Source: APXvYqxZgBV4QsyOyFZJc4WwB+Q+y9oN+4/7h/jv7xnHCzyGtyoFgCU324su7vGMDtva7uGhIkGK+Q==
X-Received: by 2002:a19:6549:: with SMTP id c9mr4028138lfj.99.1569624259330;
        Fri, 27 Sep 2019 15:44:19 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id b15sm745605lfj.84.2019.09.27.15.44.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 15:44:18 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id v24so3993175ljj.3
        for <linux-nfs@vger.kernel.org>; Fri, 27 Sep 2019 15:44:18 -0700 (PDT)
X-Received: by 2002:a2e:3015:: with SMTP id w21mr4513668ljw.165.1569624258157;
 Fri, 27 Sep 2019 15:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190927200838.GA2618@fieldses.org>
In-Reply-To: <20190927200838.GA2618@fieldses.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Sep 2019 15:44:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_bMxjz_T9Oa62Uyp8tKnKomtHKV9HTnuvMxrdwuTPOg@mail.gmail.com>
Message-ID: <CAHk-=wj_bMxjz_T9Oa62Uyp8tKnKomtHKV9HTnuvMxrdwuTPOg@mail.gmail.com>
Subject: Re: [GIT PULL] nfsd changes for 5.4
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 27, 2019 at 1:08 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Please pull nfsd changes from:
>
>   git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.4

Hmm. I styarted to pull, but then realized that the description
doesn't match the content at all.

You say:

> Highlights:
>
>         - add a new knfsd file cache, so that we don't have to open and
>           close on each (NFSv2/v3) READ or WRITE.  This can speed up
>           read and write in some cases.  It also replaces our readahead
>           cache.
>         - Prevent silent data loss on write errors, by treating write
>           errors like server reboots for the purposes of write caching,
>           thus forcing clients to resend their writes.
>         - Tweak the code that allocates sessions to be more forgiving,
>           so that NFSv4.1 mounts are less likely to hang when a server
>           already has a lot of clients.
>         - Eliminate an arbitrary limit on NFSv4 ACL sizes; they should
>           now be limited only by the backend filesystem and the
>           maximum RPC size.
>         - Allow the server to enforce use of the correct kerberos
>           credentials when a client reclaims state after a reboot.
>
> And some miscellaneous smaller bugfixes and cleanup.

But then the actual code is just one single small commit:

> Dave Wysochanski (1):
>       SUNRPC: Track writers of the 'channel' file to improve cache_listeners_exist

which doesn't actually match any of the things your description says
should be there.

So I undid my pull - either the description is completely wrong, or
you tagged the wrong commit.

Please double-check,

             Linus
