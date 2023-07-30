Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5E3768937
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 00:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjG3W4K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jul 2023 18:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3W4J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jul 2023 18:56:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4AB123
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 15:56:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E60C1FD70;
        Sun, 30 Jul 2023 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690757767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8P4DO5Yb8MoO5coRiagQZZdayB7j5qMvXy/df7rnMFU=;
        b=romHa/+Bk0YUUuFl0PJsgyKTJU/9hYofjMhOfZkbh81rDsh5Kq4YOZ+LQ+fThj8fMMj3WZ
        59CWAJ4L2e4tQeeL8K654Bh18CM3mTcJCXujOP0tScHFEucD5qNJD9TgKiYQMr73AX5CmK
        Ub6l76OjkusSlEUGxvoyOM3UjGvKthw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690757767;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8P4DO5Yb8MoO5coRiagQZZdayB7j5qMvXy/df7rnMFU=;
        b=WxvtvdZg9Fnbd7mbUV1Ou5lrdbMfuNNY1Zz+zvleAv661xKrXHLHsJE/38WfVQ8lCkm4jZ
        JQ9rkSXtNDFcYEAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41D1413274;
        Sun, 30 Jul 2023 22:56:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P8NMOYXqxmSrSgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 30 Jul 2023 22:56:05 +0000
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
Date:   Mon, 31 Jul 2023 08:56:03 +1000
Message-id: <169075776306.32308.3045406213067424206@noble.neil.brown.name>
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
> 
> I've split this into one patch for each new enum.

I don't see this in topic-sunrpc-thread-scheduling
Commit 11a5027fd416 ("SUNRPC: change various server-side #defines to enum")
contains 3 new enums, and the XPT_ and SVC_GARBAGE improvements you
mention below cannot be found.

Thanks,
NeilBrown


> 
> The XPT_ flags change needed TRACE_DEFINE_ENUM macros to make
> show_svc_xprt_flags() work properly. Added.
> 
> The new enum for SVC_GARBAGE and friends... those aren't bit flags.
> So I've made that a named enum so that it can be used for type-
> checking function return values properly.
> 
> I dropped the hunk that changes XPRT_SOCK_CONNECTING and friends.
> That should be submitted separately to Anna and Trond.
> 
> All this will appear in the nfsd repo later today.
