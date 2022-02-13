Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD854B3E61
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Feb 2022 00:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiBMXYd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Feb 2022 18:24:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbiBMXYc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Feb 2022 18:24:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AD151E5D
        for <linux-nfs@vger.kernel.org>; Sun, 13 Feb 2022 15:24:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CCBC0210F4;
        Sun, 13 Feb 2022 23:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644794664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3fEGTSGi3WrS4/MPB8Rqzty4YwV1UK/QASq/pPCy6U=;
        b=KNMfjkab5EOGgNnPVqiW+1HfhOGiJ+H5DmZvWxi1RovgVvT3gWd2Jbk4XIXeH0NB4WuJGF
        U5sqZ+n9N/kT3wwKIidxhO7J/PDkRMLDXTLA/YK4km7TROv8ERpIO+iJt3eLv+nmx4+fI7
        cG40+iWLi+Pb2DRuhvqCaB8K/ZfJ+X4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644794664;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3fEGTSGi3WrS4/MPB8Rqzty4YwV1UK/QASq/pPCy6U=;
        b=Vn8z2HRAvS6v6uasq2t2Nh2QNL5A0ucBtZSfGutmY4rjl3AiOXcButMWDqg6z565wOIRgl
        j3Qt/nCxOVg8XjAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 773AD1331E;
        Sun, 13 Feb 2022 23:24:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ATX+DCeTCWKVZgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 13 Feb 2022 23:24:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Benjamin Coddington" <bcodding@redhat.com>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>, steved@redhat.com,
        linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
In-reply-to: <299337F3-E83F-49EC-BB24-C9B859C9FB6D@redhat.com>
References: =?utf-8?q?=3Cc2e8b7c06352d3cad3454de096024fff80e638af=2E16439791?=
 =?utf-8?q?61=2Egit=2Ebcodding=40redhat=2Ecom=3E=2C?=
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>,
 <0AB20C82-6200-46E0-A76C-62345DAF8A3A@redhat.com>,
 <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>,
 <164444169523.27779.10904328736784652852@noble.neil.brown.name>,
 <39e7bba4243eb2f16d99fefb43fef6b3ff741f87.camel@hammerspace.com>,
 <164445109064.27779.13269022853115063257@noble.neil.brown.name>,
 <6BAAA0D0-7212-480F-9C33-DA1F656FF09F@redhat.com>,
 <164453369792.27779.10668875903268728405@noble.neil.brown.name>,
 <299337F3-E83F-49EC-BB24-C9B859C9FB6D@redhat.com>
Date:   Mon, 14 Feb 2022 10:24:18 +1100
Message-id: <164479465866.27779.3680126986096452561@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 12 Feb 2022, Benjamin Coddington wrote:
> On 10 Feb 2022, at 17:54, NeilBrown wrote:
> 
> > On Thu, 10 Feb 2022, Benjamin Coddington wrote:
> >>
> >> Yes, but even better than having the tool do the writing is to have 
> >> udev do
> >> it, because udev makes the problem of when and who will execute this 
> >> tool go
> >> away, and the entire process is configurable for anyone that needs to 
> >> change
> >> any part of it or use their own methods of generating/storing ids.
> >
> > I really don't understand the focus on udev.
> >
> > Something, somewhere, deliberately creates the new network namespace.
> > It then deliberately configures that namespace - creating a virtual
> > device maybe, adding an IP address, setting a default route or 
> > whatever.
> > None of that is done by udev rules (is it)?
> > Setting the NFS identity is just another part of configuring the new
> > network namespace.
> >
> > udev is great when we don't know exactly when an event will happen, 
> > but
> > we want to respond when it does.
> > That doesn't match the case of creating a new network namespace.  Some
> > code deliberately creates it and is perfectly positioned to then
> > configure it.
> 
> I think there's so many ways to create a new network namespace that we 
> can't
> reasonably be expected to try to insert out problem into all of them.

I 100% agree.  Similarly there are lots of init systems and we don't try
to provide configuration for each one to ensure - e.g.  - that sm-notify
is run at the correct time.
But we *do* provide configuration for one - systemd.  This is partly
because it is widely used, but largely because the distro that I
personally help maintain uses it.  So I added those systemd/* files.
(and then others helped improve them).

> Handling the event from the kernel allows us to make a best-effort 
> default attempt.

That "best" effort is not actually very good.

Might I suggest that we take a similar approach to the systemd config.
You choose whatever container system is important to you are the moment,
determine how best to integrate the required support with that system,
make sure the tool works well for that case, provide any config files
that might be generally useful for anyone using that container system,
and in the documentation for the tool explain generally when it must run
and why, and give an example for the system that you know.

If someone else uses a different container system, they are free to
create a solution based on your example, and welcome to submit patches -
either to nfs-utils or to that container system.

Obviously you make the tool reasonably general without over-engineering,
but don't try to solve problems that you don't even know really exist.
I would suggest the tool be passed one of:
 - a unique string 
 - a file containing a unique string
 - a file in which a randomly generated unique string may be stored if
   it doesn't already contain one
 - (maybe) nothing, in which case a new random identity is generate each
   time.  This could be useful for older kernels.

> 
> > udev is async.  How certain can we be that the udev event will be 
> > fully
> > handled before the first mount attempt?
> 
> Good point.  We can't at all be certain.
> 
> We can start over completely from here..
> 
> We can have mount.nfs /also/ try to configure the id.. this is more 
> robust.

If mount.nfs is going to do it, then the "also" is pointless.  There
would be no point in any other code doing it.  However I'm no longer as
keen on mount.nfs as I was.

> 
> We can have mount.nfs do a round of udev settle..

My experience with "udev settle" with md does not make me want to depend
on it.  It has it's place and does useful things, but not always quite
what I want.

> 
> Are there other options?

Document the requirement and make it "someone elses problem".
Your kernel patch to provide a random default mean a lack of
configuration will only hurt the container which lacks it - which nicely
localises the problem.

Thanks,
NeilBrown
