Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94DB54F8CA
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jun 2022 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbiFQOAo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jun 2022 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiFQOAm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jun 2022 10:00:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D31E49C95
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jun 2022 07:00:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A3051FDE2;
        Fri, 17 Jun 2022 14:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655474438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q3rr3aPhLrEwOHHYNdteNM9KraN2JlMl7VuM/REa3rY=;
        b=PALWN24wJBJF6/jWaAZGLksrDH5woCHhkTwpnpN8I6RaBdSiGt5S2kh4tSd4hHTSKOcB02
        EAkVz6fAYdg7MyC39PF7bG+mWk9AoFlHRmHReKpRu2tXhUpy5/wNFXlxFIl6RxGLFwfQIL
        J/hWa45/RPwcxOEBtSyZ3/hy5ECQMDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655474438;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q3rr3aPhLrEwOHHYNdteNM9KraN2JlMl7VuM/REa3rY=;
        b=6O7qtjOOWaWNeLL+pt+ZUF9sykl7Jx7/jwHeifCA1SVrix1YCBEyRBKXqRPC2jlT4VC2vG
        +BNYX6X19VGz2uAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D383113458;
        Fri, 17 Jun 2022 14:00:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0tZ1MgWJrGIKIwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 17 Jun 2022 14:00:37 +0000
Date:   Fri, 17 Jun 2022 16:02:47 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, linux-nfs@vger.kernel.org,
        Steve Dickson <steved@redhat.com>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [LTP] [PATCH v2 7/9] tst_device: Add clear command
Message-ID: <YqyJh7ihWAeS6JEc@yuki>
References: <20220609214223.4608-1-pvorel@suse.cz>
 <20220609214223.4608-8-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609214223.4608-8-pvorel@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!
Looks good, but should go before the "add: $TST_ALL_FILESYSTEMS" right?

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
