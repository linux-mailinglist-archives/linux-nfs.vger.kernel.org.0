Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1961B49F24C
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jan 2022 05:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbiA1EO7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 23:14:59 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55292 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiA1EO6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 23:14:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E15A210FE;
        Fri, 28 Jan 2022 04:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643343296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlXEu68lzg/8BgeZd+9A3f+kdSsVmA5P2x8QWZgljRk=;
        b=ZV1tGVYLKO8Ho0F1xMY/rwp0u8Ka+WhUPr1JRMA9rgkXEqsf0lltzPtYBdxpGXw4UEQXXP
        cv1FvxfzQePGM6YjEqyAHMTv8LdagaViJf0/7rGuoWuzk3HY8iWwtVNjPSZo+La7p1n1Cu
        /E8NR+CQ4wIQVnSZPpFEnZY8stGqTVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643343296;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlXEu68lzg/8BgeZd+9A3f+kdSsVmA5P2x8QWZgljRk=;
        b=dYxhzSZJmIHvuLmO97Q+d+472WiuxGukndbdCMpoT3MXp/zYf2a71uybWpqebFvm9HR4S8
        nQ+PqI+/QUGaWIAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0DF6134F7;
        Fri, 28 Jan 2022 04:14:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3J1TKr5t82F8CAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 28 Jan 2022 04:14:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] nfsd: allow NFSv4 state to be revoked.
In-reply-to: <20220128025152.GA7473@fieldses.org>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>,
 <7B388FE8-1109-4EDD-B716-661870B446C7@oracle.com>,
 <164332328424.5493.16812905543405189867@noble.neil.brown.name>,
 <20220128025152.GA7473@fieldses.org>
Date:   Fri, 28 Jan 2022 15:14:51 +1100
Message-id: <164334329191.5493.6897436011766354666@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 28 Jan 2022, J. Bruce Fields wrote:
> On Fri, Jan 28, 2022 at 09:41:24AM +1100, NeilBrown wrote:
> > It's complicated....
> > 
> > The customer has an HA config with multiple filesystem resource which
> > they want to be able to migrate independently.  I don't think we really
> > support that, but they seem to want to see if they can make it work (and
> > it should be noted that I talk to an L2 support technician who talks to
> > the customer representative, so I might be getting the full story).
> > 
> > Customer reported that even after unexporting a filesystem, they cannot
> > then unmount it.  Whether or not we think that independent filesystem
> > resources is supportable, I do think that the customer should have a
> > clear path for unmounting a filesystem without interfering with service
> > provided from other filesystems.  Stopping nfsd would interfere with
> > that service by forcing a grace-period on all filesystems.
> > The RFC explicitly supports admin-revocation of state, and that would
> > address this specific need, so it seemed completely appropriate to
> > provide it.
> 
> I was little worried that might be the use-case.
> 
> 

:-)

> I don't see how it's going to work.  You've got clients that hold locks
> an opens on the unexported filesystem.  So maybe you can use an NFSv4
> referral to point them to the new server.  Are they going to try to
> issue reclaims to the new server?  There's more to do before this works.

As I hope I implied, I'm not at all sure that the specific problem that
the customer raised (cannot unmount a filesystem) directly related to
the general solution that the customer is trying to create.  Some
customers like us to hold their hand the whole way, others like to (feel
that they) have more control.  In general I like to encourage
independence (but I have to consciously avoid trusting the results).

We have an "unlock_filesystem" interface.  I want it to work for NFSv4. 
The HA config was background, not a complete motivation.

> 
> > As an aside ...  I'd like to be able to suggest that the customer use
> > network namespaces for the different filesystem resources.  Each could
> > be in its own namespace and managed independently.
> 
> Yeah.  Then you're basically migrating the whole server, not just the
> one export, and that's more of a solved problem.

Exactly.

> 
> > However I don't think we have good admin infrastructure for that do
> > we?
> > 
> > I'd like to be able to say "set up these 2 or 3 config files and run
> > systemctl start nfs-server@foo and the 'foo' network namespace will be
> > created, configured, and have an nfs server running".  Do we have
> > anything approaching that?  Even a HOWTO ??
> 
> But I don't think we've got anything that simple yet?

I guess I have some work to do....

Thanks,
NeilBrown
