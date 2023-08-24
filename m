Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3AE7878DB
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 21:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjHXTm5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243322AbjHXTmb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 15:42:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82953210D
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 12:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2B3366CDB
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 19:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60DEC433C8;
        Thu, 24 Aug 2023 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692906125;
        bh=AvTUYjsvx547StYD1H3PARNO13Jht5ty3EIsJP3jOjU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Piu1fOsnSkOMROvH4Vkc22riqVVeUHpCEJS0hbwowsTLoDxF4aTwx15cZpCsktQxU
         6cMc8+byKYQsYiiEv5ZoEb3Gz8Xf/Hk2uCYiIH2bzLjfXWxuyGQhrZ2eKYEfBFuYWi
         Mphwqid3WnqhSHfPJOqOPgw1gPYuY1CBjA74GrqI5PFWphNf7CKe5EQZJCHZYu+zuk
         1iDbj2v13ZysBYBvKBaiVrAvt8Kpi4F971FfpYIRcMnsGc3qlpd/VcoZcH0NF7aeKB
         GlpR+9PQsKXT45hqMYHKXFQ6mzmuqXC9e0pyl7kLqr0YVskudI60xsYXEHAX40bSL/
         RcJ7+7C2gu9Wg==
Message-ID: <9867b999cbd8cab2a7cdc809d75579bd9528c953.camel@kernel.org>
Subject: Re: [PATCH] NFSD: Fix a thinko introduced by recent trace point
 changes
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     kernel test robot <oliver.sang@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 24 Aug 2023 15:42:03 -0400
In-Reply-To: <169288742767.62637.4868507858344398487.stgit@klimt.1015granger.net>
References: <169288742767.62637.4868507858344398487.stgit@klimt.1015granger.net>
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

On Thu, 2023-08-24 at 10:30 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The fixed commit erroneously removed a call to nfsd_end_grace(),
> which makes calls to write_v4_end_grace() a no-op.
>=20
> Fixes: 39d432fc7630 ("NFSD: trace nfsctl operations")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308241229.68396422-oliver.sang@=
intel.com
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfsctl.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 1b8b1aab9a15..4302ca0ff6ed 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1105,6 +1105,7 @@ static ssize_t write_v4_end_grace(struct file *file=
, char *buf, size_t size)
>  			if (!nn->nfsd_serv)
>  				return -EBUSY;
>  			trace_nfsd_end_grace(netns(file));
> +			nfsd4_end_grace(nn);
>  			break;
>  		default:
>  			return -EINVAL;
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
