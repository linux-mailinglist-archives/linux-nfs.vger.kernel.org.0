Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06426C30E4
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 12:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCULxH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 07:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCULxG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 07:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFF45242
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 04:52:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C734961B4B
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 11:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9303C433D2;
        Tue, 21 Mar 2023 11:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679399577;
        bh=CmMZ1klRJvwsDqsConHuj1q1DcpFrF6ICuzfaznTxwI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Bk9rW5t3Q+zzkGAFyF1HaPnznqmEKdmaWncOBpLyALWWAt88xTqN3cQ0tx6VtV8kp
         ulEZjVHLU4P62+BTYZLV+sR0eI8V4vL72rN6RbxI8c4YqgeAGC98fIlQH0f6Y/YHjc
         V6zIfZDFr67LaTc2IugvVxq5vYQSCeDfUUsDoln44p2TcTkZ+96/0ME2Izuqyd5bgA
         NT9PiAfLi4AYYVhTC5dx/nHcH7rzomllaJZNCLtrrRLnzErmJoNStOoyyc9JHObKCz
         16WEMBEXGoLRKuX6i+EV5b2loKsI4ZnmPsWTEEUIyZr3AafqLuFzD1KFN6hy8gXNS4
         o/PNJUdb6Ireg==
Message-ID: <d5c93e97f10a8ae803efaad02559dd118e9b9b6f.camel@kernel.org>
Subject: Re: [PATCH v1 0/4] nfs-utils changes for RPC-with-TLS server
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 21 Mar 2023 07:52:55 -0400
In-Reply-To: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-03-20 at 10:35 -0400, Chuck Lever wrote:
> Hi Steve-
>=20
> This is server-side support for RPC-with-TLS, to accompany similar
> support in the Linux NFS client. This implementation can support
> both the opportunistic use of transport layer security (it will be
> used if the client cares to) and the required use of transport
> layer security (the server requires the client to use it to access
> a particular export).
>=20
> Without any other user space componentry, this implementation will
> be able to handle clients that request the use of RPC-with-TLS. To
> support security policies that restrict access to exports based on
> the client's use of TLS, modifications to exportfs and mountd are
> needed. These can be found here:
>=20
> git://git.linux-nfs.org/projects/cel/nfs-utils.git
>=20
> They include an update to exports(5) explaining how to use the new
> "xprtsec=3D" export option.
>=20
> The kernel patches, along with the the handshake upcall, are carried
> in the topic-rpc-with-tls-upcall branch available from:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>=20
> This was posted under separate cover.
>=20
> ---
>=20
> Chuck Lever (4):
>       libexports: Fix whitespace damage in support/nfs/exports.c
>       exports: Add an xprtsec=3D export option
>       exportfs: Push xprtsec settings to the kernel
>       exports.man: Add description of xprtsec=3D to exports(5)
>=20
>=20
>  support/export/cache.c       |  15 ++++++
>  support/include/nfs/export.h |   6 +++
>  support/include/nfslib.h     |  14 +++++
>  support/nfs/exports.c        | 100 ++++++++++++++++++++++++++++++++---
>  utils/exportfs/exportfs.c    |   1 +
>  utils/exportfs/exports.man   |  45 +++++++++++++++-
>  6 files changed, 172 insertions(+), 9 deletions(-)
>=20

Nice work, Chuck! This all looks pretty straightforward. I have a
(minor) concern about potentially blocking nfsd threads for up to 20s in
a handshake, but this seems like a good place to start.
--=20
Jeff Layton <jlayton@kernel.org>
