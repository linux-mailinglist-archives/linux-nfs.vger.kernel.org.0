Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6EB7F0976
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 23:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjKSWk7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 17:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKSWk6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 17:40:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6612D
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 14:40:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ABFBA218EA;
        Sun, 19 Nov 2023 22:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700433653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGk6YNOW6yEdrFd50gkSj0dGPBzyhyYCafewMyZoYwE=;
        b=fZIBEAO/B5uCJRePpWQU1+XDwLTvNUJh5zLe9Jt1fqHTy3co+XzV1fWsgjBQaqKJDgBUa7
        shw/9vPMR/29/dhUsK9GRtMvN6Lq5TrFN0GG18r/2pUh4diw7VAqyHsqEHrIqrRpy6UouL
        +6KCok/7A10UWiZC/Q7qGBggY8lCvX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700433653;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGk6YNOW6yEdrFd50gkSj0dGPBzyhyYCafewMyZoYwE=;
        b=GD5kOxFrnUKvfjgvTmIqVVjVa1hLj13vKa/sJNpn6eMx3Ie+DFvvZs5S3ZXJ8PJXDpzgcZ
        7HZ1QxWHhi6VsjDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D61D139B7;
        Sun, 19 Nov 2023 22:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Rgv+B/OOWmVjYQAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 19 Nov 2023 22:40:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 6/9] nfsd: allow admin-revoked NFSv4.0 state to be freed.
In-reply-to: <c5a0e63abee568a048446306c571ca503ef6a38a.camel@kernel.org>
References: <20231117022121.23310-1-neilb@suse.de>,
 <20231117022121.23310-7-neilb@suse.de>,
 <c5a0e63abee568a048446306c571ca503ef6a38a.camel@kernel.org>
Date:   Mon, 20 Nov 2023 09:40:48 +1100
Message-id: <170043364826.19300.6951044665580840453@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 6.40
X-Spamd-Result: default: False [6.40 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[0.999];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[21.05%]
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
> > For NFSv4.1 and later the client easily discovers if there is any
> > admin-revoked state and will then find and explicitly free it.
> > 
> > For NFSv4.0 there is no such mechanism.  The client can only find that
> > state is admin-revoked if it tries to use that state, and there is no
> > way for it to explicitly free the state.  So the server must hold on to
> > the stateid (at least) for an indefinite amount of time.  A
> > RELEASE_LOCKOWNER request might justify forgetting some of these
> > stateids, as would the whole clients lease lapsing, but these are not
> > reliable.
> > 
> > This patch takes two approaches.
> > 
> > Whenever a client uses an revoked stateid, that stateid is then
> > discarded and will not be recognised again.  This might confuse a client
> > which expect to get NFS4ERR_ADMIN_REVOKED consistently once it get it at
> > all, but should mostly work.  Hopefully one error will lead to other
> > resources being closed (e.g.  process exits), which will result in more
> > stateid being freed when a CLOSE attempt gets NFS4ERR_ADMIN_REVOKED.
> > 
> > Also, any admin-revoked stateids that have been that way for more than
> > one lease time are periodically revoke.
> > 
> 
> Why a single lease period?

Because it was easy to code.

> 
> Is that a long enough time for v4.0? Given that the protocol has no
> mechanism to detect revoked state, I have to wonder if a single lease
> period is enough time for the client to detect the problem?

There is no amount of time that is long enough.
In many cases the client will notice quickly.  In some cases it might
not notice for days or weeks.
Given that there is no perfect solution, and given that v4.0 is really
just a prototype that probably shouldn't be used any more, I don't think
there is any benefit is trying any harder.

Thanks,
NeilBrown
