Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EFE4E8D58
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Mar 2022 06:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiC1EeU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Mar 2022 00:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiC1EeT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Mar 2022 00:34:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4764950B06
        for <linux-nfs@vger.kernel.org>; Sun, 27 Mar 2022 21:32:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF5C71F381;
        Mon, 28 Mar 2022 04:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648441957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1L5yR4a8nXVzL0APYLq0Rm12+pM7lRYqTSo82y+9aVE=;
        b=emTJKaiV+CV19NWM9kN5yrdiCuOLi5Z8ZhSv7EECWj0qwpBMDdr9BIij39lwWXkckje2Zc
        Em2R5EZX9K7fSxZjI76swYbYUsMJkW5IsOh2njdq5eR4bJvwMeVOiXA02pJklZ27AmQBE6
        z8kgdkUjU6jeR5nQriafMWR83HQbEls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648441957;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1L5yR4a8nXVzL0APYLq0Rm12+pM7lRYqTSo82y+9aVE=;
        b=CR36W0G3Dy4qeZz+lG6IW1gyn+CC2gyz75dUhaJqqtwh//d3GlL9itOE448IFJaHS9SPlm
        RyUqTzf6pMT5FTDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30EB813AFE;
        Mon, 28 Mar 2022 04:32:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YAF6N2M6QWIrRAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 28 Mar 2022 04:32:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Benjamin Coddington" <bcodding@redhat.com>,
        "Steve Dickson" <SteveD@RedHat.com>,
        "Trond Myklebust" <trondmy@hammerspace.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFSv4: ensure different netns do not share cl_owner_id
In-reply-to: <CC04FF50-B936-456D-8BF0-4BF04647B4BC@oracle.com>
References: <164816787898.6096.12819715693501838662@noble.neil.brown.name>,
 <CC04FF50-B936-456D-8BF0-4BF04647B4BC@oracle.com>
Date:   Mon, 28 Mar 2022 15:32:31 +1100
Message-id: <164844195133.6096.11388357137493699567@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 26 Mar 2022, Chuck Lever III wrote:
> Hi Neil-
> 
> > On Mar 24, 2022, at 8:24 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > 
> > [[ This implements an idea I had while discussing the issues around
> >   NFSv4 client identity.  It isn't a solution, but instead aims to make
> >   the problem more immediately visible so that sites can "fix" their
> >   configuration before they get strange errors.
> >   I'm not convinced it is a good idea, but it seems worthy of a little
> >   discussion at least.
> >   There is a follow up patch to nfs-utils which expands this more
> >   towards a b-grade solution, but again if very open for discussion.
> > ]]
> > 
> > The default cl_owner_id is based on host name which may be common
> > amongst different network namespaces.  If two clients in different
> > network namespaces with the same cl_owner_id attempt to mount from the
> > same server, problem will occur as each client can "steal" the lease
> > from the other.
> 
> The immediate issue, IIUC, is that this helps only when the potentially
> conflicting containers are located on the same physical host. I would
> expect there are similar, but less probable, collision risks across
> a population of clients.

I see that as a separate issue - certainly similar but probably
requiring a separate solution.  I had hope to propose a (partial)
solution to that the same time, but it proved challenging.

I would like to automatically set nfs.nfs4_unique_id to something based
on /etc/machine_id if it isn't otherwise set.
- we could auto-generate /etc/modprobe.d/00-nfs-identity.conf
  but I suspect that would over-ride anything on the kernel command
  line.
- we could run a tool at boot and when udev notices that the module is
  loaded, and set the parameter if it isn't already set, but that might
  happen after the first mount
- we could get mount.nfs to check-and-set, but that might run in a mount
  namespace which sees a different /etc/machine-id
- we could change the kernel to support another module parameter.
  nfs.nfs4_unique_id_default, and set that via /etc/modprobe.d
  Then the kernel uses it only if nfs4_unique_id is not set.

I think this idea would be sufficiently safe if we could make it work.
I can't see how to make it work without a kernel change - and I don't
really like the kernel change I suggested. 

> 
> I guess I was also under the impression that NFS mount(2) can return
> EADDRINUSE already, but I might be wrong about that.

Maybe it could return EADDRINUSE if all privileged ports were in use ...
I'd need to check that.

> 
> In regard to the general issues around client ID, my approach has been
> to increase the visibility of CLID_INUSE errors. At least on the
> server, there are trace points that fire when this happens. Perhaps
> the server and client could be more verbose about this situation.

I found the RFC a bit unclear here, but my understanding is that
CLID_INUSE will only get generated if krb5 authentication is used for
EXCHANGE_ID, and the credentials for the clients are different.
This is certainly a case worth handling well, but I doubt it would
affect a high proportion of NFS installations.

Or have I misunderstood?

> 
> Our server might also track the last few boot verifiers for a client
> ID, and if it sees them repeating, issue a warning? That becomes
> onerous if there are more than a handful of clients with the same
> co_ownerid, however.

That's an interesting idea.  There would be no guarantees, but I would
probably report some errors, which would be enough to flag to the
problem to the sysadmin.

Thanks,
NeilBrown
