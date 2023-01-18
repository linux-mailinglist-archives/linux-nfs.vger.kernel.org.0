Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC3B672358
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 17:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjARQb4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 11:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjARQbe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 11:31:34 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B52599BB
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 08:29:29 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 200so20441273pfx.7
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 08:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E1yzc0xMNsHwn821CMSakLZ0YRpKD708qeoHAkvCp1k=;
        b=r4r8RE9/H3Qg4vDym58324MgB+h15N8AGEbAlv/J6y6LszOWXiF1dae9+M200zxtvi
         GGtJC8ciQVHt3u7FZBT8WxIxNawmkUQqRSlt385Z094L/w6+hDe6axUDC8V8AKuUP3KY
         SkrYAztiCiMwIaPPZ5MXhW3YlnhsfqVQb1LScn7ApybMf+d3vL6yqsl0YkzcttgGkKZs
         qyYq66R50Tcom+xuv6BX1BFeHnC3pJCjAlCTcyqjveFTaN6R2UJXSuX3dlVxu2APvdA7
         ry0JIlZUDi4OHGOsSxcWLr/R0dvZr5T0pfYAf5QUJ8IcdCdT5jV+kij2Nu48sCBaUzrv
         nyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1yzc0xMNsHwn821CMSakLZ0YRpKD708qeoHAkvCp1k=;
        b=hBfhOjZVoMTRWcliJQn5KYAM2mvl1YguTsHW/14gZQFWLGEXHo9DT2T3hBXs/3Cx86
         ON+QRN06NdCGTVSmBSbDXvud237GXgk8gE8BdphBzl+5sbLUT0iWSouKMzpFUClbFRx8
         Wa5yacF4L9wk/7JV8tDu3h+TmWrg+P/wzgQHSHMmazkU5Yw8p1OCBGOhOvmNSJmmfnpk
         CmHeiL4I8YYQs3cJdcAcQ7uewEZP4vCKByplMJd5E27eZqKFk6vBF3wp/n/76smZSuoB
         vybiPb5AULBpovhf4EKOOnDHFcedPsRtuDkNSOyuK8E3Y15WObqHmSRVYT5z9tLeBOy1
         7nFA==
X-Gm-Message-State: AFqh2kpoqRP2eNTdPv+/3Zhb1f43Q8OpbrzuPJiMo/PyqreLej/OknAh
        oyyJUR6sXsGmP1c+6MLl0LiAriG4Y/p3BX5vc+s=
X-Google-Smtp-Source: AMrXdXtFexrBZZB5SdDPqFz7tX56W43NMOZ3UiP31Ko6/9vxoY/4QB2Z3Pmx6SW33gyUnAwivQGHOoasshRfaY96aj8=
X-Received: by 2002:a65:4884:0:b0:476:a862:53d2 with SMTP id
 n4-20020a654884000000b00476a86253d2mr697501pgs.163.1674059369104; Wed, 18 Jan
 2023 08:29:29 -0800 (PST)
MIME-Version: 1.0
References: <20230117193831.75201-1-jlayton@kernel.org> <20230117193831.75201-3-jlayton@kernel.org>
 <CAN-5tyHA6JgqnEorEqz1b3CLdbXWhT6hNZKXzgfZy3Fr_TdW7Q@mail.gmail.com> <1fc9af5a2c2a79c5befa4510c714f97e26b13ed5.camel@kernel.org>
In-Reply-To: <1fc9af5a2c2a79c5befa4510c714f97e26b13ed5.camel@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 18 Jan 2023 11:29:17 -0500
Message-ID: <CAN-5tyHKS9o3KDV3zUmzjiOjSxyC1rNe77Tc8c7RHmoXE6s_RQ@mail.gmail.com>
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

On Wed, Jan 18, 2023 at 10:27 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Wed, 2023-01-18 at 09:42 -0500, Olga Kornievskaia wrote:
> > On Tue, Jan 17, 2023 at 2:38 PM Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > There are two different flavors of the nfsd4_copy struct. One is
> > > embedded in the compound and is used directly in synchronous copies. The
> > > other is dynamically allocated, refcounted and tracked in the client
> > > struture. For the embedded one, the cleanup just involves releasing any
> > > nfsd_files held on its behalf. For the async one, the cleanup is a bit
> > > more involved, and we need to dequeue it from lists, unhash it, etc.
> > >
> > > There is at least one potential refcount leak in this code now. If the
> > > kthread_create call fails, then both the src and dst nfsd_files in the
> > > original nfsd4_copy object are leaked.
> >
> > I don't believe that's true. If kthread_create thread fails we call
> > cleanup_async_copy() that does a put on the file descriptors.
> >
>
> You mean this?
>
> out_err:
>         if (async_copy)
>                 cleanup_async_copy(async_copy);
>
> That puts the references that were taken in dup_copy_fields, but the
> original (embedded) nfsd4_copy also holds references and those are not
> being put in this codepath.

Can you please point out where do we take a reference on the original copy?

> > > The cleanup in this codepath is also sort of weird. In the async copy
> > > case, we'll have up to four nfsd_file references (src and dst for both
> > > flavors of copy structure).
> >
> > That's not true. There is a careful distinction between intra -- which
> > had 2 valid file pointers and does a get on both as they both point to
> > something that's opened on this server--- but inter -- only does a get
> > on the dst file descriptor, the src doesn't exit. And yes I realize
> > the code checks for nfs_src being null which it should be but it makes
> > the code less clear and at some point somebody might want to decide to
> > really do a put on it.
> >
>
> This is part of the problem here. We have a nfsd4_copy structure, and
> depending on what has been done to it, you need to call different
> methods to clean it up. That seems like a real antipattern to me.

But they call different methods because different things need to be
done there and it makes it clear what needs to be for what type of
copy.

> > > They are both put at the end of
> > > nfsd4_do_async_copy, even though the ones held on behalf of the embedded
> > > one outlive that structure.
> > >
> > > Change it so that we always clean up the nfsd_file refs held by the
> > > embedded copy structure before nfsd4_copy returns. Rework
> > > cleanup_async_copy to handle both inter and intra copies. Eliminate
> > > nfsd4_cleanup_intra_ssc since it now becomes a no-op.
> >
> > I feel by combining the cleanup for both it obscures a very important
> > destication that src filehandle doesn't exist for inter.
>
> If the src filehandle doesn't exist, then the pointer to it will be
> NULL. I don't see what we gain by keeping these two distinct, other than
> avoiding a NULL pointer check.

My reason would be for code clarity because different things are
supposed to happen for intra and inter. Difference of opinion it
seems.

>
> >
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
> > >  1 file changed, 10 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index 37a9cc8ae7ae..62b9d6c1b18b 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *nsui, struct file *filp,
> > >         long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
> > >
> > >         nfs42_ssc_close(filp);
> > > -       nfsd_file_put(dst);
> > >         fput(filp);
> > >
> > >         spin_lock(&nn->nfsd_ssc_lock);
> > > @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqstp,
> > >                                  &copy->nf_dst);
> > >  }
> > >
> > > -static void
> > > -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file *dst)
> > > -{
> > > -       nfsd_file_put(src);
> > > -       nfsd_file_put(dst);
> > > -}
> > > -
> > >  static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
> > >  {
> > >         struct nfsd4_cb_offload *cbo =
> > > @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
> > >         dst->ss_nsui = src->ss_nsui;
> > >  }
> > >
> > > +static void release_copy_files(struct nfsd4_copy *copy)
> > > +{
> > > +       if (copy->nf_src)
> > > +               nfsd_file_put(copy->nf_src);
> > > +       if (copy->nf_dst)
> > > +               nfsd_file_put(copy->nf_dst);
> > > +}
> > > +
> > >  static void cleanup_async_copy(struct nfsd4_copy *copy)
> > >  {
> > >         nfs4_free_copy_state(copy);
> > > -       nfsd_file_put(copy->nf_dst);
> > > -       if (!nfsd4_ssc_is_inter(copy))
> > > -               nfsd_file_put(copy->nf_src);
> > > +       release_copy_files(copy);
> > >         spin_lock(&copy->cp_clp->async_lock);
> > >         list_del(&copy->copies);
> > >         spin_unlock(&copy->cp_clp->async_lock);
> > > @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
> > >         } else {
> > >                 nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
> > >                                        copy->nf_dst->nf_file, false);
> > > -               nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
> > >         }
> > >
> > >  do_callback:
> > > @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >         } else {
> > >                 status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
> > >                                        copy->nf_dst->nf_file, true);
> > > -               nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
> > >         }
> > >  out:
> > > +       release_copy_files(copy);
> > >         return status;
> > >  out_err:
> > >         if (async_copy)
> > > --
> > > 2.39.0
> > >
>
> --
> Jeff Layton <jlayton@kernel.org>
