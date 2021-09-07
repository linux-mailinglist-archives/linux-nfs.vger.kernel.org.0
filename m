Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C176A4021F0
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Sep 2021 04:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhIGAmp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Sep 2021 20:42:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38816 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhIGAmo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Sep 2021 20:42:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87CA5221A8;
        Tue,  7 Sep 2021 00:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630975298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OAW130kfzXgD7DFHMInOZ8+8a98c4xfyHi7BgBKUqgU=;
        b=bWYy2jvSlF8VGXcaTp8MW+t9c2IyTP7QH1gv7APg+XcKF18ORbDWm6Rv7bWcbrCSs394IL
        Bhf9FTlpsCW16bctC/OrTQKqbcEN7ara5Tgf4rXXqkwffmtf0rzuo09wrHsFh0Z12Gflrw
        gEs29ACgpY9G3nUDI5Q4KwTe+YLE0K0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630975298;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OAW130kfzXgD7DFHMInOZ8+8a98c4xfyHi7BgBKUqgU=;
        b=acWxfKIsn10FS691pHZ1KzL8IpyBAii4Ft8xw/pEqJcW2mV9mviIW5d9LNCVPBbXoZEJ8d
        VYYBFyX2IYWMhiAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC5A413C31;
        Tue,  7 Sep 2021 00:41:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EfhYGkC1NmGKbwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 07 Sep 2021 00:41:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Bruce Fields" <bfields@fieldses.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Mel Gorman" <mgorman@suse.com>, "Linux-MM" <linux-mm@kvack.org>
Subject: Re: [PATCH] SUNRPC: use congestion_wait() in svc_alloc_args()
In-reply-to: <163096695999.2518.10383290668057550257@noble.neil.brown.name>
References: <163090344807.19339.10071205771966144716@noble.neil.brown.name>,
 <848A6498-CFF3-4C66-AE83-959F8221E930@oracle.com>,
 <YTZ4E0Zh6F/WSpy0@casper.infradead.org>,
 <163096695999.2518.10383290668057550257@noble.neil.brown.name>
Date:   Tue, 07 Sep 2021 10:41:33 +1000
Message-id: <163097529362.2518.16697605173806213577@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 07 Sep 2021, NeilBrown wrote:
> Even if we just provided
> 
>  void reclaim_progress_wait(void)
>  {
>         schedule_timeout_uninterruptible(HZ/20);
>  }
> 
> that would be an improvement.

I contemplated providing a patch, but the more I thought about it, the
less sure I was.

When does a single-page GFP_KERNEL allocation fail?  Ever?

I know that if I add __GFP_NOFAIL then it won't fail and that is
preferred to looping.
I know that if I add __GFP_RETRY_MAILFAIL (or others) then it might
fail.
But that is the semantics for a plain GFP_KERNEL ??

I recall a suggestion one that it would only fail if the process was
being killed by the oom killer.  That seems reasonable and would suggest
that retrying is really bad.  Is that true?

For svc_alloc_args(), it might be better to fail and have the calling
server thread exit.  This would need to be combined with dynamic
thread-count management so that when a request arrived, a new thread
might be started.

So maybe we really don't want reclaim_progress_wait(), and all current
callers of congestion_wait() which are just waiting for allocation to
succeed should be either change to use __GFP_NOFAIL, or to handle
failure.
For the ext4_truncate case() that would be easier if there were a
PF_MEMALLOC_NOFAIL flag though maybe passing down __GFP_MNOFAIL isn't
too hard.

(this is why we all work-around problems in the platform rather than
 fixing them.  Fixing them is just too hard...)

NeilBrown
