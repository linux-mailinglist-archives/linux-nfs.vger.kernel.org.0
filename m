Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC26B57F8E4
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 06:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiGYEq1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 00:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiGYEq1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 00:46:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56023BCB4
        for <linux-nfs@vger.kernel.org>; Sun, 24 Jul 2022 21:46:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 67451341CD;
        Mon, 25 Jul 2022 04:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658724384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HIH2kPKMOVgbCGyqlsXeL4jJaBpZo2x6Bx6JcO3teDc=;
        b=OKXU9cXu8GWwRUUlABU9sbkNCIAqLpLjfq1g56Oo6gwCwzwJdLxObXuZwYqoZ4zczAUoul
        pvzY4qjXtnqpkUOvC9ApMNHwamZy6fMhSTT5MVkkRMyJwW/bMqDz+y9uWv66n5BmTs1hXG
        LkFs9b+KwpNQfbr4G/je41zf20kuEkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658724384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HIH2kPKMOVgbCGyqlsXeL4jJaBpZo2x6Bx6JcO3teDc=;
        b=p2w31/h/jHZz0UM0Ke5OzRfvs1dYVEqNE0ZzkWZr7tiM+kP2G4k2bj43rLB8OVfiRv6iOC
        u33IpgyqPBYYZvCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4709013A8D;
        Mon, 25 Jul 2022 04:46:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5YpyAR8g3mJoHQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 25 Jul 2022 04:46:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] nfsd: close potential race between open and delegation
In-reply-to: <A5CC699E-040A-4017-93BE-51D3E1BD9B0C@oracle.com>
References: <20220714200434.161818-1-jlayton@kernel.org>,
 <165784314214.25184.13511971308364755291@noble.neil.brown.name>,
 <c10b61cd59a940dd93f6977300ab0d3c6742320f.camel@kernel.org>,
 <165811450205.25184.16800980627192339653@noble.neil.brown.name>,
 <A5CC699E-040A-4017-93BE-51D3E1BD9B0C@oracle.com>
Date:   Mon, 25 Jul 2022 14:46:16 +1000
Message-id: <165872437607.4359.14496861113580730818@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 19 Jul 2022, Chuck Lever III wrote:
> 
> > On Jul 17, 2022, at 11:21 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > But right now I have a cold and don't trust myself to think clearly
> > enough to create code worth posting.  Hopefully I'll be thinking more
> > clearly later in the week.
> 
> Thanks for the update!
> 
> Here are my plans: I'd like to finalize content of the first 5.20
> NFSD pull request this week. If these patches are not ready by
> then, I can prepare a second PR later in the 5.20 merge window
> with your work, which should give you another two weeks. If they
> are still not ready, I'll get them in first thing for the next
> merge window.

FYI I've addressed the outstanding issues (I think), but have not yet done
any testing or given the patches a final inspection.  I hope to do that
tomorrow, and will post the patches once it is done.
If you want a preview you can find them on github.com/neilbrown/linux
in the "nfsd" branch.

Jeff's patches to validate delegations after getting the lease, so we
don't have to hold the lock so long, comes first.

NeilBrown
