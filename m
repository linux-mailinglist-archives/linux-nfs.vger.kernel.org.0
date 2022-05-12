Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A6C525039
	for <lists+linux-nfs@lfdr.de>; Thu, 12 May 2022 16:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355149AbiELOfw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 May 2022 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355391AbiELOfu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 May 2022 10:35:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF422BCE
        for <linux-nfs@vger.kernel.org>; Thu, 12 May 2022 07:35:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 181B621B57;
        Thu, 12 May 2022 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652366146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SsXS3qPPAsS+aLUE42n2KTk/EFaibSTdM3Xf/eGrFW0=;
        b=LuSzqyq6jO4ohBEz6LxDUiTKl1lrOu+lN/XJ5CnW+cJT1SDFgh86JbKI35CMDrv4R/5LlC
        ws9+Y9+0pLrQf4zjh8/sEEVfzkTHVzYZ3EoJCYj3Klm5vHyI/qeG81eGR+OUuk6FujgOga
        dyDOyb10PvtCSDFGNvkXai3+i1seAd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652366146;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SsXS3qPPAsS+aLUE42n2KTk/EFaibSTdM3Xf/eGrFW0=;
        b=7hf10TAV/m1/x4IaH7OdUuLXz6Oplxmu/BSH1wWi80+vB5M0gaS9yckIYVDOx+ItBlcMM0
        mQUNzrV9piUidUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6A5013A84;
        Thu, 12 May 2022 14:35:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZwHcMkEbfWJgVwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 14:35:45 +0000
Date:   Thu, 12 May 2022 16:37:59 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
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
Message-ID: <Yn0bxyweYWKgY8SB@yuki>
References: <20220428144308.32639-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428144308.32639-1-pvorel@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!
Looks like rstatd wasn't included in distributions to begin with, so
there is no point to keep tests for it.

https://bugs.gentoo.org/show_bug.cgi?id=115806
https://access.redhat.com/solutions/34127
https://www.ibm.com/support/pages/rstatd-not-installed-or-distributed-suse-linux-enterprise-server-10

-- 
Cyril Hrubis
chrubis@suse.cz
