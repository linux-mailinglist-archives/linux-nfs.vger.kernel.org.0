Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FE0672657
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 19:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjARSKL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 13:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjARSJc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 13:09:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5167111E8B
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 10:09:06 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id bj3so33414436pjb.0
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 10:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qNsxJk0j3aPPluX/e85E8h5/q6OYK6BnrTUmaQ93BUM=;
        b=FanISyWTItdOsDW52R25/h9Nxsg+IYpQRQCH/hzEzYJh+BRPlnqdMxgQgoCPqd/MIo
         Bb9fScSGe0sn79uDDQYp6ZhNAH3P6CAdMdy1iaEphCB+ZKN6/uFg7yXLeSbY/WBeqLgl
         DhtlW/z/kM6nbZh850P+6i/OGbteH2PWWMElIo5Oj4G3yKc1WU+l4UsE0VTOVScxPCJH
         u7zobUJZutW/yS4BuxO8rrg9R0PijPc7TCWGgAtO+cuDgusmYLFQq3RF++tiKFaKsgAC
         KEQ5syIYSIgyZIV5Uzv8jMBs8yUxPSk0SAzS2ncUTS0YjgSQ3YlgOHDLKOj430/RWgIs
         Jgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNsxJk0j3aPPluX/e85E8h5/q6OYK6BnrTUmaQ93BUM=;
        b=VU7cHKTooCqr89o0/Woka9etxftasJuKrzRlDXOcoiczCoGlG6SiarotGiXooZBNX1
         VZFgDBTRuUogV6hPiGNC8kDoFSWx5Hv+eK5U2/RPoN5RmshNNfKr8t/u/vqFJlS+GLO7
         7Qnc8lxz1QeOx/9BhiRks/r3I1ucNApVWij0bWUGSY4IdTeHkk0ANCMXK1H1BA71vnGv
         54b3RrE1nPOYiZoyOdsF9Fd0IBWtI+DeAyxCU7JImWVkEhtXfg9Cvkmt1ebZUtiwl/wL
         zEpvKRwIli79xd+Kmib/pL67uqoJnjU/z6aND1tVxv/fyqs6iyuiy4c6Qq1TwI6cIkf8
         BwaA==
X-Gm-Message-State: AFqh2krxWwap13y41CyfCialD23hJ5mGblbEbGs1RsHVRU4JbAHRLNkD
        q9e1g+awMAkiuz8dlRiqCDp/7TJCie9FjgsbKlc=
X-Google-Smtp-Source: AMrXdXvgshXHXq8emQZ2qidyevuTvNYzBShMk5CCgpdEwxyd0A9mwqXiSzEmusvxCAOUiYfkF4+khs6HKgCxlGiJ/0k=
X-Received: by 2002:a17:90a:d582:b0:213:9df5:43b2 with SMTP id
 v2-20020a17090ad58200b002139df543b2mr748572pju.86.1674065345780; Wed, 18 Jan
 2023 10:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20230118173139.71846-1-jlayton@kernel.org> <20230118173139.71846-2-jlayton@kernel.org>
 <CAN-5tyHgYpGBaJYB932VAqyMGSMikexA=0uKTzROtP9nw=Nu-w@mail.gmail.com> <944bf7f3e6956989933d07aabd4a632de2ec4667.camel@kernel.org>
In-Reply-To: <944bf7f3e6956989933d07aabd4a632de2ec4667.camel@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 18 Jan 2023 13:08:54 -0500
Message-ID: <CAN-5tyHnhk9sV-jfnDvQ66brYtqY7NPvsq3D1-hWe7vYUxjgUQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] nfsd: don't take nfsd4_copy ref for OP_OFFLOAD_STATUS
To:     Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
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

On Wed, Jan 18, 2023 at 12:49 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Wed, 2023-01-18 at 12:43 -0500, Olga Kornievskaia wrote:
> > On Wed, Jan 18, 2023 at 12:35 PM Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > We're not doing any blocking operations for OP_OFFLOAD_STATUS, so taking
> > > and putting a reference is a waste of effort. Take the client lock,
> > > search for the copy and fetch the wr_bytes_written field and return.
> > >
> > > Also, make find_async_copy a static function.
> > >
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/nfs4proc.c | 35 ++++++++++++++++++++++++-----------
> > >  fs/nfsd/state.h    |  2 --
> > >  2 files changed, 24 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index 62b9d6c1b18b..731c2b22f163 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -1823,23 +1823,34 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >         goto out;
> > >  }
> > >
> > > -struct nfsd4_copy *
> > > -find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
> > > +static struct nfsd4_copy *
> > > +find_async_copy_locked(struct nfs4_client *clp, stateid_t *stateid)
> > >  {
> > >         struct nfsd4_copy *copy;
> > >
> > > -       spin_lock(&clp->async_lock);
> > > +       lockdep_assert_held(&clp->async_lock);
> > > +
> > >         list_for_each_entry(copy, &clp->async_copies, copies) {
> > >                 if (memcmp(&copy->cp_stateid.cs_stid, stateid, NFS4_STATEID_SIZE))
> > >                         continue;
> > > -               refcount_inc(&copy->refcount);
> >
> > If we don't take a refcount on the copy, this copy could be removed
> > between the time we found it in the list of copies and when we then
> > look inside to check the amount written so far. This would lead to a
> > null (or bad) pointer dereference?
> >
>
> No. The existing code finds this object, takes a reference to it,
> fetches a single integer out of it and then puts the reference. This
> patch just has it avoid the reference altogether and fetch the value
> while we still hold the spinlock. This should be completely safe
> (assuming the locking around the existing list handling is correct,
> which it does seem to be).

Thank you for the explanation. I see it now.

>
>
> > > -               spin_unlock(&clp->async_lock);
> > >                 return copy;
> > >         }
> > > -       spin_unlock(&clp->async_lock);
> > >         return NULL;
> > >  }
> > >
> > > +static struct nfsd4_copy *
> > > +find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
> > > +{
> > > +       struct nfsd4_copy *copy;
> > > +
> > > +       spin_lock(&clp->async_lock);
> > > +       copy = find_async_copy_locked(clp, stateid);
> > > +       if (copy)
> > > +               refcount_inc(&copy->refcount);
> > > +       spin_unlock(&clp->async_lock);
> > > +       return copy;
> > > +}
> > > +
> > >  static __be32
> > >  nfsd4_offload_cancel(struct svc_rqst *rqstp,
> > >                      struct nfsd4_compound_state *cstate,
> > > @@ -1924,22 +1935,24 @@ nfsd4_fallocate(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >         nfsd_file_put(nf);
> > >         return status;
> > >  }
> > > +
> > >  static __be32
> > >  nfsd4_offload_status(struct svc_rqst *rqstp,
> > >                      struct nfsd4_compound_state *cstate,
> > >                      union nfsd4_op_u *u)
> > >  {
> > >         struct nfsd4_offload_status *os = &u->offload_status;
> > > -       __be32 status = 0;
> > > +       __be32 status = nfs_ok;
> > >         struct nfsd4_copy *copy;
> > >         struct nfs4_client *clp = cstate->clp;
> > >
> > > -       copy = find_async_copy(clp, &os->stateid);
> > > -       if (copy) {
> > > +       spin_lock(&clp->async_lock);
> > > +       copy = find_async_copy_locked(clp, &os->stateid);
> > > +       if (copy)
> > >                 os->count = copy->cp_res.wr_bytes_written;
> > > -               nfs4_put_copy(copy);
> > > -       } else
> > > +       else
> > >                 status = nfserr_bad_stateid;
> > > +       spin_unlock(&clp->async_lock);
> > >
> > >         return status;
> > >  }
> > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > index e94634d30591..d49d3060ed4f 100644
> > > --- a/fs/nfsd/state.h
> > > +++ b/fs/nfsd/state.h
> > > @@ -705,8 +705,6 @@ extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name
> > >  extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn);
> > >
> > >  void put_nfs4_file(struct nfs4_file *fi);
> > > -extern struct nfsd4_copy *
> > > -find_async_copy(struct nfs4_client *clp, stateid_t *staetid);
> > >  extern void nfs4_put_cpntf_state(struct nfsd_net *nn,
> > >                                  struct nfs4_cpntf_state *cps);
> > >  extern __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> > > --
> > > 2.39.0
> > >
>
> --
> Jeff Layton <jlayton@kernel.org>
