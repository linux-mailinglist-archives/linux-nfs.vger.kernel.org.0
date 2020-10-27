Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA32B29C955
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Oct 2020 21:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1821556AbgJ0UAP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 16:00:15 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:35576 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1823131AbgJ0UAO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Oct 2020 16:00:14 -0400
Received: by mail-ed1-f46.google.com with SMTP id w25so2764804edx.2
        for <linux-nfs@vger.kernel.org>; Tue, 27 Oct 2020 13:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXMYnFYoYwPh+fHfCxd3T0sqEIYyZgBB4wvl2gn4hh4=;
        b=rRhRcCm1YnKAxkQe0g8agfiVuwcgmWgud+zCqEe5x3Irq9geo/KL9TqselKehOBgTU
         EL2Y5plYDHiMdVGEJdCWY1OzQDAPYwDiQqvb/C0h8nUa38C4YaY4qf+NHS78+UWTx2an
         zE3GLVsy+7wpUTHhH1aLtSYA/kzXy2Z66gNPIknsmp5UcTal4CYBfbpe9IVwelHxn7ee
         6yF6ljzkYgPGKQe9ABje1NoYDVxSUKljTCqnfLpPMkFGBQqcaz5OquFtiQ425cUiERZr
         PVdMbz1FUKq1xWc1tqYlGx91gE24/3aBYV0kN5Z3e3TztJUaqOKqN7CFchnyBUwiNgdQ
         vBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXMYnFYoYwPh+fHfCxd3T0sqEIYyZgBB4wvl2gn4hh4=;
        b=IEKWhIMz2q9iy1Lggk8P8ghQtRJbpxUmbDlK9BIsi3kUg46t2TOH0MXvjInykcL58g
         Cagp3P+lZnKc8+Clr3I0QKDMHY7BrQg2dPYlIoNUWyI/EN8tMPFloBW9RBupGyIh1YIq
         kbU9Ni7PB36IXFAlh6ewJjFy7ERuQM622Ft+I70Hu9kRva/x0dLKNSMxrsMKbmUpDarZ
         E4aO0FQbbN4gSmUZdGV8z+LeVcHtq7vb8rnEUpyaSJDM8OXKtglehf85oLCZo5uFQFzs
         6qsMo3EuuIxC2sst1wP6knG3u9txEhDiKIlGMq5l/56HyCRi4ytSlYDwbpHKSwuYdZ4r
         vE1g==
X-Gm-Message-State: AOAM531IGL/GaNdz9V1q0r6o+lfkFkyojzNVs3s97V8T1hZIYM705NUO
        h5eDkGhmwYKq0fwp/1ty1JYL0gjwFK/D507sKnUPWjVoBMo=
X-Google-Smtp-Source: ABdhPJyi/mZZfzBZFUX6cv2yd57cnf2Q2CEEcBay9r8ecGsaXxFNEspBaYGUbU4t99heXnuMp/UCU36VwsRESvsfIx4=
X-Received: by 2002:a50:9519:: with SMTP id u25mr4185146eda.102.1603828812658;
 Tue, 27 Oct 2020 13:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201027174945.GC1644@fieldses.org>
In-Reply-To: <20201027174945.GC1644@fieldses.org>
From:   Anna Schumaker <schumakeranna@gmail.com>
Date:   Tue, 27 Oct 2020 15:59:56 -0400
Message-ID: <CAFX2Jf=-Y905+cMtLike2ddpthCV=K6CM8iS4EPeAz1RYzF-pA@mail.gmail.com>
Subject: Re: xfstests generic/263
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 27, 2020 at 1:49 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Generic/263 is failing whenever client and server both supports
> READ_PLUS.
>
> I'm not even sure the failure is wrong.  The NFS FALLOC operation doesn't
> support those other other fallocate modes, are they implemented elsewhere in
> the kernel or libc somehow?  Anyway, odd that it would have anything to do with
> READ_PLUS.

I just ran xfstests, and I'm seeing this too. The test passes using
basic READ on v4.2, so there might be something farther down the log
that diff is cutting off. I'll see if anything sticks out to me this
week.

Anna

>
> --b.
>
> generic/263 109s ... [failed, exit status 1]- output mismatch (see /root/xfstests-dev/results//generic/263.out.bad)
>     --- tests/generic/263.out   2019-12-20 17:34:10.493343575 -0500
>     +++ /root/xfstests-dev/results//generic/263.out.bad 2020-10-27 13:43:41.968835322 -0400
>     @@ -1,3 +1,2018 @@
>      QA output created by 263
>      fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
>     -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
>     +Seed set to 1
>     +main: filesystem does not support fallocate mode FALLOC_FL_KEEP_SIZE, disabling!
>     +main: filesystem does not support fallocate mode FALLOC_FL_ZERO_RANGE, disabling!
>     +main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RANGE, disabling!
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/263.out /root/xfstests-dev/results//generic/263.out.bad'  to see the entire diff)
> Ran: generic/263
> Failures: generic/263
> Failed 1 of 1 tests
