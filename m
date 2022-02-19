Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98974BC701
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Feb 2022 09:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbiBSI4I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Feb 2022 03:56:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiBSI4I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Feb 2022 03:56:08 -0500
X-Greylist: delayed 543 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Feb 2022 00:55:47 PST
Received: from eu-shark1.inbox.eu (eu-shark1.inbox.eu [195.216.236.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2D3C9926;
        Sat, 19 Feb 2022 00:55:47 -0800 (PST)
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 602A46C0073B;
        Sat, 19 Feb 2022 10:46:43 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1645260403; bh=x2IqM3rwY6UxdZw1mh9cnsrSbRnGQ1NRGSoumt9GeF8=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
         Content-Type:X-ESPOL:from:date:to:cc;
        b=qBRVp4O7j3qJBmnvMKrWgNfY/koP4YDle4CEUxIRVdPKMCbouznzYn7qULOmDDbYS
         W8EO9W+e8gXqSabjgfnrs++4IbEUKqNluvC9/VY0LNvLKEV8VA06cimLCfGNFrZ0W8
         LM1NxghciLzcQpHGs9UJ/+VfeRYSCXCKSR9Hhu2E=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 4FCC76C00736;
        Sat, 19 Feb 2022 10:46:43 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id Vmb7lF0202yH; Sat, 19 Feb 2022 10:46:43 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id E7FAA6C0073A;
        Sat, 19 Feb 2022 10:46:42 +0200 (EET)
References: <20220208215232.491780-1-anna@kernel.org>
 <20220208215232.491780-5-anna@kernel.org>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Anna Schumaker <anna@kernel.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/4] generic/633: Check if idmapped mounts are supported
 before running
Date:   Sat, 19 Feb 2022 16:40:09 +0800
In-reply-to: <20220208215232.491780-5-anna@kernel.org>
Message-ID: <wnhr451v.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWenZQs2rylXXenn5ea+0QNbnX/mQl2JBCgRI2663TM2UR7LszwX
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On Tue 08 Feb 2022 at 16:52, Anna Schumaker <anna@kernel.org> 
wrote:

> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
> This appears to have been missed when the test was added.
>
It's removed on purpose to also verify idmapped mounts unrelated 
tests.

Generic/633 fails on NFS because of setgid inheritance behavior of 
NFS.
Already reported it to the community[1].

[1]: 
https://lore.kernel.org/linux-nfs/OS3PR01MB770539462BE3E7959DAF8B5789389@OS3PR01MB7705.jpnprd01.prod.outlook.com/T/#u

--
Su
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  tests/generic/633 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/generic/633 b/tests/generic/633
> index 382806471223..6750117735f7 100755
> --- a/tests/generic/633
> +++ b/tests/generic/633
> @@ -15,6 +15,7 @@ _begin_fstest auto quick atime attr cap 
> idmapped io_uring mount perms rw unlink
>  # real QA test starts here
>
>  _supported_fs generic
> +_require_idmapped_mounts
>  _require_test
>
>  echo "Silence is golden"
