Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A72514072
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 04:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiD2CBL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Apr 2022 22:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350360AbiD2CBK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Apr 2022 22:01:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B92BF526;
        Thu, 28 Apr 2022 18:57:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4D1D11F891;
        Fri, 29 Apr 2022 01:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651197473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6SWF/nGzhsjwq5ARATRVet+UBJFK9TgWKy2UT2xPXM=;
        b=U8L2w6H02ZPq7rqO5DJ0G2KO0ozM0gXG5jxSla0+RuSUHKTcGzpozSVMnFSJD5xmhDq8ad
        2uyZ3apVsDcOxO6E8thPaHk3V8U3QwE2H7it2GRgun7Ft+q1sS0Y6dAuRBjTiqB4BbldL0
        UKa0F/nGDA/bdxrLQvJ4wZUVWx6f5OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651197473;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6SWF/nGzhsjwq5ARATRVet+UBJFK9TgWKy2UT2xPXM=;
        b=y33957Ckvud8SaVQpfdx8Oo831Ez0W23CrChHWBUdp0Vg6adczUx3ofOTzcWn8qyMebGIp
        ebijTSE+d4Ipx8Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35C8813446;
        Fri, 29 Apr 2022 01:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x6U6OR5Ga2JHXgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 29 Apr 2022 01:57:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Christoph Hellwig" <hch@lst.de>,
        "Miaohe Lin" <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MM: handle THP in swap_*page_fs()
In-reply-to: <20220428182132.883a082ad8918fd5f8073130@linux-foundation.org>
References: <165119280115.15698.2629172320052218921.stgit@noble.brown>,
 <165119301488.15698.9457662928942765453.stgit@noble.brown>,
 <20220428182132.883a082ad8918fd5f8073130@linux-foundation.org>
Date:   Fri, 29 Apr 2022 11:57:45 +1000
Message-id: <165119746546.1648.12856939779038565632@noble.neil.brown.name>
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
> > Pages passed to swap_readpage()/swap_writepage() are not necessarily all
> > the same size - there may be transparent-huge-pages involves.
> > 
> > The BIO paths of swap_*page() handle this correctly, but the SWP_FS_OPS
> > path does not.
> > 
> > So we need to use thp_size() to find the size, not just assume
> > PAGE_SIZE, and we need to track the total length of the request, not
> > just assume it is "page * PAGE_SIZE".
> 
> Cool.  I added this in the series after
> mm-submit-multipage-write-for-swp_fs_ops-swap-space.patch.  I could
> later squash it into that patch if you think that's more logical.

I think it best to keep it separate, though that position is good.
If we were to squash, some would need to go into the "submit multipage
reads" patch, and some in "submit multipage writes".  IF you wanted to
do that I wouldn't object but I don't think it is needed.

Thanks,
NeilBrown
