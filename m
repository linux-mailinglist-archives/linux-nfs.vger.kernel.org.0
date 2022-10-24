Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF46260981C
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 04:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJXCHk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Oct 2022 22:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJXCHk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Oct 2022 22:07:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2196FA31
        for <linux-nfs@vger.kernel.org>; Sun, 23 Oct 2022 19:07:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D39DD2199A;
        Mon, 24 Oct 2022 02:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666577255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufJrwSckxs7bbC2kzHtfl61ywrGTI4JvCYYQP+dprA0=;
        b=UyH37NuGY54PosnTlkmi/gga3y3azHZzXGEMeMqhvqeTD+U9Y7tzk8gesZh9j/CmBrHt/i
        ZBMOsqEmcAKtbkOfjst9MiwFZ+9BBC02AAMXu9S60PYOEw5LQmO5wDiQw/yMePKEF5Tqdl
        CBB4TAmMqFVlqHxTvDxljwUtoHEU2nI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666577255;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufJrwSckxs7bbC2kzHtfl61ywrGTI4JvCYYQP+dprA0=;
        b=UfyluQGVzkfIv9QHyJSibZe8oE4mo2ajDXX/AKGM6CxNhbUx9fJlHkK1pl+UCPLq+S03pB
        abPMfgAfHRroUFDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2B7913357;
        Mon, 24 Oct 2022 02:07:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rB5fFmbzVWPTLgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Oct 2022 02:07:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@poochiereds.net>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] NFSD: Use rhashtable for managing nfs4_file objects
In-reply-to: <1DE04392-E8C9-4D39-BF23-BD1A59DB4FE3@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>,
 <166612313084.1291.5764156173845222109.stgit@manet.1015granger.net>,
 <cdad5af44b1c62c8e2ceae27cb2b646f7b2ec0bd.camel@poochiereds.net>,
 <1DE04392-E8C9-4D39-BF23-BD1A59DB4FE3@oracle.com>
Date:   Mon, 24 Oct 2022 13:07:10 +1100
Message-id: <166657723034.12462.8422170607830380805@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 20 Oct 2022, Chuck Lever III wrote:
> 
> > On Oct 19, 2022, at 7:39 AM, Jeff Layton <jlayton@poochiereds.net> wrote:
> > 
> >> -	fp = find_or_add_file(open->op_file, current_fh);
> >> +	rcu_read_lock();
> >> +	fp = insert_nfs4_file(open->op_file, current_fh);
> >> +	rcu_read_unlock();
> > 
> > It'd probably be better to push this rcu_read_lock down into
> > insert_nfs4_file. You don't need to hold it over the actual insertion,
> > since that requires the state_lock.
> 
> I used this arrangement because:
> 
> insert_nfs4_file() invokes only find_nfs4_file() and the
> insert_file() helper. Both find_nfs4_file() and the
> insert_file() helper invoke rhltable_lookup(), which
> must be called with the RCU read lock held.
> 
> And this is the reason why put_nfs4_file() no longer takes
> the state_lock: it would take the state_lock first and
> then the RCU read lock (which is implicitly taken in
> rhltable_remove()), which results in a lock inversion
> relative to insert_nfs4_file(), which takes the RCU read
> lock first, then the state_lock.

It doesn't make any sense to talk about lock inversion with
rcu_read_lock().  It isn't really a lock in any traditional sense in
that it can never block (which is what cause lock-inversion problems).
I prefer to think for rcu_read_lock() as taking a reference on some
global state.

> 
> 
> I'm certainly not an expert, so I'm willing to listen to
> alternative approaches. Can we rely on only the RCU read
> lock for exclusion on hash insertion?

Probably we can.  I'll read through all the patches now and provide some
review.

NeilBrown

