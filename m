Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7803627463F
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 18:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgIVQME (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 12:12:04 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:32799 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgIVQME (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 12:12:04 -0400
Received: by mail-ej1-f65.google.com with SMTP id j11so23771395ejk.0
        for <linux-nfs@vger.kernel.org>; Tue, 22 Sep 2020 09:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OO37rQuRCBICesrmsnMsTDld4Ii44qBLySFyC37hth0=;
        b=tzTEITHxYwy68wbybbQIZHVg41olSDcS/1snEgtc7o4Jcft2J9IoHarsuPgzRe+MY/
         pjvVDbWX2IZoyx+xmZZ5TLdmUqnzWgeaK0rCUxL7ak1GWZgzvZRzk6VBr5Gm3E/U68lc
         rlagtOj/sDSINHPq2zA91XTlY/2BoYrCdmtKNnIS4nk5WLLSy6tArznwzSStkk6BdP4V
         XW3i33hz++fStwNNrW3lya0mS6k+am/kOF5vwl+fgMfk9C5PrTkGqX/HiHK/Hp/7hS7a
         S3esLiV6MBQcOZ3G3s/jOxVp7fH25Ro2Ch9dSOeSzRo17tCBov84czkvRKFucDcBdTVB
         uXEQ==
X-Gm-Message-State: AOAM532wK/S3PMXq/hkogQK5flqO0l0Q/hEscOm6OfI1SMFsp0dloxsi
        1w34FD36DkTQMT6ZwzaradeKPIvMDsnIYwVhKz9BUpQ7
X-Google-Smtp-Source: ABdhPJzbYk7b49UGIckmPMNesMTFYEB7WduVRwcguc3JYxDv6kvW6VPyW3SRe4l55t3/uLrCaogY1MiQkmLjQNRjgsM=
X-Received: by 2002:a17:906:3ca2:: with SMTP id b2mr5887775ejh.460.1600791122504;
 Tue, 22 Sep 2020 09:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <5a7f6bbf4cf2038634a572f42ad80e95a8d0ae9c.1600686204.git.bcodding@redhat.com>
 <CAFX2JfmeOm+-cpq6aTGnBNZLmAOwp8dykTWe7L6OU3mmnSw6rw@mail.gmail.com>
 <8DB79D4D-6986-4114-B031-43157089C2B5@redhat.com> <CAFX2JfmH-oP94jdwcnjkqoOQOCaEg5PvC0G5Q1P5q3C5J9A0Ug@mail.gmail.com>
 <CAFX2JfkQSonD=Hnn40Y8A62rfmoQ2d8_ugNvOmg+Ny8zJ6dLAg@mail.gmail.com>
 <EEE7BF42-07C5-4593-93AB-068F8DDCCD9A@redhat.com> <CAFX2JfnDKhkM4b68haOtwSS+7W7CRABDqeCauvSXZf_zoEf8fw@mail.gmail.com>
In-Reply-To: <CAFX2JfnDKhkM4b68haOtwSS+7W7CRABDqeCauvSXZf_zoEf8fw@mail.gmail.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 22 Sep 2020 12:11:46 -0400
Message-ID: <CAFX2JfmPNMbM3FShzP-WbVf+=8iTNs__wRGk-M5waLoQpP1WUQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] NFSv4: Fix a livelock when CLOSE pre-emptively bumps
 state sequence
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 22, 2020 at 11:53 AM Anna Schumaker
<anna.schumaker@netapp.com> wrote:
>
> On Tue, Sep 22, 2020 at 11:49 AM Benjamin Coddington
> <bcodding@redhat.com> wrote:
> >
> > On 22 Sep 2020, at 10:43, Anna Schumaker wrote:
> >
> > > On Tue, Sep 22, 2020 at 10:31 AM Anna Schumaker
> > > <anna.schumaker@netapp.com> wrote:
> > >>
> > >> On Tue, Sep 22, 2020 at 10:22 AM Benjamin Coddington
> > >> <bcodding@redhat.com> wrote:
> > >>>
> > >>> On 22 Sep 2020, at 10:03, Anna Schumaker wrote:
> > >>>> Hi Ben,
> > >>>>
> > >>>> Once I apply this patch I have trouble with generic/478 doing lock
> > >>>> reclaim:
> > >>>>
> > >>>> [  937.460505] run fstests generic/478 at 2020-09-22 09:59:14
> > >>>> [  937.607990] NFS: __nfs4_reclaim_open_state: Lock reclaim failed!
> > >>>>
> > >>>> And the test just hangs until I kill it.
> > >>>>
> > >>>> Just thought you should know!
> > >>>
> > >>> Yes, thanks!  I'm not seeing that..  I've tested these based on
> > >>> v5.8.4, I'll
> > >>> rebase and check again.  I see a wirecap of generic/478 is only 515K
> > >>> on my
> > >>> system, would you be willing to share a capture of your test
> > >>> failing?
> > >>
> > >> I have it based on v5.9-rc6 (plus the patches I have queued up for
> > >> v5.10), so there definitely could be a difference there! I'm using a
> > >> stock kernel on my server, though :)
> > >>
> > >> I can definitely get you a packet trace once I re-apply the patch and
> > >> rerun the test.
> > >
> > > Here's the packet trace, I reran the test with just this patch applied
> > > on top of v5.9-rc6 so it's not interacting with something else in my
> > > tree. Looks like it's ending up in an NFS4ERR_OLD_STATEID loop.
> >
> > Thanks very much!
> >
> > Did you see this failure with all three patches applied, or just with
> > the
> > first patch?
>
> I saw it with the first patch applied, and with the first and third
> applied. I initially hit it as I was wrapping up for the day
> yesterday, but I left out #2 since I saw your retraction

I reran with all three patches applied, and didn't have the issue. So
something in the refactor patch fixes it.

Anna

>
> >
> > I see the client get two OPEN responses, but then is sending
> > TEST_STATEID
> > with the first seqid.  Seems like seqid 2 is getting lost.  I wonder if
> > we're making a bad assumption that NFS_OPEN_STATE can only be toggled
> > under
> > the so_lock.
> >
> > Ben
> >
