Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E085E53F3FA
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 04:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbiFGCiK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 22:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiFGCiJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 22:38:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FBE5F8D9
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 19:38:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9829921B59;
        Tue,  7 Jun 2022 02:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654569487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUqKl01D1Dk9739cP4y1+EH2QYoOpo0/Xdt7m0JZ3fg=;
        b=xAYe1wvTaSpU4f8aAzBQTIA/tteYlSGAg4X7gIiKv3WlQ8t/fhbXqh9XCPBtiIBuNnG2H1
        0to0HvBC+uz68IlqgvsTZSmckqcwV8vzIELZUHkN2WIqqSNs4Pi7g8BO6P/DuwlHPFJ2sI
        KrUZAgdj2bA5bUi5qVg7RgD4HIIIOj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654569487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUqKl01D1Dk9739cP4y1+EH2QYoOpo0/Xdt7m0JZ3fg=;
        b=etKUuENPrTzV3eLJrhmdLdSZEFVQT5NPGXImeEA7KOThoD6be+xrUtra25jQnDZ+uCgp/M
        lWY2lxhjbqXcdaDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9F7613A15;
        Tue,  7 Jun 2022 02:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XkbNHA66nmLCKgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 07 Jun 2022 02:38:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] SUNRPC: Clean up xdr_commit_encode()
In-reply-to: <BCB98EE4-9824-4147-8D21-47110914D51F@oracle.com>
References: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>,
 <165445911819.1664.8436212544546306528.stgit@bazille.1015granger.net>,
 <165456394819.22243.15333379326870400835@noble.neil.brown.name>,
 <BCB98EE4-9824-4147-8D21-47110914D51F@oracle.com>
Date:   Tue, 07 Jun 2022 12:37:58 +1000
Message-id: <165456947808.22243.6052931047455826981@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 07 Jun 2022, Chuck Lever III wrote:
> 
> > On Jun 6, 2022, at 9:05 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Mon, 06 Jun 2022, Chuck Lever wrote:
> >> Both the ::iov_len field and the third parameter of memcpy() and
> >> memmove() are size_t. There's no reason for the implicit conversion
> >> from size_t to int and back. Change the type of @shift to make the
> >> code easier to read and understand.
> > 
> > I wouldn't object to "shift" being renamed "frag1bytes" to make the
> > connection with xdr_get_next_encode_buffer() more blatant..
> 
> I thought of that. Readers would wonder why frag1bytes in
> xdr_commit_encode() was a size_t, but in xdr_get_next_encode_buffer()
> it's a signed int. It started to become a longer string to pull.
> Maybe it's worth it?
> 

Probably worth it.  Not necessarily worth it today.  I have no strong
preference.

NeilBrown

> 
> > Reviewed-by: NeilBrown <neilb@suse.de>
> > 
> > Thanks,
> > NeilBrown
> > 
> > 
> >> 
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> net/sunrpc/xdr.c |    4 +++-
> >> 1 file changed, 3 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> >> index 08a85375b311..de8f71468637 100644
> >> --- a/net/sunrpc/xdr.c
> >> +++ b/net/sunrpc/xdr.c
> >> @@ -933,14 +933,16 @@ EXPORT_SYMBOL_GPL(xdr_init_encode);
> >>  */
> >> inline void xdr_commit_encode(struct xdr_stream *xdr)
> >> {
> >> -	int shift = xdr->scratch.iov_len;
> >> +	size_t shift = xdr->scratch.iov_len;
> >> 	void *page;
> >> 
> >> 	if (shift == 0)
> >> 		return;
> >> +
> >> 	page = page_address(*xdr->page_ptr);
> >> 	memcpy(xdr->scratch.iov_base, page, shift);
> >> 	memmove(page, page + shift, (void *)xdr->p - page);
> >> +
> >> 	xdr_reset_scratch_buffer(xdr);
> >> }
> >> EXPORT_SYMBOL_GPL(xdr_commit_encode);
> >> 
> >> 
> >> 
> 
> --
> Chuck Lever
> 
> 
> 
> 
