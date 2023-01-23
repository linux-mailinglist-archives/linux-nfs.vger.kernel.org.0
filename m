Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F5F677F8A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 16:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjAWPXg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 10:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjAWPX3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 10:23:29 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704932A14B
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 07:22:24 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w2so9002684pfc.11
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 07:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YCkLcpaaxowLXRncIqlOUbwc4VwDKE5OUI8Fgk4o2mo=;
        b=TGJC3I43aCclPumbSJNGg/C9LSqgm1SqUEY8xhR1u25wuUlxSNouiTGLOC5noCIAJM
         q4xDFo86hFyZQQdBuh3/8/qH9sMBuHEH8n5IGLh0dldwiFAjqi2fOVOZYuLwmNAJSc4E
         pbLljSCaw6QsvC8pRIyPv1swWLtqFUxwMkVOSb7gPx3RbCVQT+a8whagaCtkOYS8ZXET
         vovdw8i+s7xQC/nNjQthZzM5236cgz90TIxmTGJD0QSHOp/n1bk8blk1LIL0uWEXKj/M
         XxjeT7tUE/0CzRZTa+TzEXgrXBKbaTF5IXYVuIOLmmfaqfSUjOfz+7IVhb4NG9m75JMp
         e22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCkLcpaaxowLXRncIqlOUbwc4VwDKE5OUI8Fgk4o2mo=;
        b=q50H41JwPYn26ZuWf41VI39j8OfREFCtW0FpMgkW33sVtEzc3JY+bLOKZGeSTmBlw2
         SH5NiBEFBoiLWUMHRbeDWmUns4N6iW9Zm66prrT+rhbuQlnT3FlRw8Fl9FzX/9XaHEtH
         eTjn3cCMF8TH8/zFOouX8QyBdlBpz8w29YH5DaN6ZBBljvuNl10ewdlXVWZdxSFRLQBE
         lr0jBuq3tXSe0H1O3YlAVZT3FSfmzLrdUradsDzC4NKvETPnAP+VCQi8GK3p/DZbA9+1
         /GNuP9V3iVxu09VRNPMr59tQ4JofYUrGhbA9LRq7aiVMQpPeMGSBc+lwH+mRyHuJErgu
         xZbg==
X-Gm-Message-State: AO0yUKUXXwvGyK15HHd3ssYImo9dj1nLkXc6J8KTKF6Litg1uZfZEDKG
        ZO+tHJVLiSzuKPyYP4nFldUD5QLfjEFcAmL6gAI=
X-Google-Smtp-Source: AK7set+RFCKAAEkzhFYmhNX2RbJL/4R+1+8l3YklabHMcLDwVKhe8E6n3gBbMAZpWjUOi0y72Ko8Y1BgrMBRVCJGSSc=
X-Received: by 2002:a62:5ec5:0:b0:590:22f:2b06 with SMTP id
 s188-20020a625ec5000000b00590022f2b06mr95667pfb.29.1674487343258; Mon, 23 Jan
 2023 07:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20230117193831.75201-1-jlayton@kernel.org> <20230117193831.75201-3-jlayton@kernel.org>
 <9bff17d4-c305-1918-5079-d2e9cf291bc7@oracle.com> <eb5a9fa65a8c2bcc257101c96f7fbbe18a3b74ff.camel@kernel.org>
 <3ff5458c-88ab-18ab-ebfe-98ba8050fd84@oracle.com> <3a910faf64ab6442fd089f17a0f7834dbf24cd41.camel@kernel.org>
 <68e2bff9-bf02-4b19-3707-be88b77d8072@oracle.com> <4577f120-9191-c138-299f-eeddc3652e8b@oracle.com>
 <80fd3e68dd5ed457bf38f4ff0a6086d568cc3cee.camel@kernel.org>
 <D14F7839-3E42-4592-BF11-4A19905D5AA4@oracle.com> <f52f1cbf-aed4-b0f3-2066-9aa67e2a6003@oracle.com>
 <71DC929D-D10B-4721-8327-301A7E65312F@oracle.com>
In-Reply-To: <71DC929D-D10B-4721-8327-301A7E65312F@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 23 Jan 2023 10:22:11 -0500
Message-ID: <CAN-5tyGOF4eg4WpMzh2kWa=UszC9oQGbKXNeKWOU3hpS5KSHNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jan 22, 2023 at 11:46 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jan 21, 2023, at 4:28 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >
> >
> > On 1/21/23 12:12 PM, Chuck Lever III wrote:
> >>
> >>> On Jan 21, 2023, at 3:05 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >>>
> >>> On Sat, 2023-01-21 at 11:50 -0800, dai.ngo@oracle.com wrote:
> >>>> On 1/21/23 10:56 AM, dai.ngo@oracle.com wrote:
> >>>>> On 1/20/23 3:43 AM, Jeff Layton wrote:
> >>>>>> On Thu, 2023-01-19 at 10:38 -0800, dai.ngo@oracle.com wrote:
> >>>>>>> On 1/19/23 2:56 AM, Jeff Layton wrote:
> >>>>>>>> On Wed, 2023-01-18 at 21:05 -0800, dai.ngo@oracle.com wrote:
> >>>>>>>>> On 1/17/23 11:38 AM, Jeff Layton wrote:
> >>>>>>>>>> There are two different flavors of the nfsd4_copy struct. One is
> >>>>>>>>>> embedded in the compound and is used directly in synchronous
> >>>>>>>>>> copies. The
> >>>>>>>>>> other is dynamically allocated, refcounted and tracked in the client
> >>>>>>>>>> struture. For the embedded one, the cleanup just involves
> >>>>>>>>>> releasing any
> >>>>>>>>>> nfsd_files held on its behalf. For the async one, the cleanup is
> >>>>>>>>>> a bit
> >>>>>>>>>> more involved, and we need to dequeue it from lists, unhash it, etc.
> >>>>>>>>>>
> >>>>>>>>>> There is at least one potential refcount leak in this code now.
> >>>>>>>>>> If the
> >>>>>>>>>> kthread_create call fails, then both the src and dst nfsd_files
> >>>>>>>>>> in the
> >>>>>>>>>> original nfsd4_copy object are leaked.
> >>>>>>>>>>
> >>>>>>>>>> The cleanup in this codepath is also sort of weird. In the async
> >>>>>>>>>> copy
> >>>>>>>>>> case, we'll have up to four nfsd_file references (src and dst for
> >>>>>>>>>> both
> >>>>>>>>>> flavors of copy structure). They are both put at the end of
> >>>>>>>>>> nfsd4_do_async_copy, even though the ones held on behalf of the
> >>>>>>>>>> embedded
> >>>>>>>>>> one outlive that structure.
> >>>>>>>>>>
> >>>>>>>>>> Change it so that we always clean up the nfsd_file refs held by the
> >>>>>>>>>> embedded copy structure before nfsd4_copy returns. Rework
> >>>>>>>>>> cleanup_async_copy to handle both inter and intra copies. Eliminate
> >>>>>>>>>> nfsd4_cleanup_intra_ssc since it now becomes a no-op.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >>>>>>>>>> ---
> >>>>>>>>>>     fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
> >>>>>>>>>>     1 file changed, 10 insertions(+), 13 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >>>>>>>>>> index 37a9cc8ae7ae..62b9d6c1b18b 100644
> >>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
> >>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
> >>>>>>>>>> @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct
> >>>>>>>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
> >>>>>>>>>>         long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> >>>>>>>>>>             nfs42_ssc_close(filp);
> >>>>>>>>>> -    nfsd_file_put(dst);
> >>>>>>>>> I think we still need this, in addition to release_copy_files called
> >>>>>>>>> from cleanup_async_copy. For async inter-copy, there are 2 reference
> >>>>>>>>> count added to the destination file, one from nfsd4_setup_inter_ssc
> >>>>>>>>> and the other one from dup_copy_fields. The above nfsd_file_put is
> >>>>>>>>> for
> >>>>>>>>> the count added by dup_copy_fields.
> >>>>>>>>>
> >>>>>>>> With this patch, the references held by the original copy structure
> >>>>>>>> are
> >>>>>>>> put by the call to release_copy_files at the end of nfsd4_copy. That
> >>>>>>>> means that the kthread task is only responsible for putting the
> >>>>>>>> references held by the (kmalloc'ed) async_copy structure. So, I think
> >>>>>>>> this gets the nfsd_file refcounting right.
> >>>>>>> Yes, I see. One refcount is decremented by release_copy_files at end
> >>>>>>> of nfsd4_copy and another is decremented by release_copy_files in
> >>>>>>> cleanup_async_copy.
> >>>>>>>
> >>>>>>>>>>         fput(filp);
> >>>>>>>>>>             spin_lock(&nn->nfsd_ssc_lock);
> >>>>>>>>>> @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqstp,
> >>>>>>>>>>                      &copy->nf_dst);
> >>>>>>>>>>     }
> >>>>>>>>>>     -static void
> >>>>>>>>>> -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file
> >>>>>>>>>> *dst)
> >>>>>>>>>> -{
> >>>>>>>>>> -    nfsd_file_put(src);
> >>>>>>>>>> -    nfsd_file_put(dst);
> >>>>>>>>>> -}
> >>>>>>>>>> -
> >>>>>>>>>>     static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
> >>>>>>>>>>     {
> >>>>>>>>>>         struct nfsd4_cb_offload *cbo =
> >>>>>>>>>> @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct
> >>>>>>>>>> nfsd4_copy *src, struct nfsd4_copy *dst)
> >>>>>>>>>>         dst->ss_nsui = src->ss_nsui;
> >>>>>>>>>>     }
> >>>>>>>>>>     +static void release_copy_files(struct nfsd4_copy *copy)
> >>>>>>>>>> +{
> >>>>>>>>>> +    if (copy->nf_src)
> >>>>>>>>>> +        nfsd_file_put(copy->nf_src);
> >>>>>>>>>> +    if (copy->nf_dst)
> >>>>>>>>>> +        nfsd_file_put(copy->nf_dst);
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>>     static void cleanup_async_copy(struct nfsd4_copy *copy)
> >>>>>>>>>>     {
> >>>>>>>>>>         nfs4_free_copy_state(copy);
> >>>>>>>>>> -    nfsd_file_put(copy->nf_dst);
> >>>>>>>>>> -    if (!nfsd4_ssc_is_inter(copy))
> >>>>>>>>>> -        nfsd_file_put(copy->nf_src);
> >>>>>>>>>> +    release_copy_files(copy);
> >>>>>>>>>>         spin_lock(&copy->cp_clp->async_lock);
> >>>>>>>>>>         list_del(&copy->copies);
> >>>>>>>>>> spin_unlock(&copy->cp_clp->async_lock);
> >>>>>>>>>> @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
> >>>>>>>>>>         } else {
> >>>>>>>>>>             nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
> >>>>>>>>>>                            copy->nf_dst->nf_file, false);
> >>>>>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
> >>>>>>>>>>         }
> >>>>>>>>>>         do_callback:
> >>>>>>>>>> @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct
> >>>>>>>>>> nfsd4_compound_state *cstate,
> >>>>>>>>>>         } else {
> >>>>>>>>>>             status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
> >>>>>>>>>>                            copy->nf_dst->nf_file, true);
> >>>>>>>>>> -        nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
> >>>>>>>>>>         }
> >>>>>>>>>>     out:
> >>>>>>>>>> +    release_copy_files(copy);
> >>>>>>>>>>         return status;
> >>>>>>>>>>     out_err:
> >>>>>>>>> This is unrelated to the reference count issue.
> >>>>>>>>>
> >>>>>>>>> Here if this is an inter-copy then we need to decrement the reference
> >>>>>>>>> count of the nfsd4_ssc_umount_item so that the vfsmount can be
> >>>>>>>>> unmounted
> >>>>>>>>> later.
> >>>>>>>>>
> >>>>>>>> Oh, I think I see what you mean. Maybe something like the (untested)
> >>>>>>>> patch below on top of the original patch would fix that?
> >>>>>>>>
> >>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >>>>>>>> index c9057462b973..7475c593553c 100644
> >>>>>>>> --- a/fs/nfsd/nfs4proc.c
> >>>>>>>> +++ b/fs/nfsd/nfs4proc.c
> >>>>>>>> @@ -1511,8 +1511,10 @@ nfsd4_cleanup_inter_ssc(struct
> >>>>>>>> nfsd4_ssc_umount_item *nsui, struct file *filp,
> >>>>>>>>           struct nfsd_net *nn = net_generic(dst->nf_net, nfsd_net_id);
> >>>>>>>>           long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> >>>>>>>>    -       nfs42_ssc_close(filp);
> >>>>>>>> -       fput(filp);
> >>>>>>>> +       if (filp) {
> >>>>>>>> +               nfs42_ssc_close(filp);
> >>>>>>>> +               fput(filp);
> >>>>>>>> +       }
> >>>>>>>>              spin_lock(&nn->nfsd_ssc_lo
> >>>>>>>>           list_del(&nsui->nsui_list);
> >>>>>>>> @@ -1813,8 +1815,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct
> >>>>>>>> nfsd4_compound_state *cstate,
> >>>>>>>>           release_copy_files(copy);
> >>>>>>>>           return status;
> >>>>>>>>    out_err:
> >>>>>>>> -       if (async_copy)
> >>>>>>>> +       if (async_copy) {
> >>>>>>>>                   cleanup_async_copy(async_copy);
> >>>>>>>> +               if (nfsd4_ssc_is_inter(async_copy))
> >>>>>>> We don't need to call nfsd4_cleanup_inter_ssc since the thread
> >>>>>>> nfsd4_do_async_copy has not started yet so the file is not opened.
> >>>>>>> We just need to do refcount_dec(&copy->ss_nsui->nsui_refcnt), unless
> >>>>>>> you want to change nfsd4_cleanup_inter_ssc to detect this error
> >>>>>>> condition and only decrement the reference count.
> >>>>>>>
> >>>>>> Oh yeah, and this would break anyway since the nsui_list head is not
> >>>>>> being initialized. Dai, would you mind spinning up a patch for this
> >>>>>> since you're more familiar with the cleanup here?
> >>>>> Will do. My patch will only fix the unmount issue. Your patch does
> >>>>> the clean up potential nfsd_file refcount leaks in COPY codepath.
> >>>> Or do you want me to merge your patch and mine into one?
> >>>>
> >>> It probably is best to merge them, since backporters will probably want
> >>> both patches anyway.
> >> Unless these two changes are somehow interdependent, I'd like to keep
> >> them separate. They address two separate issues, yes?
> >
> > Yes.
> >
> >>
> >> And -- narrow fixes need to go to nfsd-fixes, but clean-ups can wait
> >> for nfsd-next. I'd rather not mix the two types of change.
> >
> > Ok. Can we do this:
> >
> > 1. Jeff's patch goes to nfsd-fixes since it has the fix for missing
> > reference count.
>
> To make sure I haven't lost track of anything:
>
> The patch you refer to here is this one:
>
> https://lore.kernel.org/linux-nfs/20230117193831.75201-3-jlayton@kernel.org/
>
> Correct?
>
> (I was waiting for Jeff and Olga to come to consensus, and I think
> they have, so I can apply it to nfsd-fixes now).

Sorry folks but I got a bit lost in the thread. I thought Dai pointed
out that we can't remove the put from the nfsd4_cleanup_inter_ssc()
because that's the put for the copied structure and not the original
file references which is what Jeff's patch is trying to address.


> > 2. My fix for the cleanup of allocated memory goes to nfsd-fixes.
>
> And this one hasn't been posted yet, right? Or did I miss it?
>
>
> > 3. I will do the optimization Jeff proposed about list_head and
> > nfsd4_compound in a separate patch that goes into nfsd-next.
>
> That should be fine.
>
>
> > -Dai
> >
> >>> Just make yourself the patch author and keep my S-o-b line.
> >>>
> >>>> I think we need a bit more cleanup in addition to your patch. When
> >>>> kmalloc(sizeof(*async_copy->cp_src), ..) or nfs4_init_copy_state
> >>>> fails, the async_copy is not initialized yet so calling cleanup_async_copy
> >>>> can be a problem.
> >>>>
> >>> Yeah.
> >>>
> >>> It may even be best to ensure that the list_head and such are fully
> >>> initialized for both allocated and embedded struct nfsd4_copy's. You
> >>> might shave off a few cpu cycles by not doing that, but it makes things
> >>> more fragile.
> >>>
> >>> Even better, we really ought to split a lot of the fields in nfsd4_copy
> >>> into a different structure (maybe nfsd4_async_copy). Trimming down
> >>> struct nfsd4_copy would cut down the size of nfsd4_compound as well
> >>> since it has a union that contains it. I was planning on doing that
> >>> eventually, but if you want to take that on, then that would be fine
> >>> too.
> >>>
> >>> --
> >>> Jeff Layton <jlayton@kernel.org>
> >> --
> >> Chuck Lever
>
> --
> Chuck Lever
>
>
>
