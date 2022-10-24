Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334E060C03C
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 02:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiJYAyo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 20:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJYAyR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 20:54:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CD51BA1ED
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 16:37:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5888F21E59;
        Mon, 24 Oct 2022 23:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666654659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KN0ki/2NsOxvcRxLp93JxPYxpoL0JusvlwKW+z8Ya4=;
        b=JDGl1EEYEyLEIpJRWV2TGibQyi4SEYYUYgoyxypKnRf98QwtAimLJ7oqBhNd5tmcLhS6oi
        VDGA1yhtJ/zhOfPx1ep2NmkyAmoXWZWVINjvtt7hIsgGBW2aBZeUsjnYJAv+PtcEM0kSBA
        MHOngWLMfyOfyP/k1NR/Ydqnn38VMkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666654659;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KN0ki/2NsOxvcRxLp93JxPYxpoL0JusvlwKW+z8Ya4=;
        b=8MdvoAez+NYCa0uWbrg96YzwjopreF6vYU+y5KfrNbjdOXWgwBLjPh5jsA6wdoGb2YfJAJ
        nEqdwYDOBHL9GdBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7379C13A79;
        Mon, 24 Oct 2022 23:37:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j4UVC8IhV2P9JgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Oct 2022 23:37:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 12/13] NFSD: Allocate an rhashtable for nfs4_file objects
In-reply-to: <166665108857.50761.11874625810370383309.stgit@klimt.1015granger.net>
References: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>,
 <166665108857.50761.11874625810370383309.stgit@klimt.1015granger.net>
Date:   Tue, 25 Oct 2022 10:37:34 +1100
Message-id: <166665465494.12462.9078997979555811271@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Oct 2022, Chuck Lever wrote:
> Introduce the infrastructure for managing nfs4_file objects in an
> rhashtable. This infrastructure will be used by the next patch.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c |   23 ++++++++++++++++++++++-
>  fs/nfsd/state.h     |    1 +
>  2 files changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index abed795bb4ec..681cb2daa843 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -44,7 +44,9 @@
>  #include <linux/jhash.h>
>  #include <linux/string_helpers.h>
>  #include <linux/fsnotify.h>
> +#include <linux/rhashtable.h>
>  #include <linux/nfs_ssc.h>
> +
>  #include "xdr4.h"
>  #include "xdr4cb.h"
>  #include "vfs.h"
> @@ -721,6 +723,18 @@ static unsigned int file_hashval(const struct svc_fh *=
fh)
> =20
>  static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
> =20
> +static struct rhltable nfs4_file_rhltable ____cacheline_aligned_in_smp;
> +
> +static const struct rhashtable_params nfs4_file_rhash_params =3D {
> +	.key_len		=3D sizeof_field(struct nfs4_file, fi_inode),
> +	.key_offset		=3D offsetof(struct nfs4_file, fi_inode),
> +	.head_offset		=3D offsetof(struct nfs4_file, fi_rlist),
> +
> +	/* Reduce resizing churn on light workloads */
> +	.min_size		=3D 256,		/* buckets */

Every time I see this line a groan a little bit.  Probably I'm groaning
at rhashtable - you shouldn't need to have to worry about these sorts of
details when using an API...  but I agree that avoiding churn is likely
a good idea.

Where did 256 come from?  Would PAGE_SIZE/sizeof(void*) make more sense
(though that is 512).
How much churn is too much?  The default is 4 and we grow at >75% and
shrink at <30%, so at 4 entries the table would resize to 8, and that 2
entries it  would shrink back.  That does sound like churn.
If we choose 8, then at 7 we grow to 16 and at 4 we go back to 8.
If we choose 16, then at 13 we grow to 32 and at 9 we go back to 16.

If we choose 64, then at 49 we grow to 128 and at 39 we go back to 64.

The margin seems rather narrow.  May 30% is too high - 15% might be a
lot better.  But changing that might be difficult.

So I don't have a good recommendation, but I don't like magic numbers.
Maybe PAGE_SIZE/sizeof(void*) ??

But either way
  Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


> +	.automatic_shrinking	=3D true,
> +};
> +
>  /*
>   * Check if courtesy clients have conflicting access and resolve it if pos=
sible
>   *
> @@ -8023,10 +8037,16 @@ nfs4_state_start(void)
>  {
>  	int ret;
> =20
> -	ret =3D nfsd4_create_callback_queue();
> +	ret =3D rhltable_init(&nfs4_file_rhltable, &nfs4_file_rhash_params);
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D nfsd4_create_callback_queue();
> +	if (ret) {
> +		rhltable_destroy(&nfs4_file_rhltable);
> +		return ret;
> +	}
> +
>  	set_max_delegations();
>  	return 0;
>  }
> @@ -8057,6 +8077,7 @@ nfs4_state_shutdown_net(struct net *net)
> =20
>  	nfsd4_client_tracking_exit(net);
>  	nfs4_state_destroy_net(net);
> +	rhltable_destroy(&nfs4_file_rhltable);
>  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
>  	nfsd4_ssc_shutdown_umount(nn);
>  #endif
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e2daef3cc003..190fc7e418a4 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -546,6 +546,7 @@ struct nfs4_file {
>  	bool			fi_aliased;
>  	spinlock_t		fi_lock;
>  	struct hlist_node       fi_hash;	/* hash on fi_fhandle */
> +	struct rhlist_head	fi_rlist;
>  	struct list_head        fi_stateids;
>  	union {
>  		struct list_head	fi_delegations;
>=20
>=20
>=20
