Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A145F65CB2E
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 02:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjADBBm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Jan 2023 20:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbjADBBl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 20:01:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8520DB39
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 17:01:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 44BB276667;
        Wed,  4 Jan 2023 01:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1672794099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/EW3DxXDYb7rTcHoHvb9Zw0bTpgKC1LMFT+TucZonY=;
        b=Fd+F/7F6HCCDeufFfypyXjwhMN7c/DAuPqx4+wen663FUWxqxWcGh9O0jq0cfFrddT8Hlh
        AvYLpd+s3buYvtNr5fQEkQv6a+IsykzqZX5B5DB3doaIAJFD4lv8crrNOU7JQg3S/YAXuI
        o7RqS/u7MGLfAdZ//s8RewQHHpeYBOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1672794099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/EW3DxXDYb7rTcHoHvb9Zw0bTpgKC1LMFT+TucZonY=;
        b=SrStzjqyHvCy+Fmh/s8dPJ4YG/uCFFBXRfUOxDnhpy/APQBt3qu0WXpCVgcqDAYZix8tnF
        EYxzCLBfW39CllCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FFB713273;
        Wed,  4 Jan 2023 01:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NFZaCfHPtGPiaAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 04 Jan 2023 01:01:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@kernel.org>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "Anna Schumaker" <anna@kernel.org>,
        "Olga Kornievskaia" <aglo@umich.edu>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
In-reply-to: <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>,
 <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>
Date:   Wed, 04 Jan 2023 12:01:33 +1100
Message-id: <167279409373.13974.16504090316814568327@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 04 Jan 2023, Trond Myklebust wrote:
> 
> 
> If the server starts to reply NFS4ERR_STALE to GETATTR requests, why do
> we care about stateid values? Just mark the inode as stale and drop it
> on the floor.

We have a valid state from the server - we really shouldn't just ignore
it.

Maybe it would be OK to mark the inode stale.  I don't know if various
retry loops abort properly when the inode is stale.

> 
> If the server tries to declare the state as revoked, then it is clearly
> borken, so let NetApp fix their own bug.

That's probably fair.

Thanks,
NeilBrown

> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
> 
