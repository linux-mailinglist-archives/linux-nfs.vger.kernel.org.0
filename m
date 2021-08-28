Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031883FA357
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Aug 2021 05:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhH1DXl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 23:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhH1DXl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 23:23:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C4BC0613D9
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 20:22:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k24so7634121pgh.8
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 20:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0OXvn5V6GaSHXYZzdaWLuFOEEOZx1kZ19Du/mw2jjc=;
        b=L9q3UU5Q/j7ym+cnFSBu58BAuQZwy6lOsBm8qNDVGWKsJZki1rUeZEaX9dBK1p4OIO
         ZLFxOJghvSsQllWT7hqhTF/cnViTXYecSEXm2g4O/amfRnNvwhPgtL3Pjup0nTP2HsK1
         oH+FURY+NGMWEXoZxjaZJc2iUQL8Zdh7FcGvD4nKB6GuoTVtgHv4XKYJgjVq61FFOQrN
         8d9sPjlgV19inYCTEE1sA9CW8sWlYN38gRTAK3zWA6MXqBgmQqOJm1QPH57i4HMPphEW
         MiDDJJYHOIbngM3hWGSUt3B/ph91Eh7JShSUA7r/6OFzXBTTM9giglbsAZ7P9r4kDB3e
         zxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0OXvn5V6GaSHXYZzdaWLuFOEEOZx1kZ19Du/mw2jjc=;
        b=oCuuXIgDpN1LpM9B8JmcLZ0M05QzRXZ4pxSFL7EM50uTFsLK0yBPJHjCQ2F7tf3HHA
         ecE8xdNhyWwHuFCRForPWoM6R5b8FNIdmg6ojFEb9RKok6n/fFiRlfQFXXxdcHNmK7SD
         Tw//jOGZgLUEy7fhCIfuvUQjsLcdv2I9ksJkLq/9xceKfAJllUMFi/IaB9TsvyYCmYVA
         r02YEVv6SqDXGaDQ3eJTN0HAKCZfG/vsU3ssyGa3sn4J1IsQY6tY/pWnybF1hRDE2BM1
         dtrkDqzLBdduvjWW09aiSeVUpC52EqmjQtystxDxn8kbu59ds8vhxYNk43fEKRUz4Xs4
         mhxg==
X-Gm-Message-State: AOAM530/vwniB495TQvSfSOI0A8jYLSAEvYDHNVImnFuzoX/nPJByheP
        HVKaZ8hBD28u2LwHcJtcAOHU1xjmI4G8O2kC0Ys=
X-Google-Smtp-Source: ABdhPJy0mu+fj0dggYyDcUJGu7Urv3G+fx4GeJJbik/Kox/3WB7i674Tg5BzSBTecrIPCp38HGxVMVQAR2ZixA0QEI0=
X-Received: by 2002:a65:4486:: with SMTP id l6mr10497667pgq.145.1630120971075;
 Fri, 27 Aug 2021 20:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>
 <162907681945.1695.10796003189432247877@noble.neil.brown.name>
 <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com> <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>
 <162915491276.9892.7049267765583701172@noble.neil.brown.name>
 <162941948235.9892.6790956894845282568@noble.neil.brown.name>
 <CAOv1SKAyr0Cixc8eQf8-Fdnf=9Db_xZGsweq9K2E5AkALFqavQ@mail.gmail.com>
 <CAOv1SKDDUFpgexZ_xYCe6c2-UCBK0+vicoG+LAtG2Zhispd_jg@mail.gmail.com>
 <162960371884.9892.13803244995043191094@noble.neil.brown.name>
 <CAOv1SKBePD6N-R0uETgcSPA-LZZ4895ZJDKTY7mYvhfu184OQQ@mail.gmail.com>
 <162966962721.9892.5962616727949224286@noble.neil.brown.name>
 <CAOv1SKB6xqyduf5L5hcXOe-xMN-UJOfFeE5eXVga3TviKuH0PA@mail.gmail.com>
 <163001427749.7591.7281634750945934559@noble.neil.brown.name>
 <CAOv1SKC+3LXhM+L9MwU2D03bpeof55-g+i=r3SWEjVWcPVCi8Q@mail.gmail.com>
 <163004202961.7591.12633163545286005205@noble.neil.brown.name>
 <CAOv1SKDTcg5WDp5zf3ZGL0enJ7K693W-9TMYKcrgweyzp6Qjhg@mail.gmail.com>
 <163004848514.7591.2757618782251492498@noble.neil.brown.name>
 <6CC9C852-CEE3-4657-86AD-9D5759E2BE1C@oracle.com> <CAOv1SKAiPB62sQcnDCKC5vYbbmakfbe80KRu3JEVZVO7Trk8cw@mail.gmail.com>
 <CAOv1SKATk1iP=J9r2x0CQzNuwq2VoRvN8Mkba3DsKq6W_tfrDQ@mail.gmail.com> <416268C9-BEAC-483C-9392-8139340BC849@oracle.com>
In-Reply-To: <416268C9-BEAC-483C-9392-8139340BC849@oracle.com>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Fri, 27 Aug 2021 20:22:40 -0700
Message-ID: <CAOv1SKCjvgSfUoFtufZ5-dB-quG=djnn-UHO286S410aVxrV0Q@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Mel Gorman <mgorman@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I had some time this evening (and the kernel finally compiled), and
wanted to get this tested.

The TL;DR:  Both patches are needed

Below are the test results from my replication of Neil's test. It is
readily apparent that both the 5.13.13 kernel AND the 5.13.13 kernel
with the 82011c80b3ec fix exhibit the randomness in read times that
were observed. The 5.13.13 kernel with both the 82011c80b3ec and
f6e70aab9dfe fixes brings the performance back in line with the
5.12.15 kernel which I tested as a baseline.

Please forgive the inconsistency in sample counts. This was running as
a while loop, and I just let it go long enough that the behavior was
consistent. Only change to the VM between tests was the different
kernel + a reboot. The testing PC had a consistent workload during the
entire set of tests.

Test 0: 5.13.10 (base kernel in VM image, just for kicks)
==================================================
 Samples 30
 Min 6.839
 Max 19.998
 Median 9.638
 75-P 10.898
 95-P 12.939
 99-P 18.005

Test 1: 5.12.15 (known good)
==================================================
 Samples 152
 Min 1.997
 Max 2.333
 Median 2.171
 75-P 2.230
 95-P 2.286
 99-P 2.312

Test 2: 5.13.13 (known bad)
==================================================
 Samples 42
 Min 3.587
 Max 15.803
 Median 6.039
 75-P 6.452
 95-P 10.293
 99-P 15.540

Test 3: 5.13.13 + 82011c80b3ec fix
==================================================
 Samples 44
 Min 4.309
 Max 37.040
 Median 6.615
 75-P 10.224
 95-P 19.516
 99-P 36.650

Test 4: 5.13.13 + 82011c80b3ec fix + f6e70aab9dfe fix
==================================================
 Samples 131
 Min 2.013
 Max 2.397
 Median 2.169
 75-P 2.211
 95-P 2.283
 99-P 2.348

I am going to run the kernel w/ both fixes over the weekend, but
things look good at this point.

- mike

On Fri, Aug 27, 2021 at 4:49 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
> > On Aug 27, 2021, at 6:00 PM, Mike Javorski <mike.javorski@gmail.com> wrote:
> >
> > OK, an update. Several hours of spaced out testing sessions and the
> > first patch seems to have resolved the issue. There may be a very tiny
> > bit of lag that still occurs when opening/processing new files, but so
> > far on this kernel I have not had any multi-second freezes. I am still
> > waiting on the kernel with Neil's patch to compile (compiling on this
> > underpowered server so it's taking several hours), but I think the
> > testing there will just be to see if I can show it works still, and
> > then to try and test in a memory constrained VM. To see if I can
> > recreate Neil's experiment. Likely will have to do this over the
> > weekend given the kernel compile delay + fiddling with a VM.
>
> Thanks for your testing!
>
>
> > Chuck: I don't mean to overstep bounds, but is it possible to get that
> > patch pulled into 5.13 stable? That may help things for several people
> > while 5.14 goes through it's shakedown in archlinux prior to release.
>
> The patch had a Fixes: tag, so it should get automatically backported
> to every kernel that has the broken commit. If you don't see it in
> a subsequent 5.13 stable kernel, you are free to ask the stable
> maintainers to consider it.
>
>
> > - mike
> >
> > On Fri, Aug 27, 2021 at 10:07 AM Mike Javorski <mike.javorski@gmail.com> wrote:
> >>
> >> Chuck:
> >> I just booted a 5.13.13 kernel with your suggested patch. No freezes
> >> on the first test, but that sometimes happens so I will let the server
> >> settle some and try it again later in the day (which also would align
> >> with Neil's comment on memory fragmentation being a contributor).
> >>
> >> Neil:
> >> I have started a compile with the above kernel + your patch to test
> >> next unless you or Chuck determine that it isn't needed, or that I
> >> should test both patches discreetly. As the above is already merged to
> >> 5.14 it seemed logical to just add your patch on top.
> >>
> >> I will also try to set up a vm to test your md5sum scenario with the
> >> various kernels since it's a much faster thing to test.
> >>
> >> - mike
> >>
> >> On Fri, Aug 27, 2021 at 7:13 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>>
> >>>
> >>>> On Aug 27, 2021, at 3:14 AM, NeilBrown <neilb@suse.de> wrote:
> >>>>
> >>>> Subject: [PATCH] SUNRPC: don't pause on incomplete allocation
> >>>>
> >>>> alloc_pages_bulk_array() attempts to allocate at least one page based on
> >>>> the provided pages, and then opportunistically allocates more if that
> >>>> can be done without dropping the spinlock.
> >>>>
> >>>> So if it returns fewer than requested, that could just mean that it
> >>>> needed to drop the lock.  In that case, try again immediately.
> >>>>
> >>>> Only pause for a time if no progress could be made.
> >>>
> >>> The case I was worried about was "no pages available on the
> >>> pcplist", in which case, alloc_pages_bulk_array() resorts
> >>> to calling __alloc_pages() and returns only one new page.
> >>>
> >>> "No progess" would mean even __alloc_pages() failed.
> >>>
> >>> So this patch would behave essentially like the
> >>> pre-alloc_pages_bulk_array() code: call alloc_page() for
> >>> each empty struct_page in the array without pausing. That
> >>> seems correct to me.
> >>>
> >>>
> >>> I would add
> >>>
> >>> Fixes: f6e70aab9dfe ("SUNRPC: refresh rq_pages using a bulk page allocator")
> >>>
> >>>
> >>>> Signed-off-by: NeilBrown <neilb@suse.de>
> >>>> ---
> >>>> net/sunrpc/svc_xprt.c | 7 +++++--
> >>>> 1 file changed, 5 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> >>>> index d66a8e44a1ae..99268dd95519 100644
> >>>> --- a/net/sunrpc/svc_xprt.c
> >>>> +++ b/net/sunrpc/svc_xprt.c
> >>>> @@ -662,7 +662,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
> >>>> {
> >>>>      struct svc_serv *serv = rqstp->rq_server;
> >>>>      struct xdr_buf *arg = &rqstp->rq_arg;
> >>>> -     unsigned long pages, filled;
> >>>> +     unsigned long pages, filled, prev;
> >>>>
> >>>>      pages = (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
> >>>>      if (pages > RPCSVC_MAXPAGES) {
> >>>> @@ -672,11 +672,14 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
> >>>>              pages = RPCSVC_MAXPAGES;
> >>>>      }
> >>>>
> >>>> -     for (;;) {
> >>>> +     for (prev = 0;; prev = filled) {
> >>>>              filled = alloc_pages_bulk_array(GFP_KERNEL, pages,
> >>>>                                              rqstp->rq_pages);
> >>>>              if (filled == pages)
> >>>>                      break;
> >>>> +             if (filled > prev)
> >>>> +                     /* Made progress, don't sleep yet */
> >>>> +                     continue;
> >>>>
> >>>>              set_current_state(TASK_INTERRUPTIBLE);
> >>>>              if (signalled() || kthread_should_stop()) {
> >>>
> >>> --
> >>> Chuck Lever
> >>>
> >>>
> >>>
>
> --
> Chuck Lever
>
>
>
