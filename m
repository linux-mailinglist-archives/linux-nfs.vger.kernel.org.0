Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAE66F7749
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 22:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjEDUmO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 16:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjEDUl7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 16:41:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABCC12EB6
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 13:37:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 837731F898;
        Thu,  4 May 2023 20:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683232614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ygCCzMW4Cui/q/1N1fyCIgAk/7w6VcpWy2rJsWoqidA=;
        b=BxbOI7MJGFmxw1B+m9ZtQTlW2BX/mNwa1zvoPYk24Nso1r3PBAW2aRhm7uezlwttbAq0un
        aR1PttkFA13LSMvS5j2zaUPipTOVPR9bwX+WLhkOS2W/yvVNlATwLIpVlimHQ42yKxzEcR
        KUGxoKH8KNe0FRJjlrKwlcgeqNNpt64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683232614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ygCCzMW4Cui/q/1N1fyCIgAk/7w6VcpWy2rJsWoqidA=;
        b=xFbZ/+bxbmmGd6vFcP0ubabAP9i0KG7/xu2yQ9G6oedLDbVxLskou9mBzrDPKDTm9ArP4o
        IUrZs9SDqRM9HzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED32F13444;
        Thu,  4 May 2023 20:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6799NmUXVGRkKwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 20:36:53 +0000
Date:   Thu, 4 May 2023 22:37:07 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     NeilBrown <neilb@suse.de>, Cyril Hrubis <chrubis@suse.cz>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] nfslock01.sh: Don't test on NFS v3 on TCP
Message-ID: <20230504203707.GA3830225@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230502075921.3614794-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502075921.3614794-1-pvorel@suse.cz>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

FYI we're not going to disable the tests, it's against "do not work around real
bugs in tests" [1]. Thus I set this patch as "rejected".

I'm not sure if anybody has tried the suggested settings, I'll try to test it soon.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/ZFO2vmWk-tvrZoQQ@yuki/
