Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0D1397525
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jun 2021 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhFAOMw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 10:12:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59150 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbhFAOMw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 10:12:52 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A7EF1FD2A;
        Tue,  1 Jun 2021 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622556670;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d/8LtOYLHOjmpyu57r8dcTE5DKcRdePo0yQQE+IKBkM=;
        b=Jj3ZT4B2x21wBbrUCO9UYCjOSqtNL8WdXf0LJiSPpN/NZ1vEeg2PPZGO4nuKT1ME5eqKNg
        hmbdiimFnjR9RyGaGw8ja5bWMp2RFBmDZBBZQ8N32mO4rCZ4Lm+geMVCBvu8x8dX27/0mx
        XD7RGw0hetN3T1270hqhs6M4jqfCdMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622556670;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d/8LtOYLHOjmpyu57r8dcTE5DKcRdePo0yQQE+IKBkM=;
        b=pY1lju/1c1I+hsO1kBqBtp2Qoe6ReHxtm0wF+/Nvhx8a1Vfyh62TSor8wNb7LNvlhAlAgg
        X/5kLmSh3QHVkMAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 243A8118DD;
        Tue,  1 Jun 2021 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622556670;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d/8LtOYLHOjmpyu57r8dcTE5DKcRdePo0yQQE+IKBkM=;
        b=Jj3ZT4B2x21wBbrUCO9UYCjOSqtNL8WdXf0LJiSPpN/NZ1vEeg2PPZGO4nuKT1ME5eqKNg
        hmbdiimFnjR9RyGaGw8ja5bWMp2RFBmDZBBZQ8N32mO4rCZ4Lm+geMVCBvu8x8dX27/0mx
        XD7RGw0hetN3T1270hqhs6M4jqfCdMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622556670;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d/8LtOYLHOjmpyu57r8dcTE5DKcRdePo0yQQE+IKBkM=;
        b=pY1lju/1c1I+hsO1kBqBtp2Qoe6ReHxtm0wF+/Nvhx8a1Vfyh62TSor8wNb7LNvlhAlAgg
        X/5kLmSh3QHVkMAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id wreOB/4/tmCOIAAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Tue, 01 Jun 2021 14:11:10 +0000
Date:   Tue, 1 Jun 2021 16:11:08 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [LTP PATCH v2 1/3] nfs_lib.sh: Detect unsupported protocol
Message-ID: <YLY//HUlsrK2eBb2@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210526172503.18621-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526172503.18621-1-pvorel@suse.cz>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Alexey,

could you please have look on v2 before I merge it?

Kind regards,
Petr

> Caused by disabled CONFIG_NFSD_V[34] in kernel config.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> new in v2

>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 6 ++++++
>  1 file changed, 6 insertions(+)

> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index 3fad8778a..b80ee0e18 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -94,9 +94,15 @@ nfs_mount()

>  	if [ $? -ne 0 ]; then
>  		cat mount.log
> +
>  		if [ "$type" = "udp" -o "$type" = "udp6" ] && tst_kvcmp -ge 5.6; then
>  			tst_brk TCONF "UDP support disabled with the kernel config NFS_DISABLE_UDP_SUPPORT?"
>  		fi
> +
> +		if grep -i "Protocol not supported" mount.log; then
> +			tst_brk TCONF "Protocol not supported"
> +		fi
> +
>  		tst_brk TBROK "mount command failed"
>  	fi
>  }
