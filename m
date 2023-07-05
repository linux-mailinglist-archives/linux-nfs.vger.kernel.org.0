Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB2C747ABF
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jul 2023 02:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjGEAff (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jul 2023 20:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGEAfe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jul 2023 20:35:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AD81B6
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 17:35:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A232222036;
        Wed,  5 Jul 2023 00:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688517332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4bh3vL9M5RCyjxh1iBV8FJydm9uzIJX6V8UIb22jq8=;
        b=RNxi83o1Wo6Iq574w6384s+R6GC84eiKO3Qeb/+r18NuILIxO8qjGaVCEVT2pNmsLRX4BE
        xg6gbFVxtphp2qR+C8PEhlXraQge/jmCr58qEeu/Wqz6y+G/uV+kf0riSI9ztGq4j7npVY
        nbBH1l4vvgolUK2FLukO0dmXT1eEuSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688517332;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4bh3vL9M5RCyjxh1iBV8FJydm9uzIJX6V8UIb22jq8=;
        b=8qV3p2SLyCinDqJGarzREhhPpV2/4k6UjluO7eQRHSKYRlPtGlOVEtMRKGLmmLlecsUlOw
        LjrZ14nrVXIKyvDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75231134F3;
        Wed,  5 Jul 2023 00:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wQ40CtK6pGR2CAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 05 Jul 2023 00:35:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Chuck Lever" <cel@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Lorenzo Bianconi" <lorenzo@kernel.org>,
        "Jeff Layton" <jlayton@redhat.com>,
        "Dave Chinner" <david@fromorbit.com>
Subject: Re: [PATCH v2 9/9] SUNRPC: Convert RQ_BUSY into a per-pool bitmap
In-reply-to: <FB2463CA-5D78-4B59-8038-E5F45FF9304B@oracle.com>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>,
 <168842930872.139194.10164846167275218299.stgit@manet.1015granger.net>,
 <168843398253.8939.16982425023664424215@noble.neil.brown.name>,
 <ZKN9xmRn+EN/TQwY@manet.1015granger.net>,
 <FB2463CA-5D78-4B59-8038-E5F45FF9304B@oracle.com>
Date:   Wed, 05 Jul 2023 10:35:27 +1000
Message-id: <168851732726.8939.10301524975411010085@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 05 Jul 2023, Chuck Lever III wrote:
> > On Jul 3, 2023, at 10:02 PM, Chuck Lever <cel@kernel.org> wrote:
> > 
> > On Tue, Jul 04, 2023 at 11:26:22AM +1000, NeilBrown wrote:
> >> On Tue, 04 Jul 2023, Chuck Lever wrote:
> >>> From: Chuck Lever <chuck.lever@oracle.com>
> >>> 
> >>> I've noticed that client-observed server request latency goes up
> >>> simply when the nfsd thread count is increased.
> >>> 
> >>> List walking is known to be memory-inefficient. On a busy server
> >>> with many threads, enqueuing a transport will walk the "all threads"
> >>> list quite frequently. This also pulls in the cache lines for some
> >>> hot fields in each svc_rqst (namely, rq_flags).
> >> 
> >> I think this text could usefully be re-written.  By this point in the
> >> series we aren't list walking.
> >> 
> >> I'd also be curious to know what latency different you get for just this
> >> change.
> > 
> > Not much of a latency difference at lower thread counts.
> > 
> > The difference I notice is that with the spinlock version of
> > pool_wake_idle_thread, there is significant lock contention as
> > the thread count increases, and the throughput result of my fio
> > test is lower (outside the result variance).
> 
> I mis-spoke. When I wrote this yesterday I had compared only the
> "xarray with bitmap" and the "xarray with spinlock" mechanisms.
> I had not tried "xarray only".
> 
> Today, while testing review-related fixes, I benchmarked "xarray
> only". It behaves like the linked-list implementation it replaces:
> performance degrades with anything more than a couple dozen threads
> in the pool.

I'm a little surprised it is that bad, but only a little.
The above is good text to include in the justification of that last
patch.

Thanks for the clarification.
NeilBrown
