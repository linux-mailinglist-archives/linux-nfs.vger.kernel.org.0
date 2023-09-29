Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ECC7B37E2
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 18:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjI2Q0h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 12:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjI2Q0g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 12:26:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274E0BE
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 09:26:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61548C433C7;
        Fri, 29 Sep 2023 16:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696004794;
        bh=+LM5lynOwSdMYigCH0vK3oPoPdpzQuEK8V83/IU7Wls=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iW5WkSUQ/5wi0ob6NbsyAIj+XuY8Kb/FRvORysw6DY+jY8ZFIXhodLERT9sdcSid+
         pzcoXgS45WR7WGNV39bwJuztv1r8HeQ7D3lvk++BosqFUZYD+Hi2wV4A8RhKcAvayI
         Lo5FgqRiOhyluw9i44gi9r8tUrTAp7N0VAl1l3CPuOSwfje4H/du2fkchvVzxjxtBK
         NE5QBxGwY8XcZFXTtvcBTABKekoEGyxEA1kTHC7TogGZdmpqwElFY9y+0YSSJ+IEp/
         XyhHX7PVYzasreERqn7iE2e9TWyVmjBk/bt1TWWIpKtlU1ZXWgtKRrnU0PPwkA18e6
         r8qNxkCbX9ztQ==
Message-ID: <c6ed1c23c7d2ff4b7e1422458c28a44e25599fb7.camel@kernel.org>
Subject: Re: [PATCH v1 0/7] Clean up XDR encoders for NFSv4 OPEN and LOCK
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 29 Sep 2023 12:26:33 -0400
In-Reply-To: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
References: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Fri, 2023-09-29 at 09:58 -0400, Chuck Lever wrote:
> Tidy up the server-side XDR encoders for NFSv4 OPEN and LOCK
> results. Series applies to nfsd-next. See topic branch
> "nfsd4-encoder-overhaul" in this repo:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>=20
> ---
>=20
> Chuck Lever (7):
>       NFSD: Add nfsd4_encode_lock_owner4()
>       NFSD: Refactor nfsd4_encode_lock_denied()
>       NFSD: Add nfsd4_encode_open_read_delegation4()
>       NFSD: Add nfsd4_encode_open_write_delegation4()
>       NFSD: Add nfsd4_encode_open_none_delegation4()
>       NFSD: Add nfsd4_encode_open_delegation4()
>       NFSD: Clean up nfsd4_encode_open()
>=20
>=20
>  fs/nfsd/nfs4state.c |   6 +-
>  fs/nfsd/nfs4xdr.c   | 305 +++++++++++++++++++++++++++-----------------
>  fs/nfsd/xdr4.h      |   2 +-
>  3 files changed, 189 insertions(+), 124 deletions(-)
>=20
> --
> Chuck Lever
>=20

Looks pretty straightforward. I had one minor nit about the struct
packing but the rest looks fine. You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
