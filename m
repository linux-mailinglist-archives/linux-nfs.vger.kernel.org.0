Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393FF604D47
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiJSQXl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 12:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiJSQX1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 12:23:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23DA1C7D7A
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 09:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66DCEB824FA
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 16:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6AEC433C1;
        Wed, 19 Oct 2022 16:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666196582;
        bh=MVy0Fo1C9ZBQ8MLVtnax4/02OyQAfikyXsc6COXfXB8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t82ZadLN4i3zPiNcSr+ygw8LIVnz0DmzNK9oPNEnMzlUwWxntZUP4vv3nAVVLLECe
         32NaM/5PJrLSCZ5Vz49cBxMOCKV1EHyzNBtS/bsnhJJclfpX0OPT/WoGCzt8Y8XDit
         nxqp3vzfKUOxmEUGP78A7wWRVJKBqS9Swyqq63Ng+RfOYGqDczd0HJqLvgQTLJXkNR
         4/OL6ZnY0Dx7UUn+k5sjork5EPwxCE12dEq9iOsJr1CcblBbCGzNSGT4SXLLxwbu4W
         lqJEfekB29sG8UH07gFKHTLDdO0V9PxN5daOvPWuq6ztoLDUXN+pL2VBVttVBMF8zM
         PsgsNltJoTFgg==
Message-ID: <636e82620a796d38a0a6784cc8f65efd9d71d680.camel@kernel.org>
Subject: Re: [PATCH v3 3/3] nfsd: allow disabling NFSv2 at compile time
From:   Jeff Layton <jlayton@kernel.org>
To:     Tom Talpey <tom@talpey.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 19 Oct 2022 12:23:00 -0400
In-Reply-To: <865a1b1f-811d-312c-4141-31e572b37679@talpey.com>
References: <20221018114756.23679-1-jlayton@kernel.org>
         <20221018114756.23679-3-jlayton@kernel.org>
         <865a1b1f-811d-312c-4141-31e572b37679@talpey.com>
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

On Wed, 2022-10-19 at 11:09 -0400, Tom Talpey wrote:
> LGTM
>=20
> Reviewed-by: Tom Talpey <tom@talpey.com>
>=20
> Next, to make it a module!
>=20

We could, but I'm not sure it's worthwhile. We'd need to export about 15
symbols from nfsd.ko. Personally I'd rather see it just go away
eventually.

> On 10/18/2022 7:47 AM, Jeff Layton wrote:
> > rpc.nfsd stopped supporting NFSv2 a year ago. Take the next logical
> > step toward deprecating it and allow NFSv2 support to be compiled out.
> >=20
> > Add a new CONFIG_NFSD_V2 option that can be turned off and rework the
> > CONFIG_NFSD_V?_ACL option dependencies. Add a description that
> > discourages enabling it.
> >=20
> > Also, change the description of CONFIG_NFSD to state that the always-on
> > version is now 3 instead of 2.
> >=20
> > Finally, add an #ifdef around "case 2:" in __write_versions. When NFSv2
> > is disabled at compile time, this should make the kernel ignore attempt=
s
> > to disable it at runtime, but still error out when trying to enable it.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/nfsd/Kconfig  | 19 +++++++++++++++----
> >   fs/nfsd/Makefile |  5 +++--
> >   fs/nfsd/nfsctl.c |  2 ++
> >   fs/nfsd/nfsd.h   |  3 +--
> >   fs/nfsd/nfssvc.c |  6 ++++++
> >   5 files changed, 27 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> > index f6a2fd3015e7..7c441f2bd444 100644
> > --- a/fs/nfsd/Kconfig
> > +++ b/fs/nfsd/Kconfig
> > @@ -8,6 +8,7 @@ config NFSD
> >   	select SUNRPC
> >   	select EXPORTFS
> >   	select NFS_ACL_SUPPORT if NFSD_V2_ACL
> > +	select NFS_ACL_SUPPORT if NFSD_V3_ACL
> >   	depends on MULTIUSER
> >   	help
> >   	  Choose Y here if you want to allow other computers to access
> > @@ -26,19 +27,29 @@ config NFSD
> >  =20
> >   	  Below you can choose which versions of the NFS protocol are
> >   	  available to clients mounting the NFS server on this system.
> > -	  Support for NFS version 2 (RFC 1094) is always available when
> > +	  Support for NFS version 3 (RFC 1813) is always available when
> >   	  CONFIG_NFSD is selected.
> >  =20
> >   	  If unsure, say N.
> >  =20
> > -config NFSD_V2_ACL
> > -	bool
> > +config NFSD_V2
> > +	bool "NFS server support for NFS version 2 (DEPRECATED)"
> >   	depends on NFSD
> > +	default n
> > +	help
> > +	  NFSv2 (RFC 1094) was the first publicly-released version of NFS.
> > +	  Unless you are hosting ancient (1990's era) NFS clients, you don't
> > +	  need this.
> > +
> > +	  If unsure, say N.
> > +
> > +config NFSD_V2_ACL
> > +	bool "NFS server support for the NFSv2 ACL protocol extension"
> > +	depends on NFSD_V2
> >  =20
> >   config NFSD_V3_ACL
> >   	bool "NFS server support for the NFSv3 ACL protocol extension"
> >   	depends on NFSD
> > -	select NFSD_V2_ACL
> >   	help
> >   	  Solaris NFS servers support an auxiliary NFSv3 ACL protocol that
> >   	  never became an official part of the NFS version 3 protocol.
> > diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> > index 805c06d5f1b4..6fffc8f03f74 100644
> > --- a/fs/nfsd/Makefile
> > +++ b/fs/nfsd/Makefile
> > @@ -10,9 +10,10 @@ obj-$(CONFIG_NFSD)	+=3D nfsd.o
> >   # this one should be compiled first, as the tracing macros can easily=
 blow up
> >   nfsd-y			+=3D trace.o
> >  =20
> > -nfsd-y 			+=3D nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \
> > -			   export.o auth.o lockd.o nfscache.o nfsxdr.o \
> > +nfsd-y 			+=3D nfssvc.o nfsctl.o nfsfh.o vfs.o \
> > +			   export.o auth.o lockd.o nfscache.o \
> >   			   stats.o filecache.o nfs3proc.o nfs3xdr.o
> > +nfsd-$(CONFIG_NFSD_V2) +=3D nfsproc.o nfsxdr.o
> >   nfsd-$(CONFIG_NFSD_V2_ACL) +=3D nfs2acl.o
> >   nfsd-$(CONFIG_NFSD_V3_ACL) +=3D nfs3acl.o
> >   nfsd-$(CONFIG_NFSD_V4)	+=3D nfs4proc.o nfs4xdr.o nfs4state.o nfs4idma=
p.o \
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 68ed42fd29fc..d1e581a60480 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -581,7 +581,9 @@ static ssize_t __write_versions(struct file *file, =
char *buf, size_t size)
> >  =20
> >   			cmd =3D sign =3D=3D '-' ? NFSD_CLEAR : NFSD_SET;
> >   			switch(num) {
> > +#ifdef CONFIG_NFSD_V2
> >   			case 2:
> > +#endif
> >   			case 3:
> >   				nfsd_vers(nn, num, cmd);
> >   				break;
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 09726c5b9a31..93b42ef9ed91 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -64,8 +64,7 @@ struct readdir_cd {
> >  =20
> >  =20
> >   extern struct svc_program	nfsd_program;
> > -extern const struct svc_version	nfsd_version2, nfsd_version3,
> > -				nfsd_version4;
> > +extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_ver=
sion4;
> >   extern struct mutex		nfsd_mutex;
> >   extern spinlock_t		nfsd_drc_lock;
> >   extern unsigned long		nfsd_drc_max_mem;
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index bfbd9f672f59..62e473b0ca52 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -91,8 +91,12 @@ unsigned long	nfsd_drc_mem_used;
> >   #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> >   static struct svc_stat	nfsd_acl_svcstats;
> >   static const struct svc_version *nfsd_acl_version[] =3D {
> > +# if defined(CONFIG_NFSD_V2_ACL)
> >   	[2] =3D &nfsd_acl_version2,
> > +# endif
> > +# if defined(CONFIG_NFSD_V3_ACL)
> >   	[3] =3D &nfsd_acl_version3,
> > +# endif
> >   };
> >  =20
> >   #define NFSD_ACL_MINVERS            2
> > @@ -116,7 +120,9 @@ static struct svc_stat	nfsd_acl_svcstats =3D {
> >   #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) =
*/
> >  =20
> >   static const struct svc_version *nfsd_version[] =3D {
> > +#if defined(CONFIG_NFSD_V2)
> >   	[2] =3D &nfsd_version2,
> > +#endif
> >   	[3] =3D &nfsd_version3,
> >   #if defined(CONFIG_NFSD_V4)
> >   	[4] =3D &nfsd_version4,

--=20
Jeff Layton <jlayton@kernel.org>
