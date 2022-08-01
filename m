Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595C3586CEE
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiHAOfa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 10:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiHAOfa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 10:35:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9519729C92
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 07:35:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 540EE4DF2B;
        Mon,  1 Aug 2022 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659364527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tzPoVXo/eN+CAZh7akQYfwNVkaFgpFdO5btoRyxgKuc=;
        b=oxvwQsVV86evhqdrbe1wfblF/NDvZknI/hWJZnv/aKZhmw6ThzVcUAr/3umo6xo6L4ifLl
        XQBCUJkuOVeNh1BQV1J1WN0d69H3+H/mJFcM2KsMEiCKAwvqGpJEMqe0CxNQ5vQl7X4xjF
        DphGF4m68eYeINAkZ09s7EutQ1DEsno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659364527;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tzPoVXo/eN+CAZh7akQYfwNVkaFgpFdO5btoRyxgKuc=;
        b=Jo/vlhjlChb1ty5mI/zEaU15l8lguzcqE6fALs4WtsJN/LPS168d4bAZetaoqaYVwsqfD2
        sLL/Y1Id2gp5DXAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2201F13AAE;
        Mon,  1 Aug 2022 14:35:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6e9oBq/k52IOXAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 01 Aug 2022 14:35:27 +0000
Date:   Mon, 1 Aug 2022 16:35:25 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, linux-nfs@vger.kernel.org,
        Chen Hanxiao <chenhx.fnst@fujitsu.com>
Subject: Re: [RFC PATCH 1/1] metaparse: Replace macro also in arrays
Message-ID: <YufkrU5Z1GCsBhcU@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220729153246.1213-1-pvorel@suse.cz>
 <YufMST1r0+ciz2c4@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YufMST1r0+ciz2c4@yuki>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> Hi!
> > This helps to replace macros like:

> >     #define TEST_APP "userns06_capcheck"

> >     static const char *const resource_files[] = {
> > 	TEST_APP,
> > 	NULL,
> >     };

> > $ ./metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ ../testcases/kernel/containers/userns/userns06.c
> > Before:
> >    "resource_files": [
> >      "TEST_APP"
> >     ],
> >     ...

> > After:
> >    "resource_files": [
> >      "userns06_capcheck"
> >     ],
> >     ...

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi all,

> > This is a reaction on patch
> > https://patchwork.ozlabs.org/project/ltp/patch/20220722083529.209-1-chenhx.fnst@fujitsu.com/
> > First: I was wrong, inlining arrays does any change in the docparse output.
> > BTW I'd be still for inlining for better readability.

> > I'm not sure if this is not good idea, maybe some of the constants should be
> > kept unparsed, e.g.:

> > Orig:
> >    "caps": [
> >      "TST_CAP",
> >      "(",
> >      "TST_CAP_DROP",
> >      "CAP_SYS_RESOURCE",

> > Becomes:
> >    "caps": [
> >      "TST_CAP",
> >      "(",
> >      "TST_CAP_DROP",
> >      "24",

> > CAP_SYS_RESOURCE is replaced because it's a string, but IMHO it'd be better to keep it.
> > TST_CAP{_DROP,} aren't replaced because they aren't a plain strings.
> > Maybe replace only non-numerc values?

> That really depends on the context, we do have many cases where we have
> a macro that expands to numeric that should be expanded, runtime would
> be one of the prime examples of that.
Yep.

> I guess that the only solution would be an explicit list of macro
> prefixes that should not be expanded, e.g. do not expand if macro starts
> with "CAP_".

Good idea, thanks! I was thinking about rewrite parsing to sparse, but you would
not like it as being slow. This is indeed a better solution.

Kind regards,
Petr
