Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A5F54F8E9
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jun 2022 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382622AbiFQOIB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jun 2022 10:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382620AbiFQOIA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jun 2022 10:08:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A34FC40
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jun 2022 07:07:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 440CB1FDE5;
        Fri, 17 Jun 2022 14:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655474878;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Muo4pFI8p4KNmoA3ofO5dMv9wOznN8GBeoBdD7xtNA=;
        b=tp7Iyc4xmmpkVrOuhW+dbs8l1u4vAVHY6xr9KN1Pqtq2sHyj3Xo+QlTT5sv3jpKSpq+c2m
        BMnhKOqYbp6otDuqC5ua/fwjJN6rDO0rAdK3FOaNUGfMnZEZIHdo6jVYAIaOS8AgT595TC
        eNy//TS0np1lfx39UDeRAk270SQ8trI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655474878;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Muo4pFI8p4KNmoA3ofO5dMv9wOznN8GBeoBdD7xtNA=;
        b=g/RVfHeS8EdJ8IWArg/jcFuVuJew/ZUTGK1jJ7neIVHM4adYbz2vfHgQcIg6mI/fdXA/GZ
        AYFxt6kpwwEhB7BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0802013458;
        Fri, 17 Jun 2022 14:07:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CKUqO72KrGK1JgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 17 Jun 2022 14:07:57 +0000
Date:   Fri, 17 Jun 2022 16:07:55 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, linux-nfs@vger.kernel.org
Subject: Re: [LTP] [PATCH v2 5/9] tst_test.sh: Add $TST_ALL_FILESYSTEMS
Message-ID: <YqyKu2Gi7SbeplMs@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220609214223.4608-1-pvorel@suse.cz>
 <20220609214223.4608-6-pvorel@suse.cz>
 <YqyHNFkJdC0q2Vxs@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqyHNFkJdC0q2Vxs@yuki>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Cyril,

> Generally the code looks good, there is still a minor difference between
> C API and this changes though. As we do call the _tst_cleanup_timer at
> the end of this function the script runs without a timeout for a short
> while (which includes tst_mkfs call).

> I guess that instead of stopping the timer at the end of the
> _tst_run_iterations() we can simply reset it (on the top of this patch):

Good catch, thanks for providing a patch.
LGTM, I'll have a deeper look later.

Kind regards,
Petr
