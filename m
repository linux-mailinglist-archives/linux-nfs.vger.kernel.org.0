Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28AB7C0049
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Oct 2023 17:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjJJPWU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Oct 2023 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjJJPWT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Oct 2023 11:22:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F697
        for <linux-nfs@vger.kernel.org>; Tue, 10 Oct 2023 08:22:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A681DC433C7;
        Tue, 10 Oct 2023 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696951338;
        bh=X1iVh58lKMxePXdz5GnM6nkMcJFAwZy2EFP/RxSUDMc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UU+POW/S0xQ4NbVUT9AuVUJ14ismd48jP7f1NntD6mw74fCRRwlFaQSIUwCKsTELz
         v0qLzASbNL+8f0q9eZI5M6X9t/1b5fhtmTNkuGEdo5Q1aTpZmXYfSRo9g3aBQvE/Mw
         IldVcJK1oIZLd+0Ls/QvdesS/v1yoVxm7IWu5z2h4A08vaC2Wsmef1uLZnZATO3qK8
         KldIHBv8T7BCySN8TsakhWDdWTr4xyJohucfIOWMbLgQ3PBf/xiFx4vZMclA7hlqpn
         Z9woa72CVkUTCcnAZ+j37HeEecuDZHn6TBspkN7hNjSqGIyXKKR/jJZXYPeSZG8lVd
         9cqHdNpXjhz3w==
Message-ID: <105a77ad8fa0ebaf9a3ccc8d29e8f9e60b5ea96e.camel@kernel.org>
Subject: Re: [PATCH v1 0/8] Clean up miscellaneous NFSv4 XDR encoders
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Tue, 10 Oct 2023 11:22:16 -0400
In-Reply-To: <169687606447.41382.568611605570999245.stgit@oracle-102.nfsv4bat.org>
References: <169687606447.41382.568611605570999245.stgit@oracle-102.nfsv4bat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-10-09 at 14:29 -0400, Chuck Lever wrote:
> Tidy up the server-side XDR result encoders for remaining
> miscellanous NFSv4 operations. Series applies to nfsd-next. See
> topic branch "nfsd4-encoder-overhaul" in this repo:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>=20
> ---
>=20
> Chuck Lever (8):
>       NFSD: Clean up nfsd4_encode_access()
>       NFSD: Clean up nfsd4_do_encode_secinfo()
>       NFSD: Clean up nfsd4_encode_exchange_id()
>       NFSD: Clean up nfsd4_encode_test_stateid()
>       NFSD: Clean up nfsd4_encode_copy()
>       NFSD: Clean up nfsd4_encode_copy_notify()
>       NFSD: Clean up nfsd4_encode_offset_status()
>       NFSD: Clean up nfsd4_encode_seek()
>=20
>=20
>  fs/nfsd/nfs4proc.c |   4 +-
>  fs/nfsd/nfs4xdr.c  | 419 ++++++++++++++++++++++++---------------------
>  fs/nfsd/xdr4.h     |   4 +-
>  3 files changed, 225 insertions(+), 202 deletions(-)
>=20
> --
> Chuck Lever
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
