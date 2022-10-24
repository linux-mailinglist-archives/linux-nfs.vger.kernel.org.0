Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B943C609F90
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 12:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJXK7T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 06:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJXK7C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 06:59:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6E15F997
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 03:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E74FFB810E5
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 10:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE97C433C1;
        Mon, 24 Oct 2022 10:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666609077;
        bh=8zjscNgRX1pwsOzFMCNp5SBDcYWmEXpxRyHAWeo5f3g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qGkal+2quaZP6KOaaf4qp1avH+KkLzzG9PVfH8RWeyOmCqE1+vg62dAadRu6WCuBs
         9rDWALqC8cYMFaR3hUft+qWkk+YV8ri6SNU2yMnkgUO6w2fFHTseKKYrnrhW64ouu9
         xu+cWp19S4cFk/RJdHWj4EB/SGlPGWlvt1X5P/w5ymGj/QzIYaoZrsGIJtL6FK/tql
         VDRmi4jZ0ySjL2iMq3Jy29Za7LvpNSXCEXSK1nd1YdzckGd66gBZXK8k2pmamT1gX0
         GIybU6sASFVvJMPyC7LRMiT9Q6CZIZivCt3PmE8QEqVMrZ3q4gLcNE583XtZ4tnoBQ
         tdCqLHlq9LATw==
Message-ID: <6af5e6b60fcac271b4bb37dec2ffe25adfef80df.camel@kernel.org>
Subject: Re: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file
 objects
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 24 Oct 2022 06:57:55 -0400
In-Reply-To: <166657723034.12462.8422170607830380805@noble.neil.brown.name>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
        , <166612313084.1291.5764156173845222109.stgit@manet.1015granger.net>
        , <cdad5af44b1c62c8e2ceae27cb2b646f7b2ec0bd.camel@poochiereds.net>
        , <1DE04392-E8C9-4D39-BF23-BD1A59DB4FE3@oracle.com>
         <166657723034.12462.8422170607830380805@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-24 at 13:07 +1100, NeilBrown wrote:
> On Thu, 20 Oct 2022, Chuck Lever III wrote:
> >=20
> > > On Oct 19, 2022, at 7:39 AM, Jeff Layton <jlayton@poochiereds.net> wr=
ote:
> > >=20
> > > > -	fp =3D find_or_add_file(open->op_file, current_fh);
> > > > +	rcu_read_lock();
> > > > +	fp =3D insert_nfs4_file(open->op_file, current_fh);
> > > > +	rcu_read_unlock();
> > >=20
> > > It'd probably be better to push this rcu_read_lock down into
> > > insert_nfs4_file. You don't need to hold it over the actual insertion=
,
> > > since that requires the state_lock.
> >=20
> > I used this arrangement because:
> >=20
> > insert_nfs4_file() invokes only find_nfs4_file() and the
> > insert_file() helper. Both find_nfs4_file() and the
> > insert_file() helper invoke rhltable_lookup(), which
> > must be called with the RCU read lock held.
> >=20
> > And this is the reason why put_nfs4_file() no longer takes
> > the state_lock: it would take the state_lock first and
> > then the RCU read lock (which is implicitly taken in
> > rhltable_remove()), which results in a lock inversion
> > relative to insert_nfs4_file(), which takes the RCU read
> > lock first, then the state_lock.
>=20
> It doesn't make any sense to talk about lock inversion with
> rcu_read_lock().  It isn't really a lock in any traditional sense in
> that it can never block (which is what cause lock-inversion problems).
> I prefer to think for rcu_read_lock() as taking a reference on some
> global state.
>=20

Right. To be clear, you can deadlock with synchronize_rcu if you use it
improperly, but the rcu_read_lock itself never blocks.

> >=20
> >=20
> > I'm certainly not an expert, so I'm willing to listen to
> > alternative approaches. Can we rely on only the RCU read
> > lock for exclusion on hash insertion?
>=20
> Probably we can.  I'll read through all the patches now and provide some
> review.
>=20

The rcu_read_lock provides _no_ exclusion whatsoever, so it's not
usually suitable for things that need exclusive access (like a hash
insertion). If each rhl hash chain has its own lock though, then we may
not require other locking to serialize insertions.

--=20
Jeff Layton <jlayton@kernel.org>
