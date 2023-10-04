Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788B07B8613
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 19:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjJDREe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 13:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243559AbjJDREe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 13:04:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D419B
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 10:04:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EBEC433C8;
        Wed,  4 Oct 2023 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696439069;
        bh=1ogzXaF+JakFRGGkCsT10LOiWTKjcJ7klcT+Cr9HRa0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BGZz/bEB5mrfHx8NtumOmpXpl836aTkcSpPcwUA7jFbsWYEhL7WSnQeBI6GGCuiIr
         2QOWFHgMp/RsCPfZBUYR0Ad+LEl+s7+l4El2UQ6ydAI1UQnUvE3cVHjvXEez/6NRfj
         09/hf5G9XYtl8PrzadfREIvW2T6AIGkJMscd7f73/vj602H0zM4jDzL8kdrKLzlblk
         +PwVUTsz4mJItPnWy0RfLs4o78s+H260S4lrrV7xGizoYlxP9lWgRlXpk/q9NX/VYW
         +Tox55Ssdf3Al2CHcPAZBgS11+UtzBeMV0Ngn7AMJCVOjzBchY2KYBB+i6G9gGN0X7
         M3+Co5lMq7Q0Q==
Date:   Wed, 4 Oct 2023 10:04:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-nfs@vger.kernel.org, neilb@suse.de, chuck.lever@oracle.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Message-ID: <20231004100428.3ca993aa@kernel.org>
In-Reply-To: <ZQ2+1NhagxR5bZF+@lore-desk>
References: <b7985d6f0708d4a2836e1b488d641cdc11ace61b.1695386483.git.lorenzo@kernel.org>
        <cc6341a7c5f09b731298236b260c9dfd94a811d8.camel@kernel.org>
        <ZQ2+1NhagxR5bZF+@lore-desk>
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

On Fri, 22 Sep 2023 18:20:36 +0200 Lorenzo Bianconi wrote:
> > matter at all. Do we have to send down a value at all?  
> 
> I am not sure if ynl supports a doit operation with a request with no parameters.
> @Chuck, Jakub: any input here?

It should, if it doesn't LMK, I will fix..
