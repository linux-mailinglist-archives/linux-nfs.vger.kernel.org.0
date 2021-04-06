Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9CE355C71
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Apr 2021 21:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhDFTlm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Apr 2021 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbhDFTll (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Apr 2021 15:41:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B079C06174A
        for <linux-nfs@vger.kernel.org>; Tue,  6 Apr 2021 12:41:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u5so23825390ejn.8
        for <linux-nfs@vger.kernel.org>; Tue, 06 Apr 2021 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcDl6tC0057Us4IPh7R+dtZuOqBZazYFD5q1YATGt5c=;
        b=sIg2SLM015O7hlZkbLMg0/RN8TbEIEA72tAXtDzoDUc0ZngMTerIGMi5wx+0zLP4Qm
         aEDRhnc9AZLOmd10nt8zjosPx9X86ZEaFSMJJaopC5JNJptPaRZuRM/0ds1q/5x17+QO
         8kOZ7lvLP8FHqqRDfRhG7Zm7BgGZTuGKH5IymGBv/JYeRpe3HwGZN8DChsmCQgFXE5Ai
         dRWzk7tV3jJyNMpuIajnfodBfcSY3vdgYfhU/yWoJ96WN2do9eecyJLX3DjEgMSGplB/
         wgqkL1WIqLl1Cpsx1SFD2wkF5lndYWShTqXe3AntVYPJMVVNyxBKStH0MPyPJcf5kgJS
         MvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcDl6tC0057Us4IPh7R+dtZuOqBZazYFD5q1YATGt5c=;
        b=dgAeC5QIPzhBxiKMhxz5CXb1CVN74PyGhZzU8P+QEUOx1NYOjZRyeh64pMKpZ1w6nc
         vVYp3f11cHpjo+bU0qKClD68oUS+nbap5hB3L2Weie3+aXtN9wGp92qvoQk6EG0KW1/b
         /nklk5roSZ3skUi0QSN+gzhnEfl3bu5QN5oilv6nTNb/qDNk+nOPv6R/aw6uBjFB3FHV
         uIpSsEdKfRNqpg1pb1pJfwOqL2G1QOGjLp6T0pJz2DHDVHdWsgTSaAFpDraPI9iuXL2B
         M8dXxgjP6VUi/YSGAW2FvOjJFr8f4TX3K+JJhWM9wer1TgO02c4gL506uoNQSYhqA2aT
         zlEQ==
X-Gm-Message-State: AOAM531+Z816gQs6aARw7BaoYtsoSJwA5EsLDRB/x85J9E5YCDIdKCGc
        6SZuyjH6v50zi2BmC26MrUMUglZBbvfwDmSJI6FcmWI2
X-Google-Smtp-Source: ABdhPJxRQGc0OXJJS9Jh72n+XPM9zO4XQJ//O+Rrs10XdMrSChyVj0BuQfcFCa7v5DBoP/eefre5ez8i924l2DjvXUg=
X-Received: by 2002:a17:906:4c91:: with SMTP id q17mr2274706eju.0.1617738090731;
 Tue, 06 Apr 2021 12:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210402233031.36731-1-dai.ngo@oracle.com> <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
In-Reply-To: <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 6 Apr 2021 15:41:19 -0400
Message-ID: <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's export.
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 6, 2021 at 12:33 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >
> > Hi,
> >
> > Currently the source's export is mounted and unmounted on every
> > inter-server copy operation. This causes unnecessary overhead
> > for each copy.
> >
> > This patch series is an enhancement to allow the export to remain
> > mounted for a configurable period (default to 15 minutes). If the
> > export is not being used for the configured time it will be unmounted
> > by a delayed task. If it's used again then its expiration time is
> > extended for another period.
> >
> > Since mount and unmount are no longer done on each copy request,
> > this overhead is no longer used to decide whether the copy should
> > be done with inter-server copy or generic copy. The threshold used
> > to determine sync or async copy is now used for this decision.
> >
> > -Dai
> >
> > v2: fix compiler warning of missing prototype.
>
> Hi Olga-
>
> I'm getting ready to shrink-wrap the initial NFSD v5.13 pull request.
> Have you had a chance to review Dai's patches?

Hi Chuck,

I apologize I haven't had the chance to review/test it yet. Can I have
until tomorrow evening to do so?

>
>
> --
> Chuck Lever
>
>
>
