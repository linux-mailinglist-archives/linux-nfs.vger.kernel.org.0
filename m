Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E2360BE2D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 01:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiJXXHY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 19:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiJXXHD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 19:07:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1DC2D9402
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 14:28:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC62321E76;
        Mon, 24 Oct 2022 21:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666646837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T8DBOSqA44SLE6JCNf23NVA4YL+7DSE/8vdJQLtbMg4=;
        b=l/l9iYdBkTgRvfGeQ788nMZZ21QHn3AfKyo38nBSCqaWI/61jv7GZG0qcvYO/mSvp3Qjk7
        nyMpVbemBZXYQkuIFGIIKgHYzG0ppyE7Y8tvgU6R/V4nomuJIvU7WwsKbXyvAZoHBl6RFz
        Cloukk+APVxvDjobUqMv0Lcufg7hys0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666646837;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T8DBOSqA44SLE6JCNf23NVA4YL+7DSE/8vdJQLtbMg4=;
        b=THaDI9kpzedeeVkRAYaLvxo6x2F6AJVkHWxWOSiKaEV1mV+RSqaUR7xev2DBVGyxQbGd32
        mzSUbG5PaTEoiuAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB1A113A79;
        Mon, 24 Oct 2022 21:27:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5qxrHzQDV2MJcAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Oct 2022 21:27:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file
 garbage collection
In-reply-to: <030F4BAB-6042-44C8-AC20-B1503D8A8004@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>,
 <166612311828.1291.6808456808715954510.stgit@manet.1015granger.net>,
 <166657883468.12462.7206160925496863213@noble.neil.brown.name>,
 <030F4BAB-6042-44C8-AC20-B1503D8A8004@oracle.com>
Date:   Tue, 25 Oct 2022 08:27:02 +1100
Message-id: <166664682244.12462.3621556759521787062@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Oct 2022, Chuck Lever III wrote:
>=20
> > On Oct 23, 2022, at 10:33 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Wed, 19 Oct 2022, Chuck Lever wrote:
> >> NFSv4 operations manage the lifetime of nfsd_file items they use by
> >> means of NFSv4 OPEN and CLOSE. Hence there's no need for them to be
> >> garbage collected.
> >>=20
> >> Introduce a mechanism to enable garbage collection for nfsd_file
> >> items used only by NFSv2/3 callers.
> >>=20
> >> Note that the change in nfsd_file_put() ensures that both CLOSE and
> >> DELEGRETURN will actually close out and free an nfsd_file on last
> >> reference of a non-garbage-collected file.
> >>=20
> >> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394
> >> Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> >> Tested-by: Jeff Layton <jlayton@kernel.org>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> fs/nfsd/filecache.c |   61 +++++++++++++++++++++++++++++++++++++++++++++=
------
> >> fs/nfsd/filecache.h |    3 +++
> >> fs/nfsd/nfs3proc.c  |    4 ++-
> >> fs/nfsd/trace.h     |    3 ++-
> >> fs/nfsd/vfs.c       |    4 ++-
> >> 5 files changed, 63 insertions(+), 12 deletions(-)
> >>=20
> >> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> >> index b7aa523c2010..87fce5c95726 100644
> >> --- a/fs/nfsd/filecache.c
> >> +++ b/fs/nfsd/filecache.c
> >> @@ -63,6 +63,7 @@ struct nfsd_file_lookup_key {
> >> 	struct net			*net;
> >> 	const struct cred		*cred;
> >> 	unsigned char			need;
> >> +	unsigned char			gc:1;
> >> 	enum nfsd_file_lookup_type	type;
> >> };
> >>=20
> >> @@ -162,6 +163,8 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_com=
pare_arg *arg,
> >> 			return 1;
> >> 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
> >> 			return 1;
> >> +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
> >> +			return 1;
> >> 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
> >> 			return 1;
> >> 		break;
> >> @@ -297,6 +300,8 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, un=
signed int may)
> >> 		nf->nf_flags =3D 0;
> >> 		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
> >> 		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
> >> +		if (key->gc)
> >> +			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
> >> 		nf->nf_inode =3D key->inode;
> >> 		/* nf_ref is pre-incremented for hash table */
> >> 		refcount_set(&nf->nf_ref, 2);
> >> @@ -428,16 +433,27 @@ nfsd_file_put_noref(struct nfsd_file *nf)
> >> 	}
> >> }
> >>=20
> >> +static void
> >> +nfsd_file_unhash_and_put(struct nfsd_file *nf)
> >> +{
> >> +	if (nfsd_file_unhash(nf))
> >> +		nfsd_file_put_noref(nf);
> >> +}
> >> +
> >> void
> >> nfsd_file_put(struct nfsd_file *nf)
> >> {
> >> 	might_sleep();
> >>=20
> >> -	nfsd_file_lru_add(nf);
> >> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)
> >=20
> > Clearly this is a style choice on which sensible people might disagree,
> > but I much prefer to leave out the "=3D=3D 1" That is what most callers in
> > fs/nfsd/ do - only exceptions are here in filecache.c.
> > Even "!=3D 0" would be better than "=3D=3D 1".
> > I think test_bit() is declared as a bool, but it is hard to be certain.
>=20
> The definitions of test_bit() I've seen return "int" which is why
> I wrote it this way.

Just for completeness, I found

#define test_bit(nr, addr)              bitop(_test_bit, nr, addr)

in linux/bitops.h.

bitop() is defined just above and (I think) in the case where nr is
constant and addr is not NULL, this becomes a call to const_test_bit().
In include/asm-generic/bitops/generic-non-atomic.h I found

static __always_inline bool
const_test_bit(unsigned long nr, const volatile unsigned long *addr)

In the non-constant case it calls _test_bit() which is

static __always_inline bool
_test_bit(unsigned long nr, const volatile unsigned long *addr)

But as an int that is known to be 0 or 1 is type-compatible with a bool,
ht shouldn't really matter from a type perspective, only for a human
readability perspective.

Thanks,
NeilBrown
