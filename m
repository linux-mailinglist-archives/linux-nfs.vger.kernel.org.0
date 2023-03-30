Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AD06D0E0E
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Mar 2023 20:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjC3Stf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Mar 2023 14:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjC3Stc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Mar 2023 14:49:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB5D314
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 11:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03325B829E6
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 18:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48929C433D2;
        Thu, 30 Mar 2023 18:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680202168;
        bh=DWJJQCHfIcsajia5y4Qg+6PDpLinmL8KbsspINYnBxg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O0oLDQ5942oLjoDb3wPpLgOmVwRVxfQFCIj5vAU+y6XZn8dVehnOtfGchAFaf8JcS
         p9IH02OfpxCmvGTlp5NQLy1EHzhj/D57Nu1zkcrfX7il5AXj6lwXlymO9a43zTq6Wm
         IDOxW7DMbyUOp7wIK8HGK+Vc/22ECadBXxqcVNkhCj8Pjn8hX9Ts5JNtxOYyz+JAiL
         apd6yQ8XtjGzhoy6Qb67SKxSz8yWWle1mJxCeAW76Gk74d4lX66Ed0pAUx5XKEfp60
         y9A85CgSWorfM76C5YLyAJfoMGxPms2YhLlOYyKmw8u2iwqiC2RkjLyIeGTX0uHMis
         DplHck/ZPtDsA==
Message-ID: <12c783873abcd0f9c631e2f367cc1dd97949e0fb.camel@kernel.org>
Subject: Re: [PATCH] sunrpc: only free unix grouplist after RCU settles
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Zhi Li <yieli@redhat.com>
Date:   Thu, 30 Mar 2023 14:49:26 -0400
In-Reply-To: <49AC9CF4-71A8-48D7-BF21-41FFFEFBE4C8@oracle.com>
References: <20230330182427.19013-1-jlayton@kernel.org>
         <49AC9CF4-71A8-48D7-BF21-41FFFEFBE4C8@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-03-30 at 18:31 +0000, Chuck Lever III wrote:
> Hi Jeff-
>=20
> > On Mar 30, 2023, at 2:24 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > While the unix_gid object is rcu-freed, the group_info list that it
> > contains is not. Ensure that we only put the group list reference once
> > we are really freeing the unix_gid object.
> >=20
> > Reported-by: Zhi Li <yieli@redhat.com>
>=20
> Should we also add
>=20
> Fixes: fd5d2f78261b ("SUNRPC: Make server side AUTH_UNIX use lockless loo=
kups") ?
>=20
>=20

Sure. That does look like when that particular bug crept in.
=20
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2183056
>=20
> This bug isn't publicly accessible, fwiw.
>=20

Thanks. It should be now.

>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > net/sunrpc/svcauth_unix.c | 17 +++++++++++++----
> > 1 file changed, 13 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
> > index 50e2eb579194..4485088ce27b 100644
> > --- a/net/sunrpc/svcauth_unix.c
> > +++ b/net/sunrpc/svcauth_unix.c
> > @@ -416,14 +416,23 @@ static int unix_gid_hash(kuid_t uid)
> > 	return hash_long(from_kuid(&init_user_ns, uid), GID_HASHBITS);
> > }
> >=20
> > -static void unix_gid_put(struct kref *kref)
> > +static void unix_gid_free(struct rcu_head *rcu)
> > {
> > -	struct cache_head *item =3D container_of(kref, struct cache_head, ref=
);
> > -	struct unix_gid *ug =3D container_of(item, struct unix_gid, h);
> > +	struct unix_gid *ug =3D container_of(rcu, struct unix_gid, rcu);
> > +	struct cache_head *item =3D &ug->h;
> > +
> > 	if (test_bit(CACHE_VALID, &item->flags) &&
> > 	    !test_bit(CACHE_NEGATIVE, &item->flags))
> > 		put_group_info(ug->gi);
> > -	kfree_rcu(ug, rcu);
> > +	kfree(ug);
> > +}
> > +
> > +static void unix_gid_put(struct kref *kref)
> > +{
> > +	struct cache_head *item =3D container_of(kref, struct cache_head, ref=
);
> > +	struct unix_gid *ug =3D container_of(item, struct unix_gid, h);
> > +
> > +	call_rcu(&ug->rcu, unix_gid_free);
> > }
> >=20
> > static int unix_gid_match(struct cache_head *corig, struct cache_head *=
cnew)
> > --=20
> > 2.39.2
> >=20
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
