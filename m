Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89213456898
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Nov 2021 04:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhKSD1V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Nov 2021 22:27:21 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49910 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhKSD1V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Nov 2021 22:27:21 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A5B71FD38;
        Fri, 19 Nov 2021 03:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637292259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5t8B/6AdIjqnMZKW24I0xyCUbRwAn53r+Tw3bd6n1Dw=;
        b=j/GRz7E6EpszpgHkNfbewLxAm6sLY/EtPGeGajyFVkAFUUcVqQmLgErjo5X2rIJ4HApL+C
        zk739eRPc9i8Ji8fv5mHxUQNPRb1jq1mbQmD0T+kKELNFd8QQehMQqu3MzXkjhflXLlpxa
        N2lFaaYR8c6bsWHozOCsdKfpTwjnIf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637292259;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5t8B/6AdIjqnMZKW24I0xyCUbRwAn53r+Tw3bd6n1Dw=;
        b=44/z4ov2nQw9pJYMW7hnXpri2hoERPdNO5rXb7hkq4MnJK4yuGC4jHmMqv65COtk/SwvW0
        LAaflwfaEYYdtoCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BD3913DCB;
        Fri, 19 Nov 2021 03:24:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Yr4XA+IYl2GOBQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 19 Nov 2021 03:24:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 00/14] SUNRPC: clean up server thread management.
In-reply-to: <20211117141231.GA24762@fieldses.org>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>,
 <20211117141231.GA24762@fieldses.org>
Date:   Fri, 19 Nov 2021 14:24:15 +1100
Message-id: <163729225540.13692.3919900284802570106@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 18 Nov 2021, J. Bruce Fields wrote:
> On Wed, Nov 17, 2021 at 11:46:49AM +1100, NeilBrown wrote:
> > I have a dream of making nfsd threads start and stop dynamically.
> 
> It's a good dream!
> 
> I haven't had a chance to look at these at all yet, I just kicked off
> tests to run overnight, and woke up to the below.
> 
> This happened on the client, probably the first time it attempted to do
> an nfsv4 mount, so something went wrong with setup of the callback
> server.
> 
> --b.
> 
> [  285.585061] divide error: 0000 [#1] PREEMPT SMP KASAN PTI

It appears that serv->sv_nrpools is zero.  I don't think I changed
anything relating to that.

I did think it off that nfs-callback uses svc_create_pooled, but doesn't
ensure it requests as many threads as pools....  probably not related
though.

I'll dig in a bit more later.

Thanks,
NeilBrown
