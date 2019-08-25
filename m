Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9089C2D7
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Aug 2019 12:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfHYKMq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Aug 2019 06:12:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33262 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfHYKMq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Aug 2019 06:12:46 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so30463378iog.0
        for <linux-nfs@vger.kernel.org>; Sun, 25 Aug 2019 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMpyQvF6VzughydnrGZHt+I7Ql6B0+O3aZ99w06rrB0=;
        b=WRMep0SfYrMDheaLekaO6LNsHOt0YTl0JHu32AtcogB8IE0Z7iIUvr8W48sMCW+qmM
         wb8+vpr/pdO5Gaz/dqA48yD9ho8XMbgAxHTOTzb7OUpmbG9XsH+fCAysroGb5UgGgrPq
         roIPdCnMho4fLhYpBqoXp/2dboGv35kxLWKOXu7DQTofp1H6QJb+QDTm2Q3tjeaSYvzD
         K30hGbw/+mTXH8kYfi5hZZhkVMGcMUcHq/WfIZcA3yjDvWouGqk1UlZj6mynvHPrNyga
         FGLAQEtDrIKGYcGNnX3SBqcnTTVI42QZT0aqvBUxuRP4H7F8afjfkT2wx5N79yRxTTId
         y0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMpyQvF6VzughydnrGZHt+I7Ql6B0+O3aZ99w06rrB0=;
        b=tmv3QgyBED3lIHDfHks8P2NK5SHGUmx2h8u/yM5Ut3CW7sUWqNqB1nOKKEKtOfMvzT
         U7Nv4lf1XI5mjlVw3nishGxwdqGbCtMDzbQKs6FoHadjSslz0k51wrwAglaZPQmKE7DV
         a5CKCMhFfqa55uTqV2xWDOxbbkF0N+5y/cIeeEJD50m3lg5zGT87QSceWMQTb6/fbtQT
         mIzx+mpfjYpEDRMh1tHjeyR33yVu/nTgHKE5ucOLI5Sw126PwQN4S3fmrm8ZEBZXmk/d
         rLaV9XLfrOcYH5pFZkQFT4BzgtyZwjzFTTLCM7BbNFBZmjI9BDlx/g2R/HlF+/svUHBs
         TVAQ==
X-Gm-Message-State: APjAAAWkxAOW29AM9QERyVTtApYDjwZuYrounz7t+TKYmrwR3De2ayN3
        KkrJWc+wEFWfHAVBFEoI2YsASh3KfHJgE1cej1Fwtg==
X-Google-Smtp-Source: APXvYqxr7+J1ckULATkxxljBqpvrUxVstFS1oYrb+2SWBrzUbjBu3cME5YdbOEUeT55SSyAsEpBjgwxKOZk24dgms1A=
X-Received: by 2002:a02:3e86:: with SMTP id s128mr12524010jas.14.1566727965414;
 Sun, 25 Aug 2019 03:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <1566406146-7887-1-git-send-email-alex@zadara.com>
In-Reply-To: <1566406146-7887-1-git-send-email-alex@zadara.com>
From:   Alex Lyakas <alex@zadara.com>
Date:   Sun, 25 Aug 2019 13:12:34 +0300
Message-ID: <CAOcd+r0bXefi79dnwrwsDN1OecScfTjc8DYS5_9A8D5XKrh7QQ@mail.gmail.com>
Subject: Re: [RFC-PATCH] nfsd: when unhashing openowners, increment
 openowner's refcount
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Shyam Kaushik <shyam@zadara.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce, Chuck,

You are listed as maintainers of nfsd. Can you please take a look at
the below patch?

Thanks,
Alex.

On Wed, Aug 21, 2019 at 7:50 PM Alex Lyakas <alex@zadara.com> wrote:
>
> release_openowner() expects an extra refcnt taken for the openowner,
> which it is releasing.
>
>  With nfsd_inject_forget_client_openowners() and nfsd_inject_forget_openowners(),
> we unhash openowners and collect them into a reaplist. Later we call
> nfsd_reap_openowners(), which calls release_openowner(), which releases all openowner's stateids.
> Each OPEN stateid holds a refcnt on the openowner. Therefore, after releasing
> the last OPEN stateid via its sc_free function, which is nfs4_free_ol_stateid,
> nfs4_put_stateowner() will be called, which will realize its the last
> refcnt for the openowner. As a result, openowner will be freed.
> But later, release_openowner() will go ahead and call release_last_closed_stateid()
> and nfs4_put_stateowner() on the same openowner which was just released.
> This corrupts memory and causes random crashes.
>
> After we fixed this, we confirmed that the openowner is not freed
> prematurely. It is freed by release_openowner() final call
> to nfs4_put_stateowner().
>
> However, we still get (other) random crashes and memory corruptions
> when nfsd_inject_forget_client_openowners() and
> nfsd_inject_forget_openowners().
> According to our analysis, we don't see any other refcount issues.
> Can anybody from the community review these flows for other potentials issues?
>
> Signed-off-by: Alex Lyakas <alex@zadara.com>
> ---
>  fs/nfsd/nfs4state.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 7857942..4e9afca 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7251,6 +7251,7 @@ static u64 nfsd_foreach_client_lock(struct nfs4_client *clp, u64 max,
>                         func(oop);
>                         if (collect) {
>                                 atomic_inc(&clp->cl_rpc_users);
> +                               nfs4_get_stateowner(&oop->oo_owner);
>                                 list_add(&oop->oo_perclient, collect);
>                         }
>                 }
> --
> 1.9.1
>
