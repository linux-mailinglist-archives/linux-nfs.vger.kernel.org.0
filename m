Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F565584953
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jul 2022 03:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiG2B3d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 21:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2B3d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 21:29:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8BF52DD6
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 18:29:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C8C9371EB;
        Fri, 29 Jul 2022 01:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659058155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8nh9T/OH7VjG9IjEklDmZQjKG6QCDyCYEkKuFgCN8Ao=;
        b=W9yD/VGhhvN7YX1rU0/o1cS1v3iiouK0WRoEdgf00v8T6SXpn6IAzPV6fhKSloncaj3BBf
        h7Zb/0lUPjeuXBEa8ghhRByRlLJMnpxh1Ytk7NyEPKJ3lFBSulay9UCcvqwqpnaDcV54+z
        yPpItH9ItkIMiraz2Xn/S5E7fT5vsik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659058155;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8nh9T/OH7VjG9IjEklDmZQjKG6QCDyCYEkKuFgCN8Ao=;
        b=ZttsdGA0uzIWrO8i6fDxT5ffcTNch0hL5wb1zbHIE1b2gPX+DBzx5sF9FmARPs5sacQwU4
        uT3PPuCxfqsBX2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5912613A7E;
        Fri, 29 Jul 2022 01:29:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2fcsBeo342LFPgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 29 Jul 2022 01:29:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/13] NFSD: clean up locking
In-reply-to: <44AD17F0-FC0B-4F20-BCED-071CD70DFBBC@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>,
 <44AD17F0-FC0B-4F20-BCED-071CD70DFBBC@oracle.com>
Date:   Fri, 29 Jul 2022 11:29:11 +1000
Message-id: <165905815102.4359.6022541493569857679@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 29 Jul 2022, Chuck Lever III wrote:
> 
> > On Jul 26, 2022, at 2:45 AM, NeilBrown <neilb@suse.de> wrote:
> > 
> > This is the latest version of my series to clean up locking -
> > particularly of directories - in preparation for proposed patches which
> > change how directory locking works across the VFS.
> > 
> > I've included Jeff's patches to validate the dentry after getting a
> > delegation.  The second patch has been changed quite a bit to use
> > nfsd_lookup_dentry(). I've left Jeff's From: line in place - let me know
> > if you'd rather I change it.
> > 
> > Setting of ACLs and security labels has been moved from nfs4 code to
> > nfsd_setattr() which allows quite a lot of code cleanup.
> > 
> > I think I've addressed all the concerns that have been raised, though
> > maybe not in the way that was suggested.
> > 
> > I've tested this with cthon tests over v2, v3, v4.0, v4.1, and xfstests
> > on v3 and v4.1, and pynfs 4.0, 4.1.  No problems appeared.
> > 
> > Thanks,
> > NeilBrown
> 
> Hi Neil-
> 
> No objections to this round, looks like a very good set of clean-ups.
> 
> I've also resurrected NFSv2 on my test systems, and captured a baseline
> without these patches applied.
> 
> There are a number of cosmetic issues I found, posting those separately.
> If you trust me, I can take care of those here, or you can submit a
> v3 (v4?).

I would love for you to make those changes yourself!
As I noted separately there is a bug : nfserrno() needed where you
suggested __be32.
All others are cosmetic and I trust you to fix those up however seems
best.

Thanks,
NeilBrown

