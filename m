Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BDC331638
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 19:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhCHSg2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 13:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCHSgE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Mar 2021 13:36:04 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185E1C06174A
        for <linux-nfs@vger.kernel.org>; Mon,  8 Mar 2021 10:36:04 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b7so16217501edz.8
        for <linux-nfs@vger.kernel.org>; Mon, 08 Mar 2021 10:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCs/YwRvijlrnCFQVqWxI+H4chwt7gzPnt+CQTEpNkA=;
        b=luxLbTnEQAv175zlPTi4YD6WxuIu5waKw7ZzpRI6Pwy61RqxAhDUFGI00ePgf59uw9
         ebZg+EQESjkjMQzsGJD4wvHDUMEtPcJRAkdY48vjHLdcM4EbSjHPoz5UzDhCZ56ernEQ
         VzBYiX3gXLANfwdYSxTPw5eBt72NIi/Wd0fvwqg1M7uEaTKORh4Tsq96wcLaYZGtHKj5
         8mlIRYyQm5zHRoEDnTXetBk+pjxG9r7EJ4/60W2dIqVLVpfMoj6XiBovJ2zD8hrrkViW
         LO6Rjm8rGINQiC66UyqFqoyt50e5526xxgq2vPvw7XnqPU1t6kHLxM4bQPcjSynUK+ax
         XNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCs/YwRvijlrnCFQVqWxI+H4chwt7gzPnt+CQTEpNkA=;
        b=pLp1ffhbl9+0yeQZ/j5h6vEmDgv1DRXr37+o6rXz0U5TGhSb9Iwmt1C9qphfa656e7
         TCuNdC8GOxc56uSLmfbzXygfwAxvGc0SI2b8Zau8upnOmulNsUK6755uRZpeu3Pcm0Gu
         1QrcwxzWaKUBbrU759BbvZOQGkZf1yJc+b2qrpI+hd1sB3HxckAjyxhYs/lttY2+43ME
         0cNH6jVVLMvaQIgKkkJ6ohFKcoV+4ulM8DkK9xnLi7IZASuyRjk8BSE+ov9VfohjQZ9E
         2jmYkQF9fFS8SwrXdA0qetM1T9rkeL1muGIZ2nbsMUuxvap3BOOYb/sCn+1eJpMzEhAq
         vY+Q==
X-Gm-Message-State: AOAM532Wm5zU87S1I21pmaBZ8cQ9zNdnp3FPt6sDlATcQEd7DFiy073D
        SNEThtUUoiZGZmUJIwqDcVxo+y8ajDMOemy5IgvmDc4V
X-Google-Smtp-Source: ABdhPJx33Q8Po2L0RUq8fa9WoblsmK60wjYRtWQDpGR3xM9LJLjhRt7sRL295VuoPgeODRN0TIwkOte3LLqR32CLe/I=
X-Received: by 2002:aa7:da98:: with SMTP id q24mr12594433eds.84.1615228562696;
 Mon, 08 Mar 2021 10:36:02 -0800 (PST)
MIME-Version: 1.0
References: <20210302194659.98563-1-dai.ngo@oracle.com>
In-Reply-To: <20210302194659.98563-1-dai.ngo@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 8 Mar 2021 13:35:50 -0500
Message-ID: <CAN-5tyHr6VEfBubU_gBRyCfzkAzGkwiBvO-0S9Kbnpj_LnVdQQ@mail.gmail.com>
Subject: Re: [PATCH] NFSv4.2: destination file needs to be released after
 inter-server copy is done.
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 2, 2021 at 2:47 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>
> This patch is to fix the resource leak problem of the source file
> when doing inter-server copy. The fix is to close and release the
> file in __nfs42_ssc_close after the copy is done.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfs/nfs4file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index 57b3821d975a..20163fe702a7 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -405,6 +405,12 @@ static void __nfs42_ssc_close(struct file *filep)
>         struct nfs_open_context *ctx = nfs_file_open_context(filep);
>
>         ctx->state->flags = 0;
> +
> +       if (!filep)
> +               return;
> +       get_file(filep);
> +       filp_close(filep, NULL);
> +       fput(filep);
>  }

I don't understand this logic. There is no reason to call
filp_close()? All this would be done by doing a fput(). Also fput()
would drop a reference on the mount point. So we are doing this then
we can't call that extra disconnect that was added by another patch.
Anyway I don't see why there is any reason to call anything but the
fput(), I'm not sure why __nfs42_ssc_close() is a better function and
doesn't lead to the "use_after_free".

>
>  static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
> --
> 2.9.5
>
