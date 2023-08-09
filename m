Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74D77505D
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Aug 2023 03:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjHIBaJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 21:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjHIBaI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 21:30:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3831BDA
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 18:30:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A72061F45F;
        Wed,  9 Aug 2023 01:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691544602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lY5HR9Vtr8aTUv2TNXnfYgpmvZQfZPQdJ+ZCpwW4/4=;
        b=aKZ0ncA9O6WvEGAYujdwXG6eAf7A83eXKNHfiAeby1os/wfbyCav0MfeGATqn5olafJsPV
        auqCr4OUkLKhrE+JMWb2PPvMVaxt0vTnbu5Bajaft+8KjH+JIpS4Wz/hnHcsrlUC1AsA76
        UVEw6vOkl6pcrSHENxLuyTpi4whLQR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691544602;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lY5HR9Vtr8aTUv2TNXnfYgpmvZQfZPQdJ+ZCpwW4/4=;
        b=E72UE+hZ9aIBfwMdSm/+baRMpifMfSDx4GNW3tXhXcA7nhxgO+dfz1DDXav+8Gec643N/G
        CdIXzTWT13V1/aBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9B691377F;
        Wed,  9 Aug 2023 01:30:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Zq1wHhjs0mSvSQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 09 Aug 2023 01:30:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Lorenzo Bianconi" <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
In-reply-to: <ZNLmHZ/leArMDsEE@tissot.1015granger.net>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>,
 <169149440399.32308.1010201101079709026@noble.neil.brown.name>,
 <ZNJCIRjI64YIY+I0@tissot.1015granger.net>,
 <ea598236b2da9f1aa9b587ca797afaa9de5545c7.camel@kernel.org>,
 <ZNJLQIxweTaEsu16@tissot.1015granger.net>,
 <ed02b06f96eeeca4d499583f2bdf31a433921aa1.camel@kernel.org>,
 <ZNJctyaMBVuoT6yz@tissot.1015granger.net>,
 <169153110624.32308.3596310364486971122@noble.neil.brown.name>,
 <ZNLmHZ/leArMDsEE@tissot.1015granger.net>
Date:   Wed, 09 Aug 2023 11:29:57 +1000
Message-id: <169154459718.32308.4071940535265083664@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 09 Aug 2023, Chuck Lever wrote:
> On Wed, Aug 09, 2023 at 07:45:06AM +1000, NeilBrown wrote:
> > On Wed, 09 Aug 2023, Chuck Lever wrote:
> > > On Tue, Aug 08, 2023 at 10:20:44AM -0400, Jeff Layton wrote:
> > > > 
> > > > It would probably be fairly simple to output well-formed yaml instead.
> > > > JSON and XML are a bit more of a pain.
> > > 
> > > If folks don't mind, I would like more structured output like one of
> > > these self-documenting formats. (I know I said I didn't care before,
> > > but I'm beginning to care now ;-)
> > 
> > Lustre, which I am somewhat involved with, uses YAML for various things.
> > If someone else introduced yaml-producing sysfs files to the kernel
> > first, that might make the path for lustre smoother :-)
> 
> It worries me that there isn't yet kernel infrastructure for
> formating yaml in sysfs files. That broadens the scope of this
> work significantly.
> 
> 
> > Another option is netlink which lustre is stating to use for
> > configuration and stats.  It is a self-describing format.  The code
> > looks verbose, but it is widely used in the kernel and so well supported.
> 
> I just spent the last 6 months building a netlink upcall to handle
> TLS handshake requests for in-kernel TLS consumers. It is built on
> the recently-added yaml netlink specs and code generator. The yaml
> netlink specs are kept under:
> 
>   Documentation/netlink/specs/
> 
> Using netlink would give us a lot of infrastructure for this
> facility, but I'm not sure it's worth the extra complexity. And it
> would /require/ the use of user space tooling (ie, not 'cat') to get
> to the information exported from the kernel. <shrug>
> 

I do like the "cat" approach.  Unfortunately it doesn't scale and you
never really know when it needs to scale.
The nfsd/rpc cache.c auth cache is still a sore point for me.  It works
nicely expect that it breaks for gss because the keys get too big.  So
we've had a couple of attempts to "fix" that.  The fixes work, but they
are *different*.

The other well known pain point is /proc/mounts.  It is really cool that
you can "cat" that, but with thousands of mounts it can take tools like
systemd a long time to find changes.

does any of that matter for collecting stats?  Will we hit a wall?  I
really don't know.  I'd like to think that we won't....

> 
> > > I'm also wondering if we really ought not add another file under
> > > /proc, which is essentially obsolete. Would /sys/fs/nfsd/yada be
> > > better for this facility?
> > 
> > It is only under /proc because that is where it is mounted by default :-)
> > I think it might be sensible to create a node under /sys where all the
> > content of the nfsd filesystem also appears.
> 
> There are things in the nfsd filesystem that really belong under
> /proc/net/rpc or elsewhere, so IMO such migration needs to be
> handled on a case-by-case basis -- different project for another
> time.

abolutely.

> 
> 
> > I'm not keen on /sys/fs/nfsd because nfsd isn't a filesystem, it is a
> > service.
> 
> How about /sys/module/nfsd ?

Not worse than /sys/fs/nfsd.  Not really better though.
Everything in /sys/module/foo is about the module as a chunk of code -
except "parameters".  I guess we could add "state".

Maybe configfs is the thing ...  but I never liked configfs.  It seems
like a solution in search of a problem.

I complained that /sys/fs is like the provfs-v2.  It is more that
everything other than devices (and block,bus,class) is procfs-v2.
There are little bits of regularity, but no big-picture.

I would probably argue for /sys/services/sunrpc/{nfsd,lockd,nfsv4.1-cb}

Alternately, we could go for /sys/devices/virtual/sunrpc.  The virtual
directory contains "workqueue" which is a service in some sense, and
contains subdirectories for specific work-queues.
I'm not sure that all of the nfsd stuff would fit under there...

but maybe I'm over-thinking things.

Thanks,
NeilBrown


> 
> 
> > > I hesitate to even mention network namespaces...
> > 
> > Please do mention them - I find them too easy to forget about.
> > /proc/fs/nfsd/ inherits the network namespace from whoever mounts it.
> > So this can work perfectly.
> > If we created a mirror in /sys/ we would presumably use the namespace of
> > the process that opens the file.
> 
> I agree: the network namespace of the process that opens the
> rpc_status file is just what we want to limit access to in-flight
> requests. The current network namespace of each thread is available
> via SVC_NET(rqst), so it should be quite simple to display only
> in-flight requests that match the opener's namespace.
> 
> 
> -- 
> Chuck Lever
> 

