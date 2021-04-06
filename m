Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E460355C9E
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Apr 2021 21:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhDFT50 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Apr 2021 15:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbhDFT5Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Apr 2021 15:57:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D289C06174A
        for <linux-nfs@vger.kernel.org>; Tue,  6 Apr 2021 12:57:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w18so18085318edc.0
        for <linux-nfs@vger.kernel.org>; Tue, 06 Apr 2021 12:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UlCKp1hOgyFEkg8dN88nQ0VQ3uPC2Mnk5Ex1y+KfZBM=;
        b=OfLWLTQU8Uw3ykdieu7JlZMuQBKi/xm3PLmhUt9/aIwWZCPpT5RvP7rXongZ5ZoZDA
         4/oc6o0Q/mkVJ7IkE5XtntcWA2lGorHQ2KVUKytcmH7hugl64pnu1nva7NtEjcXytduj
         BvrhaUazy7aJY8bsgUSNLnzuvvF0eZTwTpINLaNBm7Jngd1LDGjaWQExzW5PRvWSPxqM
         k4BUHcEmpGLVEznPzy8SKpXZeYpU0Z/sCRI0Dvqo7IZt4ejpGyiOGOzFgPYIKkigbnTE
         eeL4hL6Q7tRZXVwXc0TeNLcdeL5kmli7md6vD3YSZL8FTu3OtqzfOUicdb56e6C9V2mw
         Afzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UlCKp1hOgyFEkg8dN88nQ0VQ3uPC2Mnk5Ex1y+KfZBM=;
        b=ETDMpselPex39GxFrUiFlNlvAqic4rfOhO1X9Bbwl5AGYzMvOTYx651dl/FbBAQZ3Y
         4z31dcL3SgMjRKXZIELJauqUnOVA4CwkupCi3pmrDJFG2DthbYYqtIe4/jwtJOT/4c7Q
         DYGq+SnBdx+Eo+mMdgABFsvnm35MjpLKITNK9NzTkeuPTkKrot65YXJB/1TO3trdNyNC
         mYpVhLJ2k/TNKvgsBFSOv+Wl8S4/9Yj+HRRObVRrxUmOnxUlbN9t/QeBbSc7LTeCi3Q6
         HGsTK00CoRbXWFoW3jcO4xrcRYmufQl3HDgIhCBn1ODeifFeVj4oyDjNpuWBo5J8gOhZ
         jT9Q==
X-Gm-Message-State: AOAM530FgzrP8tMm+y+LCxlhPjZYhOFJUvGGtWW2OU+gVrpq0R9GhCIl
        1Ksz6fkD0gcbxcO5mvKx+zrfBLWnwGkSRxLFkPw=
X-Google-Smtp-Source: ABdhPJzRtrJ32nsldr6duiJjEz9rlCbSx7y4S/1QRdpeOTiWuuRSImmynxvdHV/bf2uYTMBJbIh/SV8KUTqLIKKhwRY=
X-Received: by 2002:aa7:cf16:: with SMTP id a22mr23008701edy.267.1617739036148;
 Tue, 06 Apr 2021 12:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210402233031.36731-1-dai.ngo@oracle.com> <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
 <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com> <7BED2160-1052-49EE-BB62-6ACF6F84C91C@oracle.com>
In-Reply-To: <7BED2160-1052-49EE-BB62-6ACF6F84C91C@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 6 Apr 2021 15:57:04 -0400
Message-ID: <CAN-5tyEKqNHmwiMfCpkZrCVYeaO-FH69v5L4Tk_8EsoTfytpVA@mail.gmail.com>
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

On Tue, Apr 6, 2021 at 3:43 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Apr 6, 2021, at 3:41 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > On Tue, Apr 6, 2021 at 12:33 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> Currently the source's export is mounted and unmounted on every
> >>> inter-server copy operation. This causes unnecessary overhead
> >>> for each copy.
> >>>
> >>> This patch series is an enhancement to allow the export to remain
> >>> mounted for a configurable period (default to 15 minutes). If the
> >>> export is not being used for the configured time it will be unmounted
> >>> by a delayed task. If it's used again then its expiration time is
> >>> extended for another period.
> >>>
> >>> Since mount and unmount are no longer done on each copy request,
> >>> this overhead is no longer used to decide whether the copy should
> >>> be done with inter-server copy or generic copy. The threshold used
> >>> to determine sync or async copy is now used for this decision.
> >>>
> >>> -Dai
> >>>
> >>> v2: fix compiler warning of missing prototype.
> >>
> >> Hi Olga-
> >>
> >> I'm getting ready to shrink-wrap the initial NFSD v5.13 pull request.
> >> Have you had a chance to review Dai's patches?
> >
> > Hi Chuck,
> >
> > I apologize I haven't had the chance to review/test it yet. Can I have
> > until tomorrow evening to do so?
>
> Next couple of days will be fine. Thanks!
>

I also assumed there would be a v2 given that kbot complained about
the NFSD patch.

> --
> Chuck Lever
>
>
>
