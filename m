Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C20672561
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjARRqK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjARRpb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:45:31 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4475CE7B
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:44:06 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 141so25089550pgc.0
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xkZZSI8mDX4J5x+7Ohm4OO2vu0LGTyS+CKaRsj3stUg=;
        b=mgCgdMQdKyrtWk14KL64XlUF+XV6YO6HM+FtBOTQZ4QslesPzWQLezw2JBNcoQ4BOq
         r6lxrKObATk+4DkwaytFxxMpOjDTzFViq1OOCcyD6vIjr8lVdqiuS5CFl8FrCZD8NinN
         bz1EBRoz3/I3ZvbTF6L2RlsyMsOFUs0r78/iY6y2AIvAn3Du4rcYu77P39N7Z9SQ8DB0
         pRIsf9bEHGa+4VzA3YfsLU5rQqtEtd0F3p/FQXXBumVHqY1crgMLAsCPdHwhzkWtjkDT
         IcfzVp3D2qrorUfRsa/8Cj0yCxPeiZOJOKonBxRlvS7gyrh9pzryYDiHvq8wGvSliAjI
         YGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkZZSI8mDX4J5x+7Ohm4OO2vu0LGTyS+CKaRsj3stUg=;
        b=j2QlCuowUx4lxidC2LfF9e8+yjJIePhb5Xn80lTBmVpsHNAh5MULYiVwvsSnOk8VoJ
         KgKtTWhVxgIvfLKqG5wOWpw941xbH5wKTKPEZ5T5d2YQp12cgeExi6+VE+6qHcbpSxOJ
         tjtRvHzpjZY8Z8RGOv5REimZAO8LmcY0JfUR2n2oO4qlRl74YEa8ORlbjxngSWO5E0Ru
         NyldM19npSUu0t3SHv5oGf133/JLtpD0IcRVflfBIsEKQieqZN5EZV0rqfTZu0/U50tC
         BO11tH+449jsBs3CWPn2ZF2O6ih7YmXqmPxKRzAbkfRIvopDpihrVjmGbZ/E0Gwk2BQU
         z93g==
X-Gm-Message-State: AFqh2koE7MV+KQ7wj7apCYi57+vTTbPdeQ3gbP918IaSa+6dGbwKpM4g
        B98L+DY8tw9vGMUQYPd4q025Yi1czKUhqV5iJAwcDEduYgI=
X-Google-Smtp-Source: AMrXdXt3rgXpJhIQKL9E9ob/BuU3rbATrr3iJH0qztk5/NaRQ6B55Q7GA2wLt3hwLpN6gSATEzzbjbxTGO2bXdntxkI=
X-Received: by 2002:aa7:82ca:0:b0:58d:c184:6a21 with SMTP id
 f10-20020aa782ca000000b0058dc1846a21mr735365pfn.29.1674063845028; Wed, 18 Jan
 2023 09:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20230118173139.71846-1-jlayton@kernel.org> <20230118173139.71846-2-jlayton@kernel.org>
In-Reply-To: <20230118173139.71846-2-jlayton@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 18 Jan 2023 12:43:53 -0500
Message-ID: <CAN-5tyHgYpGBaJYB932VAqyMGSMikexA=0uKTzROtP9nw=Nu-w@mail.gmail.com>
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

On Wed, Jan 18, 2023 at 12:35 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> We're not doing any blocking operations for OP_OFFLOAD_STATUS, so taking
> and putting a reference is a waste of effort. Take the client lock,
> search for the copy and fetch the wr_bytes_written field and return.
>
> Also, make find_async_copy a static function.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c | 35 ++++++++++++++++++++++++-----------
>  fs/nfsd/state.h    |  2 --
>  2 files changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 62b9d6c1b18b..731c2b22f163 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1823,23 +1823,34 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>         goto out;
>  }
>
> -struct nfsd4_copy *
> -find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
> +static struct nfsd4_copy *
> +find_async_copy_locked(struct nfs4_client *clp, stateid_t *stateid)
>  {
>         struct nfsd4_copy *copy;
>
> -       spin_lock(&clp->async_lock);
> +       lockdep_assert_held(&clp->async_lock);
> +
>         list_for_each_entry(copy, &clp->async_copies, copies) {
>                 if (memcmp(&copy->cp_stateid.cs_stid, stateid, NFS4_STATEID_SIZE))
>                         continue;
> -               refcount_inc(&copy->refcount);

If we don't take a refcount on the copy, this copy could be removed
between the time we found it in the list of copies and when we then
look inside to check the amount written so far. This would lead to a
null (or bad) pointer dereference?

> -               spin_unlock(&clp->async_lock);
>                 return copy;
>         }
> -       spin_unlock(&clp->async_lock);
>         return NULL;
>  }
>
> +static struct nfsd4_copy *
> +find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
> +{
> +       struct nfsd4_copy *copy;
> +
> +       spin_lock(&clp->async_lock);
> +       copy = find_async_copy_locked(clp, stateid);
> +       if (copy)
> +               refcount_inc(&copy->refcount);
> +       spin_unlock(&clp->async_lock);
> +       return copy;
> +}
> +
>  static __be32
>  nfsd4_offload_cancel(struct svc_rqst *rqstp,
>                      struct nfsd4_compound_state *cstate,
> @@ -1924,22 +1935,24 @@ nfsd4_fallocate(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>         nfsd_file_put(nf);
>         return status;
>  }
> +
>  static __be32
>  nfsd4_offload_status(struct svc_rqst *rqstp,
>                      struct nfsd4_compound_state *cstate,
>                      union nfsd4_op_u *u)
>  {
>         struct nfsd4_offload_status *os = &u->offload_status;
> -       __be32 status = 0;
> +       __be32 status = nfs_ok;
>         struct nfsd4_copy *copy;
>         struct nfs4_client *clp = cstate->clp;
>
> -       copy = find_async_copy(clp, &os->stateid);
> -       if (copy) {
> +       spin_lock(&clp->async_lock);
> +       copy = find_async_copy_locked(clp, &os->stateid);
> +       if (copy)
>                 os->count = copy->cp_res.wr_bytes_written;
> -               nfs4_put_copy(copy);
> -       } else
> +       else
>                 status = nfserr_bad_stateid;
> +       spin_unlock(&clp->async_lock);
>
>         return status;
>  }
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e94634d30591..d49d3060ed4f 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -705,8 +705,6 @@ extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name
>  extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn);
>
>  void put_nfs4_file(struct nfs4_file *fi);
> -extern struct nfsd4_copy *
> -find_async_copy(struct nfs4_client *clp, stateid_t *staetid);
>  extern void nfs4_put_cpntf_state(struct nfsd_net *nn,
>                                  struct nfs4_cpntf_state *cps);
>  extern __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> --
> 2.39.0
>
