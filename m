Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F2C6F78BB
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 00:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjEDWDD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 18:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDWDB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 18:03:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998B81BD9
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 15:02:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 336B91FD6B;
        Thu,  4 May 2023 22:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683237777;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chmLSqNowL16JqBY6RvWE0xmKKybZomj8imcuXLsOGA=;
        b=LuzDzYZBc4UPhw0eR4xZGrnHZUXgyalIhsGBajNo0lp2zIPL0IfgbU1LFh9ernxNyzObZ4
        weaNISE2pwUqg9mHAW+f8YHqVOh4RJmDli+GWYBhBy3MS23MzCbt88XJ+/+huwUKAavs07
        UC5a5S3aPMoIwa5mTU3+OoSIlmhJp2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683237777;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chmLSqNowL16JqBY6RvWE0xmKKybZomj8imcuXLsOGA=;
        b=slo7459POaS3hEmF29RAV1ibMV2xEMp/1YSXVgHOkNjARBhDVu9y/H7LckhPwRHaYEmSU5
        XT7gOJbBtWTLkUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7444D133F7;
        Thu,  4 May 2023 22:02:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XDs4F5ArVGQATQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 22:02:56 +0000
Date:   Fri, 5 May 2023 00:02:54 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
        NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v5 5/5] nfs: Run on btrfs, ext4, xfs
Message-ID: <20230504220254.GC4244@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230504131414.3826283-1-pvorel@suse.cz>
 <20230504131414.3826283-6-pvorel@suse.cz>
 <ZFO6ywouPkmNKtkr@yuki>
 <20230504220037.GB4244@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504220037.GB4244@pevik>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

...
> check_umount()
> {
> 	local i
> 	local dir="$1"
> 	local type="${2:-lhost}"
> 	local cmd="grep -q $dir /proc/mounts"

> 	for i in $(seq 50); do
> 		if [ "$type" = "lhost" ]; then
> 			$cmd || return
> 		else
> 			tst_rhost_run -c "$cmd" || return
> 		fi
> 		tst_sleep 100ms
> 		tst_res TWARN "failed to umount '$dir'"
> 	done
Obviously TWARN should be here.
...

Kind regards,
Petr
