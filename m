Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBD77DDB4D
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 04:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346237AbjKADBr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 23:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbjKADBp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 23:01:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06BFA4
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 20:01:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50CA72184E;
        Wed,  1 Nov 2023 03:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698807698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8GRcTqTiS/dLllUCp3Rt95yASrb17PLxHKDPTOR59k=;
        b=LSydD/RJCcCx7sq89n5BHD5RSd/BM1j0/ZtJF/Qy4ed5lvoTVYZhfMd5TDcP5tppun2Ab+
        tR/5z8BqsE1TYJltaQJX5Wl+2rDUCpF+SfemiyiLqnCRn0XTbWj1R59SVUsTPa6DuGQNry
        /xpE+pNAEyPZ4ayYjLxXtpTU3/PpnZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698807698;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8GRcTqTiS/dLllUCp3Rt95yASrb17PLxHKDPTOR59k=;
        b=izESZvafx7ObgWp0PscfR8xtfMtyFKAvlnwpVJMO/hi5Dy54j/XIvbcgJ30VP7d/Jnyehy
        Sz+Ih8U7FanIbECg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45B19138EC;
        Wed,  1 Nov 2023 03:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HbphO4+/QWX8aAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 01 Nov 2023 03:01:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 6/6] nfsd: allow delegation state ids to be revoked and then freed
In-reply-to: <4C3DBAFF-4C83-4DB4-A6C6-D9C4387BF1F4@oracle.com>
References: <20231101010049.27315-1-neilb@suse.de>,
 <20231101010049.27315-7-neilb@suse.de>,
 <4C3DBAFF-4C83-4DB4-A6C6-D9C4387BF1F4@oracle.com>
Date:   Wed, 01 Nov 2023 14:01:33 +1100
Message-id: <169880769331.24305.7672914147957308642@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 01 Nov 2023, Chuck Lever III wrote:
> Howdy Neil-
> 
> > On Oct 31, 2023, at 5:57 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > Revoking state through 'unlock_filesystem' now revokes any delegation
> > states found.  When the stateids are then freed by the client, the
> > revoked stateids will be cleaned up correctly.
> 
> Here's my derpy question of the day.
> 
> "When the stateids are then freed by the client" seems to be
> a repeating trope, and it concerns me a bit (probably because
> I haven't yet learned how this mechanism /currently/ works)...
> 
> In the case when the client has actually vanished (eg, was
> destroyed by an orchestrator), it's not going to be around
> to actively free revoked state. Doesn't that situation result
> in pinned state on the server? I would expect that's a primary
> use case for "unlock_filesystem."

If a client is de-orchestrated then it will stop renewing its lease, and
regular cleanup of expired state will kick in after one lease period.
So for NFSv4 we don't need to worry about disappearing clients.
For NFSv3 (or more specifically for NLM) we did and locks could hang
around indefinitely if the client died.
For that reason we have /proc/fs/nfsd/unlock_ip which discards all NFSv3
lock state for a given client.  Extending that to NFSv4 is not needed
because of leases, and not meaningful because of trunking - a client
might have several IP's.

unlock_filesystem is for when the client is still active and we want to
let it (them) continue accessing some filesystems, but not all.

NeilBrown


> 
> Maybe I've misunderstood something fundamental.
> 
> 
> --
> Chuck Lever
> 
> 
> 

