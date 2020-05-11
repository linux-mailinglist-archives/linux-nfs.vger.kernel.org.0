Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15111CE1D9
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2020 19:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgEKRh1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 May 2020 13:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbgEKRh1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 May 2020 13:37:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D43C061A0C
        for <linux-nfs@vger.kernel.org>; Mon, 11 May 2020 10:37:27 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 4so8678923qtb.4
        for <linux-nfs@vger.kernel.org>; Mon, 11 May 2020 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jm2pB+Pn7xlYaxu4dwAX13euHAmJ6upDYFxFYbleTV8=;
        b=XW9+/i5i4GB/dohgszjO7RFHyhTfAjhGaQHkafS2ETDFq//ZQMORSv/Jb8bRIfMs/r
         G2bQPf9jklP3HlSwD2mqDHUzKbEGlvkaCMXHImbsIvPDG6nsKhfHyNYfW1rdDvvY4m7Z
         VsgraIcV2ql2mhLcv8UShNS8mmwAZHKhdPPAFEKA6m2VVR0HtUG/8r6QKhvfUJGldwHr
         OtllAnv4b9fLmXlcheaatGxIdkmDaeNV6kB+6mUse1KRTub7QRun1EOi11VNiZCMCFBy
         dbVgdJsV/FB+LcNe8wmzdEd2okELCXAoqtxm8Ci6CUaIqrVKdCkD30OqhiuApjt59CoD
         ChUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jm2pB+Pn7xlYaxu4dwAX13euHAmJ6upDYFxFYbleTV8=;
        b=mgcsvIaLCzTK0BfCEYiI3SLfZfwiLFx1LWOM3htJ1wwZWeWZXxcM9EuswDARacPN84
         D//EuvayNqXTboxjauI+vflN3UcNd+2rkXpD74fNOOBbwI6KjDifeWNsOoJrhua+GRfz
         lWi+vvTfhS+MI+xANDHMjwAsoPJ71GjN15ne8xAHdB0LGVrsEnMGAqO/qYC4KWLwrhuI
         spOibqtPQ3Kxov+wSAJGcvf80D54hprJotaVe8fZgkRvbggS3ebthi7nS+KaeweW6Vd5
         vovalYyt7+ZKSvgk3ZxsheHd7FtOSusoN2s3GedHuUyHa/TRJzTGYDjptJa5gGvv+ET2
         w0+w==
X-Gm-Message-State: AGi0PuaqwVsjrnDefyvTp0ArcLxoYbmwPKS5Q/GKFP/ZXC3vP/y/Rebe
        DhUK7jN7kbdHAOMw7ptEykrsCso=
X-Google-Smtp-Source: APiQypKBu1Oopc757vUh3tmsvo+CZiYiOpcmQuqBjEoVd2ROvbs3WX4Ym9ooym1oM5AbMi44XOE4fg==
X-Received: by 2002:ac8:36c8:: with SMTP id b8mr10703291qtc.212.1589218646360;
        Mon, 11 May 2020 10:37:26 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id k58sm10015127qtf.40.2020.05.11.10.37.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 10:37:25 -0700 (PDT)
Date:   Mon, 11 May 2020 13:37:23 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: fix NULL deference in nfs4_get_valid_delegation
Message-ID: <20200511173723.3xlqhkmrjbuc5g7r@gabell>
References: <20200508221935.GA11225@fieldses.org>
 <20200511121054.l2j34vnwqxhvd2ao@gabell>
 <20200511131637.GA8629@fieldses.org>
 <8f9f84f11df6f5caf054d1eada2d91ea158a6882.camel@hammerspace.com>
 <20200511135745.GB8629@fieldses.org>
 <20200511140158.GD8629@fieldses.org>
 <20200511140248.GE8629@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511140248.GE8629@fieldses.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

How about adding Cc: stable@vger.kernel.org in the sign-off area?
9ae075fdd190 "NFSv4: Convert open state lookup to use RCU" was merged
to v4.20 and some stable tree have 9ae075fdd190.

On Mon, May 11, 2020 at 10:02:48AM -0400, bfields@fieldses.org wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> We add the new state to the nfsi->open_states list, making it
> potentially visible to other threads, before we've finished initializing
> it.
> 
> That wasn't a problem when all the readers were also taking the i_lock
> (as we do here), but since we switched to RCU, there's now a possibility
> that a reader could see the partially initialized state.
> 
> Symptoms observed were a crash when another thread called
> nfs4_get_valid_delegation() on a NULL inode, resulting in an oops like:
> 
> 	BUG: unable to handle page fault for address: ffffffffffffffb0 ...
> 	RIP: 0010:nfs4_get_valid_delegation+0x6/0x30 [nfsv4] ...
> 	Call Trace:
> 	 nfs4_open_prepare+0x80/0x1c0 [nfsv4]
> 	 __rpc_execute+0x75/0x390 [sunrpc]
> 	 ? finish_task_switch+0x75/0x260
> 	 rpc_async_schedule+0x29/0x40 [sunrpc]
> 	 process_one_work+0x1ad/0x370
> 	 worker_thread+0x30/0x390
> 	 ? create_worker+0x1a0/0x1a0
> 	 kthread+0x10c/0x130
> 	 ? kthread_park+0x80/0x80
> 	 ret_from_fork+0x22/0x30
> 
> Fixes: 9ae075fdd190 "NFSv4: Convert open state lookup to use RCU"

Cc: stable@vger.kernel.org # 4.20.x-

Thanks!
Masa

> Reviewed-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
> Tested-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfs/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > I do have a patch including the tags and oops provided by Masayoshi
> > Mizuma, if you'd like to take that instead.  See followup.--b.
> 
> Here you go.
> 
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index f7723d221945..459c7fb5d103 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -734,9 +734,9 @@ nfs4_get_open_state(struct inode *inode, struct nfs4_state_owner *owner)
>  		state = new;
>  		state->owner = owner;
>  		atomic_inc(&owner->so_count);
> -		list_add_rcu(&state->inode_states, &nfsi->open_states);
>  		ihold(inode);
>  		state->inode = inode;
> +		list_add_rcu(&state->inode_states, &nfsi->open_states);
>  		spin_unlock(&inode->i_lock);
>  		/* Note: The reclaim code dictates that we add stateless
>  		 * and read-only stateids to the end of the list */
> -- 
> 2.26.2
> 
