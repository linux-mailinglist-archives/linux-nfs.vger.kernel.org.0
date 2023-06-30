Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557B97441ED
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 20:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjF3SKY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jun 2023 14:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjF3SKY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jun 2023 14:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7904719C
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 11:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D4F1617D5
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 18:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93FCC433C0;
        Fri, 30 Jun 2023 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688148622;
        bh=ri0ccoEo1Lwg3kpxlgZdTJRThQ3wV5URI1lDncEoyzA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t4SH5XlnD6Bdb4Jpzx1YQmOAYCSVVcVNwpHSlp5dKCHuLStXVa2k4dIJnk9X0JIvZ
         T3EDPn/t0qiUBHPf6ZdoEBbeqhQ7Naig6zrYw3LmO/PVTMMMSgk+HVb3YK5Ht1vjrI
         EosgevovQAajkd9gTaspAyX5jVIY4JTA3fF1p9XTcN90XpGPp/m7uThepH0GGUjhzb
         Do04e5nngvFnDU2XruCVXwr5A511hHHIq8vqnfJlciBFMIDa/kaec4ztnjhwsBlhXC
         nRXeCdIgaUzboj87zwNfly7n6Q7NOlvWYzBOzGSrJVZ1Xu0KZ7t0FIfQSa9re3EqkH
         nzMT68eung/Fg==
Message-ID: <e0b9f2591d4b8ebcb75a2ea1ee7aea5c0e8cedd6.camel@kernel.org>
Subject: Re: [PATCH v1 0/9] Remove support for DES-based Kerberos enctypes
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com,
        simo@redhat.com, smayhew@redhat.com
Date:   Fri, 30 Jun 2023 14:10:20 -0400
In-Reply-To: <168806089210.507650.17584608037244782863.stgit@morisot.1015granger.net>
References: <168806089210.507650.17584608037244782863.stgit@morisot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-06-29 at 13:50 -0400, Chuck Lever wrote:
> As we agreed, v6.6 will remove support for DES-based Kerberos
> enctypes from the kernel's SunRPC GSS implementation. Here's a
> series to do that.
>=20
> This has been compile-tested only. Comments and further testing are
> welcome.
>=20
> ---
>=20
> Chuck Lever (9):
>       SUNRPC: Remove RPCSEC_GSS_KRB5_ENCTYPES_DES
>       SUNRPC: Remove Kunit tests for the DES3 encryption type
>       SUNRPC: Remove DES and DES3 enctypes from the supported enctypes li=
st
>       SUNRPC: Remove code behind CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED
>       SUNRPC: Remove krb5_derive_key_v1()
>       SUNRPC: Remove gss_import_v1_context()
>       SUNRPC: Remove CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM
>       SUNRPC: Remove the ->import_ctx method
>       SUNRPC: Remove net/sunrpc/auth_gss/gss_krb5_seqnum.c
>=20
>=20
>  net/sunrpc/.kunitconfig                 |   1 -
>  net/sunrpc/Kconfig                      |  35 ---
>  net/sunrpc/auth_gss/Makefile            |   2 +-
>  net/sunrpc/auth_gss/gss_krb5_internal.h |  23 --
>  net/sunrpc/auth_gss/gss_krb5_keys.c     |  84 -------
>  net/sunrpc/auth_gss/gss_krb5_mech.c     | 257 +--------------------
>  net/sunrpc/auth_gss/gss_krb5_seal.c     |  69 ------
>  net/sunrpc/auth_gss/gss_krb5_seqnum.c   | 106 ---------
>  net/sunrpc/auth_gss/gss_krb5_test.c     | 196 ----------------
>  net/sunrpc/auth_gss/gss_krb5_unseal.c   |  77 -------
>  net/sunrpc/auth_gss/gss_krb5_wrap.c     | 287 ------------------------
>  11 files changed, 3 insertions(+), 1134 deletions(-)
>  delete mode 100644 net/sunrpc/auth_gss/gss_krb5_seqnum.c
>=20
> --
> Chuck Lever
>=20

Love that diffstat.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
