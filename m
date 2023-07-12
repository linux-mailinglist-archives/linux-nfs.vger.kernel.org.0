Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6EB7507A2
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jul 2023 14:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGLMLL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jul 2023 08:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjGLMLH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jul 2023 08:11:07 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D991BFF
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jul 2023 05:10:48 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 42AC45C016C;
        Wed, 12 Jul 2023 08:10:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 12 Jul 2023 08:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1689163845; x=1689250245; bh=+GntHArDzPKLk
        2PNbZnKYMOj1ok9kjbg95D2vSVIuO0=; b=Br3CGEPCZcEcqxRn52GeyHuQvJYBn
        FMVBnaYxjnM8c1MNkxijgpho/pmGMsHZLWOCHRWd6aoBY5VtxM9X6iSRGVfxuKgQ
        30SqyE2bIwad2lhN0BQV6IitJFWQPvzvX39PY66X3xFs33anURxQaWtGMJeVDCbN
        K53uEZXwXyIBzE0MwWkOYxBqT0C7kHEUWd4Wq6DO6VZn8g9Cyrm72g8WZZ6Gd4tT
        q0w/s/vioenXIafGrkW1K2nHGO66QlHngwCRDpUo3BOHwRJGtRNWPcV1yCGBMqfe
        OXP1haXI/2r3fdB3WiZIGSbUjV9vM0RXBxWK7TFM3HYBhb6u9EzT1i1qQ==
X-ME-Sender: <xms:RZiuZOf-girq_JErtLndAhjdR6TxLnZOd1sptPGpDiSRSKMNNramVA>
    <xme:RZiuZIMutGGNWLRdveG5B0bX6t4fysyGFb1H2VenP1h28OR68pCIjNU4eFEd1JJ9z
    v1S-JTHWy_CR3w>
X-ME-Received: <xmr:RZiuZPjXpe0XeFACidzgkxixOGPGJjqC4K1m4JXpmAAwd6yePh6NWKAf7cjQL45z5hnN17oV4PBxRhYMlX4r2vqecv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedvgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:RZiuZL8wKZ3IomrnB0qcmHIOANV3GMd6uecbVHDfl6a-jcyi6n0qXA>
    <xmx:RZiuZKsfrbooc8nnbCBT3bRLCTLGsM7wcVKr-NevQwRIOjnXVNfwyw>
    <xmx:RZiuZCG6tAIO7TsqvShrhDQiUxPcbegPrEbhkHNg9JrogKxTPL69uQ>
    <xmx:RZiuZD5XfhzYb7DkG_5KgvHtkkF_i8-9LpsDCJYhrLB8zIf75jAeMA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 08:10:44 -0400 (EDT)
Date:   Wed, 12 Jul 2023 15:10:39 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        aahringo@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Fix sysfs server name memory leak
Message-ID: <ZK6YPyludwL6zK93@shredder>
References: <6702796fee0365bf399800326bbe6c88e5f73f68.1689014440.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6702796fee0365bf399800326bbe6c88e5f73f68.1689014440.git.bcodding@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 10, 2023 at 02:41:58PM -0400, Benjamin Coddington wrote:
> Free the formatted server index string after it has been duplicated by
> kobject_rename().
> 
> Fixes: 1c7251187dc0 ("NFS: add superblock sysfs entries")
> Reported-by: Alexander Aring <aahringo@redhat.com>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

Hit this issue as well. This patch fixes the problem.

Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks
