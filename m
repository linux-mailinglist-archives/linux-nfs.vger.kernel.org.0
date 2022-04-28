Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AC5512B15
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Apr 2022 07:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbiD1FuM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 01:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243200AbiD1FuK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 01:50:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7659D35DF5
        for <linux-nfs@vger.kernel.org>; Wed, 27 Apr 2022 22:46:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 153B91F37B;
        Thu, 28 Apr 2022 05:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651124815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jSn3KVAShGG/D51q+t21UuS4+LW5vKSLaQTKrfB2A5I=;
        b=mldwaW3spuHU55LYLQ1l5gotc8VPCRkxARKyEEsv30TgYjJY6uDEGlXvWYHEnNt5jBRCD3
        kJeLR9vIuhUoCPfLAa/+Zn+GlMJAyRyOzLiY3+yk39USf20rZctxmpTFR+SaE1HZLyYX2x
        XgSsLgfjJP07H6r+1UX93l/9E8c3VcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651124815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jSn3KVAShGG/D51q+t21UuS4+LW5vKSLaQTKrfB2A5I=;
        b=PT3De/FojXm9FrJR9be1SuczydQFw+iSb7sOki/S95E4ZSUHF00GGyWR2FqxCbltyYw4ZB
        Rs81jgHvhSo58dBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95DEA13491;
        Thu, 28 Apr 2022 05:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5tnwE00qamIFQAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 28 Apr 2022 05:46:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Daire Byrne" <daire@dneg.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Patrick Goetz" <pgoetz@math.utexas.edu>,
        "linux-nfs" <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
In-reply-to: <CAPt2mGPVWuut=ESWicSw0Ser2PGTeuyb+ACL41N6p_FAAuOUwg@mail.gmail.com>
References: <20220126025722.GD17638@fieldses.org>,
 <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>,
 <CAPt2mGNXq==1KUskF3U6-CDeoX57=d7NW4Qn_esDqarf9bTBaw@mail.gmail.com>,
 <20220211155949.GA4941@fieldses.org>,
 <CAPt2mGOx0qNTWoY9vmyVBtZ3gxdbv5qQ-2qVbtqWW9FiZFRhEg@mail.gmail.com>,
 <164517040900.10228.8956772146017892417@noble.neil.brown.name>,
 <CAPt2mGMLQCEPqsYGeaMd3BPGRne4F4h-2-pzqm1a8nwfKqv1ug@mail.gmail.com>,
 <CAPt2mGMt3Sq66qmPBeGYE0CASTTy7nY2K_LjQK6VZx-uz2P-wg@mail.gmail.com>,
 <20220425132232.GA24825@fieldses.org>,
 <CAPt2mGMtBH=jzK0cTT7+PTbX-iR-iSx1RmF2beCDxBjXY5sj8A@mail.gmail.com>,
 <20220425160236.GB24825@fieldses.org>,
 <CAPt2mGPR9c9=rh4p_D7RPo+4S=DgH7VNpqvOKryKsYwaCAtnJA@mail.gmail.com>,
 <165093700757.1648.16863178337904278508@noble.neil.brown.name>,
 <CAPt2mGPVWuut=ESWicSw0Ser2PGTeuyb+ACL41N6p_FAAuOUwg@mail.gmail.com>
Date:   Thu, 28 Apr 2022 15:46:44 +1000
Message-id: <165112480439.1648.3067400915036759878@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 26 Apr 2022, Daire Byrne wrote:
> On Tue, 26 Apr 2022 at 02:36, NeilBrown <neilb@suse.de> wrote:
> >
> > On Tue, 26 Apr 2022, Daire Byrne wrote:
> > >
> > > I'll stare at fs/nfsd/vfs.c for a bit but I probably lack the
> > > expertise to make it work.
> >
> > Staring at code is good for the soul ....  but I'll try to schedule time
> > to work on this patch again - make it work from nfsd and also make it
> > handle rename.
>=20
> Yea, I stared at it for quite a while this morning and no amount of
> coffee was going to help me figure out how best to proceed.

yes, it isn't at all straight forward - is it?
We probably need quite a bit of surgery in nfsd/vfs.c to make it more
similar to fs/namei.c.  In particularly we will need to use
filename_create() instead of lookup_one_len().

There is a potential cost to doing this though.  The NFS protocol allows
the server to report the change-id of the directory before and after a
create/unlink operation so that the client can determine if it is the
only one making changes to the directory, and so can keep its cache.
This requires the pre/post to be atomic - which requires an exclusive
lock.
If we change nfsd to use a shared lock on the directory, then it cannot
report atomic pre/post attributes, so the client will have to flush its
cache more often.

Support parallel creates and atomic attributes we would need to enhance
the filesystem interface so the fs can report the attributes for each
create.   Could get messy.

This doesn't actually matter for NFS re-export because it doesn't
support atomic attributes anyway.  It also doesn't matter if multiple
clients are changing tghe one directory.  But I think we do want to keep atom=
ic
attributes for exporting other filesystems in other use-cases.

It's starting to get messy.  Not impossible, just messy.  Messy takes
longer :-)

NeilBrown
