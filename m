Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A09590748
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Aug 2022 22:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiHKUUV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Aug 2022 16:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiHKUUT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Aug 2022 16:20:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4854E11A1C
        for <linux-nfs@vger.kernel.org>; Thu, 11 Aug 2022 13:20:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A0C2A5D168;
        Thu, 11 Aug 2022 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660249216;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ea5tjl2HJw8x2mxlnZAvgJJXhqwZy1YJ9uXCkwrrQRU=;
        b=US+4kk1Y86nzEbzY8tDRLTmpVIgzT5Nboi3qKntme9cTkYrEngkz+DRInBuQIrnYdsJR1L
        yiypIgpHCvsifwULQT1eO27l0zPXXpqyYV408PDUApilF8iAUL2J19fdK6BPtQzqeCadkn
        zB+F9onZbM3/Z1kArV9aEn+9aCYjBoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660249216;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ea5tjl2HJw8x2mxlnZAvgJJXhqwZy1YJ9uXCkwrrQRU=;
        b=BsO+xUoJlacyob16xYhi8YPpGHGwKFGbmlxlwPeMKEzUrM4+XhZ5ryWrgCnn9JoH6S+CTJ
        IvsFpMvlWyVnPzCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DBB013A9B;
        Thu, 11 Aug 2022 20:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ek/DF4Bk9WL5GAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 11 Aug 2022 20:20:16 +0000
Date:   Thu, 11 Aug 2022 22:20:14 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3] nfsrahead: fix linking while static linking
Message-ID: <YvVkftYtIgFhYHKk@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220809223308.1421081-1-giulio.benetti@benettiengineering.com>
 <20220810214554.107094-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810214554.107094-1-giulio.benetti@benettiengineering.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

nit (not worth of reposting): I'm not a native speaker, but IMHO subject should
be without while, e.g. "fix order on static linking"

Kind regards,
Petr
