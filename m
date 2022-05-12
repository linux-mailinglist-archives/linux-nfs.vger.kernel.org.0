Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD26E525088
	for <lists+linux-nfs@lfdr.de>; Thu, 12 May 2022 16:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355160AbiELOq4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 May 2022 10:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355547AbiELOqz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 May 2022 10:46:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8AB31DF1
        for <linux-nfs@vger.kernel.org>; Thu, 12 May 2022 07:46:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EDC7521B78;
        Thu, 12 May 2022 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652366812;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F/ljP6CGooMeCqYwmHQLxJxLLKHZ4lezYNMzCYo+tZ8=;
        b=IZ0xzEZXwDjfd6dXhRw7yaic5FsrdosFhMvo7sagFYw4PT6Q0JxZh43uikVm+qJZZ0m5nv
        bPwWNmqiF2j7RalZrCia/2klstRynnZZAoPnoPHxsx5BpuQzQuzAs/NHCVIYfal4LGEMJF
        TcW5isJx+6iEqTCAFvfu2Q93i0G9qEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652366812;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F/ljP6CGooMeCqYwmHQLxJxLLKHZ4lezYNMzCYo+tZ8=;
        b=V09bQHp9KE0w8KHUf2o2ftE3LWM8MZktn4url8j/AVzLcNI7s7v62OgoTWuJ3fu7c4figJ
        ZC0IRWLAnFoq61DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C515713ABE;
        Thu, 12 May 2022 14:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6uCNLtsdfWKmXAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 12 May 2022 14:46:51 +0000
Date:   Thu, 12 May 2022 16:46:49 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, Steve Dickson <steved@redhat.com>,
        libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        automated-testing@yoctoproject.org, Li Wang <liwang@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Daniel D??az <daniel.diaz@linaro.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: Re: [RFC PATCH 0/3] Remove RPC rup and rusers tests
Message-ID: <Yn0d2bVppx36Nwv5@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220428144308.32639-1-pvorel@suse.cz>
 <Yn0bxyweYWKgY8SB@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn0bxyweYWKgY8SB@yuki>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Cyril,

> Hi!
> Looks like rstatd wasn't included in distributions to begin with, so
> there is no point to keep tests for it.

> https://bugs.gentoo.org/show_bug.cgi?id=115806
> https://access.redhat.com/solutions/34127
> https://www.ibm.com/support/pages/rstatd-not-installed-or-distributed-suse-linux-enterprise-server-10

Thanks for the links.
FYI Debian has had it for a long time in rstatd package:
https://packages.debian.org/search?suite=default&section=all&arch=any&searchon=contents&keywords=rstatd
https://packages.debian.org/bullseye/rstatd
https://tracker.debian.org/pkg/rstatd

but that IMHO no reason to keep these tests.

Kind regards,
Petr

