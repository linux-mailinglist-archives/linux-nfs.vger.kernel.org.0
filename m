Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199216F46D6
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjEBPQi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjEBPQh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 11:16:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B189A1704
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 08:16:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59A7621C19;
        Tue,  2 May 2023 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683040595;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+jmsfE48eQhPr7xu3AbpMooOhY62h5fFJ77A9si21r8=;
        b=g9ZPlS60sx8gPrY9rSuuAbIe9BWgS1CRywE8DPRi6V3Ahgyj+z9rFKbwF5oVS4Vyf2pJVP
        sErvXE/8OhjcjnA//nfxVZT1xNuft0Ub9kCzYziqCQdwpTXBK6ViVdE0eeKcsKH3qgf/HJ
        OozvkgaZj9ly3vTjA8yv+IlOrA/mv9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683040595;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+jmsfE48eQhPr7xu3AbpMooOhY62h5fFJ77A9si21r8=;
        b=eOfTYx3hTn9dagT6H0ip5NGJh7SMzMyQUuvSFVnn1X5gIIpxLSvnhTUXuJoZkprQiNyMoI
        WWCtgQs3jXzOCNAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03010134FB;
        Tue,  2 May 2023 15:16:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xDCbOlIpUWQyHAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 02 May 2023 15:16:34 +0000
Date:   Tue, 2 May 2023 17:16:48 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     NeilBrown <neilb@suse.de>, Cyril Hrubis <chrubis@suse.cz>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 4/4] nfs: Run on all filesystems
Message-ID: <20230502151648.GB3677937@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230428160038.3534905-1-pvorel@suse.cz>
 <20230428160038.3534905-5-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428160038.3534905-5-pvorel@suse.cz>
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

this patch shown also problems on vfat on various new systems (and on older
Debian with nfs-utils 1.3.3 even on all filesystems) - '2' is not visible.

More info at the patch:
https://lore.kernel.org/ltp/20230502151348.3677809-1-pvorel@suse.cz/

Kind regards,
Petr
