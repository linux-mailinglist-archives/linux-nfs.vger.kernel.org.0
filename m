Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F075A1CD969
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2020 14:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgEKMK6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 May 2020 08:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727019AbgEKMK5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 May 2020 08:10:57 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E2C061A0C
        for <linux-nfs@vger.kernel.org>; Mon, 11 May 2020 05:10:57 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id a136so453453qkg.6
        for <linux-nfs@vger.kernel.org>; Mon, 11 May 2020 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n8DSiesfkDCcbdQha/ivQ11kBOlJ+H4bPGGAvA7i7xg=;
        b=FAQ9hoqm8TflzO53GLjFjcnn2r6enk4TiOPc+5roMD5fUJyNNTmu7j9MCtyC+Hd8PZ
         /3jyDJlbRjDg4sStM3VZsn9eFFSqn+pXiFePRbTKAHDhTQ90Q+gw6lutRcd/Q/nTyP4L
         io2oPZDK4KtGOsocrOz/t97HTcrcD/xecdPycsFuOrsr6e/6ln7FBw2WBe1uPKyU7ijQ
         BvGuG0WMgc7mGApbmjvEYgPGVhOSjKIaqtjK+2KZsXRHswEaaWdqaOUSBsZaSFJ8OZMG
         OsCWCx9mTbfMyQTkB+p94KqO59KZHB0vaPnjUKXjJJlB/YcC5uUM2r3juNF+hwOQ/IeJ
         MGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n8DSiesfkDCcbdQha/ivQ11kBOlJ+H4bPGGAvA7i7xg=;
        b=Oj1TUxTm4BbgyVGn9KvEDevlX7ySuWU2ZOJBb9m0ejqbljQyOpQv7OoNH6I8Mr/xOV
         WjnZvSuYrdcRNoqLKbEzjmVg5yJROIU7nzbeaUonFn8Au/RgPGf68i5+NpMpoAfNFUIQ
         QVUKT1wMEmf0XIbMPjdxd7F0m+r5URiNy8v4McQ95wMBBbASBpQsyFm9WqKnC87G4opX
         x95cUZUT7NO4WHbjR+eNv6UdwffJdLNDUWN9uxKZVhF1F5voMlJJUhhFlH6Fk4VZwlwa
         +2MboXViR5Ht9o0x5+gJkmEk6DrQaR3qz2+qtkf9t2KyKFOIeanv5yX1hGzg8z0E5A7l
         lCtQ==
X-Gm-Message-State: AGi0PubXnbmr4QBzN7ssXO6DtYlSREZrA5dWMsGxWRIFzJZFIIeG74fM
        pwBhMnhjUtVG8x6MXEnzOtODY9o=
X-Google-Smtp-Source: APiQypIrK6wDPGv7ah4mTvy+HPK7FZmU7H5MlybBsV+2B8KZMjM6iFEXACkcPZWwI+0VLgdrf2mI2Q==
X-Received: by 2002:a37:27d8:: with SMTP id n207mr15785635qkn.40.1589199056609;
        Mon, 11 May 2020 05:10:56 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id k43sm9542253qtk.67.2020.05.11.05.10.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 05:10:56 -0700 (PDT)
Date:   Mon, 11 May 2020 08:10:54 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: fix NULL deference in nfs4_get_valid_delegation
Message-ID: <20200511121054.l2j34vnwqxhvd2ao@gabell>
References: <20200508221935.GA11225@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508221935.GA11225@fieldses.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 08, 2020 at 06:19:35PM -0400, J. Bruce Fields wrote:
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
> nfs4_get_valid_delegation() on a NULL inode.
> 
> Fixes: 9ae075fdd190 "NFSv4: Convert open state lookup to use RCU"
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfs/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index ac93715c05a4..a8dc25ce48bb 100644
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

Thank you for posting the patch! It works for our box.
Please feel free to add:

        Reviewed-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
        Tested-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
        Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Without the patch, the system which is a NFSv4 client has been
crashed randomly. The panic log is such as:

   BUG: unable to handle page fault for address: ffffffffffffffb0
   ...
   RIP: 0010:nfs4_get_valid_delegation+0x6/0x30 [nfsv4]
   ...
   Call Trace:
    nfs4_open_prepare+0x80/0x1c0 [nfsv4]
    __rpc_execute+0x75/0x390 [sunrpc]
    ? finish_task_switch+0x75/0x260
    rpc_async_schedule+0x29/0x40 [sunrpc]
    process_one_work+0x1ad/0x370
    worker_thread+0x30/0x390
    ? create_worker+0x1a0/0x1a0
    kthread+0x10c/0x130
    ? kthread_park+0x80/0x80
    ret_from_fork+0x22/0x30

After applied the patch, the panic is gone.

Thanks!
Masa
