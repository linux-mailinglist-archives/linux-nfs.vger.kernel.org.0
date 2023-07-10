Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104DE74E0EB
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 00:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGJWSz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 18:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjGJWSy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 18:18:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5A7189
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 15:18:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 24F161FD82;
        Mon, 10 Jul 2023 22:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689027532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W5gBRyOlIM1QXcl27ofiQGrpHqwjWzMv56YOS8lro5U=;
        b=Dvjmh0WwT5/T7I0rgT/ZsQup4IgJHYPPkIhWBbaAegI3UviqZRuZvvQhBNyat7TFhk9run
        9QNxAaPHDL5bCrht1QiPVkSs5pwHqZJLm74/KlO1mMuu5zHjZ4+E3YgEfF8D4NGrmxH0ir
        A4yJ1YfeV1o4Zm24l0q5X7InkaOxKHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689027532;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W5gBRyOlIM1QXcl27ofiQGrpHqwjWzMv56YOS8lro5U=;
        b=axiJ5Uuz7EcbguniggiZFBPbOjUBeAoAZqTQXN7bNVH7lLp4plxwc8lNMXGiph90WZOzOq
        8KUIu0KyTc9k+2Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9CC31361C;
        Mon, 10 Jul 2023 22:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kGzKJsmDrGRPeAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 10 Jul 2023 22:18:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH/RFC] sunrpc: constant-time code to wake idle thread
In-reply-to: <ZKwwFNeTw60Wuo+K@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>,
 <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>,
 <168843152047.8939.5788535164524204707@noble.neil.brown.name>,
 <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>,
 <168894969894.8939.6993305724636717703@noble.neil.brown.name>,
 <ZKwwFNeTw60Wuo+K@manet.1015granger.net>
Date:   Tue, 11 Jul 2023 08:18:46 +1000
Message-id: <168902752676.8939.10101566412527206148@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 11 Jul 2023, Chuck Lever wrote:
> 
> Actually... Lorenzo reminded me that we need to retain a mechanism
> that can iterate through all the threads in a pool. The xarray
> replaces the "all_threads" list in this regard.
> 

For what purpose?

NeilBrown
