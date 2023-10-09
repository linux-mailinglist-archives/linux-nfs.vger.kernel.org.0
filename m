Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC5F7BE84C
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Oct 2023 19:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjJIRhD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 13:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjJIRhC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 13:37:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD11B94
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 10:37:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69F1C433C9;
        Mon,  9 Oct 2023 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696873021;
        bh=MSQ/4hoHooyiip6EPWg2znyMYdFYhi/6LVl6Kh071Fg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E8wHcdDINoFOxbAw5W09HZbAQ+boFT4U/xWsF8zGAJp/QBlYECr/BO6EqflCu68OP
         O6breJz08GW28bEdxTkC6ne99xHOH4ZQzsIDdDnKSsu0JHrRUVRPl3iKAyeYAGPJXl
         UhnbE/JmD7sA3z5LK3YQfFWPzXhILnQF7WNxxIHXedQX+r7KpE+yCOAGLbJL4Dcwts
         5Vqt/FG36bfvYAtHWB+x1WhsyyZsGR1+ukfnAhtYJ/h08gYUY5tKng/cUlVB0zzR76
         sWlGjwgbYtJAW7h3FAAHeqcKSn48kRWRu76F4FMtz1lQDJXKg7ZkyCJTjxmjkGK8QN
         Fz83XN5rFCPDQ==
Message-ID: <9b15512bf345bea99218a7682fd9cc5d10cda9c5.camel@kernel.org>
Subject: Re: [PATCH v1 0/5] Clean up XDR encoders for NFSv4 READDIR
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 09 Oct 2023 13:36:59 -0400
In-Reply-To: <169642681764.7503.2925922561588558142.stgit@klimt.1015granger.net>
References: <169642681764.7503.2925922561588558142.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-10-04 at 09:41 -0400, Chuck Lever wrote:
> Tidy up the server-side XDR encoders for READDIR results and
> directory entries. Series applies to nfsd-next. See topic branch
> "nfsd4-encoder-overhaul" in this repo:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>=20
> ---
>=20
> Chuck Lever (5):
>       NFSD: Rename nfsd4_encode_dirent()
>       NFSD: Clean up nfsd4_encode_rdattr_error()
>       NFSD: Add an nfsd4_encode_nfs_cookie4() helper
>       NFSD: Clean up nfsd4_encode_entry4()
>       NFSD: Clean up nfsd4_encode_readdir()
>=20
>=20
>  fs/nfsd/nfs4xdr.c | 200 +++++++++++++++++++++++-----------------------
>  fs/nfsd/xdr4.h    |   3 +
>  2 files changed, 104 insertions(+), 99 deletions(-)
>=20
> --
> Chuck Lever
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
