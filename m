Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00AE79CC18
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 11:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjILJkp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 05:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjILJkp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 05:40:45 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5C11BE
        for <linux-nfs@vger.kernel.org>; Tue, 12 Sep 2023 02:40:40 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-594ebdf7bceso53680967b3.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 Sep 2023 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1694511640; x=1695116440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/vvgLyYPDhkbWsRRJdRij+x20FAmOn99Wk/F04+9Hkw=;
        b=RgppV3vcFA49mEn6Ur93/z9EzHpA3JAE96sP9uN0ATYqJkcFt+lWrFvfnUnvizEDBj
         s/9gtRahq8B4WJeNBL0iGVlRjH8OeLLW/Abrw/yxJfjxO+4t0WpokjJYaaH1oBsBbdLY
         sx+SsPcKIEXm94YEQcjqBwvfCXKq9tNVbpbmKiXhuZOYFKBT9NaGVOF2R5h3vwCCLSMN
         GVimHOZbKogqEvl311r2+Z2g6sQAYJsZA07t8Rf+zRJBeg5/z0Sg5kECY8yb2ViakI4u
         vcFKd+4q5vhVbDHZsZtVlOqeUGZbT1WLI6h2bY8mhsgsKqrGdft8GAZRncPDiHXWvWGZ
         V3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694511640; x=1695116440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vvgLyYPDhkbWsRRJdRij+x20FAmOn99Wk/F04+9Hkw=;
        b=dDc+i3c31ui58nsVL6AbE3y3bAIMsSElKGFJoR0EhqXK5VkKkv4r4+algxHk6pW2x6
         jNfH7x5N5q5O94XtgWbqO2eXPdRSFx8ZJ+n+HJJ+RxNkSC21ghCt+IekXnZLyh8qYo3u
         yBVkc2hsAhK+86aNTfG6uwfD+OWrmRu3Ag7raTfuY9C2p+FolZP+gmpboFs4h0mU4ITz
         aJ2vpo4NPKLiROFAPG6qMzKEf4O/9pyKfv0CcLi5D3M6kg2FFuj4Wlyina2xv2FeUj9J
         a0eG3PLObPiBqdgu1rV0yhcAMLSuJpC1DQbdzC4HNlm03A4AgOzpiUZYUBS2Ojtn0qxn
         fyiA==
X-Gm-Message-State: AOJu0YwLBpyhqFmRHE3eGGrDW0O439V5k+nD3856+wJ8qB3mYBf5XrRb
        1yKU60hPX50yrKQFI5WayjSP8MAQyhU3ZO2DI+6+apFzoVGtaq8gc5k=
X-Google-Smtp-Source: AGHT+IHC+QIo+dM0WucjAme/5+WfL+tsV5m7O7VHafEag0N6AIltI5++QCnoLDjsu57f8BL6T1ln/rmRk2uIBZ4tluI=
X-Received: by 2002:a25:6009:0:b0:d7e:c554:caf0 with SMTP id
 u9-20020a256009000000b00d7ec554caf0mr9667605ybb.50.1694511640125; Tue, 12 Sep
 2023 02:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230911185031.11903-1-trond.myklebust@hammerspace.com>
In-Reply-To: <20230911185031.11903-1-trond.myklebust@hammerspace.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 12 Sep 2023 10:40:04 +0100
Message-ID: <CAPt2mGPAjD_227EHZQ58+-HH17KtF7MEOJX3KCvdHcaR3x5VLQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] NFSv4.x client improvements for knfsd re-exporting
To:     trondmy@gmail.com
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Just to say, we see similar problems with NFSv3 servers re-exported to
NFSv3 clients.

In our case we have a single server re-exporting multiple NFSv3 remote
server mounts. If one of those re-exported mounts goes "bad" (network
loss, network congestion, server load), the knfsd threads slowly get
consumed by eager clients of that (hung) mount until there are no
threads left to serve the clients of all the other mounts/servers
being re-exported by that single server (that are still good).

The "softerr" mount option on the re-export server does not help with
this and the svc_rpc_per_connection_limit can make this much worse by
allowing a handful of clients to lock up all the knfsd threads very
quickly.

Even when the conditions of that "bad" server improve, there seems to
be a feedback loop of both the re-export servers retrans and the
clients of the re-export servers retrans that means many duplicate
lookups occur for a long time - it is often quicker to just reboot
that re-export server. Even worse, these duplicate lookups can
themselves cause high ops load on the original server and so the
requests timeout and retrans etc etc.

The only thing we have found to make this a little more bearable is to
increase the timeo (>30 mins) to minimise retrans and set the
svc_rpc_per_connection_limit=4. This at least reduces the chance that
a single re-export server that is serving multiple mounts can remain
responsive for all other mounts it serves. The other option would be
to just have a unique re-export server for a single mountpoint but
there are resource constraints when you have 30+ servers and mounts to
deal with.

We are still unable to use NFSv4 for our workloads because they often
involve high latency re-export servers 150+ms away and NFSv4 re-export
server performance is still limited by parallel metadata ops:

https://lore.kernel.org/all/CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com/#t
https://bugzilla.linux-nfs.org/show_bug.cgi?id=375

Daire

On Mon, 11 Sept 2023 at 23:01, <trondmy@gmail.com> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> When re-exporting a NFSv4.x filesystem through knfsd, we want to ensure
> that the individual knfsd threads don't get stuck waiting for the server
> in a NFS4ERR_DELAY loop. While it may make sense to have the re-exported
> client retry a few times, particularly when the clients are using NFSv3,
> ultimately we want to just punt a EAGAIN back to knfsd, so that it can
> return NFS4ERR_DELAY/NFS3ERR_JUKEBOX, and free up the thread.
>
> With that in mind, add a client module parameter, 'delay_retrans', that
> specifies how many times a 'softerr' mounted NFSv4 filesystem should
> retry before returning EAGAIN.
> In order to avoid disrupting existing setups, the feature is disabled by
> default, however it can be enabled by specifying a positive value for
> the new parameter.
>
> Trond Myklebust (2):
>   NFSv4: Add a parameter to limit the number of retries after
>     NFS4ERR_DELAY
>   NFSv4/pnfs: Allow layoutget to return EAGAIN for softerr mounts
>
>  .../admin-guide/kernel-parameters.txt         |  7 +++
>  fs/nfs/nfs4_fs.h                              |  2 +
>  fs/nfs/nfs4proc.c                             | 43 +++++++++++++++----
>  fs/nfs/pnfs.c                                 |  8 +++-
>  fs/nfs/pnfs.h                                 |  5 ++-
>  fs/nfs/super.c                                |  8 +++-
>  fs/nfs/write.c                                |  2 +
>  7 files changed, 63 insertions(+), 12 deletions(-)
>
> --
> 2.41.0
>
