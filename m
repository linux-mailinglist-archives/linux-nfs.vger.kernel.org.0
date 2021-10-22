Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8269F437EA4
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 21:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhJVTbz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhJVTby (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 15:31:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8A7C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 12:29:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id l5so1042103lja.13
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 12:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MIYbiqTAgOZcVD7o78/iMiC5v0PdYgNzQoieL1dnhA=;
        b=NpDhMd+K20exoXtDQK8VxJJZx2jeiKfduhNixPkqDW3AhUt9xwYIfDXlKXTXwxZNO2
         rNDgVo6Zt+p6dmQo5I+h/tgPznlF+wHZKxE1z8e+Cg4jyabcAJUUy8ldhvdjRTw7E0CK
         ZCzjOxlNRUs2SJlFmk4Z3ttWsxuy0Et3Uj530=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MIYbiqTAgOZcVD7o78/iMiC5v0PdYgNzQoieL1dnhA=;
        b=b5cYVoU+Y46KLEIHKz+AFR8sUrebSFbMckrDFUZEWPDEsdVCzT3Io/nHBaOGyOzzyi
         aPVD9yw8l52xMJe3gzH9ZuBXYsqf/j9ZTky0hsWCrnRLlyM5K429amJtZxCMHsXx1wG1
         x/pkUhvFU54nye7RHKeVBHXVBXdlI9EeN6dmsvHYYhRDtRusxmNPxEmQwI0gPcVsqFL9
         IS7JNwUghR2fTGQ9ANvNMayy/japq39WU1F7OtE6uf1B7N2NCfoVfu7ou+jhxfSugu5t
         NLFVLN+OJ2IVyAcZGI/C3+V2i6dpUJ14x4YCuSDoAtYmsxDWVUVKrBNNB26Dthb4vvz3
         uCmA==
X-Gm-Message-State: AOAM530hreRdMJ5C1AGAyWx7RHNbaOvaQ4myi/w96nr/7/+zq//6udo5
        M6S5czNSkxAeZ2RiwGo75Kb+oU+K87TcB5uI5fU=
X-Google-Smtp-Source: ABdhPJwITuBuzBEv3DzupIN4DLl61oTrZKY+8xG79/PQVA2lWTDN59yV15HxVNO1N8IX5qHrhbbZmQ==
X-Received: by 2002:a2e:504:: with SMTP id 4mr1895775ljf.100.1634930974773;
        Fri, 22 Oct 2021 12:29:34 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id y5sm981865ljy.38.2021.10.22.12.29.34
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 12:29:34 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id l5so1042064lja.13
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 12:29:34 -0700 (PDT)
X-Received: by 2002:a19:ad0c:: with SMTP id t12mr1362164lfc.173.1634930491229;
 Fri, 22 Oct 2021 12:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Oct 2021 09:21:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjmx7+PD0hzWj5Bg2b807xYD2KCZApTvFje=ufo+MxBMQ@mail.gmail.com>
Message-ID: <CAHk-=wjmx7+PD0hzWj5Bg2b807xYD2KCZApTvFje=ufo+MxBMQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/53] fscache: Rewrite index API and management system
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 22, 2021 at 8:58 AM David Howells <dhowells@redhat.com> wrote:
>
> David Howells (52):
>       fscache_old: Move the old fscache driver to one side
>       fscache_old: Rename CONFIG_FSCACHE* to CONFIG_FSCACHE_OLD*
>       cachefiles_old:  Move the old cachefiles driver to one side

Honestly, I don't see the point of this when it ends up just being
dead code basically immediately.

You don't actually support picking one or the other at build time,
just a hard switch-over.

That makes the old fscache driver useless. You can't say "use the old
one because I don't trust the new". You just have a legacy
implementation with no users.

              Linus
