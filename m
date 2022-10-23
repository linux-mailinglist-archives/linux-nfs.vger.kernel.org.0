Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6C66096F3
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 00:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJWWGI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Oct 2022 18:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJWWGI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Oct 2022 18:06:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC6B6D573
        for <linux-nfs@vger.kernel.org>; Sun, 23 Oct 2022 15:06:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 31B1921EF9;
        Sun, 23 Oct 2022 22:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666562763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LRiJiTPqOqwlqaydST6lPYccLqFZrWc8lnObmpHnE9w=;
        b=JaCMSP6mvCTFH2y6T1WPYY9xzkhT5frIl3w0YXmB1l4tq6yt6ho7qpvI7bjJ/jKBcoQVKL
        zUnjiYM3Z0QbMqYLQbK2TyPAjl10T13t29URE2WNsFd0qzeICEjf2sE9/bKaGKWy16gMuR
        CX3e3tjS+3SxSGcsFfrLjj33WN7r5BM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666562763;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LRiJiTPqOqwlqaydST6lPYccLqFZrWc8lnObmpHnE9w=;
        b=uuV8tsFQTd6HyZG570ERORrRvwlUkIfkb6qtFsTg+y6gaIPfgcCgEmFraraqEICdo9f1XA
        g1pyjYKopm4awfDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB6F2139F0;
        Sun, 23 Oct 2022 22:06:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1lcIJ8m6VWPJVAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 23 Oct 2022 22:06:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Salvatore Bonaccorso" <carnil@debian.org>
Cc:     "Steve Dickson" <steved@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: systemd/50-nfs.conf and interoperability issue with
 intramfs-tools not including sunrpc into initrd
In-reply-to: <Y1KoKwu88PulcokW@eldamar.lan>
References: <Y1KoKwu88PulcokW@eldamar.lan>
Date:   Mon, 24 Oct 2022 09:05:57 +1100
Message-id: <166656275785.12462.14027406790454668194@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 22 Oct 2022, Salvatore Bonaccorso wrote:
> Hi Neil, hi Steve,
> 
> In Debian for the update including the systemd/50-nfs.conf there was a
> report that sunrpc is not included anymore in the initrd through the
> initramfs-tools hooks. 
> 
> The report is at https://bugs.debian.org/1022172
> 
> As we would not start to diverge again from nfs-utils upstream and
> keep in sync with upstream as much as possible I would like to retain
> whatever is from nfs-utils upstream downstream as well.
> 
> Marco d'Intri suggested there three possible solutions, of which one
> could be done in nfs-utils (whereas the other two are either in kmod
> upstream or initramfs-tools upstream). The nfs-utils one would be to
> replace the modprobe configuration with a set of udev rules instead.
> 
> What do you think?

I don't object to nfs-utils being changed to install an appropriate udev
rules file instead of the modprobe.d file.  Would you be willing to
develop, test, and post a patch?

Thanks,
NeilBrown
