Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16903BF204
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jul 2021 00:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGGWYq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jul 2021 18:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGWYq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jul 2021 18:24:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFABC061574
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jul 2021 15:22:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v20so5839775eji.10
        for <linux-nfs@vger.kernel.org>; Wed, 07 Jul 2021 15:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hu09cGchw4ZBf2ieIR80Yn6dGqn6lP49htN7WlvjKZ4=;
        b=lpE6J89rc6cj4R5CWe5QRYqW6ydFhWdDmL/wwbLKzFqooCJDB1rL5omC5MeAPGBzg8
         IQqYkVl1oMTR9+rQsLH3rnF7VPMycaJZTKxdiBRPcWYXJa26u+8Q7nA80m63SuQjfveB
         LjB9085RjfO8XCYSpG4O4kMgVwfXfaGqsabr6NvpsZPV617mSwFfivCjxaW/Dyk5zhDR
         a0y0K+qdVh/m3UUUYtcNsoqfcYiDqJFZXbaLdwc9kwXk+mQSKuTRG4Vk9e8b40LiweHT
         CHqdyTRiIqNaSlbs4olUDenriXjKdFGKHSKfORv9YHTfZ5PrhI1A7gXS5ovbe2isOkqI
         txxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hu09cGchw4ZBf2ieIR80Yn6dGqn6lP49htN7WlvjKZ4=;
        b=AOzmmNDP4HpGzGs1nphILEGyLfl+5ovFwM2wYDoRkNmMKnSEFamosg91Wm0ISpTDvG
         mrr8SJSQKcty6RU8R7NAxPmadpTwCwi9tw6QzLgxBZgpVsegfioRf3FLWxx+WGsMe32s
         /rvCSqZLAGU/AzBt9AL7v6eMXP+JcUbBkePfuUFPLzIV1UCxQ5wseNJn9KGeifDQKSVY
         DBsfAaTed0Ms9BDn+d7jHqihpPuo41q+/sWH1e4m5UNy1UdZUAL9XwZv0jgF0FWMANNC
         VcqJkIdf+z+wXqgs9iXIEn1AeNjcTtbIJu4zTOJ7PV8GLzqJnstZRszVIGXmggHQU5pu
         oQAg==
X-Gm-Message-State: AOAM531y2gAnFr7rSwGI+JeKkii85xbdJs4mmufEgDWVSpR6I8cHLxct
        1DhdaPz1iOHeKWNyCNhErC3juJgz0Ga/+cZ/ICfnhw==
X-Google-Smtp-Source: ABdhPJzllkXaMNJbX2zObO1Jgdbfvn6nTpyjApuD7m0eb56UufExnQ+kgEo0M6vgI1Trs30wRX8hFQk0C8RTfvDFdGw=
X-Received: by 2002:a17:907:7709:: with SMTP id kw9mr27403583ejc.68.1625696524045;
 Wed, 07 Jul 2021 15:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <162458475606.28671.1835069742861755259@noble.neil.brown.name>
 <162510089174.7211.449831430943803791@noble.neil.brown.name>
 <CAPt2mGMgCHwvmy2MA4c2E316xVYPiRy4pRdcX4-1EAALfcxz+A@mail.gmail.com>
 <162513954601.3001.5763461156445846045@noble.neil.brown.name>
 <CAPt2mGNCV7Sh0uXA0ihpuSVcecXW=5cMUAfiS0tYr_cTQ0Du8w@mail.gmail.com>
 <162535340922.16506.4184249866230493262@noble.neil.brown.name>
 <CAPt2mGNOMh0uWozi=L5H6X7aKUuh_+-QxJ7OK9e6ELiKnSh1hg@mail.gmail.com>
 <162562036711.12832.7541413783945987660@noble.neil.brown.name>
 <CAPt2mGM6mcqM9orzHuyTVgX2pnG5Y7nLeM85tdZ5LoDO9XozBA@mail.gmail.com> <162569314954.31036.11087071768390664533@noble.neil.brown.name>
In-Reply-To: <162569314954.31036.11087071768390664533@noble.neil.brown.name>
From:   Daire Byrne <daire@dneg.com>
Date:   Wed, 7 Jul 2021 23:21:28 +0100
Message-ID: <CAPt2mGPSeK6YHPQ8r6Z0UJv4mJnRAcEEc4VmLaENo91-K8P=fQ@mail.gmail.com>
Subject: Re: [PATCH/rfc v2] NFS: introduce NFS namespaces.
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 7 Jul 2021 at 22:25, NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 07 Jul 2021, Daire Byrne wrote:
> > I stripped out all my patches so it's just this one on top of 5.13-rc7
> > and I can still reproduce it.
> >
> > I can only trigger it by mounting the same export (RHEL7 server) using
> > two different namespaces and performing a heavy IO benchmark to either
> > mount (leaving one idle). Part of the benchmark walks thousands of
> > dirs with files (hence the readdirs).
> >
> > If I mount the same server twice with no (same) namespaces, even with
> > the patch applied, it works fine without any crash.
>
> That's pretty solid evidence!
>
> I just realized that the stack trace you reported mentions
> "kfree_const()".
> My latest patch doesn't include that, and nfs doesn't use it at all.
> Might you still be using the older patch?
>
> NeilBrown

Oh... the last stack trace, the readdir one? I don't see kfree_const
myself but I may have a case of word blindness. The first one I
reported definitely has kfree_const but after your latest patch, this
last one around readdir doesn't seem to?

I'm pretty sure I have your latest patch (with kfree instead of
kfree_const) correctly applied. Though, I will double check that the
correct kernel and modules were then installed properly on my test VM.

Daire
