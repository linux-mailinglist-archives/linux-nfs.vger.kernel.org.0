Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB84A570689
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 17:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiGKPC7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 11:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGKPC6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 11:02:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443CA5C97F
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 08:02:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 02ABF20388;
        Mon, 11 Jul 2022 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657551777;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcVxXPTvHuiyIJ7LzZg7yYibCd22okN9v+E19WIie9A=;
        b=tIjqvEqRgYXe9HWuLUYnDybZjJM8YPnTBgI2FLGnX2GiOO5FjepuaBF3P3D+/+D0mvTmMe
        9aFbKBv6nKM8ic4bBSuqpNKxHaj/ZiqqXcaCLng4WxSTQenrz4a7kWJxq3cIN3KHCpyrZ6
        qNi6npl5UVhZRqfaAANHSWmsaZ4Zvzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657551777;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcVxXPTvHuiyIJ7LzZg7yYibCd22okN9v+E19WIie9A=;
        b=dBzgd98WmIpdgtCkUFYTJXyDUJXENwAproU23Umof+ZxcslRP5Bei3ylmO0FyyC1uYpsnh
        WcVoVSLTyEImPkBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9A5813322;
        Mon, 11 Jul 2022 15:02:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /j4HJ6A7zGJ8WAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 11 Jul 2022 15:02:56 +0000
Date:   Mon, 11 Jul 2022 17:02:55 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     linux-nfs@vger.kernel.org, Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH v2 4/9] shell: Add test for TST_MOUNT_DEVICE=1
Message-ID: <Ysw7n+WQvw/rcoOy@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220609214223.4608-1-pvorel@suse.cz>
 <20220609214223.4608-5-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609214223.4608-5-pvorel@suse.cz>
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

FYI merged up to this patch, the rest (the actual $TST_ALL_FILESYSTEMS)
will go in v3.

Kind regards,
Petr
