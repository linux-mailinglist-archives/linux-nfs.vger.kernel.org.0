Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1043549B78B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 16:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345552AbiAYP1D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 10:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349626AbiAYPYq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 10:24:46 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EA5C06173D
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 07:24:42 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ah7so30930485ejc.4
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 07:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FmCu5q/9cyd6jLwDAKHOnptOvmHmNnDiPHpjTLMqXXc=;
        b=FYMmG0bW7AcVJozcIb4UL5jaq8gx/U3N8bfYx6LTr8RR0tl5lC7CI/OgS+3IA4EHwS
         V/5uM0CkfAtvMvBW0hbzxYMfl0HnSZQ3/o7F65e/NJzgkO6ffIWPdtCuKAtBDp4vR9RP
         GaE93WvFVGl3kyFEf0jbkwOKBp6YyQOMA7ta5GO3Q/UNQt7gLYhQY+sITf0fNXiD7VTS
         JFJCHKkp9mvtq7lfMvLRBiLgAR+qnRo5tQEFNtl1RC/wgVtzdu50rdBVstykoaXzpLfo
         88VTt+lfnBAGE5/a4bBhINihqjbz+X1jUrA78EmCPlYttwEe/6yUCxs85gbYf2BOHtq9
         qm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmCu5q/9cyd6jLwDAKHOnptOvmHmNnDiPHpjTLMqXXc=;
        b=kZ8pM0SGamRmXToqfv/2Q5cMDLP01OMMuATilmzGCXKAKELBs5KrVPPUpCrVpWm3cA
         3dMk+KKkZdg6T516KgYvELPpvG/BycOIs8z+X2X2/EKF6JMjymeSrQKDTDyfSJ67paMv
         xbNv4yY+RIusvyUY5rAckt/JT6hUtJhRm54mQSH7ftIK8l1j0wtp2G/ki0jJvwTHjIzt
         HlI2+/JkFUSZPa1phkwhJsKuQP02S4A6XUaY8dinYcwnH038b4cUWXpsutX1ktsp6bv0
         yTvfCx/ZEkJkC8oEOyOKTEDrEhnFSH7XuMYigEFCQDy808YBI3klEHCjE/ddm56Mwbp7
         gOFA==
X-Gm-Message-State: AOAM533K2hzbft3sQzGhwGp/Xcn5olbfXFV5Wq1mYerb4rKziYQmRGYU
        EpjvPF7mnUA/U+7vc2o8KJFZAHjo8Uwgv3OafBSTm8C3vEJ1Kg==
X-Google-Smtp-Source: ABdhPJwnjBgXzawV5S0lMccZQeXYSktLqE1xynuyEvx5K8yUSwynd6AtcjQ1OhW1Ym4F9sKhhgxMCPc54V4eFUs3KSU=
X-Received: by 2002:a17:906:2ec8:: with SMTP id s8mr16699667eji.746.1643124281229;
 Tue, 25 Jan 2022 07:24:41 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
 <20220124193759.GA4975@fieldses.org> <CAPt2mGOCn5OaeZm24+zh92qRcWTF8h-H2WXqScz9RMfo4r_-Qw@mail.gmail.com>
 <20220124205045.GB4975@fieldses.org> <CAPt2mGPTGgXztawDJfAKsiYqnm6P_mn1rtquSDKjpnSgvJH1YA@mail.gmail.com>
 <20220125135959.GA15537@fieldses.org>
In-Reply-To: <20220125135959.GA15537@fieldses.org>
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 25 Jan 2022 15:24:05 +0000
Message-ID: <CAPt2mGMKqPDaH3U=frrONX0V0aae0A=KDQhUd2GYO78u8FNyJQ@mail.gmail.com>
Subject: Re: parallel file create rates (+high latency)
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Jan 2022 at 14:00, J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Jan 25, 2022 at 12:52:46PM +0000, Daire Byrne wrote:
> > Yea, it does seem like the server is the ultimate arbitrar and the
> > fact that multiple clients can achieve much higher rates of
> > parallelism does suggest that the VFS locking per client is somewhat
> > redundant and limiting (in this super niche case).
>
> It doesn't seem *so* weird to have a server with fast storage a long
> round-trip time away, in which case the client-side operation could take
> several orders of magnitude longer than the server.

Yea, I'm fine with the speed of light constraints for a single process
far away. But the best way to achieve aggregate performance in such
environments is to have multiple parallel streams in flight at once
(preferably bulk transfers).

Because I am writing through a single re-export server, I just so
happen to be killing any parallelism for single directory files
creates even though it works reasonably well for opens, reads, writes
and stat (and anything cacheable) which all retain a certain amount of
useful parallelism over a high latency network (nconnect helps too).
Each of our batch jobs all read 95% of the same files each time and
they all tend to run within the same short (hour) time periods so
highly cacheable.

> Though even if the client locking wasn't a factor, you might still have
> to do some work to take advantage of that.  (E.g. if your workload is
> just a single "untar"--it still waits for one create before doing the
> next one).

Yep. Again I'm okay with each client of a re-export server doing 3
creates per second, my problem is that all N instances together do 3
creates per second aggregate (in a single directory).

But I guess for this kind of workload, win some lose some. I just need
to figure out if I can engineer it to be less of a loser...

Of course, Hammerspace have a different approach to this kind of
problem with their global namespace and replicated MDT servers. And
that is probably a much more sensible way of going about this kind of
thing.

Daire
