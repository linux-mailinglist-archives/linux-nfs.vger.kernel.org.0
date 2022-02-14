Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F814B5E6E
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Feb 2022 00:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiBNXur (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Feb 2022 18:50:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiBNXur (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Feb 2022 18:50:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AED14032;
        Mon, 14 Feb 2022 15:50:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03792210F5;
        Mon, 14 Feb 2022 23:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644882637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qvPKjOh/wsUJqEQu+1yAdeggiSSJIk+3zVWtr119qmc=;
        b=MZKhM6baDXALJ8vMZRvkt0G/ule23iqk82N9aMTi4UY7j4EgQTr+czqmbaKwCj/YvSzYW9
        0NqlSUIKeAr2COGHUE2sx6+4MXY77jrH3EEv6oyosIHgYgHgVi9YC+o+SDuxFyhb7RfRgU
        AQb380eSlEsyi6eU+84RGkWhP1+S6h4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644882637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qvPKjOh/wsUJqEQu+1yAdeggiSSJIk+3zVWtr119qmc=;
        b=q4XCtTO4Ndidxg058D+Zx3F0YQcH4twF3P/3VBgXGRGXeQ0YS4wrPnsb+7tj85xUBjPJF5
        d+qoI2Skz5LzVPCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAD1213B59;
        Mon, 14 Feb 2022 23:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 81zII8jqCmJ9MwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 14 Feb 2022 23:50:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mark Hemment" <markhemm@googlemail.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "David Howells" <dhowells@redhat.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        "Linux MM" <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/21] MM: create new mm/swap.h header file.
In-reply-to: <CAMuHMdUtZyJE0-_B7YDexDpkOe_y5jQ7rWJKPyzJJczuSq7POg@mail.gmail.com>
References: <164420889455.29374.17958998143835612560.stgit@noble.brown>,
 <164420916109.29374.8959231877111146366.stgit@noble.brown>,
 <CAMuHMdUtZyJE0-_B7YDexDpkOe_y5jQ7rWJKPyzJJczuSq7POg@mail.gmail.com>
Date:   Tue, 15 Feb 2022 10:50:26 +1100
Message-id: <164488262648.17471.2510331812560662090@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 11 Feb 2022, Geert Uytterhoeven wrote:
> Hi Neil,
> 
> On Wed, Feb 9, 2022 at 10:52 AM NeilBrown <neilb@suse.de> wrote:
> > Many functions declared in include/linux/swap.h are only used within mm/
> >
> > Create a new "mm/swap.h" and move some of these declarations there.
> > Remove the redundant 'extern' from the function declarations.
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> 
> Thanks for your patch!
> 
> > --- /dev/null
> > +++ b/mm/swap.h
> > @@ -0,0 +1,129 @@
> > +
> 
> scripts/checkpatch.pl:
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> 
> Gr{oetje,eeting}s,
> 
>                         Geert

Argg...  I think you pointed that out previously and I forgot to act on
it.
I've now copied the SPDX line from linux/swap.h, and also added that
standard "#ifndef _MM_SWAP_H" etc protection.

Thanks,
NeilBrown
