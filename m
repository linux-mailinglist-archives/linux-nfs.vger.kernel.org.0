Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E5E5FE51C
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Oct 2022 00:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJMWOv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Oct 2022 18:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMWOu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Oct 2022 18:14:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539F617A87
        for <linux-nfs@vger.kernel.org>; Thu, 13 Oct 2022 15:14:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B37211F855;
        Thu, 13 Oct 2022 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665699287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZIGyGSt7rJ5evJ6rF5buUouYwQaBnhbBVbBn64ECL08=;
        b=qopsLfE2NNsL+jkDeErf/Nxp4uese2JqNWIuBKcldrz/w7TwK1iii/Qz3Vyzp0yTXiOi78
        in6spD11Wu5Uyd2M4l1O+ffoTyiGjaBzSXHTRz9Ee2fteRR/1Q+5t/lJAK0r4WKcoZrEpO
        QHpEIkIozVoJpleAO7debfbkYaOYkZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665699287;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZIGyGSt7rJ5evJ6rF5buUouYwQaBnhbBVbBn64ECL08=;
        b=NSzIKIbseGWXFoT9JQajDOoeXFu8uVCSK52cm4A73YUEvfN7Ifyua79OxQKAU0E4eoe4wS
        Ecndrq8LXAl37UBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C99B613AAA;
        Thu, 13 Oct 2022 22:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2rqYH9aNSGMgYAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 13 Oct 2022 22:14:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] NFSD: Use rhashtable for managing nfs4_file objects
In-reply-to: <E69F66C3-C17E-4397-8329-8B6C2D2E2F0F@oracle.com>
References: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>,
 <166507324882.1802.884870684212914640.stgit@manet.1015granger.net>,
 <166544739751.14457.9018300177489236723@noble.neil.brown.name>,
 <EB08B095-BF02-4B5E-8CD2-12B0201328D2@oracle.com>,
 <166553144435.32740.14940127200777208215@noble.neil.brown.name>,
 <4004BFE1-C887-4A53-9512-8A264E0361FF@oracle.com>,
 <166560951668.32740.3528791072339550207@noble.neil.brown.name>,
 <E69F66C3-C17E-4397-8329-8B6C2D2E2F0F@oracle.com>
Date:   Fri, 14 Oct 2022 09:14:42 +1100
Message-id: <166569928288.32740.15383309396957908665@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 14 Oct 2022, Chuck Lever III wrote:
> 
> > On Oct 12, 2022, at 5:18 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Thu, 13 Oct 2022, Chuck Lever III wrote:
> >> 
> >> I think I stopped at the non-list variant of rhashtable because
> >> using rhl was more complex, and the non-list variant seemed to
> >> work fine. There's no architectural reason either file_hashtbl
> >> or the filecache must use the non-list variant.
> >> 
> >> In any event, it's worth taking the trouble now to change the
> >> nfs4_file implementation proposed here as you suggest.
> > 
> > If you like you could leave it as-is for now and I can provide a patch
> > to convert to rhl-tables later (won't be until late October).
> > There is one thing I would need to understand though: why are the
> > nfsd_files per-filehandle instead of per-inode?  There is probably a
> > good reason, but I cannot think of one.
> 
> I'm not clear on your offer: do you mean converting the nfsd_file
> cache from rhashtable to rhl, or converting the proposed nfs4_file
> rework? I had planned to do the latter myself and post a refresh.

Either/both.  Of course if you do the refresh, then I'll just review it.

> 
> The nfsd_file_acquire API is the only place that seems to want a
> filehandle, and it's just to lookup the underlying inode. Perhaps
> I don't understand your question?

Sorry, I meant nfs4_files, not nfsd_file: find_file() and find_or_add_file().
Why is there one nfs4_file per filehandle

I see that there can be several nfsd_file per inode - in different
network namespaces, or with different credentials or different access
modes.  That really needs to be fixed.

Thanks,
NeilBrown
