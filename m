Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2C04EEE21
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Apr 2022 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiDANcd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Apr 2022 09:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345341AbiDANcc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Apr 2022 09:32:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1009E27DEAC
        for <linux-nfs@vger.kernel.org>; Fri,  1 Apr 2022 06:30:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C01151FCFF;
        Fri,  1 Apr 2022 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648819841;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FpRflFwadmazJd5+FSaayWT1/O0VT62B6/XjClAY+g=;
        b=HghYn/oDGmUjokIIvMlK4AEevxvISloeygwRr42196KEqsrelrGJt13XJOk61ARlOjEHAI
        Ua4OXF40d8vCs8kF6+9wRlyFQp1/7sQWM1a3lFlKqks/x7MMFGF2pcJYq2IGggeISnSOUc
        LpwDACgSFUTyTVU9f7ECGlQpwtPGV7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648819841;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FpRflFwadmazJd5+FSaayWT1/O0VT62B6/XjClAY+g=;
        b=Xzknx9yNCLY025B2AVUN/R4rAwgU2vTMw08bSHvkdN1ce+Ylj6K03ULfcg2ruQnzn0qkOj
        OTIB+ozI+yzxkmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78FAC132C1;
        Fri,  1 Apr 2022 13:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M5RjEYD+RmLqWQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 01 Apr 2022 13:30:40 +0000
Date:   Fri, 1 Apr 2022 15:30:36 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Frank Filz <ffilzlnx@mindspring.com>
Cc:     'Bruce Fields' <bfields@redhat.com>, 'NeilBrown' <neilb@suse.de>,
        'Linux NFS Mailing List' <linux-nfs@vger.kernel.org>,
        'Yong Sun' <yosun@suse.com>
Subject: Re: pynfs: [NFS 4.0] SEC7, LOCK24 test failures
Message-ID: <Ykb+e0nvmeq41RHg@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <YLY9pKu38lEWaXxE@pevik>
 <YLZS1iMJR59n4hue@pick.fieldses.org>
 <164248153844.24166.16775550865302060652@noble.neil.brown.name>
 <CAPL3RVE8+zYOLotpUQ6QWFy5rYS8o1NV6XbKE4-D6XpVSoYw3w@mail.gmail.com>
 <0b8e01d81249$b7c4f300$274ed900$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8e01d81249$b7c4f300$274ed900$@mindspring.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

> Yes, I believe I wrote this test to recreate a condition we saw in the wild. There is no guarantee the client doesn't send LOCK with an OPEN stateid and requesting new lock owner when you already have a LOCK stateid for that lock owner. This test case forces that condition.

> It looks like we were having troubles with FREE_STATEID racing with LOCK. A LOCK following a FREE_STATEID MUST use the OPEN stateid and ask for a new lock owner (since the LOCK stateid was freed), but if the LOCK wins the race, the old LOCK stateid still exists, so we get an LOCK with OPEN stateid requesting new lock owner where the STATEID will already exist.

> Now maybe there's a different way to resolve the race, but if the LOCK truly arrives before Ganesha even sees the FREE_STATEID then it has no knowledge that would allow it to delay the LOCK request. Before we made changes to allow this I believe we replied with an error that broke things client side.

> Here's a Ganesha patch trying to resolve the race and creating the condition that LOCK24 was then written to test:

> https://github.com/nfs-ganesha/nfs-ganesha/commit/7d0fb8e9328c40fcfae03ac950a854f56689bb44

> Of course the client may have changed to eliminate the race...

> If need be, just change this from an "all" test to a "ganesha" test.

Bruce, could this be done to solve problems for other clients?

> Frank

> > -----Original Message-----
> > From: Bruce Fields [mailto:bfields@redhat.com]
> > Sent: Tuesday, January 25, 2022 2:47 PM
> > To: NeilBrown <neilb@suse.de>
> > Cc: Petr Vorel <pvorel@suse.cz>; Linux NFS Mailing List <linux-
> > nfs@vger.kernel.org>; Yong Sun <yosun@suse.com>; Frank S. Filz
> > <ffilzlnx@mindspring.com>
> > Subject: Re: pynfs: [NFS 4.0] SEC7, LOCK24 test failures

> > Frank added this test in 4299316fb357, and I don't really understand his
> > description, but it *sounds* like he really wanted it to do the new-lockowner
> > case.  Frank?

> > --b.

> > On Tue, Jan 18, 2022 at 12:01 AM NeilBrown <neilb@suse.de> wrote:

> > > On Wed, 02 Jun 2021, J. Bruce Fields wrote:
> > > > On Tue, Jun 01, 2021 at 04:01:08PM +0200, Petr Vorel wrote:

> > > > > LOCK24   st_lock.testOpenUpgradeLock                              : FAILURE
> > > > >            OP_LOCK should return NFS4_OK, instead got
> > > > >            NFS4ERR_BAD_SEQID

> > > > I suspect the server's actually OK here, but I need to look more
> > > > closely.

> > > I agree.
> > > I think this patch fixes the test.

> > > NeilBrown

> > > From: NeilBrown <neilb@suse.de>
> > > Date: Tue, 18 Jan 2022 15:50:37 +1100
> > > Subject: [PATCH] Fix NFSv4.0 LOCK24 test

> > > Only the first lock request for a given open-owner can use lock_file.
> > > Subsequent lock request must use relock_file.

> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  nfs4.0/servertests/st_lock.py | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)

> > > diff --git a/nfs4.0/servertests/st_lock.py
> > > b/nfs4.0/servertests/st_lock.py index 468672403ffe..db08fbeedac4
> > > 100644
> > > --- a/nfs4.0/servertests/st_lock.py
> > > +++ b/nfs4.0/servertests/st_lock.py
> > > @@ -886,6 +886,7 @@ class open_sequence:
> > >          self.client = client
> > >          self.owner = owner
> > >          self.lockowner = lockowner
> > > +        self.lockseq = 0
> > >      def open(self, access):
> > >          self.fh, self.stateid = self.client.create_confirm(self.owner,
> > >                                                 access=access, @@
> > > -899,15 +900,21 @@ class open_sequence:
> > >      def close(self):
> > >          self.client.close_file(self.owner, self.fh, self.stateid)
> > >      def lock(self, type):
> > > -        res = self.client.lock_file(self.owner, self.fh, self.stateid,
> > > -                    type=type, lockowner=self.lockowner)
> > > +        if self.lockseq == 0:
> > > +            res = self.client.lock_file(self.owner, self.fh, self.stateid,
> > > +                                        type=type, lockowner=self.lockowner)
> > > +        else:
> > > +            res = self.client.relock_file(self.lockseq, self.fh, self.lockstateid,
> > > +                                        type=type)
> > >          check(res)
> > >          if res.status == NFS4_OK:
> > >              self.lockstateid = res.lockid
> > > +            self.lockseq = self.lockseq + 1
> > >      def unlock(self):
> > >          res = self.client.unlock_file(1, self.fh, self.lockstateid)
> > >          if res.status == NFS4_OK:
> > >              self.lockstateid = res.lockid
> > > +            self.lockseq = self.lockseq + 1

> > >  def testOpenUpgradeLock(t, env):
> > >      """Try open, lock, open, downgrade, close
> > > --
> > > 2.34.1


