Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4899E3EAC6F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Aug 2021 23:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhHLVg4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 17:36:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55270 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhHLVg4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 17:36:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD0021FF79;
        Thu, 12 Aug 2021 21:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628804189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8NG/Nl+xLaaGV0VrGXl3aCbcv/ay2zFvI+KmIPBXXSI=;
        b=f1sK5EyhqgOmZ23WmAjo4UVpV3gbARWACUUl/U6LIWKzUImnnUpYAL2dwKhWpHd3NFPj9j
        sh24U6QHt9Lvi1ie9yRQazXx5oSEbi5QE93cntO1xxhEEFUZL+3exjovYzdOLjg2C8fv4r
        2PyaoA/7MJQTv8gpv+V7S8zJaAHG1mM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628804189;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8NG/Nl+xLaaGV0VrGXl3aCbcv/ay2zFvI+KmIPBXXSI=;
        b=kLOeHgV6doTp3hTdnOMbYlsbcaEU+6PZZ2P2dHbZIcJ4LAiooFptoNFuo8bZmlSVRFAfAJ
        QPw3oiQeJoVKP7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25C2313C80;
        Thu, 12 Aug 2021 21:36:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xVrfNFuUFWGybAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 12 Aug 2021 21:36:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J.  Bruce Fields" <bfields@fieldses.org>
Cc:     "Timothy Pearson" <tpearson@raptorengineering.com>,
        "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        "Trond Myklebust" <trondmy@gmail.com>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
In-reply-to: <20210812144428.GA9536@fieldses.org>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>,
 <162855621114.22632.14151019687856585770@noble.neil.brown.name>,
 <20210812144428.GA9536@fieldses.org>
Date:   Fri, 13 Aug 2021 07:36:25 +1000
Message-id: <162880418532.15074.7140645794203395299@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 13 Aug 2021, J.  Bruce Fields wrote:
> On Tue, Aug 10, 2021 at 10:43:31AM +1000, NeilBrown wrote:
> > 
> > The problem here appears to be that a signalled task is being retried
> > without clearing the SIGNALLED flag.  That is causing the infinite loop
> > and the soft lockup.
> > 
> > This bug appears to have been introduced in Linux 5.2 by
> > Commit: ae67bd3821bb ("SUNRPC: Fix up task signalling")
> 
> I wonder how we arrived here.  Does it require that an rpc task returns
> from one of those rpc_delay() calls just as rpc_shutdown_client() is
> signalling it?  That's the only way async tasks get signalled, I think.

I don't think "just as" is needed.
I think it could only happen if rpc_shutdown_client() were called when
there were active tasks - presumably from nfsd4_process_cb_update(), but
I don't know the callback code well.
If any of those active tasks has a ->done handler which might try to
reschedule the task when tk_status == -ERESTARTSYS, then you get into
the infinite loop.

> 
> > Prior to this commit a flag RPC_TASK_KILLED was used, and it gets
> > cleared by rpc_reset_task_statistics() (called from rpc_exit_task()).
> > After this commit a new flag RPC_TASK_SIGNALLED is used, and it is never
> > cleared.
> > 
> > A fix might be to clear RPC_TASK_SIGNALLED in
> > rpc_reset_task_statistics(), but I'll leave that decision to someone
> > else.
> 
> Might be worth testing with that change just to verify that this is
> what's happening.
> 
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index c045f63d11fa..caa931888747 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -813,7 +813,8 @@ static void
>  rpc_reset_task_statistics(struct rpc_task *task)
>  {
>  	task->tk_timeouts = 0;
> -	task->tk_flags &= ~(RPC_CALL_MAJORSEEN|RPC_TASK_SENT);
> +	task->tk_flags &= ~(RPC_CALL_MAJORSEEN|RPC_TASK_SIGNALLED|
> +							RPC_TASK_SENT);

NONONONONO.
RPC_TASK_SIGNALLED is a flag in tk_runstate.
So you need
	clear_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);

NeilBrown
