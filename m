Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC1C57E83F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 22:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiGVUWS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiGVUWR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 16:22:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43522326E8;
        Fri, 22 Jul 2022 13:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03584B82A6E;
        Fri, 22 Jul 2022 20:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978EDC341C6;
        Fri, 22 Jul 2022 20:22:13 +0000 (UTC)
Date:   Fri, 22 Jul 2022 16:22:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] SUNRPC: Replace dprintk() call site in
 xs_data_ready
Message-ID: <20220722162212.3d080c23@gandalf.local.home>
In-Reply-To: <9FDA46D8-4D6E-49B0-A583-D0FF739111BF@oracle.com>
References: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
        <165851074247.361126.17205394769981595871.stgit@morisot.1015granger.net>
        <66371b9db4210fe853e98a8ec68b0f780ba886af.camel@hammerspace.com>
        <9FDA46D8-4D6E-49B0-A583-D0FF739111BF@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[ Added the user space perf folks ]

On Fri, 22 Jul 2022 18:45:30 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> >> +TRACE_EVENT(xs_data_ready,
> >> +  TP_PROTO(
> >> +  const struct rpc_xprt *xprt
> >> +  ),
> >> +
> >> +  TP_ARGS(xprt),
> >> +
> >> +  TP_STRUCT__entry(
> >> +  __sockaddr(addr, xprt->addrlen)
> >> +  ),
> >> +
> >> +  TP_fast_assign(
> >> +  __assign_sockaddr(addr, &xprt->addr, xprt->addrlen);
> >> +  ),
> >> +
> >> +  TP_printk("peer=%pISpc", __get_sockaddr(addr))  
> > 
> > NACK. Please resolve and store the string up front instead of storing
> > the sockaddr. Most versions of perf can't resolve those kernel-specific
> > %p printks and just end up barfing on them.  
> 
> Interesting. We added get_sockaddr() to avoid this issue in
> trace-cmd. Sounds like perf needs to be fixed up too, or
> maybe this is another case of having an old libtraceevent?
> 
> Meanwhile, I can revert this back to the old way of handling
> presentation addresses.
> 

Hmm, I thought that perf now uses the external libtraceevent.

Perhaps it hasn't been updated to the latest release that has the ability
to parse this.

Maybe just install

  git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git

?

-- Steve

