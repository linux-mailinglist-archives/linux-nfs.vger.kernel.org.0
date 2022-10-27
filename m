Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6A610650
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 01:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiJ0XWX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 19:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJ0XWW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 19:22:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACF757DC6
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 16:22:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7AAC2219B8;
        Thu, 27 Oct 2022 23:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666912940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4gJ+q7ZCuzTzGbWnoheWsvBj0/NGKAUuM4x9tL8GEKU=;
        b=ekM9rZALd78y7ubuMiWCnpvpMT+Qm4LL2q+F7sOPBE+xmzwkVgG+QJzoIwqKXiWr+VO0Un
        0tQNawMpEPbEZSLZkfsMlMwKwm2IZgWBH/zI5hH41fJdRYwC2y2paACyjOrUY6fZkIgwAG
        pRkQi8X4PKfMb9/A6kpRebLRdZixbwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666912940;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4gJ+q7ZCuzTzGbWnoheWsvBj0/NGKAUuM4x9tL8GEKU=;
        b=WHwoOvOOVV1GihJ47BHwvksdMsC66o8Ie8gGMT28gD3SMduCP9eNpQkXdMZjAky0jkd6AG
        a7WzSlgssyrrEpBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51DE113357;
        Thu, 27 Oct 2022 23:22:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NM/1AqsSW2P/EAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Oct 2022 23:22:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, jlayton@redhat.com
Subject: Re: [PATCH v6 09/14] NFSD: Clean up nfsd4_init_file()
In-reply-to: <166689675530.90991.2630847343462195612.stgit@klimt.1015granger.net>
References: <166689625728.90991.15067635142973595248.stgit@klimt.1015granger.net>,
 <166689675530.90991.2630847343462195612.stgit@klimt.1015granger.net>
Date:   Fri, 28 Oct 2022 10:22:15 +1100
Message-id: <166691293591.13915.198182531468244072@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 28 Oct 2022, Chuck Lever wrote:
> Name nfs4_file-related helpers consistently. There are already
> nfs4_file_yada functions, so let's go with the same convention used
> by put_nfs4_file(): init_nfs4_file().

I don't understand.  You say "consistently", then you say that as we
have lots of "nfs4_file_yada" functions, this new one will NOT follow
that pattern.

Surely "consistency" means renaming put_nfs4_file() to nfs4_file_put(),
and introducing nfs4_file_init().

Not that I really care that much about the naming, but would like to be
able to follow your logic.

Thanks,
NeilBrown
