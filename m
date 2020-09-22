Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2218C2745CF
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIVPyF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 11:54:05 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:35223 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgIVPyE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 11:54:04 -0400
Received: by mail-ej1-f66.google.com with SMTP id u21so23661995eja.2
        for <linux-nfs@vger.kernel.org>; Tue, 22 Sep 2020 08:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pIoceIKQPNtSSW0ClpWL4s0yxOcwiu4CqYlHp9kO+wI=;
        b=aEa1jULjDZ12q/K0gSsNYClsrMgLQnT+bY2nKzgF+i1afhOWNGeK0aUhPawdedcNkr
         hYX3q+yU9jxpzHCqjJcwEhdXCsZD6lrucskV+0XEE0g+/LtZXH1ADNCxQXySZVJFKqBi
         zYYdyOtahs0CZ7hjuGgCQ1gMcQPj5fezsvyG1BLJHrcomKyu5ezH5cjSBfoPeLbNANi5
         EOtHp923xKZUehlm3HKlQuVh98rpOanEUEcth7xnMfslzCvSyQaESR0cjGEsydlYc0w6
         Bh3pE2on9yicZR62hTS3u2mW03z9Vv9oUGGH59aD3QN1x4UgcIYXP/NdxaqIvc/HBhxe
         BqIg==
X-Gm-Message-State: AOAM530du5oiSthNrofuqdUrSf8K85n/0+Ne0gcYOEgEeqr7bzrqSxoP
        VKoa7dBNBEsv7WMACkJ1hebLxYc5eH3KLzcvr6M=
X-Google-Smtp-Source: ABdhPJxgW5a+GRtCWMt4UkVdRCuwV15bSFH1S1Y+MIl52yktBY4UVvpwVU5mtihufhRMF+6dpE0NfBXx2B2XwNceeE8=
X-Received: by 2002:a17:906:3552:: with SMTP id s18mr5643260eja.23.1600790042721;
 Tue, 22 Sep 2020 08:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <5a7f6bbf4cf2038634a572f42ad80e95a8d0ae9c.1600686204.git.bcodding@redhat.com>
 <CAFX2JfmeOm+-cpq6aTGnBNZLmAOwp8dykTWe7L6OU3mmnSw6rw@mail.gmail.com>
 <8DB79D4D-6986-4114-B031-43157089C2B5@redhat.com> <CAFX2JfmH-oP94jdwcnjkqoOQOCaEg5PvC0G5Q1P5q3C5J9A0Ug@mail.gmail.com>
 <CAFX2JfkQSonD=Hnn40Y8A62rfmoQ2d8_ugNvOmg+Ny8zJ6dLAg@mail.gmail.com> <EEE7BF42-07C5-4593-93AB-068F8DDCCD9A@redhat.com>
In-Reply-To: <EEE7BF42-07C5-4593-93AB-068F8DDCCD9A@redhat.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 22 Sep 2020 11:53:46 -0400
Message-ID: <CAFX2JfnDKhkM4b68haOtwSS+7W7CRABDqeCauvSXZf_zoEf8fw@mail.gmail.com>
Subject: Re: [PATCH 1/3] NFSv4: Fix a livelock when CLOSE pre-emptively bumps
 state sequence
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 22, 2020 at 11:49 AM Benjamin Coddington
<bcodding@redhat.com> wrote:
>
> On 22 Sep 2020, at 10:43, Anna Schumaker wrote:
>
> > On Tue, Sep 22, 2020 at 10:31 AM Anna Schumaker
> > <anna.schumaker@netapp.com> wrote:
> >>
> >> On Tue, Sep 22, 2020 at 10:22 AM Benjamin Coddington
> >> <bcodding@redhat.com> wrote:
> >>>
> >>> On 22 Sep 2020, at 10:03, Anna Schumaker wrote:
> >>>> Hi Ben,
> >>>>
> >>>> Once I apply this patch I have trouble with generic/478 doing lock
> >>>> reclaim:
> >>>>
> >>>> [  937.460505] run fstests generic/478 at 2020-09-22 09:59:14
> >>>> [  937.607990] NFS: __nfs4_reclaim_open_state: Lock reclaim failed!
> >>>>
> >>>> And the test just hangs until I kill it.
> >>>>
> >>>> Just thought you should know!
> >>>
> >>> Yes, thanks!  I'm not seeing that..  I've tested these based on
> >>> v5.8.4, I'll
> >>> rebase and check again.  I see a wirecap of generic/478 is only 515K
> >>> on my
> >>> system, would you be willing to share a capture of your test
> >>> failing?
> >>
> >> I have it based on v5.9-rc6 (plus the patches I have queued up for
> >> v5.10), so there definitely could be a difference there! I'm using a
> >> stock kernel on my server, though :)
> >>
> >> I can definitely get you a packet trace once I re-apply the patch and
> >> rerun the test.
> >
> > Here's the packet trace, I reran the test with just this patch applied
> > on top of v5.9-rc6 so it's not interacting with something else in my
> > tree. Looks like it's ending up in an NFS4ERR_OLD_STATEID loop.
>
> Thanks very much!
>
> Did you see this failure with all three patches applied, or just with
> the
> first patch?

I saw it with the first patch applied, and with the first and third
applied. I initially hit it as I was wrapping up for the day
yesterday, but I left out #2 since I saw your retraction

>
> I see the client get two OPEN responses, but then is sending
> TEST_STATEID
> with the first seqid.  Seems like seqid 2 is getting lost.  I wonder if
> we're making a bad assumption that NFS_OPEN_STATE can only be toggled
> under
> the so_lock.
>
> Ben
>
