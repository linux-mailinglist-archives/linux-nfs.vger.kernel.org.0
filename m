Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1835990F0
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Aug 2022 01:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbiHRXF4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Aug 2022 19:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiHRXFz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Aug 2022 19:05:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921E6CD7A6
        for <linux-nfs@vger.kernel.org>; Thu, 18 Aug 2022 16:05:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 491015C56B;
        Thu, 18 Aug 2022 23:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660863953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bVh29NEyEDoQ7z5I08Hqo13QuYYn37AowncWmf6tQ1Y=;
        b=HxiHY94ExKj7o69Zt+PyobH74ane9g1x9bpFh+xpRpRoMAvroQh+p7wNqtBrWNMMddm/P1
        pLNh+89Zvlj8XtNCOXTkDwIdO0dwa5NspMdgoUckgE8yD6hs1pC3VXp+jLyZU0yiCUOruo
        VdrkuA4ubqoTR+IQVV0+FQq36jAoKDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660863953;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bVh29NEyEDoQ7z5I08Hqo13QuYYn37AowncWmf6tQ1Y=;
        b=mPiPjfY0tnlHyF71n0F8FuIgpYgncsPNAiL/D3oHwBAsAK2UXc+US3C7/lEyj/R3VGgS9I
        pPOKbq5uYfE7D7Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B9BC139B7;
        Thu, 18 Aug 2022 23:05:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qt3iNc/F/mLmMwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 18 Aug 2022 23:05:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     hooanon05g@gmail.com
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: Re: NFS, two d_delete() calls in nfs_unlink()
In-reply-to: <9451.1660793491@jrobl>
References: <7634.1660728564@jrobl>,
 <166079133167.5425.16635199337074058478@noble.neil.brown.name>,
 <9451.1660793491@jrobl>
Date:   Fri, 19 Aug 2022 09:05:48 +1000
Message-id: <166086394829.5425.9699631920964605772@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 18 Aug 2022, hooanon05g@gmail.com wrote:
> "NeilBrown":
> > Thanks for the report.
> > This possibility of calling d_delete() twice has been present
> > since  9019fb391de0 in v5.16.
> 
> I don't think 9019fb391de0 is a problem.
> Before v6.0-rc1, the target dentry was unhashed by __d_drop() call in
> nfs_unlink(), and nfs_dentry_handle_enoent() skipped calling d_delete()
> by simple_positive(). d_delete() was called only once via
> nfs_dentry_remove_handle_error().

Ahhh - simple_positive() checks d_unhashed() - I didn't connect that.

So before my recent patch we needed the second call to d_delete() in
nfs_unlink() because the first wasn't effective.  However the second
call in nfs_rmdir() was still a problem.

So if the current fix (9a31abb1c009) gets ported back before the patch
that removed unhash (3c59366c207e) then it won't do the right thing
for nfs_unlink().  As it has a Fixes: tag, that is likely.

It would be better to protect the d_delete() with
d_really_is_positive().

Trond: can we drop that patch and replace it, or should I add the
d_really_is_positive() check with a new patch?


> 
> In v6.0-rc1, the dentry is not unhashed and nfs_dentry_handle_enoent()
> doesn't skip calling d_delete().
> 
> 
> > How did you discover this bug, and why do you think my patch
> > caused it?
> 
> I met this problem during a stress test aiming a filesystem I am
> developing.
> And I think unhashing causes nfs_dentry_handle_enoent() to call
> d_delete().

Thanks a lot for helping me understand!

Thanks,
NeilBrown

