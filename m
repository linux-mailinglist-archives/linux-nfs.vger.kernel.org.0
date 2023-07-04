Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D427466F5
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 03:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjGDBsm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 21:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGDBsl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 21:48:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F86E54
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 18:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 876686108E
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 01:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5C3C433C8;
        Tue,  4 Jul 2023 01:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688435295;
        bh=7J+akZNM+HSYfrHj5U8NXN8J9SWZrdDti9eT/Grsib0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/IAijyaDehFGto+TqDWO0MCoF3GABzJ6sjIIuoMGEOsB4koR6NcYRPurtWFFSvaH
         RGszR0OW3BB8Ms9yac8ZOXIJgs2tR3k8DVV2FKjaLhRC+FMTTOBpSwWz6hnsvrb7W4
         GZI03Pk4E1WP9RdUkrXUvyWN2UXtclNbC4Q9UlPBqKBXIfMBAvHT6nsdkvmJadFE5Y
         yWt5qYAmNAlMkYw5OfibzHTSTJanYF3r0u/MiOHIx6rowZDYFr8uaQ3GESpDLrlXr5
         k1Fh+bdAEt85+wXg90qxLDfEgjFVx/NTwvto9dygRyDiss89XiRBVHmGJSY3IGzLPL
         U1/iZMJIXOxlg==
Date:   Mon, 3 Jul 2023 21:48:12 -0400
From:   Chuck Lever <cel@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH v2 7/9] SUNRPC: Don't disable BH's when taking sp_lock
Message-ID: <ZKN6XHFMuzNb9IZ6@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
 <168842929557.139194.4420161035549339648.stgit@manet.1015granger.net>
 <168843216897.8939.13310930289540832368@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168843216897.8939.13310930289540832368@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 04, 2023 at 10:56:08AM +1000, NeilBrown wrote:
> On Tue, 04 Jul 2023, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Consumers of sp_lock now all run in process context. We can avoid
> > the overhead of disabling bottom halves when taking this lock.
> 
> "now" suggests that something has recently changed so that sp_lock isn't
> taken in bh context.  What was that change - I don't see it.
> 
> I think svc_data_ready() is called in bh, and that calls
> svc_xprt_enqueue() which take sp_lock to add the xprt to ->sp_sockets. 
> 
> Is that not still the case?

Darn, I forgot about that one. I'll drop this patch.

> NeilBrown
> 
> 
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  net/sunrpc/svc_xprt.c |   14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index ecbccf0d89b9..8ced7591ce07 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -472,9 +472,9 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
> >  	pool = svc_pool_for_cpu(xprt->xpt_server);
> >  
> >  	percpu_counter_inc(&pool->sp_sockets_queued);
> > -	spin_lock_bh(&pool->sp_lock);
> > +	spin_lock(&pool->sp_lock);
> >  	list_add_tail(&xprt->xpt_ready, &pool->sp_sockets);
> > -	spin_unlock_bh(&pool->sp_lock);
> > +	spin_unlock(&pool->sp_lock);
> >  
> >  	rqstp = svc_pool_wake_idle_thread(xprt->xpt_server, pool);
> >  	if (!rqstp) {
> > @@ -496,14 +496,14 @@ static struct svc_xprt *svc_xprt_dequeue(struct svc_pool *pool)
> >  	if (list_empty(&pool->sp_sockets))
> >  		goto out;
> >  
> > -	spin_lock_bh(&pool->sp_lock);
> > +	spin_lock(&pool->sp_lock);
> >  	if (likely(!list_empty(&pool->sp_sockets))) {
> >  		xprt = list_first_entry(&pool->sp_sockets,
> >  					struct svc_xprt, xpt_ready);
> >  		list_del_init(&xprt->xpt_ready);
> >  		svc_xprt_get(xprt);
> >  	}
> > -	spin_unlock_bh(&pool->sp_lock);
> > +	spin_unlock(&pool->sp_lock);
> >  out:
> >  	return xprt;
> >  }
> > @@ -1116,15 +1116,15 @@ static struct svc_xprt *svc_dequeue_net(struct svc_serv *serv, struct net *net)
> >  	for (i = 0; i < serv->sv_nrpools; i++) {
> >  		pool = &serv->sv_pools[i];
> >  
> > -		spin_lock_bh(&pool->sp_lock);
> > +		spin_lock(&pool->sp_lock);
> >  		list_for_each_entry_safe(xprt, tmp, &pool->sp_sockets, xpt_ready) {
> >  			if (xprt->xpt_net != net)
> >  				continue;
> >  			list_del_init(&xprt->xpt_ready);
> > -			spin_unlock_bh(&pool->sp_lock);
> > +			spin_unlock(&pool->sp_lock);
> >  			return xprt;
> >  		}
> > -		spin_unlock_bh(&pool->sp_lock);
> > +		spin_unlock(&pool->sp_lock);
> >  	}
> >  	return NULL;
> >  }
> > 
> > 
> > 
> 
