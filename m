Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089ACB11E8
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 17:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbfILPOw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 11:14:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43072 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732698AbfILPOv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Sep 2019 11:14:51 -0400
Received: by mail-vs1-f66.google.com with SMTP id u21so16405606vsl.10
        for <linux-nfs@vger.kernel.org>; Thu, 12 Sep 2019 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07SsL4NNCezJsMJeyYEYBy9C7VkD7TKBf2fYsbgo7m4=;
        b=JxmBexubMmQu2W2JNSXjTw8tZYQtmXKq0opzkDOrossjWUZ9XTw3VTZ47Fdktk0rdf
         zSA6fiL+7QvrH3VFcRJ9ENIl8Se1mtNkqDg+r2b7IvoJTX2KKGB4rNf8o3EYnT5KcHub
         +PrzwgSc8MJtFxaIyLcI2y8eJRGO7xQVESE3HhXqfXy3OOLPetAH/urXsFMS/bd3WzGY
         yLDbP42CxLANhuSe2DnTm8EO6xc1RAYcDP0zBjEpc9Jle3/wONHoZ6oxRsLkzmvR+qzR
         gc8t7w+QJcPbQfj92qpb6Cd5oVeX6gFr6vFSX3e99P5dEtyFEpGNMeGebPHAuXsxxVmx
         vgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07SsL4NNCezJsMJeyYEYBy9C7VkD7TKBf2fYsbgo7m4=;
        b=VaCi7NAjadxszxB3h3vnTGacgFy+n45f0tvmsxwqagCJbKq3P4T870KulnM51D2KqW
         /taBWwMdWqpIpk9e4roAtxGB2UmSPcivj2mvMAMKIMitOSwwVTqFJsWkgd5pwqIJYZq4
         znXG/5BY0z7vXXg/a//yIYE60MBDoUvXLOfSqB0SDuIqfHHUtSJn/OVMWTBojFUkf6n3
         qqA9H2erJsEyNVgIVhUcxjrCm0XEfcGcAZ6vna4rkzhZgouDQOmM0xXi76aEjNt1LkN+
         T7Y86lbO+Q9hb3mhD+hy9ukmniQwaGxB21xjrevOKsCNB6xAIPfVMQh7Yy5yAg1Ymz2Y
         S98A==
X-Gm-Message-State: APjAAAXN0PKSMeN2SmSmgg/AgnkKW/VxO6Evv/LA7/GuSD1ESIixB/tT
        57UmY6G7R8DnMv5yPyaa3C0A8h3HfpcNsihcEs4=
X-Google-Smtp-Source: APXvYqx7jqTwQb+p2QxykdNZA/FLpaayeZONRjY9gXMx8Hf9nk+4dqkqur2RIiIFXCfaiJIv7uwOYrxj1ltT6XLd5fs=
X-Received: by 2002:a67:e298:: with SMTP id g24mr10073372vsf.164.1568301290188;
 Thu, 12 Sep 2019 08:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
 <20190909140104.78818-2-trond.myklebust@hammerspace.com> <20190909140104.78818-3-trond.myklebust@hammerspace.com>
 <20190909140104.78818-4-trond.myklebust@hammerspace.com> <20190909140104.78818-5-trond.myklebust@hammerspace.com>
 <20190909140104.78818-6-trond.myklebust@hammerspace.com>
In-Reply-To: <20190909140104.78818-6-trond.myklebust@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 12 Sep 2019 11:14:39 -0400
Message-ID: <CAN-5tyGOjTGft-rvqD7EzhCS9CK1dNKpUq9hRZTqs8ivLZ0_cg@mail.gmail.com>
Subject: Re: [PATCH 6/9] pNFS: Handle NFS4ERR_OLD_STATEID on layoutreturn by
 bumping the state seqid
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

Can you explain why are we just bumping the seqid by 1 instead of what
it was currently using to update it to the current value which could
be more than off by one? I'm just speculating that we'll see the same
behavior that we'll get the ERR_OLD_STATEID incremented by one until
the current value?

On Tue, Sep 10, 2019 at 4:09 AM Trond Myklebust <trondmy@gmail.com> wrote:
>
> If a LAYOUTRETURN receives a reply of NFS4ERR_OLD_STATEID then assume we've
> missed an update, and just bump the stateid.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4proc.c |  2 +-
>  fs/nfs/pnfs.c     | 18 ++++++++++++++----
>  fs/nfs/pnfs.h     |  4 ++--
>  3 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index a5deb00b5ad1..cbaf6b7ac128 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -9069,7 +9069,7 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
>         server = NFS_SERVER(lrp->args.inode);
>         switch (task->tk_status) {
>         case -NFS4ERR_OLD_STATEID:
> -               if (nfs4_layoutreturn_refresh_stateid(&lrp->args.stateid,
> +               if (nfs4_layout_refresh_old_stateid(&lrp->args.stateid,
>                                         &lrp->args.range,
>                                         lrp->args.inode))
>                         goto out_restart;
> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> index abc7188f1853..bb80034a7661 100644
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -359,9 +359,10 @@ pnfs_clear_lseg_state(struct pnfs_layout_segment *lseg,
>  }
>
>  /*
> - * Update the seqid of a layout stateid
> + * Update the seqid of a layout stateid after receiving
> + * NFS4ERR_OLD_STATEID
>   */
> -bool nfs4_layoutreturn_refresh_stateid(nfs4_stateid *dst,
> +bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
>                 struct pnfs_layout_range *dst_range,
>                 struct inode *inode)
>  {
> @@ -377,7 +378,15 @@ bool nfs4_layoutreturn_refresh_stateid(nfs4_stateid *dst,
>
>         spin_lock(&inode->i_lock);
>         lo = NFS_I(inode)->layout;
> -       if (lo && nfs4_stateid_match_other(dst, &lo->plh_stateid)) {
> +       if (lo &&  pnfs_layout_is_valid(lo) &&
> +           nfs4_stateid_match_other(dst, &lo->plh_stateid)) {
> +               /* Is our call using the most recent seqid? If so, bump it */
> +               if (!nfs4_stateid_is_newer(&lo->plh_stateid, dst)) {
> +                       nfs4_stateid_seqid_inc(dst);
> +                       ret = true;
> +                       goto out;
> +               }
> +               /* Try to update the seqid to the most recent */
>                 err = pnfs_mark_matching_lsegs_return(lo, &head, &range, 0);
>                 if (err != -EBUSY) {
>                         dst->seqid = lo->plh_stateid.seqid;
> @@ -385,6 +394,7 @@ bool nfs4_layoutreturn_refresh_stateid(nfs4_stateid *dst,
>                         ret = true;
>                 }
>         }
> +out:
>         spin_unlock(&inode->i_lock);
>         pnfs_free_lseg_list(&head);
>         return ret;
> @@ -1475,7 +1485,7 @@ int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
>                 *ret = -NFS4ERR_NOMATCHING_LAYOUT;
>                 return 0;
>         case -NFS4ERR_OLD_STATEID:
> -               if (!nfs4_layoutreturn_refresh_stateid(&arg->stateid,
> +               if (!nfs4_layout_refresh_old_stateid(&arg->stateid,
>                                         &arg->range, inode))
>                         break;
>                 *ret = -NFS4ERR_NOMATCHING_LAYOUT;
> diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
> index 3ef3756d437c..f8a38065c7e4 100644
> --- a/fs/nfs/pnfs.h
> +++ b/fs/nfs/pnfs.h
> @@ -261,7 +261,7 @@ int pnfs_destroy_layouts_byfsid(struct nfs_client *clp,
>                 bool is_recall);
>  int pnfs_destroy_layouts_byclid(struct nfs_client *clp,
>                 bool is_recall);
> -bool nfs4_layoutreturn_refresh_stateid(nfs4_stateid *dst,
> +bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
>                 struct pnfs_layout_range *dst_range,
>                 struct inode *inode);
>  void pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo);
> @@ -798,7 +798,7 @@ static inline void nfs4_pnfs_v3_ds_connect_unload(void)
>  {
>  }
>
> -static inline bool nfs4_layoutreturn_refresh_stateid(nfs4_stateid *dst,
> +static inline bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
>                 struct pnfs_layout_range *dst_range,
>                 struct inode *inode)
>  {
> --
> 2.21.0
>
