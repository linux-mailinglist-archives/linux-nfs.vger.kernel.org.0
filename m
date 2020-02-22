Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4142168D35
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Feb 2020 08:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBVHZS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Feb 2020 02:25:18 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46751 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbgBVHZS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Feb 2020 02:25:18 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 48554220AB;
        Sat, 22 Feb 2020 02:25:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 22 Feb 2020 02:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=pZsXeFLwpvkkZrkEqVGvo7W5G2A
        ZarCTt3hHqK7ixuY=; b=tpKdV3FNrSNXBWtvihTlnY1tmYCEvKewjv1PTj5+o4I
        nmfk9lEpBkBk5H7v5swM5TFkwvX80zZ0ffjNrdWl4PfJrJ6c/16NfweHlzgHR9ge
        vzoT2uTwBsTpoqt+Ktc3fidpCnmh5hy0NfQJfJCwuB7X24KYutHG/Aaje1ogBlTM
        O+p3+yjliQrneykHfTjOEjmD9CFm5ULcFa9s9tgNcVcC4R6i0xLcW+Cl6dKyVafU
        OOOoptcVghslF/IYBAMv0eNKPfRGL2AIKNTKj7r3MHymcqECaOlsMpnlX2gT/yuS
        IuBa3NcF3jFwrVVd8iHj93APqsh1ju9K+Z8xUvanaqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=pZsXeF
        LwpvkkZrkEqVGvo7W5G2AZarCTt3hHqK7ixuY=; b=VDDq/jLBOaemr0ppaoD8j1
        daQ+TdBILj+O2EHbqBcnXHTEV3nEG9clucUIm7/ofJoUqyjXSeun5LXJjDhnatmz
        CNiu4uzdZT5ZJduSqjstCEqwmSTLM4nYixw5SWx7Quiks0HEJne1r8YnWcGTMvlD
        v4GsYQ0l1K+CfyPyvv0syR5HZxIhI4JTR+y4G1ttCCKAYmqRdOERJ+8hXkZ+DmOh
        2Two14DNVOgTPNEHWOaErq/vkZXrSGbMIaT+YyUknLRmr5zmglxYtp9wzb5MGzdm
        4PMAEnFxXy6T2O1AXoWJdOHRgmdoCCWSEDXrDLgWMrC7aBfNp8GO9HEr9mS+O3xg
        ==
X-ME-Sender: <xms:XNdQXn44z9hsmbRD6UINgGFpGdPUbzaTNiGZbTNhbK2t1EXoEgVgcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeehgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddule
    durdduleeirddvgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:XNdQXhI3SXYHIzhC7hkXNc2ELojXokRsjOoDLvw8lht4SOUNCFOusg>
    <xmx:XNdQXpeL6Ubr2d29ccBz_We_2vufLH4D6AKS7wqORRYmtAkyYRPUxA>
    <xmx:XNdQXsciDbV1XvVbanIK11eMK1PtE5bcRn2TXpGKRkR5GlmWDhsQFA>
    <xmx:XddQXqYOi3yMXOEer44Hdf0sG6YMEBhYjiDhaq8-T3nfmyB21mmWtA>
Received: from vm-mail (x4dbfc4f4.dyn.telefonica.de [77.191.196.244])
        by mail.messagingengine.com (Postfix) with ESMTPA id 971353060D1A;
        Sat, 22 Feb 2020 02:25:15 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id 426793b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 22 Feb 2020 07:25:13 +0000 (UTC)
Date:   Sat, 22 Feb 2020 08:25:45 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        dhowells@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Don't hard-code the fs_type when submounting
Message-ID: <20200222072535.GA4618@ncase>
References: <20200220130620.3547817-1-smayhew@redhat.com>
 <20200220134618.GA4641@ncase>
 <20200221202105.GA3175@aion.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <20200221202105.GA3175@aion.usersys.redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 03:21:05PM -0500, Scott Mayhew wrote:
> On Thu, 20 Feb 2020, Patrick Steinhardt wrote:
>=20
> > On Thu, Feb 20, 2020 at 08:06:20AM -0500, Scott Mayhew wrote:
> > > Hard-coding the fstype causes "nfs4" mounts to appear as "nfs",
> > > which breaks scripts that do "umount -at nfs4".
> > >=20
> > > Reported-by: Patrick Steinhardt <ps@pks.im>
> > > Fixes: f2aedb713c28 ("NFS: Add fs_context support.")
> > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > ---
> > >  fs/nfs/namespace.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> > > index ad6077404947..f3ece8ed3203 100644
> > > --- a/fs/nfs/namespace.c
> > > +++ b/fs/nfs/namespace.c
> > > @@ -153,7 +153,7 @@ struct vfsmount *nfs_d_automount(struct path *pat=
h)
> > >  	/* Open a new filesystem context, transferring parameters from the
> > >  	 * parent superblock, including the network namespace.
> > >  	 */
> > > -	fc =3D fs_context_for_submount(&nfs_fs_type, path->dentry);
> > > +	fc =3D fs_context_for_submount(path->mnt->mnt_sb->s_type, path->den=
try);
> > >  	if (IS_ERR(fc))
> > >  		return ERR_CAST(fc);
> >=20
> > Thanks for your fix! While this fixes the fstype with mount.nfs4(8),
> > it still doesn't work when using mount(8):
> >=20
> >      $ sudo mount server:/mnt /mnt && findmnt -n -ofstype /mnt
> >      nfs
> >      $ sudo umount /mnt
> >      $ sudo mount.nfs4 server:/mnt /mnt && findmnt -n -ofstype /mnt
> >      nfs4
> >=20
> > I guess the issue is that the kernel doesn't yet know which NFS version
> > the server provides at the point where `fs_context_for_submount()` is
> > called.
>=20
> Thanks for testing.  Actually the problem is that the super_block's
> s_type is now based on the fs_context->fs_type field, which is set when
> the fs_context is created (way before the mount options are parsed).
> When you use mount(8) without specifying '-t nfs4', it defaults to
> using the mount.nfs helper, which calls mount(2) with 'nfs' as the
> fstype.  I'm sending a second patch that double-checks the
> fs_context->fs_type after the mount options have been parsed.  We still
> shouldn't be hard-coding the fstype in fs_context_for_submount() though
> (i.e. both patches are needed).

I can confirm that the problem is fixed with both patches applied.
Thanks a lot!

Patrick

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAl5Q13kACgkQEXxntp6r
8SxibxAAievKouJnHiXgfN8+2bAK7L5o5FnwGwT2waEMzQ5CnFbLBDq3DO2QUeGa
meTvSBO67G0VuN6iE8pwYYi1zq9l88SmeS62XksT25r8vhmFLWtsUOyoTtzDt1IV
0vsCSCSj7f7R5/4Aj3fbaqeyI2NPdvha5XRuJXhgtX3I1BsVDnFj2Aqj+u+iSfO4
BqQSmM4hJMfQslquhW8CgXh6AWXy5b4zpi3Y7KmdsiSWXzcKjAoEzSVisy8yz4t6
/HdggqN4pCuNptUnU0rohBqMLtzs9duH2HQOyasVVJUEV45RuqtmGDukI9cnd5tR
4dDQuwpTWHAZcSXPW2YH/JymrykzjzR9CGozU0ENkyTMRhkNOhMP5EqGWxO9/yvE
mg1fwUiMCN7a9QcmWIltX9wzL8fnWoRh4jIu0xwpx/U+5aEwhM0+yDELYVtLM9a9
PcBe417Ba0GWjjknK/PPOaYtBUJZUMvn1LIr95j7mAUYPN8TBtlYvD0Rsihh3j5a
X+wDhBksk3I7LEb4sjlyFkhJYba5TwtuXEbnELNWF1C0PNk4I9s5zmifjOkjJCNA
qwsvmUje/reH35lbCZz24YMxLgWrLNkyiQbt+glyS9CLhxVHnk/+xf6hJp/BP7Sg
10Rxk3IL3QtKfiNGY0KSdsNwO9NTKvBxaGZmYVmdsaWf5vFawxA=
=YPpu
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
