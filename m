Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73132ADE0D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 19:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgKJSS1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 13:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbgKJSS0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Nov 2020 13:18:26 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6363BC0613CF
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 10:18:26 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w13so18951556eju.13
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 10:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fD7KCcTAq1Hz+/dNG2WLQdV9gqWXnUtyE8ou/RF65Ho=;
        b=V/1Xl9kesiwfZF+5Y4oD/1b5KfJEAMUL4mi2wdV7JmWbux9ioTA5r/N6zIrdFxNa4U
         RgL/V8z39NPY654rXFqD8jYYJMtIX+072SgqSvghUyG5ryemMZmWR8tFTY3bJ1/ONdao
         6X6rQEOUftU4tyEBWhoNGNWHn4wAqEIAKk6j+383l4Vt6fiekX4sJFLx7dTRYwb7M9FP
         OhSJN7cQNBzoU9e7TGMjgZmIISL/O235Pu6rkljuOgqZFoNzZ7Jne0cYd6P1unf1BHea
         Jfdj8iM7IX822AdWj0NCpn//7SoKJUohoBgGYGoz5xC4sJ3f7VB2f0VUwzFygsj5pmO4
         R8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fD7KCcTAq1Hz+/dNG2WLQdV9gqWXnUtyE8ou/RF65Ho=;
        b=A92yGPhDjyIWtTacnR3WPPfCYEt6x8ksjGabYVQIgTQjNLp8JF54KktuOW8RBHubyo
         0STtMpRU+wIheDQDPD1Nk3frntnt9i102LU8sg0HKi261YPPnEICpFwm4XdradEEeCFX
         /DvTuNPPi4YXIvuRMlyj2Wo5lgjlTb5VKckU3DCbySTE1rqFEFnq+ZYtNza9v59sFXex
         hbLg6vob4ZM18TVq7qWbDCLLcu3MDXqqmXgufDT/LgIpoE42n/k74N13oiotenNhWDfm
         w/3m4ZBe/Vi0ohCWPgRkKt0xt0GeFZcAxB0dpS+3Ms78xOHX0YtIQCJW1L0f6DOFj/zH
         Pyew==
X-Gm-Message-State: AOAM530q4y5ux8nY+W80bFhGvCbesOvY4of50/JxXNuIkJxCZ1dE7Cuz
        1vapAn5tlezPe2yBKye3bwyo1tmNgnDZ5U+ltXQ=
X-Google-Smtp-Source: ABdhPJxnnLMHRx7KPiImxUkW2TzIp1WE1nwdgSY0nJwfUjNGz1cV4Y8Efl7rW8/VNwabxelnFNwfFHDCGRg4WHqnY3w=
X-Received: by 2002:a17:906:ccc5:: with SMTP id ot5mr22078395ejb.248.1605032303755;
 Tue, 10 Nov 2020 10:18:23 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyENFaKb=CUZCxkeAqhS7jsFswwaGkPyC0W9h_OJyVrEmw@mail.gmail.com>
 <98BAC3EC-35C5-449F-8476-4B740632DC7C@oracle.com> <CAN-5tyGKXJCWxzDnPfT0v70Ry7QNvSCKRnwyU360aW6nJvN-aA@mail.gmail.com>
 <CAN-5tyFsGBJ3aJC0XVfTOAR219d6jukYZPLvmUGgRFYkraB88A@mail.gmail.com>
 <576A90AD-278A-4738-B437-162C8B931FE0@oracle.com> <CAN-5tyF1mUQ3bgx_5i2SJH=BQ1MH0omHkQq6SmaZw7sS5U_1GA@mail.gmail.com>
 <C452338F-A32A-4F35-BB9C-08104DB91960@oracle.com>
In-Reply-To: <C452338F-A32A-4F35-BB9C-08104DB91960@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 10 Nov 2020 13:18:12 -0500
Message-ID: <CAN-5tyH0ujGDgowBZi6ykZ52ZFqW7GZJekhb6-oZEuq0XrpaUw@mail.gmail.com>
Subject: Re: kernel oops in generic/013 on an rdma mount (over either soft
 roce or iwarp)
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 10, 2020 at 12:44 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
> > On Nov 10, 2020, at 11:51 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Tue, Nov 10, 2020 at 9:42 AM Chuck Lever <chuck.lever@oracle.com> wrote:
> >>
> >>> Which those changes applied, I get the following oops:
> >>
> >> What's your workload? Do you have a reproducer?
> >
> > I ran generic/013 linux-to-linux.
>
> I'm not able to reproduce the problem.

Are you on hardware? This is over soft roce/iwarp. I will try hardware
but it'll take me time.

> xfstest: mount options: vers=4.2,proto=rdma,sec=sys,rsize=262144,wsize=131072
>
> FSTYP         -- nfs
> PLATFORM      -- Linux/x86_64 manet 5.10.0-rc1-00015-g6d4bab79ed4f #1297 SMP Sat Oct 31 12:56:30 EDT 2020
>
> generic/001 22s ...  22s
> generic/002 1s ...  2s
> generic/003     [not run] this test requires a valid $SCRATCH_DEV
> generic/004     [not run] O_TMPFILE is not supported
> generic/005 1s ...  2s
> generic/006 10s ...  9s
> generic/007 40s ...  39s
> generic/008     [not run] xfs_io fzero  failed (old kernel/wrong fs?)
> generic/009     [not run] xfs_io fzero  failed (old kernel/wrong fs?)
> generic/010     [not run] /home/cel/src/xfstests/src/dbtest not built
> generic/011 6s ...  6s
> generic/012     [not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> generic/013 9s ...  9s
> generic/014 10s ...  8s
> generic/015     [not run] this test requires a valid $SCRATCH_DEV
> generic/016     [not run] xfs_io fiemap  failed (old kernel/wrong fs?)
> generic/017     [not run] this test requires a valid $SCRATCH_DEV
> generic/018     [not run] this test requires a valid $SCRATCH_DEV
>
> I must be missing something that you have in your environment.
>
>
> --
> Chuck Lever
>
>
>
