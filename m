Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6517227489C
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 20:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIVSwJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 14:52:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37313 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVSwJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 14:52:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id n22so17233426edt.4
        for <linux-nfs@vger.kernel.org>; Tue, 22 Sep 2020 11:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzbHwqikeIWXc1En92RguGYvJkSfHMbGChoZYuuNr3s=;
        b=DdXDIZbrn+NbNCWRXEDGP7QY1j8r1Y231nTpbXoov9LWSPAnCWgH3EnPm9ZjxZhNsv
         pW5tQNXTUwznwj1I18kHLGdzWmxW1WLjfEhhNsP4HNzkHwX7S1yYHFgmfe0RKQHuJsg1
         9XwAwFlcV0hQqbkhrvvtdTOYq1OA/RlgS/6CBdQS/VO+rDzoI0cJem43SHt/XOy5XGQ+
         +/IkCKeMJrywVUxjjeVQKrZ4LFsIcmk+nQ4DNvtPBmkpw1zsNWlA9aX8gjzEWvGSrjPz
         u0TNUWKQ2jYqICZZj9oCkhcHPfu5W+RQ5jVr3vxtM9aOBqVQcbXcVJfOwFM5boIgz1CX
         hbTg==
X-Gm-Message-State: AOAM5316B3KxYRDC93uTYqkccgPQ4ws9xu3/FoNC+ze9MPXZ6H7Z8n8K
        ejWTKEtKyDIxuNJkvLR0XmvdEe9cL6VOL9h1cPE=
X-Google-Smtp-Source: ABdhPJxsEIzuaeBDu+x140sNeNPRuqVjgp8jeQ12WIMhkuaheomNHu5Ha3Si9yzxpsXcHDFZab6uFwBpHRRL1hv6Esg=
X-Received: by 2002:a50:fc83:: with SMTP id f3mr5662030edq.102.1600800726967;
 Tue, 22 Sep 2020 11:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <5a7f6bbf4cf2038634a572f42ad80e95a8d0ae9c.1600686204.git.bcodding@redhat.com>
 <CAFX2JfmeOm+-cpq6aTGnBNZLmAOwp8dykTWe7L6OU3mmnSw6rw@mail.gmail.com>
 <8DB79D4D-6986-4114-B031-43157089C2B5@redhat.com> <CAFX2JfmH-oP94jdwcnjkqoOQOCaEg5PvC0G5Q1P5q3C5J9A0Ug@mail.gmail.com>
 <CAFX2JfkQSonD=Hnn40Y8A62rfmoQ2d8_ugNvOmg+Ny8zJ6dLAg@mail.gmail.com>
 <EEE7BF42-07C5-4593-93AB-068F8DDCCD9A@redhat.com> <CAFX2JfnDKhkM4b68haOtwSS+7W7CRABDqeCauvSXZf_zoEf8fw@mail.gmail.com>
 <CAFX2JfmPNMbM3FShzP-WbVf+=8iTNs__wRGk-M5waLoQpP1WUQ@mail.gmail.com> <068EFB54-D0B0-42C2-9408-603F10918FD7@redhat.com>
In-Reply-To: <068EFB54-D0B0-42C2-9408-603F10918FD7@redhat.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 22 Sep 2020 14:51:50 -0400
Message-ID: <CAFX2Jfnqyyvnzfj05QvxQKope=PydKfOnNFCXyJv2FgTxeOt=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] NFSv4: Fix a livelock when CLOSE pre-emptively bumps
 state sequence
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 22, 2020 at 2:47 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 22 Sep 2020, at 12:11, Anna Schumaker wrote:
>
> > On Tue, Sep 22, 2020 at 11:53 AM Anna Schumaker
> > <anna.schumaker@netapp.com> wrote:
> >>
> >> On Tue, Sep 22, 2020 at 11:49 AM Benjamin Coddington
> >> <bcodding@redhat.com> wrote:
> >>>
> >>> On 22 Sep 2020, at 10:43, Anna Schumaker wrote:
> >>>
> >>>> On Tue, Sep 22, 2020 at 10:31 AM Anna Schumaker
> >>>> <anna.schumaker@netapp.com> wrote:
> >>>>>
> >>>>> On Tue, Sep 22, 2020 at 10:22 AM Benjamin Coddington
> >>>>> <bcodding@redhat.com> wrote:
> >>>>>>
> >>>>>> On 22 Sep 2020, at 10:03, Anna Schumaker wrote:
> >>>>>>> Hi Ben,
> >>>>>>>
> >>>>>>> Once I apply this patch I have trouble with generic/478 doing lock
> >>>>>>> reclaim:
> >>>>>>>
> >>>>>>> [  937.460505] run fstests generic/478 at 2020-09-22 09:59:14
> >>>>>>> [  937.607990] NFS: __nfs4_reclaim_open_state: Lock reclaim failed!
> >>>>>>>
> >>>>>>> And the test just hangs until I kill it.
> >>>>>>>
> >>>>>>> Just thought you should know!
> >>>>>>
> >>>>>> Yes, thanks!  I'm not seeing that..  I've tested these based on
> >>>>>> v5.8.4, I'll
> >>>>>> rebase and check again.  I see a wirecap of generic/478 is only 515K
> >>>>>> on my
> >>>>>> system, would you be willing to share a capture of your test
> >>>>>> failing?
> >>>>>
> >>>>> I have it based on v5.9-rc6 (plus the patches I have queued up for
> >>>>> v5.10), so there definitely could be a difference there! I'm using a
> >>>>> stock kernel on my server, though :)
> >>>>>
> >>>>> I can definitely get you a packet trace once I re-apply the patch and
> >>>>> rerun the test.
> >>>>
> >>>> Here's the packet trace, I reran the test with just this patch applied
> >>>> on top of v5.9-rc6 so it's not interacting with something else in my
> >>>> tree. Looks like it's ending up in an NFS4ERR_OLD_STATEID loop.
> >>>
> >>> Thanks very much!
> >>>
> >>> Did you see this failure with all three patches applied, or just with
> >>> the
> >>> first patch?
> >>
> >> I saw it with the first patch applied, and with the first and third
> >> applied. I initially hit it as I was wrapping up for the day
> >> yesterday, but I left out #2 since I saw your retraction
> >
> > I reran with all three patches applied, and didn't have the issue. So
> > something in the refactor patch fixes it.
>
> That helped me see the case we're not handling correctly is when two OPENs
> race and the second one tries to update the state first and gets dropped.
> That is fixed by the 2/3 refactor patch since the refactor was being a bit
> more explicit.
>
> That means I'll need to fix those two patches and send them again.  I'm very
> glad you caught this!  Thanks very much for helping me find the problem.

You're welcome! I'm looking forward to the next version :)

Anna

>
> Ben
>
