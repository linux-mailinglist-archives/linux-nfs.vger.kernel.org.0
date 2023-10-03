Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6EA7B707D
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Oct 2023 20:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbjJCSED (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Oct 2023 14:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjJCSEC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Oct 2023 14:04:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E81AB
        for <linux-nfs@vger.kernel.org>; Tue,  3 Oct 2023 11:03:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F07C433C8;
        Tue,  3 Oct 2023 18:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696356239;
        bh=i5SJqPcjVPyVB1ildzpV3oWH+KGv0OBRnSp5zrfjEQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tfcA+UvrJwLDoVISbmRAJ9D5QZE3zMic+ZBol+Bh8fY8Kx7FM7Kkj8yU0JzljCV0C
         NQBgwJTA2Ev6OEqyeXnfjG5ex8FcXasqyBOHjjZRAwsRW47ed/g1enBj50EJseoacN
         lcWAfjrXCfn9Wc5L78Ri4QiqWqf8kE8coGw7YLj5tt+7saV9yM3+BIYjt9BtU5yrkJ
         Ekw1dScZfJrVHvBreRtdC0gUVX6rLMew9X8mXIciAEoRgxo6ZiL4a7BVFtvV3K/zyy
         1BkFlFh6EXbKSJ0N62VZFmVV7VX1KuQhOmfmdZoXfWNIC+MrfN34rQq8tnEdUXh9xJ
         yqQEKdZClhK1w==
Date:   Tue, 3 Oct 2023 11:03:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        netdev@vger.kernel.org
Subject: Re: [PATCH v8 3/3] NFSD: add rpc_status netlink support
Message-ID: <20231003110358.4a08b826@kernel.org>
In-Reply-To: <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
        <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 11 Sep 2023 14:49:46 +0200 Lorenzo Bianconi wrote:
> +	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
> +			  &nfsd_server_nl_family, NLM_F_MULTI,
> +			  NFSD_CMD_RPC_STATUS_GET);
> +	if (!hdr)
> +		return -ENOBUFS;

Why NLM_F_MULTI? AFAIU that means "I'm splitting one object over
multiple messages". 99% of the time the right thing to do is change 
what we consider to be "an object" rather than do F_MULTI. In theory
user space should re-constitute all the NLM_F_MULTI messages into as
single object, which none of YNL does today :(
