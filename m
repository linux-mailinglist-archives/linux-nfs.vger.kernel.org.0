Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B675367268D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 19:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjARSR2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 13:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjARSQo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 13:16:44 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21F25A365
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 10:16:42 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so3042175pjl.0
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 10:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=84dcjt0FSinmofCbZBmnPAi36UUTwkXE05KRgfBYryc=;
        b=SCl0agTk1J7D/jsY7w1HIheYK/fQHVeYJfo5sCC8+T+DbV6FmNKhCjQEaOKygiA1b5
         RpDvk+Rc2/JGxWXqqdVGwvl4ywbvYFHs/7qJBPvWtiX38jt3DG4foA6ddYmUaGa2Fzbk
         Iu4rTUMGLZrH694uKplpd7HgGCLGtUahbsGUUlj5ZsiGXn8uQe0BrI8sbD7MGT1BFU44
         B8YCjzxJcoBixgYAK+fmLd1uWDHLV2A/VGrdnaZ5fTLID3wMPbQRUOYMDAEvHa75K3Mj
         IvKzmxiogN6uUlpz5CPF2BqFuC13WF9v1o59EpIPzy9xUFS1JCZUh+OIibutQ9K9o2BT
         uP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84dcjt0FSinmofCbZBmnPAi36UUTwkXE05KRgfBYryc=;
        b=Mr9CM138nYVZkYlr3HfZDH3fTXvlKFxUNtO51tShm+GSUnoGQImljavw5Zli+mgSzY
         uL+dY3cdUL63o3tY8bKtakn0t1fUAjKeC7rY8faEUwPYZmU5+2yDlWqX2ow3lOT8CDFF
         3uZcivbs18oFZiSDXPfBV7YiLml0jpNf9b/VpkRM3XKevMVqpVhNw3f3d83rWEoEC+gB
         Vb/st8RPrFPrvcauTFuAO5EyR0oOnMfgx4VNa6we2zs4aA9Z89bO7UeDJRgfvWoQ9Lvn
         SKxtQX6IjjczlkQOHQL98stlJ7ik9hFXzKhzP+kCKTm3LNF7V29GixUXV52NEBsAhVac
         fo9w==
X-Gm-Message-State: AFqh2kphg2grfwJdCDXHkhMQ9GVWWbMW7bC8LHp3FlhOonIOw8b3X5n0
        dvI35HdLArk77dtifQkNlFLAwU141acDrZ1qa39Kz06T
X-Google-Smtp-Source: AMrXdXuZlBzQWYOsho3czlEuEEAmWMjtpcdMdBQHYXVZRAnjQjMn1fsb50YO7FXQMRdgKj06f50RTU4nfE2BetKlZB8=
X-Received: by 2002:a17:902:778c:b0:192:ba7a:2be4 with SMTP id
 o12-20020a170902778c00b00192ba7a2be4mr877939pll.27.1674065802065; Wed, 18 Jan
 2023 10:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20230117193831.75201-1-jlayton@kernel.org> <20230117193831.75201-3-jlayton@kernel.org>
 <CAN-5tyHA6JgqnEorEqz1b3CLdbXWhT6hNZKXzgfZy3Fr_TdW7Q@mail.gmail.com>
 <1fc9af5a2c2a79c5befa4510c714f97e26b13ed5.camel@kernel.org>
 <CAN-5tyHKS9o3KDV3zUmzjiOjSxyC1rNe77Tc8c7RHmoXE6s_RQ@mail.gmail.com>
 <cb4b8c379a07d9ecccd202b2a85e80ba6d5e5a26.camel@kernel.org> <CAN-5tyFLOZDS2W9UGMxZDo1Zi9RvuCXon3Xsd1yEyMtxyd3GeQ@mail.gmail.com>
In-Reply-To: <CAN-5tyFLOZDS2W9UGMxZDo1Zi9RvuCXon3Xsd1yEyMtxyd3GeQ@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 18 Jan 2023 13:16:30 -0500
Message-ID: <CAN-5tyEvXo+xijgk+Wbrrvy=O3BwdOB9MHdsQCXvsM_CyemaRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nfsd: clean up potential nfsd_file refcount leaks in
 COPY codepath
To:     Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        dai.ngo@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 18, 2023 at 12:07 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Wed, Jan 18, 2023 at 11:57 AM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Wed, 2023-01-18 at 11:29 -0500, Olga Kornievskaia wrote:
> > > On Wed, Jan 18, 2023 at 10:27 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > >
> > > > On Wed, 2023-01-18 at 09:42 -0500, Olga Kornievskaia wrote:
> > > > > On Tue, Jan 17, 2023 at 2:38 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > >
> > > > > > There are two different flavors of the nfsd4_copy struct. One is
> > > > > > embedded in the compound and is used directly in synchronous copies. The
> > > > > > other is dynamically allocated, refcounted and tracked in the client
> > > > > > struture. For the embedded one, the cleanup just involves releasing any
> > > > > > nfsd_files held on its behalf. For the async one, the cleanup is a bit
> > > > > > more involved, and we need to dequeue it from lists, unhash it, etc.
> > > > > >
> > > > > > There is at least one potential refcount leak in this code now. If the
> > > > > > kthread_create call fails, then both the src and dst nfsd_files in the
> > > > > > original nfsd4_copy object are leaked.
> > > > >
> > > > > I don't believe that's true. If kthread_create thread fails we call
> > > > > cleanup_async_copy() that does a put on the file descriptors.
> > > > >
> > > >
> > > > You mean this?
> > > >
> > > > out_err:
> > > >         if (async_copy)
> > > >                 cleanup_async_copy(async_copy);
> > > >
> > > > That puts the references that were taken in dup_copy_fields, but the
> > > > original (embedded) nfsd4_copy also holds references and those are not
> > > > being put in this codepath.
> > >
> > > Can you please point out where do we take a reference on the original copy?
> > >
> >
> > In the case of an inter-server copy, nf_dst is set in
> > nfsd4_setup_inter_ssc. For intraserver copy, both pointers are set via
> > the call to nfsd4_verify_copy. Both functions call
> > nfs4_preprocess_stateid_op, which returns a reference to the nfsd_file
> > in the second to last arg.
>
> Ah. Thank you. I didn't know that nfs4_preprocess_stateid_op() takes a
> reference on it's 5th argument. I think I was previously looking at
> nfsd4_read() function which calls nfs4_preprocess_stateid_op() and
> gets back read->rd_nf but it never does a put on it when it returns.
> However, I now looked at other functions that call
> nfs4_preproess_stateid_op() such as nfsd4_fallocate() and I see that
> it does a put.

So is there a refcount leak in the nfsd4_read() then since it doesn't
do a put? Or the internals obscure and that even though it calls the
same function and passes that parameter no refcount was increased. Is
it based on the "WR_STATE, RD_STATE" parameter. I see that
nfsd4_write() does do a put. For copy, we call the src_fd with
RD_STATE and dst_fd with WR_STATE. If I were to follow the logic of
nfsd4_read/nfsd4_write, the the copy doesn't need to do a put for src
but will need it for the dst. The proposed patch does it for both.

So I'm still confused if this patch is the correct solution.

> >
> > > > > > The cleanup in this codepath is also sort of weird. In the async copy
> > > > > > case, we'll have up to four nfsd_file references (src and dst for both
> > > > > > flavors of copy structure).
> > > > >
> > > > > That's not true. There is a careful distinction between intra -- which
> > > > > had 2 valid file pointers and does a get on both as they both point to
> > > > > something that's opened on this server--- but inter -- only does a get
> > > > > on the dst file descriptor, the src doesn't exit. And yes I realize
> > > > > the code checks for nfs_src being null which it should be but it makes
> > > > > the code less clear and at some point somebody might want to decide to
> > > > > really do a put on it.
> > > > >
> > > >
> > > > This is part of the problem here. We have a nfsd4_copy structure, and
> > > > depending on what has been done to it, you need to call different
> > > > methods to clean it up. That seems like a real antipattern to me.
> > >
> > > But they call different methods because different things need to be
> > > done there and it makes it clear what needs to be for what type of
> > > copy.
> > >
> >
> >
> > I sure as hell had a hard time dissecting how all of that was supposed
> > to work. There is clear bug here, and I think this patch makes the
> > result clearer and more robust in the face of changes.
> >
> > There are actually 4 different cases here: sync vs. async, alongside
> > intra vs. interserver copy. These are all overloaded onto a nfsd4_copy
> > structure, seemingly for no good reason.
> >
> > The cleanup, in particular seems quite fragile to me, and there is a
> > dearth of defensive coding measures. If you subtly call the "wrong"
> > cleanup function at the wrong point in time, then things may go awry.
> >
> > I'll leave it up to Chuck to make the final determination, but I see
> > this patch as an improvement.
> >
> > > > > > They are both put at the end of
> > > > > > nfsd4_do_async_copy, even though the ones held on behalf of the embedded
> > > > > > one outlive that structure.
> > > > > >
> > > > > > Change it so that we always clean up the nfsd_file refs held by the
> > > > > > embedded copy structure before nfsd4_copy returns. Rework
> > > > > > cleanup_async_copy to handle both inter and intra copies. Eliminate
> > > > > > nfsd4_cleanup_intra_ssc since it now becomes a no-op.
> > > > >
> > > > > I feel by combining the cleanup for both it obscures a very important
> > > > > destication that src filehandle doesn't exist for inter.
> > > >
> > > > If the src filehandle doesn't exist, then the pointer to it will be
> > > > NULL. I don't see what we gain by keeping these two distinct, other than
> > > > avoiding a NULL pointer check.
> > >
> > > My reason would be for code clarity because different things are
> > > supposed to happen for intra and inter. Difference of opinion it
> > > seems.
> > >
> > > >
> > > > >
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ---
> > > > > >  fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
> > > > > >  1 file changed, 10 insertions(+), 13 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > > index 37a9cc8ae7ae..62b9d6c1b18b 100644
> > > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > > @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *nsui, struct file *filp,
> > > > > >         long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> > > > > >
> > > > > >         nfs42_ssc_close(filp);
> > > > > > -       nfsd_file_put(dst);
> > > > > >         fput(filp);
> > > > > >
> > > > > >         spin_lock(&nn->nfsd_ssc_lock);
> > > > > > @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqstp,
> > > > > >                                  &copy->nf_dst);
> > > > > >  }
> > > > > >
> > > > > > -static void
> > > > > > -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file *dst)
> > > > > > -{
> > > > > > -       nfsd_file_put(src);
> > > > > > -       nfsd_file_put(dst);
> > > > > > -}
> > > > > > -
> > > > > >  static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
> > > > > >  {
> > > > > >         struct nfsd4_cb_offload *cbo =
> > > > > > @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
> > > > > >         dst->ss_nsui = src->ss_nsui;
> > > > > >  }
> > > > > >
> > > > > > +static void release_copy_files(struct nfsd4_copy *copy)
> > > > > > +{
> > > > > > +       if (copy->nf_src)
> > > > > > +               nfsd_file_put(copy->nf_src);
> > > > > > +       if (copy->nf_dst)
> > > > > > +               nfsd_file_put(copy->nf_dst);
> > > > > > +}
> > > > > > +
> > > > > >  static void cleanup_async_copy(struct nfsd4_copy *copy)
> > > > > >  {
> > > > > >         nfs4_free_copy_state(copy);
> > > > > > -       nfsd_file_put(copy->nf_dst);
> > > > > > -       if (!nfsd4_ssc_is_inter(copy))
> > > > > > -               nfsd_file_put(copy->nf_src);
> > > > > > +       release_copy_files(copy);
> > > > > >         spin_lock(&copy->cp_clp->async_lock);
> > > > > >         list_del(&copy->copies);
> > > > > >         spin_unlock(&copy->cp_clp->async_lock);
> > > > > > @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
> > > > > >         } else {
> > > > > >                 nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
> > > > > >                                        copy->nf_dst->nf_file, false);
> > > > > > -               nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
> > > > > >         }
> > > > > >
> > > > > >  do_callback:
> > > > > > @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > > > > >         } else {
> > > > > >                 status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
> > > > > >                                        copy->nf_dst->nf_file, true);
> > > > > > -               nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
> > > > > >         }
> > > > > >  out:
> > > > > > +       release_copy_files(copy);
> > > > > >         return status;
> > > > > >  out_err:
> > > > > >         if (async_copy)
> > > > > > --
> > > > > > 2.39.0
> > > > > >
> > > >
> > > > --
> > > > Jeff Layton <jlayton@kernel.org>
> >
> > --
> > Jeff Layton <jlayton@kernel.org>
