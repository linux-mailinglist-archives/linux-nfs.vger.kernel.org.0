Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0F879C486
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 06:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjILEIY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 00:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjILEIX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 00:08:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19300D7;
        Mon, 11 Sep 2023 21:08:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C4D7B1F8D7;
        Tue, 12 Sep 2023 04:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694491698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rh7F3S61PjrxqXKWwokxFxj2WiyskgmEmJI3rKq9O/A=;
        b=ogDJxf/HcVXEd6KH4AAO73Z/IGRdsCTGfQJBycEhJCwfTM490QNMuN0MvseKJsxnsydan+
        EksUr3Rt6ZrKnjlBlVbaKlZRQlSDLNiOWvM+ZDSikNu9lYeWnkFEpqPqHMmNPJUCc/Ags8
        w7JLVgCRgvBBTz22Pi/vGusaE9D4L9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694491698;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rh7F3S61PjrxqXKWwokxFxj2WiyskgmEmJI3rKq9O/A=;
        b=KM/KTuQQ/RGpqVzCaLGlPqWvAGJ716DHv2tU5kO0pqn02AWFWjlQEfVHoPsIKjIuY76bi2
        ZvpijTabfJ8LeLDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E8B413A2E;
        Tue, 12 Sep 2023 04:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V8qvBC/k/2QgJgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 12 Sep 2023 04:08:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Kees Cook" <kees@kernel.org>
Cc:     "Chuck Lever" <cel@kernel.org>, linux-nfs@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "David Gow" <davidgow@google.com>, linux-kernel@vger.kernel.org,
        "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 11/17] lib: add light-weight queuing mechanism.
In-reply-to: <0D0F3EEB-B837-4C65-95BF-99ACF3169206@kernel.org>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>,
 <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>,
 <0D0F3EEB-B837-4C65-95BF-99ACF3169206@kernel.org>
Date:   Tue, 12 Sep 2023 14:08:11 +1000
Message-id: <169449169186.22106.13281613238195902818@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 12 Sep 2023, Kees Cook wrote:
> On September 11, 2023 7:39:43 AM PDT, Chuck Lever <cel@kernel.org> wrote:
> >From: NeilBrown <neilb@suse.de>
> > [...]
> > Does not use kunit framework.
> 
> Any reason why not? It seems like it'd be well suited to it...

A quick look didn't suggest that using Kunit would make my task any
easier.  It seemed to require a lot of boiler plate for little gain.
Maybe that was unfair - I didn't spend long looking.
Partly, I put that comment in the commit message so that if one wanted
to try to change my mind - there was a prompt for them to do it.

Also I had a quick look at other test code in lib/ and it all seemed to
use the "run some code at boot time" approach.

So if anyone can make a clear argument why using Kunit will help me, or
will help someone else, I'll consider it.  But I cannot see the
motivation without help.

Thanks,
NeilBrown
