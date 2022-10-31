Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5FE613E02
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 20:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJaTFo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 15:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJaTFn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 15:05:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99F563C2
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 12:05:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A67522C82;
        Mon, 31 Oct 2022 19:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667243138;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wXGmgo8wmVuY2OWn/RhzfVOf4dSTvTYsgWyE6GjGRVY=;
        b=u8oQ48Ql1+4I8I57qEpGGL80XjKj3uj9RWkyxrWb0WPKoxQdE5sPPqWYenGLNgRiQciVKB
        LjZd1bHoDA774SD/oobXBnamJSghUFs+BM2CdCwPjCOln3pgfTnW9RgcfXaTmXHdwsDGB7
        hMNPg5d1pe1Mbcw/GMNFGzg3e0FwwaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667243138;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wXGmgo8wmVuY2OWn/RhzfVOf4dSTvTYsgWyE6GjGRVY=;
        b=yi14Jan6oPtK6BXGEVKP8M8zOWb7ZmlcSPSwJF9lT4MHlnNYy5SEPqieUHqARG4TcJ6PkG
        t2mlsaq9wp+0h6DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02B5F13451;
        Mon, 31 Oct 2022 19:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BVQqNoEcYGM+BQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 31 Oct 2022 19:05:37 +0000
Date:   Mon, 31 Oct 2022 20:05:34 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: fix net-namespace logic in
 __nfsd_file_cache_purge
Message-ID: <Y2AcfsN3PvwfjRhA@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221031154921.500620-1-jlayton@kernel.org>
 <BCEEEF05-11E3-4E31-BDE1-DDCA65A5AB6F@oracle.com>
 <Y2AXrMEim07Y0LLY@pevik>
 <433f431a3684eb296a62f8f3cdbf34e185a5a84d.camel@kernel.org>
 <1E40B5C0-1E8A-4FBD-80FB-3432037F101D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1E40B5C0-1E8A-4FBD-80FB-3432037F101D@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> > On Oct 31, 2022, at 2:46 PM, Jeff Layton <jlayton@kernel.org> wrote:

> > On Mon, 2022-10-31 at 19:45 +0100, Petr Vorel wrote:

> >>>> On Oct 31, 2022, at 11:49 AM, Jeff Layton <jlayton@kernel.org> wrote:

> >>>> If the namespace doesn't match the one in "net", then we'll continue,
> >>>> but that doesn't cause another rhashtable_walk_next call, so it will
> >>>> loop infinitely.

> >>>> Fixes: ce502f81ba88 ("NFSD: Convert the filecache to use rhashtable")
> >>>> Reported-by: Petr Vorel <pvorel@suse.cz>
> >>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >>>> ---
> >>>> fs/nfsd/filecache.c | 5 ++---
> >>>> 1 file changed, 2 insertions(+), 3 deletions(-)

> >>> Thank you! Applied and pushed to for-rc. I'll send a PR in a few days.

> >> Thanks for a quick action!


> > No problem. 

> >> What a shame you didn't put link to the report, which contains reproducer.
> >> https://lore.kernel.org/ltp/Y1%2FP8gDAcWC%2F+VR3@pevik/

> >> Kind regards,
> >> Petr


> > Chuck, could you add that link to the changelog when you merge it?

> In progress, I'll push the update in a moment.

Thanks a lot!

Kind regards,
Petr



> > Thanks,
> > Jeff

> >>>> The v1 patch applies cleanly to v6.0, but not to Chuck's for-next
> >>>> branch. This one should be suitable there.
> >>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> >>>> index 98c6b5f51bc8..4a8aa7cd8354 100644
> >>>> --- a/fs/nfsd/filecache.c
> >>>> +++ b/fs/nfsd/filecache.c
> >>>> @@ -890,9 +890,8 @@ __nfsd_file_cache_purge(struct net *net)

> >>>> 		nf = rhashtable_walk_next(&iter);
> >>>> 		while (!IS_ERR_OR_NULL(nf)) {
> >>>> -			if (net && nf->nf_net != net)
> >>>> -				continue;
> >>>> -			nfsd_file_unhash_and_dispose(nf, &dispose);
> >>>> +			if (!net || nf->nf_net == net)
> >>>> +				nfsd_file_unhash_and_dispose(nf, &dispose);
> >>>> 			nf = rhashtable_walk_next(&iter);
> >>>> 		}

> >>>> -- 
> >>>> 2.38.1

> > -- 
> > Jeff Layton <jlayton@kernel.org>
