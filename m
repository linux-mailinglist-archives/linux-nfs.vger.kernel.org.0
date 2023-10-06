Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F8A7BB19F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Oct 2023 08:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjJFGlt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Oct 2023 02:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjJFGls (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Oct 2023 02:41:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E666EA;
        Thu,  5 Oct 2023 23:41:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B62D51F45F;
        Fri,  6 Oct 2023 06:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696574503;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHPegFj7wYRBnWo4iJfVnNBssSPMttVzktBNWxsaxJY=;
        b=RPqzfKv4gZGmUZdxYmP2RazsngprG/807/v2Of1+KBo5sUqo9JSFupq8mGvNz6LrSpyLHC
        qoqJVH8IWZF4iVQ7uGKPcp2MOF2HAqeK2AYYUXY0Nn57WS3JfpE/hSCm86/po3CzryejT2
        7T2n4g1+hMUPCYmGifNU1lOhdwZT6OE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696574503;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHPegFj7wYRBnWo4iJfVnNBssSPMttVzktBNWxsaxJY=;
        b=t5N6hNk50AuI+4qPPg4glFprLLTrJyOMPg25eEz33RGUSTueo0on1yxzZmg9dTdscRqq9O
        AZRSUM7ZJwsJjfDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4608913A2E;
        Fri,  6 Oct 2023 06:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2t+vCCasH2UZWgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 06 Oct 2023 06:41:42 +0000
Date:   Fri, 6 Oct 2023 08:41:40 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nfs@vger.kernel.org, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        LTP List <ltp@lists.linux.it>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Eryu Guan <eguan@redhat.com>, chrubis <chrubis@suse.cz>
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
Message-ID: <20231006064140.GA178316@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20231004175217.404851126@linuxfoundation.org>
 <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
 <20231005172448.GA161140@pevik>
 <CA+G9fYuyXgWvsRhznP2x2VE5CvSyCCgcvxPz2J=dbvg6YW2iUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuyXgWvsRhznP2x2VE5CvSyCCgcvxPz2J=dbvg6YW2iUA@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Thu, 5 Oct 2023 at 22:54, Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Naresh,

> > > On Wed, 4 Oct 2023 at 23:41, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:

> > > > This is the start of the stable review cycle for the 6.1.56 release.
> > > > There are 259 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.

> > > > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > > > Anything received after that time might be too late.

> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.56-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > > and the diffstat can be found below.

> > > > thanks,

> > > > greg k-h

> > > Results from Linaro’s test farm.
> > > Regressions on arm64 bcm2711-rpi-4-b device running LTP dio tests on
> > Could you please note in your reports also LTP version?

> Sure.
> We are running LTP Version: 20230516 for our testing.

> We will update the latest LTP release (20230929) next week.

Great, thank you.

> > FYI the best LTP release is always the latest release or git master branch.

> We have two threads here.
> 1) LTP release tag testing on all stable-rc branches
> 2) LTP master testing on a given specific kernel version [a]

Great, this makes sense.

BTW from looking in the log [b] ("INFO: ltp-pan reported some tests FAIL")
I see you use runltp. We recommend to switch to kirk [c]. And we definitely
appreciate your feedback from it.

Kind regards,
Petr

> [a] https://qa-reports.linaro.org/lkft/ltp-master/
[b] https://qa-reports.linaro.org/lkft/ltp-master/build/v6.5.3_20230929-2-g48a150bfd/testrun/20223790/suite/ltp-cve/test/cve-2017-8890/log
[c] https://github.com/linux-test-project/kirk/#readme

> - Naresh
