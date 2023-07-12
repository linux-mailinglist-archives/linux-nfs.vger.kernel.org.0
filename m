Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065917505D9
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jul 2023 13:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjGLLSp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jul 2023 07:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGLLSW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jul 2023 07:18:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9848EE49
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jul 2023 04:18:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3FA392229E;
        Wed, 12 Jul 2023 11:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689160700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HaufsLrGe7M5bdyvz/qn8BH8v0A8g+v4xa53gqehDbo=;
        b=tfmYm/LqU0tUxgxQshwi7b9OUELi38AE0PA3ywSAI7aZtwl7d+qDtjr1Y4ZFCBSRtSJ57k
        eXkn4PZTipzdA2Pr+B6kPz0kGtmg5v9BY+w4sSg3Gh70WIF++kkEHwePDLjPzd0MgJP+EZ
        4THBG3WMHH4+GPe6I+vZPJTKmTp/4os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689160700;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HaufsLrGe7M5bdyvz/qn8BH8v0A8g+v4xa53gqehDbo=;
        b=1xkAPsnBFC19E7RsovZYdyHEGCW40KcsQ3MIXYO+7J+D+FTt5l6qlFlYD1+VM0LKsAehby
        tSEwqY68tTl0X+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E873D133DD;
        Wed, 12 Jul 2023 11:18:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k/+bNvuLrmQIJwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 12 Jul 2023 11:18:19 +0000
Date:   Wed, 12 Jul 2023 13:18:18 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ltp@lists.linux.it,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] runtest/net.nfs: Run nfs02_06 on TCP only
Message-ID: <20230712111818.GA775074@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230622084648.490498-1-pvorel@suse.cz>
 <e4d22ae6cefb34463ed7d04287ca9e81cd0949d8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d22ae6cefb34463ed7d04287ca9e81cd0949d8.camel@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff,

> On Thu, 2023-06-22 at 10:46 +0200, Petr Vorel wrote:
> > UDP support disabled was on NFS server in kernel 5.6.
> > Due that 2 of 3 nfs06.sh tests runs are being skipped on newer kernels.

> > Therefore NFSv3 job in nfs02_06 test as TCP. This way all jobs in the
> > test are TCP, thus test will not be skipped. This also bring NFSv3
> > testing also under TCP (previously it was tested only on UDP).

> > Keep UDP in nfs01_06 jobs, so that NFSv3 on UDP is still covered for
> > older kernels.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  runtest/net.nfs | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/runtest/net.nfs b/runtest/net.nfs
> > index 72cf4b307..15a960017 100644
> > --- a/runtest/net.nfs
> > +++ b/runtest/net.nfs
> > @@ -58,7 +58,7 @@ nfs41_ipv6_05 nfs05.sh -6 -v 4.1 -t tcp
> >  nfs42_ipv6_05 nfs05.sh -6 -v 4.2 -t tcp

> >  nfs01_06  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
> > -nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "udp,tcp,tcp,tcp,tcp,tcp"
> > +nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
> >  nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"

> >  nfs3_07 nfs07.sh -v 3 -t udp

> UDP support is more or less being deprecated at this point, so testing
> on tcp is preferred.

> Acked-by: Jeff Layton <jlayton@kernel.org>

too late to add the ack to the commit message (already merged),
but thanks for your confirmation.

FYI I kept some UDP testing because new LTP releases are sometimes used with
*not so old* enterprise distros. But these UDP tests are single tests (there is
one test run under TCP and one under UDP). nfs06.sh is specific that it combines
6 various NFS versions and TCP + UDP, and single UDP causes whole specific test
run being cancelled. And again, I still kept nfs01_06 which uses older NFS (ver
3 and 4) with original UDP for older distros.

Interesting question is when to drop UDP testing completely. I guess few years
after kernel 5.6 was released, when all major enterprise distros are based on
kernel >= 5.6 and there are no stable/LTS with older kernel (e.g. in 2026, when
5.4 and older LTS will be EOL).

Kind regards,
Petr
