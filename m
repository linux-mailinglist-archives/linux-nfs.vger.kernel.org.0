Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77F4570698
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 17:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiGKPIo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 11:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbiGKPIo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 11:08:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58544BE13
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 08:08:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1A6612291B;
        Mon, 11 Jul 2022 15:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657552122;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dtikuyI7ocoYg32UJ/6PpZewwe2BWv9rbFYqahOuSok=;
        b=U7mBbap8BFaaCJceZ4RRRjfoetonq7Ue61ZEv5PAYng7s28MgBD/4uXSOkWjH3O/2c4KHD
        Q3aB2lUEZ7sljkTT1JGoZRcKVwfJOcStXXE5ZskUxeKS/okwj0yL2yLo0x36bt/jG7dN1A
        JgSMNmxOzOOSXTZr2X56s5J5Ted+v14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657552122;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dtikuyI7ocoYg32UJ/6PpZewwe2BWv9rbFYqahOuSok=;
        b=Rwo2pUIJ5zoPht8OqJhBf0w/kosdvZnUiete3FmD8xt/tq3JBtg/770o4rI9skNlZ47CGW
        IZw2rNrxKvLMNxAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E575013322;
        Mon, 11 Jul 2022 15:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M1T4Nfk8zGKxWgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 11 Jul 2022 15:08:41 +0000
Date:   Mon, 11 Jul 2022 17:08:40 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, linux-nfs@vger.kernel.org
Subject: Re: [LTP] [RFC][PATCH v2 9/9] nfs: Use TST_ALL_FILESYSTEMS=1
Message-ID: <Ysw8+JLSELXuS0MI@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220609214223.4608-1-pvorel@suse.cz>
 <20220609214223.4608-10-pvorel@suse.cz>
 <YqyU8goDyTwJjXM4@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqyU8goDyTwJjXM4@yuki>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

> > +	systemctl restart nfs-server

> I wonder do we stil have to care for systems without systemd?
That'd be a question for embedded people. I myself wonder if they all moved to
systemd. But at least Alpine and Buildroot distros allow to use Busybox as init,
thus I'd still care.

> We do have daemonlib.sh in LTP that has restart_daemon() function that
> branches to systemctl|service|/etc/init.d/ that is used by a few tests.
That's exactly what I'm planning to use.

Kind regards,
Petr
