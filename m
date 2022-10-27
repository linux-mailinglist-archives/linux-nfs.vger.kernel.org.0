Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FF6610654
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 01:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiJ0XYu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 19:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiJ0XYs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 19:24:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678B3360B1
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 16:24:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AF3861F747;
        Thu, 27 Oct 2022 23:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666913077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5t6SJz0yRdAWEtwRuc1GVv2/pPXnIPWP34FVR3TuLc=;
        b=omsBkxVx7kIzq8NVuJWAyScU/E4Q0/+hsGmqnkm6Io8wxPD/1XGxieT8Mh6GqD42rqUTnT
        iwhqpOW/6gn6nyDTRyfdwKe127FQ7Hd8s+QB2AQZSnWD0dnFvXuj/Lhy6ipxG3jIE9jzVk
        ZL5F+XRQKaCgQgP/0o2BAr53nTSMNhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666913077;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5t6SJz0yRdAWEtwRuc1GVv2/pPXnIPWP34FVR3TuLc=;
        b=Mwag1u+dFy54uGElblTdkKzpD9fIhsxrZO2zwVi/JfZWAlFE0L5zCEOi8rXPTunJL59jU/
        EGp0GkCLKBGz8GCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7220B13357;
        Thu, 27 Oct 2022 23:24:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +kqjCTQTW2PWEQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Oct 2022 23:24:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, jlayton@redhat.com
Subject: Re: [PATCH v6 13/14] NFSD: Allocate an rhashtable for nfs4_file objects
In-reply-to: <166689678047.90991.16096403318324605089.stgit@klimt.1015granger.net>
References: <166689625728.90991.15067635142973595248.stgit@klimt.1015granger.net>,
 <166689678047.90991.16096403318324605089.stgit@klimt.1015granger.net>
Date:   Fri, 28 Oct 2022 10:24:33 +1100
Message-id: <166691307319.13915.11000056177725554613@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 28 Oct 2022, Chuck Lever wrote:
> Introduce the infrastructure for managing nfs4_file objects in an
> rhashtable. This infrastructure will be used by the next patch.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c |   26 +++++++++++++++++++++++++-
>  fs/nfsd/state.h     |    1 +
>  2 files changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a07fbbe289cf..3afb73750d2d 100644
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
> @@ -721,6 +723,21 @@ static unsigned int file_hashval(const struct svc_fh *=
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
> +	/*
> +	 * Start with a single page hash table to reduce resizing churn
> +	 * on light workloads.
> +	 */

Nice :-)

NeilBrown

> +	.min_size		=3D 256,
> +	.automatic_shrinking	=3D true,
> +};
> +
>  /*
>   * Check if courtesy clients have conflicting access and resolve it if pos=
sible
>   *
> @@ -8025,10 +8042,16 @@ nfs4_state_start(void)
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
> @@ -8059,6 +8082,7 @@ nfs4_state_shutdown_net(struct net *net)
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
