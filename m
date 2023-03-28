Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF906CC092
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Mar 2023 15:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjC1NXS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Mar 2023 09:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjC1NXP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Mar 2023 09:23:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D542FD3
        for <linux-nfs@vger.kernel.org>; Tue, 28 Mar 2023 06:23:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 898FE1F8B8;
        Tue, 28 Mar 2023 13:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680009789;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9kIZldL9DC/HWWMxCKKSH9nuMpZLU/I/S+0SivZ0W8I=;
        b=nrN0tAFBasEihch+SogrT++p1gHqKWhdJiHUqNstCwHFByY8FlRTFq9Hf/xHueoZmtXud0
        QNY7WIYJpv1MV1anKHwLcMlgjptQcPU/UlUIPQw3DEoldpO+vFUEI+Lcdb39fz3qxzqrNG
        f47XW2Z5pl79sfH4EJ9W8ks6PhtKnrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680009789;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9kIZldL9DC/HWWMxCKKSH9nuMpZLU/I/S+0SivZ0W8I=;
        b=yreTaBo1knFXC0j6if0G/XnJ+e90nad/qzCcjXQqRypA8Yb+lDWUTzeWxtxfbhAOaLw89n
        qziRKrBAyyGp2xAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0254F1390B;
        Tue, 28 Mar 2023 13:23:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id if/1OTzqImTDUwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 28 Mar 2023 13:23:08 +0000
Date:   Tue, 28 Mar 2023 15:23:07 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     calum.mackay@oracle.com, bfields@fieldses.org,
        ffilzlnx@mindspring.com, linux-nfs@vger.kernel.org,
        Frank Filz <ffilz@redhat.com>
Subject: Re: [pynfs PATCH v2 5/5] LOCK24: fix the lock_seqid in second lock
 request
Message-ID: <20230328132307.GA780540@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230313112401.20488-1-jlayton@kernel.org>
 <20230313112401.20488-6-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313112401.20488-6-jlayton@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff,

thanks for fixing a long standing issue.

Tested-by: Petr Vorel <pvorel@suse.cz>
(on openSUSE and SLES)

Kind regards,
Petr
