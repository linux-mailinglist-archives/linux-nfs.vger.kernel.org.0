Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D356D5E78
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Apr 2023 12:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbjDDK7Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Apr 2023 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjDDK67 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Apr 2023 06:58:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5034749F5
        for <linux-nfs@vger.kernel.org>; Tue,  4 Apr 2023 03:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 313DF631CD
        for <linux-nfs@vger.kernel.org>; Tue,  4 Apr 2023 10:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372C3C433D2;
        Tue,  4 Apr 2023 10:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680605688;
        bh=h4+T8Imo6qOzgIGs1Wpe6DpxZFIpYM3IVGTeUhccZxI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y5CPwwtl7NCxAhlla87HLCnCNszDio2OB/NUr3hRTL9Gj+4r2inoT5KKLJHR8rraZ
         ryYvTtR3XPyJy7DS7lNAb53cKqmWL9zqKktzn7zfTOZ0sJdNplyUBtw7GgHw3Ad7X7
         mu4td30NFuDirmvJRgVFhSv0Vh/zG58yLigo8gOeCCEUMxZdEluni94K1X1DyuPGKi
         xz8PgSI6CDtfc92iRQBEn+38+qoqh3gZ3imSi88I9cjEQpwd2HOv5ThRQSJeVxDll/
         W+7Cebet0KYX/FLyyAoXuLnoyZbyE0UeAbYff0FhG+gxJ4qDvaQ3Jgrc7ds+DM89vP
         2u+V7JPXf53Tw==
Message-ID: <c29bdf3faa6d274acf7083839ecf8b2a2a66a21a.camel@kernel.org>
Subject: Re: [PATCH] NFSD: callback request does not use correct credential
 for AUTH_SYS
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 04 Apr 2023 06:54:46 -0400
In-Reply-To: <1680380528-22306-1-git-send-email-dai.ngo@oracle.com>
References: <1680380528-22306-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 2023-04-01 at 13:22 -0700, Dai Ngo wrote:
> Currently callback request does not use the credential specified in
> CREATE_SESSION if the security flavor for the back channel is AUTH_SYS.
>=20
> Problem was discovered by pynfs 4.1 DELEG5 and DELEG7 test with error:
> DELEG5   st_delegation.testCBSecParms     : FAILURE
>            expected callback with uid, gid =3D=3D 17, 19, got 0, 0
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4callback.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 2a815f5a52c4..4039ffcf90ba 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -946,8 +946,8 @@ static const struct cred *get_backchannel_cred(struct=
 nfs4_client *clp, struct r
>  		if (!kcred)
>  			return NULL;
> =20
> -		kcred->uid =3D ses->se_cb_sec.uid;
> -		kcred->gid =3D ses->se_cb_sec.gid;
> +		kcred->fsuid =3D ses->se_cb_sec.uid;
> +		kcred->fsgid =3D ses->se_cb_sec.gid;
>  		return kcred;
>  	}
>  }

Reviewed-by: Jeff Layton <jlayton@kernel.org>
