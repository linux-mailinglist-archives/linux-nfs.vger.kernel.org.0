Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2048627444C
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 16:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIVObp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 10:31:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43405 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgIVObo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 10:31:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id n13so16320998edo.10
        for <linux-nfs@vger.kernel.org>; Tue, 22 Sep 2020 07:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7t2nsztso/UJZPLp6dXqSo73jJSnHpndEDnLnK47kk=;
        b=CsT+HA7NSMKC89THkPbVLmQl7fp3rQ3DaNw57+2ZJLqETjyJcMb1Fkdri2UZN2imo+
         P+r7F9tDH4YCWZWZF2nIEBLL692WKB9zUS6f0Fgytam6HT5J33Ms7B/X39VqoHaZlK2f
         I+pnLP4ZF+0QWPTovtaR/nG3SxnVflYH+NANRVdTVlnHMgQfRh8SPjB+c3xYMQF7mhfl
         nnQKUunXSIc14cEHYKKWSXLdHIAKSWdUwL7G4leL9aysFiFpQ8nU3mfBhSKQUDhd1+yb
         JMgMu5UlCQsIFMyFFTgQWIfco8IrfMGCg9+yzddkqOBji+/5wkrWUT8Da+D+Ua7PkFLE
         QVFQ==
X-Gm-Message-State: AOAM531Q5QMRA+X4wFcbHj7aN8QR6UHIeaHU0emy431m8XqcgbBmv63O
        6xsdm4Oe+ahqVehEwa317dumdVmmGwzaZLH8ct4SQsAY
X-Google-Smtp-Source: ABdhPJwWWNCDHnZ8KGj6Do7UDSuyNS2yGpbuyhatwckFVK9QFDmz/V+fLBFpD7xAfyFAgekjOpHGb7cY63oSYuquKWs=
X-Received: by 2002:a50:ef0c:: with SMTP id m12mr4147312eds.264.1600785102967;
 Tue, 22 Sep 2020 07:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <5a7f6bbf4cf2038634a572f42ad80e95a8d0ae9c.1600686204.git.bcodding@redhat.com>
 <CAFX2JfmeOm+-cpq6aTGnBNZLmAOwp8dykTWe7L6OU3mmnSw6rw@mail.gmail.com> <8DB79D4D-6986-4114-B031-43157089C2B5@redhat.com>
In-Reply-To: <8DB79D4D-6986-4114-B031-43157089C2B5@redhat.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 22 Sep 2020 10:31:26 -0400
Message-ID: <CAFX2JfmH-oP94jdwcnjkqoOQOCaEg5PvC0G5Q1P5q3C5J9A0Ug@mail.gmail.com>
Subject: Re: [PATCH 1/3] NFSv4: Fix a livelock when CLOSE pre-emptively bumps
 state sequence
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 22, 2020 at 10:22 AM Benjamin Coddington
<bcodding@redhat.com> wrote:
>
> On 22 Sep 2020, at 10:03, Anna Schumaker wrote:
> > Hi Ben,
> >
> > Once I apply this patch I have trouble with generic/478 doing lock reclaim:
> >
> > [  937.460505] run fstests generic/478 at 2020-09-22 09:59:14
> > [  937.607990] NFS: __nfs4_reclaim_open_state: Lock reclaim failed!
> >
> > And the test just hangs until I kill it.
> >
> > Just thought you should know!
>
> Yes, thanks!  I'm not seeing that..  I've tested these based on v5.8.4, I'll
> rebase and check again.  I see a wirecap of generic/478 is only 515K on my
> system, would you be willing to share a capture of your test failing?

I have it based on v5.9-rc6 (plus the patches I have queued up for
v5.10), so there definitely could be a difference there! I'm using a
stock kernel on my server, though :)

I can definitely get you a packet trace once I re-apply the patch and
rerun the test.

Anna

>
> Ben
>
