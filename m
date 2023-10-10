Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ED67C4418
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Oct 2023 00:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjJJWaZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Oct 2023 18:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjJJWaW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Oct 2023 18:30:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E89AF0
        for <linux-nfs@vger.kernel.org>; Tue, 10 Oct 2023 15:30:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B4F7C1F6E6;
        Tue, 10 Oct 2023 22:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696977012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7M56PoZvRnYHJXBhK6lrWfnNCxCQ5r3Vk/yZ9cXnRZA=;
        b=kXtqpjspHBmFsS5uczBat61KGInKIzzG3XbN6z6RJ4zxSLaiE+arOWb50FYLeC4NZEjP6z
        sLsDebw1l1uvPiSbJl2VTtZadhppJ6JsY/yx2Sde5iERuz0W7Dl7y20giulojXuUBZko1O
        OWVqfXcWNdyFB2t4zPfrK2sapSGXTx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696977012;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7M56PoZvRnYHJXBhK6lrWfnNCxCQ5r3Vk/yZ9cXnRZA=;
        b=7gQE++bxuHj0BAVb8F4g7UjV6nAzs6xvEv4JS0/Mpdi/OvboRrRKJ5g4aMKkiclr8TiNZ6
        ywMNdsPtyN5RTYDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88B761358F;
        Tue, 10 Oct 2023 22:30:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8gzTDnLQJWUSMAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 10 Oct 2023 22:30:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH] lockd: hold a reference to nlmsvc_serv while stopping thread.
In-reply-to: <834A724C-4A44-4277-AFB5-D639FCF2900B@oracle.com>
References: <169689454310.26263.15848180396022999880@noble.neil.brown.name>,
 <834A724C-4A44-4277-AFB5-D639FCF2900B@oracle.com>
Date:   Wed, 11 Oct 2023 09:30:06 +1100
Message-id: <169697700659.26263.12600384009390271074@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 10 Oct 2023, Chuck Lever III wrote:
> 
> > On Oct 9, 2023, at 7:35 PM, NeilBrown <neilb@suse.de> wrote:
> > We are required to hold a reference to the svc_serv struct while
> > stopping the last thread, as doing that could otherwise drop the last
> > reference itself and the svc_serv would be freed while still in use.
> > 
> > lockd doesn't do this.  After startup, the only reference is held by the
> > running thread.
> > 
> > So change locked to hold a reference on nlmsvc_serv while-ever the
> > service is active, and only drop it after the last thread has been
> > stopped.
> > 
> > Note: it doesn't really make sense for threads to hold references to the
> > svc_serv any more.  The fact threads are included in serv->sv_nrthreads
> > is sufficient.  Maybe a future patch could address this.
> > 
> > Reported-by: Jeff Layton <jlayton@kernel.org>
> > Fixes: 68cc388c3238 ("SUNRPC: change how svc threads are asked to exit.")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> 
> Thanks for the fast response!
> 
> Should I squash this into 68cc, or apply it before? I would
> like to ensure that bisect works nicely over this series of
> commits.

Probably makes sense to put it before.  In that case the patch
description needs re-wording.

And on reflection I think the code should be changed a little so that it
matches similar code in nfsd and nfs4-callback.
So I'll repost.
I'll take the liberty of preserving Jeff's review/test even though I've
changed the code .... I hope that's OK.

NeilBrown
