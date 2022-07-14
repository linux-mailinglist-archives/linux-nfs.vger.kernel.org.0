Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA620575833
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 01:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiGNX7T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 19:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGNX7Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 19:59:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11EC1A83C
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 16:59:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7FB8133D30;
        Thu, 14 Jul 2022 23:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657843152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLjEX5R7agADucFksybyp1KoPUJ4cffA5wOP28IVfSU=;
        b=q7+uIGruZq3MQ1072Ru3JyEtAvQYC4BxhaLWulsUT5j5tAlEI6k3zoq0tUEZV5Hx4DqkvN
        V/mcmxCoaeSeDbVQYjR0sD3M4iwIkkE3D4D8Up233n4M2VzrP+XVkKqwesy1gqt9Qc1RQs
        pt0UisSb789IF1etak6f8Ef712hu0dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657843152;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLjEX5R7agADucFksybyp1KoPUJ4cffA5wOP28IVfSU=;
        b=ZgiXbXgrjDwQiRqgSP0Vl+8kctZz8AA7gLZtizAN8BZ09+2tAJAdlonIh96JAfim4NraxF
        9JukrCUJxgt1X0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FD0A13316;
        Thu, 14 Jul 2022 23:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HALVC8+t0GL6eAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 14 Jul 2022 23:59:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2] nfsd: close potential race between open and delegation
In-reply-to: <20220714200434.161818-1-jlayton@kernel.org>
References: <20220714200434.161818-1-jlayton@kernel.org>
Date:   Fri, 15 Jul 2022 09:59:02 +1000
Message-id: <165784314214.25184.13511971308364755291@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 15 Jul 2022, Jeff Layton wrote:
> This is a respin of the patchset that I sent earlier today. I hit a
> deadlock with that one because of the ambiguous locking.
> 
> This series is based on top of Neil's set entitled:
> 
>     [PATCH 0/8] NFSD: clean up locking.
> 
> His patchset makes the locking in the nfsd4_open codepath much more
> consistent, and this becomes a lot simpler to fix. Without that set
> however, the state of the parent's i_rwsem is unclear after nfsd_lookup
> is called, and I don't see a way to determine it reliably.

I haven't examined these patch very closely, but a few initial thoughts
are:

1/ Before my series, you can unambiguously tell if i_rwsem is held by
   checking fhp->fh_locked.  In fact, just call "fh_lock()", and you can
   then be sure the fh is locked, whether or not it was locked before
however...
2/ Do we really need to lock the parent?  If a rename or unlink happens
   after the lease was taken, the lease will be broken. So
    take lease.
    repeat lookup (locklessly)
    Check if lease has been broken
   Should provide all you need.

   You don't *need* to lock the directory to open an existing file and
   with my pending parallel-updates patch set, you only need a shared
   lock on the directory to create a file.  So I'd rather not be locking
   the directory at all to get a delegation

3/ When you vet the name you only do a lookup_one_len(), while
   nfsd_lookup_dentry() also calls nfsd_cross_mnt() as it is possible
   for a file to be mounted on.
   That means that if I did bind mount one file over another and export
   over NFSD, the file will never offer a delegation.
   This is a minor point, but I think it would be best to be as correct
   and consistent as possible.

Thanks for working on this!

NeilBrown

> 
> Jeff Layton (2):
>   nfsd: drop fh argument from alloc_init_deleg
>   nfsd: vet the opened dentry after setting a delegation
> 
>  fs/nfsd/nfs4state.c | 54 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 9 deletions(-)
> 
> -- 
> 2.36.1
> 
> 
