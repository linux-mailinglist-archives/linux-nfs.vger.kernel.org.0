Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4B768905
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 00:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjG3WLe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jul 2023 18:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjG3WLe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jul 2023 18:11:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F41D10D3
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 15:11:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 14EB51F8A4;
        Sun, 30 Jul 2023 22:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690755092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4Gzu0UQHSbYf8d6PrfpRq7iOpvSg7bXLOhZcY4AVhY=;
        b=yzeC+UwQ6m60dDW4XbTC2A9ri9IG0/ZxXZQ7DlQDu+/EaFEttBkS5iF4VGg6Ll5/XiuSqM
        Q+yZ96jCGPhnxCBpkbOuuGsKjZn67wcymrLc8XWEIpFxtajp0R6T5sIfaObu+Rkxt/sal/
        2N8+6ycZvRZ/3SxEMTikcADO7qerwrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690755092;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4Gzu0UQHSbYf8d6PrfpRq7iOpvSg7bXLOhZcY4AVhY=;
        b=l7cYC0fn1EoCHfD3p48cW6OZazThqkd9+hU0jQNA4hzTNDUIoF1cXVduNS9t42J8Lk23H5
        ncZDZIkBo0SPxqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA3F013595;
        Sun, 30 Jul 2023 22:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M+LtHhLgxmRSPAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 30 Jul 2023 22:11:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/14] SUNRPC: change various server-side #defines to enum
In-reply-to: <ZMaIWPyEm83GaS0q@tissot.1015granger.net>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>,
 <168966228863.11075.8173252015139876869.stgit@noble.brown>,
 <ZLaVtpLf1k2Ig5Kz@bazille.1015granger.net>,
 <ZMaIWPyEm83GaS0q@tissot.1015granger.net>
Date:   Mon, 31 Jul 2023 08:11:27 +1000
Message-id: <169075508761.32308.11692865993389725826@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 31 Jul 2023, Chuck Lever wrote:
> On Tue, Jul 18, 2023 at 09:37:58AM -0400, Chuck Lever wrote:
> > On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
> > > When a sequence of numbers are needed for internal-use only, an enum is
> > > typically best.  The sequence will inevitably need to be changed one
> > > day, and having an enum means the developer doesn't need to think about
> > > renumbering after insertion or deletion.  The patch will be easier to
> > > review.
> > 
> > Last sentence needs to define the antecedant of "The patch".
> 
> I've changed the last sentence in the description to "Such patches
> will be easier ..."
> 
> I've applied 1/5 through 5/5, with a few cosmetic changes, to the
> SUNRPC threads topic branch. 6/6 needed more work:

Ah - ok.  I was all set to resubmit with various changes and
re-ordering.  I guess I waited too long.

> All this will appear in the nfsd repo later today.

Not yet....

Thanks,
NeilBrown
