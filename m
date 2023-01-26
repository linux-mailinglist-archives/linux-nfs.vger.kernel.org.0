Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5EC67D7DB
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jan 2023 22:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjAZVjH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Jan 2023 16:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjAZVjG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Jan 2023 16:39:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489023C61
        for <linux-nfs@vger.kernel.org>; Thu, 26 Jan 2023 13:39:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8014EB81EF0
        for <linux-nfs@vger.kernel.org>; Thu, 26 Jan 2023 21:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5CBC433EF;
        Thu, 26 Jan 2023 21:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674769143;
        bh=WPilZoMaN1g8lUTkRLNe2cQrBnckb48Pif757jFliPI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=taKEP7tqYK4SMIOeFaNgiBw1rO4DxOQmcOGSMA//ZPl9qWgoOPvtPTtVxuXK8uXS0
         Kn0BBX9E3D6ZW4t8sl378Nn9SfW+9iu/IcKJ52g+UTmGqfQPLocwMVALpECoaoBTjH
         C45LudFCHRmU6Jrr+ynkczS7Gpazt6HHEqdBGaiS8W2O5BT2qqKxGasZD3NFaMG1aE
         w7GZo/i5OQ61/DQF21031w/23wyDDh0oEU+Cmnzw5mG64sKTESWLrsM1IeqxYu+AJQ
         sFZlVz9qKKgQxawX/6BP0HSe2mu+4YdztVgX29ZL08Ebbt6nKNrB/0mppR9zcx6E7u
         hSxBgTfsoG0Vw==
Message-ID: <b7d6521139f97ee40ede638da0ba1d2fffd853f5.camel@kernel.org>
Subject: Re: [PATCH/RFC] NFSv3 handle out-of-order write replies
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 26 Jan 2023 16:39:01 -0500
In-Reply-To: <167476540120.23017.11089540386030477339@noble.neil.brown.name>
References: <167461221711.23017.1840413589310764555@noble.neil.brown.name>
        , <bc265a2756ca172bc62b68f5214213700f59a28c.camel@kernel.org>
         <167476540120.23017.11089540386030477339@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-01-27 at 07:36 +1100, NeilBrown wrote:
> On Thu, 26 Jan 2023, Jeff Layton wrote:
> > On Wed, 2023-01-25 at 13:03 +1100, NeilBrown wrote:
> >=20
> > > diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> > > index 7931fa472561..8a83d6d204ed 100644
> > > --- a/include/linux/nfs_fs.h
> > > +++ b/include/linux/nfs_fs.h
> > > @@ -190,6 +190,33 @@ struct nfs_inode {
> > >  	/* Open contexts for shared mmap writes */
> > >  	struct list_head	open_files;
> > > =20
> > > +	/* Keep track of out-of-order replies.
> > > +	 * The ooo array contains start/end pairs of
> > > +	 * number from the changeid sequence when
> > > +	 * the inodes iversion has been updated.
> > > +	 * It also contains end/start pair (i.e. reverse order)
> > > +	 * of sections of the changeid sequence that have
> > > +	 * been seen in replies from the server.
> > > +	 * Normally these should match and when both
> > > +	 * A:B and B:A are found in ooo, they are both removed.
> > > +	 * And if a reply with A:B causes an iversion update
> > > +	 * of A:B, then neither are added.
> > > +	 * When a reply has pre_change that doesn't match
> > > +	 * iversion, then the changeid pair, and any consequent
> > > +	 * change in iversion ARE added.  Later replies
> > > +	 * might fill in the gaps, or possibly a gap is caused
> > > +	 * by a change from another client.
> > > +	 * When a file or directory is opened, if the ooo table
> > > +	 * is not empty, then we assume the gaps were due to
> > > +	 * another client and we invalidate the cached data.
> > > +	 *
> > > +	 * We can only track a limited number of concurrent gaps.
> > > +	 * Currently that limit is 16.
> > > +	 */
> > > +	int ooo_cnt;
> > > +	int ooo_max; // TRACING
> > > +	unsigned long ooo[16][2];
> >=20
> > Why unsigned longs here? Shouldn't these be u64?
>=20
> Yes, they should be u64.  Thanks.
>=20
> >=20
> > I guess you could argue that when we have 32-bit longs that the most
> > significant bits don't matter, but that's also the case with 64-bit
> > longs, and 32 bits would halve the space requirements.
> >=20
> > Also, this grows each inode by 2k on a 64-bit arch! Maybe we should
> > dynamically allocate these things instead? If the allocation fails, the=
n
> > we could just go back to marking the cache invalid and move on.
>=20
> 2K? 8*16*2+4*2 =3D=3D 264, not 2048.
>=20

You're correct of course. I'm not sure where I got 2048.

> But I agree that allocating on demand would make sense.  16 is probably
> more than needed.  I don't have proper testing results from the customer
> yet, but I wouldn't be surprised if a smaller number would suffice.  But
> if we are allocating only on demand, it wouldn't hurt to allocate 16.

Makes sense. Is there a max number of NFS writes you can have in flight
to a single server in the client? That might inform how large an array
you need.
>=20
--=20
Jeff Layton <jlayton@kernel.org>
