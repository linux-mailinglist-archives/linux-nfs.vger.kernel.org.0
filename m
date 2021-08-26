Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDA13F9089
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 01:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhHZWLe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 18:11:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45864 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhHZWLd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 18:11:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 93F2C22301;
        Thu, 26 Aug 2021 22:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630015844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqVa9ALCvKXBfMGhtANCDxUsSXrBziImkZXv54gpas0=;
        b=diaMaXYhOAc8MtObt/0nqDllTnvKQxGOXqfyh182Orq1cVeZRw38+D1BmNnGM3YLKe2vCy
        iDVICe1i4wuZlsU3AHlO1t7NwEnCNM0Bmrze8e07RrCAmdPR8oYMna99Ha/s3YJtHWeaC5
        5990SfUe5uPi5qME4fy9fD8r+o2ygGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630015844;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqVa9ALCvKXBfMGhtANCDxUsSXrBziImkZXv54gpas0=;
        b=9QCSITNIIxszhvgh6FxztC65eHww+YB6UmSw3tRnQ3vdPFFBttZ1HtR/9wdkCj2SP150W3
        tPFw+ynrembqW3Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 413A513CD7;
        Thu, 26 Aug 2021 22:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HBV5AGMRKGFUcwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 26 Aug 2021 22:10:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J.  Bruce Fields" <bfields@fieldses.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <20210826201916.GB10730@fieldses.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>,
 <20210826201916.GB10730@fieldses.org>
Date:   Fri, 27 Aug 2021 08:10:38 +1000
Message-id: <163001583884.7591.13328510041463261313@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 27 Aug 2021, J.  Bruce Fields wrote:
> On Thu, Aug 26, 2021 at 04:03:04PM +1000, NeilBrown wrote:
> >=20
> > [[ Hi Bruce and Chuck,
> >    I've rebased this patch on the earlier patch I sent which allows
> >    me to use the name "fh_flags".  I've also added a missing #include.
> >    I've added the 'Acked-by' which Joesf provided earlier for the
> >    btrfs-part.  I don't have an 'ack' for the  stat.h part, but no-one
> >    has complained wither.
> >    I think it is as ready as it can be, and am keen to know what you
> >    think.
> >    I'm not *very* keen on testing s_magic in nfsd code (though we
> >    already have a couple of such tests in nfs3proc.c), but it does have
> >    the advantage of ensuring that no other filesystem can use this
> >    functionality without landing a patch in fs/nfsd/.
> > =20
> >    Thanks for any review that you can provide,
> >    NeilBrown
> > ]]
>=20
> This seems hairy, but *somebody* has hated every single solution
> proposed, so, argh, I don't know, maybe it's best.

People don't like change I guess :-)
I think we need the fh_flags stuff for almost any fix, else existing
mounts could break when the server is upgraded.  This could be needed
for any filesystem that has flawed NFS export support and needs to
seemlessly repair it.
We *might* be able to avoid that is I xored the uniquifier with the fsid
instead of the fileid (I'd have to test), but that has other problems
like polluting the client's mount table and mounted-on-fileid being hard
to manage - especially for NFSv3.
The rest is the minimum that actually achieves something.

I could still agonise of whether the swap-bits instead of swap-bytes,
and whether to leave a few high bits free for e.g. overlay.  But I won't
lose sleep over it.

>=20
> There was a ton of "but why can't we just..." in previous threads, could
> we include URLs for those and/or the lwn articles?  E.g.:
>=20
> 	https://lore.kernel.org/linux-nfs/162742539595.32498.13687924366155737575.=
stgit@noble.brown/#b
> 	https://lwn.net/Articles/866709/

I've add Link: lines.  The are a couple of other threads that maybe I
could like.

> > Acked-by: Josef Bacik <josef@toxicpanda.com> (for BTFS change)
>=20
> s/BTFS/BTRFS/.

Ack.
> >  	/* fileid */
> > +	if (!resp->dir_have_uniquifier) {
> > +		struct kstat stat;
> > +		if (fh_getattr(&resp->fh, &stat) =3D=3D nfs_ok)
> > +			resp->dir_ino_uniquifier =3D
> > +				nfsd_ino_uniquifier(&resp->fh, &stat);
> > +		else
> > +			resp->dir_ino_uniquifier =3D 0;
> > +		resp->dir_have_uniquifier =3D true;
>=20
> This took me a minute.  So we're assuming the uniquifier stays the same
> across a directory and its children (because you can't hard link across
> subvolumes), and this code is just caching the uniquifier for use across
> the directory--is that right?

Yep.  I think I originally planned to set dir_ino_uniquifier closer to
"open", but there wasn't a convenient place to do that, so I did it here
and added the "dir_have_uniquifier" flag.

The comment in stat.h affirms that the uniquifier for a directory can be
used for inodes reported by readdir.  Note that the inode numbers might
be different to those returned by a lookup of the name - just like with
mountpoints.=20


>=20
> > +	}
> > +	if (resp->dir_ino_uniquifier !=3D ino)
> > +		ino ^=3D resp->dir_ino_uniquifier;
>=20
> I guess this check (here and in nfsd_uniquify_ino) is just to prevent
> returning inode number zero?

Yep.  The set of valid inode numbers is 1..MAX and that set isn't closed
under xor.  It is closed (and bijective) under "xor if not equals".

I've added:
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 5e2d5c352ecd..fed56edf229f 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1162,6 +1162,7 @@ svcxdr_encode_entry3_common(struct nfsd3_readdirres *re=
sp, const char *name,
 			resp->dir_ino_uniquifier =3D 0;
 		resp->dir_have_uniquifier =3D true;
 	}
+	/* See comment in nfsd_uniquify_ino() */
 	if (resp->dir_ino_uniquifier !=3D ino)
 		ino ^=3D resp->dir_ino_uniquifier;
 	if (xdr_stream_encode_u64(xdr, ino) < 0)
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index bbc7ddd34143..6dd8c7325902 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -155,6 +155,9 @@ static inline u64 nfsd_uniquify_ino(const struct svc_fh *=
fhp,
 				    const struct kstat *stat)
 {
 	u64 u =3D nfsd_ino_uniquifier(fhp, stat);
+	/* Neither stat->ino or return value can be zero, so
+	 * if ->ino is u, return u.
+	 */
 	if (u !=3D stat->ino)
 		return stat->ino ^ u;
 	return stat->ino;

Thanks,
NeilBrown
