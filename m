Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540917F09D6
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 00:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjKSXWA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 18:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSXWA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 18:22:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7F112D
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 15:21:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 716FC1F74A;
        Sun, 19 Nov 2023 23:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700436115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5sW60m8r+jjM2DZGTaHYRSXuTNCBFFXoO1T02gH29U=;
        b=ITQIRVCZJ7fsAVTN2yp83mfQSkWgZ7TiaeU++8hL8E4c0nBMq0OJxh8o2fCDHNwmNzjlzh
        z5vEj78GhwBwlSMEryKS/vq+9judAHFV4QnPJzi+L8nJHl0iBimxT8lam6UEB1q3TCOpVx
        LRwpRYWW2lz7MvGdKRzKmxYs67Pu1n8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700436115;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5sW60m8r+jjM2DZGTaHYRSXuTNCBFFXoO1T02gH29U=;
        b=GCOw/hNmaGy+a4dQE2UtIp5l2Y1tfTEWQzH/KFcRIUCT6BzqAO4+j2Y5KWLSEGSIU7yX0n
        AxgR8mg4jnWwogBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CBBC1377F;
        Sun, 19 Nov 2023 23:21:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1W18AJGYWmV7cQAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 19 Nov 2023 23:21:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 0/9 v3] support admin-revocation of v4 state
In-reply-to: <9e18d992cdccf56d26482adc8c1c4a6012c68f8e.camel@kernel.org>
References: <20231117022121.23310-1-neilb@suse.de>,
 <9e18d992cdccf56d26482adc8c1c4a6012c68f8e.camel@kernel.org>
Date:   Mon, 20 Nov 2023 10:21:49 +1100
Message-id: <170043610989.19300.5572465091839523991@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 6.40
X-Spamd-Result: default: False [6.40 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[38.72%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 17 Nov 2023, Jeff Layton wrote:
> On Fri, 2023-11-17 at 13:18 +1100, NeilBrown wrote:
> > This set adds a prequel series to my previous posting which addresses
> > some locking problems around ->sc_type and splits that field into
> > to separate fields: sc_type and sc_status.
> > The recovation code is modified to accomodate these changed.
> > 
> > Thanks
> > NeilBrown
> > 
> >  [PATCH 1/9] nfsd: hold ->cl_lock for hash_delegation_locked()
> >  [PATCH 2/9] nfsd: avoid race after unhash_delegation_locked()
> >  [PATCH 3/9] nfsd: split sc_status out of sc_type
> >  [PATCH 4/9] nfsd: prepare for supporting admin-revocation of state
> >  [PATCH 5/9] nfsd: allow admin-revoked state to appear in
> >  [PATCH 6/9] nfsd: allow admin-revoked NFSv4.0 state to be freed.
> >  [PATCH 7/9] nfsd: allow lock state ids to be revoked and then freed
> >  [PATCH 8/9] nfsd: allow open state ids to be revoked and then freed
> >  [PATCH 9/9] nfsd: allow delegation state ids to be revoked and then
> > 
> 
> Nice set. I like this overall. One (other) question: do we need to add
> handling for revoking layout stateids as well?

I guess so... I don't give much thought to layout stateids.
They are used in LAYOUTGET LAYOUTCOMMIT LAYOUTRETURN.
(it's seems odd that they aren't used in READ/WRITE....)

I guess we need to drop the ref on ->ls_file and maybe unlock the vfs
lease....

I wonder if I should just use ->sc_free for that.

Maybe ->sc_free could take a 'revoke_only' arg which causes it to free
resources but not free the stateid itself.
Maybe that would make the code cleaner.

NeilBrown


> 
> I'll plan to pull this into my local branch for some testing over the
> weekend.
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

