Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8A5660617
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 18:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjAFR6D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Jan 2023 12:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjAFR6B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Jan 2023 12:58:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F167DE0F
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 09:57:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8811561E6F
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 17:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6EDC433EF;
        Fri,  6 Jan 2023 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673027878;
        bh=4hOT7dIlq8PAlY8hZODlsx4Qt81lydsvBPlUrfmEZu4=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=W/mABxj1KpkrmfEO2k5qDKsHCUMoXnWfBdwIsPHWveLgJ+Tbm5BYLafY8iDOEXYK8
         0v9HRaAjz5I+rQSbjy3zq9Qaz7pAC9nU5qAa5rj9aUo9M7JTYUQDL2JgwWnLgkOyTh
         V1NLFA6cHTv2tIfIbFtvR0TjLltzoQRml5YwMVy8wrxovq1AlB2PmJSyiiVgMAvvpw
         qpjfE53YTPhz1Ub4IPcFolbG6VHDnDGD1Ka4kkVHr+cyx0MNvQVn8kxhq6FlvO3tk3
         SlUi9+N0AtQpPRAZveA4fRL6i8kJP5JTfMsrD0bowtlxbDv0A542fHrj7LEbHlA4Ba
         vKhDQDYcbJMgw==
Message-ID: <d0ee3c7a4850246d72e88eeb3b88db40380507f2.camel@kernel.org>
Subject: Re: [PATCH v1] Revert "SUNRPC: Use RMW bitops in single-threaded
 hot paths"
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Date:   Fri, 06 Jan 2023 12:57:57 -0500
In-Reply-To: <167302701777.4221.807573588471189662.stgit@klimt.1015granger.net>
References: <167302701777.4221.807573588471189662.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-01-06 at 12:43 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The premise that "Once an svc thread is scheduled and executing an
> RPC, no other processes will touch svc_rqst::rq_flags" is false.
> svc_xprt_enqueue() examines the RQ_BUSY flag in scheduled nfsd
> threads when determining which thread to wake up next.
>=20
> Found via KCSAN.
>=20
> Fixes: 28df0988815f ("SUNRPC: Use RMW bitops in single-threaded hot paths=
")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c                       |    7 +++----
>  fs/nfsd/nfs4xdr.c                        |    2 +-
>  net/sunrpc/auth_gss/svcauth_gss.c        |    4 ++--
>  net/sunrpc/svc.c                         |    6 +++---
>  net/sunrpc/svc_xprt.c                    |    2 +-
>  net/sunrpc/svcsock.c                     |    8 ++++----
>  net/sunrpc/xprtrdma/svc_rdma_transport.c |    2 +-
>  7 files changed, 15 insertions(+), 16 deletions(-)
>=20

Makes sense.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
