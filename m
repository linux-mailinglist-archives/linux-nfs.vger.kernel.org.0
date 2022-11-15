Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C7629C0B
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Nov 2022 15:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiKOO0C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Nov 2022 09:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKOO0B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Nov 2022 09:26:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB32AC5;
        Tue, 15 Nov 2022 06:25:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5E063CE1754;
        Tue, 15 Nov 2022 14:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E86AC433D7;
        Tue, 15 Nov 2022 14:25:56 +0000 (UTC)
Date:   Tue, 15 Nov 2022 09:26:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] trace: Relocate event helper files
Message-ID: <20221115092638.62cb7322@gandalf.local.home>
In-Reply-To: <166843895843.170837.8663873976042560070.stgit@klimt.1015granger.net>
References: <166843895843.170837.8663873976042560070.stgit@klimt.1015granger.net>
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

On Mon, 14 Nov 2022 10:16:12 -0500
Chuck Lever <chuck.lever@oracle.com> wrote:

> Steven Rostedt says:
> > The include/trace/events/ directory should only hold files that
> > are to create events, not headers that hold helper functions.
> >
> > Can you please move them out of include/trace/events/ as that
> > directory is "special" in the creation of events.  
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  drivers/infiniband/core/cm_trace.h  |    2 
>  drivers/infiniband/core/cma_trace.h |    2 
>  fs/nfs/nfs4trace.h                  |    6 -
>  fs/nfs/nfstrace.h                   |    6 -
>  include/trace/events/fs.h           |  122 -----------
>  include/trace/events/nfs.h          |  375 -----------------------------------
>  include/trace/events/rdma.h         |  168 ----------------
>  include/trace/events/rpcgss.h       |    2 
>  include/trace/events/rpcrdma.h      |    4 
>  include/trace/events/sunrpc.h       |    2 
>  include/trace/events/sunrpc_base.h  |   18 --
>  include/trace/misc/fs.h             |  122 +++++++++++
>  include/trace/misc/nfs.h            |  375 +++++++++++++++++++++++++++++++++++
>  include/trace/misc/rdma.h           |  168 ++++++++++++++++
>  include/trace/misc/sunrpc.h         |   18 ++
>  15 files changed, 695 insertions(+), 695 deletions(-)
>  delete mode 100644 include/trace/events/fs.h
>  delete mode 100644 include/trace/events/nfs.h
>  delete mode 100644 include/trace/events/rdma.h
>  delete mode 100644 include/trace/events/sunrpc_base.h
>  create mode 100644 include/trace/misc/fs.h
>  create mode 100644 include/trace/misc/nfs.h
>  create mode 100644 include/trace/misc/rdma.h
>  create mode 100644 include/trace/misc/sunrpc.h
> 
> Note: with an Acked-by from both the NFS client and RDMA core
> maintainers I can take this through the nfsd for-next tree, unless
> someone has another suggestion.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
