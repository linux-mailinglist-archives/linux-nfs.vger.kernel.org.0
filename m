Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444627CDD5D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 15:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjJRNdp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 09:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjJRNdo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 09:33:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BD2BA
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 06:33:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A294C433C8;
        Wed, 18 Oct 2023 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697636022;
        bh=/KVVEvhK2wTmzNCW5aIqNbFOEHRTLC4/5aBMD+XOMpE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l+YFQK6HyfC/mt7R+oR4M4d5O/ue9WD/7LkEm20R23yilkkxoP3zeAB8ulgwqebID
         XJdi0yKdLeonn60JCG0Z5zM9U1Ao7VCdVN+n63p+VKr7xRhc6L2QVI6HzdnXfDtPA0
         JbUHNRhCdxJfVQ+RRsT8h8mmyQh35SN0bnOFup2mk4/vSxmf6KO8vBaqhBvJ3bFqz2
         iqlWR0+AZhxIMK0o2I5MzCzcrzg/biNCT4takPvAGVzGDSzX79kCDjAvjVlh+Oy+vV
         6prSA41ljVOrnx1Ghibbg0lr1UWxGdQC6rxi5Du7QUCE5OM8Mk9DfHXoA1SMWLsZfC
         kyXSXFU4r5pfg==
Message-ID: <6157b73e380e5b625cd8ed0133ef392d0dd4bd8b.camel@kernel.org>
Subject: Re: [PATCH 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Date:   Wed, 18 Oct 2023 09:33:40 -0400
In-Reply-To: <ZS/V+4Cuzox7erqz@tissot.1015granger.net>
References: <cover.1697577945.git.bcodding@redhat.com>
         <bd900de1d19bc56e6df5b44379f373617acc894e.1697577945.git.bcodding@redhat.com>
         <ZS/V+4Cuzox7erqz@tissot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-10-18 at 08:56 -0400, Chuck Lever wrote:
> On Tue, Oct 17, 2023 at 05:30:44PM -0400, Benjamin Coddington wrote:
> > Expose a per-mount knob in sysfs to set the READDIR requested attribute=
s
> > for a non-plus READDIR request.
> >=20
> > For example:
> >=20
> >   echo 0x800 0x800000 0x0 > /sys/fs/nfs/0\:57/v4_readdir_attrs
> >=20
> > .. will revert the client to only request rdattr_error and
> > mounted_on_fileid for any non "plus" READDIR, as before the patch
> > preceeding this one in this series.  This provides existing installatio=
ns
> > an option to fix a potential performance regression that may occur afte=
r
> > NFS clients update to request additional default READDIR attributes.
> >=20
> > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> > ---
> >  fs/nfs/client.c           |  2 +
> >  fs/nfs/nfs4client.c       |  4 ++
> >  fs/nfs/nfs4proc.c         |  1 +
> >  fs/nfs/nfs4xdr.c          |  7 ++--
> >  fs/nfs/sysfs.c            | 81 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/nfs_fs_sb.h |  1 +
> >  include/linux/nfs_xdr.h   |  1 +
> >  7 files changed, 93 insertions(+), 4 deletions(-)
>=20
> Admittedly, it would be much easier for humans to use if the API was
> based on the symbolic names of the bits rather than a triplet of raw
> hexadecimal values.
>=20

I think there are some significant footguns with this interface. It'd be
very easy to set this wrong and get weird behavior.  OTOH, we could push
that complexity into userland and provide some sort of script in nfs-
utils for tuning this.

That said...

When we look at interfaces like this, we have to consider that they may
be around for a long, long time (decades, even), and people will come to
rely on them to do strange things that are difficult for us to support.
If we have someone saying that their READDIR performance slowed down, we
now have to grab those settings from this sysfs file and validate them
when trying to help them.

Personally, I'd prefer a simple binary "make it work the old way"
switch, if we're concerned about performance regressions here. I think
that's the sort of thing that is simple to explain to admins that are
suffering from this problem and (more importantly) the sort of setting
we can later remove when it's no longer needed.

Adding this sort of fine-grained knob will create more problems than it
solves, as people will (inevitably) use it incorrectly.

>=20
> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index 44eca51b2808..e9aa1fd4335f 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> > @@ -922,6 +922,8 @@ void nfs_server_copy_userdata(struct nfs_server *ta=
rget, struct nfs_server *sour
> >  	target->options =3D source->options;
> >  	target->auth_info =3D source->auth_info;
> >  	target->port =3D source->port;
> > +	memcpy(target->readdir_attrs, source->readdir_attrs,
> > +			sizeof(target->readdir_attrs));
> >  }
> >  EXPORT_SYMBOL_GPL(nfs_server_copy_userdata);
> > =20
> > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > index 11e3a285594c..3bbfb4244c14 100644
> > --- a/fs/nfs/nfs4client.c
> > +++ b/fs/nfs/nfs4client.c
> > @@ -1115,6 +1115,10 @@ static int nfs4_server_common_setup(struct nfs_s=
erver *server,
> > =20
> >  	nfs4_server_set_init_caps(server);
> > =20
> > +	/* Default (non-plus) v4 readdir attributes */
> > +	server->readdir_attrs[0] =3D FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ER=
ROR;
> > +	server->readdir_attrs[1] =3D FATTR4_WORD1_MOUNTED_ON_FILEID;
> > +
> >  	/* Probe the root fh to retrieve its FSID and filehandle */
> >  	error =3D nfs4_get_rootfh(server, mntfh, auth_probe);
> >  	if (error < 0)
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 7016eaadf555..0f0028de7941 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -5113,6 +5113,7 @@ static int _nfs4_proc_readdir(struct nfs_readdir_=
arg *nr_arg,
> >  		.pgbase =3D 0,
> >  		.count =3D nr_arg->page_len,
> >  		.plus =3D nr_arg->plus,
> > +		.server =3D server,
> >  	};
> >  	struct nfs4_readdir_res res;
> >  	struct rpc_message msg =3D {
> > diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> > index 7200d6f7cd7b..45a9b40b801e 100644
> > --- a/fs/nfs/nfs4xdr.c
> > +++ b/fs/nfs/nfs4xdr.c
> > @@ -1601,16 +1601,15 @@ static void encode_read(struct xdr_stream *xdr,=
 const struct nfs_pgio_args *args
> > =20
> >  static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_r=
eaddir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
> >  {
> > -	uint32_t attrs[3] =3D {
> > -		FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR,
> > -		FATTR4_WORD1_MOUNTED_ON_FILEID,
> > -	};
> > +	uint32_t attrs[3];
> >  	uint32_t dircount =3D readdir->count;
> >  	uint32_t maxcount =3D readdir->count;
> >  	__be32 *p, verf[2];
> >  	uint32_t attrlen =3D 0;
> >  	unsigned int i;
> > =20
> > +	memcpy(attrs, readdir->server->readdir_attrs, sizeof(attrs));
> > +
> >  	if (readdir->plus) {
> >  		attrs[0] |=3D FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
> >  			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
> > diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> > index bf378ecd5d9f..6d4f52bf47b3 100644
> > --- a/fs/nfs/sysfs.c
> > +++ b/fs/nfs/sysfs.c
> > @@ -270,7 +270,82 @@ shutdown_store(struct kobject *kobj, struct kobj_a=
ttribute *attr,
> >  	return count;
> >  }
> > =20
> > +static ssize_t
> > +v4_readdir_attrs_show(struct kobject *kobj, struct kobj_attribute *att=
r,
> > +				char *buf)
> > +{
> > +	struct nfs_server *server;
> > +	server =3D container_of(kobj, struct nfs_server, kobj);
> > +
> > +	return sysfs_emit(buf, "0x%x 0x%x 0x%x\n",
> > +			server->readdir_attrs[0],
> > +			server->readdir_attrs[1],
> > +			server->readdir_attrs[2]);
> > +}
> > +
> > +static ssize_t
> > +v4_readdir_attrs_store(struct kobject *kobj, struct kobj_attribute *at=
tr,
> > +				const char *buf, size_t count)
> > +{
> > +	struct nfs_server *server;
> > +	u32 attrs[3];
> > +	char p[36], *v;
> > +	size_t token =3D 0;
> > +	int i;
> > +
> > +	if (count > 36)
> > +		return -EINVAL;
> > +
> > +	v =3D strncpy(p, buf, count);
> > +
> > +	for (i =3D 0; i < 3; i++) {
> > +		token +=3D strcspn(v, " ") + 1;
> > +		if (token > 34)
> > +			return -EINVAL;
> > +
> > +		p[token - 1] =3D '\0';
> > +		if (kstrtoint(v, 0, &attrs[i]))
> > +			return -EINVAL;
> > +		v =3D &p[token];
> > +	}
> > +
> > +	/* Allow only what we decode - see decode_getfattr_attrs() */
> > +	if (attrs[0] & ~(FATTR4_WORD0_TYPE |
> > +			FATTR4_WORD0_CHANGE |
> > +			FATTR4_WORD0_SIZE |
> > +			FATTR4_WORD0_FSID |
> > +			FATTR4_WORD0_RDATTR_ERROR |
> > +			FATTR4_WORD0_FILEHANDLE |
> > +			FATTR4_WORD0_FILEID |
> > +			FATTR4_WORD0_FS_LOCATIONS) ||
> > +		attrs[1] & ~(FATTR4_WORD1_MODE |
> > +			FATTR4_WORD1_NUMLINKS |
> > +			FATTR4_WORD1_OWNER |
> > +			FATTR4_WORD1_OWNER_GROUP |
> > +			FATTR4_WORD1_RAWDEV |
> > +			FATTR4_WORD1_SPACE_USED |
> > +			FATTR4_WORD1_TIME_ACCESS |
> > +			FATTR4_WORD1_TIME_METADATA |
> > +			FATTR4_WORD1_TIME_MODIFY |
> > +			FATTR4_WORD1_MOUNTED_ON_FILEID) ||
> > +		attrs[2] & ~(FATTR4_WORD2_MDSTHRESHOLD |
> > +			FATTR4_WORD2_SECURITY_LABEL))
> > +		return -EINVAL;
> > +
> > +	server =3D container_of(kobj, struct nfs_server, kobj);
> > +
> > +	if (attrs[0])
> > +		server->readdir_attrs[0] =3D attrs[0];
> > +	if (attrs[1])
> > +		server->readdir_attrs[1] =3D attrs[1];
> > +	if (attrs[2])
> > +		server->readdir_attrs[2] =3D attrs[2];
> > +
> > +	return count;
> > +}
> > +
> >  static struct kobj_attribute nfs_sysfs_attr_shutdown =3D __ATTR_RW(shu=
tdown);
> > +static struct kobj_attribute nfs_sysfs_attr_v4_readdir_attrs =3D __ATT=
R_RW(v4_readdir_attrs);
> > =20
> >  #define RPC_CLIENT_NAME_SIZE 64
> > =20
> > @@ -325,6 +400,12 @@ void nfs_sysfs_add_server(struct nfs_server *serve=
r)
> >  	if (ret < 0)
> >  		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
> >  			server->s_sysfs_id, ret);
> > +
> > +	ret =3D sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_v4_readdi=
r_attrs.attr,
> > +				nfs_netns_server_namespace(&server->kobj));
> > +	if (ret < 0)
> > +		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
> > +			server->s_sysfs_id, ret);
> >  }
> >  EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
> > =20
> > diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> > index cd628c4b011e..db87261b7cd7 100644
> > --- a/include/linux/nfs_fs_sb.h
> > +++ b/include/linux/nfs_fs_sb.h
> > @@ -219,6 +219,7 @@ struct nfs_server {
> >  						   of change attribute, size, ctime
> >  						   and mtime attributes supported by
> >  						   the server */
> > +	u32			readdir_attrs[3]; /* V4 tuneable default readdir attrs */
> >  	u32			acl_bitmask;	/* V4 bitmask representing the ACEs
> >  						   that are supported on this
> >  						   filesystem */
> > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > index 12bbb5c63664..e05d861b1788 100644
> > --- a/include/linux/nfs_xdr.h
> > +++ b/include/linux/nfs_xdr.h
> > @@ -1142,6 +1142,7 @@ struct nfs4_readdir_arg {
> >  	struct page **			pages;	/* zero-copy data */
> >  	unsigned int			pgbase;	/* zero-copy data */
> >  	const u32 *			bitmask;
> > +	const struct nfs_server		*server;
> >  	bool				plus;
> >  };
> > =20
> > --=20
> > 2.41.0
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
