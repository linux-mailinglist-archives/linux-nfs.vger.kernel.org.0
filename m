Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A77B4D0CEF
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Mar 2022 01:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiCHApn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Mar 2022 19:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbiCHApl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Mar 2022 19:45:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1873F3FD95
        for <linux-nfs@vger.kernel.org>; Mon,  7 Mar 2022 16:44:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20D8B210F6;
        Tue,  8 Mar 2022 00:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646700284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H287JkfM0pgsX2YVNWuwkE6wMb8BfJREfNdSLTgAtc8=;
        b=Wkcspy/7RE2qfgGC9R/a3GkzX9ypNBZ77V1g/vjKjzsrFHWoFnvwRmFgOfg3BpbFaDWbag
        8BNWRzV3IUYHQr2YLb6Y7dgLKIBIWI6zg9b8mvifhqC+iMXtKboIASjDwb+nqE6xY1GNOe
        MXAJvf2iYDlZFgDY1vR5ql4i0Foy5Ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646700284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H287JkfM0pgsX2YVNWuwkE6wMb8BfJREfNdSLTgAtc8=;
        b=EF8MIOn8R/MMCkz8AhJ4zfFfLnoeiwxU4BtN9CSgFayc3NbQPpjcnRGKSsWwvuBjsB2UeZ
        47hnyWZdhIBq0xCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD47013BE6;
        Tue,  8 Mar 2022 00:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eHvYGvqmJmJdfAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 08 Mar 2022 00:44:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Benjamin Coddington" <bcodding@redhat.com>,
        "Steve Dickson" <SteveD@RedHat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs.man: document requirements for NFS mounts in a container
In-reply-to: <1872EF26-5C7D-4C5D-A425-11548477BAA6@oracle.com>
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
 <1872EF26-5C7D-4C5D-A425-11548477BAA6@oracle.com>
Date:   Tue, 08 Mar 2022 11:44:38 +1100
Message-id: <164670027879.4945.3527837295426794022@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 04 Mar 2022, Chuck Lever III wrote:
> 
> 2. NAT
> 
> NAT hasn't been mentioned before, but it is a common
> deployment scenario where multiple clients can have the
> same hostname and local IP address (a private address such
> as 192.168.0.55) but the clients all access the same NFS
> server.

I can't see how NAT is relevant.  Whether or not clients have the same
host name seems to be independent of whether or not they access the
server through NAT.
What am I missing?
> 
> The client's identifier needs to be persistent so that:
> 
> 1. If the server reboots, it can recognize when clients
>    are re-establishing their lock and open state versus
>    an unfamiliar creating lock and open state that might
>    involve files that an existing client has open.

The protocol request clients which are re-establishing state to
explicitly say "I am re-establishing state" (e.g. CLAIM_PREVIOUS).
clients which are creating new state don't make that claim.

IF the server maintainer persistent state, then the reboot server needs
to use the client identifier to find the persistent state, but that is
not importantly different from the more common situation of a server
which hasn't rebooted and needs to find the appropriate state.

Again - what am I missing?


Thanks,
NeilBrown
