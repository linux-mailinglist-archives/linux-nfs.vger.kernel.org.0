Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BAD74E116
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 00:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjGJWaW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 18:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGJWaV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 18:30:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD23197
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 15:30:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 12AA422550;
        Mon, 10 Jul 2023 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689028218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vc6gW8GD0lt5DasnDckChkHC6xnbLIc/234m/k+yBFU=;
        b=wUfyqNvWnwxG53bpQLbQfhwQ3kIV9XM4UhO6W1zUTYHgBnHfJLXmwU9kr78lPq7HoG8Ef3
        PQNCj8xG0QDtivYC3tmn97x1WiLe6kumCF6ZCmoGKCrPbQcWpP/gOQsab48+s0QFaXh7Zx
        MBxUKocj4SXz/T+mC/z56S/E+9/1du8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689028218;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vc6gW8GD0lt5DasnDckChkHC6xnbLIc/234m/k+yBFU=;
        b=xnM3m56afaREaDnLrqa7RofbbD95vNzaqS8y9PoF5EHuqZbE0Xsmsyijvy60n0Y4QoRbEx
        3hD5KtiVgm4uOxAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D958F1361C;
        Mon, 10 Jul 2023 22:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id auDNIneGrGSxewAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 10 Jul 2023 22:30:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@redhat.com>
Cc:     "Chuck Lever" <cel@kernel.org>, linux-nfs@vger.kernel.org,
        "Chuck Lever" <chuck.lever@oracle.com>, lorenzo@kernel.org,
        david@fromorbit.com
Subject: Re: [PATCH v3 0/9] SUNRPC service thread scheduler optimizations
In-reply-to: <132490dda81e93b2f5145ee210167b4c3d0d2cd1.camel@redhat.com>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>,
 <132490dda81e93b2f5145ee210167b4c3d0d2cd1.camel@redhat.com>
Date:   Tue, 11 Jul 2023 08:30:12 +1000
Message-id: <168902821270.8939.5953157228100878959@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 11 Jul 2023, Jeff Layton wrote:
> 
> You can add my Reviewed-by to the first 7 patches. The last two are not
> quite there yet, I think, but I like how they're looking so far.

Similarly here is my r-b for the first 7

 Reviewed-By: NeilBrown <neilb@suse.de>

NeilBrown
