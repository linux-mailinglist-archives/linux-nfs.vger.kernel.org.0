Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BB97432EB
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 05:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjF3DE4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 23:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjF3DEw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 23:04:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39AD3588
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 20:04:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A8133211DE;
        Fri, 30 Jun 2023 03:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688094289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrYkjCgtfX+pFT+t0RZkQHZfWWVcJ3Ln+joYhGnMJRU=;
        b=VW2DP5SvfHXGR+OcYbd187a1r19ZkLm1t2hJPg7m8bjHZJKgWDWM7sZZBhRGI86PuKVv9p
        FswO3nQlzmN33MLmp3E7OytJkL9XP7wLwComJUYdYdU0EexIlfilrgqNAqomVDwHwn5T/F
        rkQcsdnWAuT249b8EGy9iLAp0kzryPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688094289;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrYkjCgtfX+pFT+t0RZkQHZfWWVcJ3Ln+joYhGnMJRU=;
        b=PRW3kBtyfn4CwT3Y84beXTk4qW6VNYWItSrMdCnjnykn7Z2w1stkXlhB1kSxrG6CW55CI/
        yarzUpobNWb5VDDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7613E1391D;
        Fri, 30 Jun 2023 03:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id whRsCk9GnmSQTgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 30 Jun 2023 03:04:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH RFC 0/8] RPC service thread scheduler optimizations
In-reply-to: <168809295522.9283.8453285193952262503@noble.neil.brown.name>
References: <168806401782.1034990.9686296943273298604.stgit@morisot.1015granger.net>,
 <168809295522.9283.8453285193952262503@noble.neil.brown.name>
Date:   Fri, 30 Jun 2023 13:04:44 +1000
Message-id: <168809428416.9283.10675552657236895730@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 30 Jun 2023, NeilBrown wrote:
> 
>  I agree that an a priori cap on number of threads is not ideal.
>  Have you considered using the xarray to only store busy threads?
>  I think its lookup mechanism mostly relies on a bitmap of present
>  entries, but I'm not completely sure.

It might be event better to use xa_set_mark() and xa_clear_mark() to
manage the busy state.
These are not atomic so you would need an atomic operation in the rqst.

#define XA_MARK_IDLE XA_MARK_1

do {
 rqstp = xa_find(xa, ..., XA_MARK_IDLE);
 if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags)) {
     xa_clear_mark(xa, rqstp->xa_index, XA_MARK_IDLE);
     break;
 }
} while {rqstp);

xa_find() should be nearly as fast at find_next_bit()
  
NeilBrown

