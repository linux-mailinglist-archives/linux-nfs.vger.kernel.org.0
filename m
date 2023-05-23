Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0710670DDB6
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 15:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjEWNlX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 09:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbjEWNlU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 09:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B174138;
        Tue, 23 May 2023 06:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 814A063291;
        Tue, 23 May 2023 13:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65475C433D2;
        Tue, 23 May 2023 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684849275;
        bh=IEUevsV5Tv6TaHhge5wi4t7qxjgDO959yxwDY9txkGM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=crhcbz4d+Oy+m/mJ4NDwEGIpz1uNdq3Xrk3RZcj5LfYe6fqS2UksFZ3zQjLhNe2NQ
         emcpTOntHB4XS6R8rXn3G5jqqzxJwX2YMdB+5ra9wDgzyT+NOvVqVbCqERT6GeeT3x
         +5/km26cNs8vmxN5Gw8364G1Ge5kYhRhTuuYYOHvJ10EUE/HKx63MN7DiKzK/bDUtS
         NIpltkp9KF7cJUUO4/TohKdcEbwuMmBPWGODE6LKDOSbCNvIzFXS5gS4MRvoZWpjVa
         cfLRLu8bwR5q1/Yd7Au8dTV1II0bqFc9cxQXApNiJBMzcHflrr11KNah9bxXfG2MUn
         D9o0IpA0SCQtQ==
Message-ID: <d07a0957040ebc3b5689f524e9d3c04cd166c42b.camel@kernel.org>
Subject: Re: [PATCH] nfsd: make a copy of struct iattr before calling
 notify_change
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Zhi Li <yieli@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 May 2023 09:41:14 -0400
In-Reply-To: <168472353748.5298.2381558773846767023@noble.neil.brown.name>
References: <20230517162645.254512-1-jlayton@kernel.org>
         <168472353748.5298.2381558773846767023@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-05-22 at 12:45 +1000, NeilBrown wrote:
> On Thu, 18 May 2023, Jeff Layton wrote:
> > notify_change can modify the iattr structure. In particular it can can
> > end up setting ATTR_MODE when ATTR_KILL_SUID is already set, causing a
> > BUG() if the same iattr is passed to notify_change more than once.
> >=20
> > Make a copy of the struct iattr before calling notify_change.
> >=20
> > Fixes: 34b91dda7124 NFSD: Make nfsd4_setattr() wait before returning NF=
S4ERR_DELAY
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2207969
> > Reported-by: Zhi Li <yieli@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/vfs.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index c4ef24c5ffd0..ad0c5cd900b1 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -538,7 +538,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
> > =20
> >  	inode_lock(inode);
> >  	for (retries =3D 1;;) {
> > -		host_err =3D __nfsd_setattr(dentry, iap);
> > +		struct iattr attrs =3D *iap;
> > +
> > +		host_err =3D __nfsd_setattr(dentry, &attrs);
>=20
> I think this needs something to ensure a well meaning by-passer doesn't
> try to "optimise" it back to the way it was.
> Maybe make "iap" const?  Or add a comment?  Or both?
>=20

We can't make iap const, as we have to call nfsd_sanitize_attrs on it,
and that will change things in it. I think we'll probably have to settle
for a comment. Chuck, can we fold the patch below in to this one?

--------------------8<------------------

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2a3687cdf926..817effd63730 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -538,6 +538,11 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fh=
p,
 	for (retries =3D 1;;) {
 		struct iattr attrs;
=20
+		/*
+		 * notify_change can alter the iattr in ways that make it
+		 * unsuitable for submission multiple times. Make a copy
+		 * for every loop.
+		 */
 		attrs =3D *iap;
 		host_err =3D __nfsd_setattr(dentry, &attrs);
 		if (host_err !=3D -EAGAIN || !retries--)

