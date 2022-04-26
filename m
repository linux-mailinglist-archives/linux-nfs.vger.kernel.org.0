Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E57950EE1C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Apr 2022 03:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiDZBkB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Apr 2022 21:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbiDZBkA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Apr 2022 21:40:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEDB237CB
        for <linux-nfs@vger.kernel.org>; Mon, 25 Apr 2022 18:36:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A4AB210EC;
        Tue, 26 Apr 2022 01:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650937012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8O1lpyGwE1KynYbKWDSjMiInKLW82QFg41pztWg7qBM=;
        b=m0XAklW4dmBPDshNAXFJW8REuvbVAW3/9pjnxPjzPKDiXgDpURJYwUdySXR4lRq9rd850N
        oEU4B+4V4JQmeB2qen530ue1qI3B0N4gu44ZDlhDxGeTvuz7RTmpW4P9gANzY6oHAEqYdP
        nv0Q0B+JSucIbLFlmFQYjycru36lBI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650937012;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8O1lpyGwE1KynYbKWDSjMiInKLW82QFg41pztWg7qBM=;
        b=Vmery/4OYJJaaeYkrHSgXTmQJyjCekekxtxLkIFzRerAMMApt1DNx03CIJWb279XHInyBs
        jmEFiK2sEqXjI2BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2739213A97;
        Tue, 26 Apr 2022 01:36:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2ROwNLJMZ2KRCAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Apr 2022 01:36:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Daire Byrne" <daire@dneg.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Patrick Goetz" <pgoetz@math.utexas.edu>,
        "linux-nfs" <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
In-reply-to: <CAPt2mGPR9c9=rh4p_D7RPo+4S=DgH7VNpqvOKryKsYwaCAtnJA@mail.gmail.com>
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
 <CAPt2mGPR9c9=rh4p_D7RPo+4S=DgH7VNpqvOKryKsYwaCAtnJA@mail.gmail.com>
Date:   Tue, 26 Apr 2022 11:36:47 +1000
Message-id: <165093700757.1648.16863178337904278508@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 26 Apr 2022, Daire Byrne wrote:
> 
> I'll stare at fs/nfsd/vfs.c for a bit but I probably lack the
> expertise to make it work.

Staring at code is good for the soul ....  but I'll try to schedule time
to work on this patch again - make it work from nfsd and also make it
handle rename.

> 
> It's also not entirely clear that this parallel creates RFC patch will
> ever make it into mainline?

I hope it will eventually, but I have no idea when that might be.

Thanks for your continued interest,
NeilBrown
