Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A911472C886
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbjFLOa1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbjFLOaL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:30:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B044E4C08
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 07:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5060A62A25
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 14:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4BDC433D2;
        Mon, 12 Jun 2023 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686580051;
        bh=4R8Qly2i9ytenrdlDwzObOgHpl/X+jcap9F0mmf2AEI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gL3uueyNSWflI5hOQuESbDdJ9L2hb1lxMFBEdoyP6Adg7TbVc6YnajWkR1M8dV5sM
         4gT9CUBi9rpicGMVf3RaJ0gyloT4FPWiw3jBldgX+XJmolIU4njCNS5L01r23bPzJC
         sty8FpRC61uiUR33AU1ze0lI0fPfEC2drEAfQZvW7GSvTbM0Lb5tBIct0Xe8eQjoFy
         zj2AF+z7kTb6o3bI3ScvTi2/HLxi/bmhnXWRtfHsPhzfmHfgKPjJHIlvpZLi+BhD1r
         xl0jzVzZ9OJHHmuo7bhkeAAHhLRHYRztoe7dfss7OOTlYSmM/PyUVw5B2oXYWABsp5
         9UqD/ez+vDcIA==
Message-ID: <0946f8f0d8d1901ade3396b84931110d6dea5785.camel@kernel.org>
Subject: Re: [PATCH v1 0/7] Several minor NFSD clean-ups
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 12 Jun 2023 10:27:30 -0400
In-Reply-To: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
References: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-06-12 at 10:13 -0400, Chuck Lever wrote:
> These are not strongly related to each other, but there was a whole
> collection such that I didn't feel like posting each individually.
>=20
> ---
>=20
> Chuck Lever (7):
>       SUNRPC: Move initialization of rq_stime
>       NFSD: Add an nfsd4_encode_nfstime4() helper
>       svcrdma: Convert "might sleep" comment into a code annotation
>       svcrdma: trace cc_release calls
>       svcrdma: Remove an unused argument from __svc_rdma_put_rw_ctxt()
>       SUNRPC: Fix comments for transport class registration
>       SUNRPC: Remove transport class dprintk call sites
>=20
>=20
>  fs/nfsd/nfs4xdr.c                     | 46 +++++++++++++++------------
>  include/trace/events/rpcrdma.h        |  8 +++++
>  net/sunrpc/svc_xprt.c                 | 18 ++++++++---
>  net/sunrpc/xprtrdma/svc_rdma_rw.c     | 14 ++++----
>  net/sunrpc/xprtrdma/svc_rdma_sendto.c |  2 ++
>  5 files changed, 58 insertions(+), 30 deletions(-)
>=20
> --
> Chuck Lever
>=20

This all looks good to me:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
