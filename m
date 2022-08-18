Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B079597BB8
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Aug 2022 04:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbiHRCzj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Aug 2022 22:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242883AbiHRCzj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Aug 2022 22:55:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC284A571E
        for <linux-nfs@vger.kernel.org>; Wed, 17 Aug 2022 19:55:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C9C620B6A;
        Thu, 18 Aug 2022 02:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660791336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SSSJqi9vFita0vstRwkfAQnmHXDnamYCySmvCOoAvsI=;
        b=vZ6K9auxlA0PXaXfOP9LNVCu4aJ3ADD+PQPssUTZqRP0dNQEKdaKZrN14XJWCpQ8GFZ5un
        eaDArfWSDZRHHg45rrIKzidtQiqMZ6YX4eH5WOQDgQfT6mXUss/GDyFXY6SSKT+JbBS5MX
        HYo1M5+/Z5zMqLksasRz6zKLov9XsdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660791336;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SSSJqi9vFita0vstRwkfAQnmHXDnamYCySmvCOoAvsI=;
        b=D5WeK5lmMWayuJp97sBeLrryzMX/C93a5ByHn2on6qyRroDAuGOC5b8nkZhPu5U9Yf04lO
        jgPVc3NzUTZ3d7AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A2BF13440;
        Thu, 18 Aug 2022 02:55:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fEIzNSaq/WLacgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 18 Aug 2022 02:55:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. R. Okajima" <hooanon05g@gmail.com>
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: Re: NFS, two d_delete() calls in nfs_unlink()
In-reply-to: <7634.1660728564@jrobl>
References: <7634.1660728564@jrobl>
Date:   Thu, 18 Aug 2022 12:55:31 +1000
Message-id: <166079133167.5425.16635199337074058478@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 17 Aug 2022, J. R. Okajima wrote:
> Hello NeilBrown and Trond Myklebust,
> 
> By the commin in v6.0-rc1,
> 	3c59366c207e 2022-08-08 NFS: don't unhash dentry during unlink/rename
> nfs_unlink() stopped calling __d_drop().
> And it MAY cause two d_delete() calls. If it happens, the second call
> leads to NULL pointer access because d_inode is already cleared.
> 
> Here is the detail.
> 
> nfs_unlink()
> + nfs_safe_remove()
>   + NFS_PROTO(dir)->remove() <-- returns ENOENT
>   + nfs_dentry_handle_enoent()
>     + if (simple_positive()) d_delete() <-- 1st call and d_inode is cleared
> + nfs_dentry_remove_handle_error()
>   + if (ENOENT) d_delete() <-- second call and NULL d_inode is accessed
> 
> How about adding a condition for d_delete() call in
> nfs_dentry_remove_handle_error(), such like simple_positive()?
> 

Thanks for the report.
This possibility of calling d_delete() twice has been present
since  9019fb391de0 in v5.16.
It is possible that my patch made it more likely or more problematic,
though I cannot see why.
I posted a patch which Trond has applied to his linux-next branch.
It is in linux-next as commit 9a31abb1c009c40

How did you discover this bug, and why do you think my patch
caused it?

Thanks,
NeilBrown
