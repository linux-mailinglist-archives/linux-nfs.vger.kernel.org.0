Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D384E1EFB
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Mar 2022 03:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbiCUCQC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Mar 2022 22:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiCUCQB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 20 Mar 2022 22:16:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8963AA6F
        for <linux-nfs@vger.kernel.org>; Sun, 20 Mar 2022 19:14:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B2221F37C;
        Mon, 21 Mar 2022 02:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647828876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXbV/wVKDeEge03VzZeZXtVmnP3b3MHuuRfa3SrngAM=;
        b=znT13aiY5AB9WL+5kumKkmg3ZS7Y9FtWY8s7QGPd1jFz7ESutKBboHeM1Gs42Q77J4Twtb
        6STOma9hCsi4INXWKn8pfHfb/WRuQC5mFRhb6xzCKKvYgcdUlqISAdlNyYwPEUN+/J1SQA
        133IWEknCyZCs4/rBH03kc07FrkamL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647828876;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXbV/wVKDeEge03VzZeZXtVmnP3b3MHuuRfa3SrngAM=;
        b=giGIs9l9MXQx7bhJzhKpOST1TjWf4aVazNl8E8oEplAmZklQJMgOI4drJ4sjotCGXyhTo6
        j813ajGD3nr4T2BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24B6B133DD;
        Mon, 21 Mar 2022 02:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dg+TNInfN2LdQQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 21 Mar 2022 02:14:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Benjamin Coddington" <bcodding@redhat.com>,
        "Steve Dickson" <SteveD@RedHat.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Trond Myklebust" <trondmy@hammerspace.com>
Subject: Re: [PATCH v2] nfs.man: document requirements for NFSv4 identity
In-reply-to: <9D0A7A61-BCF4-4A1B-B462-5F1402EE0B2E@oracle.com>
References: <164721984672.11933.15475930163427511814@noble.neil.brown.name>,
 <ED6618CE-EC09-448D-904C-F34FCE8E8935@oracle.com>,
 <164730488811.11933.18315180827167871419@noble.neil.brown.name>,
 <9A7BF2ED-E125-4FEF-B984-C343C9E142F0@oracle.com>,
 <164756881642.24302.4153094189268832687@noble.neil.brown.name>,
 <9D0A7A61-BCF4-4A1B-B462-5F1402EE0B2E@oracle.com>
Date:   Mon, 21 Mar 2022 13:14:29 +1100
Message-id: <164782886934.24302.3305618822276162890@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 19 Mar 2022, Chuck Lever III wrote:
> 
> Here are some suggestions that might make it simpler to implement.
> 
> 1. Ben's tool manufactures the uniqifier if the file doesn't
>    already exist. That seems somewhat racy. Instead, why not
>    make installation utilities responsible for creating the
>    uniquifier? We need some guarantee that when a VM is cloned,
>    the uniquifier is replaced, for instance; that's well
>    outside nfs-utils' sphere of influence.

You say "the file" like that is a well defined concept.  It isn't.
In the context of a container we don't even know if there is *any*
stable local storage.
The existence of "the file" is as much out side of nfs-util's sphere of
influence as the cloning of a VM is.
At least the cloning of a VM is, or soon will be
(https://lwn.net/Articles/887207/), within the sphere of influence of
the NFS kernel module.  It will be able to detect the fork and ....  do
something.  Maybe disable access to all existing mounts and refuse new
mounts until 'identity' has been set.

If NFS had always required identity to be set in a container before
allowing mounts, then the udev approach could work and we would be in a
much better place.  But none of us knew that then, and it is too late
for that now (is it?).

This conversation seems to be going around in circles and not getting
anywhere.  As as I have no direct interest (the SUSE bugzilla has
precisely 1 bug relating to NFS and non-unique hostnames, and the
customer seemed to accept the requirement of unique hostnames) I am
going to bow out.  I might post one more attempt at a documentation
update ... or I might not.

Thanks,
NeilBrown
