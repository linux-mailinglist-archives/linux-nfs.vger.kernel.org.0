Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC84672476
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjARRHd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjARRHX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:07:23 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC0256880
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:07:18 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a184so26704315pfa.9
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=11sVhEjAljcesWJCM6NYMSNlAgiwCG/zfh7gz/9uL08=;
        b=WtehA93OA+d3TPGTxpMkylh0YBxdJbIADVP/9SwVL+SPPQlQRlBZsd0LwA72mnNnj2
         AhkDeEPLQehMUO4jdH3A0xuC1WLdWgDbIAcYJfbqQdBtr6lNCnPLlrKQqKlVBXTA8IDa
         ++aft1VtVpp0wiuoElD8AGmm3l0uysUHCEOm1LkfFXnHOZTGlr1UDiO0C6is+fPoPxD0
         bpnu0AdcSk7MiRvta0CtCitQWsQxwApwvVu6Uh5e3mj2GAjoZ+mX3OCntiYzzTOJP/ik
         niKfn1jn4Tz5w+FLKD9S0TN3fuXncZ4bsgdC1gpcEYepwI6hKYz70uuRYmbQI1Pfde7F
         6RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11sVhEjAljcesWJCM6NYMSNlAgiwCG/zfh7gz/9uL08=;
        b=qip/EUHz3rGYwErKOT1YKhsAkAqQSNo3hXRHvT1vapt94hCvEOXzqVxil7l9jG9zrQ
         oX8JFaelYd4elCZCpwdY8Bqk013z6Q0W/f9rlZch1by06cPaCL5rWHJonaxY+Midgd6G
         1bX6aMeYe+vBoGe2EvXuCrrTWB8trO6e4jm6j0/ckTgubR/YKtIz4183BfjZJMpxWAzc
         rFrBzgZORZvOY8lwPAMiqmO9zv6FRsAGwxhrOYrioN1LI/NzwoJpQC1AXBjLKIxWTUzr
         k5uXfQupQPePENMhSvwamVV/3XsGcTWgK6enKd+heOrzJ+06LCzJuv7efNaAtFYqAlQV
         cQoA==
X-Gm-Message-State: AFqh2kpv9BmVG6w+YUtU125l9SJDb0ZjNvSIFSBtbFOC7W6PDXte9eTL
        NZkDTkf5Nb9HjsVunqApeCCcKUQFIDtFqfAR51S/n6VI
X-Google-Smtp-Source: AMrXdXsk7+8crsfAr5XDve25zGKKs91EW3Vdf1I4L1gYVoFuZTSxTMty9gaEELNarQRssOXwBsRWfTkx0eEBm7e1fnc=
X-Received: by 2002:a63:4760:0:b0:484:55ce:2577 with SMTP id
 w32-20020a634760000000b0048455ce2577mr501525pgk.172.1674061638120; Wed, 18
 Jan 2023 09:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20230117193831.75201-1-jlayton@kernel.org> <20230117193831.75201-3-jlayton@kernel.org>
 <CAN-5tyHA6JgqnEorEqz1b3CLdbXWhT6hNZKXzgfZy3Fr_TdW7Q@mail.gmail.com>
 <1fc9af5a2c2a79c5befa4510c714f97e26b13ed5.camel@kernel.org>
 <CAN-5tyHKS9o3KDV3zUmzjiOjSxyC1rNe77Tc8c7RHmoXE6s_RQ@mail.gmail.com> <cb4b8c379a07d9ecccd202b2a85e80ba6d5e5a26.camel@kernel.org>
In-Reply-To: <cb4b8c379a07d9ecccd202b2a85e80ba6d5e5a26.camel@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 18 Jan 2023 12:07:06 -0500
Message-ID: <CAN-5tyFLOZDS2W9UGMxZDo1Zi9RvuCXon3Xsd1yEyMtxyd3GeQ@mail.gmail.com>
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

On Wed, Jan 18, 2023 at 11:57 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Wed, 2023-01-18 at 11:29 -0500, Olga Kornievskaia wrote:
> > On Wed, Jan 18, 2023 at 10:27 AM Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > On Wed, 2023-01-18 at 09:42 -0500, Olga Kornievskaia wrote:
> > > > On Tue, Jan 17, 2023 at 2:38 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > >
> > > > > There are two different flavors of the nfsd4_copy struct. One is
> > > > > embedded in the compound and is used directly in synchronous copies. The
> > > > > other is dynamically allocated, refcounted and tracked in the client
> > > > > struture. For the embedded one, the cleanup just involves releasing any
> > > > > nfsd_files held on its behalf. For the async one, the cleanup is a bit
> > > > > more involved, and we need to dequeue it from lists, unhash it, etc.
> > > > >
> > > > > There is at least one potential refcount leak in this code now. If the
> > > > > kthread_create call fails, then both the src and dst nfsd_files in the
> > > > > original nfsd4_copy object are leaked.
> > > >
> > > > I don't believe that's true. If kthread_create thread fails we call
> > > > cleanup_async_copy() that does a put on the file descriptors.
> > > >
> > >
> > > You mean this?
> > >
> > > out_err:
> > >         if (async_copy)
> > >                 cleanup_async_copy(async_copy);
> > >
> > > That puts the references that were taken in dup_copy_fields, but the
> > > original (embedded) nfsd4_copy also holds references and those are not
> > > being put in this codepath.
> >
> > Can you please point out where do we take a reference on the original copy?
> >
>
> In the case of an inter-server copy, nf_dst is set in
> nfsd4_setup_inter_ssc. For intraserver copy, both pointers are set via
> the call to nfsd4_verify_copy. Both functions call
> nfs4_preprocess_stateid_op, which returns a reference to the nfsd_file
> in the second to last arg.

Ah. Thank you. I didn't know that nfs4_preprocess_stateid_op() takes a
reference on it's 5th argument. I think I was previously looking at
nfsd4_read() function which calls nfs4_preprocess_stateid_op() and
gets back read->rd_nf but it never does a put on it when it returns.
However, I now looked at other functions that call
nfs4_preproess_stateid_op() such as nfsd4_fallocate() and I see that
it does a put.
>
> > > > > The cleanup in this codepath is also sort of weird. In the async copy
> > > > > case, we'll have up to four nfsd_file references (src and dst for both
> > > > > flavors of copy structure).
> > > >
> > > > That's not true. There is a careful distinction between intra -- which
> > > > had 2 valid file pointers and does a get on both as they both point to
> > > > something that's opened on this server--- but inter -- only does a get
> > > > on the dst file descriptor, the src doesn't exit. And yes I realize
> > > > the code checks for nfs_src being null which it should be but it makes
> > > > the code less clear and at some point somebody might want to decide to
> > > > really do a put on it.
> > > >
> > >
> > > This is part of the problem here. We have a nfsd4_copy structure, and
> > > depending on what has been done to it, you need to call different
> > > methods to clean it up. That seems like a real antipattern to me.
> >
> > But they call different methods because different things need to be
> > done there and it makes it clear what needs to be for what type of
> > copy.
> >
>
>
> I sure as hell had a hard time dissecting how all of that was supposed
> to work. There is clear bug here, and I think this patch makes the
> result clearer and more robust in the face of changes.
>
> There are actually 4 different cases here: sync vs. async, alongside
> intra vs. interserver copy. These are all overloaded onto a nfsd4_copy
> structure, seemingly for no good reason.
>
> The cleanup, in particular seems quite fragile to me, and there is a
> dearth of defensive coding measures. If you subtly call the "wrong"
> cleanup function at the wrong point in time, then things may go awry.
>
> I'll leave it up to Chuck to make the final determination, but I see
> this patch as an improvement.
>
> > > > > They are both put at the end of
> > > > > nfsd4_do_async_copy, even though the ones held on behalf of the embedded
> > > > > one outlive that structure.
> > > > >
> > > > > Change it so that we always clean up the nfsd_file refs held by the
> > > > > embedded copy structure before nfsd4_copy returns. Rework
> > > > > cleanup_async_copy to handle both inter and intra copies. Eliminate
> > > > > nfsd4_cleanup_intra_ssc since it now becomes a no-op.
> > > >
> > > > I feel by combining the cleanup for both it obscures a very important
> > > > destication that src filehandle doesn't exist for inter.
> > >
> > > If the src filehandle doesn't exist, then the pointer to it will be
> > > NULL. I don't see what we gain by keeping these two distinct, other than
> > > avoiding a NULL pointer check.
> >
> > My reason would be for code clarity because different things are
> > supposed to happen for intra and inter. Difference of opinion it
> > seems.
> >
> > >
> > > >
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
> > > > >  1 file changed, 10 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > index 37a9cc8ae7ae..62b9d6c1b18b 100644
> > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *nsui, struct file *filp,
> > > > >         long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> > > > >
> > > > >         nfs42_ssc_close(filp);
> > > > > -       nfsd_file_put(dst);
> > > > >         fput(filp);
> > > > >
> > > > >         spin_lock(&nn->nfsd_ssc_lock);
> > > > > @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqstp,
> > > > >                                  &copy->nf_dst);
> > > > >  }
> > > > >
> > > > > -static void
> > > > > -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file *dst)
> > > > > -{
> > > > > -       nfsd_file_put(src);
> > > > > -       nfsd_file_put(dst);
> > > > > -}
> > > > > -
> > > > >  static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
> > > > >  {
> > > > >         struct nfsd4_cb_offload *cbo =
> > > > > @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
> > > > >         dst->ss_nsui = src->ss_nsui;
> > > > >  }
> > > > >
> > > > > +static void release_copy_files(struct nfsd4_copy *copy)
> > > > > +{
> > > > > +       if (copy->nf_src)
> > > > > +               nfsd_file_put(copy->nf_src);
> > > > > +       if (copy->nf_dst)
> > > > > +               nfsd_file_put(copy->nf_dst);
> > > > > +}
> > > > > +
> > > > >  static void cleanup_async_copy(struct nfsd4_copy *copy)
> > > > >  {
> > > > >         nfs4_free_copy_state(copy);
> > > > > -       nfsd_file_put(copy->nf_dst);
> > > > > -       if (!nfsd4_ssc_is_inter(copy))
> > > > > -               nfsd_file_put(copy->nf_src);
> > > > > +       release_copy_files(copy);
> > > > >         spin_lock(&copy->cp_clp->async_lock);
> > > > >         list_del(&copy->copies);
> > > > >         spin_unlock(&copy->cp_clp->async_lock);
> > > > > @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
> > > > >         } else {
> > > > >                 nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
> > > > >                                        copy->nf_dst->nf_file, false);
> > > > > -               nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
> > > > >         }
> > > > >
> > > > >  do_callback:
> > > > > @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > > > >         } else {
> > > > >                 status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
> > > > >                                        copy->nf_dst->nf_file, true);
> > > > > -               nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
> > > > >         }
> > > > >  out:
> > > > > +       release_copy_files(copy);
> > > > >         return status;
> > > > >  out_err:
> > > > >         if (async_copy)
> > > > > --
> > > > > 2.39.0
> > > > >
> > >
> > > --
> > > Jeff Layton <jlayton@kernel.org>
>
> --
> Jeff Layton <jlayton@kernel.org>
