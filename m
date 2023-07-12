Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CE175006E
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jul 2023 09:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjGLHvc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jul 2023 03:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjGLHvI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jul 2023 03:51:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FABD1BDC
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jul 2023 00:50:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD545225BD;
        Wed, 12 Jul 2023 07:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689148252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LuMaEWzppXeqILtQ+q99CCpcsCfYtC8cG4xI25O5IhE=;
        b=RhLSMyHTsnNjxAi97o6Sgglwt33JCPrUyF+ysou1RemngF6hyywRlKxFzAM0lBK7MzZJpc
        5t9Z3elOXH2QCrqzRJKa+OmukFgIPYKRLsETvOskfJcDHGWykqLI4rl+Ld5m6hxZ0RWUR4
        cLwnjxhDxmaIDU5FYEx6guNri9gBJtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689148252;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LuMaEWzppXeqILtQ+q99CCpcsCfYtC8cG4xI25O5IhE=;
        b=rVymJVQkQ0whHZYWQROxoFfi4Bo0FcWWAIqx8qO55n2gTdShCccmI8cetH2a4BUsZ5eMhU
        /PUAL3eCOYh+fZDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FC7213336;
        Wed, 12 Jul 2023 07:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yejCJVxbrmQrMwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 12 Jul 2023 07:50:52 +0000
Date:   Wed, 12 Jul 2023 09:51:56 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: Re: [LTP] [PATCH 1/1] runtest/net.nfs: Run nfs02_06 on TCP only
Message-ID: <ZK5bnATPwNd-kmvO@yuki>
References: <20230622084648.490498-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622084648.490498-1-pvorel@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!
Sounds reasonable.

Acked-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
