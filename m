Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2BB790F4C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Sep 2023 01:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbjICX5a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 3 Sep 2023 19:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbjICX53 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 3 Sep 2023 19:57:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F109AC4
        for <linux-nfs@vger.kernel.org>; Sun,  3 Sep 2023 16:57:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AAC2E1F37E;
        Sun,  3 Sep 2023 23:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693785444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDb9dKw2xucCAaJKQcLT6rx5yXErRDek4eb5FNIkiE8=;
        b=Cjz5l/a+kYv+l4GKKi3ponujL4Roms8NmkzpjQPr+VK5OfqMH5/Wd74kBEEws2q6/njJqb
        M5JvWdZjGbD+fiSnUMp2Dwp/sb4h1j6hQrb0Sjc6/Q2BuWEwrscn24+jfO2mWK3IoXvshh
        8rPADlqS2t8y4ARNgUXeh4vOmwlZGKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693785444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDb9dKw2xucCAaJKQcLT6rx5yXErRDek4eb5FNIkiE8=;
        b=I/yOMYzYhWrzhUoawXTykIR/K+K9JSjyqoFOXd8wtDRDdGhNiVPauaDHzcLPJcYjBbeeUf
        5ytFjs4Q35W3fPAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68B1E13413;
        Sun,  3 Sep 2023 23:57:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4qEYB2Md9WSoLwAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 03 Sep 2023 23:57:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 05/10] lib: add light-weight queuing mechanism.
In-reply-to: <ZO9ek4UI8sNETSdr@tissot.1015granger.net>
References: <20230830025755.21292-1-neilb@suse.de>,
 <20230830025755.21292-6-neilb@suse.de>,
 <ZO9ek4UI8sNETSdr@tissot.1015granger.net>
Date:   Mon, 04 Sep 2023 09:57:20 +1000
Message-id: <169378544013.27865.12349454505654498043@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 31 Aug 2023, Chuck Lever wrote:
> On Wed, Aug 30, 2023 at 12:54:48PM +1000, NeilBrown wrote:
> > lwq is a FIFO single-linked queue that only requires a spinlock
> > for dequeueing, which happens in process context.  Enqueueing is atomic
> > with no spinlock and can happen in any context.
> >=20
> > Include a unit test for basic functionality - runs at boot time.  Does
> > not use kunit framework.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  include/linux/lwq.h | 120 +++++++++++++++++++++++++++++++++++
> >  lib/Kconfig         |   5 ++
> >  lib/Makefile        |   2 +-
> >  lib/lwq.c           | 149 ++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 275 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/lwq.h
> >  create mode 100644 lib/lwq.c
>=20
> I've applied and/or squashed the previous four and pushed.

Thanks.

>=20
> I don't have any specific complaints on this one, but checkpatch
> throws about 20 warnings. Some of those you might want to deal with
> or just ignore. Up to you, but I'll hold off on applying it until I
> hear from you.

There are 5 "Avoid logging continuation" warnings that I cannot avoid.
11 "Prefer FOO_{cont,info}(..) to printk" warnings that I don't think
are relevant.  There is no "FOO" that is appropriate, and other testing
code just uses printk.
There is one "added file - does MAINTAINERS need updating?" warning.
I don't know that we need a MAINTAINER for each little lib file (??)
There is one "write a better help paragraph" warning, but I cannot
think of anything useful to add,
And 2 "memory barrier without comment" warnings where there *is* a
comment, but it is one line to far away.

So I don't want to fix any of those warnings. - thanks.

>=20
> Also, I'm trying to collect a set of potential reviewers for it:
>=20
> [cel@bazille even-releases]$ scripts/get_maintainer.pl lib/
> Andrew Morton <akpm@linux-foundation.org> (commit_signer:206/523=3D39%)
> "Liam R. Howlett" <Liam.Howlett@oracle.com> (commit_signer:89/523=3D17%,aut=
hored:61/523=3D12%)
> Kees Cook <keescook@chromium.org> (commit_signer:48/523=3D9%)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:48/523=3D9%)
> David Gow <davidgow@google.com> (commit_signer:43/523=3D8%)
> linux-kernel@vger.kernel.org (open list)
> [cel@bazille even-releases]$
>=20
> Is that a reasonable set to add as Cc's?

It would be hard to do better.  I had a look at history and it is mostly
drive-by stuff.  A few have been funnelled through Andrew Morton because
he is willing to take most things that don't have any other home.
I doubt we'll get good review - but I've been surprised before.

Thanks,
NeilBrown
