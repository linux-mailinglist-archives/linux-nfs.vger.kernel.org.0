Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513204B18DE
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 23:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbiBJWzE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 17:55:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345323AbiBJWzD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 17:55:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E5655B0
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 14:55:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4898C1F38E;
        Thu, 10 Feb 2022 22:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644533702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KiENcqdDRrOMjFfEDvXBS+bTdu0nC3y8/zENlIgctU=;
        b=ykePmpg9DZAU3UL3fmqDUXFv569PsCQifkMiAesNh2NbHxhx93YIbytJ0w1z3MG1zeBl2C
        rODVFH4nHNY/08IBnVdpuAIz2VkeAVSN4YSt7G/yZpk7qtNwfDArfkGVp1raGTgR4unZEh
        XKwZXZ+93Zh+mWIl34iYGh5RoTKgJ6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644533702;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KiENcqdDRrOMjFfEDvXBS+bTdu0nC3y8/zENlIgctU=;
        b=aU035pPJwVVdu7GeohkfxmYfPfiw8RQ8TSZdpbY3T90IFKOvl+SZoakWi/fLDNhqpnVo5/
        R4MXcqf31vK7NzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE24413C57;
        Thu, 10 Feb 2022 22:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YCLeJcSXBWJWQwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 10 Feb 2022 22:55:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Benjamin Coddington" <bcodding@redhat.com>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>, steved@redhat.com,
        linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
In-reply-to: <6BAAA0D0-7212-480F-9C33-DA1F656FF09F@redhat.com>
References: =?utf-8?q?=3Cc2e8b7c06352d3cad3454de096024fff80e638af=2E16439791?=
 =?utf-8?q?61=2Egit=2Ebcodding=40redhat=2Ecom=3E=2C?=
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>,
 <0AB20C82-6200-46E0-A76C-62345DAF8A3A@redhat.com>,
 <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>,
 <164444169523.27779.10904328736784652852@noble.neil.brown.name>,
 <39e7bba4243eb2f16d99fefb43fef6b3ff741f87.camel@hammerspace.com>,
 <164445109064.27779.13269022853115063257@noble.neil.brown.name>,
 <6BAAA0D0-7212-480F-9C33-DA1F656FF09F@redhat.com>
Date:   Fri, 11 Feb 2022 09:54:57 +1100
Message-id: <164453369792.27779.10668875903268728405@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 10 Feb 2022, Benjamin Coddington wrote:
> 
> Yes, but even better than having the tool do the writing is to have udev do
> it, because udev makes the problem of when and who will execute this tool go
> away, and the entire process is configurable for anyone that needs to change
> any part of it or use their own methods of generating/storing ids.

I really don't understand the focus on udev.

Something, somewhere, deliberately creates the new network namespace.
It then deliberately configures that namespace - creating a virtual
device maybe, adding an IP address, setting a default route or whatever.
None of that is done by udev rules (is it)?
Setting the NFS identity is just another part of configuring the new
network namespace.

udev is great when we don't know exactly when an event will happen, but
we want to respond when it does.
That doesn't match the case of creating a new network namespace.  Some
code deliberately creates it and is perfectly positioned to then
configure it.

udev is async.  How certain can we be that the udev event will be fully
handled before the first mount attempt?

NeilBrown
