Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9E65FA7A
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 04:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjAFDs4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 22:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjAFDsz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 22:48:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDB16A0F4
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 19:48:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFF7577083;
        Fri,  6 Jan 2023 03:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1672976931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/h5ONn5kfeNXOcPz6IlUqS0OikNDflZib77sRoB5w4=;
        b=htB06lsA02J8z+qBu3UPdbBbT2pVmpc/wEIclYVGJJ/vNyjuD/g9WQfshEPI8c9aHDO639
        jyl0VydRFOZhg/ITUSxQTOLj6+4ISDyl1LamIqVfhyeb8nUkLqPA7pHX+I2Vh1PCC5EKSm
        SARhdrU09zotKj89uddqGC97n4GJEgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1672976931;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/h5ONn5kfeNXOcPz6IlUqS0OikNDflZib77sRoB5w4=;
        b=yLemHUtZcYY1SeZAFqUrtFdDU6T8dO1770ZzbO5gchgg2myv0kI5O6MxfEjX6rDbF/I9Ih
        v7kJjLrVHHBZPTAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 364F8139D2;
        Fri,  6 Jan 2023 03:48:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A82oNyGat2PpXgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 06 Jan 2023 03:48:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@kernel.org>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "Anna Schumaker" <anna@kernel.org>,
        "Olga Kornievskaia" <aglo@umich.edu>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
In-reply-to: <46f047159da42dadaca576e0a87a622539609730.camel@kernel.org>
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>,
 <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>,
 <167279409373.13974.16504090316814568327@noble.neil.brown.name>,
 <210f08ae5f0ba47c289293981f490fca848dd2ed.camel@kernel.org>,
 <167279837032.13974.12155714770736077636@noble.neil.brown.name>,
 <167295936597.13974.7568769884598065471@noble.neil.brown.name>,
 <46f047159da42dadaca576e0a87a622539609730.camel@kernel.org>
Date:   Fri, 06 Jan 2023 14:48:46 +1100
Message-id: <167297692611.13974.5805041718280562542@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 06 Jan 2023, Trond Myklebust wrote:
> On Fri, 2023-01-06 at 09:56 +1100, NeilBrown wrote:
> > On Wed, 04 Jan 2023, NeilBrown wrote:
> > > On Wed, 04 Jan 2023, Trond Myklebust wrote:
> > > > On Wed, 2023-01-04 at 12:01 +1100, NeilBrown wrote:
> > > > > On Wed, 04 Jan 2023, Trond Myklebust wrote:
> > > > > >=20
> > > > > >=20
> > > > > > If the server starts to reply NFS4ERR_STALE to GETATTR
> > > > > > requests,
> > > > > > why do
> > > > > > we care about stateid values? Just mark the inode as stale
> > > > > > and drop
> > > > > > it
> > > > > > on the floor.
> > > > >=20
> > > > > We have a valid state from the server - we really shouldn't
> > > > > just
> > > > > ignore
> > > > > it.
> > > > >=20
> > > > > Maybe it would be OK to mark the inode stale.=C2=A0 I don't know if
> > > > > various
> > > > > retry loops abort properly when the inode is stale.
> > > >=20
> > > > Yes, they are all supposed to do that. Otherwise we would end up
> > > > looping forever in close(), for instance, since the PUTFH,
> > > > GETATTR and
> > > > CLOSE can all return NFS4ERR_STALE as well.
> > >=20
> > > To mark the inode as STALE we still need to find the inode, and
> > > that is
> > > the key bit missing in the current code.=C2=A0 Once we find the inode,
> > > we
> > > could mark it stale, but maybe some other error resulted in the
> > > missing
> > > GETATTR...
> > >=20
> > > It might make sense to put the new code in _nfs4_proc_open() after
> > > the
> > > explicit nfs4_proc_getattr() fails.=C2=A0 We would need to find the
> > > inode
> > > given only the filehandle.=C2=A0 Is there any easy way to do that?
> > >=20
> > > Thanks,
> > > NeilBrown
> > >=20
> >=20
> > I couldn't see a consistent pattern to follow for when to mark an
> > inode
> > as stale.=C2=A0 Do this, on top of the previous patch, seem reasonable?
> >=20
> > Thanks,
> > NeilBrown
> >=20
> >=20
> >=20
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index b441b1d14a50..04497cb42154 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -489,6 +489,8 @@ static int nfs4_do_handle_exception(struct
> > nfs_server *server,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0case -ESTALE:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (i=
node !=3D NULL && S_ISREG(inode->i_mode))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pnfs_destroy_layout(NFS_I(inode)=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (inode)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_set_inode_stale(inode);
>=20
> This is normally dealt with in the generic code inside
> nfs_revalidate_inode(). There should be no need to duplicate it here.
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_DELEG_REVOKED:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0case -NFS4ERR_ADMIN_REVOKED:
> > @@ -2713,8 +2715,12 @@ static int _nfs4_proc_open(struct
> > nfs4_opendata *data,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0retur=
n status;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(o_res->f_attr->vali=
d & NFS_ATTR_FATTR)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0struct inode *inode =3D nfs4_get_inode_by_stateid(
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&data->o_re=
s.stateid,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->owner=
);
>=20
> There shouldn't be a need to go looking for open descriptors here,
> because they will hit ESTALE at some point later anyway.

The problem is that they don't hit ESTALE later.  Unless we update our
stored stateid with the result of the OPEN, we can use the old stateid,
and get the corresponding error.

The only way to avoid the infinite loop is to either mark the inode as
stale, or update the state-id.  For either of those we need to find the
inode.  We don't have fileid so we cannot use iget.  We do have file
handle and state-id.

Maybe you are saying this is a server bug that the client cannot be
expect to cope with at all, and that an infinite loop is a valid client
response to this particular server behaviour.  In that case, I guess no
patch is needed.

NeilBrown


>=20
> If we're going to change anything, I'd rather see us return -EACCES and
> -ESTALE from the decode_access() and decode_getfattr() calls in
> nfs4_xdr_dec_open() (and only those errors from those two calls!) so
> that we can skip the unnecessary getattr call here.
>=20
> In fact, the only case that this extra getattr should be trying to
> address is the one where the server returns NFS4ERR_DELAY to either the
> decode_access() or the decode_getfattr() calls specifically, and where
> we therefore don't want to replay the entire open call.
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0nfs4_sequence_free_slot(&o_res->seq_res);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr,
> > NULL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr,
> > inode);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0iput(inode);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0}
> > @@ -4335,6 +4341,7 @@ int nfs4_proc_getattr(struct nfs_server
> > *server, struct nfs_fh *fhandle,
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nfs4_exception exc=
eption =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.interruptible =3D true,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.inode =3D inode,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int err;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do {
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20
>=20
