Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E977258026A
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 18:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiGYQHH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 12:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbiGYQHG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 12:07:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496B9BE22;
        Mon, 25 Jul 2022 09:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00283B81011;
        Mon, 25 Jul 2022 16:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859CCC341C6;
        Mon, 25 Jul 2022 16:07:01 +0000 (UTC)
Date:   Mon, 25 Jul 2022 12:06:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] SUNRPC: Replace dprintk() call site in
 xs_data_ready
Message-ID: <20220725120659.1a00a3e2@gandalf.local.home>
In-Reply-To: <Yt67gCcZfOEJizay@kernel.org>
References: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
        <165851074247.361126.17205394769981595871.stgit@morisot.1015granger.net>
        <66371b9db4210fe853e98a8ec68b0f780ba886af.camel@hammerspace.com>
        <9FDA46D8-4D6E-49B0-A583-D0FF739111BF@oracle.com>
        <20220722162212.3d080c23@gandalf.local.home>
        <Yt67gCcZfOEJizay@kernel.org>
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

On Mon, 25 Jul 2022 12:49:20 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Perhaps it'd be better to check if libtracevent-devel is installed and
> use it, falling back to tools/lib/traceevent/ and then adding a warning
> that the in-tree codebase is being used?

Yeah, this is the way trace-cmd went. For a few releases, it would just
warn that it couldn't find the system libraries, and then fall back to the
internals, and then it finally just removed the internals and failed with a
message stating where to get the necessary libraries.

-- Steve
