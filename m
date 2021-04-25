Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056CE36A7AD
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Apr 2021 16:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhDYOGR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Apr 2021 10:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhDYOGQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Apr 2021 10:06:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91953C061574
        for <linux-nfs@vger.kernel.org>; Sun, 25 Apr 2021 07:05:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e7so62566971edu.10
        for <linux-nfs@vger.kernel.org>; Sun, 25 Apr 2021 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zv7L+2FnAzPAVTwuA/Uo/jsa/QGE7CR8iJQRAKnkWHU=;
        b=lQwQpuw+w5zeKx4TVgg8VKDWnz7TmkO/s8/Ejuan8aZny7qDJJktU34U5+cpWuxxl+
         JvE9JW1ogWcqPtIxM/jEeRY+soRzex3QuhuwJVNNWcoqYo0U4ofl1OnRE+yHoxd73A96
         DSbdwvYkVQ8M2aDbS8/SkqbxAgraXWIRS4fNUXWjysMnrwZ9yfwiL50F3mIqRKDugoVv
         B0rI9XNjC5bZItD++YWlXrDh48MTyvDswnD9GoguEDgByAKyC63cU6q6aZs0Kew5EI60
         l1zEprEPsE+ur78cWo5RrTMGKgaSlT95q+zNF2EHSyayyGAO8OwUFDcrs5EkuZRcuH3P
         GDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zv7L+2FnAzPAVTwuA/Uo/jsa/QGE7CR8iJQRAKnkWHU=;
        b=Qaa1Sq2kyfjsmU21mXd03ZG3iW/ZHL14u3M/5l8SCWO7A5jvyS5Am5pyvIhI5VNTbi
         sYapMpzSsnqilP47EytT91xDEKdrklBlAVNG0M2GLM9MOxZkXkllit66gA2e1mUVAy5M
         cDXV2qgT3rsdfumSSk7hOz51DW+ZdLjyDNGc7Y/qTuGwTmC47PZpShEMYf/9dXDxojJq
         QWzyLdRO/PxQqnfnppkQjURvKwLTXqaK3XRBzS8MpEkyRHyMhP3SrfS4zJqiT6BQgHyB
         iXmpOIR0C7FE9Pa4N3M2q7JvK6q0c23lEWoxLPuRj0TmJkkwcNT7wXSVRSAT4kPrvZpc
         Y0Kw==
X-Gm-Message-State: AOAM533XFqbGoFwKGoY6n4Xu1BKsctuLCo4omJ2T5igbQkJCZgxCVTnF
        1KPmzAky0GogMHTUV8mWjKbJ4T0wweCAl2Vp+u0=
X-Google-Smtp-Source: ABdhPJw7kbZjP2n25bQ5FXCFx5Co8pJcicV9HVcgGB2+TNR1CBI57ZnjZZEnpKGxlZoSA+iMUWGeBTta9dN65UoVcbo=
X-Received: by 2002:a05:6402:3591:: with SMTP id y17mr15776771edc.67.1619359534075;
 Sun, 25 Apr 2021 07:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210422202908.60995-1-olga.kornievskaia@gmail.com> <A38B105D-D6DF-43CE-A9D9-C97B98E3B967@oracle.com>
In-Reply-To: <A38B105D-D6DF-43CE-A9D9-C97B98E3B967@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Sun, 25 Apr 2021 10:05:22 -0400
Message-ID: <CAN-5tyF-6LrgwLpZf_nRPHHRJ-w2zQkS3swtVkQKbMSfH6E2aw@mail.gmail.com>
Subject: Re: [RFC v2 1/1] NFSD add vfs_fsync after async copy is done
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Apr 24, 2021 at 1:52 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Hi Olga-
>
> > On Apr 22, 2021, at 4:29 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Currently, the server does all copies as NFS_UNSTABLE. For synchronous
> > copies linux client will append a COMMIT to the COPY compound but for
> > async copies it does not (because COMMIT needs to be done after all
> > bytes are copied and not as a reply to the COPY operation).
> >
> > However, in order to save the client doing a COMMIT as a separate
> > rpc, the server can reply back with NFS_FILE_SYNC copy. This patch
> > proposed to add vfs_fsync() call at the end of the async copy.
>
> I'm having trouble understanding the description. Are you saying
> the client does a COPY then a COMMIT, or that the source server
> is doing WRITEs and then a COMMIT? Just suggesting a little more
> clarity (or an ASCII diagram) might help the weary reviewer.

Client is doing a COMMIT after receiving the reply of the asynchronous
copy in the CB_OFFLOAD where the server indicates that copy was done
as NFS_UNSTABLE. If the server replied that the copy was done as
NFS_FILE_SYNC, then the client wouldn't need to send the additional
COMMIT rpc. That's what this patch proposes to do. The disadvantage to
this approach is that if some other implementation has a design where
multiple copies are sent to satisfy a larger copy then that
implementation might prefer to do a single commit later. But a linux
client only sends a whole copy that was requested by the application
which is always followed then by COMMIT so to me it makes sense to say
the round trip and do the copy with fsync.

> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> > fs/nfsd/nfs4proc.c | 23 ++++++++++++++++++-----
> > 1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 66dea2f1eed8..f63a2cb14a5e 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1536,19 +1536,21 @@ static const struct nfsd4_callback_ops nfsd4_cb_offload_ops = {
> >       .done = nfsd4_cb_offload_done
> > };
> >
> > -static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
> > +static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync,
> > +                             bool committed)
> > {
> > -     copy->cp_res.wr_stable_how = NFS_UNSTABLE;
> > +     copy->cp_res.wr_stable_how = committed ? NFS_FILE_SYNC : NFS_UNSTABLE;
> >       copy->cp_synchronous = sync;
> >       gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
> > }
> >
> > -static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
> > +static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy, bool *committed)
>
> Nit: Instead of adding an output parameter, would it make sense
> to add the boolean to struct nfsd4_copy?

Sure thing.

> > {
> >       ssize_t bytes_copied = 0;
> >       size_t bytes_total = copy->cp_count;
> >       u64 src_pos = copy->cp_src_pos;
> >       u64 dst_pos = copy->cp_dst_pos;
> > +     __be32 status;
> >
> >       do {
> >               if (kthread_should_stop())
> > @@ -1563,6 +1565,16 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
> >               src_pos += bytes_copied;
> >               dst_pos += bytes_copied;
> >       } while (bytes_total > 0 && !copy->cp_synchronous);
> > +     /* for a non-zero asynchronous copy do a commit of data */
> > +     if (!copy->cp_synchronous && copy->cp_res.wr_bytes_written > 0) {
> > +             down_write(&copy->nf_dst->nf_rwsem);
> > +             status = vfs_fsync_range(copy->nf_dst->nf_file,
> > +                                      copy->cp_dst_pos,
> > +                                      copy->cp_res.wr_bytes_written, 0);
> > +             up_write(&copy->nf_dst->nf_rwsem);
> > +             if (!status)
> > +                     *committed = true;
> > +     }
> >       return bytes_copied;
> > }
> >
> > @@ -1570,15 +1582,16 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
> > {
> >       __be32 status;
> >       ssize_t bytes;
> > +     bool committed = false;
> >
> > -     bytes = _nfsd_copy_file_range(copy);
> > +     bytes = _nfsd_copy_file_range(copy, &committed);
> >       /* for async copy, we ignore the error, client can always retry
> >        * to get the error
> >        */
> >       if (bytes < 0 && !copy->cp_res.wr_bytes_written)
> >               status = nfserrno(bytes);
> >       else {
> > -             nfsd4_init_copy_res(copy, sync);
> > +             nfsd4_init_copy_res(copy, sync, committed);
> >               status = nfs_ok;
> >       }
> >
> > --
> > 2.27.0
> >
>
> --
> Chuck Lever
>
>
>
