Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787464BD7E3
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 09:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbiBUIAL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 03:00:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346742AbiBUIAF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 03:00:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E95121E22
        for <linux-nfs@vger.kernel.org>; Sun, 20 Feb 2022 23:59:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0EBCE212BD;
        Mon, 21 Feb 2022 07:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645430375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyrW6bGjdA6bWRy082qiiOfb3YbCLD/JuAPvmBqgGOY=;
        b=Rv8HMhuANOZFFBj1CdWzNyab3F7A/+XNGfBNAUzr7vusyh2oiJTBVY/2+O9sXd91JgTJ6r
        3QaAqfYsIzSVfSCEEthYPxWn8jy4xx5suh+YiCwRqoJyjvEpPFLbxx+waR9e4SxAoG0fka
        pHAt2aMRuikqPxvwPcx4RpA0dkjABLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645430375;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyrW6bGjdA6bWRy082qiiOfb3YbCLD/JuAPvmBqgGOY=;
        b=389sMAkS9tFYCwuW8GohqT8tfifV67XUJM3REv5h/U9+0C9RrTacpJGwSRfyTxlA6K0TU/
        bhgwDO5sJ8VieqDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E57B313322;
        Mon, 21 Feb 2022 07:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IJ4ZKGRGE2JcVwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 21 Feb 2022 07:59:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: NFSv4 versus NFSv3 parallel client op/s
In-reply-to: <194829a2c280364faa6e9c70dbaee463101453a7.camel@hammerspace.com>
References: <CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com>,
 <6b528d29-1a9c-d16e-f649-5d994d6222b8@talpey.com>,
 <CAPt2mGOnbN=N5TqCWzVtX7CYoptpknCbnSXGfoX8X87DsvhoKw@mail.gmail.com>,
 <3849f322-94f7-fe73-4e08-1660be516384@talpey.com>,
 <66383037-8263-4D7B-B96C-C9CED24042FC@oracle.com>,
 <164523140095.10228.17507004698722847604@noble.neil.brown.name>,
 <194829a2c280364faa6e9c70dbaee463101453a7.camel@hammerspace.com>
Date:   Mon, 21 Feb 2022 18:59:15 +1100
Message-id: <164543035585.17923.4120371632609985618@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 19 Feb 2022, Trond Myklebust wrote:
> On Sat, 2022-02-19 at 11:43 +1100, NeilBrown wrote:
> > On Sat, 19 Feb 2022, Chuck Lever III wrote:
> > > 
> > > For the Linux NFS server, there is an enhancement request open
> > > in this area:
> > > 
> > > https://bugzilla.linux-nfs.org/show_bug.cgi?id=375
> > > 
> > > If there are any relevant design notes or performance results,
> > > that would be the place to put them.
> > 
> > I wonder if I have a login there..
> > 
> 
> If you're having trouble setting one up, then let me know. I should be
> able to help.

Thanks.  I couldn't find any evidence in email history of ever having
one, so I tried creating one and it went completely smoothly. :-)

NeilBrown
