Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028017F0978
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 23:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjKSWrO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 17:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKSWrO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 17:47:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C419E
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 14:47:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A8BF1F750;
        Sun, 19 Nov 2023 22:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700434029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xmMI49vYUpW7GVnOnFaREy3ONietvbBmNKkKdxBAE/w=;
        b=P5d3sBK+84HhJKRpYBDR0qYCVXlCBL+Sadyu9ZNMjyoCB9BpgQVnIDfSUrNJlZ4PBGM9L7
        LFTAnzRBtOPzbeXMUhbxA2kyiRuTrYPlWmi+S3VzRzFG0EnNAwv3lCK5wGiAnCA2i12dwv
        T6aR3tDTK9B+6imqPE3daGvnPl+qBX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700434029;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xmMI49vYUpW7GVnOnFaREy3ONietvbBmNKkKdxBAE/w=;
        b=iThOwzauWpfPsQfjw9iS+OEiO+91XDA23MRpRV1fe0hoiBdtb028ClXNgxlp75v4U8dR6g
        oJwCbLVzu+0eZxCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 120831377F;
        Sun, 19 Nov 2023 22:47:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U1O9LWqQWmWcYwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 19 Nov 2023 22:47:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 6/9] nfsd: allow admin-revoked NFSv4.0 state to be freed.
In-reply-to: <ZVfF8R2t3WH7FqVd@tissot.1015granger.net>
References: <20231117022121.23310-1-neilb@suse.de>,
 <20231117022121.23310-7-neilb@suse.de>,
 <ZVfF8R2t3WH7FqVd@tissot.1015granger.net>
Date:   Mon, 20 Nov 2023 09:47:03 +1100
Message-id: <170043402394.19300.7144468429486716541@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
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
         BAYES_HAM(-0.00)[28.25%]
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
> On Fri, Nov 17, 2023 at 01:18:52PM +1100, NeilBrown wrote:
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
> > No actual freeing of state happens in this patch.  That will come in
> > future patches which handle the different sorts of revoked state.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/netns.h     |  4 ++
> >  fs/nfsd/nfs4state.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 100 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index ec49b200b797..02f8fa095b0f 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -197,6 +197,10 @@ struct nfsd_net {
> >  	atomic_t		nfsd_courtesy_clients;
> >  	struct shrinker		nfsd_client_shrinker;
> >  	struct work_struct	nfsd_shrinker_work;
> > +
> > +	/* last time an admin-revoke happened for NFSv4.0 */
> > +	time64_t		nfs40_last_revoke;
> > +
> >  };
> 
> This hunk doesn't apply to nfsd-next due to v6.7-rc changes to NFSD
> to implement a dynamic shrinker. So I stopped my review here for
> now.

I didn't a rebase onto nfsd-next and there were no conflicts!

I guess the change from
  	struct work_struct	nfsd_shrinker_work;
to
  	struct work_struct	*nfsd_shrinker_work;

was technically a conflict but I'm surprised your tool complained..

NeilBrown
