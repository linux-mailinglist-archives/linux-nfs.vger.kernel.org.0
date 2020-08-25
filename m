Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C4C252010
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Aug 2020 21:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgHYTfF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Aug 2020 15:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYTfE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Aug 2020 15:35:04 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D808BC061574
        for <linux-nfs@vger.kernel.org>; Tue, 25 Aug 2020 12:35:03 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c10so12278093edk.6
        for <linux-nfs@vger.kernel.org>; Tue, 25 Aug 2020 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExjStVHf/BW5fZ//Raah24ZMhFsKpWvW6CB/cy9ojcY=;
        b=NN6dXfXd5U19ia5IQ+x0lrMaQlhffekNII5KKLqum512iK3G8zhWjhkZGBSBsuNs6Y
         LqSFCVp7eiAScEz1t1vyGM8Aoyuks4rGHgtMpVbz77pfr+BekZQrKWWR3RruB4qAajG/
         1jOs8btrj9rwiXMytm5iRYuTkJrCQFLapQ0HrQEnOIlcPastvuz5N2jNLUorCxXQbjUy
         3y+/s04AsBphVSvZt2N5F/k4Xs7bTmeeMQKyWgLBYPbAFfx3j6i2fC7MoyHesMfEgrLI
         j6ftjVdej5J50ZT2XVN6hp4iIf9ZzmBD6wjzpvFiE/1Rg4xdN5FB+PLgnI1WuwHhlNFe
         Axcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExjStVHf/BW5fZ//Raah24ZMhFsKpWvW6CB/cy9ojcY=;
        b=arQMZBE2SlvUtMqEs6EiJJcvwGogHNhvSXLj5XJxH7vVDKllnxANywCm79Q+qbENAB
         uJD2Rvgb1zkJOCa3DuP3VSPCIJMV25sSIA+sOqaH1cp7Y/XEuzTFPXAldNTcNaoE6J/3
         pfhYe8tq3gZOTPPKSMSl7PIG/C2MVVzLL0atr7uqWk28/A4lUmO6PwuSS/ipHPd6BlEC
         M4G/9pCPIy2f5hFAh7yS+/LLSW8Ajx4cpeKe4tpi3f7e9If+TEOCb+Zf7RyyXW3CV02a
         ldik4GJSlZz3ienTH1haJQUMbnw6vKL54oJFaSydKDJEv0NJdJZWGlCFKXoyBv+QH2hO
         ufoA==
X-Gm-Message-State: AOAM533y2ZN5GLIbJDg9JixFPfS47f22/AzutFdqAvyghmEIgjD+MKEr
        N+RXGUvQZwrWAh22KyZWUf+MyYgaQL5Qse9dj0jdhZBgkvo=
X-Google-Smtp-Source: ABdhPJypXpCPAL5H6snVEthgN24AFpwDFLguos6JYNUVVGvw9Cf+RyQ/aIKh0pjQXhiJAdQbuUs0YO+5kzZSD7Xp2BA=
X-Received: by 2002:aa7:cf19:: with SMTP id a25mr11441614edy.67.1598384102497;
 Tue, 25 Aug 2020 12:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200820225243.24825-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20200820225243.24825-1-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 25 Aug 2020 15:34:51 -0400
Message-ID: <CAN-5tyGdNxe_6=H7YrAkU2xdT02Yr2sZafg-O4aGHf9hM=ifcw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1 handle ERR_DELAY error reclaiming locking
 state on delegation recall
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Any comments on this patch? Thank you.

On Thu, Aug 20, 2020 at 6:50 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> A client should be able to handle getting an ERR_DELAY error
> while doing a LOCK call to reclaim state due to delegation being
> recalled. This is a transient error that can happen due to server
> moving its volumes and invalidating its file location cache and
> upon reference to it during the LOCK call needing to do an
> expensive lookup (leading to an ERR_DELAY error on a PUTFH).
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs4proc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index dbd01548335b..4a6cfb497103 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -7298,7 +7298,12 @@ int nfs4_lock_delegation_recall(struct file_lock *fl, struct nfs4_state *state,
>         err = nfs4_set_lock_state(state, fl);
>         if (err != 0)
>                 return err;
> -       err = _nfs4_do_setlk(state, F_SETLK, fl, NFS_LOCK_NEW);
> +       do {
> +               err = _nfs4_do_setlk(state, F_SETLK, fl, NFS_LOCK_NEW);
> +               if (err != -NFS4ERR_DELAY)
> +                       break;
> +               ssleep(1);
> +       } while (err == -NFS4ERR_DELAY);
>         return nfs4_handle_delegation_recall_error(server, state, stateid, fl, err);
>  }
>
> --
> 2.18.1
>
