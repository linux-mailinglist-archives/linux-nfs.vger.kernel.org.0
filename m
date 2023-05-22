Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D74670CE72
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 01:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjEVXIO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 May 2023 19:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjEVXIN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 May 2023 19:08:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C791AC6
        for <linux-nfs@vger.kernel.org>; Mon, 22 May 2023 16:08:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3DA782228C;
        Mon, 22 May 2023 23:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684796883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlYhxk0OlLkO1UuRsIIq1aBUsVFZhUn/EAPB6alB3hc=;
        b=j5Fe/Y01GlVivzD4+OH5ydxOMYdvtZLMSKS8ABoZEem8s33ziBP9RvcY09hAoGv/fT5+WL
        XB4TEPneIk3HMHMhFU1c8lFmH1P4561fCIlduep3tpV78VH2eUaOv+knIssOAFcONMxO+Q
        p3C3KJWZqzWIerQypDbzvyl1euBVBRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684796883;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlYhxk0OlLkO1UuRsIIq1aBUsVFZhUn/EAPB6alB3hc=;
        b=X6u2FX35weTs0WBZq/tLNhprIwBeBzCDype6T2cP6crXHbVff3G3L4n2hUjNr5P/Jp5GUA
        QHEHYqEATLG53NCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0535C13336;
        Mon, 22 May 2023 23:08:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T6AAK9H1a2T7CAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 22 May 2023 23:08:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: don't provide pre/post-op attrs if fh_getattr fails
In-reply-to: <20230519111723.20612-1-jlayton@kernel.org>
References: <20230519111723.20612-1-jlayton@kernel.org>
Date:   Mon, 22 May 2023 11:24:22 +1000
Message-id: <168471866230.5298.3283829268036917998@noble.neil.brown.name>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 19 May 2023, Jeff Layton wrote:
> nfsd calls fh_getattr to get the latest inode attrs for pre/post-op
> info. In the event that fh_getattr fails, it resorts to scraping cached
> values out of the inode directly.
> 
> Since these attributes are optional, we can just skip providing them
> altogether when this happens.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfsfh.c | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ccd8485fee04..e8e13ae72e3c 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -623,16 +623,9 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
>  
>  	inode = d_inode(fhp->fh_dentry);
>  	err = fh_getattr(fhp, &stat);
> -	if (err) {
> -		/* Grab the times from inode anyway */
> -		stat.mtime = inode->i_mtime;
> -		stat.ctime = inode->i_ctime;
> -		stat.size  = inode->i_size;
> -		if (v4 && IS_I_VERSION(inode)) {
> -			stat.change_cookie = inode_query_iversion(inode);
> -			stat.result_mask |= STATX_CHANGE_COOKIE;
> -		}
> -	}
> +	if (err)
> +		return;
> +

I wondered if this might exercise error paths which had not previously
been tested.  Before this change fh_pre_saved is always set, now it is
not.

The code looks OK, but I was amused by xdr_stream_encode_item_absent().
Various places in the code test for "< 0" or "> 0" which seems to
suggest that "0" is not being handled consistently.
But of course xdr_stream_encode_item_absent() can never return 0.  It
returns either XDR_UNIT or -EMSGSIZE.

I wonder if we should be consistent in how we test for an error ....  or
if it it really matters.

Patch itself looks good.

Thanks,
NeilBrown


>  	if (v4)
>  		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
>  
> @@ -660,15 +653,10 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
>  		printk("nfsd: inode locked twice during operation.\n");
>  
>  	err = fh_getattr(fhp, &fhp->fh_post_attr);
> -	if (err) {
> -		fhp->fh_post_saved = false;
> -		fhp->fh_post_attr.ctime = inode->i_ctime;
> -		if (v4 && IS_I_VERSION(inode)) {
> -			fhp->fh_post_attr.change_cookie = inode_query_iversion(inode);
> -			fhp->fh_post_attr.result_mask |= STATX_CHANGE_COOKIE;
> -		}
> -	} else
> -		fhp->fh_post_saved = true;
> +	if (err)
> +		return;
> +
> +	fhp->fh_post_saved = true;
>  	if (v4)
>  		fhp->fh_post_change =
>  			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
> -- 
> 2.40.1
> 
> 

