Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C8F2A8889
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 22:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgKEVKi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 16:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVKi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 16:10:38 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25E7C0613CF
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 13:10:37 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id o21so4715575ejb.3
        for <linux-nfs@vger.kernel.org>; Thu, 05 Nov 2020 13:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hD1JHGyBmCoD2u4B0+QIQoDydS/XKLh8Fbp4gRSy2t4=;
        b=JIJ6WYGv6HHP6wpaHbaAYmCg/thIJRo+a7TR0BPIaWPPUPQwh4atH/Ou8W3OyViilu
         Bl8X1f6Sba8WnFT9nTdeKzA1pkIfjsKzCx3wKFrwqTOxBo33rHmCDWHntCgRekxVblle
         /8/7c7mcEwmA2kAtMjRY2G86uRMMJk8F50RchrskJ2LPHrN8JaBIS/cQdfLyrB9Fqah5
         VdD+cCjXcl4kNT1WKKc2CLDcAp6RUbaGTAYHLrCGqHaNpIUadqRJ8O63F3w2MBFxyZv2
         Yu8oyUAIES6e800752ez9/FnNXku4bwu15SfTXMm1yAlswg5cnQyV/lUHsxioaycd/Yw
         tkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hD1JHGyBmCoD2u4B0+QIQoDydS/XKLh8Fbp4gRSy2t4=;
        b=tqlnXSLvHPWMZKVfsAMP4YmyNgUHU7oeIx51ZvOSI7Yx2fFN5auPprZw7ZpDRk1ign
         LAiMbtorQJuTvk+ryoB9iQtranxBCA2d6IsbNkh7h8s+DLtEPHIz+DzbPQvyBYPoAR9U
         H3rLZg3hYaG6/OoW91vFU+EIop7QNACd/e/q8BdJKzJXA1uDvOEmLJt17Kkjn7B9Fts+
         wNQGo/1ZogERsPAfN6erhumMwnDuqWu1dtKwuvt4kBVDixKypLpnEt6aiYoeupl5GX/Z
         YGFxGy447ahdTjZ0u5RQv6kWlxRBCT0LTtaqMfdrqqHbiIAGkE+81R3j7CqMKP6GM9t+
         wOrw==
X-Gm-Message-State: AOAM530upsEoErS694tQzo9N373AzhykvH8uvQZnyCGUi1v12V5kNay/
        Rnms7FMb5cUipLSxgUvokCyTX2youTak3v1Vm5k=
X-Google-Smtp-Source: ABdhPJyPWJoafnOvHY2kK5AX6ekX8z0fOVMtgU3Z3XrONypcJzfOxFbDvyHQ54PUE4siuG7NJfab7dwjD4Z8/sVgglw=
X-Received: by 2002:a17:906:3b89:: with SMTP id u9mr4196894ejf.436.1604610636443;
 Thu, 05 Nov 2020 13:10:36 -0800 (PST)
MIME-Version: 1.0
References: <20201027174945.GC1644@fieldses.org> <CAFX2Jf=-Y905+cMtLike2ddpthCV=K6CM8iS4EPeAz1RYzF-pA@mail.gmail.com>
 <20201105205205.GC25512@fieldses.org>
In-Reply-To: <20201105205205.GC25512@fieldses.org>
From:   Anna Schumaker <schumakeranna@gmail.com>
Date:   Thu, 5 Nov 2020 16:10:19 -0500
Message-ID: <CAFX2JfkyD6WZptqtoirj=1j3mH8m9Uzx4XKZo2OxzQ5g+qN+xA@mail.gmail.com>
Subject: Re: xfstests generic/263
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 5, 2020 at 3:52 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Oct 27, 2020 at 03:59:56PM -0400, Anna Schumaker wrote:
> > On Tue, Oct 27, 2020 at 1:49 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > Generic/263 is failing whenever client and server both supports
> > > READ_PLUS.
> > >
> > > I'm not even sure the failure is wrong.  The NFS FALLOC operation doesn't
> > > support those other other fallocate modes, are they implemented elsewhere in
> > > the kernel or libc somehow?  Anyway, odd that it would have anything to do with
> > > READ_PLUS.
> >
> > I just ran xfstests, and I'm seeing this too. The test passes using
> > basic READ on v4.2, so there might be something farther down the log
> > that diff is cutting off. I'll see if anything sticks out to me this
> > week.
>
> I think 091 is failing from the same cause, by the way.  I haven't
> investigated any more though.

These tests do a combination of directio reads and buffered reads. I
don't yet understand why this is a problem with READ_PLUS but works
fine for READ

Anna
>
> --b.
