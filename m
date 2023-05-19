Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC3370982C
	for <lists+linux-nfs@lfdr.de>; Fri, 19 May 2023 15:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjESN00 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 May 2023 09:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjESN00 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 May 2023 09:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA52119
        for <linux-nfs@vger.kernel.org>; Fri, 19 May 2023 06:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFA6A6577E
        for <linux-nfs@vger.kernel.org>; Fri, 19 May 2023 13:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF55AC433EF;
        Fri, 19 May 2023 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684502784;
        bh=O/3QDWIi9jHJhh6/FJqfClXXLU1Kc/hf1uvyvt9bkKc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FIWpqr6tCnOfQrKRZfMbrjNHCn5qOGn3pnbo9wPzWBx++7xcAFwKC1IzSAEOAzUVk
         9hF56nOedQqP9ZyPj+4m9McaqmUs6f4zM8IMvz/eWoho/+Wfkd40zHGas+e0nBAIqs
         v5ZltZhGXzdeIIcozC8ZzTf48+jAE5sEG0BJdHKaLAZBACzVih3wMn0svcNmEueYLZ
         vlmg3RIXGYT3ePTOXmuMk2lC48ZFimj7oisMqgldLwc8Eum167BKaG8Tdg4hg2eJ3Y
         gPeNgR8VlhSPprIUwYVRcoIiqNIoOrqsBY6x3CsA/r6WJL2r5xXkNBSn0QCwWNu4s6
         +QX7rjRjG4uYQ==
Message-ID: <84004358376fe8dbd524e71a6d06e83563be717c.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't provide pre/post-op attrs if fh_getattr
 fails
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Fri, 19 May 2023 09:26:22 -0400
In-Reply-To: <e0c64e6c69552872925312ca012946acc308b71c.camel@hammerspace.com>
References: <20230519111723.20612-1-jlayton@kernel.org>
         <e0c64e6c69552872925312ca012946acc308b71c.camel@hammerspace.com>
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

On Fri, 2023-05-19 at 13:08 +0000, Trond Myklebust wrote:
> On Fri, 2023-05-19 at 07:17 -0400, Jeff Layton wrote:
> > nfsd calls fh_getattr to get the latest inode attrs for pre/post-op
> > info. In the event that fh_getattr fails, it resorts to scraping
> > cached
> > values out of the inode directly.
> >=20
> > Since these attributes are optional, we can just skip providing them
> > altogether when this happens.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > =A0fs/nfsd/nfsfh.c | 26 +++++++-------------------
> > =A01 file changed, 7 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index ccd8485fee04..e8e13ae72e3c 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -623,16 +623,9 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0inode =3D d_inode(fhp->fh_dentry);
> > =A0=A0=A0=A0=A0=A0=A0=A0err =3D fh_getattr(fhp, &stat);
> > -=A0=A0=A0=A0=A0=A0=A0if (err) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Grab the times from in=
ode anyway */
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0stat.mtime =3D inode->i_m=
time;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0stat.ctime =3D inode->i_c=
time;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0stat.size=A0 =3D inode->i=
_size;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (v4 && IS_I_VERSION(in=
ode)) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0s=
tat.change_cookie =3D
> > inode_query_iversion(inode);
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0s=
tat.result_mask |=3D STATX_CHANGE_COOKIE;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > -=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0if (err)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +
> > =A0=A0=A0=A0=A0=A0=A0=A0if (v4)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fhp->fh_pre_change =3D =
nfsd4_change_attribute(&stat,
> > inode);
> > =A0
> > @@ -660,15 +653,10 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk("nfsd: inode loc=
ked twice during
> > operation.\n");
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0err =3D fh_getattr(fhp, &fhp->fh_post_attr);
> > -=A0=A0=A0=A0=A0=A0=A0if (err) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fhp->fh_post_saved =3D fa=
lse;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fhp->fh_post_attr.ctime =
=3D inode->i_ctime;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (v4 && IS_I_VERSION(in=
ode)) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0f=
hp->fh_post_attr.change_cookie =3D
> > inode_query_iversion(inode);
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0f=
hp->fh_post_attr.result_mask |=3D
> > STATX_CHANGE_COOKIE;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > -=A0=A0=A0=A0=A0=A0=A0} else
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fhp->fh_post_saved =3D tr=
ue;
> > +=A0=A0=A0=A0=A0=A0=A0if (err)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0fhp->fh_post_saved =3D true;
> > =A0=A0=A0=A0=A0=A0=A0=A0if (v4)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fhp->fh_post_change =3D
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0nfsd4_change_attribute(&fhp->fh_post_attr,
> > inode);
>=20
> Unfortunately, I did recently find a corner case where this behaviour
> will break the Linux NFSv3 client. In the case where READ sometimes
> returns post-op attributes, and sometimes not, we can end up triggering
> the 'out_overflow' in xdr_get_next_encode_buffer(), resulting in an EIO
> error.
>=20
> The problem is ultimately due to the attempt by the client to align the
> pages to where it expects the READ reply to occur. When the behaviour
> is unpredictable, then it sometimes ends up allocating too little
> memory for the attributes, and ends up getting confused.
>=20
> This bug does need to be fixed in the client, but just a warning that
> the above server patch would be capable of triggering it.
>=20

Thanks for the heads up. This is not a critical issue, so I'm OK with
delaying this change if it's going to cause undue pain in the field. We
could also consider providing a module option or something in the
meantime, to give people a workaround if they hit it.

OTOH, this should only rarely happen. getattr doesn't often fail unless
you're exporting something like NFS or Ceph and someone does something
nefarious on the backend server/cluster.

--=20
Jeff Layton <jlayton@kernel.org>
