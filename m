Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2923F7EA2D2
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 19:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjKMSaU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 13:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjKMSaT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 13:30:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C90D75
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 10:30:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2581321906;
        Mon, 13 Nov 2023 18:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699900214;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQmb7sqCPozsfoSaQktmcGPlLwbM9ywgWhDHHFoJQ2Q=;
        b=CWkEhPndATWYVncvKlqmOrSq71matEuDOPhCXg8Fmrk1eMhGV++BFV3J/iz308VPT/NgCW
        vWF9K/9qVL03SwCyIK5IpOHkRCGA3y5Ds0gx41bYoCypze8cvwCAac4uXYMO5qPwOBoLG5
        zj9JBM6GPz5gc7U/6sQy1qXv0/H8icQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699900214;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQmb7sqCPozsfoSaQktmcGPlLwbM9ywgWhDHHFoJQ2Q=;
        b=ArjTdolqkev8bQaBeJXsjy45Ov4qFuTZJBHYgkGLk5IRavVaHPYnxQgqtr3v/U0Kb2gSvw
        lUw5Ys56oc+7PnBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7CDE13398;
        Mon, 13 Nov 2023 18:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H+UVJjVrUmV7JwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 13 Nov 2023 18:30:13 +0000
Date:   Mon, 13 Nov 2023 19:30:11 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Petr Vorel <petr.vorel@gmail.com>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [PATCH 1/1] libtirpc: Add detection for new rpc_gss_sec members
Message-ID: <20231113183011.GA2247997@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20231025180141.416189-1-pvorel@suse.cz>
 <900689ef-3f63-4c54-b986-f612c4b2109c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900689ef-3f63-4c54-b986-f612c4b2109c@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,

Thanks for having a look.

> Hello,

> On 10/25/23 2:01 PM, Petr Vorel wrote:
> > From: Petr Vorel<petr.vorel@gmail.com>

> > 4b272471 started to use struct rpc_gss_sec member minor_status, which
> > was added in new libtirpc 1.3.4. Add check for the member to prevent
> > failure on older libtirpc headers.

> > Fixes: 4b272471 ("gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials")
> > Signed-off-by: Petr Vorel<pvorel@suse.cz>
> > ---
> >   aclocal/libtirpc.m4 | 4 ++++
> >   1 file changed, 4 insertions(+)

> > diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
> > index bddae022..dd351722 100644
> > --- a/aclocal/libtirpc.m4
> > +++ b/aclocal/libtirpc.m4
> > @@ -25,6 +25,10 @@ AC_DEFUN([AC_LIBTIRPC], [
> >                            [AC_DEFINE([HAVE_LIBTIRPC_SET_DEBUG], [1],
> >                                       [Define to 1 if your tirpc library provides libtirpc_set_debug])],,
> >                            [${LIBS}])])
> > +     AS_IF([test "$enable_gss" = "yes"],
> > +           [AC_CHECK_MEMBER(struct rpc_gss_sec.minor_status,,
> > +                         [AC_MSG_ERROR([Missing rpc_gss_sec.minor_status in <rpc/auth_gss.h>, update libtirpc or run with --disable-gss])],
> > +                         [#include <rpc/auth_gss.h>])])
> >     AC_SUBST([AM_CPPFLAGS])
> >     AC_SUBST(LIBTIRPC)
> > -- 2.42.0

> This does not work... since it is looking at that gssrpc/auth_gss.h
> instead of the tirpc/rpc/auth_gss.h so the check fails
Is it? There is no <gssrpc/auth_gss.h>. I suppose you test on some recent
Fedora, I'll retest it.

I tested it on openSUSE Tumbleweed, where libtirpc-devel is
installed into /usr/include/rpc/, thus /usr/include/rpc/auth_gss.h exists.
But on Debian (and likely on RHEL/Fedora as you noticed it) is on
/usr/include/tirpc/rpc/auth_gss.h.

I hoped that this is handled elsewhere via -I/usr/include/tirpc.
So, I'm really confused why would have look at <gssrpc/auth_gss.h>.

Kind regards,
Petr

> I like the idea of having the check, but I'm not sure on
> how to point it in the right direction.

> steved.
