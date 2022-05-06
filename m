Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444E651D385
	for <lists+linux-nfs@lfdr.de>; Fri,  6 May 2022 10:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390187AbiEFImN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 May 2022 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiEFImL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 May 2022 04:42:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC8C3B7
        for <linux-nfs@vger.kernel.org>; Fri,  6 May 2022 01:38:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l18so13097032ejc.7
        for <linux-nfs@vger.kernel.org>; Fri, 06 May 2022 01:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBkH1YgBBg5lHtmXPTC9d6coG0adV0HCM1ShUIWoEoc=;
        b=gFdBpA1ILmq2CQJufz20dOXpO9QPPBOGNDEN9iwP9yYgp8oBrRHcC2FpnXWqkQFP2u
         HbkZe6muAUQK/3mebQuSNrUP3Z0d+jKagUdzdfTl/Yg44DMBvZpRVHJVXbN+iwaEEmdQ
         qQ3F8CBFcyQObxRS1e9UCzfC8uf4uIIBuUgtencWVOB9v1ZGiuCGkBhSLFSkA5vZ+bf1
         FaSmX+5WZan+yPWgUNWy7bpj6YlZ+HSbMsjmplPcsDkn16KpnyxjiwMjrGI8mTZ3DPxT
         ye+OKNYpooGHg5TJvfGsOjBV/68xhos/y0mkE1YVvXi0aufiG5Zn9oCN6wOkZ2qpjXzt
         86Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBkH1YgBBg5lHtmXPTC9d6coG0adV0HCM1ShUIWoEoc=;
        b=p2R7s5KWR1KF3K2d0zB3AL35kfPchRxL1wg7wGEzTm/ZBSEghGESINuhsrzlYVJU7P
         z1SsRdH1Bcb4gMvPfokoLi1+YhVEdReYxNljqFH18DLK9ayVQV9kt8Qij+u0cLCsi3CG
         zXX14a6qnfdzVbjIA+ioVUbbm8F+OSIjmCEAIwCLWB/FZhoaDhJKH24ruV4Omo3DQ+37
         s5QGTjckaEz+z5Futq9n3zd0C5Hv4Yc03+55dWFuyezDnpUPgf5KPQKELrC1Ef/cQ8xQ
         ee4kR+i5JwCW/3mXTE8xuXBhcjPQYmDeyBe0zrpJIKqA+TD21J6S6xuhUMFYQCeTGBHL
         HHQw==
X-Gm-Message-State: AOAM530WRmurbbf89MAjJWMrkzIDieg0uTrQIlFh1tU8gh5nJeSjj5gg
        h1qXQ4QpcyzWiI+g0sYaFEcIipt1EWAMnZcbnTe0Vg==
X-Google-Smtp-Source: ABdhPJwufJaMAM2+MNOlVHAYPUzuPaCimo02YkmbADJ6ehIimaOWceDQz6W4LctqUXiCnzrmfjiFrEPSoDWSynLdYOY=
X-Received: by 2002:a17:907:1693:b0:6f4:ee60:16e8 with SMTP id
 hc19-20020a170907169300b006f4ee6016e8mr1858054ejc.312.1651826307950; Fri, 06
 May 2022 01:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220504132106.28812-1-dwysocha@redhat.com>
In-Reply-To: <20220504132106.28812-1-dwysocha@redhat.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Fri, 6 May 2022 09:37:52 +0100
Message-ID: <CAPt2mGMQ2x_aQwr2W18xX5LfUy6q118QxVqhdC663ZtUjZehdg@mail.gmail.com>
Subject: Re: [PATCH] NFS: Pass i_size to fscache_unuse_cookie() when a file is released
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        David Howells <dhowells@redhat.com>,
        Daire Byrne <daire.byrne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 4 May 2022 at 14:22, Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> Pass updated i_size in fscache_unuse_cookie() when called
> from nfs_fscache_release_file(), which ensures the size of
> an fscache object gets written to the cache storage.  Failing
> to do so results in unnessary reads from the NFS server, even
> when the data is cached, due to a cachefiles object coherency
> check failing with a trace similar to the following:
>   cachefiles_coherency: o=0000000e BAD osiz B=afbb3 c=0

I can confirm that this fixes an oddity I had noticed with the "new" fscache.

When running an fio read benchmark, if you remounted or dropped caches
between reads, it seemed like it required two initial reads of the
data (and writes to cache) before all subsequent reads would come from
the fscache disk.

Tested-by: Daire Byrne <daire@dneg.com>

Cheers,

Daire
