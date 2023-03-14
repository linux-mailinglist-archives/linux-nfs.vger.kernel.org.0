Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C73A6B9EFD
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Mar 2023 19:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCNSsd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Mar 2023 14:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCNSsc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Mar 2023 14:48:32 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330CD4680;
        Tue, 14 Mar 2023 11:47:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B64F044A;
        Tue, 14 Mar 2023 18:47:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B64F044A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678819620; bh=sA+YLYPr09cFZAdNXkCmHbvNl4qDsJMXs9WA5SzWBvc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KAc3oVnuRCy0qrK6ynpO+5haELILgdyVwkzTO/fHRR2hf2uWoROMhlKiwSpYfPUFc
         r6k1ivvqEuPMBi5UwHVt5Vg+EcORg+dz95CbZBlzkOOSbK4gOU8Qd7b9SJ6V0dLLEF
         sn6fsFEd1U56NPqW4Y7YP6HGwGqpf2cjPOSJ+ZP/6PdFe3klebLiXTRwk/++kAS4jR
         DYAdm/bthWip50SlhYtGmbaqzU0doXyMOTlKDzBg8zPQm5g7ZGSFZg4/wNc1aPZhwy
         kSo/IlvMfmLdqr5ho+KBQBmbXpphk5NsTLvvk74nR8i+/1ZVe1Y4k0dNVErRFpMRDv
         Uuc3IHtz8H0Lw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] Documentation: kernel-parameters: sort NFS parameters
In-Reply-To: <20230227025816.1083-1-rdunlap@infradead.org>
References: <20230227025816.1083-1-rdunlap@infradead.org>
Date:   Tue, 14 Mar 2023 12:46:59 -0600
Message-ID: <871qlrrx0c.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Sort the NFS kernel command line parameters. This is done in 4 groups
> so as to not have them intermingled: 'nfs' module parameters, 'nfs4'
> module parameters, 'nfsd' module parameters, and nfs "global" (__setup,
> no module) parameters.
>
> There were 5 parameters which were listed with a space between the
> parameter name and the following '=' sign. The space has been
> removed since module parameters expect 'parameter=' with no intervening
> space.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: linux-nfs@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt |   74 +++++++-------
>  1 file changed, 37 insertions(+), 37 deletions(-)

Applied,

thanks.

jon
