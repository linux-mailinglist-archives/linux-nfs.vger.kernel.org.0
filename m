Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D01769F527
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 14:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjBVNNa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 08:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjBVNNa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 08:13:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A6838EA7
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 05:13:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E97AB6144D
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 13:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23B6C433D2;
        Wed, 22 Feb 2023 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677071585;
        bh=gkLt7aLrQ0RRDgOkWSsY7NgiftNp9WHzjltE1jhxIOQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DaHr0Ml0aHXz3uatkva+VgEBnbDzh9C7B/8hQI4LL1GtSQ54q4WOP+bTy2gs/sGwH
         zym0CGrZsa9Q6YHV1a2qud1mDY0kJo19++yVuq6IXDIzbtCTQZOyGvSjLUHOgch3TG
         ZBz0m+qdrzph5VZz4OTK8CPLTBVT+cvNDN7bZ8rgMveVvnAEvnSdpmeyPdH7yGhMxj
         Q1cXEzcRmMYR4x8rFcTrIeBrcz8N8hx50B9EKybpQDkaYsrggVcmqNBV/SEqdthxzd
         nZEdwi7JOyhpO2Eo4H6blZyzz+C0J2/wwv28gXZlmaDQX5iW/6qTcL/QwnCI8oS3n8
         ySZRzijWyVMOA==
Message-ID: <58384faee4c5583a47cd8a19e2d157d4b9b8d960.camel@kernel.org>
Subject: Re: [PATCH] nfs4.0: add a retry loop on NFS4ERR_DELAY to compound
 function
From:   Jeff Layton <jlayton@kernel.org>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Dai Ngo <dai.ngo@oracle.com>
Date:   Wed, 22 Feb 2023 08:13:03 -0500
In-Reply-To: <20230222131100.26472-1-jlayton@kernel.org>
References: <20230222131100.26472-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Oops. The subject should have read [pynfs PATCH]:

On Wed, 2023-02-22 at 08:11 -0500, Jeff Layton wrote:
> The latest knfsd server is "courteous" in that it will not revoke a
> lease held by an expired client until there is competing access for it.
> When there is competing access, it can now return NFS4ERR_DELAY until
> the old client is expired. I've seen this happen when running pynfs in
> a loop against a server with only 4g of memory.
>=20
> The v4.0 compound handler doesn't retry automatically on NFS4ERR_DELAY
> like the v4.1 version does. Add support for it using the same timeouts
> as the v4.1 compound handler.
>=20
> Cc: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  nfs4.0/nfs4lib.py | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
> index 9b074f02b91f..eddcd862bc2f 100644
> --- a/nfs4.0/nfs4lib.py
> +++ b/nfs4.0/nfs4lib.py
> @@ -338,12 +338,21 @@ class NFS4Client(rpc.RPCClient):
>          un_p =3D self.nfs4unpacker
>          p.reset()
>          p.pack_COMPOUND4args(compoundargs)
> -        res =3D self.call(NFSPROC4_COMPOUND, p.get_buffer())
> -        un_p.reset(res)
> -        res =3D un_p.unpack_COMPOUND4res()
> -        if SHOW_TRAFFIC:
> -            print(res)
> -        un_p.done()
> +        res =3D None
> +
> +        # NFS servers can return NFS4ERR_DELAY at any time for any reaso=
n.
> +        # Just delay a second and retry the call again in that event. If
> +        # it fails after 10 retries then just give up.
> +        for i in range(1, 10):
> +            res =3D self.call(NFSPROC4_COMPOUND, p.get_buffer())
> +            un_p.reset(res)
> +            res =3D un_p.unpack_COMPOUND4res()
> +            if SHOW_TRAFFIC:
> +                print(res)
> +            un_p.done()
> +            if res.status !=3D NFS4ERR_DELAY:
> +                break
> +            time.sleep(1)
> =20
>          # Do some error checking
> =20

--=20
Jeff Layton <jlayton@kernel.org>
