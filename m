Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4773B7F0974
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 23:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjKSWf0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 17:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjKSWfZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 17:35:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2125412D
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 14:35:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEB271F381;
        Sun, 19 Nov 2023 22:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700433320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71kfZrbImrhOUXNEGJs/dh09RJf3EuELs7HIwgSQGx8=;
        b=Msy6fKvMBWaqvNaJGhuzAnIa6EZb3Pu3vnms6FBoKo3QKZFzgZoD8ZmN5aQN7nfNSU6DbP
        2hYA1VKT2MNO5H8vu6d2vyFHVdCUaAVIfYtVu2VAboxvao8hjTbBdVoS3DHceLWVKPnbpr
        9eD/lhx45msRhRsNJu+FJhLt72cH6n8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700433320;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71kfZrbImrhOUXNEGJs/dh09RJf3EuELs7HIwgSQGx8=;
        b=Ss+sMch9zYwm6zrTAgn5qFKo08Q+bDq9blYn2JuypvBFxrTqz0tGaLz5wMVuki8gNcwgJ4
        weFnlOeudRuXaOCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 952F8139B7;
        Sun, 19 Nov 2023 22:35:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D3MeEqaNWmVAXwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 19 Nov 2023 22:35:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 3/9] nfsd: split sc_status out of sc_type
In-reply-to: <ZVfEYfslqZDvwW/X@tissot.1015granger.net>
References: <20231117022121.23310-1-neilb@suse.de>,
 <20231117022121.23310-4-neilb@suse.de>,
 <ZVfEYfslqZDvwW/X@tissot.1015granger.net>
Date:   Mon, 20 Nov 2023 09:35:15 +1100
Message-id: <170043331552.19300.14124734701560396770@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 6.39
X-Spamd-Result: default: False [6.39 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[0.999];
         MIME_GOOD(-0.10)[text/plain];
         CLAM_VIRUS_FAIL(0.00)[failed to scan and retransmits exceed];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[44.47%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 18 Nov 2023, Chuck Lever wrote:
> On Fri, Nov 17, 2023 at 01:18:49PM +1100, NeilBrown wrote:
> > sc_type identifies the type of a state - open, lock, deleg, layout - and
> > also the status of a state - closed or revoked.
> >=20
> > This is a bit untidy and could get worse when "admin-revoked" states are
> > added.  So clean it up.
> >=20
> > With this patch, the type is now all that is stored in sc_type.  This is
> > zero when the state is first added to ->cl_stateids (causing it to be
> > ignored), and is then set appropriately once it is fully initialised.
> > It is set under ->cl_lock to ensure atomicity w.r.t lookup.  It is now
> > never cleared.
> >=20
> > sc_type is still a bit-set even though at most one bit is set.  This allo=
ws
> > lookup functions to be given a bitmap of acceptable types.
> >=20
> > cl_type is now an unsigned short rather than char.  There is no value in
>=20
> s/cl_type/sc_type
>=20
>=20
> > restricting to just 8 bits.  When passed to a function or stored in local
> > variable, "unsigned int" is used.
>=20
> This seems confusing, and I'd prefer not to introduce implicit type
> conversions where they aren't truly necessary. Why not use "unsigned
> short" or even "unsigned int" everywhere?
>=20

Not really a type conversion - just a size change.
Maybe I could use
   unsigned int sc_type:16, sc_stats:16;
and use unsigned int everywhere?

Maybe it is confusing...  maybe I'll just make it unsigned short
everywhere.=20

Thanks,
NeilBrown
