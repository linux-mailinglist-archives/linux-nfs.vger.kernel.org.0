Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CEF12EBA9
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2020 23:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgABWJA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jan 2020 17:09:00 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45641 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgABWJA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jan 2020 17:09:00 -0500
Received: by mail-vs1-f68.google.com with SMTP id b4so25814471vsa.12
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jan 2020 14:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVzVBelWzaF8I8jnLlZp2V6RKqMtCITlWFSIbKDAaTg=;
        b=igi0s8GNg4Sin5UV+Vl4fyzkVIUz6a9Af3QNYFkuKVZURzyPK2UhNCCHpKK55XcVZP
         CTRTQ9z0+fdMuMzQn4cMUoR8l0Q543wy+tX1E3dua7eC9ZNwwruexx1UiGa8I9kVS4r3
         hFY7ZFxBHDKATP7wVTGRXsIlP/+o08UDMQZVbqEX4I261YaGhlEVA4JwQZPAISVCYzN7
         cVAFrMvF0pPmjDN+7RX8oIvtaL4L9X2qLWNtHYOUOzOiIh6M0lRxCuri+fQ+jUq5yc7B
         XE4VyUli0Nk/03DdsJC7HNpOQr4CHNAMEULDc4o9nBPV0rDO//EakmBrAxium4zPJbzB
         OwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVzVBelWzaF8I8jnLlZp2V6RKqMtCITlWFSIbKDAaTg=;
        b=ElEyK8Q1k8vEf8gCuchWzWNW7g2in2+ErLQe7NiginzzfibnacqHNIjlg/VXWe9L3e
         DrhQakVH/Pvt5PkPD0hADG8MPziNKODhrO8uXCaV1H73EyfeBMxRSCQBl1Twblo3fBS+
         tHGT1dCbySIVrcKG0efvhSaOnItKGjs9y3knny5+6CSSPmC1/wE8PrpnTZCGRRcXinAH
         nX5byC0yVDMX8fJP40zl5xQcWrls2UgjnQ4b2TEcNLXpys1IjoI5mI1X8WNZn7+eHFLA
         etHV+XIHuBYyvcaKCQ1nK2TxFUNYh1uTBB1p5sOth2KABEnBQgjjoc7FccN56fMYjRFV
         S4gQ==
X-Gm-Message-State: APjAAAWjYAM9u6Qsy0FhT0uSVOgqDCqYOy3SVKl7BUuVBDX4mGJcf9sf
        7MMX9sUq00AoVRTtSjRJaGyXNGQ+9tf+UWJqm+w=
X-Google-Smtp-Source: APXvYqxfJjr5I23j8McQ9WqlusREMki2SjVxUrFDGfgsjIlgPnKiBFmYyF2aSuO5ZBybsNod5VZizTv56M+vQU+gZ2M=
X-Received: by 2002:a05:6102:190:: with SMTP id r16mr42922441vsq.215.1578002939662;
 Thu, 02 Jan 2020 14:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20200102212827.11597-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20200102212827.11597-1-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 2 Jan 2020 17:08:48 -0500
Message-ID: <CAN-5tyEpr1rz1V1fVZKXLz=9uOOaDrEyUrzTHUEJ+6EfmAPZ1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] NFSv4.1 fix incorrect return value in copy_file_range
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Apologizes please ignore this was trying to submit v2 of the ACL patch
and sent the wrong file.

On Thu, Jan 2, 2020 at 4:28 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> According to the NFSv4.2 spec if the input and output file is the
> same file, operation should fail with EINVAL. However, linux
> copy_file_range() system call has no such restrictions. Therefore,
> in such case let's return EOPNOTSUPP and allow VFS to fallback
> to doing do_splice_direct(). Also when copy_file_range is called
> on an NFSv4.0 or 4.1 mount (ie., a server that doesn't support
> COPY functionality), we also need to return EOPNOTSUPP and
> fallback to a regular copy.
>
> Fixes xfstest generic/075, generic/091, generic/112, generic/263
> for all NFSv4.x versions.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs42proc.c | 3 ---
>  fs/nfs/nfs4file.c  | 4 +++-
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index ff6f85f..5196bfa 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -329,9 +329,6 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
>         };
>         ssize_t err, err2;
>
> -       if (!nfs_server_capable(file_inode(dst), NFS_CAP_COPY))
> -               return -EOPNOTSUPP;
> -
>         src_lock = nfs_get_lock_context(nfs_file_open_context(src));
>         if (IS_ERR(src_lock))
>                 return PTR_ERR(src_lock);
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index 45b2322..00d1719 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -133,8 +133,10 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
>                                     struct file *file_out, loff_t pos_out,
>                                     size_t count, unsigned int flags)
>  {
> +       if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
> +               return -EOPNOTSUPP;
>         if (file_inode(file_in) == file_inode(file_out))
> -               return -EINVAL;
> +               return -EOPNOTSUPP;
>         return nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count);
>  }
>
> --
> 1.8.3.1
>
