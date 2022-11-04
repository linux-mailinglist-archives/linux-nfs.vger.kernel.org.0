Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAA761A33B
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Nov 2022 22:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiKDVWE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Nov 2022 17:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiKDVWD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Nov 2022 17:22:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACD04E412
        for <linux-nfs@vger.kernel.org>; Fri,  4 Nov 2022 14:22:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D9A9B21872;
        Fri,  4 Nov 2022 21:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667596918;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UhVMltezdX5TTdlMmbZgrh8J0fbd7JPXfeLxhllMy58=;
        b=b57GNW+Muq21KShnZi9n5h2suO5fDyb7zhcO/RB20MXftgzpVkNAzKSIh9ObSkzS/A2Lzr
        RorMU8geLnZnke1/xF5L+/2px7PiZoeWuQDxLHOrzYZFyT5XzjuKiFUfMqYwtzGUTRxrul
        fHm/TBvp7bfnjRHu/eRi62jji/0OVUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667596918;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UhVMltezdX5TTdlMmbZgrh8J0fbd7JPXfeLxhllMy58=;
        b=SnWO2SSd0dHuam/ALwqCEx5mbw8QpASSW/Amsz5IlsiGDSTnX5u9kXPRj1zSdowQXNsZIS
        QVxiZiP9u37w3mAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 954241346F;
        Fri,  4 Nov 2022 21:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lE5IIXaCZWPOAgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 04 Nov 2022 21:21:58 +0000
Date:   Fri, 4 Nov 2022 22:21:56 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        regressions@lists.linux.dev,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>
Subject: Re: [PATCH v2] nfsd: fix net-namespace logic in
 __nfsd_file_cache_purge
Message-ID: <Y2WCdDAGt1OEFzL7@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221031154921.500620-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031154921.500620-1-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

> If the namespace doesn't match the one in "net", then we'll continue,
> but that doesn't cause another rhashtable_walk_next call, so it will
> loop infinitely.

> Fixes: ce502f81ba88 ("NFSD: Convert the filecache to use rhashtable")

Adding this to regression tracker.
https://linux-regtracking.leemhuis.info/tracked-regression/

#regzbot ^introduced ce502f81ba88
#regzbot ignore-activity

Kind regards,
Petr

> Reported-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

> The v1 patch applies cleanly to v6.0, but not to Chuck's for-next
> branch. This one should be suitable there.
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 98c6b5f51bc8..4a8aa7cd8354 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -890,9 +890,8 @@ __nfsd_file_cache_purge(struct net *net)

>  		nf = rhashtable_walk_next(&iter);
>  		while (!IS_ERR_OR_NULL(nf)) {
> -			if (net && nf->nf_net != net)
> -				continue;
> -			nfsd_file_unhash_and_dispose(nf, &dispose);
> +			if (!net || nf->nf_net == net)
> +				nfsd_file_unhash_and_dispose(nf, &dispose);
>  			nf = rhashtable_walk_next(&iter);
>  		}
