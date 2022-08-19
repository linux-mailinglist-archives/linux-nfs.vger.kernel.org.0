Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C69D59A6C9
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Aug 2022 21:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349727AbiHSTlc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Aug 2022 15:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349461AbiHSTlb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Aug 2022 15:41:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDBE1136A5
        for <linux-nfs@vger.kernel.org>; Fri, 19 Aug 2022 12:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD7F4B825BF
        for <linux-nfs@vger.kernel.org>; Fri, 19 Aug 2022 19:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261DBC433D6;
        Fri, 19 Aug 2022 19:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660938087;
        bh=erjFzRbyImCPF6IEhgYNtSpwqTc/G13Alj4H1FifGgw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qZYzx4Voi1gPNCJIE5zjcwep7HCuEEfctxzS+Voc8IwRCXODvgGxnFdZxoqu8nEAc
         PwGXfkYqXuGaKlhCg9aj8Ak42hTcejwVzCRqOkdYDso+a2eMbTPoTQWOUDz+d2tMiA
         06Tc9wf6W0fqUW6122W8ZeB6rhLP3YZ9Ve5UB2kLKDBamptxyymPV7RRs9xTQToeGO
         poPQl5O8Sis+eS4v7HtNlISKeL1heMpS+HtWgnV8Qg0yBC3cv01MLHxUsx7lBUjlzk
         dZXQORvuXPOVGGwsntTFpDlEYRl6zryBPFEWQSbfoBDlpsOGQN8ru5XklKetUtj1ud
         FvSBjUG4ce/yw==
Message-ID: <19f46780bd8716ff9661591746df670b28103228.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD enforce filehandle check for source file in
 COPY
From:   Jeff Layton <jlayton@kernel.org>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        chuck.level@oracle.come
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 19 Aug 2022 15:41:25 -0400
In-Reply-To: <20220819191636.68024-1-olga.kornievskaia@gmail.com>
References: <20220819191636.68024-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Fri, 2022-08-19 at 15:16 -0400, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> If the passed in filehandle for the source file in the COPY operation
> is not a regular file, the server MUST return NFS4ERR_WRONG_TYPE.
>=20
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfsd/nfs4proc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index a72ab97f77ef..d8f05d96fe68 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1768,7 +1768,13 @@ static int nfsd4_do_async_copy(void *data)
>  		filp =3D nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>  				      &copy->stateid);
>  		if (IS_ERR(filp)) {
> -			nfserr =3D nfserr_offload_denied;
> +			switch (PTR_ERR(filp)) {
> +			case -EBADF:
> +				nfserr =3D nfserr_wrong_type;
> +				break;
> +			default:
> +				nfserr =3D nfserr_offload_denied;
> +			}
>  			nfsd4_interssc_disconnect(copy->ss_mnt);
>  			goto do_callback;
>  		}

Reviewed-by: Jeff Layton <jlayton@kernel.org>
