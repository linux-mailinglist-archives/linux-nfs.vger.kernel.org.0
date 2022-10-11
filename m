Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EC85FA930
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 02:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJKAQp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Oct 2022 20:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJKAQo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Oct 2022 20:16:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE3E5C95D
        for <linux-nfs@vger.kernel.org>; Mon, 10 Oct 2022 17:16:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1CD81FE85;
        Tue, 11 Oct 2022 00:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665447401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6jJasXbmNoQYMeXKlhtjjpXItiNJRaxr4nVcy+aZfA=;
        b=PTjgRw1LfIOwrkg23LE0BKXWPIb/BOnh88bU3XCX5HPXSoGflbGQLmN1Q3gRlQHmeazkM6
        fSDfSA0XKPeSBomAnunsOiqD4u3F0UVeCAvHrLLXE/3nZNr7yqM4l5Mz3o65ez+63JBfPE
        I4x2WHSy2Kxacy0Hg7s095kOx+fHcfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665447401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6jJasXbmNoQYMeXKlhtjjpXItiNJRaxr4nVcy+aZfA=;
        b=DOnGyAlCknBAYZLzF6jJWI8bUjiplbPNAiFrRnJKyNdXLpreE9DhgxcKlzqJNnq7z1XG2R
        ASj1+oIAaySZX4Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A1A413A9A;
        Tue, 11 Oct 2022 00:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2YBqNui1RGMqdAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 11 Oct 2022 00:16:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 7/9] NFSD: Use rhashtable for managing nfs4_file objects
In-reply-to: <166507324882.1802.884870684212914640.stgit@manet.1015granger.net>
References: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>,
 <166507324882.1802.884870684212914640.stgit@manet.1015granger.net>
Date:   Tue, 11 Oct 2022 11:16:37 +1100
Message-id: <166544739751.14457.9018300177489236723@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 07 Oct 2022, Chuck Lever wrote:
>  
> -static unsigned int file_hashval(struct svc_fh *fh)
> +/*
> + * The returned hash value is based solely on the address of an in-code
> + * inode, a pointer to a slab-allocated object. The entropy in such a
> + * pointer is concentrated in its middle bits.

I think you need more justification than that for throwing away some of
the entropy, even if you don't think it is much.
Presumably you think hashing 32 bits is faster than hashing 64 bits.
Maybe it is, but is it worth it?

rhashtable depends heavily on having a strong hash function.  In
particular if any bucket ends up with more than 16 elements it will
choose a new seed and rehash.  If you deliberately remove some bits that
it might have been used to spread those 16 out, then you are asking for
trouble.

We know that two different file handles can refer to the same inode
("rarely"), and you deliberately place them in the same hash bucket.
So if an attacker arranges to access 17 files with the same inode but
different file handles, then the hashtable will be continuously
rehashed.

The preferred approach when you require things to share a hash chain is
to use an rhl table.  This allows multiple instances with the same key.
You would then key the rhl-table with the inode, and search a
linked-list to find the entry with the desired file handle.  This would
be no worse in search time than the current code for aliased inodes, but
less susceptible to attack.

> +/**
> + * nfs4_file_obj_cmpfn - Match a cache item against search criteria
> + * @arg: search criteria
> + * @ptr: cache item to check
> + *
> + * Return values:
> + *   %0 - Item matches search criteria
> + *   %1 - Item does not match search criteria

I *much* prefer %-ESRCH for "does not match search criteria".  It is
self-documenting.  Any non-zero value will do.

NeilBrown
