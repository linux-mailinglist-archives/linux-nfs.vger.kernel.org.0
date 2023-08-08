Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E899C774D1A
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Aug 2023 23:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjHHVcQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 17:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHHVcP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 17:32:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7713A8
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 14:32:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54DCD222D6;
        Tue,  8 Aug 2023 21:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691530333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6bBQFa8q1z1fppVfsG9OJyVkVRcc4dy3C0x6pgpgwYo=;
        b=mfissbQq0NGUkA8r/11KfhwKqcQxV7NvtYW0QjaVboM5cWDo8dJnw8srp/v6KAqkjKQKc1
        IrskU700GQD3YTqGLDPHZ2RbCuMpoubK7uwQxWHDMnglbxBw0oNp/ZpAuc7lUa8dfdl2XN
        gwyXDHHDqadC02mRxT7F3kUDFlz5Pb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691530333;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6bBQFa8q1z1fppVfsG9OJyVkVRcc4dy3C0x6pgpgwYo=;
        b=QtIRLDlAmi/YiLKa77KroZXT5ZurcgHq1+O8Z0L3Dp2kf0WaMH+vbaUzO/IvekMj2n3WYd
        OeUtEVAXmY21AaCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FA7D13451;
        Tue,  8 Aug 2023 21:32:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vc4WCVu00mRCbgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 08 Aug 2023 21:32:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Lorenzo Bianconi" <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com, jlayton@kernel.org
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
In-reply-to: <ZNJCIRjI64YIY+I0@tissot.1015granger.net>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>,
 <169149440399.32308.1010201101079709026@noble.neil.brown.name>,
 <ZNJCIRjI64YIY+I0@tissot.1015granger.net>
Date:   Wed, 09 Aug 2023 07:32:06 +1000
Message-id: <169153032644.32308.1966584430746700085@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 08 Aug 2023, Chuck Lever wrote:
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

Surely a user would care about whether the script works...

>=20
> This file is intended to be parsable by scripts and they have to
> keep up with the occasional changes in format. Scripts can handle an
> unrecogized version however they like.

I think it is naive to introduce versioning and not describe what it
means.  Scripts need to handle version numbers the way the author of the
version intends. That is how protocols work.

version numbers are great when the request can ask for a version or
version range and the responder can provide any of a number of versions.
This is how NFS versions work.  So embedding the version number in the
file name would be fine - it would allow negotiation.

>=20
> This is what we typically get with a made-up format that isn't .ini
> or JSON or XML. The file format isn't self-documenting. The final
> field on each row is a variable number of tokens, so it will be
> nearly impossible to simply add another field without breaking
> something.

There is an existing pattern in line/field files to terminate a variable
length array with something like "-".  /proc/self/mountinfo does this.

I'm not against yaml though

>=20
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
> > file with space-separated fields like this.  You should probably promise
> > not to remove fields, but to deprecate fields by replacing them with "X"
> > or whatever.
> >=20
> > A tool really needs to be able to extract anything it can understand,
> > and know how to avoid what it doesn't understand.  A version number
> > doesn't help with that.
>=20
> It's how mountstats format changes are managed. We have bumped that
> version number over the years, so there is precedent for it.
>=20

NFS_IOSTATS_VERS has changed once, from 1.0 to 1.1.
This was in 2012 for a patch which says:
  Add the new fields at the end of the mountstats xprt stanza so that
  mountstats outputs the previous correct values and ignores the new
  fields.

so the new format was deliberately backward compatible and the version
change wasn't really needed.

Thanks,
NeilBrown


>=20
> > And if you really wanted to change the format so much that old tools
> > cannot use any of the content, it would likely make most sense to change
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
> > > @@ -1117,6 +1117,9 @@ int nfsd_stats_release(struct inode *inode, struc=
t file *file)
> > >  	return ret;
> > >  }
> > > =20
> > > +/* Increment NFSD_RPC_STATUS_VERSION adding new info to the handler */
> > > +#define NFSD_RPC_STATUS_VERSION		1
> > > +
> > >  static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> > >  {
> > >  	struct inode *inode =3D file_inode(m->file);
> > > @@ -1125,6 +1128,8 @@ static int nfsd_rpc_status_show(struct seq_file *=
m, void *v)
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
> --=20
> Chuck Lever
>=20

