Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA166293A9
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Nov 2022 09:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiKOIz0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Nov 2022 03:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiKOIzL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Nov 2022 03:55:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D1820BD8;
        Tue, 15 Nov 2022 00:55:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFA3D61576;
        Tue, 15 Nov 2022 08:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9A4C433D7;
        Tue, 15 Nov 2022 08:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668502510;
        bh=YQt8dY+TTo+k+xH93ToB9Kla1gbOkIvs+B7HgkneBzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SafA/O9IFTMH486enCSQ1mSkVVGcsN/txRSQAHrK2/bmjfB9qjAE0WE9w26WCrFQU
         vvQi+MUmnMbzOx8jcQ5CRNkjWZzU2cwNSstDFIdY2NNM9p5J0TfWzuvN2MpEGEw3Ez
         dV71MMYBluVg9rMLoP1PdfapnMtQouN0Ro0JhalqizHslS9lyOYgSl2jHQWZf1zZph
         h2TQ/BJmnyT6jNSUPJOdmW3SJk5UjgoF5eijcoG1Gt5O2U63AXhAoHKVdfbor7nRIl
         haV9Ae6xGWBFZ1CRKOrMPyKryJqgRe5F7X3zLLOANzEVbo2xNXsWVjtj60GShamDDd
         bl2QJrSJB+80g==
Date:   Tue, 15 Nov 2022 10:55:06 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     rostedt@goodmis.org, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] trace: Relocate event helper files
Message-ID: <Y3NT6sCGhtf16FaO@unreal>
References: <166843895843.170837.8663873976042560070.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166843895843.170837.8663873976042560070.stgit@klimt.1015granger.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 14, 2022 at 10:16:12AM -0500, Chuck Lever wrote:
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

Please update MAINTAINERS file too.

diff --git a/MAINTAINERS b/MAINTAINERS
index 4db8e4e02c05..86e57325eb6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10054,6 +10054,7 @@ F:      drivers/infiniband/
 F:     include/rdma/
 F:     include/trace/events/ib_mad.h
 F:     include/trace/events/ib_umad.h
+F:     include/trace/misc/rdma.h
 F:     include/uapi/linux/if_infiniband.h
 F:     include/uapi/rdma/
 F:     samples/bpf/ibumad_kern.c


Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
