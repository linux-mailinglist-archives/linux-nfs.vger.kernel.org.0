Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EEA7DDD5F
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 08:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjKAHnY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Nov 2023 03:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjKAHnY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Nov 2023 03:43:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F38C2
        for <linux-nfs@vger.kernel.org>; Wed,  1 Nov 2023 00:43:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F10481F74A;
        Wed,  1 Nov 2023 07:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698824596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQeIMZZsHiJhjQyjmdP6tO8zlKf+zKx9pvF/QxSQLNM=;
        b=MbyHB/TxMsdVzsozYeQ4JGshNBaeNMDFUDRbOMm6WvyqsR6LpOuyvAfGTAtWWYasR8au6M
        kEwZiEYnf0fy2GZDgcQ7R0PROvzUekHfAh/HzSQWZf/5nV06rX3/rVzfnxCmGoJnRFQ/3i
        eZfjgSCP1sHPY9odx4Z8RoHRBP2oaeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698824596;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQeIMZZsHiJhjQyjmdP6tO8zlKf+zKx9pvF/QxSQLNM=;
        b=sfwIZMtOzj6L+Q6R09OtkReSLRkw51hEI4OChSTNLycRgeQDTpmynp/vIxvTglor13z05j
        jc//SEcRuBsY5iCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3AF71348D;
        Wed,  1 Nov 2023 07:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Iu1bJpIBQmXeWAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 01 Nov 2023 07:43:14 +0000
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
In-reply-to: <D2B988F4-D8F5-4A5A-BC97-F67D19A76C78@oracle.com>
References: <20231101010049.27315-1-neilb@suse.de>,
 <20231101010049.27315-7-neilb@suse.de>,
 <4C3DBAFF-4C83-4DB4-A6C6-D9C4387BF1F4@oracle.com>,
 <169880769331.24305.7672914147957308642@noble.neil.brown.name>,
 <D2B988F4-D8F5-4A5A-BC97-F67D19A76C78@oracle.com>
Date:   Wed, 01 Nov 2023 18:43:11 +1100
Message-id: <169882459188.24305.13216722681220510683@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 01 Nov 2023, Chuck Lever III wrote:
> 
> > On Oct 31, 2023, at 8:01 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Wed, 01 Nov 2023, Chuck Lever III wrote:
> >> Howdy Neil-
> >> 
> >>> On Oct 31, 2023, at 5:57 PM, NeilBrown <neilb@suse.de> wrote:
> >>> 
> >>> Revoking state through 'unlock_filesystem' now revokes any delegation
> >>> states found.  When the stateids are then freed by the client, the
> >>> revoked stateids will be cleaned up correctly.
> >> 
> >> Here's my derpy question of the day.
> >> 
> >> "When the stateids are then freed by the client" seems to be
> >> a repeating trope, and it concerns me a bit (probably because
> >> I haven't yet learned how this mechanism /currently/ works)...
> >> 
> >> In the case when the client has actually vanished (eg, was
> >> destroyed by an orchestrator), it's not going to be around
> >> to actively free revoked state. Doesn't that situation result
> >> in pinned state on the server? I would expect that's a primary
> >> use case for "unlock_filesystem."
> > 
> > If a client is de-orchestrated then it will stop renewing its lease, and
> > regular cleanup of expired state will kick in after one lease period.
> 
> Thanks for educating me.
> 
> Such state actually stays around for much longer now as
> expired but renewable state. Does unlock_filesystem need
> to purge courtesy state too, to make the target filesystem
> unexportable and unmountable?

I don't think there is any special case there that we need to deal with.
I haven't explored in detail but I think "courtesy" state is managed at
the client level.  Some clients still have valid leases, others are
being maintained only as a courtesy.  At the individual state level
there is no difference.  The "unlock_filesystem" code examines all
states for all client and selects those for the target filesystem and
revokes those.

NeilBrown


> 
> 
> > So for NFSv4 we don't need to worry about disappearing clients.
> > For NFSv3 (or more specifically for NLM) we did and locks could hang
> > around indefinitely if the client died.
> > For that reason we have /proc/fs/nfsd/unlock_ip which discards all NFSv3
> > lock state for a given client.  Extending that to NFSv4 is not needed
> > because of leases, and not meaningful because of trunking - a client
> > might have several IP's.
> > 
> > unlock_filesystem is for when the client is still active and we want to
> > let it (them) continue accessing some filesystems, but not all.
> > 
> > NeilBrown
> > 
> > 
> >> 
> >> Maybe I've misunderstood something fundamental.
> >> 
> >> 
> >> --
> >> Chuck Lever
> 
> 
> --
> Chuck Lever
> 
> 
> 

