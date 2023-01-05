Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF065F65A
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 23:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjAEWCt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 17:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjAEWCr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 17:02:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B4A67BEF
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 14:02:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E28CB8C12F;
        Thu,  5 Jan 2023 22:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1672956164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dnpmgIuJxSXIJ0SRrRB9dS7AKTOSv031CF0jpFgi7Mo=;
        b=m3c04xXwMWCsRUhaxZyqtM8iAn3NYs9tPr4bVeBT51+r3jgCtYAfD9JmckztWgGLCFKeZ3
        FQ60hWbtM0Syrm/RJb9iE70fNfxGYxTVG4Y6bj6sDtrqeNh+6pDS56+Lge4NyCKqBuiqC0
        LYLDTxDBGtp8tIpSzHLX5VN3Wgtghbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1672956164;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dnpmgIuJxSXIJ0SRrRB9dS7AKTOSv031CF0jpFgi7Mo=;
        b=bQ7sS8jvgQDNeoxWXBoOggq2kMlVgCZtEtU/BwM0BXcJe+YUIlCyrCSP07+AFryCZlLue/
        iPqpSVDF6mGONyAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AB3E13338;
        Thu,  5 Jan 2023 22:02:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9LhVMAJJt2OMUwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 05 Jan 2023 22:02:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Olga Kornievskaia" <aglo@umich.edu>
Cc:     "Trond Myklebust" <trondmy@kernel.org>,
        "Trond Myklebust" <trondmy@hammerspace.com>,
        "Anna Schumaker" <anna@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
In-reply-to: <CAN-5tyH72SBP=9LQFzxUOQKVzbaiPgSOV4efTCMPYywbCwrGYw@mail.gmail.com>
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>,
 <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>,
 <CAN-5tyEBce3ZcXt9fxN9qPStRSSb=H-3v2ZFUovJRCs3CZXgXw@mail.gmail.com>,
 <167279876729.13974.1765446738043285170@noble.neil.brown.name>,
 <167279964139.13974.11763637507027085853@noble.neil.brown.name>,
 <CAN-5tyH72SBP=9LQFzxUOQKVzbaiPgSOV4efTCMPYywbCwrGYw@mail.gmail.com>
Date:   Fri, 06 Jan 2023 09:02:39 +1100
Message-id: <167295615935.13974.12958918575587963063@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 05 Jan 2023, Olga Kornievskaia wrote:
> On Tue, Jan 3, 2023 at 9:34 PM NeilBrown <neilb@suse.de> wrote:
> >
> > On Wed, 04 Jan 2023, NeilBrown wrote:
> > > On Wed, 04 Jan 2023, Olga Kornievskaia wrote:
> > > > On Tue, Jan 3, 2023 at 7:46 PM Trond Myklebust <trondmy@kernel.org> w=
rote:
> > > > >
> > > > >
> > > > > If the server starts to reply NFS4ERR_STALE to GETATTR requests, wh=
y do
> > > > > we care about stateid values?
> > > >
> > > > It is acceptable for the server to return ESTALE to the GETATTR after
> > > > the processing the open (due to a REMOVE that comes in) and that open
> > > > generating a valid stateid which client should care about when there
> > > > are pre-existing opens. The server will keep the state of an existing
> > > > opens valid even if the file is removed. Which is what's happening,
> > > > the previous open is being used for IO but the stateid is updated on
> > > > the server but not on the client.
> > >
> > > I agree that it is acceptable to return ESTALE to the GETATTR, but
> > > having done that I don't think it is acceptable for a PUTFH of the same
> > > filehandle to succeed.  Certainly any attempt to again use the
> > > filehandle after the PUTFH should fail with NFS4ERR_STALE.
> > >
> > > RFC7530 says
> > >
> > > 13.1.2.7.  NFS4ERR_STALE (Error Code 70)
> > >
> > >    The current or saved filehandle value designating an argument to the
> > >    current operation is invalid.  The file system object referred to by
> > >    that filehandle no longer exists, or access to it has been revoked.
> > >
> > > So the file doesn't exist or access has been revoked.  So any writes
> > > should fail.  Failing with OLD_STATEID is weird - and having writes
> > > succeed if we use the correct stateid is also odd.  Failing with STALE
> > > would be perfectly sensible and I suspect the Linux client would handle
> > > that just fine.
> >
> > I checked a recent tcpdump (with patched SLE kernel talking to Netapp)
> > and I see that the writes don't succeed after the first NFS4ERR_STALE.
> >
> > If the "correct" stateid is given to WRITE, it returns NFS4ERR_STALE.
> > If the older stateid is given to WRITE, it returns NFS4ERR_OLD_STATEID.
> >
> > So it seems that it just has these two checks in the wrong order.
>=20
> Does Netapp return ERR_STALE on the PUTFH if the stateid is correct?

In the traces I have, Netapp never returns ERR_STALE on PUTFH.  Of
course the PUTFH operation doesn't have a stateid, so the "if the
stateid is correct" is not meaningful.

ACCESS, READ, WRITE, SETATTR, and GETATTR are the only ops that I have
seen to result in ERR_STALE.

ACCESS and GETATTR don't have a stateid.
READ, WRITE, and SETATTR do.  These get OLD_STATEID if the stateid is
old, and only get STALE if the stateid is current.


> If it's the WRITE operation that returns an error and if the server
> has multiple errors (ie bad statid and bad file handle)` then I don't
> think the spec says which error is more important. In this case, I
> think the server should fail PUTFH with ERR_STALE.

I agree.  If the PUTFH returned STALE there would not be a problem.
Even if a race resulted in the PUTFH succeeding and the WRITE getting
OLD_STATEID, Linux-NFS would retry an the new PUTFH could then fail
correctly.

NeilBrown

>=20
> >
> > NeilBrown
>=20
