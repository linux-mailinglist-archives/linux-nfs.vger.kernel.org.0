Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E477BA270
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Oct 2023 17:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjJEPha (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Oct 2023 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjJEPg6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Oct 2023 11:36:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E3A826CB
        for <linux-nfs@vger.kernel.org>; Thu,  5 Oct 2023 07:52:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F216CC433CD;
        Thu,  5 Oct 2023 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696517422;
        bh=Cfx4NIhnhmSnDlcZrtZVJc7mM5jWFh/wy1BMr4tGedM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SvUtLqCGQMHff7uUeT3UYhdEhfZNQrW3N38nqK0uii6f7m17jnNHdzc3K3brsHgDo
         0TGbKWz9+KQC+roOrl9lr9v8IJwAgL/kZUItmGwOqWVhbz7TNicCczzdADWOlqOXFb
         i4D7REdTSXkof/rnarlv2GiyL2wwJFZu3Y2I96m2NbbXCERiu4l79J/H3RzMuMmfV6
         d/h4tjCKZQWzIzflTJfmaxqAorzGUoraZexgrvLt0yAg6s47B7pRtHPdKye8mSEZem
         lAqjhR2jRisj//NNV6aTGcEpX6ySTCx83QiSuDBzQTpv56gFsPF9NBoieypoICqxjQ
         J/mtaK0jTRZeA==
Date:   Thu, 5 Oct 2023 07:50:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, netdev@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC] tools: ynl: Add source files for nfsd netlink
 protocol
Message-ID: <20231005075021.0da40d7d@kernel.org>
In-Reply-To: <169651139213.16787.3812644920847558917.stgit@klimt.1015granger.net>
References: <169651139213.16787.3812644920847558917.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 05 Oct 2023 09:10:38 -0400 Chuck Lever wrote:
> Should I include this with the nfsd netlink protocol patches already
> in nfsd-next, or do you want to take it after those have been merged?

Either way works, I don't see any conflicts right now.
Worst case we'll have a minor conflict on the Makefile.

Note that you should probably also add an entry for nfsd to
tools/net/ynl/Makefile.deps in case there are discrepancies
between the system headers and new uAPI extensions.
