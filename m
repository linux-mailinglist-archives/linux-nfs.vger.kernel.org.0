Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDFD40B471
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 18:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhINQXf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 12:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhINQXe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 12:23:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656F1C061574
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 09:22:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y28so5798117lfb.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dYD2uKNORcxZ6YMCdwcOxjjHXEclNcfa/CTjAP47gc=;
        b=aWJRDZPRQV27jEUKoc4qE6zGbRoWbKwm9kcYSPpoNuqjBLGs9WKOvCqbYQZ04P3jy1
         4wsAum1KxojNT2yyO1DmteAlpzy+vIjQ6bjIvwLNB76bbbmj19VrvzgTZnYd6uwWG6vX
         yWKNOrbr5bi7cuk7kXat3qOTmWTGGPHSlwsBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dYD2uKNORcxZ6YMCdwcOxjjHXEclNcfa/CTjAP47gc=;
        b=BZROVNTkjTVshf+gFQyq+72eUobsBJtdC8gjoDjChY7qB5JfpqJrl8g5gpgz4urnhB
         pacWUqNdm10QElWZNYhfgQYe0rudh6X4VsCvj7CR4cXPcP/riPljjSf+/Mk7hpSlQYHF
         VVBkG9H7015yLs+JArCxZpFqlstzIyu80mD5VZtL9s4Q1z9EDj7BnbtWjWyeM+AZ0AmF
         DAo04TQ12pkC662MMKK22WGfAz0IbyW6VaLLi1J/xOzQiYw7wV/PPG6571a7tTP75I4J
         jMaHsqo2pqpAdi7vypNOXXBYegTyLm+2mWi+YoxT7JUJS+PVGt1H5xYH67qK/08CGt1E
         q52g==
X-Gm-Message-State: AOAM530eJxihVZI/KcSQcCtytYkAehjYnypFLQ5lGjA+SVtqWB3cToBM
        IfPE7rDGqUTlQHnOSZuCAXYE6/oXWzqtgRW7XJI=
X-Google-Smtp-Source: ABdhPJzArFlPkZFNnlx8Be5G+K2W3VX7EGnPiGktmmlgfxNn/qO8fUh/QGHEy7XwnI/LbCSgoCKaJg==
X-Received: by 2002:a05:6512:3d0b:: with SMTP id d11mr11488217lfv.20.1631636534812;
        Tue, 14 Sep 2021 09:22:14 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b19sm1150615lfb.135.2021.09.14.09.22.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 09:22:14 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id x27so30041035lfu.5
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 09:22:14 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr14013881lfv.655.1631636533920;
 Tue, 14 Sep 2021 09:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
In-Reply-To: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 09:21:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVK+1CyEjW8u71zVPK8msea=qPpznX35gnX+s8sXnJTg@mail.gmail.com>
Message-ID: <CAHk-=wiVK+1CyEjW8u71zVPK8msea=qPpznX35gnX+s8sXnJTg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] fscache: Replace and remove old I/O API
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 14, 2021 at 6:54 AM David Howells <dhowells@redhat.com> wrote:
>
>  (1) A simple fallback API is added that can read or write a single page
>      synchronously.  The functions for this have "deprecated" in their names
>      as they have to be removed at some point.

I'm looking at those patches, and there's no way I'll apply anything
that starts out with moving to a "deprecated" interface.

Call it "fallback" or "simple" or something that shows the intent, but
no, I'm not taking patches that introduce a _new_ interface and call
it "deprecated".

            Linus
