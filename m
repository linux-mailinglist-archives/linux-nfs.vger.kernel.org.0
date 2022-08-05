Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2697158A8D4
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Aug 2022 11:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbiHEJcp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Aug 2022 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiHEJco (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Aug 2022 05:32:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DF9101CA
        for <linux-nfs@vger.kernel.org>; Fri,  5 Aug 2022 02:32:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E860B20329;
        Fri,  5 Aug 2022 09:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659691961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0G0uLbaaUiW/DLpzUjyIgCLqiJXod15Uj+qglPR6Ej4=;
        b=DiG4+kEvZb0XL9LNyqQuxyQ4heGbqtkXj147kiK51B3SU1MbNOmweDNi4OEDFWxJYGHa50
        hxo0911gwwEvVXYcJ4v1hzICycT+xW6Ygtmi11HO4PtHg+inyGAZduIsvBqAmh+Lu01CoN
        NEV4tksgilVnCnwo4FgiGFQ0fWivEtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659691961;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0G0uLbaaUiW/DLpzUjyIgCLqiJXod15Uj+qglPR6Ej4=;
        b=TcNaoQLg5nXFkEYsiH6XbI2L9Z3d1Z/jR36TPE4J8WgAcxCgdBAXmCu4zQxau9Y4x9Y4j3
        UeyLagjbiK++5gDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7F7E133B5;
        Fri,  5 Aug 2022 09:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gkb7Lrnj7GKHVQAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 05 Aug 2022 09:32:41 +0000
Date:   Fri, 5 Aug 2022 11:34:31 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, linux-nfs@vger.kernel.org,
        Andrea Cervesato <andrea.cervesato@suse.com>
Subject: Re: [PATCH 1/1] aiodio: Fix format string for 32bit
Message-ID: <YuzkJ8cwOVEEkAVT@yuki>
References: <20220803173211.14292-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803173211.14292-1-pvorel@suse.cz>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!
> On 32bit char pointer is int and size_t is unsigned int,
> Cast to long / unsigned long.

Actually char pointer is char pointer, that is not an integer type at
all. If you do a pointer difference you end up with an signed integer
value of ptrdiff_t type, because unlike the result of sizeof(foo)
pointer difference can be negative as well. In C99 ptrdiff_t can be
printed as %td see the "Length modifier" part of man 3 printf.

-- 
Cyril Hrubis
chrubis@suse.cz
