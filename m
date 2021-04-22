Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87E63685E1
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 19:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbhDVR2s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Apr 2021 13:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhDVR2r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Apr 2021 13:28:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940F3C06174A
        for <linux-nfs@vger.kernel.org>; Thu, 22 Apr 2021 10:28:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cq11so10800395edb.0
        for <linux-nfs@vger.kernel.org>; Thu, 22 Apr 2021 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGR375qZiVlpZ6O7p+rVUvDDj092xnOtFt0/wMvyCwI=;
        b=ZGMFaApwYhr1IvT6t2QyIv8/+PiwvCkmVVJ0zZlIu9NmPkcfDRKGYXlrRiJvFo3xQl
         /vf/ydywcKKx42WSI/YSY2qu5fQ6uPUSsuABjQtPjJzZtg3eZt+7XbX40HZVC/tNcMzm
         8yAOpXjh0ycPmNVSr6UcfMnxbmyPmNXnJPdarTVBE+gjWuJDeW0CPyVWjlUlO/tHRr7Y
         UJrm36sZoUHC1aRLacdkz82zAXVXpIfCnK+/vkpDQ9cBgm1Q/STGeij9u6Bvebg9J1a8
         wqmLn+r2IG4Hka/JU98iJcyy4zKU0cmBQa8iXM6YgzU56/60NURV78yaCNsU3YCQGhVk
         JyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGR375qZiVlpZ6O7p+rVUvDDj092xnOtFt0/wMvyCwI=;
        b=ZKbzBcEXOiuEm3Wx/BxhfCM41mqSeCNHln4lAwumzn9CFUaNjsABJNFXAjri/mlT4l
         8Oa3LyyMZqs8QBjgar222AirDjxtTnqJm062+QV4Pv/EsZoMBsFWbmsJ5jU6SZsrvf3W
         iwIwCpNir5zM6wL+sG/OQ4vHQQjI8DeHDAki+W5rqZKKlw5HHq1mjnbd00qkjiyZXVgL
         C2tXOULVK77hjuxz3ZKnwbm8xiRke2DFP/XJf2gi986kooeH/HUXt0vCUCnMktR5Nh6J
         GEWbaXE3W9dI6uTc4YrPCOtR+Rzycnsv786QSk0PjV/K5Yw8fMhiqDRhywUXLxdNvNi7
         Zmuw==
X-Gm-Message-State: AOAM531Hmsr7UUpfuAzd9S/EFUKySmhRlZoQpq+egngmBYN2XMkgIpfb
        trn8JdkH3pzDRD3mYbGaYUQAfyQsAhIxYPHPh4m5Ak7X
X-Google-Smtp-Source: ABdhPJyx8205OGsHqdjNEwIputwkjfu9YaY5C39IBzkjKfy24vL9ps137K66dBBmGrXhVe/3GGsK1B16P1rkXy1uLm0=
X-Received: by 2002:a05:6402:31ac:: with SMTP id dj12mr5275020edb.267.1619112489310;
 Thu, 22 Apr 2021 10:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210422161922.56080-1-olga.kornievskaia@gmail.com> <22046fa4-730f-4e08-cfd8-eadc5fe098b3@oracle.com>
In-Reply-To: <22046fa4-730f-4e08-cfd8-eadc5fe098b3@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 22 Apr 2021 13:27:58 -0400
Message-ID: <CAN-5tyFbwOmyeTw7iY9M2GaofSpz03ui3nFNUPM8HkaHqv1D9g@mail.gmail.com>
Subject: Re: [RFC 1/1] NFSD add vfs_fsync after async copy is done
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 22, 2021 at 12:54 PM <dai.ngo@oracle.com> wrote:
>
>
> On 4/22/21 9:19 AM, Olga Kornievskaia wrote:
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
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >   fs/nfsd/nfs4proc.c | 22 +++++++++++++++++-----
> >   1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 66dea2f1eed8..c6f45f67d59b 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1536,19 +1536,21 @@ static const struct nfsd4_callback_ops nfsd4_cb_offload_ops = {
> >       .done = nfsd4_cb_offload_done
> >   };
> >
> > -static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
> > +static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync,
> > +                             bool committed)
> >   {
> > -     copy->cp_res.wr_stable_how = NFS_UNSTABLE;
> > +     copy->cp_res.wr_stable_how = committed ? NFS_FILE_SYNC : NFS_UNSTABLE;
> >       copy->cp_synchronous = sync;
> >       gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
> >   }
> >
> > -static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
> > +static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy, bool *committed)
> >   {
> >       ssize_t bytes_copied = 0;
> >       size_t bytes_total = copy->cp_count;
> >       u64 src_pos = copy->cp_src_pos;
> >       u64 dst_pos = copy->cp_dst_pos;
> > +     __be32 status;
> >
> >       do {
> >               if (kthread_should_stop())
> > @@ -1563,6 +1565,15 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
> >               src_pos += bytes_copied;
> >               dst_pos += bytes_copied;
> >       } while (bytes_total > 0 && !copy->cp_synchronous);
> > +     /* for a non-zero asynchronous copy do a commit of data */
> > +     if (!copy->cp_synchronous && bytes_copied > 0) {
>
> I think (bytes_copied > 0) should be (bytes_total < copy->cp_count).

I don't think so. A successful async copy should never be less the
requested bytes.

>
> -Dai
>
> > +             down_write(&copy->nf_dst->nf_rwsem);
> > +             status = vfs_fsync_range(copy->nf_dst->nf_file,
> > +                                      copy->cp_dst_pos, bytes_copied, 0);
> > +             up_write(&copy->nf_dst->nf_rwsem);
> > +             if (!status)
> > +                     *committed = true;
> > +     }
> >       return bytes_copied;
> >   }
> >
> > @@ -1570,15 +1581,16 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
> >   {
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
