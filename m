Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8A676890E
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 00:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjG3WO3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jul 2023 18:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjG3WO2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jul 2023 18:14:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6241510F4
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 15:14:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 25965227D2;
        Sun, 30 Jul 2023 22:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690755266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NkZzqFpyCQaUlrhG4lRiL+YhFb3ICReCtXF6pRw10Uw=;
        b=NMEB+JXbF8TF7aEwmXMRZ50anABNSVd5VUM3xom/QZ/oklnf5MGOlnjNKqJ++qkYjJp85e
        hTsCw9lnL+v6lUUuIR4DL+VLHAurMhbdzq57igrQORHmcfKXKVKpxl2d3or+DE1yHZWSY0
        XsLWeE9wwEBGgKUT70MpE5Mz85gdh3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690755266;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NkZzqFpyCQaUlrhG4lRiL+YhFb3ICReCtXF6pRw10Uw=;
        b=kyrkiOnL0743aLWYiDtqi7erVA/rKCtZmbj1J3gs41LVGWMlsXk2WiF6PUAvdDrrsBI3MC
        US7gB3aY8mGWEZBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB5D713595;
        Sun, 30 Jul 2023 22:14:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T2AXI8DgxmSHPQAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 30 Jul 2023 22:14:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/14] SUNRPC: change various server-side #defines to enum
In-reply-to: <169075508761.32308.11692865993389725826@noble.neil.brown.name>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>,
 <168966228863.11075.8173252015139876869.stgit@noble.brown>,
 <ZLaVtpLf1k2Ig5Kz@bazille.1015granger.net>,
 <ZMaIWPyEm83GaS0q@tissot.1015granger.net>,
 <169075508761.32308.11692865993389725826@noble.neil.brown.name>
Date:   Mon, 31 Jul 2023 08:14:21 +1000
Message-id: <169075526174.32308.13675913011176702739@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 31 Jul 2023, NeilBrown wrote:
> On Mon, 31 Jul 2023, Chuck Lever wrote:
> > On Tue, Jul 18, 2023 at 09:37:58AM -0400, Chuck Lever wrote:
> > > On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
> > > > When a sequence of numbers are needed for internal-use only, an enum =
is
> > > > typically best.  The sequence will inevitably need to be changed one
> > > > day, and having an enum means the developer doesn't need to think abo=
ut
> > > > renumbering after insertion or deletion.  The patch will be easier to
> > > > review.
> > >=20
> > > Last sentence needs to define the antecedant of "The patch".
> >=20
> > I've changed the last sentence in the description to "Such patches
> > will be easier ..."
> >=20
> > I've applied 1/5 through 5/5, with a few cosmetic changes, to the
> > SUNRPC threads topic branch. 6/6 needed more work:
>=20
> Ah - ok.  I was all set to resubmit with various changes and
> re-ordering.  I guess I waited too long.
>=20
> > All this will appear in the nfsd repo later today.
>=20
> Not yet....

No, they are there - the top date looked rather old so I thought there
was nothing new yet.  Sorry.

NeilBrown
