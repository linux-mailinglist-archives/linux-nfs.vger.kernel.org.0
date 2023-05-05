Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9233E6F8364
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 14:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjEEM7t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 May 2023 08:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEEM7m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 May 2023 08:59:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0041CFD9
        for <linux-nfs@vger.kernel.org>; Fri,  5 May 2023 05:59:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 77A8E21E36;
        Fri,  5 May 2023 12:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683291580;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+gikjnsTNmzqSiYHO4Rp2dHiAjctlJpjrfoF2J1F5Dc=;
        b=FxbGYBQ59tkzrveiL+VWzUo8wb0AxWFg533yZhbSBx4CB2bX9JxRa/EOlcZoNmUX+C3NpY
        Fy6NOAXRdYXWE5aT5JUFnZawz3xNnfDiR3BHg3ivfZjHr3d4+dsz+9Pw4A40rZq2Qz+V+a
        nrcoFG37Llu/1oC23rlafd96xhzmGIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683291580;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+gikjnsTNmzqSiYHO4Rp2dHiAjctlJpjrfoF2J1F5Dc=;
        b=5b88zrPNYFNZDKnfokPetnNIcRlb//BawX1TGldM4t6D2+g5lmIuFe0MSw37++70oOVfo8
        mrpMCABb/WlQqIDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45B6E13513;
        Fri,  5 May 2023 12:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T+OkD7z9VGRERwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 05 May 2023 12:59:40 +0000
Date:   Fri, 5 May 2023 14:59:38 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, NeilBrown <neilb@suse.de>,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v5 5/5] nfs: Run on btrfs, ext4, xfs
Message-ID: <20230505125938.GA16082@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230504131414.3826283-1-pvorel@suse.cz>
 <20230504131414.3826283-6-pvorel@suse.cz>
 <ZFO6ywouPkmNKtkr@yuki>
 <20230504220037.GB4244@pevik>
 <20230504232321.GA25208@pevik>
 <ZFTjrmSdaJaf1Xyq@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFTjrmSdaJaf1Xyq@yuki>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Cyril,

> Hi!
> Let's get this merged with the sleeps for now and lets try to fix it
> properly after the release. You can push the patchset with my Ack.

Patchset merged, I guess we can freeze LTP before the release.
Thanks!

Kind regards,
Petr
