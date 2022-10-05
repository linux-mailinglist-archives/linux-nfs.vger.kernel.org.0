Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41BC5F4D05
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 02:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJEAZT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Oct 2022 20:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJEAZR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Oct 2022 20:25:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84824286C3
        for <linux-nfs@vger.kernel.org>; Tue,  4 Oct 2022 17:25:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 061B92198D;
        Wed,  5 Oct 2022 00:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664929515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEK56S4R6zFvtBZQUS/XIh0EqRa6KE3zlRCByQiFSJE=;
        b=cnzLXBhC9VtlShOZS5kK+27os7IxI70uKH9+hI3+K4soFDW02732XNwKll7qVOI9OvRBJk
        XuPWiN/XTUINb5cVxzK4jPtpsu57ehkLiVX31bCfCzIlJipqYiaLp0Z/vKlLkL95sV5VbX
        8Ut4RiAsPjKPG/V7MrzQm3n+WKacmeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664929515;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEK56S4R6zFvtBZQUS/XIh0EqRa6KE3zlRCByQiFSJE=;
        b=A7WHbPiTaCvnLqB1e5s+nIHD72UnenkmSMR1hYO3FV5fvMVzc1lz2/KD0qGyIsJJmy4itU
        d+9vYGRSrYYeF5Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBC2C13345;
        Wed,  5 Oct 2022 00:25:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wOJfG+nOPGMSUQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 05 Oct 2022 00:25:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: nfsd: another possible delegation race
In-reply-to: <fb9c520e8bd9a034eeb10285c03dcf5cd6a660c9.camel@kernel.org>
References: <166486048770.14457.133971372966856907@noble.neil.brown.name>,
 <fb9c520e8bd9a034eeb10285c03dcf5cd6a660c9.camel@kernel.org>
Date:   Wed, 05 Oct 2022 11:25:09 +1100
Message-id: <166492950933.14457.10186344229031903354@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 04 Oct 2022, Jeff Layton wrote:
> On Tue, 2022-10-04 at 16:14 +1100, NeilBrown wrote:
> > Hi,
> >  I have a customer who experienced a crash in nfsd which appears to be
> >  related to delegation return.  I cannot completely rule-out
> >   Commit 548ec0805c39 ("nfsd: fix use-after-free due to delegation race")
...
> 
> Ok, so a DELEGRETURN is racing with a lease break?
> 

and that is exactly what the above mentioned commit fixes.  I now see
that it is the right fix for my problem as well.

Putting the delegation_hashed() check in nfsd_break_deleg_cb() doesn't
help because the problematic list-add to del_recall_lru doesn't happen
until later in a different thread, and so the nfs4_delegation could
still get unhashed before that thread adds it to the list.  The above
commit adds the protection at the right place.

Because being on ->del_recall_lru doesn't imply a reference, it is easy
for the delegation to be freed before the laundromat finds it on the
list.

As mentioned in my reply to Chuck, the refcount_inc() gives a "saturated"
error rather than a "use-after-free" error because when the delegation
was freed, slub (which SUSE uses) puts a pointer at the start of the
memory, which is exactly where the refcount is.  So it has a good chance
of becoming negative.

So my symptoms are now completely explained.  Thanks to both of you for
your help.

NeilBrown
