Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ACA65F720
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 23:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbjAEW4o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 17:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbjAEW4e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 17:56:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E5F392C2
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 14:56:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0C8176771B;
        Thu,  5 Jan 2023 22:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1672959390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QCN4ijWoohssoRjOSRDt/nX4FoCQl0w6fE1EpxKy7z0=;
        b=1Iu8j49Hf5quSuTujLsxUIqI/6yd69ymYcs3MyxnSa8l63umd4xOnRRkdmEyQAP8bpWRA8
        IX3UrZ8bwfBHGDefpxEnbBt0jgzRjpQDj3/CeoBA1IuxVfZZcD3tS5HgZtwtzrLqXQXQ/W
        IfyqYuT8yfahL+tHNdkxP740eJO87hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1672959390;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QCN4ijWoohssoRjOSRDt/nX4FoCQl0w6fE1EpxKy7z0=;
        b=pQlWQQ+k0B0j0p81/JeaXEnrdOU3PLq/YXfrR+QBYrL3mhnC83YrzFE5mwrz+HKjCkZQOn
        6k3uMiset6Uu7GDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DA3C13338;
        Thu,  5 Jan 2023 22:56:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r99lOZtVt2PNZwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 05 Jan 2023 22:56:27 +0000
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
In-reply-to: <167279837032.13974.12155714770736077636@noble.neil.brown.name>
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>,
 <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>,
 <167279409373.13974.16504090316814568327@noble.neil.brown.name>,
 <210f08ae5f0ba47c289293981f490fca848dd2ed.camel@kernel.org>,
 <167279837032.13974.12155714770736077636@noble.neil.brown.name>
Date:   Fri, 06 Jan 2023 09:56:05 +1100
Message-id: <167295936597.13974.7568769884598065471@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 04 Jan 2023, NeilBrown wrote:
> On Wed, 04 Jan 2023, Trond Myklebust wrote:
> > On Wed, 2023-01-04 at 12:01 +1100, NeilBrown wrote:
> > > On Wed, 04 Jan 2023, Trond Myklebust wrote:
> > > >=20
> > > >=20
> > > > If the server starts to reply NFS4ERR_STALE to GETATTR requests,
> > > > why do
> > > > we care about stateid values? Just mark the inode as stale and drop
> > > > it
> > > > on the floor.
> > >=20
> > > We have a valid state from the server - we really shouldn't just
> > > ignore
> > > it.
> > >=20
> > > Maybe it would be OK to mark the inode stale.=C2=A0 I don't know if
> > > various
> > > retry loops abort properly when the inode is stale.
> >=20
> > Yes, they are all supposed to do that. Otherwise we would end up
> > looping forever in close(), for instance, since the PUTFH, GETATTR and
> > CLOSE can all return NFS4ERR_STALE as well.
>=20
> To mark the inode as STALE we still need to find the inode, and that is
> the key bit missing in the current code.  Once we find the inode, we
> could mark it stale, but maybe some other error resulted in the missing
> GETATTR...
>=20
> It might make sense to put the new code in _nfs4_proc_open() after the
> explicit nfs4_proc_getattr() fails.  We would need to find the inode
> given only the filehandle.  Is there any easy way to do that?
>=20
> Thanks,
> NeilBrown
>=20

I couldn't see a consistent pattern to follow for when to mark an inode
as stale.  Do this, on top of the previous patch, seem reasonable?

Thanks,
NeilBrown



diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b441b1d14a50..04497cb42154 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -489,6 +489,8 @@ static int nfs4_do_handle_exception(struct nfs_server *se=
rver,
 		case -ESTALE:
 			if (inode !=3D NULL && S_ISREG(inode->i_mode))
 				pnfs_destroy_layout(NFS_I(inode));
+			if (inode)
+				nfs_set_inode_stale(inode);
 			break;
 		case -NFS4ERR_DELEG_REVOKED:
 		case -NFS4ERR_ADMIN_REVOKED:
@@ -2713,8 +2715,12 @@ static int _nfs4_proc_open(struct nfs4_opendata *data,
 			return status;
 	}
 	if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
+		struct inode *inode =3D nfs4_get_inode_by_stateid(
+			&data->o_res.stateid,
+			data->owner);
 		nfs4_sequence_free_slot(&o_res->seq_res);
-		nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr, NULL);
+		nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr, inode);
+		iput(inode);
 	}
 	return 0;
 }
@@ -4335,6 +4341,7 @@ int nfs4_proc_getattr(struct nfs_server *server, struct=
 nfs_fh *fhandle,
 {
 	struct nfs4_exception exception =3D {
 		.interruptible =3D true,
+		.inode =3D inode,
 	};
 	int err;
 	do {
