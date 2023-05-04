Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBAA6F6D63
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 15:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjEDN5Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 09:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjEDN5P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 09:57:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943837EC4
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 06:57:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4991B223B7;
        Thu,  4 May 2023 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683208633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yErvE/CQwOKfoZxtMaL3WaZmx5CmbYeLnDjk1/0iieY=;
        b=GQlbHpOvT6jfcvutjjEtcxveT0343g2wKji2LOA1q9Ro2Yjy+JEBD+JEBTtY55dGVIHpHb
        kkD5yk8m+9WaECk6D22d0omo7ZaKNJuynftCGCGGFssF5MomJexWCGMkIVZ7ZmCfyn5ZYJ
        Zn15E44qvBr5PN6W3GKOaLTqhXNPF2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683208633;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yErvE/CQwOKfoZxtMaL3WaZmx5CmbYeLnDjk1/0iieY=;
        b=n95AYjdMrNMoqtzuoQ75ehRY8kt/RKepUDvTkP0FJIPhCRyBEle9DiiiKreXPChv0u0Hgm
        i4QCY2M86YMvsQDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3529113444;
        Thu,  4 May 2023 13:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tfmBC7m5U2SHbwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 04 May 2023 13:57:13 +0000
Date:   Thu, 4 May 2023 15:58:15 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, NeilBrown <neilb@suse.de>,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v5 1/5] nfs_lib.sh: Cleanup local and remote directories
 setup
Message-ID: <ZFO597l50v9PEQPP@yuki>
References: <20230504131414.3826283-1-pvorel@suse.cz>
 <20230504131414.3826283-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504131414.3826283-2-pvorel@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 52 ++++++++++++++-------
>  1 file changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index af7d46a21..1b5604ab5 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) Linux Test Project, 2016-2022
> +# Copyright (c) Linux Test Project, 2016-2023
>  # Copyright (c) 2015-2018 Oracle and/or its affiliates. All Rights Reserved.
>  # Copyright (c) International Business Machines  Corp., 2001
>  
> @@ -53,6 +53,24 @@ get_socket_type()
>  	done
>  }
>  
> +# directory mounted by NFS client
> +get_local_dir()
> +{
> +	local v="$1"
> +	local n="$2"
> +
> +	echo "$TST_TMPDIR/$v/$n"
> +}
> +
> +# directory on NFS server
> +get_remote_dir()
> +{
> +	local v="$1"
> +	local n="$2"
> +
> +	echo "$TST_TMPDIR/$v/$n"
> +}

It's a bit puzzling why we have two identical functions with a different
name...

-- 
Cyril Hrubis
chrubis@suse.cz
