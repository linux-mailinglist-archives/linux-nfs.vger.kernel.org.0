Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4DB7CE6E4
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 20:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjJRSjM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 14:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjJRSjL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 14:39:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8403C114
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 11:39:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080EAC433CB
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 18:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697654348;
        bh=lTCoZ74B9AyQsS/cTTGAslX0e67xsNcWd6p1fJtgGyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XNYai6IR806eT7BN3v9J5zaV04LXAvlxrWfEO9VEMjKunwheOvzNMnwbsjn+0tDUt
         digcc8gu85HOBQrTGTbdKhmSbN6h4o4lXHFOCbTWscDZJoKsEx+G/Bao8wKq45BlO/
         HH3Wlh3dRiVh+6sUuCqTrjrPsCAlObWw3GjniX8J2qjz1DKMpIFqL0MF1nvlDgq51c
         5FhP5+Gy5zxxMUj8PxJo6FbRBbE/KR453MjZtQqjZmaWijUyx6CqN0nqtVMuzYuvHK
         RiTMrE6Ez8zqgoYUI/aARTXvkTM0qWK1+Jt/BCn+uWL27y4Gakz2IPh3N3bBfAtm7A
         lBFrRbtCUoXwQ==
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-457c7177a42so2416544137.2
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 11:39:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz+PSOKXTFehtchJjRBpLEhzzP42GpTmfG39VqVsaEOyRw0I7+m
        IOKnFIArK5TkVwnN4+E1sKTZmW9blBsQMwAuTC0=
X-Google-Smtp-Source: AGHT+IFuksqcmUGTmv5HRvSr8VsvO7BLkjAwwFlcAHPDGhfew6aB5bkdLiqrzrcygTqKcx/MZAjvwvt7VxQlc+C1kmk=
X-Received: by 2002:a67:c21c:0:b0:44d:5435:a3f with SMTP id
 i28-20020a67c21c000000b0044d54350a3fmr6550932vsj.29.1697654347110; Wed, 18
 Oct 2023 11:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697577945.git.bcodding@redhat.com> <bd900de1d19bc56e6df5b44379f373617acc894e.1697577945.git.bcodding@redhat.com>
 <ZS/V+4Cuzox7erqz@tissot.1015granger.net> <6157b73e380e5b625cd8ed0133ef392d0dd4bd8b.camel@kernel.org>
 <ZS/qwYzQvrgJNEv6@tissot.1015granger.net>
In-Reply-To: <ZS/qwYzQvrgJNEv6@tissot.1015granger.net>
From:   Anna Schumaker <anna@kernel.org>
Date:   Wed, 18 Oct 2023 14:38:51 -0400
X-Gmail-Original-Message-ID: <CAFX2JfkON+5MsYuw-SsvSg04M6Fy=BY_v7RZ9aAs35P7fD15Gw@mail.gmail.com>
Message-ID: <CAFX2JfkON+5MsYuw-SsvSg04M6Fy=BY_v7RZ9aAs35P7fD15Gw@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 18, 2023 at 10:25=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On Wed, Oct 18, 2023 at 09:33:40AM -0400, Jeff Layton wrote:
> > On Wed, 2023-10-18 at 08:56 -0400, Chuck Lever wrote:
> > > On Tue, Oct 17, 2023 at 05:30:44PM -0400, Benjamin Coddington wrote:
> > > > Expose a per-mount knob in sysfs to set the READDIR requested attri=
butes
> > > > for a non-plus READDIR request.
> > > >
> > > > For example:
> > > >
> > > >   echo 0x800 0x800000 0x0 > /sys/fs/nfs/0\:57/v4_readdir_attrs
> > > >

I understand why you're not adding a keyword for each attribute
requested in a readdir, but would it be possible to have a single
magic keyword like "reset" or "default" that is an alias for reverting
to the default attributes?

> > > > .. will revert the client to only request rdattr_error and
> > > > mounted_on_fileid for any non "plus" READDIR, as before the patch
> > > > preceeding this one in this series.  This provides existing install=
ations
> > > > an option to fix a potential performance regression that may occur =
after
> > > > NFS clients update to request additional default READDIR attributes=
.
> > > >
> > > > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> > > > ---
> > > >  fs/nfs/client.c           |  2 +
> > > >  fs/nfs/nfs4client.c       |  4 ++
> > > >  fs/nfs/nfs4proc.c         |  1 +
> > > >  fs/nfs/nfs4xdr.c          |  7 ++--
> > > >  fs/nfs/sysfs.c            | 81 +++++++++++++++++++++++++++++++++++=
++++
> > > >  include/linux/nfs_fs_sb.h |  1 +
> > > >  include/linux/nfs_xdr.h   |  1 +
> > > >  7 files changed, 93 insertions(+), 4 deletions(-)
> > >
> > > Admittedly, it would be much easier for humans to use if the API was
> > > based on the symbolic names of the bits rather than a triplet of raw
> > > hexadecimal values.
> > >
> >
> > I think there are some significant footguns with this interface. It'd b=
e
> > very easy to set this wrong and get weird behavior.  OTOH, we could pus=
h
> > that complexity into userland and provide some sort of script in nfs-
> > utils for tuning this.
> >
> > That said...
> >
> > When we look at interfaces like this, we have to consider that they may
> > be around for a long, long time (decades, even), and people will come t=
o
> > rely on them to do strange things that are difficult for us to support.
> > If we have someone saying that their READDIR performance slowed down, w=
e
> > now have to grab those settings from this sysfs file and validate them
> > when trying to help them.
> >
> > Personally, I'd prefer a simple binary "make it work the old way"
> > switch, if we're concerned about performance regressions here. I think
> > that's the sort of thing that is simple to explain to admins that are
> > suffering from this problem and (more importantly) the sort of setting
> > we can later remove when it's no longer needed.
> >
> > Adding this sort of fine-grained knob will create more problems than it
> > solves, as people will (inevitably) use it incorrectly.
>
> Totally agree with this assessment. It will get baked into wacky
> knowledge base articles for decades. Voice of experience here ;-)
>
> It's not yet clear sysadmins will even need a switch like this, so I
> would go further and say you should hold off on merging anything
> like it until there is an actual reported need for it.
>
> Now, full control over that bitmap is still very neat thing for
> experimentation by NFS developers. Hiding this behind a Kconfig
> option would let you merge it but then turn it off in production
> kernels.

Definitely a neat thing to have, but I'm also in favor of hiding it
behind a kconfig option to start.

Anna

>
>
> > > > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > > > index 44eca51b2808..e9aa1fd4335f 100644
> > > > --- a/fs/nfs/client.c
> > > > +++ b/fs/nfs/client.c
> > > > @@ -922,6 +922,8 @@ void nfs_server_copy_userdata(struct nfs_server=
 *target, struct nfs_server *sour
> > > >   target->options =3D source->options;
> > > >   target->auth_info =3D source->auth_info;
> > > >   target->port =3D source->port;
> > > > + memcpy(target->readdir_attrs, source->readdir_attrs,
> > > > +                 sizeof(target->readdir_attrs));
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(nfs_server_copy_userdata);
> > > >
> > > > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > > > index 11e3a285594c..3bbfb4244c14 100644
> > > > --- a/fs/nfs/nfs4client.c
> > > > +++ b/fs/nfs/nfs4client.c
> > > > @@ -1115,6 +1115,10 @@ static int nfs4_server_common_setup(struct n=
fs_server *server,
> > > >
> > > >   nfs4_server_set_init_caps(server);
> > > >
> > > > + /* Default (non-plus) v4 readdir attributes */
> > > > + server->readdir_attrs[0] =3D FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATT=
R_ERROR;
> > > > + server->readdir_attrs[1] =3D FATTR4_WORD1_MOUNTED_ON_FILEID;
> > > > +
> > > >   /* Probe the root fh to retrieve its FSID and filehandle */
> > > >   error =3D nfs4_get_rootfh(server, mntfh, auth_probe);
> > > >   if (error < 0)
> > > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > > index 7016eaadf555..0f0028de7941 100644
> > > > --- a/fs/nfs/nfs4proc.c
> > > > +++ b/fs/nfs/nfs4proc.c
> > > > @@ -5113,6 +5113,7 @@ static int _nfs4_proc_readdir(struct nfs_read=
dir_arg *nr_arg,
> > > >           .pgbase =3D 0,
> > > >           .count =3D nr_arg->page_len,
> > > >           .plus =3D nr_arg->plus,
> > > > +         .server =3D server,
> > > >   };
> > > >   struct nfs4_readdir_res res;
> > > >   struct rpc_message msg =3D {
> > > > diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> > > > index 7200d6f7cd7b..45a9b40b801e 100644
> > > > --- a/fs/nfs/nfs4xdr.c
> > > > +++ b/fs/nfs/nfs4xdr.c
> > > > @@ -1601,16 +1601,15 @@ static void encode_read(struct xdr_stream *=
xdr, const struct nfs_pgio_args *args
> > > >
> > > >  static void encode_readdir(struct xdr_stream *xdr, const struct nf=
s4_readdir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
> > > >  {
> > > > - uint32_t attrs[3] =3D {
> > > > -         FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR,
> > > > -         FATTR4_WORD1_MOUNTED_ON_FILEID,
> > > > - };
> > > > + uint32_t attrs[3];
> > > >   uint32_t dircount =3D readdir->count;
> > > >   uint32_t maxcount =3D readdir->count;
> > > >   __be32 *p, verf[2];
> > > >   uint32_t attrlen =3D 0;
> > > >   unsigned int i;
> > > >
> > > > + memcpy(attrs, readdir->server->readdir_attrs, sizeof(attrs));
> > > > +
> > > >   if (readdir->plus) {
> > > >           attrs[0] |=3D FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
> > > >                   FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_=
WORD0_FILEID;
> > > > diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> > > > index bf378ecd5d9f..6d4f52bf47b3 100644
> > > > --- a/fs/nfs/sysfs.c
> > > > +++ b/fs/nfs/sysfs.c
> > > > @@ -270,7 +270,82 @@ shutdown_store(struct kobject *kobj, struct ko=
bj_attribute *attr,
> > > >   return count;
> > > >  }
> > > >
> > > > +static ssize_t
> > > > +v4_readdir_attrs_show(struct kobject *kobj, struct kobj_attribute =
*attr,
> > > > +                         char *buf)
> > > > +{
> > > > + struct nfs_server *server;
> > > > + server =3D container_of(kobj, struct nfs_server, kobj);
> > > > +
> > > > + return sysfs_emit(buf, "0x%x 0x%x 0x%x\n",
> > > > +                 server->readdir_attrs[0],
> > > > +                 server->readdir_attrs[1],
> > > > +                 server->readdir_attrs[2]);
> > > > +}
> > > > +
> > > > +static ssize_t
> > > > +v4_readdir_attrs_store(struct kobject *kobj, struct kobj_attribute=
 *attr,
> > > > +                         const char *buf, size_t count)
> > > > +{
> > > > + struct nfs_server *server;
> > > > + u32 attrs[3];
> > > > + char p[36], *v;
> > > > + size_t token =3D 0;
> > > > + int i;
> > > > +
> > > > + if (count > 36)
> > > > +         return -EINVAL;
> > > > +
> > > > + v =3D strncpy(p, buf, count);
> > > > +
> > > > + for (i =3D 0; i < 3; i++) {
> > > > +         token +=3D strcspn(v, " ") + 1;
> > > > +         if (token > 34)
> > > > +                 return -EINVAL;
> > > > +
> > > > +         p[token - 1] =3D '\0';
> > > > +         if (kstrtoint(v, 0, &attrs[i]))
> > > > +                 return -EINVAL;
> > > > +         v =3D &p[token];
> > > > + }
> > > > +
> > > > + /* Allow only what we decode - see decode_getfattr_attrs() */
> > > > + if (attrs[0] & ~(FATTR4_WORD0_TYPE |
> > > > +                 FATTR4_WORD0_CHANGE |
> > > > +                 FATTR4_WORD0_SIZE |
> > > > +                 FATTR4_WORD0_FSID |
> > > > +                 FATTR4_WORD0_RDATTR_ERROR |
> > > > +                 FATTR4_WORD0_FILEHANDLE |
> > > > +                 FATTR4_WORD0_FILEID |
> > > > +                 FATTR4_WORD0_FS_LOCATIONS) ||
> > > > +         attrs[1] & ~(FATTR4_WORD1_MODE |
> > > > +                 FATTR4_WORD1_NUMLINKS |
> > > > +                 FATTR4_WORD1_OWNER |
> > > > +                 FATTR4_WORD1_OWNER_GROUP |
> > > > +                 FATTR4_WORD1_RAWDEV |
> > > > +                 FATTR4_WORD1_SPACE_USED |
> > > > +                 FATTR4_WORD1_TIME_ACCESS |
> > > > +                 FATTR4_WORD1_TIME_METADATA |
> > > > +                 FATTR4_WORD1_TIME_MODIFY |
> > > > +                 FATTR4_WORD1_MOUNTED_ON_FILEID) ||
> > > > +         attrs[2] & ~(FATTR4_WORD2_MDSTHRESHOLD |
> > > > +                 FATTR4_WORD2_SECURITY_LABEL))
> > > > +         return -EINVAL;
> > > > +
> > > > + server =3D container_of(kobj, struct nfs_server, kobj);
> > > > +
> > > > + if (attrs[0])
> > > > +         server->readdir_attrs[0] =3D attrs[0];
> > > > + if (attrs[1])
> > > > +         server->readdir_attrs[1] =3D attrs[1];
> > > > + if (attrs[2])
> > > > +         server->readdir_attrs[2] =3D attrs[2];
> > > > +
> > > > + return count;
> > > > +}
> > > > +
> > > >  static struct kobj_attribute nfs_sysfs_attr_shutdown =3D __ATTR_RW=
(shutdown);
> > > > +static struct kobj_attribute nfs_sysfs_attr_v4_readdir_attrs =3D _=
_ATTR_RW(v4_readdir_attrs);
> > > >
> > > >  #define RPC_CLIENT_NAME_SIZE 64
> > > >
> > > > @@ -325,6 +400,12 @@ void nfs_sysfs_add_server(struct nfs_server *s=
erver)
> > > >   if (ret < 0)
> > > >           pr_warn("NFS: sysfs_create_file_ns for server-%d failed (=
%d)\n",
> > > >                   server->s_sysfs_id, ret);
> > > > +
> > > > + ret =3D sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_v4_re=
addir_attrs.attr,
> > > > +                         nfs_netns_server_namespace(&server->kobj)=
);
> > > > + if (ret < 0)
> > > > +         pr_warn("NFS: sysfs_create_file_ns for server-%d failed (=
%d)\n",
> > > > +                 server->s_sysfs_id, ret);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
> > > >
> > > > diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> > > > index cd628c4b011e..db87261b7cd7 100644
> > > > --- a/include/linux/nfs_fs_sb.h
> > > > +++ b/include/linux/nfs_fs_sb.h
> > > > @@ -219,6 +219,7 @@ struct nfs_server {
> > > >                                              of change attribute, s=
ize, ctime
> > > >                                              and mtime attributes s=
upported by
> > > >                                              the server */
> > > > + u32                     readdir_attrs[3]; /* V4 tuneable default =
readdir attrs */
> > > >   u32                     acl_bitmask;    /* V4 bitmask representin=
g the ACEs
> > > >                                              that are supported on =
this
> > > >                                              filesystem */
> > > > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > > > index 12bbb5c63664..e05d861b1788 100644
> > > > --- a/include/linux/nfs_xdr.h
> > > > +++ b/include/linux/nfs_xdr.h
> > > > @@ -1142,6 +1142,7 @@ struct nfs4_readdir_arg {
> > > >   struct page **                  pages;  /* zero-copy data */
> > > >   unsigned int                    pgbase; /* zero-copy data */
> > > >   const u32 *                     bitmask;
> > > > + const struct nfs_server         *server;
> > > >   bool                            plus;
> > > >  };
> > > >
> > > > --
> > > > 2.41.0
> > > >
> > >
> >
> > --
> > Jeff Layton <jlayton@kernel.org>
>
> --
> Chuck Lever
