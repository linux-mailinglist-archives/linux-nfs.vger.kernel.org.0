Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E939E65CBD8
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 03:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjADCTg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Jan 2023 21:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjADCTf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 21:19:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B62E65A0
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 18:19:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B8AC76E59;
        Wed,  4 Jan 2023 02:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1672798772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENt4wz1gH2/EOWOKfDtLSEL0R+5RWadfbiqcYz7nUMQ=;
        b=2Y/XXKqRaIf8+3qFdk9vrww07MtdHs+wv39j+5liyVUU5YvxBU9BC1/mQEYFSvYpWil2SH
        6u0i/0n6jVpxLnd2fIPqkMU942HXcAOnq9vn16t9oTgsaQti41RLIzXnhS3snObXPBQMCQ
        /RBiMXUh7a1oqAgHlQeLgLCSsAanunY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1672798772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENt4wz1gH2/EOWOKfDtLSEL0R+5RWadfbiqcYz7nUMQ=;
        b=uawty7c7wyl/N9N6GiJEFdKKKVnZWQY4iSZF5nHhl1A4GA2ujJhwwYMWeV+XfXF3B5L4Bn
        jf9i0SLlBLwAmNDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD9CB1342C;
        Wed,  4 Jan 2023 02:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2KM2GDLitGOCBwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 04 Jan 2023 02:19:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Olga Kornievskaia" <aglo@umich.edu>
Cc:     "Trond Myklebust" <trondmy@kernel.org>,
        "Trond Myklebust" <trondmy@hammerspace.com>,
        "Anna Schumaker" <anna@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
In-reply-to: <CAN-5tyEBce3ZcXt9fxN9qPStRSSb=H-3v2ZFUovJRCs3CZXgXw@mail.gmail.com>
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>,
 <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>,
 <CAN-5tyEBce3ZcXt9fxN9qPStRSSb=H-3v2ZFUovJRCs3CZXgXw@mail.gmail.com>
Date:   Wed, 04 Jan 2023 13:19:27 +1100
Message-id: <167279876729.13974.1765446738043285170@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 04 Jan 2023, Olga Kornievskaia wrote:
> On Tue, Jan 3, 2023 at 7:46 PM Trond Myklebust <trondmy@kernel.org> wrote:
> >
> >
> > If the server starts to reply NFS4ERR_STALE to GETATTR requests, why do
> > we care about stateid values?
> 
> It is acceptable for the server to return ESTALE to the GETATTR after
> the processing the open (due to a REMOVE that comes in) and that open
> generating a valid stateid which client should care about when there
> are pre-existing opens. The server will keep the state of an existing
> opens valid even if the file is removed. Which is what's happening,
> the previous open is being used for IO but the stateid is updated on
> the server but not on the client.

I agree that it is acceptable to return ESTALE to the GETATTR, but
having done that I don't think it is acceptable for a PUTFH of the same
filehandle to succeed.  Certainly any attempt to again use the
filehandle after the PUTFH should fail with NFS4ERR_STALE.

RFC7530 says

13.1.2.7.  NFS4ERR_STALE (Error Code 70)

   The current or saved filehandle value designating an argument to the
   current operation is invalid.  The file system object referred to by
   that filehandle no longer exists, or access to it has been revoked.

So the file doesn't exist or access has been revoked.  So any writes
should fail.  Failing with OLD_STATEID is weird - and having writes
succeed if we use the correct stateid is also odd.  Failing with STALE
would be perfectly sensible and I suspect the Linux client would handle
that just fine.

Thanks,
NeilBrown
