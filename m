Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A94B5753F9
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 19:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiGNRY5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 13:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGNRY5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 13:24:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C2C599E5
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 10:24:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF10C1F8C7;
        Thu, 14 Jul 2022 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657819494;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7FG23WQK31OUTlDJfPNOeC9o4vfSL9y1u3YdpZ+ezbY=;
        b=gDDnzwScNEwKvwaQueJmbzL79ht0T8N1LnDT/7UAvHNcewsIJHGJM5ugiAYu2eee7q/wIs
        mjqX/LH/3I1kvTYGUh28z8I4OM5lDabj9lPFdotGA0SfCVAP15Nl+wntHa9Q6jiCQu5MmT
        InppGGLQYgGcsKg4dd7AZGDOE5936s0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657819494;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7FG23WQK31OUTlDJfPNOeC9o4vfSL9y1u3YdpZ+ezbY=;
        b=wsHpVoB99jFqLVgkwqIsXo9uBMxJKRZg7vIcFyZcHCE8MCrlll7+Glb+O05UEqPNRxbYMz
        /VA5TyR4JKSYpfCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CCA613A61;
        Thu, 14 Jul 2022 17:24:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8ypVJGZR0GILeAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 14 Jul 2022 17:24:54 +0000
Date:   Thu, 14 Jul 2022 19:24:52 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     linux-nfs@vger.kernel.org, Cyril Hrubis <chrubis@suse.cz>,
        Martin Doucha <mdoucha@suse.cz>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: Re: [PATCH 1/1] netstress: Restore runtime to 5m
Message-ID: <YtBRZCKfhA6b433J@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220713124347.13593-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713124347.13593-1-pvorel@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

> netstress requires the previous default timeout 5m due longer timeout
> for higher message sizes (e.g. 65535):

> ./sctp_ipsec.sh -6 -p comp -m transport -s 100:1000:65535:R65535
...
> sctp_ipsec 3 TINFO: run client 'netstress -l -T sctp -H fd00:1:1:1::1 -n 65535 -N 65535 -S fd00:1:1:1::2 -D ltp_ns_veth2 -a 2 -r 100 -d /tmp/LTP_sctp_ipsec.ARZbGkvjPa/tst_netload.res' 5 times
> sctp_ipsec 3 TWARN: netstress failed, ret: 2
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> netstress.c:896: TINFO: IP_BIND_ADDRESS_NO_PORT is used
> netstress.c:898: TINFO: connection: addr 'fd00:1:1:1::1', port '55097'
> netstress.c:900: TINFO: client max req: 100
> netstress.c:901: TINFO: clients num: 2
> netstress.c:906: TINFO: client msg size: 65535
> netstress.c:907: TINFO: server msg size: 65535
> netstress.c:979: TINFO: SCTP client
> netstress.c:475: TINFO: Running the test over IPv6
> Test timeouted, sending SIGKILL!
> tst_test.c:1577: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1579: TBROK: Test killed! (timeout?)

> Converting netstress.c to use TST_NO_DEFAULT_MAIN (i.e. implementing main)
> would require more changes, because it uses .forks_child, .needs_checkpoints,
> cleanup function.
Merged to get at least netstress timeout fixed.

> NOTE: there is also needed to increase timeout for sctp_ipsec.sh.
> At least on my VM 10 min wasn't enough. Trying to measure reasonable
> time with TST_TIMEOUT=-1.
Continue debugging this.

Kind regards,
Petr
