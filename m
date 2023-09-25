Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709CA7AE1AD
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Sep 2023 00:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjIYW2y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 18:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjIYW2x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 18:28:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB599C
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 15:28:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44EC421845;
        Mon, 25 Sep 2023 22:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695680925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1YTh2ZbvDc6Qaz3c3+oIaLCAPA8I4bw0FSvGIQ0Pkk=;
        b=SJdqB8eIXX8i35rtmATrXgJDqSht4IX+Bym6RGUyt03KJHDgMzyVqCp73dPy0X1oAF+x8O
        FYsImHUKxIsvh6SPx5kHJJUdGxltz1zIEPvrYnjSL87J2GvPcwt82zZjwBqZWtLLO2CsRM
        b6XSzn8SgihGkdcvNCacYIcTHxf0tkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695680925;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1YTh2ZbvDc6Qaz3c3+oIaLCAPA8I4bw0FSvGIQ0Pkk=;
        b=nDlknFPTm3qA0cTp0zzLoPcmjKjX0/1H51n/r3JRnNxG/gTjWjUUAV8Iqh3q5bRZHHUA5o
        jQ+KsL3sfsrezoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 771C613580;
        Mon, 25 Sep 2023 22:28:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id evbwC5sJEmWAFQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 25 Sep 2023 22:28:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "aglo@umich.edu" <aglo@umich.edu>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
Subject: Re: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock regression
In-reply-to: <077cb75b44afd2404629c1388a92ca61da5092b1.camel@hammerspace.com>
References: <20230917230551.30483-1-trondmy@kernel.org>,
 <20230917230551.30483-2-trondmy@kernel.org>,
 <CAFX2Jfn-6J1RAiz7Vjjet+EW4jDFVRcQ9ahsZVp69AW=MC5tpg@mail.gmail.com>,
 <9eda74d7438ee0a82323058b9d4c2b98f4e434cf.camel@hammerspace.com>,
 <CAN-5tyEvYBr-bqOeO2Umt2DVa_CkKxT8_2Zo8Q1mfa9RN9VxQg@mail.gmail.com>,
 <077cb75b44afd2404629c1388a92ca61da5092b1.camel@hammerspace.com>
Date:   Tue, 26 Sep 2023 08:28:39 +1000
Message-id: <169568091982.19404.4821745630158429694@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 23 Sep 2023, Trond Myklebust wrote:
> On Fri, 2023-09-22 at 13:22 -0400, Olga Kornievskaia wrote:
> > On Wed, Sep 20, 2023 at 8:27 PM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > > 
> > > On Wed, 2023-09-20 at 15:38 -0400, Anna Schumaker wrote:
> > > > Hi Trond,
> > > > 
> > > > On Sun, Sep 17, 2023 at 7:12 PM <trondmy@kernel.org> wrote:
> > > > > 
> > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > 
> > > > > Commit 4dc73c679114 reintroduces the deadlock that was fixed by
> > > > > commit
> > > > > aeabb3c96186 ("NFSv4: Fix a NFSv4 state manager deadlock")
> > > > > because
> > > > > it
> > > > > prevents the setup of new threads to handle reboot recovery,
> > > > > while
> > > > > the
> > > > > older recovery thread is stuck returning delegations.
> > > > 
> > > > I'm seeing a possible deadlock with xfstests generic/472 on NFS
> > > > v4.x
> > > > after applying this patch. The test itself checks for various
> > > > swapfile
> > > > edge cases, so it seems likely something is going on there.
> > > > 
> > > > Let me know if you need more info
> > > > Anna
> > > > 
> > > 
> > > Did you turn off delegations on your server? If you don't, then
> > > swap
> > > will deadlock itself under various scenarios.
> > 
> > Is there documentation somewhere that says that delegations must be
> > turned off on the server if NFS over swap is enabled?
> 
> I think the question is more generally "Is there documentation for NFS
> swap?"

The main difference between using NFS for swap and for regular file IO
is in the handling of writes, and particularly in the style of memory
allocation that is safe while handling a write request (or anything
which might block some write request, etc).

For buffered IO, memory allocations must be GFP_NOIO or PF_MEMALLOC_NOIO.
For swap-out, memory allocations must be GFP_MEMALLOC or PG_MEMALLOC.

That is the primary difference - all other differences are minor.  This
difference might justify documentation suggesting that 
/proc/sys/vm/min_free_kbytes could usefully be increased, but I don't
see that more is needed.

The NOIO/MEMALLOC distinction is properly plumbed through nfs, sunrpc,
and networking and all "just works".  The problem area is that
kthread_create() doesn't take a gfpflags_t argument, so it uses
GFP_KERNEL allocations to create the new thread.

This means that when a write cannot proceed without state management,
and state management requests that a threads be started, there is a risk
of memory allocation deadlock.
I believe the risk is there even for buffered IO, but I'm not 100%
certain and in practice I don't think a deadlock has ever been reported.
With swap-out it is fairly easy to trigger a deadlock if there is heavy
swap-out traffic when state management is needed.

The common pattern in the kernel when a thread might be needed to
support writeout is to keep the thread running permanently (rather than
to add a gfpflags_t to kthread_create), so that is what I added to the
nfsv4 state manager.

However the state manager thread has a second use - returning
delegations.  This sometimes needs to run concurrently with state
management, so one thread is not enough.

What is that context for delegation return?  Does it ever block writes? 
If it doesn't, would it make sense to use a work queue for returning
delegations - maybe system_wq?

I think it might be best to have the nfsv4 state manager thread always
be running whether swap is enabled or not.  As I say I think there is at
least a theoretical risk of a deadlock even without swap, and having a
small test matrix is usually a good thing.

Thanks,
NeilBrown
