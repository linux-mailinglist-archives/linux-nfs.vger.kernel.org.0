Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1074E5F4C6B
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 01:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiJDXGq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Oct 2022 19:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiJDXGX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Oct 2022 19:06:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E56727B33
        for <linux-nfs@vger.kernel.org>; Tue,  4 Oct 2022 16:06:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C04E218E8;
        Tue,  4 Oct 2022 23:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664924774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZI6xtemsVCF5yBriFGUIYAln0eHjioIoffaHM8ZfFI=;
        b=WdEbhFEWoRdMf0TcXjTvMZQPfNwj8yvWkdjSankNnMdi3lWvydyxOJj28hFC+EsAaBFk3U
        E+hrOxYFSaXmmF+K2jVkql+a7/YCUsnPfR5j5+jRqxfU5afZYryYwoOr/MEoY5rcLlHN0l
        Q99RWASzus/prR4Xs9bvUZiN5Tml6nA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664924774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZI6xtemsVCF5yBriFGUIYAln0eHjioIoffaHM8ZfFI=;
        b=HrFAUpz2TJDTvRtPlyELnwzEdcdPw0N88pej3WFOrw30ztUdpw6mL9ykW7nF8Z43S32eNi
        MvZp3OmF/m5w/IAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64778139D2;
        Tue,  4 Oct 2022 23:06:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lxqsB2W8PGN6NwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 04 Oct 2022 23:06:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3] nfsd: rework hashtable handling in nfsd_do_file_acquire
In-reply-to: <4FF85113-6F17-4F3C-AD31-E2472A988618@oracle.com>
References: <20221003113436.24161-1-jlayton@kernel.org>,
 <F4DF35B2-CE11-4BD9-8442-97852F57CE2E@oracle.com>,
 <166483484979.14457.9448463531121052564@noble.neil.brown.name>,
 <4FF85113-6F17-4F3C-AD31-E2472A988618@oracle.com>
Date:   Wed, 05 Oct 2022 10:06:07 +1100
Message-id: <166492476800.14457.10230243127842792324@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 05 Oct 2022, Chuck Lever III wrote:
> 
> > On Oct 3, 2022, at 6:07 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Tue, 04 Oct 2022, Chuck Lever III wrote:
> >> 
> >>> On Oct 3, 2022, at 7:34 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >>> 
> >>> nfsd_file is RCU-freed, so we need to hold the rcu_read_lock long enough
> >>> to get a reference after finding it in the hash. Take the
> >>> rcu_read_lock() and call rhashtable_lookup directly.
> >>> 
> >>> Switch to using rhashtable_lookup_insert_key as well, and use the usual
> >>> retry mechanism if we hit an -EEXIST. Eliminiate the insert_err goto
> >>> target as well.
> >> 
> >> The insert_err goto is there to remove a very rare case from
> >> the hot path. I'd kinda like to keep that feature of this code.
> > 
> > ????
> > The fast path in the new code looks quite clean - what concerns you?
> > Maybe a "likely()" annotation can be used to encourage the compiler to
> > optimise for the non-error path so the error-handling gets moved
> > out-of-line (assuming it isn't already), but don't think the new code
> > needs that goto.
> 
> It's an instruction cache footprint issue.
> 
> A CPU populates its instruction cache by reading instructions from
> memory in bulk (some multiple of the size of the cacheline). I
> would like to keep the instructions involved with very rare cases
> (like this one) out-of-line so they do not clutter the CPU's
> instruction cache.
> 
> Unfortunately the compiler on my system has decided to place this
> snippet of code right before the out_status: label, which defeats
> my intention.

Don't you hate that!!!!

On the unpatched code, if I put a "likely" annotation on the assumed
common case:

	if (likely(!nf)) {
		nf = new;
		goto open_file;
	}

then the open_file code is placed immediately after the
rhashtable_lookup_get_insert_key().

This supports my suggestion that likely/unlikely annotations are better
at controlling code placement than source-code placement.

I've thought for a while that those annotations should be
optimise_for() and optimise_against() or similar.  That is what is being
requested.

NeilBrown
