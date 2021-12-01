Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A02B464497
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Dec 2021 02:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbhLABmQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Nov 2021 20:42:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59648 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhLABmP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Nov 2021 20:42:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 32A051FD34;
        Wed,  1 Dec 2021 01:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638322735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVW9VrPTjxfY2F1IktQ1VRd1IWba0hfInbTxN9DF5xI=;
        b=rkGOJFIYMjI5ah8DfWF/QAl84Ao0mV/UvnCHT3sS5yfPBMSlpSIN+VcAJK+HZ2gUSadtiZ
        CkY7Z1M6mlD+vJGSNENDAy88+f+Aje2RFEzpiZSJkTEFWEM0y7deOAppEO96XF0u7sMo04
        ixdRTWAxbqYuUuENmPO9G/asm6Md/J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638322735;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVW9VrPTjxfY2F1IktQ1VRd1IWba0hfInbTxN9DF5xI=;
        b=9qJGTkq4ZQnNabUZzHKBLjIr69eoMh9gPS+yd81WuxxqJzhc6x1o22FHeaWU5NXNDV66ni
        zKArrTOOOp0V1GBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4B6B13498;
        Wed,  1 Dec 2021 01:38:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I8xGHy3SpmEdNgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 01 Dec 2021 01:38:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: Fix RCU-related sparse splat
In-reply-to: <2ABC02B1-CE76-422A-B64F-64B108B12C0B@oracle.com>
References: <163821156142.90770.4019362941494014139.stgit@bazille.1015granger.net>,
 <20211130225250.GC641268@paulmck-ThinkPad-P17-Gen-1>,
 <163831537509.26075.12859361728901873347@noble.neil.brown.name>,
 <2ABC02B1-CE76-422A-B64F-64B108B12C0B@oracle.com>
Date:   Wed, 01 Dec 2021 12:38:50 +1100
Message-id: <163832273051.26075.5034720991945492453@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 01 Dec 2021, Chuck Lever III wrote:
> 
> By way of further explanation:
> 
> The Documentation/ for RCU (ie, "RCU for Dummies") suggests that
> rcu_assign_pointer() is adequate for preventing undesirable
> compiler optimizations or CPU load/store reordering.
> 
> rcu_assign_pointer() uses WRITE_ONCE for constants like NULL and
> smp_store_release() when assigning variable values. I copied the
> use of WRITE_ONCE() from rcu_assign_pointer(). So I expect exactly
> zero change in behavior or compiled code... (but I should have
> checked the generated object to verify that is the case).

True, there would be no change in behaviour - but we should at least ask
if that behaviour is correct, and why.

If any barriers are needed here, they would have to be between the
assignment of NULL here, and the tests of l->net in
   nfsd_file_list_add_disposal()
   nfsd_free_fcache_disposal_net()
(because they are the only places ->net is used)
The only conceivable race is that they will see a value in ->net "after"
NULL has been assigned.
If there were a race there, it would be between different cpus, so
 smp_store_relase() and smp_load_acquire()
would be the correct tools to avoid that race.

If, on the other hand, there is no chance of a race, then there is no
need to assign NULL to ->net at all.  I believe this is actually the
case.
As the 'net' is freed using kfree_rcu, there is no possibility for a
search that started before something was removed from the list to get a
false-positive when testing if l->net == net.

So while your change is safe from a behavioural perspective, I don't
think it is safe from a maintenance perspective because it leaves in
place code that doesn't really make sense, but removes the warning that
helps us to find that nonsense.

> 
> Sure. If it makes sense to use nfsd_net instead of a separate data
> structure, then that can be made to happen. I would like to hear
> from Trond regarding why he felt a separate data structure was
> necessary for fcache_disposal.

That would be best, yes.

Thanks,
NeilBrown
