Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692E0355D0A
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Apr 2021 22:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347168AbhDFUnf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Apr 2021 16:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245602AbhDFUne (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Apr 2021 16:43:34 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4E1C06174A
        for <linux-nfs@vger.kernel.org>; Tue,  6 Apr 2021 13:43:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id e14so24006880ejz.11
        for <linux-nfs@vger.kernel.org>; Tue, 06 Apr 2021 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daYdRP/Ty/Qa0OIKPNwVUwpc37WYTp3B8DKdrbpE3Ug=;
        b=P+hPQAyyHoWMsN+wVgP1EfUg43hZYigJGR7Qx6Hu9JMX7OUwxMkGNvGx+xsDxsc0S9
         qDQbsAecAxUvuqentYiuhHYMVoqDpoHLTxO0abd0QzM1BysQ2pciw4JEiYrfa2NhXZ6x
         WnZss048PNsnuCfoQZ86yh+9cytUBM66APSCh7MCfpn5UfpSO1ugXc4PAfvxAdtYoDtN
         nQVISCt8Ja5Ih+W908WZGZEChMIaXU+OELYxZoei2Faw2gQG/bkwj59opHy+XvJQMsKj
         nzL2FgUsusR17mCuHUrW2+RRbXdJmfQ2Q0oFlTBre5U3MvujN66kLuf7K7hefx57FF2c
         BL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daYdRP/Ty/Qa0OIKPNwVUwpc37WYTp3B8DKdrbpE3Ug=;
        b=LkHzkTyRywToLc7zc4nZ7gqgN8hEIMR6vJBGCGoOGPfVnhcwo3o4czOJTxDwc8wi7M
         l/QtlknHzD/mWeV4Mz42xQN4YF2P1LgherNIuAI4PHcyfes9jniSYPdIy/MoMPlqYOCF
         vyGP4x4AYPndF156xDOOHm7AAzIc21Dbo4YNBoK0RxpWu/4ObHvR3w2wkmjGzu2g03dl
         rDfUHRJa8W7gYndb2hRdmtnCe2PHhp2VecRmtezxCKztMTQNdhTQeUe5c5bGt+3X3cZQ
         okd5mqIqiLhPORVyCcuvQE90+o3rqODAzDCAIEa4l7Y/iWp7YBLF0LT/vPS1THm9/xbx
         UpzA==
X-Gm-Message-State: AOAM532+B3upTIQXfhbJaMnAaEfpIWWR9v5mACOr61PASMvV2QSUEtQq
        ZmW02jV6ibGPX1xTLH+7R0lfdtKDnofkjBmGlPg=
X-Google-Smtp-Source: ABdhPJyo8i89F5Q+nxbZne+yYMLqrGx6023ke2zw2cQznQGoAiujDI7QXsL9hB4tyTzN+RVOFuzPhrVUghSoeFw7XRs=
X-Received: by 2002:a17:906:e2d4:: with SMTP id gr20mr36724768ejb.432.1617741804594;
 Tue, 06 Apr 2021 13:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210402233031.36731-1-dai.ngo@oracle.com> <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
 <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com>
 <7BED2160-1052-49EE-BB62-6ACF6F84C91C@oracle.com> <CAN-5tyEKqNHmwiMfCpkZrCVYeaO-FH69v5L4Tk_8EsoTfytpVA@mail.gmail.com>
 <01CD778D-57A0-442A-8D1D-5084F0FC2497@oracle.com>
In-Reply-To: <01CD778D-57A0-442A-8D1D-5084F0FC2497@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 6 Apr 2021 16:43:13 -0400
Message-ID: <CAN-5tyFEXBiWVbCq0Hgh01W=OVZkdYYAEujSug6biBaU=Ny8Og@mail.gmail.com>
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

On Tue, Apr 6, 2021 at 3:58 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Apr 6, 2021, at 3:57 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > On Tue, Apr 6, 2021 at 3:43 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Apr 6, 2021, at 3:41 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >>>
> >>> On Tue, Apr 6, 2021 at 12:33 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> Currently the source's export is mounted and unmounted on every
> >>>>> inter-server copy operation. This causes unnecessary overhead
> >>>>> for each copy.
> >>>>>
> >>>>> This patch series is an enhancement to allow the export to remain
> >>>>> mounted for a configurable period (default to 15 minutes). If the
> >>>>> export is not being used for the configured time it will be unmounted
> >>>>> by a delayed task. If it's used again then its expiration time is
> >>>>> extended for another period.
> >>>>>
> >>>>> Since mount and unmount are no longer done on each copy request,
> >>>>> this overhead is no longer used to decide whether the copy should
> >>>>> be done with inter-server copy or generic copy. The threshold used
> >>>>> to determine sync or async copy is now used for this decision.
> >>>>>
> >>>>> -Dai
> >>>>>
> >>>>> v2: fix compiler warning of missing prototype.
> >>>>
> >>>> Hi Olga-
> >>>>
> >>>> I'm getting ready to shrink-wrap the initial NFSD v5.13 pull request.
> >>>> Have you had a chance to review Dai's patches?
> >>>
> >>> Hi Chuck,
> >>>
> >>> I apologize I haven't had the chance to review/test it yet. Can I have
> >>> until tomorrow evening to do so?
> >>
> >> Next couple of days will be fine. Thanks!
> >>
> >
> > I also assumed there would be a v2 given that kbot complained about
> > the NFSD patch.
>
> This is the v2 (see Subject: )

Sigh. Thank you. I somehow missed v2 patches themselves and only saw
the originals. Again I'll test/review the v2 by the end of the day
tomorrow!

Actually a question for Dai: have you done performance tests with your
patches and can show that small copies still perform? Can you please
post your numbers with the patch series? When we posted the original
patch set we did provide performance numbers to support the choices we
made (ie, not hurting performance of small copies).

While I agree that delaying the unmount on the server is beneficial
I'm not so sure that dropping the client restriction is wise because
the small (singular) copy would suffer the setup cost of the initial
mount. Just my initial thoughts...

>

>
> --
> Chuck Lever
>
>
>
