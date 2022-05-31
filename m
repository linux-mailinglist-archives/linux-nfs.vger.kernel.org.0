Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535C65394AB
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 18:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbiEaQDu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 12:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242921AbiEaQDt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 12:03:49 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECFC8DDD4
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 09:03:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er5so18171344edb.12
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kp9bri9T4w/eSfrUFdXjOcXQN8ENEw3TZ9nNVfG2xH8=;
        b=Pstp90sfkEiiXpT80X+u+9GsWJ3bYq6N2ExSUW8G213ZB8ElWZ+k3IZqtjqsmcWCDM
         fjyZsDwyiu4u4VsBySFxJg0Ea1pq6QctndBOyaLJGBxFVxpKdnlPKXaS9oUtuiA94YL9
         i5mwjxWWEVf3Jn7D2M0Ai3onA1+fBUqzn5nlUS+qu0iNPyyxjVEwTb6tHB+dwSTlveiY
         o8gx6qYoKvoruOmF1a5RoKrJunkZ3rmteudme84sax9ZE+d3l1KWPkTQDp3l8Z65ekL+
         fWCAka1n+KdfiU74KIfzR3RqyaV0KHAZJZt0Rhqk43rkNk3ZnsYGi5X2Yhizp2up8UEV
         zP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kp9bri9T4w/eSfrUFdXjOcXQN8ENEw3TZ9nNVfG2xH8=;
        b=zgr5hIwMmiMWZUYP2VekOrCenZ4aL5QbDaEiRC4MDKGEIQognGi2C4JlsmTkCaqu3N
         lxFHI8Wt0kJIWuQvr7+cIHDNV46y6wbECK06oHMJulR1LRjO0bviqPXdJIhqPsksR9eh
         M0V5h6xjs+sLDNOk7lTRpTKMoGGuH5MkOSTUOJuPCkB9itbyURNB5J58kOTmpfkGFNSy
         bZPjlfPSTpilRqcZG9idLT1vprHYbkDkMAZLWJIS7scgM3xQV7QANw+oKCGKEljzTHfI
         u4p7LxLxS4sfa3CTz0HddT8qcUw1TzCyaqLPNzZnYDmk4T1hHAHr3u6DN2bqRvPL5J7q
         croQ==
X-Gm-Message-State: AOAM530r0BlAcZC4/aJJ1B3r7HKR/G2djceQ2/wbGodkTDW8PWyJ30K/
        JphuvggyVb0Cmk04zYPU9gSlTnp6bO3sx7rUrdjITpH5Ses=
X-Google-Smtp-Source: ABdhPJz//YHZ4lqVR8EjtFVAORkNGMwUG4QCJ+8LGO4NycJYYigHUjfbQEq1We9jaKXkxPeHUNJ07dCeiV7AKq6lYCI=
X-Received: by 2002:aa7:d143:0:b0:42d:ca9c:aa76 with SMTP id
 r3-20020aa7d143000000b0042dca9caa76mr15408152edo.163.1654013026373; Tue, 31
 May 2022 09:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220531134854.63115-1-olga.kornievskaia@gmail.com> <b829962068bf70b5aadcb16fd0265ec64c85f853.camel@hammerspace.com>
In-Reply-To: <b829962068bf70b5aadcb16fd0265ec64c85f853.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 31 May 2022 12:03:34 -0400
Message-ID: <CAN-5tyGF56-spgEcwLV2cfw4KnNfO_ru9tRH9i_mMh+wmC+cTg@mail.gmail.com>
Subject: Re: [PATCH] pNFS: fix IO thread starvation problem during
 LAYOUTUNAVAILABLE error
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 31, 2022 at 11:00 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
> On Tue, 2022-05-31 at 09:48 -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > In recent pnfs testing we've incountered IO thread starvation problem
> > during the time when the server returns LAYOUTUNAVAILABLE error to
> > the
> > client. When that happens each IO request tries to get a new layout
> > and the pnfs_update_layout() code ensures that only 1 LAYOUTGET
> > RPC is outstanding, the rest would be waiting. As the thread that
> > gets
> > the layout wakes up the waiters only one gets to run and it tends to
> > be
> > the latest added to the waiting queue. After receiving
> > LAYOUTUNAVAILABLE
> > error the client would fall back to the MDS writes and as those
> > writes
> > complete and the new write is issued, those requests are added as
> > waiters and they get to run before the earliest of the waiters that
> > was put on the queue originally never gets to run until the
> > LAYOUTUNAVAILABLE condition resolves itself on the server.
> >
> > With the current code, if N IOs arrive asking for a layout, then
> > there will be N serial LAYOUTGETs that will follow, each would be
> > getting its own LAYOUTUNAVAILABLE error. Instead, the patch proposes
> > to apply the error condition to ALL the waiters for the outstanding
> > LAYOUTGET. Once the error is received, the code would allow all
> > exiting N IOs fall back to the MDS, but any new arriving IOs would be
> > then queued up and one them the new IO would trigger a new LAYOUTGET.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/pnfs.c | 14 +++++++++++++-
> >  fs/nfs/pnfs.h |  2 ++
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> > index 68a87be3e6f9..5b7a679e32c8 100644
> > --- a/fs/nfs/pnfs.c
> > +++ b/fs/nfs/pnfs.c
> > @@ -2028,10 +2028,20 @@ pnfs_update_layout(struct inode *ino,
> >         if ((list_empty(&lo->plh_segs) || !pnfs_layout_is_valid(lo))
> > &&
> >             atomic_read(&lo->plh_outstanding) != 0) {
> >                 spin_unlock(&ino->i_lock);
> > +               atomic_inc(&lo->plh_waiting);
> >                 lseg = ERR_PTR(wait_var_event_killable(&lo-
> > >plh_outstanding,
> >                                         !atomic_read(&lo-
> > >plh_outstanding)));
> > -               if (IS_ERR(lseg))
> > +               if (IS_ERR(lseg)) {
> > +                       atomic_dec(&lo->plh_waiting);
> >                         goto out_put_layout_hdr;
> > +               }
> > +               if (test_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags)) {
> > +                       pnfs_layout_clear_fail_bit(lo,
> > pnfs_iomode_to_fail_bit(iomode));
> > +                       lseg = NULL;
> > +                       if (atomic_dec_and_test(&lo->plh_waiting))
> > +                               clear_bit(NFS_LAYOUT_DRAIN, &lo-
> > >plh_flags);
> > +                       goto out_put_layout_hdr;
> > +               }
> >                 pnfs_put_layout_hdr(lo);
> >                 goto lookup_again;
> >         }
> > @@ -2152,6 +2162,8 @@ pnfs_update_layout(struct inode *ino,
> >                 case -ERECALLCONFLICT:
> >                 case -EAGAIN:
> >                         break;
> > +               case -ENODATA:
> > +                       set_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
> >                 default:
> >                         if (!nfs_error_is_fatal(PTR_ERR(lseg))) {
> >                                 pnfs_layout_clear_fail_bit(lo,
> > pnfs_iomode_to_fail_bit(iomode));
> > diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
> > index 07f11489e4e9..5c07da32320b 100644
> > --- a/fs/nfs/pnfs.h
> > +++ b/fs/nfs/pnfs.h
> > @@ -105,6 +105,7 @@ enum {
> >         NFS_LAYOUT_FIRST_LAYOUTGET,     /* Serialize first layoutget
> > */
> >         NFS_LAYOUT_INODE_FREEING,       /* The inode is being freed
> > */
> >         NFS_LAYOUT_HASHED,              /* The layout visible */
> > +       NFS_LAYOUT_DRAIN,
> >  };
> >
> >  enum layoutdriver_policy_flags {
> > @@ -196,6 +197,7 @@ struct pnfs_commit_ops {
> >  struct pnfs_layout_hdr {
> >         refcount_t              plh_refcount;
> >         atomic_t                plh_outstanding; /* number of RPCs
> > out */
> > +       atomic_t                plh_waiting;
> >         struct list_head        plh_layouts;   /* other client
> > layouts */
> >         struct list_head        plh_bulk_destroy;
> >         struct list_head        plh_segs;      /* layout segments
> > list */
>
> According to the spec, the correct behaviour for handling
> NFS4ERR_LAYOUTUNAVAILABLE is to stop trying to do pNFS to the inode,
> and to fall back to doing I/O through the MDS. The error describes a
> more or less permanent state of the server being unable to hand out a
> layout for this file.
> If the server wanted the clients to retry after a delay, it should be
> returning NFS4ERR_LAYOUTTRYLATER. We already handle that correctly.

To clarify, can you confirm that LAYOUTUNAVAILABLE would only turn off
the inode permanently but for a period of time?

It looks to me that for the LAYOUTTRYLATER, the client would face the
same starvation problem in the same situation. I don't see anything
marking the segment failed for such error? I believe the client
returns nolayout for that error, falls back to MDS but allows asking
for the layout for a period of time, having again the queue of waiters
that gets manipulated as such that favors last added.


> Currently, what our client does to handle NFS4ERR_LAYOUTUNAVAILABLE is
> just plain wrong: we just return no layout, and then let the next
> caller to pnfs_update_layout() immediately try again.
>
> My problem with this patch, is that it just falls back to doing I/O
> through the MDS for the writes that are already queued in
> pnfs_update_layout(). It perpetuates the current bad behaviour of
> unnecessary pounding of the server with LAYOUTGET requests that are
> going to fail with the exact same error.
>
> I'd therefore prefer to see us fix the real bug (i.e. the handling of
> NFS4ERR_LAYOUTUNAVAILABLE) first, and then look at mitigating issues
> with the queuing. I already have 2 patches to deal with this.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
