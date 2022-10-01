Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A505F19F0
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Oct 2022 07:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiJAFDp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Oct 2022 01:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJAFDp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Oct 2022 01:03:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED0324BE2
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 22:03:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF595218E1;
        Sat,  1 Oct 2022 05:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664600622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOAhG365r1YKWPtMAZ+7EwTHakaspF+5YlSwaoTLlAM=;
        b=RbP5b1uV6pxK/JGCrIhqFNL0UF6r+ISJScehGkRuSSamEp0/bkUJlx2HxZm69diOIC6uUn
        To3AKD4yTOuEUd74yCUKL48k7/pc5dxyj99u6tlTXqk7CQb1jPmrR/80ccM12IIojPiBsg
        owCoDBJiL59mIjurqkFrIcvmtH27n1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664600622;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOAhG365r1YKWPtMAZ+7EwTHakaspF+5YlSwaoTLlAM=;
        b=6CkPjoMzmfzQ59b4PL9EDeSnU7aOar+bBSk4CpiHSfUcjnR6uhDncnURVEw87shsAXxEm0
        Tvu3fgKQ3RXJihDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9588D1348E;
        Sat,  1 Oct 2022 05:03:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6IhUEi3KN2POcwAAMHmgww
        (envelope-from <neilb@suse.de>); Sat, 01 Oct 2022 05:03:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/3] nfsd: fix potential race in nfsd_file_close
In-reply-to: <20220930191550.172087-3-jlayton@kernel.org>
References: <20220930191550.172087-1-jlayton@kernel.org>,
 <20220930191550.172087-3-jlayton@kernel.org>
Date:   Sat, 01 Oct 2022 15:03:38 +1000
Message-id: <166460061835.17572.12490851025838613566@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 01 Oct 2022, Jeff Layton wrote:
> Once we call nfsd_file_put, there is no guarantee that "nf" can still be
> safely accessed. That may have been the last reference.
> 
> Change the code to instead check for whether nf_ref is 2 and then unhash
> it and put the reference if we're successful.
> 
> We might occasionally race with another lookup and end up unhashing it
> when it probably shouldn't have been, but that should hopefully be rare
> and will just result in the competing lookup having to create a new
> nfsd_file.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 6237715bd23e..58f4d9267f4a 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -461,12 +461,14 @@ nfsd_file_put(struct nfsd_file *nf)
>   */
>  void nfsd_file_close(struct nfsd_file *nf)
>  {
> -	nfsd_file_put(nf);
> -	if (refcount_dec_if_one(&nf->nf_ref)) {
> -		nfsd_file_unhash(nf);
> -		nfsd_file_lru_remove(nf);
> -		nfsd_file_free(nf);
> +	/* One for the reference being put, and one for the hash */
> +	if (refcount_read(&nf->nf_ref) == 2) {
> +		if (nfsd_file_unhash(nf))
> +			nfsd_file_put_noref(nf);
>  	}
> +	/* put the ref for the stateid */
> +	nfsd_file_put(nf);
> +

This looks racy. What if a get happens after the read and before the unhash?

If we unhash the nfsd_file at last close, why does the hash table hold a
counted reference at all?
When it is hashed, set the NFSD_FILE_HASHED flag.  On last-put, if that
flag is set, unhash it.
If you want to unhash it earlier, test/clear the flag and delete from
rhashtable.

NeilBrown


>  }
>  
>  struct nfsd_file *
> -- 
> 2.37.3
> 
> 
