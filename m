Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCF84D3E47
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Mar 2022 01:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbiCJAiR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 19:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbiCJAiP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 19:38:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13261052A3
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 16:37:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 617941F381;
        Thu, 10 Mar 2022 00:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646872634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1L4H+D2pP7gWSOkerYHVyOKuobUFLZ6yNCb2YdCGSQ=;
        b=EFAb9LOZRWrt4v/xQYySIMopdYlwLpJ0yQjaYahMRTX+SPhFpo7df5eiHKfIv6I5zgYNKM
        NxR/hQwSmJV02vN5LfbWqhdAc47IJEu2Z5jz05IUXopKLzAOi4kMHYYBZ4gANnsvwniRKo
        V9ED90GLE0ivsX+lpYVn8ZCudyJ/pIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646872634;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1L4H+D2pP7gWSOkerYHVyOKuobUFLZ6yNCb2YdCGSQ=;
        b=zxqNp7ax4ezFAU8W4ppWalHJVrnzeMwWKK5fcUP2cyq0AEcxaluHo4ln6wTtx0hUeGhfE3
        ijUDOr/TkbYN/hBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E79C513D80;
        Thu, 10 Mar 2022 00:37:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ITM6JzhIKWKiKQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 10 Mar 2022 00:37:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Benjamin Coddington" <bcodding@redhat.com>,
        "Steve Dickson" <SteveD@RedHat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs.man: document requirements for NFS mounts in a container
In-reply-to: <398125AD-7CA8-4DAA-80BD-5F65A28FD633@oracle.com>
References: <cover.1644515977.git.bcodding@redhat.com>,
 <7642FA55-F3F2-4813-86E2-1B65185E6B36@oracle.com>,
 <3d2992df-7ef7-50ba-4f11-f4de588620d2@redhat.com>,
 <DDB59BD9-8C29-45C3-ABAF-B25EDDB63E09@oracle.com>,
 <D0908E76-C163-4DBF-A93C-665492EB9DB2@redhat.com>,
 <E2C56D5B-AC77-48D1-9AF6-268406648657@oracle.com>,
 <4657F9AE-3B9E-4992-9334-3FF1CF18EF31@redhat.com>,
 <C7533D80-25B3-4722-94A9-0440C48B8574@oracle.com>,
 <945849B4-BE30-434C-88E9-8E901AAFA638@redhat.com>,
 <06B01290-E375-455E-A6D7-419CA653A0D1@oracle.com>,
 <948D8123-E310-4A35-BF04-C030F20EA83C@redhat.com>,
 <164479707170.27779.15384523062754338136@noble.neil.brown.name>,
 <863AB69A-D5D6-4F22-950C-E5F468CD4552@redhat.com>,
 <42AAFEDD-F4EE-4A91-BD23-E08B1149EF1C@oracle.com>,
 <3AF29DC6-2EEB-4C3E-BD6C-BE31910921AE@redhat.com>,
 <9FC005FB-370E-4AFA-AD80-8599CBFCC1E0@oracle.com>,
 <2965D098-7AEE-419D-BF8B-4D7AF4AB40FB@redhat.com>,
 <164505339057.10228.4638327664904213534@noble.neil.brown.name>,
 <164610623626.24921.6124450559951707560@noble.neil.brown.name>,
 <F285A122-30EC-4353-AF10-FBF6999B7F25@oracle.com>,
 <164627798608.17899.14049799069550646947@noble.neil.brown.name>,
 <1872EF26-5C7D-4C5D-A425-11548477BAA6@oracle.com>,
 <164670027879.4945.3527837295426794022@noble.neil.brown.name>,
 <398125AD-7CA8-4DAA-80BD-5F65A28FD633@oracle.com>
Date:   Thu, 10 Mar 2022 11:37:06 +1100
Message-id: <164687262682.31932.7728659964479483027@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 10 Mar 2022, Chuck Lever III wrote:
> 
> > On Mar 7, 2022, at 7:44 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Fri, 04 Mar 2022, Chuck Lever III wrote:
> >> 
> >> 2. NAT
> >> 
> >> NAT hasn't been mentioned before, but it is a common
> >> deployment scenario where multiple clients can have the
> >> same hostname and local IP address (a private address such
> >> as 192.168.0.55) but the clients all access the same NFS
> >> server.
> > 
> > I can't see how NAT is relevant.  Whether or not clients have the same
> > host name seems to be independent of whether or not they access the
> > server through NAT.
> > What am I missing?
> 
> The usual construction of Linux's nfs_client_id4 includes
> the hostname and client IP address. If two clients behind
> two independent NAT boxes happen to use the same private
> IP address and the same hostname (for example
> "localhost.localdomain" is a common misconfiguration) then
> both of these clients present the same nfs_client_id4
> string to the NFS server.
> 
> Hilarity ensues.

This would only apply to NFSv4.0 (and without migration enabled).
NFSv4.1 and later don't include the IP address in the client identity.

So I think the scenario you describe is primarily a problem of the
hostname being misconfigured.  In NFSv4.0 the normal variety of IP
address can hide that problem.  IF NAT Is used in such a way that two
clients are configured with the same IP address, the defeats the hiding.

I don't think the extra complexity of NAT really makes this more
interesting.   The problem is uniform hostnames, and the fix is the same
for any other case of uniform host names.

> 
> 
> >> The client's identifier needs to be persistent so that:
> >> 
> >> 1. If the server reboots, it can recognize when clients
> >>   are re-establishing their lock and open state versus
> >>   an unfamiliar creating lock and open state that might
> >>   involve files that an existing client has open.
> > 
> > The protocol request clients which are re-establishing state to
> > explicitly say "I am re-establishing state" (e.g. CLAIM_PREVIOUS).
> > clients which are creating new state don't make that claim.
> > 
> > IF the server maintainer persistent state, then the reboot server needs
> > to use the client identifier to find the persistent state, but that is
> > not importantly different from the more common situation of a server
> > which hasn't rebooted and needs to find the appropriate state.
> > 
> > Again - what am I missing?
> 
> The server records each client's nfs_client_id4 and its
> boot verifier.
> 
> It's my understanding that the server is required to reject
> CLAIM_PREVIOUS opens if it does not recognize either the
> nfs_client_id4 string or its boot verifier, since that
> means that the client had no previous state during the last
> most recent server epoch.

I think we are saying the same thing with different words.
When you wrote

    If the server reboots, it can recognize when clients
    are re-establishing their lock and open state 

I think that "validate" is more relevant than "recognize".  The server
knows from the request that an attempt is being made to reestablish
state.  The client identity, credential, and boot verifier are used
to validate that request.

But essentially we are on the same page here.

Thanks,
NeilBrown
