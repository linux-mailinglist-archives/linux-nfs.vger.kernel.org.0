Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0228E6F6D68
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjEDOAt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 10:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjEDOAs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 10:00:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664AA1982
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 07:00:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01D4622392;
        Thu,  4 May 2023 14:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683208845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cSg8xEc+OUHSL0vqKyRefktIT42eQuoCl5F13vetUbY=;
        b=xvl5tOVN9zHrRZgPNmu8Kp9gIAzJCzid0+rIBzG+ryci57CGLsiZ83bDjaiLt8ZJZxsY3G
        W2F/SAPgb5gh+0TvAkimkvualsKgLUTxqKoyNJtG3kBsWTLwMXNKsSLGcP1iQg9YfBZw/+
        60NbxbrTfWJglgkHsVHcLuUJo5hAxWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683208845;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cSg8xEc+OUHSL0vqKyRefktIT42eQuoCl5F13vetUbY=;
        b=F5i6VI6x7uYKBFEsKc7pWz3YMPs7wQwAexNTR+6fCvfO/wJYyjKCl2HLKaj0oSSQd10+f0
        xTqNpJGUcgUZB2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0B7613444;
        Thu,  4 May 2023 14:00:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O8TCNYy6U2TIcQAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 04 May 2023 14:00:44 +0000
Date:   Thu, 4 May 2023 16:01:47 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, NeilBrown <neilb@suse.de>,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v5 5/5] nfs: Run on btrfs, ext4, xfs
Message-ID: <ZFO6ywouPkmNKtkr@yuki>
References: <20230504131414.3826283-1-pvorel@suse.cz>
 <20230504131414.3826283-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504131414.3826283-6-pvorel@suse.cz>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!
>  nfs_get_remote_path()
> @@ -210,6 +213,7 @@ nfs_cleanup()
>  		grep -q "$local_dir" /proc/mounts && umount $local_dir
>  		n=$(( n + 1 ))
>  	done
> +	sleep 2
>  
>  	n=0
>  	for i in $VERSION; do
> @@ -219,12 +223,15 @@ nfs_cleanup()
>  		if tst_net_use_netns; then
>  			if test -d $remote_dir; then
>  				exportfs -u *:$remote_dir
> +				sleep 1
>  				rm -rf $remote_dir
>  			fi
>  		else
>  			tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
> +			sleep 1
>  			tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
>  		fi
> +
>  		n=$(( n + 1 ))
>  	done

Generally I'm not happy about the sleeps in the code, the main problem
is that the test still may fail in a case that something was slower than
usuall and we decided to proceed after we slept for a pre-defined
interval. Ideally these should be replaced with a active waiting, i.e.
loop that checks some condition 10 times in a second or so. Hoewever I'm
okay with getting this in so that we manage to have these tests in
before the release and fixing it later on.

-- 
Cyril Hrubis
chrubis@suse.cz
