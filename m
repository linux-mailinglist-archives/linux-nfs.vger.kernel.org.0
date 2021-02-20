Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F83320227
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Feb 2021 01:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhBTATq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 19:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBTATp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 19:19:45 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D735C061574
        for <linux-nfs@vger.kernel.org>; Fri, 19 Feb 2021 16:19:05 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jt13so17003179ejb.0
        for <linux-nfs@vger.kernel.org>; Fri, 19 Feb 2021 16:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mA/caaAoL9Hd6pQlgStfvd3yab7XXz+u9zPpfR12ltw=;
        b=iEfdNxj/TTe8/9ZQRJ0Iam2Nqq5GVu+qcZBG9EBuPTDGGjDuXnNx+kZfGosdc2hsV+
         AH9egmLGOtYR08Pa+xRmOSIMRuxRiE2hGK7PNuRaiJdL+4qsQQh/Od/Zdf7wsf+blMsA
         U1kXRTPd7DJDWQqmwqXECa6iBP8r9CcsYx4WX85AOvGtUZO8M3ZLhsoGd2OBW9hNVBL0
         70UhiGeJLfLz3EwEhpVnYbzXyi1yQWtBqqov0bC4CKD6p3IR3v1LpshyeTaSupDxcKxf
         Yl5qDh0fRrZ0QJwdv4Q8otkRE6GbIC+KGLa9OY6uAdBNjuD7m4g2E29hT/yOIZQ8mAwc
         2NcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mA/caaAoL9Hd6pQlgStfvd3yab7XXz+u9zPpfR12ltw=;
        b=XYvN4jHHESr871WHaA9TT3abIIjWHmdSclRiDA7WCy/Qp0FAY7muMZjtnj6HItkQFo
         Dn6Ujru3cBAIryMKc4eS0UWoM9cLeVTzCRIZP3n2AUqoNu6jUdHHMR3/ufkxZIaooFUD
         yhk+rN5PVFKQ+d5Ynez9AF+LqiEJotHSngqklBkdJGYXfK9WTlBtYCqtyDeU94khqOyQ
         uht9c3/K9PKeMWGMo7AGv2KwVEDw5a9Gw3+2KSx0wc+807kW4I5K8nqmoNaHPH/dsj5W
         uOPUriLtH7YgFrkkDP1z1uiL81vI6H1zyLXZUp//sJ+Yzm2EPRkeRN7h6TtE4n0tC6en
         jOTQ==
X-Gm-Message-State: AOAM531zMLcX6SVnm6u2J42ZkBmRk3n8ZLGQWguZ4wgqAzPz9IDAc4JH
        2r5wixVPc3BJFn9kaLliFbIXTjDoNf+2tEHKOfl3ei+fIoPXXg==
X-Google-Smtp-Source: ABdhPJxPCiLvGV+BsRjRJRCMbqjoVgjP5iZB0DswuDrxTpv0e39F1kngKKv8+dDHVLnhC9HYmkHxL0p24uOrUZAciT0=
X-Received: by 2002:a17:907:1b1f:: with SMTP id mp31mr11034482ejc.348.1613780344033;
 Fri, 19 Feb 2021 16:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20201029190716.70481-1-dai.ngo@oracle.com> <20201029190716.70481-2-dai.ngo@oracle.com>
In-Reply-To: <20201029190716.70481-2-dai.ngo@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 19 Feb 2021 19:18:53 -0500
Message-ID: <CAN-5tyFnTSuMivnBPD9Aur+KDxX8fCOuSaF7qGKe6bFB7roK6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] NFSD: Fix use-after-free warning when doing
 inter-server copy
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dai (Bruce),

This patch is what broke the mount that's now left behind between the
source server and the destination server. We are no longer dropping
the necessary reference on the mount to go away. I haven't been paying
as much attention as I should have been to the changes. The original
code called fput(src) so a simple refcount of the file. Then things
got complicated and moved to nfsd_file_put(). So I don't understand
complexity. But we need to do some kind of put to decrement the needed
reference on the superblock. Bruce any ideas? Can we go back to
fput()?

On Thu, Oct 29, 2020 at 3:08 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>
> The source file nfsd_file is not constructed the same as other
> nfsd_file's via nfsd_file_alloc. nfsd_file_put should not be
> called to free the object; nfsd_file_put is not the inverse of
> kzalloc, instead kfree is called by nfsd4_do_async_copy when done.
>
> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index ad2fa1a8e7ad..9c43cad7e408 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1299,7 +1299,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct nfsd_file *src,
>                         struct nfsd_file *dst)
>  {
>         nfs42_ssc_close(src->nf_file);
> -       nfsd_file_put(src);
> +       /* 'src' is freed by nfsd4_do_async_copy */
>         nfsd_file_put(dst);
>         mntput(ss_mnt);
>  }
> --
> 2.20.1.1226.g1595ea5.dirty
>
