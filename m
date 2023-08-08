Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5085A77423D
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Aug 2023 19:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjHHRhu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 13:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbjHHRhP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 13:37:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C76CC9
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 09:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EB3862576
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 13:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29424C433C7;
        Tue,  8 Aug 2023 13:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691502524;
        bh=IU+B8Une8eBp3/2eUVrZhqhdlYmULO6+tMNPdj+G4Tk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DRZdhOHl3EpYp2pn1lu0t3lGzYGqWO27KMDTfgBQkWqcg2v/PFG7LTBhCjor/MNs2
         0cG9TietG++qgMzGkcCYYm9SXvSv+2c1tZGGBOg1Ctbkr4t4/jSB5DRKgcKbZRwazS
         e0MVkq7zby/xuE6ym1p+nHtUJavxHmWJra5E2eL0JNqGvecVPhkxv89+b1V4XpiBtO
         dZh9QzBlmCg00s222T83HP3P+0QVS44LIuyTpaaBfipaJy5u1K0sLq2C3FrQTP7SKf
         RXHYLuSQN4ufOSmmX0U4mUaMOnljiO1oa1sAIDMfG8stVKlwukL+T1GUXa6onNaTuC
         vYj9dUhn1A6hQ==
Message-ID: <ea598236b2da9f1aa9b587ca797afaa9de5545c7.camel@kernel.org>
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Date:   Tue, 08 Aug 2023 09:48:42 -0400
In-Reply-To: <ZNJCIRjI64YIY+I0@tissot.1015granger.net>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
         <169149440399.32308.1010201101079709026@noble.neil.brown.name>
         <ZNJCIRjI64YIY+I0@tissot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-08-08 at 09:24 -0400, Chuck Lever wrote:
> On Tue, Aug 08, 2023 at 09:33:23PM +1000, NeilBrown wrote:
> > On Tue, 08 Aug 2023, Lorenzo Bianconi wrote:
> > > Introduce version field to nfsd_rpc_status handler in order to help
> > > the user to maintain backward compatibility.
> >=20
> > I wonder if this really helps.  What do I do if I see a version that I
> > don't understand?  Ignore the whole file?  That doesn't make for a good
> > user experience.
>=20
> There is no UX consideration here. A user browsing the file directly
> will not care about the version.
>=20
> This file is intended to be parsable by scripts and they have to
> keep up with the occasional changes in format. Scripts can handle an
> unrecogized version however they like.
>=20
> This is what we typically get with a made-up format that isn't .ini
> or JSON or XML. The file format isn't self-documenting. The final
> field on each row is a variable number of tokens, so it will be
> nearly impossible to simply add another field without breaking
> something.
>=20

It shouldn't be a variable number of tokens per line. If there is, then
that's a bug, IMO. We do want it to be simple to just add a new field,
published version info notwithstanding.

>=20
> > I would suggest that the first step to promoting compatibility is to
> > document the format, including how you expect to extend it.
>=20
> I'd be OK with seeing that documentation added as a kdoc comment for
> nfsd_rpc_status_show(), sure.
>=20
>=20
> > Jeff's
> > suggestion of a header line with field names makes a lot of sense for a
> > file with space-separated fields like this.  You should probably promis=
e
> > not to remove fields, but to deprecate fields by replacing them with "X=
"
> > or whatever.
> >=20
> > A tool really needs to be able to extract anything it can understand,
> > and know how to avoid what it doesn't understand.  A version number
> > doesn't help with that.
>=20
> It's how mountstats format changes are managed. We have bumped that
> version number over the years, so there is precedent for it.
>=20
>=20
> > And if you really wanted to change the format so much that old tools
> > cannot use any of the content, it would likely make most sense to chang=
e
> > the name of the file...  or have two files - legacy file with old name
> > and new-improved file with new name.
> >=20
> > So I'm not keen on a version number.
>=20
> I'm a little surprised to get push-back on "# version" but OK, we
> can drop that idea in favor of a comment line in rpc_status that
> acts as a header row, just like in /proc/fs/nfsd/pool_stats.
> Scripts can treat that header as format version information.
>=20
>=20
> > Thanks,
> > NeilBrown
> >=20
> >=20
> > >=20
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  fs/nfsd/nfssvc.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >=20
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index 33ad91dd3a2d..6d5feeeb09a7 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -1117,6 +1117,9 @@ int nfsd_stats_release(struct inode *inode, str=
uct file *file)
> > >  	return ret;
> > >  }
> > > =20
> > > +/* Increment NFSD_RPC_STATUS_VERSION adding new info to the handler =
*/
> > > +#define NFSD_RPC_STATUS_VERSION		1
> > > +
> > >  static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> > >  {
> > >  	struct inode *inode =3D file_inode(m->file);
> > > @@ -1125,6 +1128,8 @@ static int nfsd_rpc_status_show(struct seq_file=
 *m, void *v)
> > > =20
> > >  	rcu_read_lock();
> > > =20
> > > +	seq_printf(m, "# version %u\n", NFSD_RPC_STATUS_VERSION);
> > > +
> > >  	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> > >  		struct svc_rqst *rqstp;
> > > =20
> > > --=20
> > > 2.41.0
> > >=20
> > >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
