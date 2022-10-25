Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3197E60C1AD
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 04:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJYC07 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 22:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiJYC04 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 22:26:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDA4334
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 19:26:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9548C1F388;
        Tue, 25 Oct 2022 02:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666664814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhYUBZgsiKZvonG/IykHEUZdnIFFg+4uyOtg93z9sjA=;
        b=vpKXgyDpQ0AFJMG26DE4X4sfyKhm0uw5sKsvgnwUJIdsAh85AaqWtZjNf4i4wMVO8ZAtnt
        FFWED7XeZZrcBFKh5jI7fM+PGppOSkY+VJm2gxZmreGeqKAeHQMNZjFMNC0o+TOJSs2gdi
        WgnReCuFDjVt2V6LXqqkUO9OLV278Zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666664814;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhYUBZgsiKZvonG/IykHEUZdnIFFg+4uyOtg93z9sjA=;
        b=ZbPLmoejkxDlv+LxbdgkSkRYmi87KVjeuA74L21D6Scj8yN++046efDylLEQ/0HAs3FIK9
        9m9PbhP60XyW2DCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B243D134CA;
        Tue, 25 Oct 2022 02:26:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E7OBGm1JV2MrfwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 25 Oct 2022 02:26:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 12/13] NFSD: Allocate an rhashtable for nfs4_file objects
In-reply-to: <C1C6B958-A138-42A0-B39E-D8CCEB3D79F7@oracle.com>
References: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>,
 <166665108857.50761.11874625810370383309.stgit@klimt.1015granger.net>,
 <166665465494.12462.9078997979555811271@noble.neil.brown.name>,
 <C1C6B958-A138-42A0-B39E-D8CCEB3D79F7@oracle.com>
Date:   Tue, 25 Oct 2022 13:26:50 +1100
Message-id: <166666481063.12462.2536448442617799527@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Oct 2022, Chuck Lever III wrote:
>=20
> > On Oct 24, 2022, at 7:37 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Tue, 25 Oct 2022, Chuck Lever wrote:
> >> Introduce the infrastructure for managing nfs4_file objects in an
> >> rhashtable. This infrastructure will be used by the next patch.
> >>=20
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> fs/nfsd/nfs4state.c |   23 ++++++++++++++++++++++-
> >> fs/nfsd/state.h     |    1 +
> >> 2 files changed, 23 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >> index abed795bb4ec..681cb2daa843 100644
> >> --- a/fs/nfsd/nfs4state.c
> >> +++ b/fs/nfsd/nfs4state.c
> >> @@ -44,7 +44,9 @@
> >> #include <linux/jhash.h>
> >> #include <linux/string_helpers.h>
> >> #include <linux/fsnotify.h>
> >> +#include <linux/rhashtable.h>
> >> #include <linux/nfs_ssc.h>
> >> +
> >> #include "xdr4.h"
> >> #include "xdr4cb.h"
> >> #include "vfs.h"
> >> @@ -721,6 +723,18 @@ static unsigned int file_hashval(const struct svc_f=
h *fh)
> >>=20
> >> static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
> >>=20
> >> +static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp;
> >> +
> >> +static const struct rhashtable_params nfs4_file_rhash_params =3D {
> >> +	.key_len		=3D sizeof_field(struct nfs4_file, fi_inode),
> >> +	.key_offset		=3D offsetof(struct nfs4_file, fi_inode),
> >> +	.head_offset		=3D offsetof(struct nfs4_file, fi_rlist),
> >> +
> >> +	/* Reduce resizing churn on light workloads */
> >> +	.min_size		=3D 256,		/* buckets */
> >=20
> > Every time I see this line a groan a little bit.  Probably I'm groaning
> > at rhashtable - you shouldn't need to have to worry about these sorts of
> > details when using an API...  but I agree that avoiding churn is likely
> > a good idea.
> >=20
> > Where did 256 come from?
>=20
> Here's the current file_hashtbl definition:
>=20
>  710 /* hash table for nfs4_file */
>  711 #define FILE_HASH_BITS                   8
>  712 #define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
>  713=20
>  714 static unsigned int file_hashval(const struct svc_fh *fh)
>  715 {
>  716         struct inode *inode =3D d_inode(fh->fh_dentry);
>  717=20
>  718         /* XXX: why not (here & in file cache) use inode? */
>  719         return (unsigned int)hash_long(inode->i_ino, FILE_HASH_BITS);
>  720 }
>  721=20
>  722 static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
>=20
> 256 buckets is the size of the existing file_hashtbl.
>=20
>=20
> >  Would PAGE_SIZE/sizeof(void*) make more sense
> > (though that is 512).
>=20
> For rhashtable, you need to account for sizeof(struct bucket_table),
> if I'm reading nested_bucket_table_alloc() correctly.
>=20
> 256 is 2048 bytes + sizeof(struct bucket_table). 512 buckets would
> push us over a page.

Ah yes, of course.  The does suggest that 256 is a better choice.

>=20
>=20
> > How much churn is too much?  The default is 4 and we grow at >75% and
> > shrink at <30%, so at 4 entries the table would resize to 8, and that 2
> > entries it  would shrink back.  That does sound like churn.
> > If we choose 8, then at 7 we grow to 16 and at 4 we go back to 8.
> > If we choose 16, then at 13 we grow to 32 and at 9 we go back to 16.
> >=20
> > If we choose 64, then at 49 we grow to 128 and at 39 we go back to 64.
> >=20
> > The margin seems rather narrow.  May 30% is too high - 15% might be a
> > lot better.  But changing that might be difficult.
>=20
> I could go a little smaller. Basically table resizing is OK when we're
> talking about a lot of buckets because that overhead is very likely to
> be amortized over many insertions and removals.
>=20
>=20
> > So I don't have a good recommendation, but I don't like magic numbers.
> > Maybe PAGE_SIZE/sizeof(void*) ??
>=20
> The only thing I can think of would be
>=20
> #define NFS4_FILE_HASH_SIZE  (some number or constant calculation)
>=20
> which to me isn't much better than
>=20
> 	.size	=3D 256,	/* buckets */
>=20
> I will ponder some more.
>=20

Maybe just a comment saying that this number will allow the
struct bucket_table to fit in one 4K page.

Thanks,
NeilBrown


>=20
> > But either way
> >  Reviewed-by: NeilBrown <neilb@suse.de>
> >=20
> > Thanks,
> > NeilBrown
> >=20
> >=20
> >> +	.automatic_shrinking	=3D true,
> >> +};
> >> +
> >> /*
> >>  * Check if courtesy clients have conflicting access and resolve it if p=
ossible
> >>  *
> >> @@ -8023,10 +8037,16 @@ nfs4_state_start(void)
> >> {
> >> 	int ret;
> >>=20
> >> -	ret =3D nfsd4_create_callback_queue();
> >> +	ret =3D rhltable_init(&nfs4_file_rhltable, &nfs4_file_rhash_params);
> >> 	if (ret)
> >> 		return ret;
> >>=20
> >> +	ret =3D nfsd4_create_callback_queue();
> >> +	if (ret) {
> >> +		rhltable_destroy(&nfs4_file_rhltable);
> >> +		return ret;
> >> +	}
> >> +
> >> 	set_max_delegations();
> >> 	return 0;
> >> }
> >> @@ -8057,6 +8077,7 @@ nfs4_state_shutdown_net(struct net *net)
> >>=20
> >> 	nfsd4_client_tracking_exit(net);
> >> 	nfs4_state_destroy_net(net);
> >> +	rhltable_destroy(&nfs4_file_rhltable);
> >> #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> >> 	nfsd4_ssc_shutdown_umount(nn);
> >> #endif
> >> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> >> index e2daef3cc003..190fc7e418a4 100644
> >> --- a/fs/nfsd/state.h
> >> +++ b/fs/nfsd/state.h
> >> @@ -546,6 +546,7 @@ struct nfs4_file {
> >> 	bool			fi_aliased;
> >> 	spinlock_t		fi_lock;
> >> 	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
> >> +	struct rhlist_head	fi_rlist;
> >> 	struct list_head        fi_stateids;
> >> 	union {
> >> 		struct list_head	fi_delegations;
> >>=20
> >>=20
> >>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
