Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02572743C9
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 16:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgIVODW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 10:03:22 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43258 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgIVODV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 10:03:21 -0400
Received: by mail-ej1-f67.google.com with SMTP id o8so23030536ejb.10
        for <linux-nfs@vger.kernel.org>; Tue, 22 Sep 2020 07:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5m3K2VwtK5Gbjy4UVPinYuo2D4zLEmK8B0scDz5TX8Y=;
        b=PchaNe7Wgtus0I4xyH3VhSmW2R29/HoozEY0Mhnmb20k4T454KfG62drBXFJF//i33
         47lzmOerk9hsdhyFPnvlg90FPphrfdDK5gJZ8q1BFwiamjJEgoPTbjhPM0bOvz2DtxYn
         KoAJdWMtV8Wt8sgYFQFx2+bEvbFCFjiZxOUiJVXjhuDAWR3PwBhROk+ln9o/PwZuqvMX
         peVOAum7+QYEFA/d6zwLKUg7mIRqEYQmL8SwuGhL++l8SqOOTQILL0iyJnmv/2qPp588
         Bt03mJKecGK3hH2JmwDJFZvHIsCSjACDedeI/mh3Bxe7VlNVddJ9EzGJq1VsVxlFJpKd
         u/MQ==
X-Gm-Message-State: AOAM531dDXl58m/xfvMc6zGQGPKbhPKUXn2wjJ2d8wm3klHaj/c0NoLo
        805qIVzHhK6r2t+3bQ85U9oNF+7p04cNqLTn+76hb5CsUQU=
X-Google-Smtp-Source: ABdhPJzFl1B3ODwDgTTOLBP8al7WVPxh19BhOEWBgIL4DXSEgWLXvj7bSsK+JHJ4lYS40uYxizrIRfoNfB3YmkUXlZc=
X-Received: by 2002:a17:906:3ca2:: with SMTP id b2mr5227232ejh.460.1600783399583;
 Tue, 22 Sep 2020 07:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <5a7f6bbf4cf2038634a572f42ad80e95a8d0ae9c.1600686204.git.bcodding@redhat.com>
In-Reply-To: <5a7f6bbf4cf2038634a572f42ad80e95a8d0ae9c.1600686204.git.bcodding@redhat.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 22 Sep 2020 10:03:03 -0400
Message-ID: <CAFX2JfmeOm+-cpq6aTGnBNZLmAOwp8dykTWe7L6OU3mmnSw6rw@mail.gmail.com>
Subject: Re: [PATCH 1/3] NFSv4: Fix a livelock when CLOSE pre-emptively bumps
 state sequence
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ben,

On Mon, Sep 21, 2020 at 7:05 AM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> Since commit 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in
> CLOSE/OPEN_DOWNGRADE") the following livelock may occur if a CLOSE races
> with the update of the nfs_state:
>
> Process 1         Process 2        Server
> =========         =========        ========
>  OPEN file
>                   OPEN file
>                                    Reply OPEN (1)
>                                    Reply OPEN (2)
>  Update state (1)
>  CLOSE file (1)
>                                    Reply OLD_STATEID (1)
>  CLOSE file (2)
>                                    Reply CLOSE (-1)
>                   Update state (2)
>                   wait for state change
>  OPEN file
>                   wake
>  CLOSE file
>  OPEN file
>                   wake
>  CLOSE file
>  ...
>                   ...
>
> As long as the first process continues updating state, the second process
> will fail to exit the loop in nfs_set_open_stateid_locked().  This livelock
> has been observed in generic/168.

Once I apply this patch I have trouble with generic/478 doing lock reclaim:

[  937.460505] run fstests generic/478 at 2020-09-22 09:59:14
[  937.607990] NFS: __nfs4_reclaim_open_state: Lock reclaim failed!

And the test just hangs until I kill it.

Just thought you should know!
Anna

>
> Fix this by detecting the case in nfs_need_update_open_stateid() and
> then exit the loop if:
>  - the state is NFS_OPEN_STATE, and
>  - the stateid sequence is > 1, and
>  - the stateid doesn't match the current open stateid
>
> Fixes: 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE")
> Cc: stable@vger.kernel.org # v5.4+
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/nfs4proc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 45e0585e0667..9ced7a62c05e 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -1570,10 +1570,14 @@ static bool nfs_need_update_open_stateid(struct nfs4_state *state,
>  {
>         if (test_bit(NFS_OPEN_STATE, &state->flags) == 0 ||
>             !nfs4_stateid_match_other(stateid, &state->open_stateid)) {
> -               if (stateid->seqid == cpu_to_be32(1))
> +               if (stateid->seqid == cpu_to_be32(1)) {
>                         nfs_state_log_update_open_stateid(state);
> -               else
> -                       set_bit(NFS_STATE_CHANGE_WAIT, &state->flags);
> +               } else {
> +                       if (!nfs4_stateid_match_other(stateid, &state->open_stateid))
> +                               return false;
> +                       else
> +                               set_bit(NFS_STATE_CHANGE_WAIT, &state->flags);
> +               }
>                 return true;
>         }
>
> --
> 2.20.1
>
