Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCFA659A2B
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Dec 2022 16:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiL3PsI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Dec 2022 10:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3PsG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Dec 2022 10:48:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92B218B31
        for <linux-nfs@vger.kernel.org>; Fri, 30 Dec 2022 07:48:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5540760CEC
        for <linux-nfs@vger.kernel.org>; Fri, 30 Dec 2022 15:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA720C433EF;
        Fri, 30 Dec 2022 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672415284;
        bh=mjL5p1vFL0moWx0sUTSzX4ixvdtZBDNznPIFQZPmVWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DN+9yV61ICKYtblP2me9u84nxfhZH5t585XdYAeaP+Vs22nDvhkYVZhrLlb0Qz1Tf
         803g1ubw/uyYQWyUClbcntEHnDMRt8EDZQ1RFMYQDiSYmnt00U2AysL85ThnWx1865
         o+PEaNHLA85DDflS2ra0vq9I/YURYz31ZwG3FVl2bQNd3IEd+jexaumLzQ6ZfcmuyQ
         lea8iiSGb/BYIyDPsDoxSrQwwqRrfYMeDCYHv97ExXcaw9ANPxPL4WsVIWDuQoGQdH
         kAKdIQPAXU/Zg+ww4CXHSUJD1L5YvToPLdxEn7nmrm7BPNBG0Qjd9UK/WfXhOH7R8I
         Mkx+TftdU3bHg==
Date:   Fri, 30 Dec 2022 16:48:00 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "cuiyue-fnst@fujitsu.com" <cuiyue-fnst@fujitsu.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: nfs setgid inheritance test
Message-ID: <20221230154800.pt3hkfzmkmmmtuq7@wittgenstein>
References: <OS0PR01MB64337F9E0954384995085EFDE3F09@OS0PR01MB6433.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OS0PR01MB64337F9E0954384995085EFDE3F09@OS0PR01MB6433.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 30, 2022 at 11:11:56AM +0000, cuiyue-fnst@fujitsu.com wrote:
> Hi, Christian
> 
> When I test xfstests on NFS(with no_root_squash), generic/633 fails like this:
> 
> generic/633       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/633.out.bad)
>     --- tests/generic/633.out     2022-11-23 09:13:48.919484895 -0500
>     +++ /var/lib/xfstests/results//generic/633.out.bad   2022-11-24 05:53:40.836484895 -0500
>     @@ -1,2 +1,4 @@
>      QA output created by 633
>      Silence is golden
>     +vfstest.c: 1642: setgid_create - Success - failure: is_setgid
>     +vfstest.c: 1882: run_test - Operation not supported - failure: create operations in directories with setgid bit set
>     ...
>     (Run 'diff -u /var/lib/xfstests/tests/generic/633.out /var/lib/xfstests/results//generic/633.out.bad'  to see the entire diff)
> 
> We have reported this problem on Feburary.
> https://lore.kernel.org/linux-nfs/OS3PR01MB770539462BE3E7959DAF8B5789389@OS3PR01MB7705.jpnprd01.prod.outlook.com/T/#u
> 
> At that time, the conclusion is NFS should skip this test.
> But I cannot find this patch in the latest xfstests.
> Does NFS still need to skip this test now?

Afaict, nothing has changed and the test should still be skipped.
I'm not sure I ever send a patch to skip this test specifically for nfs
though. I might just not have gotten around to that.

Can you please also send the exact steps for reproducing this issue?
