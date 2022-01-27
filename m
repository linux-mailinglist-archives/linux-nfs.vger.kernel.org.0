Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B849D6C1
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 01:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiA0AcL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 19:32:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47348 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiA0AcK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 19:32:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5B74621114;
        Thu, 27 Jan 2022 00:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643243529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iullOb3Z+e2T0lhh1xDMAxJ/4/RT+jyxcMAIPZ1IZgs=;
        b=NAgRhQEURd360hIYSbsXGGRw5yP1FfqvbZkytP6OOwl/Lm4Z/cpiscUnKxd/4sRC1mzdDL
        2/8+YKYaXacbg+jwvuMZdWs1iDNx/0FKAcc3ayUgvyZF0H1wzSztgUd7C15eW9EbxPzBe7
        yvee1bV+CHp2odSEGAgU8nJuve9ynNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643243529;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iullOb3Z+e2T0lhh1xDMAxJ/4/RT+jyxcMAIPZ1IZgs=;
        b=WbvBw4gQHJnfJGVuvuZtyXS9PxDOGDGLq5ACD7bBstqSyP57g3MNwJtAAzOA7DqCrafozf
        xtkWF4xr7luYMJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F112813E72;
        Thu, 27 Jan 2022 00:32:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JFZ0KgXo8WHqfQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Jan 2022 00:32:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Hugh Dickins" <hughd@google.com>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "David Howells" <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/23] MM: extend block-plugging to cover all swap reads
 with read-ahead
In-reply-to: <eeec206a-d255-a3e4-ec1e-e51a13e5118c@google.com>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>,
 <164299611274.26253.13900771841681128440.stgit@noble.brown>,
 <Ye5UzEzvN8WWMNBn@infradead.org>,
 <164323362698.5493.8309546969459514762@noble.neil.brown.name>,
 <eeec206a-d255-a3e4-ec1e-e51a13e5118c@google.com>
Date:   Thu, 27 Jan 2022 11:32:02 +1100
Message-id: <164324352246.5493.62203138362718756@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 27 Jan 2022, Hugh Dickins wrote:
> On Thu, 27 Jan 2022, NeilBrown wrote:
> > On Mon, 24 Jan 2022, Christoph Hellwig wrote:
> > > On Mon, Jan 24, 2022 at 02:48:32PM +1100, NeilBrown wrote:
> > > > Code that does swap read-ahead uses blk_start_plug() and
> > > > blk_finish_plug() to allow lower levels to combine multiple read-ahead
> > > > pages into a single request, but calls blk_finish_plug() *before*
> > > > submitting the original (non-ahead) read request.
> > > > This missed an opportunity to combine read requests.
> 
> No, you're misunderstanding there.  All the necessary reads are issued
> within the loop, between the plug and unplug: it does not skip over
> the target page in the loop, but issues its read along with the rest.
> 
> But it has not kept any of those pages locked, nor even kept any
> refcounts raised: so at the end has to look up the target page again
> with the final read_swap_cache_async() (which also copes with the
> highly unlikely case that the page got swapped out again meanwhile).
> 
....
> 
> I don't suppose your patch does any actual harm (beyond propagating a
> misunderstanding), but it's certainly not a fix, and I think should
> simply be dropped from the series.

Thanks - I had missed that.  The code is correct, but looks wrong (to
me).
I've dropped the patch, but added a comment when I add
"swap_read_unplug()" to explain while plugging isn't needed for that
final read_swap_cache_async().

> 
> (But please don't expect any comment from me on the rest:
> SWP_FS_OPS has always been beyond my understanding.)

:-)

Thanks,
NeilBrown
