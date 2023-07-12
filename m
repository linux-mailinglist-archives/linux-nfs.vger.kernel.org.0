Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A108D75113B
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jul 2023 21:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGLT3o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jul 2023 15:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGLT3n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jul 2023 15:29:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F961FC3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jul 2023 12:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1B55618D5
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jul 2023 19:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7770AC433C8;
        Wed, 12 Jul 2023 19:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689190181;
        bh=dcF1sXrC6vkXxYFxbP9xUGDUjUWhh2AcbWCrUCWRQGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/IL+br7oOpb1Ena+2O0QXZG5AYFd5Qf5pm0RnDUfxuKzzQweQXW8JRC5czPuR+U0
         kAnfbrxlVunEaGOf0fOCzmnRd0sIfomcKOhDOmu3pfZ/mnxGzTMViKorsaBaOZ5+z4
         D6CcyVKCDyHRogGIutbJL8Ens8aXk4YhcJh8PgA99DKwOgStKt86vytt1y1LelyJw0
         /DiUmaO7bqe5w43eXJgYWk/4WEQdiOYBWXFmsN2xgNGThgHydyF7Ssg4AIBZgiW1/4
         Z0uBL/pwFqp4u9sgcYAXvtHNTQazJZ7N2TfGQaWwP7lYCFVSXltNFxj15C2ZG/jK7Z
         zoHqusd6nycLQ==
Date:   Wed, 12 Jul 2023 15:29:38 -0400
From:   Chuck Lever <cel@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH/RFC] sunrpc: constant-time code to wake idle thread
Message-ID: <ZK7/IsK8XrChIuTK@bazille.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
 <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>
 <168843152047.8939.5788535164524204707@noble.neil.brown.name>
 <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>
 <168894969894.8939.6993305724636717703@noble.neil.brown.name>
 <ZKwYhbo76v8ElI1b@manet.1015granger.net>
 <168902749573.8939.3668770103738816387@noble.neil.brown.name>
 <2211CC3B-806F-461D-A5AA-E95E35E1E408@oracle.com>
 <168906970156.8939.2877716074642019289@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168906970156.8939.2877716074642019289@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 11, 2023 at 08:01:41PM +1000, NeilBrown wrote:
> On Tue, 11 Jul 2023, Chuck Lever III wrote:
> > > On Jul 10, 2023, at 6:18 PM, NeilBrown <neilb@suse.de> wrote:
> > > 
> > > What do you think of removing the ability to stop an nfsd thread by
> > > sending it a signal.  Note that this doesn't apply to lockd or to nfsv4
> > > callback threads.  And nfs-utils never relies on this.
> > > I'm keen.  It would make this patch a lot simpler.
> > 
> > I agree the code base would be cleaner for it.
> > 
> > But I'm the new kid. I'm not really sure if this is
> > part of a kernel - user space API that we mustn't
> > alter, or whether it's something that was added but
> > never used, or ....
> > 
> > I can sniff around to get a better understanding.
> 
> Once upon a time it was the only way to kill the threads.
> There was a syscall which let you start some threads.  You couldn't
> change the number of threads, but you could kill them.
> And shutdown always kills processes, so letting nfsd threads be killed
> meant that would be removed at system shutdown.
> 
> When I added the ability to dynamically change the number of threads it
> made sense that we could set the number to zero, and then to use that
> functionality to shut down the nfs server.  So the /etc/init.d/nfsd
> script changed from "killall -9 nfsd" or whatever it was to 
> "rpc.nfsd 0".
> 
> But it didn't seem sensible to remove the "kill" functionality until
> after a transition process, and I never thought the schedule a formal
> deprecation.  So it just stayed...
> 
> The more I think about it, the more I am in favour of removing it.  I
> don't think any other kernel threads can be killed.  nfsd doesn't need
> to be special.
> 
> Maybe I'll post a patch which just does that.

I won't NACK such a patch out-of-hand. It seems like a sensible
clean-up, but let's have a look at the details.
