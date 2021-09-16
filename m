Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4259640D1BE
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Sep 2021 04:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhIPCrR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Sep 2021 22:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbhIPCrR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Sep 2021 22:47:17 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB1BC061574
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 19:45:57 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r2so4740876pgl.10
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 19:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KOnbn/oK9jjJ6EK9aqpLWW8z4pmzi1ccrmKjeGDdCUQ=;
        b=TbTZcpngX871L9EDoshbbQFjZXEj9xi3W0HC766fPIeMiLSYRchkyDkXjkV8jeD/1+
         fSpddw3J+JcYSsPHHgMc3PJpNelrB+5QlKSR0KHk+NyWxQst90E/7o7JWBGjSJN4sU8L
         YTfHikhW4itx2eq83Ngq6QtqmmBjeB2pwmRx3chwq9ELOjI6ZoAS0MtxNeBy2LbQmocp
         snfd0VKoKHp2SSa2Rte4NlF8np3LUrDtpM4uFrkx2aElX6ij0Ju+gWY3T/NY2FaiAIx6
         jUQNtDZ9wbx+Srd52edfdsgFWt0+N6UJ4kbAWV2r1bFGvd2KmyYpOttJHUsozdFWTIuk
         M43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KOnbn/oK9jjJ6EK9aqpLWW8z4pmzi1ccrmKjeGDdCUQ=;
        b=A/+eKd8EqZe7s9nMhh+vpkeR6mYLVaM2gwUttQvHG5QM/LPDagwh7lBADkdwHdM5VT
         oYjVZpL9gEWl8Xh8b4u6ixStpZNLgfBV5wSbu3i04vpO5Fz5NwgszKjbsAuLw6a/tK5l
         zEyyCxa1vJxTongg4dhHTQgb3YN6LA0hOGTE7xmN2yF0x8monNrItXzmQCq2ynNhGnV8
         EQkf0XmQ3yQWE5R+LJoYMPleXpzZVBnnQkdICS0w09qAeaR9G+9Mb4gFRC7+IbmbgE5B
         eD0Qh7rl7ahH8UgXY5Sbbc8n861emfcRJOrZUVTyzGLaloQlky0rY3qK0c1zG02jJKK7
         4UCQ==
X-Gm-Message-State: AOAM532rtdprIZkBmzzVNxR53jBN1cvesKSdZ/kzy+0p9D7aGeYaFXsk
        dLcDui3dL0ELRV9uxTfHCVau+sMhSp+HTHK1v7jpgsfzHhw=
X-Google-Smtp-Source: ABdhPJwPHrnUevaHvUoYKr/+YDrNj/0Djx/ikRaTVuIZ4slFhvFcqeeDt0z/ISO9mugxzRz7f7tlIfjvbpEvgD+JZoo=
X-Received: by 2002:a63:4606:: with SMTP id t6mr2781470pga.388.1631760356959;
 Wed, 15 Sep 2021 19:45:56 -0700 (PDT)
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
 <CAOv1SKATk1iP=J9r2x0CQzNuwq2VoRvN8Mkba3DsKq6W_tfrDQ@mail.gmail.com>
 <416268C9-BEAC-483C-9392-8139340BC849@oracle.com> <CAOv1SKCjvgSfUoFtufZ5-dB-quG=djnn-UHO286S410aVxrV0Q@mail.gmail.com>
 <12B831AA-4A4E-4102-ADA3-97B6FA0B119E@oracle.com> <CAOv1SKC_ssgngiYMByVyngL6xUxPzbb7vKsvuwXjrAjC2TLcWA@mail.gmail.com>
 <27DDAD3A-B9E0-4CD3-B997-E4AFBD8C5264@oracle.com>
In-Reply-To: <27DDAD3A-B9E0-4CD3-B997-E4AFBD8C5264@oracle.com>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Wed, 15 Sep 2021 19:45:46 -0700
Message-ID: <CAOv1SKANNnAQms8mGJzTAW4dDWTF=EeCWM0tQJNiGQ=7Jekqzg@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Mel Gorman <mgorman@suse.com>, Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chuck:

I see that the patch was merged to Linus' branch, but there have been
2 stable patch releases since and the patch hasn't been pulled in. You
mentioned I should reach out to the stable maintainers in this
instance, is the stable@vger.kernel.org list the appropriate place to
make such a request?

Thanks.

- mike

On Sat, Sep 4, 2021 at 7:02 PM Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>
>
> > On Sep 4, 2021, at 1:41 PM, Mike Javorski <mike.javorski@gmail.com> wro=
te:
> >
> > =EF=BB=BFHi Chuck.
> >
> > I noticed that you sent in the 5.15 pull request but Neil's fix
> > (e38b3f20059426a0adbde014ff71071739ab5226 in your tree) missed the
> > pull and thus the fix isn't going to be backported to 5.14 in the near
> > term. Is there another 5.15 pull planned in the not too distant future
> > so this will get flagged for back-porting,
>
> Yes. The final version of Neil=E2=80=99s patch was just a little late for=
 the initial v5.15 NFSD pull request (IMO) so it=E2=80=99s queued for the n=
ext PR, probably this week.
>
>
> > or do I need to reach out to someone to expressly pull it into 5.14? If=
 the latter, can you
> > point me in the right direction of who to ask (I assume it's someone
> > other than Greg KH)?
> >
> > Thanks
> >
> > - mike
> >
> >
> >> On Sat, Aug 28, 2021 at 11:23 AM Chuck Lever III <chuck.lever@oracle.c=
om> wrote:
> >>
> >>
> >>
> >>>> On Aug 27, 2021, at 11:22 PM, Mike Javorski <mike.javorski@gmail.com=
> wrote:
> >>>
> >>> I had some time this evening (and the kernel finally compiled), and
> >>> wanted to get this tested.
> >>>
> >>> The TL;DR:  Both patches are needed
> >>>
> >>> Below are the test results from my replication of Neil's test. It is
> >>> readily apparent that both the 5.13.13 kernel AND the 5.13.13 kernel
> >>> with the 82011c80b3ec fix exhibit the randomness in read times that
> >>> were observed. The 5.13.13 kernel with both the 82011c80b3ec and
> >>> f6e70aab9dfe fixes brings the performance back in line with the
> >>> 5.12.15 kernel which I tested as a baseline.
> >>>
> >>> Please forgive the inconsistency in sample counts. This was running a=
s
> >>> a while loop, and I just let it go long enough that the behavior was
> >>> consistent. Only change to the VM between tests was the different
> >>> kernel + a reboot. The testing PC had a consistent workload during th=
e
> >>> entire set of tests.
> >>>
> >>> Test 0: 5.13.10 (base kernel in VM image, just for kicks)
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>> Samples 30
> >>> Min 6.839
> >>> Max 19.998
> >>> Median 9.638
> >>> 75-P 10.898
> >>> 95-P 12.939
> >>> 99-P 18.005
> >>>
> >>> Test 1: 5.12.15 (known good)
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>> Samples 152
> >>> Min 1.997
> >>> Max 2.333
> >>> Median 2.171
> >>> 75-P 2.230
> >>> 95-P 2.286
> >>> 99-P 2.312
> >>>
> >>> Test 2: 5.13.13 (known bad)
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>> Samples 42
> >>> Min 3.587
> >>> Max 15.803
> >>> Median 6.039
> >>> 75-P 6.452
> >>> 95-P 10.293
> >>> 99-P 15.540
> >>>
> >>> Test 3: 5.13.13 + 82011c80b3ec fix
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>> Samples 44
> >>> Min 4.309
> >>> Max 37.040
> >>> Median 6.615
> >>> 75-P 10.224
> >>> 95-P 19.516
> >>> 99-P 36.650
> >>>
> >>> Test 4: 5.13.13 + 82011c80b3ec fix + f6e70aab9dfe fix
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>> Samples 131
> >>> Min 2.013
> >>> Max 2.397
> >>> Median 2.169
> >>> 75-P 2.211
> >>> 95-P 2.283
> >>> 99-P 2.348
> >>>
> >>> I am going to run the kernel w/ both fixes over the weekend, but
> >>> things look good at this point.
> >>>
> >>> - mike
> >>
> >> I've targeted Neil's fix for the first 5.15-rc NFSD pull request.
> >> I'd like to have Mel's Reviewed-by or Acked-by, though.
> >>
> >> I will add a Fixes: tag if Neil doesn't repost (no reason to at
> >> this point) so the fix should get backported automatically to
> >> recent stable kernels.
> >>
> >>
> >>> On Fri, Aug 27, 2021 at 4:49 PM Chuck Lever III <chuck.lever@oracle.c=
om> wrote:
> >>>>
> >>>>
> >>>>> On Aug 27, 2021, at 6:00 PM, Mike Javorski <mike.javorski@gmail.com=
> wrote:
> >>>>>
> >>>>> OK, an update. Several hours of spaced out testing sessions and the
> >>>>> first patch seems to have resolved the issue. There may be a very t=
iny
> >>>>> bit of lag that still occurs when opening/processing new files, but=
 so
> >>>>> far on this kernel I have not had any multi-second freezes. I am st=
ill
> >>>>> waiting on the kernel with Neil's patch to compile (compiling on th=
is
> >>>>> underpowered server so it's taking several hours), but I think the
> >>>>> testing there will just be to see if I can show it works still, and
> >>>>> then to try and test in a memory constrained VM. To see if I can
> >>>>> recreate Neil's experiment. Likely will have to do this over the
> >>>>> weekend given the kernel compile delay + fiddling with a VM.
> >>>>
> >>>> Thanks for your testing!
> >>>>
> >>>>
> >>>>> Chuck: I don't mean to overstep bounds, but is it possible to get t=
hat
> >>>>> patch pulled into 5.13 stable? That may help things for several peo=
ple
> >>>>> while 5.14 goes through it's shakedown in archlinux prior to releas=
e.
> >>>>
> >>>> The patch had a Fixes: tag, so it should get automatically backporte=
d
> >>>> to every kernel that has the broken commit. If you don't see it in
> >>>> a subsequent 5.13 stable kernel, you are free to ask the stable
> >>>> maintainers to consider it.
> >>>>
> >>>>
> >>>>> - mike
> >>>>>
> >>>>> On Fri, Aug 27, 2021 at 10:07 AM Mike Javorski <mike.javorski@gmail=
.com> wrote:
> >>>>>>
> >>>>>> Chuck:
> >>>>>> I just booted a 5.13.13 kernel with your suggested patch. No freez=
es
> >>>>>> on the first test, but that sometimes happens so I will let the se=
rver
> >>>>>> settle some and try it again later in the day (which also would al=
ign
> >>>>>> with Neil's comment on memory fragmentation being a contributor).
> >>>>>>
> >>>>>> Neil:
> >>>>>> I have started a compile with the above kernel + your patch to tes=
t
> >>>>>> next unless you or Chuck determine that it isn't needed, or that I
> >>>>>> should test both patches discreetly. As the above is already merge=
d to
> >>>>>> 5.14 it seemed logical to just add your patch on top.
> >>>>>>
> >>>>>> I will also try to set up a vm to test your md5sum scenario with t=
he
> >>>>>> various kernels since it's a much faster thing to test.
> >>>>>>
> >>>>>> - mike
> >>>>>>
> >>>>>> On Fri, Aug 27, 2021 at 7:13 AM Chuck Lever III <chuck.lever@oracl=
e.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>> On Aug 27, 2021, at 3:14 AM, NeilBrown <neilb@suse.de> wrote:
> >>>>>>>>
> >>>>>>>> Subject: [PATCH] SUNRPC: don't pause on incomplete allocation
> >>>>>>>>
> >>>>>>>> alloc_pages_bulk_array() attempts to allocate at least one page =
based on
> >>>>>>>> the provided pages, and then opportunistically allocates more if=
 that
> >>>>>>>> can be done without dropping the spinlock.
> >>>>>>>>
> >>>>>>>> So if it returns fewer than requested, that could just mean that=
 it
> >>>>>>>> needed to drop the lock.  In that case, try again immediately.
> >>>>>>>>
> >>>>>>>> Only pause for a time if no progress could be made.
> >>>>>>>
> >>>>>>> The case I was worried about was "no pages available on the
> >>>>>>> pcplist", in which case, alloc_pages_bulk_array() resorts
> >>>>>>> to calling __alloc_pages() and returns only one new page.
> >>>>>>>
> >>>>>>> "No progess" would mean even __alloc_pages() failed.
> >>>>>>>
> >>>>>>> So this patch would behave essentially like the
> >>>>>>> pre-alloc_pages_bulk_array() code: call alloc_page() for
> >>>>>>> each empty struct_page in the array without pausing. That
> >>>>>>> seems correct to me.
> >>>>>>>
> >>>>>>>
> >>>>>>> I would add
> >>>>>>>
> >>>>>>> Fixes: f6e70aab9dfe ("SUNRPC: refresh rq_pages using a bulk page =
allocator")
> >>>>>>>
> >>>>>>>
> >>>>>>>> Signed-off-by: NeilBrown <neilb@suse.de>
> >>>>>>>> ---
> >>>>>>>> net/sunrpc/svc_xprt.c | 7 +++++--
> >>>>>>>> 1 file changed, 5 insertions(+), 2 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> >>>>>>>> index d66a8e44a1ae..99268dd95519 100644
> >>>>>>>> --- a/net/sunrpc/svc_xprt.c
> >>>>>>>> +++ b/net/sunrpc/svc_xprt.c
> >>>>>>>> @@ -662,7 +662,7 @@ static int svc_alloc_arg(struct svc_rqst *rq=
stp)
> >>>>>>>> {
> >>>>>>>>    struct svc_serv *serv =3D rqstp->rq_server;
> >>>>>>>>    struct xdr_buf *arg =3D &rqstp->rq_arg;
> >>>>>>>> -     unsigned long pages, filled;
> >>>>>>>> +     unsigned long pages, filled, prev;
> >>>>>>>>
> >>>>>>>>    pages =3D (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
> >>>>>>>>    if (pages > RPCSVC_MAXPAGES) {
> >>>>>>>> @@ -672,11 +672,14 @@ static int svc_alloc_arg(struct svc_rqst *=
rqstp)
> >>>>>>>>            pages =3D RPCSVC_MAXPAGES;
> >>>>>>>>    }
> >>>>>>>>
> >>>>>>>> -     for (;;) {
> >>>>>>>> +     for (prev =3D 0;; prev =3D filled) {
> >>>>>>>>            filled =3D alloc_pages_bulk_array(GFP_KERNEL, pages,
> >>>>>>>>                                            rqstp->rq_pages);
> >>>>>>>>            if (filled =3D=3D pages)
> >>>>>>>>                    break;
> >>>>>>>> +             if (filled > prev)
> >>>>>>>> +                     /* Made progress, don't sleep yet */
> >>>>>>>> +                     continue;
> >>>>>>>>
> >>>>>>>>            set_current_state(TASK_INTERRUPTIBLE);
> >>>>>>>>            if (signalled() || kthread_should_stop()) {
> >>>>>>>
> >>>>>>> --
> >>>>>>> Chuck Lever
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>
> >>>> --
> >>>> Chuck Lever
> >>>>
> >>>>
> >>>>
> >>
> >> --
> >> Chuck Lever
> >>
> >>
> >>
