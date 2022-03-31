Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E2C4ED13D
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 03:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352354AbiCaBQI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 21:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352324AbiCaBOt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 21:14:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1F8674C9;
        Wed, 30 Mar 2022 18:12:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D27F8210E3;
        Thu, 31 Mar 2022 01:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648689167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ZCMnjhhcWUX7ZYHloF0R6ZgTpYnAjTJDUQyQz77/Bg=;
        b=xx5GSJRewcZAbgwoEHNTyRZ1uAEYwRri3VDIauaS5z4InmEzzobqwL5Kh1mr7G8JyrRCao
        GpJApWhiCMrZZBAwg/gozjF4prLlAYI7tHF1upGqAN5guPbFdcOIh3fr/bWCOaXTW+Oj6n
        3WMJnnw+FHyu5y+B8lxJFQJCA4MoWKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648689167;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ZCMnjhhcWUX7ZYHloF0R6ZgTpYnAjTJDUQyQz77/Bg=;
        b=cdqZljJY2guPbPOstzhqlwHTLPKziJy12sNp8y8QUSoxCcHrQkbHerBbbUB1DzFy7oV60y
        gvRVgqLn4yGTdWAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB13E13AE0;
        Thu, 31 Mar 2022 01:12:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zKz5JA0ARWKjUQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 31 Mar 2022 01:12:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "David Howells" <dhowells@redhat.com>
Cc:     dhowells@redhat.com, "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@infradead.org>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] MM changes to improve swap-over-NFS support
In-reply-to: <2923577.1648635976@warthog.procyon.org.uk>
References: <164859751830.29473.5309689752169286816.stgit@noble.brown>,
 <2923577.1648635976@warthog.procyon.org.uk>
Date:   Thu, 31 Mar 2022 12:12:41 +1100
Message-id: <164868916197.25542.11845352976146070176@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 30 Mar 2022, David Howells wrote:
> Do you have a branch with your patches on?

http://git.neil.brown.name/?p=linux.git;a=shortlog;h=refs/heads/swap-nfs

git://neil.brown.name/linux  branch swap-nfs

Also  on https://github.com/neilbrown/linux.git same branch

(it seems 1GB is no longer enough to run a git server for the kernel
 effectively)

This contains 
 - recent HEAD from Linus, which includes the NFS work
 - the patches I sent to akpm
 - the patch to switch NFS over to using the new swap_rw
 - a SUNRPC patch to fix an easy crash.  But has always been there,
    but recent changes to how kmalloc is called makes it much easier to
    trigger.

NeilBrown
