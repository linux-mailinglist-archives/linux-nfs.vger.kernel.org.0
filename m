Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347F9672023
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 15:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjAROub (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 09:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjAROuC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 09:50:02 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4987249563
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 06:42:31 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c6so37113874pls.4
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 06:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pizp2r2lZmHYuou8pB4fERm99DY4Qq8OG5RzEGpNWhQ=;
        b=GLaOJHdFXeanQJSD5RJfUzc8snP693ah4L6lO2Uph+qadwnjvKbYhJIP5Mxx/wlauv
         e6kgB3j+oMfZ/O+zFPtHI6HyOa8EhcmlwGUOG11MVLws4bvcFLRGSrm8tWACUAXkvq3t
         gJePT+QKIhl+P2QSx4Oz4xLd4CgdUaaDBXbOXJEhMLhXbUeeF4XSESObG42Z1QPQsh8J
         cG8V+tLq+F56Fkphgn6S6XPTa7FWR3AacHIOdPwNCbbJxhkG7+++XAKp81YixzwMHbue
         +dQcdBN1StSNWCseSNllCklUqHUyxjRWZba1MKinIdeo/NDFWRo7WP8dBPH4ss/3RT5S
         EAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pizp2r2lZmHYuou8pB4fERm99DY4Qq8OG5RzEGpNWhQ=;
        b=CcCjDvHzf2qR4w4N+ZH2vUb6KkuXjIDV8YaDAbzlJKagpUagQtsa26qRmZjIdkUcsY
         2CgKLhdFXNvjPwSxdNX1Dbx4AxmckA1WnkO/Q5QljgCssM8rWkPM41zNq1Y92bhuohtX
         9B3eoUJiPhygr0L0aG8I4B5Q9ep0n6vYP4izFkUyuylaE3hZiOWbpFwBE3BWpxq1Z7in
         aIgHXg0z+t8vrod8Dd49twTcgnEqZkDdF7v6/ImCqttvNPIr0QI8D+5i96Q21AXSZ/3C
         AE9yk5T2X2BHjL770+yRp1nLgbIBOzmPtZ1Ea2V47XyfNXMUkJQ8ncd54TjsXiWs0/4+
         P1GA==
X-Gm-Message-State: AFqh2kq1o2tKAG55LTaWW3E4HnOZvjGzQkGVeqYiQq8tRCH4aORFKUOk
        5bCMrFp9I5F2SBvofAWsTEHxhANSqX63jFVwcSc=
X-Google-Smtp-Source: AMrXdXt87oxC7iwkHgtzTh/23HehSOxbRTLPfRfzWT4Q5j13UYw4faDScGoOjMiWFnZAjeaf2lqrcCgDP3HknAUCFus=
X-Received: by 2002:a17:90a:d582:b0:213:9df5:43b2 with SMTP id
 v2-20020a17090ad58200b002139df543b2mr678604pju.86.1674052950931; Wed, 18 Jan
 2023 06:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20230117193831.75201-1-jlayton@kernel.org> <20230117193831.75201-3-jlayton@kernel.org>
In-Reply-To: <20230117193831.75201-3-jlayton@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 18 Jan 2023 09:42:19 -0500
Message-ID: <CAN-5tyHA6JgqnEorEqz1b3CLdbXWhT6hNZKXzgfZy3Fr_TdW7Q@mail.gmail.com>
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

On Tue, Jan 17, 2023 at 2:38 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> There are two different flavors of the nfsd4_copy struct. One is
> embedded in the compound and is used directly in synchronous copies. The
> other is dynamically allocated, refcounted and tracked in the client
> struture. For the embedded one, the cleanup just involves releasing any
> nfsd_files held on its behalf. For the async one, the cleanup is a bit
> more involved, and we need to dequeue it from lists, unhash it, etc.
>
> There is at least one potential refcount leak in this code now. If the
> kthread_create call fails, then both the src and dst nfsd_files in the
> original nfsd4_copy object are leaked.

I don't believe that's true. If kthread_create thread fails we call
cleanup_async_copy() that does a put on the file descriptors.

> The cleanup in this codepath is also sort of weird. In the async copy
> case, we'll have up to four nfsd_file references (src and dst for both
> flavors of copy structure).

That's not true. There is a careful distinction between intra -- which
had 2 valid file pointers and does a get on both as they both point to
something that's opened on this server--- but inter -- only does a get
on the dst file descriptor, the src doesn't exit. And yes I realize
the code checks for nfs_src being null which it should be but it makes
the code less clear and at some point somebody might want to decide to
really do a put on it.

> They are both put at the end of
> nfsd4_do_async_copy, even though the ones held on behalf of the embedded
> one outlive that structure.
>
> Change it so that we always clean up the nfsd_file refs held by the
> embedded copy structure before nfsd4_copy returns. Rework
> cleanup_async_copy to handle both inter and intra copies. Eliminate
> nfsd4_cleanup_intra_ssc since it now becomes a no-op.

I feel by combining the cleanup for both it obscures a very important
destication that src filehandle doesn't exist for inter.

> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 37a9cc8ae7ae..62b9d6c1b18b 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1512,7 +1512,6 @@ nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *nsui, struct file *filp,
>         long timeout = msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>
>         nfs42_ssc_close(filp);
> -       nfsd_file_put(dst);
>         fput(filp);
>
>         spin_lock(&nn->nfsd_ssc_lock);
> @@ -1562,13 +1561,6 @@ nfsd4_setup_intra_ssc(struct svc_rqst *rqstp,
>                                  &copy->nf_dst);
>  }
>
> -static void
> -nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file *dst)
> -{
> -       nfsd_file_put(src);
> -       nfsd_file_put(dst);
> -}
> -
>  static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
>  {
>         struct nfsd4_cb_offload *cbo =
> @@ -1683,12 +1675,18 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
>         dst->ss_nsui = src->ss_nsui;
>  }
>
> +static void release_copy_files(struct nfsd4_copy *copy)
> +{
> +       if (copy->nf_src)
> +               nfsd_file_put(copy->nf_src);
> +       if (copy->nf_dst)
> +               nfsd_file_put(copy->nf_dst);
> +}
> +
>  static void cleanup_async_copy(struct nfsd4_copy *copy)
>  {
>         nfs4_free_copy_state(copy);
> -       nfsd_file_put(copy->nf_dst);
> -       if (!nfsd4_ssc_is_inter(copy))
> -               nfsd_file_put(copy->nf_src);
> +       release_copy_files(copy);
>         spin_lock(&copy->cp_clp->async_lock);
>         list_del(&copy->copies);
>         spin_unlock(&copy->cp_clp->async_lock);
> @@ -1748,7 +1746,6 @@ static int nfsd4_do_async_copy(void *data)
>         } else {
>                 nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>                                        copy->nf_dst->nf_file, false);
> -               nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>         }
>
>  do_callback:
> @@ -1811,9 +1808,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>         } else {
>                 status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
>                                        copy->nf_dst->nf_file, true);
> -               nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
>         }
>  out:
> +       release_copy_files(copy);
>         return status;
>  out_err:
>         if (async_copy)
> --
> 2.39.0
>
