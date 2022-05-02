Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B359516A48
	for <lists+linux-nfs@lfdr.de>; Mon,  2 May 2022 07:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355873AbiEBFc0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 01:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiEBFcZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 01:32:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E75A2D1C5;
        Sun,  1 May 2022 22:28:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C0EEA1F390;
        Mon,  2 May 2022 05:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651469336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMLDEiOEivJVbi2ra4sFxYON8MSPoZXKHIUu7A5Dhko=;
        b=iWrEtpRf1Gdn9iVp2B+2WeSIQSksT+R7WdfF8ZJEWZb48EwY5gXJXPsgnGDTTCG5mKabbq
        AMkj40CvAqbYrTxnfGFBZkQCOspxnPW1nA4/dMBHA5KrX8mH+vE62QggZVYKWVqOfe4nxo
        rMWYyiVUAAW9OYUQow7ecE8HZEqrFNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651469336;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMLDEiOEivJVbi2ra4sFxYON8MSPoZXKHIUu7A5Dhko=;
        b=CnGfXikueRG/5LVtwxpIed/U+DF8mUW1H8pG6ii0GicKNyZ8DApge1Q6Ep9DLhc1xAGGfy
        ItwuhukBBI5LK8CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A035313491;
        Mon,  2 May 2022 05:28:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 80+bEhVsb2K5TAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 02 May 2022 05:28:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "Miaohe Lin" <linmiaohe@huawei.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Christoph Hellwig" <hch@lst.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MM: handle THP in swap_*page_fs() - count_vm_events()
In-reply-to: <Ym9pLhqtf61AVrZG@casper.infradead.org>
References: <165146746627.24404.2324091720943354711@noble.neil.brown.name>,
 <Ym9pLhqtf61AVrZG@casper.infradead.org>
Date:   Mon, 02 May 2022 15:28:49 +1000
Message-id: <165146932944.24404.17790836056748683378@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 02 May 2022, Matthew Wilcox wrote:
> On Mon, May 02, 2022 at 02:57:46PM +1000, NeilBrown wrote:
> > @@ -390,9 +392,9 @@ static void sio_read_complete(struct kiocb *iocb, lon=
g ret)
> >  			struct page *page =3D sio->bvec[p].bv_page;
> > =20
> >  			SetPageUptodate(page);
> > +			count_swpout_vm_event(page);
> >  			unlock_page(page);
> >  		}
> > -		count_vm_events(PSWPIN, sio->pages);
>=20
> Surely that should be count_swpIN_vm_event?
>=20
I'm not having a good day....

Certainly shouldn't be swpout.  There isn't a count_swpin_vm_event().

swap_readpage() only counts once for each page no matter how big it is.
While swap_writepage() counts one for each PAGE_SIZE written.

And we have THP_SWPOUT but not THP_SWPIN

And I cannot find where any of these counters are documents, so I cannot
say what is "correct".

Well.... arch/s390/appldata/appldata_mem.c says
	u64 pswpin;		/* pages swapped in  */
	u64 pswpout;		/* pages swapped out */

but that isn't exactly unambiguous, and is for s390 which doesn't
support THP_SWAP

Ho hum.  I guess I put that back as it was.

Thanks for the review!!!

NeilBrown
