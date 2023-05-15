Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA00070353C
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 18:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbjEOQ5I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 12:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243247AbjEOQ5H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 12:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5214D7A92
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 09:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31BA362A1F
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 16:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E56DC4339B;
        Mon, 15 May 2023 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684169816;
        bh=Q+nclGJ4CteWjUVuOrzyFbrsJwbyFnomG9sLl3GdGgY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EfoyaEO3TysX+gC4GYICEVkvAFmCfS59TR/62rIIsUnne+1cT8wu3FB2myJN863I9
         GZ9ekAFevlqg3IlzOuqfKIYZPsFOFq/xXKfl4G4cvDlqGRdj+Z+pPx73Jteneg8nMY
         nb6ABaYyBW3v3EMluCw2NevkndmWWj/WH/y2LdI224hts+1YejeXWNjjKw7c+iZTu/
         H8/2YMCMZyT3JG/fZVy+MZvoRXaU7zh/JgiKxTwcxaQS4098Uaea3pgxPrhe2Uq3YV
         o5RUiQbKbqrzOAs6gUGJ6d/JnI2wfDXrYWNGc/7gX+jxeyMHrSwAp0ZCgKq/grHg9w
         iv5dA33NBZnFA==
Message-ID: <cad818127d6df4ebcc6e837def684ad381de83fe.camel@kernel.org>
Subject: Re: [PATCH 0/4] Socket creation observability
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 15 May 2023 12:56:54 -0400
In-Reply-To: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
References: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-05-15 at 09:32 -0400, Chuck Lever wrote:
> This series updates observability around socket creation and
> destruction to help troubleshoot issues such as:
>=20
> https://lore.kernel.org/linux-nfs/65AFD2EF-E5D3-4461-B23A-D294486D5F65@or=
acle.com/T/#t
>=20
> I plan to apply these to nfsd-next.
>=20
> ---
>=20
> Chuck Lever (4):
>       SUNRPC: Fix an incorrect comment
>       SUNRPC: Remove dprintk() in svc_handle_xprt()
>       SUNRPC: Improve observability in svc_tcp_accept()
>       SUNRPC: Trace struct svc_sock lifetime events
>=20
>=20
>  include/trace/events/sunrpc.h | 39 ++++++++++++++++++++++++-----------
>  net/sunrpc/svc_xprt.c         |  3 ---
>  net/sunrpc/svcsock.c          | 15 ++++++--------
>  3 files changed, 33 insertions(+), 24 deletions(-)
>=20
> --
> Chuck Lever
>=20

These all look fine to me. I had one nit about a conditional tracepoint,
but your call on whether you want to respin it that way.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
