Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2696B3996CF
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 02:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFCAMb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 20:12:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32778 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCAMb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 20:12:31 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6BE531FD30;
        Thu,  3 Jun 2021 00:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622679046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhRRSvZn3mGTQIcHiye01pYLVN0k13spwwILJDOGoQc=;
        b=cd70VPylyKZYi/X+klR5T0FuP2MK7im6ZeEduSxWj+KpC5sjMwtGlhIjlsLEQFxJbpYC1y
        9kHa7+5m/Gl5Q0JhmdwGKNLaiZWfs7eW6/sru6g5+NApaA47/kXgRnL+X3Ur+R5c2C8ZEM
        mXBsqjdtoUTPi+9HpcSW6dD4JR1J5ZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622679046;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhRRSvZn3mGTQIcHiye01pYLVN0k13spwwILJDOGoQc=;
        b=nwnfVo44e8melLkYgSdvYpnJNOoV19Xx7xTc8u9zA7srFbcK6NYRc/eHqYP6GpVGP2MuoF
        ozHircsqKl+ax4Dw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 6DCA0118DD;
        Thu,  3 Jun 2021 00:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622679046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhRRSvZn3mGTQIcHiye01pYLVN0k13spwwILJDOGoQc=;
        b=cd70VPylyKZYi/X+klR5T0FuP2MK7im6ZeEduSxWj+KpC5sjMwtGlhIjlsLEQFxJbpYC1y
        9kHa7+5m/Gl5Q0JhmdwGKNLaiZWfs7eW6/sru6g5+NApaA47/kXgRnL+X3Ur+R5c2C8ZEM
        mXBsqjdtoUTPi+9HpcSW6dD4JR1J5ZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622679046;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhRRSvZn3mGTQIcHiye01pYLVN0k13spwwILJDOGoQc=;
        b=nwnfVo44e8melLkYgSdvYpnJNOoV19Xx7xTc8u9zA7srFbcK6NYRc/eHqYP6GpVGP2MuoF
        ozHircsqKl+ax4Dw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id IGuACAUeuGAJdgAALh3uQQ
        (envelope-from <neilb@suse.de>); Thu, 03 Jun 2021 00:10:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: move fsnotify on client creation outside spinlock
In-reply-to: <20210602200639.GC6995@fieldses.org>
References: <20210602200639.GC6995@fieldses.org>
Date:   Thu, 03 Jun 2021 10:10:39 +1000
Message-id: <162267903933.23712.6221073402758269956@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 03 Jun 2021, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> This was causing a "sleeping function called from invalid context"
> warning.
> 
> I don't think we need the set_and_test_bit() here; clients move from
> unconfirmed to confirmed only once, under the client_lock.
> 
> The (conf == unconf) is a way to check whether we're in that confirming
> case, hopefully that's not too obscure.

It is a bit obscure, but I cannot see a cleaner way as it isn't too hard
to work out what the test means by looking back at the code.  So the
only concern is that some later change might cause the test to subtly
change meaning.  Probably not a big concern.

Anyway, thanks for fixing this up.

NeilBrown


> 
> Fixes: 472d155a0631 "nfsd: report client confirmation status in "info" file"
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 99dfc668f605..c01ecb7b3fd3 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2824,11 +2824,8 @@ move_to_confirmed(struct nfs4_client *clp)
>  	list_move(&clp->cl_idhash, &nn->conf_id_hashtbl[idhashval]);
>  	rb_erase(&clp->cl_namenode, &nn->unconf_name_tree);
>  	add_clp_to_name_tree(clp, &nn->conf_name_tree);
> -	if (!test_and_set_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags)) {
> -		trace_nfsd_clid_confirmed(&clp->cl_clientid);
> -		if (clp->cl_nfsd_dentry && clp->cl_nfsd_info_dentry)
> -			fsnotify_dentry(clp->cl_nfsd_info_dentry, FS_MODIFY);
> -	}
> +	set_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags);
> +	trace_nfsd_clid_confirmed(&clp->cl_clientid);
>  	renew_client_locked(clp);
>  }
>  
> @@ -3487,6 +3484,8 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>  	/* cache solo and embedded create sessions under the client_lock */
>  	nfsd4_cache_create_session(cr_ses, cs_slot, status);
>  	spin_unlock(&nn->client_lock);
> +	if (conf == unconf)
> +		fsnotify_dentry(conf->cl_nfsd_info_dentry, FS_MODIFY);
>  	/* init connection and backchannel */
>  	nfsd4_init_conn(rqstp, conn, new);
>  	nfsd4_put_session(new);
> @@ -4095,6 +4094,8 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>  	}
>  	get_client_locked(conf);
>  	spin_unlock(&nn->client_lock);
> +	if (conf == unconf)
> +		fsnotify_dentry(conf->cl_nfsd_info_dentry, FS_MODIFY);
>  	nfsd4_probe_callback(conf);
>  	spin_lock(&nn->client_lock);
>  	put_client_renew_locked(conf);
> -- 
> 2.31.1
> 
> 
