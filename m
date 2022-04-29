Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CA351436D
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 09:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346373AbiD2HwD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiD2HwC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 03:52:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D404AAB57
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 00:48:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC3741F37F;
        Fri, 29 Apr 2022 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651218520;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kmzcTIOXw3cIEMjBNZWqp9NjL+G0URw+pZ1cHZCGDIs=;
        b=CCtb921Bw0lqUu2QLM0pHl6SPVaofOB7WeMWqd52Ocy/TnEYvEgYmwNMOrwzdwVrsMnd57
        8gHN2Z/EhC+o+57u0Bx5/KKusj+YqRMt2B3npqCK+6u2qw7bBRBXZQaSQ4iBowwhueeg9w
        WU6zISGPr8d6SiISeL+ycb8fQMNC+r4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651218520;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kmzcTIOXw3cIEMjBNZWqp9NjL+G0URw+pZ1cHZCGDIs=;
        b=ZnVxemIoSLBKdTRoYOUGgrFkB8jDWfklibp2/KgM9sP+7stNIWJ9F3HW5Lh80OgnexLE13
        BCWLVTQxsUB/U7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 693F213AE0;
        Fri, 29 Apr 2022 07:48:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0r/nF1iYa2JdUAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 29 Apr 2022 07:48:40 +0000
Date:   Fri, 29 Apr 2022 09:48:38 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Steve Dickson <steved@redhat.com>,
        libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        Cyril Hrubis <chrubis@suse.cz>,
        automated-testing@lists.yoctoproject.org,
        Li Wang <liwang@redhat.com>, Jan Stancek <jstancek@redhat.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Daniel =?iso-8859-2?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: Re: [RFC PATCH 0/3] Remove RPC rup and rusers tests
Message-ID: <YmuYVtvPWxYarLEF@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220428144308.32639-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428144308.32639-1-pvorel@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

I'm sorry, I again used the old mail address of automated-testing ML.
Please have look at this patchset:

https://lore.kernel.org/ltp/20220428144308.32639-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/list/?series=297407&state=*

Kind regards,
Petr

> Hi all,

> IMHO safe to remove these two tests, but sending to broad audience in
> case anybody really want to have these 2 kept (they'd be rewritten to
> new LTP shell API).

> BTW in long term I'd prefer to remove all RPC tests
> (testcases/network/rpc/ directory). IMHO they should be part of libtirpc
> (which has no tests), but these tests are old, messy and I'm not sure
> how relevant they are nowadays.

> Kind regards,
> Petr

> Petr Vorel (3):
>   rpc: Remove rup01.sh test
>   rpc: Remove rusers01.sh test
>   rpc: Move rest of RPC tests to runtest/net.rpc_tests

>  runtest/net.rpc                               |  8 ---
>  runtest/net.rpc_tests                         |  3 ++
>  scenario_groups/network                       |  1 -
>  .../network/rpc/basic_tests/rup/Makefile      | 29 -----------
>  .../network/rpc/basic_tests/rup/rup01.sh      | 50 -------------------
>  .../network/rpc/basic_tests/rusers/Makefile   | 29 -----------
>  .../rpc/basic_tests/rusers/rusers01.sh        | 50 -------------------
>  testscripts/network.sh                        |  4 +-
>  8 files changed, 4 insertions(+), 170 deletions(-)
>  delete mode 100644 runtest/net.rpc
>  delete mode 100644 testcases/network/rpc/basic_tests/rup/Makefile
>  delete mode 100755 testcases/network/rpc/basic_tests/rup/rup01.sh
>  delete mode 100644 testcases/network/rpc/basic_tests/rusers/Makefile
>  delete mode 100755 testcases/network/rpc/basic_tests/rusers/rusers01.sh
