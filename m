Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB27B3805
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjI2QeP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 12:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjI2QeP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 12:34:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C001B5
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 09:34:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C007C433C7;
        Fri, 29 Sep 2023 16:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696005252;
        bh=TlNGAaBCPbTElfLlWIMLwpUz4LmP3mv+vFhbaU7emaM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t3MgS8m/XdIK+zcgQ9lom8Ei9aluKjBRxOxxuomtPWr2pie/G8cE/DvtO5EgGvoRa
         yc0fEgS/mzf33TrjUTkHr2twBD0gWr0lbXubKGPtNYE1mHu3gbptmNUVTr57VGvp1f
         0MKzntIKOxNZgZ+K4dr1XzwMZPUu+XBdTxaBd9B6wAQ+VvWEvf4y+ZQofzZXq6BoO6
         s7Z3SZuQEoYH4tMOQfn2j4xxKf6q1sc3kJhdqpWGa+eGoYOrE7tlssfH86EdaI6yIy
         SM6u2EJvpwF8kRc817XNmC7mg1JX89T8WAhh4zB4Wu5Nf57d+FuzWJv80ORU0sSVzC
         OuZbIiDDvybqA==
Message-ID: <01ac6657423d6f3a28aca457c5651c8bda12cd68.camel@kernel.org>
Subject: Re: [PATCH v1 0/8] Clean up XDR encoders for pNFS operations
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 29 Sep 2023 12:34:11 -0400
In-Reply-To: <169564827064.6013.5014460767978657478.stgit@klimt.1015granger.net>
References: <169564827064.6013.5014460767978657478.stgit@klimt.1015granger.net>
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

On Mon, 2023-09-25 at 09:27 -0400, Chuck Lever wrote:
> Tidy up the server-side XDR encoders for pNFS-related operations.
> Note that this does not touch the layout driver code; that can be
> done later.
>=20
> Series applies to nfsd-next. See topic branch
> "nfsd4-encoder-overhaul" in this repo:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>=20
> ---
>=20
> Chuck Lever (8):
>       NFSD: Add nfsd4_encode_count4()
>       NFSD: Clean up nfsd4_encode_stateid()
>       NFSD: Make @lgp parameter of ->encode_layoutget a const pointer
>       NFSD: Clean up nfsd4_encode_layoutget()
>       NFSD: Clean up nfsd4_encode_layoutcommit()
>       NFSD: Clean up nfsd4_encode_layoutreturn()
>       NFSD: Make @gdev parameter of ->encode_getdeviceinfo a const pointe=
r
>       NFSD: Clean up nfsd4_encode_getdeviceinfo()
>=20
>=20
>  fs/nfsd/blocklayoutxdr.c    |   6 +-
>  fs/nfsd/blocklayoutxdr.h    |   4 +-
>  fs/nfsd/flexfilelayoutxdr.c |   6 +-
>  fs/nfsd/flexfilelayoutxdr.h |   4 +-
>  fs/nfsd/nfs4layouts.c       |   6 +-
>  fs/nfsd/nfs4proc.c          |   4 +-
>  fs/nfsd/nfs4xdr.c           | 206 ++++++++++++++++++++----------------
>  fs/nfsd/pnfs.h              |   6 +-
>  fs/nfsd/xdr4.h              |   7 +-
>  9 files changed, 135 insertions(+), 114 deletions(-)
>=20
> --
> Chuck Lever
>=20

Looks good. Nice cleanup.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
