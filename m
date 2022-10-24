Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D7860BF02
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 01:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiJXXxQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 19:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJXXw5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 19:52:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0302FFA48
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 15:10:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AACFC1F9E3;
        Mon, 24 Oct 2022 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666649407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s91xDY46/UmvxL/BbiKwtpVduK2DFwtnpCyK7Eobe54=;
        b=E6de1eoEzFWCE4js3lU7EPO8jQeEJlAX3C9dqLR5sRz6OCvSQr7Ep9lbQlKQ5Ynk2DMviQ
        rO3IVfLulh4BIzfVU3im6fNasOg1Rjl486nS4qLGQxZlR324t2gKPev2UjePVt4sgfGBe7
        MbMDhIzX05r0oDp1D69yW+or+JXF+q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666649407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s91xDY46/UmvxL/BbiKwtpVduK2DFwtnpCyK7Eobe54=;
        b=Xlf6I0b72opMbP09Be9ebVgMdzEmSKhhxyMfVknH9aaCeuIDBZrwPehFxMid7/ZPsJ19sn
        Z4huSRUFB1bnG9Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 723A213A79;
        Mon, 24 Oct 2022 22:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kN0UCj4NV2O9AwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Oct 2022 22:10:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "David Disseldorp" <ddiss@suse.de>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] exportfs: use pr_debug for unreachable debug statements
In-reply-to: <000A2614-4C72-444A-A1D3-7B259D99C70A@oracle.com>
References: <20221021122414.20555-1-ddiss@suse.de>,
 <166656308707.12462.9861114416829680469@noble.neil.brown.name>,
 <000A2614-4C72-444A-A1D3-7B259D99C70A@oracle.com>
Date:   Tue, 25 Oct 2022 09:09:56 +1100
Message-id: <166664939677.12462.18426253960350585268@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Oct 2022, Chuck Lever III wrote:
>=20
> > On Oct 23, 2022, at 6:11 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Fri, 21 Oct 2022, David Disseldorp wrote:
> >> expfs.c has a bunch of dprintk statements which are unusable due to:
> >> #define dprintk(fmt, args...) do{}while(0)
> >> Use pr_debug so that they can be enabled dynamically.
> >> Also make some minor changes to the debug statements to fix some
> >> incorrect types, and remove __func__ which can be handled by dynamic
> >> debug separately.
> >>=20
> >> Signed-off-by: David Disseldorp <ddiss@suse.de>
> >=20
> > Reviewed-by: NeilBrown <neilb@suse.de>
> >=20
> > Thanks,
> > NeilBrown
>=20
> I don't think we're the maintainers of expfs.c ?
>=20
> $ scripts/get_maintainer.pl fs/exportfs/expfs.c
> Christian Brauner <brauner@kernel.org> (commit_signer:2/2=3D100%,authored:1=
/2=3D50%,added_lines:3/6=3D50%,removed_lines:2/6=3D33%)
> Al Viro <viro@zeniv.linux.org.uk> (commit_signer:1/2=3D50%,authored:1/2=3D5=
0%,added_lines:3/6=3D50%,removed_lines:4/6=3D67%)
> Miklos Szeredi <mszeredi@redhat.com> (commit_signer:1/2=3D50%)
> Amir Goldstein <amir73il@gmail.com> (commit_signer:1/2=3D50%)
> linux-kernel@vger.kernel.org (open list)
>=20
> But maybe MAINTAINERS needs to be fixed. There's no entry
> there for fs/exportfs.

Looking at recent commits, patches come in through multiple different
trees.
nfsd certainly has an interest in expfs.c.  The only other user is
name_to_handle/open_by_handle API.
I see it as primarily nfsd functionality which is useful enough to be
exported directly to user-space.
(It was created by me when I was nfsd maintainer - does that count?)

So I would support the suggestion of updating MAINTAINERS to include
fs/exportfs/ in the NFSD section.

Having said that - given your apparent preference of tracepoints for
tracing in nfsd - I suspect you might ask for a somewhat different patch
:-)


Thanks,
NeilBrown


>=20
>=20
> >> ---
> >> fs/exportfs/expfs.c | 8 ++++----
> >> 1 file changed, 4 insertions(+), 4 deletions(-)
> >>=20
> >> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> >> index c648a493faf23..3204bd33e4e8a 100644
> >> --- a/fs/exportfs/expfs.c
> >> +++ b/fs/exportfs/expfs.c
> >> @@ -18,7 +18,7 @@
> >> #include <linux/sched.h>
> >> #include <linux/cred.h>
> >>=20
> >> -#define dprintk(fmt, args...) do{}while(0)
> >> +#define dprintk(fmt, args...) pr_debug(fmt, ##args)
> >>=20
> >>=20
> >> static int get_name(const struct path *path, char *name, struct dentry *=
child);
> >> @@ -132,8 +132,8 @@ static struct dentry *reconnect_one(struct vfsmount =
*mnt,
> >> 	inode_unlock(dentry->d_inode);
> >>=20
> >> 	if (IS_ERR(parent)) {
> >> -		dprintk("%s: get_parent of %ld failed, err %d\n",
> >> -			__func__, dentry->d_inode->i_ino, PTR_ERR(parent));
> >> +		dprintk("get_parent of %lu failed, err %ld\n",
> >> +			dentry->d_inode->i_ino, PTR_ERR(parent));
> >> 		return parent;
> >> 	}
> >>=20
> >> @@ -147,7 +147,7 @@ static struct dentry *reconnect_one(struct vfsmount =
*mnt,
> >> 	dprintk("%s: found name: %s\n", __func__, nbuf);
> >> 	tmp =3D lookup_one_unlocked(mnt_user_ns(mnt), nbuf, parent, strlen(nbuf=
));
> >> 	if (IS_ERR(tmp)) {
> >> -		dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
> >> +		dprintk("lookup failed: %ld\n", PTR_ERR(tmp));
> >> 		err =3D PTR_ERR(tmp);
> >> 		goto out_err;
> >> 	}
> >> --=20
> >> 2.35.3
> >>=20
> >>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
