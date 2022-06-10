Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E31546FEB
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jun 2022 01:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348656AbiFJXUC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jun 2022 19:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347792AbiFJXUC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jun 2022 19:20:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24226F506D
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jun 2022 16:19:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kq6so708638ejb.11
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jun 2022 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFUZ/4X/JukFzJtRWCj5IwVqnR0commkjm8Ld9IJoQA=;
        b=AoxxrgfmaiG7fB01rWVX7//fR7hc8pfPaO6KuFkmEJpDpFR/HpqhwLdFQM6dVgzan3
         DB7+Ryy9LWRyARZSjDc1y62fbB3v6E3HNwslaXd4JIbxny9dkIOf8ftYNIIBC41esAeu
         4Gv6sMSeEfJjJ4Ad3imZr/QdI/L/mCWsQLeaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFUZ/4X/JukFzJtRWCj5IwVqnR0commkjm8Ld9IJoQA=;
        b=UHZeJz0giQJ6DnTxCJ9yV6of9Bqk3T2Nd3u7X4UfDWh/4ghZ6GraoEi5wWvSkFgPXr
         c/Wed96iQa0qOPZO/1HCbOELOckIaHeklvzKIHeJ0QZ/hrcaERZhe01aCxLnOJ9bIqP0
         gNzXk6LEskMuda7f6WaDiELR2HLx8/0Da0bKH8MO7+kKlGb1QXjLtdpnUUr7o3xVVsCD
         HPPdoY6iSX+OhhPYsvC6p8ThSQNIffonQRCkJiJVlCFJOD6OdeJ1uBv1czz2uJia2gTR
         YwwF8qAjaIhsfRw30i3oXX5MO0PcVpsbpP6xQcheDy2/2eWpvd80CfLtUP5YgQC9RqcX
         Y5sw==
X-Gm-Message-State: AOAM530iwHj7dQyR8OeglEIWNefXvrPCapxA5fnKsLgt3UCqGEIwvzAr
        WY/Ig9BD/EwyEtcU4t+85AZurRewYwZxI95a
X-Google-Smtp-Source: ABdhPJxSC6FzGtaQhAtKSl8UAQ73ODtPyilA1jKGhr+QTg7KZZL1WWg7upnuLIyfH0Ro0UnF3YzbCg==
X-Received: by 2002:a17:906:7308:b0:710:dad0:f56d with SMTP id di8-20020a170906730800b00710dad0f56dmr30793787ejc.691.1654903197042;
        Fri, 10 Jun 2022 16:19:57 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id ie5-20020a170906df0500b006fe89cafc42sm189169ejc.172.2022.06.10.16.19.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 16:19:55 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so1830724wmq.0
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jun 2022 16:19:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3485:b0:39c:7db5:f0f7 with SMTP id
 a5-20020a05600c348500b0039c7db5f0f7mr2015707wmq.8.1654903194928; Fri, 10 Jun
 2022 16:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <165489100590.703883.11054313979289027590.stgit@warthog.procyon.org.uk>
In-Reply-To: <165489100590.703883.11054313979289027590.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jun 2022 16:19:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgeW2nF5MZzmx6cPmS8mbq0kjP+VF5V76LNDLDjJ64hUA@mail.gmail.com>
Message-ID: <CAHk-=wgeW2nF5MZzmx6cPmS8mbq0kjP+VF5V76LNDLDjJ64hUA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] netfs, afs: Cleanups
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Jeff Layton <jlayton@kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 10, 2022 at 12:56 PM David Howells <dhowells@redhat.com> wrote:
>
> Here are some cleanups, one for afs and a couple for netfs:

Pulled,

               Linus
