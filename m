Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632ED580233
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiGYPt1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 11:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiGYPtY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 11:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105DE10FCA;
        Mon, 25 Jul 2022 08:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95738612D3;
        Mon, 25 Jul 2022 15:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC67C341C6;
        Mon, 25 Jul 2022 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658764163;
        bh=A6qZ/untHbxlIp2KOs+BpgbUVJKBdBN1BXQ5vjbkYEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yi/5PyKEtN0crh7payLUUz8KbToSKkcQ6NsVpPclFTErXXO8MwQih0VkK1nCVNbax
         ZhdfQhiPnK+L0js8pO7lGne0SuriLCdMX7z+5LX8ZnD2xnU/mkequTgoS/jzZkBXdk
         p+kPs7kw8U1spWnMspKwchkMLlAa3n4tsLJ334vyj9xfkweboTwuSyiR/N59MOV7gA
         AbWDz7Z8bDOirNR/mra/kELJYfqdxIGt5FQLfVuymu4Sj8JUFSCBt+NM2ci+zYbecb
         gqgw9PUUFJIaTa1xQyd9JPXQvtJZLI5BxyOXg9A+D5oqbOulv6rcEOxDO3YDJsq7uC
         TDUYXfIItnwxw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 213F640374; Mon, 25 Jul 2022 12:49:20 -0300 (-03)
Date:   Mon, 25 Jul 2022 12:49:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] SUNRPC: Replace dprintk() call site in xs_data_ready
Message-ID: <Yt67gCcZfOEJizay@kernel.org>
References: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
 <165851074247.361126.17205394769981595871.stgit@morisot.1015granger.net>
 <66371b9db4210fe853e98a8ec68b0f780ba886af.camel@hammerspace.com>
 <9FDA46D8-4D6E-49B0-A583-D0FF739111BF@oracle.com>
 <20220722162212.3d080c23@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722162212.3d080c23@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Em Fri, Jul 22, 2022 at 04:22:12PM -0400, Steven Rostedt escreveu:
> [ Added the user space perf folks ]
> 
> On Fri, 22 Jul 2022 18:45:30 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
> 
> > >> +TRACE_EVENT(xs_data_ready,
> > >> +  TP_PROTO(
> > >> +  const struct rpc_xprt *xprt
> > >> +  ),
> > >> +
> > >> +  TP_ARGS(xprt),
> > >> +
> > >> +  TP_STRUCT__entry(
> > >> +  __sockaddr(addr, xprt->addrlen)
> > >> +  ),
> > >> +
> > >> +  TP_fast_assign(
> > >> +  __assign_sockaddr(addr, &xprt->addr, xprt->addrlen);
> > >> +  ),
> > >> +
> > >> +  TP_printk("peer=%pISpc", __get_sockaddr(addr))  
> > > 
> > > NACK. Please resolve and store the string up front instead of storing
> > > the sockaddr. Most versions of perf can't resolve those kernel-specific
> > > %p printks and just end up barfing on them.  
> > 
> > Interesting. We added get_sockaddr() to avoid this issue in
> > trace-cmd. Sounds like perf needs to be fixed up too, or
> > maybe this is another case of having an old libtraceevent?
> > 
> > Meanwhile, I can revert this back to the old way of handling
> > presentation addresses.
> > 
> 
> Hmm, I thought that perf now uses the external libtraceevent.
> 
> Perhaps it hasn't been updated to the latest release that has the ability
> to parse this.
> 
> Maybe just install
> 
>   git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git

To use it one has to use:

  make -C tools/perf LIBTRACEEVENT_DYNAMIC=1

Then we get it linked with libtraceevent-devel:

$ ldd ~/bin/perf | grep traceevent
	libtraceevent.so.1 => /lib64/libtraceevent.so.1 (0x00007faa50f93000)
$

Perhaps it'd be better to check if libtracevent-devel is installed and
use it, falling back to tools/lib/traceevent/ and then adding a warning
that the in-tree codebase is being used?

- Arnaldo
