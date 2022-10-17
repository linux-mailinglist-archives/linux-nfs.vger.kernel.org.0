Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4853601C29
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 00:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiJQWOw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 18:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJQWOu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 18:14:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE2618B24
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 15:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D11EE612A1
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 22:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B04C433B5;
        Mon, 17 Oct 2022 22:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666044885;
        bh=IKpqErjack3+HUdMbZG+zUzu5Nmm6XwqapMOO2+yvm4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pyKUcYF0w5CrOgxNYQhb7+X2NOvJwpt2Fjy7chMQTpixrnhf9NcuQMuJf9V0rJOTg
         hlRCuGkavPHWf20i82WoqtE9bMu1qt+6lpjZaFVQDDN1/CmGTJONQ1L7chmZO+vOSL
         Op8L8cp73o2MHudpZemTWFPN77n913sHRVmvf4RTD8mnOKbWuRf/QoLgGD7t/MFNmf
         BpTb/UccU+Ae1Sl60LR0jmuNp0A3wzw+4bA/7MNgNOtswktATA76tCXHAB/+s/o7JH
         yH/mff9Xnwof6XuKCs4EBMQfGZlvjXQxMN8QRUAxWA+gr07azy6zwCNdvcwfLOoEX4
         cokJIDNHvlbfA==
Message-ID: <88469313a5ac32984bfc08bfe13851d27f6472c9.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] nfsd: allow disabling NFSv2 at compile time
From:   Jeff Layton <jlayton@kernel.org>
To:     Tom Talpey <tom@talpey.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 17 Oct 2022 18:14:43 -0400
In-Reply-To: <5a3646b2-685b-1fbb-ab8a-2c4a8449a647@talpey.com>
References: <20221017201436.487627-1-jlayton@kernel.org>
         <20221017201436.487627-2-jlayton@kernel.org>
         <0A1BE7DD-070F-4427-823A-92866DC7C9A9@oracle.com>
         <5a3646b2-685b-1fbb-ab8a-2c4a8449a647@talpey.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-17 at 17:22 -0400, Tom Talpey wrote:
> On 10/17/2022 4:25 PM, Chuck Lever III wrote:
> >=20
> >=20
> > > On Oct 17, 2022, at 4:14 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > rpc.nfsd stopped supporting NFSv2 a year ago. Take the next logical
> > > step toward deprecating it and allow NFSv2 support to be compiled out=
.
> > >=20
> > > Add a new CONFIG_NFSD_V2 option that can be turned off and rework the
> > > CONFIG_NFSD_V?_ACL option dependencies. Add a description that
> > > discourages enabling it.
> > >=20
> > > Also, change the description of CONFIG_NFSD to state that the always-=
on
> > > version is now 3 instead of 2.
> >=20
> > This works for me. I'll wait for more comments, but I plan
> > to pull this into for-next soon.
>=20
> It's a worthy change, but it's only a small step along the way.
> Distros will still be forced to set NFSD_V2, because they'll
> want a way to allow V2 support but there's only one V2/V3
> module to package it in. So, they're stuck turning it on.
>=20
> But, shouldn't this at least squawk if the admin attempts to
> enable V2 when it's not configured? I don't usually suggest
> a message in the kernel log, but this one seems important.
>=20

rpc.nfsd already syslogs a message when it hits an error writing to the
versions file, AFAICT. The main problem is that /usr/bin/rpc.nfsd will
write a string like this to /proc/fs/nfsd/versions (depending on
options):

    -2 +3 +4.0 -4.1 +4.2

...and if the kernel errors out on the -2, it'll abort and not apply the
other settings in that string. rpc.nfsd then logs and ignores the error
and nfsd runs anyway.

ISTM that the kernel probably ought to ignore requests to disable the
versions that it doesn't support, but error out when you try to enable a
version that isn't supported. That should make rpc.nfsd still work as
expected, at least as far as disabling v2.

I'll plan to do one more respin with that approach.

>=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > fs/nfsd/Kconfig  | 19 +++++++++++++++----
> > > fs/nfsd/Makefile |  5 +++--
> > > fs/nfsd/nfsd.h   |  3 +--
> > > fs/nfsd/nfssvc.c |  6 ++++++
> > > 4 files changed, 25 insertions(+), 8 deletions(-)
> > >=20
> > > v2: split out nfserrno move into separate patch
> > >     add help text to CONFIG_NFSD_V2 Kconfig option
> > >     don't error out in __write_versions
> > >=20
> > > diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> > > index f6a2fd3015e7..7c441f2bd444 100644
> > > --- a/fs/nfsd/Kconfig
> > > +++ b/fs/nfsd/Kconfig
> > > @@ -8,6 +8,7 @@ config NFSD
> > > 	select SUNRPC
> > > 	select EXPORTFS
> > > 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
> > > +	select NFS_ACL_SUPPORT if NFSD_V3_ACL
> > > 	depends on MULTIUSER
> > > 	help
> > > 	  Choose Y here if you want to allow other computers to access
> > > @@ -26,19 +27,29 @@ config NFSD
> > >=20
> > > 	  Below you can choose which versions of the NFS protocol are
> > > 	  available to clients mounting the NFS server on this system.
> > > -	  Support for NFS version 2 (RFC 1094) is always available when
> > > +	  Support for NFS version 3 (RFC 1813) is always available when
> > > 	  CONFIG_NFSD is selected.
> > >=20
> > > 	  If unsure, say N.
> > >=20
> > > -config NFSD_V2_ACL
> > > -	bool
> > > +config NFSD_V2
> > > +	bool "NFS server support for NFS version 2 (DEPRECATED)"
> > > 	depends on NFSD
> > > +	default n
> > > +	help
> > > +	  NFSv2 (RFC 1094) was the first publicly-released version of NFS.
> > > +	  Unless you are hosting ancient (1990's era) NFS clients, you don'=
t
> > > +	  need this.
> > > +
> > > +	  If unsure, say N.
> > > +
> > > +config NFSD_V2_ACL
> > > +	bool "NFS server support for the NFSv2 ACL protocol extension"
> > > +	depends on NFSD_V2
> > >=20
> > > config NFSD_V3_ACL
> > > 	bool "NFS server support for the NFSv3 ACL protocol extension"
> > > 	depends on NFSD
> > > -	select NFSD_V2_ACL
> > > 	help
> > > 	  Solaris NFS servers support an auxiliary NFSv3 ACL protocol that
> > > 	  never became an official part of the NFS version 3 protocol.
> > > diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> > > index 805c06d5f1b4..6fffc8f03f74 100644
> > > --- a/fs/nfsd/Makefile
> > > +++ b/fs/nfsd/Makefile
> > > @@ -10,9 +10,10 @@ obj-$(CONFIG_NFSD)	+=3D nfsd.o
> > > # this one should be compiled first, as the tracing macros can easily=
 blow up
> > > nfsd-y			+=3D trace.o
> > >=20
> > > -nfsd-y 			+=3D nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \
> > > -			   export.o auth.o lockd.o nfscache.o nfsxdr.o \
> > > +nfsd-y 			+=3D nfssvc.o nfsctl.o nfsfh.o vfs.o \
> > > +			   export.o auth.o lockd.o nfscache.o \
> > > 			   stats.o filecache.o nfs3proc.o nfs3xdr.o
> > > +nfsd-$(CONFIG_NFSD_V2) +=3D nfsproc.o nfsxdr.o
> > > nfsd-$(CONFIG_NFSD_V2_ACL) +=3D nfs2acl.o
> > > nfsd-$(CONFIG_NFSD_V3_ACL) +=3D nfs3acl.o
> > > nfsd-$(CONFIG_NFSD_V4)	+=3D nfs4proc.o nfs4xdr.o nfs4state.o nfs4idma=
p.o \
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index 09726c5b9a31..93b42ef9ed91 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -64,8 +64,7 @@ struct readdir_cd {
> > >=20
> > >=20
> > > extern struct svc_program	nfsd_program;
> > > -extern const struct svc_version	nfsd_version2, nfsd_version3,
> > > -				nfsd_version4;
> > > +extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_v=
ersion4;
> > > extern struct mutex		nfsd_mutex;
> > > extern spinlock_t		nfsd_drc_lock;
> > > extern unsigned long		nfsd_drc_max_mem;
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index bfbd9f672f59..62e473b0ca52 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -91,8 +91,12 @@ unsigned long	nfsd_drc_mem_used;
> > > #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> > > static struct svc_stat	nfsd_acl_svcstats;
> > > static const struct svc_version *nfsd_acl_version[] =3D {
> > > +# if defined(CONFIG_NFSD_V2_ACL)
> > > 	[2] =3D &nfsd_acl_version2,
> > > +# endif
> > > +# if defined(CONFIG_NFSD_V3_ACL)
> > > 	[3] =3D &nfsd_acl_version3,
> > > +# endif
> > > };
> > >=20
> > > #define NFSD_ACL_MINVERS            2
> > > @@ -116,7 +120,9 @@ static struct svc_stat	nfsd_acl_svcstats =3D {
> > > #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) =
*/
> > >=20
> > > static const struct svc_version *nfsd_version[] =3D {
> > > +#if defined(CONFIG_NFSD_V2)
> > > 	[2] =3D &nfsd_version2,
> > > +#endif
> > > 	[3] =3D &nfsd_version3,
> > > #if defined(CONFIG_NFSD_V4)
> > > 	[4] =3D &nfsd_version4,
> > > --=20
> > > 2.37.3
> > >=20
> >=20
> > --
> > Chuck Lever
> >=20
> >=20
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
