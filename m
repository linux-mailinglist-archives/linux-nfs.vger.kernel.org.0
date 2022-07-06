Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E616356905C
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 19:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiGFRMc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 13:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiGFRM3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 13:12:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B13727FE3
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 10:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 01E30CE2018
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 17:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C13EC3411C;
        Wed,  6 Jul 2022 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657127545;
        bh=mTOiVKVP5eHLbnSG1lHufBASOT+hlVSSr94f1L8gbrk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=V/TgIhZKfcZZSVrT8KSKY7ps4WaGw92edM8g/cZx8Ui77c2hx6tOOS+z6Vf/4l/B/
         VuHGPWQHxS7eh6wzQ/g7EHN08rntUZgIJQ/AGcwymlMPUfbX0Z0651MDmLJVwneR71
         B5YfWD+hY281unvM98+pRFX7NXoBMxOq1BMlzZm0P5/ctrLvRBJ12NAVBkGYS/+hNQ
         BpJwgd8JUteKxabyuZyuMU2ObdPlz0Wz9bbFexmK8ThP6jyVtBI0Jzt7/uWRYr5uy3
         ZBGTM0bKnJUlVjjn+ezt75XF2VfqSSMwKcxbRhwNYExcpmqXW9NcGdT8gUI2c54Vsr
         j9yydW7GPzyZA==
Message-ID: <781e7a9a8341250c6413efc26a4838d009ff21c9.camel@kernel.org>
Subject: Re: [PATCH v2 01/15] SUNRPC: Fail faster on bad verifier
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Wed, 06 Jul 2022 13:12:23 -0400
In-Reply-To: <165452703512.1496.16079453480386969997.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
         <165452703512.1496.16079453480386969997.stgit@oracle-102.nfsv4.dev>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-06-06 at 10:50 -0400, Chuck Lever wrote:
> A bad verifier is not a garbage argument, it's an authentication
> failure. Retrying it doesn't make the problem go away, and delays
> upper layer recovery steps.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/clnt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index e2c6eca0271b..ed13d55df720 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2649,7 +2649,7 @@ rpc_decode_header(struct rpc_task *task, struct xdr=
_stream *xdr)
> =20
>  out_verifier:
>  	trace_rpc_bad_verifier(task);
> -	goto out_garbage;
> +	goto out_err;
> =20
>  out_msg_denied:
>  	error =3D -EACCES;
>=20
>=20

Looks like this will mostly manifest as an -EIO return, which is what we
want in most cases for a munged verifer.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
