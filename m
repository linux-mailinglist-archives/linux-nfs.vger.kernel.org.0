Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B1A51407A
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 04:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiD2CIl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 22:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiD2CIl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 22:08:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABF1201A8;
        Thu, 28 Apr 2022 19:05:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C762B210E6;
        Fri, 29 Apr 2022 02:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651197922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQDXCYk6Wp2fThp27o+RRwGuMEj38RMRp7V9mIoaJbU=;
        b=aH0xMKbGX3tLDkIE+w0DSWZemlHZ9Ki3i6uleeG6ICQBueIO9bdIr3YKMKa9kn/yTmkHcu
        f7wNkMwm29wIPum703Iajuq7/r6zHPt3SKrYINfPlXbIoJjrBm49FbSbVhkvtoOdZs+9cM
        m8sZG4+MyIUgnqQVJSzoWc9T6rP7/Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651197922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQDXCYk6Wp2fThp27o+RRwGuMEj38RMRp7V9mIoaJbU=;
        b=EaIeOX9kGfmK/fCfk5FcomE94id4ubWbX/l+kI52NaQyHKGfx2YYbVWwnfCGjxEPZFdCca
        BQZK+xIJRQI0nPAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8635D13446;
        Fri, 29 Apr 2022 02:05:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rlZFEOBHa2JsYAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 29 Apr 2022 02:05:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Christoph Hellwig" <hch@lst.de>,
        "Miaohe Lin" <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] NFS: rename nfs_direct_IO and use as ->swap_rw
In-reply-to: <20220428182353.d79ae288e1bb0cae5116d989@linux-foundation.org>
References: <165119280115.15698.2629172320052218921.stgit@noble.brown>,
 <165119301493.15698.7491285551903597618.stgit@noble.brown>,
 <20220428182353.d79ae288e1bb0cae5116d989@linux-foundation.org>
Date:   Fri, 29 Apr 2022 12:05:16 +1000
Message-id: <165119791620.1648.7397114175780668923@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 29 Apr 2022, Andrew Morton wrote:
> On Fri, 29 Apr 2022 10:43:34 +1000 NeilBrown <neilb@suse.de> wrote:
> 
> > The nfs_direct_IO() exists to support SWAP IO, but hasn't worked for a
> > while.  We now need a ->swap_rw function which behaves slightly
> > differently, returning zero for success rather than a byte count.
> > 
> > So modify nfs_direct_IO accordingly, rename it, and use it as the
> > ->swap_rw function.
> > 
> 
> This one I insertion sorted into the series after
> mm-introduce-swap_rw-and-use-it-for-reads-from-swp_fs_ops-swap-space.patch.
> I can later fold this patch into that one of you think that's a better
> presentation?
> 

I'm happy for the patches to remain separate - though adjacent is good.
If they were to be merged we'd need to fix up the commit message.
At least delete:

   Future patches will restore swap-over-NFS functionality.

Thanks,
NeilBrown
