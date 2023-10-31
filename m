Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058B37DD726
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 21:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjJaUkw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 16:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjJaUkv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 16:40:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF6AF9
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 13:40:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AC6F51F38C;
        Tue, 31 Oct 2023 20:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698784847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTCYKilYfpB3yt9VGpAyi+x0xIG4jRgqYzB0R8UJYxs=;
        b=WRaxd39mB8syQPqQZrqME5wDamWCJ3KC2dNVTSHz7jiJn2aRITLy+QQbWV+VN+7XfWSW7O
        EpS4Ucu8QhIjygIT2xXq7uzqgmagufVg13gg3g52/VZuw2ilZfgsW/ykQSTYAuVOdtOD6h
        DsU2w2sH917ANIEZN6eEvJ8JqRu6Zjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698784847;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTCYKilYfpB3yt9VGpAyi+x0xIG4jRgqYzB0R8UJYxs=;
        b=G5wUNfot3LMquWzpb0/jx62Uy0CcMLFbX2fFNZ5e7ql+k+AQUsM9MJ8VweVXXw/g5Xvt9t
        170DB4KnGppfGrAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A35A1138EF;
        Tue, 31 Oct 2023 20:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jYufFk1mQWUFTQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 31 Oct 2023 20:40:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 0/5] sunrpc: not refcounting svc_serv
In-reply-to: <9BA28F70-A3FC-4EC4-A638-A27C1867F221@oracle.com>
References: <20231030011247.9794-1-neilb@suse.de>,
 <9BA28F70-A3FC-4EC4-A638-A27C1867F221@oracle.com>
Date:   Wed, 01 Nov 2023 07:40:42 +1100
Message-id: <169878484259.24305.17786556797570881562@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 01 Nov 2023, Chuck Lever III wrote:
> 
> > On Oct 29, 2023, at 6:08 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > This patch set continues earlier work of improving how threads and
> > services are managed.  Specifically it drop the refcount.
> > 
> > The refcount is always changed under the mutex, and almost always is
> > exactly equal to the number of threads.  Those few cases where it is
> > more than the number of threads can usefully be handled other ways as
> > see in the patches.
> > 
> > The first patches fixes a potential use-after-free when adding a socket
> > fails.  This might be the UAF that Jeff mentioned recently.
> > 
> > The second patch which removes the use of a refcount in pool_stats
> > handling is more complex than I would have liked, but I think it is
> > worth if for the result seen in 4/5 of substantial simplification.
> 
> So I need a v2 of this series, then...
> 
>  - Move 4/5 to the beginning of the series (patch 1 or 2, doesn't matter)

I don't understand....  2 and 3 are necessary prerequisites for 4.  The
remove places where the refcount is used.

> 
>  - Add R-b, Fixes, and Cc: stable tags to those two patches

Will do

> 
>  - Address Jeff's other comments

Yep.

> 
> AFAICT the 0-day bot reports were for the admin-revoked state series,
> not this one.

Agreed.

NeilBrown

> 
> 
> --
> Chuck Lever
> 
> 
> 

