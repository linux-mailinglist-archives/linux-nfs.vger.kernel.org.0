Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7D036867C
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Apr 2021 20:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbhDVSVj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Apr 2021 14:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbhDVSVi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Apr 2021 14:21:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593B4C06174A
        for <linux-nfs@vger.kernel.org>; Thu, 22 Apr 2021 11:21:03 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cq11so10988233edb.0
        for <linux-nfs@vger.kernel.org>; Thu, 22 Apr 2021 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHUVwvl+jE5FHx3UJejP70oC8VI/5jXowMRCzM7mO80=;
        b=nPKSGay+IVHNBo3szPbiRe/2KLl9YM7iLDPGH2rf4++2eRvtN/Z/50BxKA9drAlbXC
         XJCdTLIzq10NMH8cxA+5oX/b9Tgmk9x0uKkpBsmSopqfqwkRxQYngaa+V3stjvl7aPCV
         MFv9UodKXYm1P8bwDwo3TAWEH83Vy1RePkE35H3fxtDKggA8i4i1afc4Z1DmSM0X+2at
         dgF7X7pHkfXktQL0lR++itWcTlCdg+E5kVbmiBbxkuB0F+9LqN9fWdweOsGCD5gkefDW
         vO+lxme+FFHMVnSbcrlEP6Qs5AHSQKzqF1/z1zjqjzpu6opEFVjFhaoRcSzOtsgcmsRk
         0R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHUVwvl+jE5FHx3UJejP70oC8VI/5jXowMRCzM7mO80=;
        b=SoKtYOItUP2PVrKo/ONbTimUS8ItbfM2qzZxFI83PcXfsdltBZXRJe+mLy2f063L9a
         qyquq9XIJQH7C0QC18yQVHx7RiF4HWd1JZR2TPu4BC5APj1DAeXxxrhEjLf2pvnNSLOM
         7gR8Tzu8puVTD7z5jzNKDxSSX7pQR/RHs8oj5eS/1mF2DlEX0DQQOhvUHidz0Wiaun9f
         RnXac9PS6DFvYFeYxevufwzpQSGX0K9amtGYqKvmN4jprDuLXxkxEEP4xRp3mDOvN9f6
         MV+fabSY1SZ3QhTf/Ai3tBQ7g0brCbBVJjQLAC+oxl8aaIiOTvQmW7X3WEiMCZjNvC0f
         x+jQ==
X-Gm-Message-State: AOAM5307m6hACb7FFv8RmeNhX3Jq2vBtFVDeb7WdvIX5KmdaerMMDSi0
        HGaOd9tk/HCrx0+4p15bRDypglAwfmZvGz7a/S8=
X-Google-Smtp-Source: ABdhPJzw87r6145GFAcZLsYgTw8HdcJRVR2Fy/UZNtUAvFZzcbVDTwYWBbcfdDu8U2qOzlkWxsr8kg+2qVDqaLP88Uc=
X-Received: by 2002:aa7:d7d1:: with SMTP id e17mr5662760eds.84.1619115662043;
 Thu, 22 Apr 2021 11:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210422161922.56080-1-olga.kornievskaia@gmail.com>
 <22046fa4-730f-4e08-cfd8-eadc5fe098b3@oracle.com> <CAN-5tyFbwOmyeTw7iY9M2GaofSpz03ui3nFNUPM8HkaHqv1D9g@mail.gmail.com>
 <651a32f3-7504-ed53-2fa9-21ceedba7bd2@oracle.com>
In-Reply-To: <651a32f3-7504-ed53-2fa9-21ceedba7bd2@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 22 Apr 2021 14:20:50 -0400
Message-ID: <CAN-5tyEnYybym-irP7-TCy3MKJBR8WYFdv-r92rZqWL+95+M0g@mail.gmail.com>
Subject: Re: [RFC 1/1] NFSD add vfs_fsync after async copy is done
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 22, 2021 at 1:37 PM <dai.ngo@oracle.com> wrote:
>
>
> On 4/22/21 10:27 AM, Olga Kornievskaia wrote:
> > On Thu, Apr 22, 2021 at 12:54 PM <dai.ngo@oracle.com> wrote:
> >>
> >> On 4/22/21 9:19 AM, Olga Kornievskaia wrote:
> >>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>
> >>> Currently, the server does all copies as NFS_UNSTABLE. For synchronous
> >>> copies linux client will append a COMMIT to the COPY compound but for
> >>> async copies it does not (because COMMIT needs to be done after all
> >>> bytes are copied and not as a reply to the COPY operation).
> >>>
> >>> However, in order to save the client doing a COMMIT as a separate
> >>> rpc, the server can reply back with NFS_FILE_SYNC copy. This patch
> >>> proposed to add vfs_fsync() call at the end of the async copy.
> >>>
> >>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >>> ---
> >>>    fs/nfsd/nfs4proc.c | 22 +++++++++++++++++-----
> >>>    1 file changed, 17 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> >>> index 66dea2f1eed8..c6f45f67d59b 100644
> >>> --- a/fs/nfsd/nfs4proc.c
> >>> +++ b/fs/nfsd/nfs4proc.c
> >>> @@ -1536,19 +1536,21 @@ static const struct nfsd4_callback_ops nfsd4_cb_offload_ops = {
> >>>        .done = nfsd4_cb_offload_done
> >>>    };
> >>>
> >>> -static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
> >>> +static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync,
> >>> +                             bool committed)
> >>>    {
> >>> -     copy->cp_res.wr_stable_how = NFS_UNSTABLE;
> >>> +     copy->cp_res.wr_stable_how = committed ? NFS_FILE_SYNC : NFS_UNSTABLE;
> >>>        copy->cp_synchronous = sync;
> >>>        gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
> >>>    }
> >>>
> >>> -static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
> >>> +static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy, bool *committed)
> >>>    {
> >>>        ssize_t bytes_copied = 0;
> >>>        size_t bytes_total = copy->cp_count;
> >>>        u64 src_pos = copy->cp_src_pos;
> >>>        u64 dst_pos = copy->cp_dst_pos;
> >>> +     __be32 status;
> >>>
> >>>        do {
> >>>                if (kthread_should_stop())
> >>> @@ -1563,6 +1565,15 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
> >>>                src_pos += bytes_copied;
> >>>                dst_pos += bytes_copied;
> >>>        } while (bytes_total > 0 && !copy->cp_synchronous);
> >>> +     /* for a non-zero asynchronous copy do a commit of data */
> >>> +     if (!copy->cp_synchronous && bytes_copied > 0) {
> >> I think (bytes_copied > 0) should be (bytes_total < copy->cp_count).
> > I don't think so. A successful async copy should never be less the
> > requested bytes.
>
> nfsd_copy_file_range can return 0 on the last write in the loop which
> causes the test (bytes_copied > 0) to fail which then skipping the
> commit. The check (bytes_total < copy->cp_count) says do the commit
> if there are any bytes successfully written so far.

Ops, right, so actually what I used to have "if (bytes_total > 0)". I
think typically we should have bytes_total = copy_cp_count but the
reason I don't have it to be bytes_total <= copy->cp_count is then if
bytes_total=0 it would call the vfs_fsync() which I didn't what to do.

>
> -Dai
>
> >
> >> -Dai
> >>
> >>> +             down_write(&copy->nf_dst->nf_rwsem);
> >>> +             status = vfs_fsync_range(copy->nf_dst->nf_file,
> >>> +                                      copy->cp_dst_pos, bytes_copied, 0);
> >>> +             up_write(&copy->nf_dst->nf_rwsem);
> >>> +             if (!status)
> >>> +                     *committed = true;
> >>> +     }
> >>>        return bytes_copied;
> >>>    }
> >>>
> >>> @@ -1570,15 +1581,16 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
> >>>    {
> >>>        __be32 status;
> >>>        ssize_t bytes;
> >>> +     bool committed = false;
> >>>
> >>> -     bytes = _nfsd_copy_file_range(copy);
> >>> +     bytes = _nfsd_copy_file_range(copy, &committed);
> >>>        /* for async copy, we ignore the error, client can always retry
> >>>         * to get the error
> >>>         */
> >>>        if (bytes < 0 && !copy->cp_res.wr_bytes_written)
> >>>                status = nfserrno(bytes);
> >>>        else {
> >>> -             nfsd4_init_copy_res(copy, sync);
> >>> +             nfsd4_init_copy_res(copy, sync, committed);
> >>>                status = nfs_ok;
> >>>        }
> >>>
