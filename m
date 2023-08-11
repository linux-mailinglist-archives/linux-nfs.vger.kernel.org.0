Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE767791D3
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Aug 2023 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjHKO2g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Aug 2023 10:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjHKO2f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Aug 2023 10:28:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87711121
        for <linux-nfs@vger.kernel.org>; Fri, 11 Aug 2023 07:28:33 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9cb0bb04bso6155831fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 11 Aug 2023 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1691764112; x=1692368912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kT6bnvwHgK491Y3HNlVAV+L1FaIjGCjYkAL78BMrI8k=;
        b=na0RmcUU6mUcD2+KIm4r9oeyV7Ry0GV8PKVgSkX7XM0uw0Cd5e4CyEkkKkX0epp4rP
         l6T8NZN9p4Tivn4z51VgrVbcNUo/YjakuYJsRQBbPM0SXJG5q5rJKZiQTJl3W1nokfQr
         1chKL4KptnHKDJVDF3axPFWxumctasDVby49J5R2cKeUxQrdO4KLsEcvN9Q/TuBCsx9z
         MToacICK2vWK/3r8zGE7N88k1M7WoxheIiY14DSZAzRDVnz0hhb+Z3UgHNnNlCkl9ZSx
         7Ectn3IrUYhSOIl5fDfNSJUomeBvN5QDX3431ZnCtESGRtNN18KnS6oTNNn7wcqNqSGv
         47ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691764112; x=1692368912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kT6bnvwHgK491Y3HNlVAV+L1FaIjGCjYkAL78BMrI8k=;
        b=Xl+DfgW4Z74pY/vnUxOF77UBFx7CnBkktsV3bI0cJu8Nr7B+BwGTGNMyKpTHMjCRsi
         tEp4AMEs/A6zEJnF0iFw1R6+6hq7OPgSHloeW72PYaaReI+GD2faYOGSJUhudInIBxrN
         BSebOgveN4BExrxPrjpBae1u+hYYmtT1DTcsoaBM7bLkbQiCnAuF4P93ocJ97CZ3E9hx
         TKBunzR262IM3rtY00AxrRfMds98bheqjnS+Kns0DjONCx9XDbGwbmtTAChG7Mvf74j1
         7d9FvEE9GVbjOLruOqXuNjnnkby+3uwfnh/CPtIifFDLLrbGUrjaleTa3a10ujo819X2
         fjTA==
X-Gm-Message-State: AOJu0YwY7yodl8cmJODrwpCh5Puc8xGZT/Iu45eyLtMI+Pg4Jfd9J5kB
        EBYhaOn/IFGPdcXFr5//BNrGMJczKKwF40Ms2EZdy6Gn
X-Google-Smtp-Source: AGHT+IGpPqTcQzfCBSaZzrdvplD1O93RY55hpfwmwQAF2fffSPcpPV4SYq8jpqjERoLhKy7gKO5P2LAp36v8nbyK3fA=
X-Received: by 2002:a2e:b808:0:b0:2b9:e10b:a511 with SMTP id
 u8-20020a2eb808000000b002b9e10ba511mr1499627ljo.0.1691764111358; Fri, 11 Aug
 2023 07:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <b1ae55f1c835ea6b30089a9377ae67c40d43a0fc.camel@kernel.org>
In-Reply-To: <b1ae55f1c835ea6b30089a9377ae67c40d43a0fc.camel@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 11 Aug 2023 10:28:19 -0400
Message-ID: <CAN-5tyHejgLNPrF-bybFqrkiEvvFb+SZ9NHne9RiQ0kVwESd5A@mail.gmail.com>
Subject: Re: turning on s2s copy by default in knfsd
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornieskaia <kolga@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 11, 2023 at 10:23=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> Chuck and I were chatting yesterday about what it will take to make the
> inter_copy_offload_enable module option on by default, and I'd like to
> start working toward that end.
>
> I think what we want to aim for is to eventually deprecate the module
> option and have this "just work" when the conditions are right.
>
> It looks like main obstacle is this (from RFC7862 section 4.9):
>
>    NFSv4 clients and servers supporting the inter-server COPY operations
>    described in this section are REQUIRED to implement the mechanism
>    described in Section 4.9.1.1 and to support rejecting COPY_NOTIFY
>    requests that do not use the RPC security protocol (RPCSEC_GSS)
>    [RFC7861] with privacy.  If the server-to-server copy protocol is
>    based on ONC RPC, the servers are also REQUIRED to implement
>    [RFC7861], including the RPCSEC_GSSv3 "copy_to_auth",
>    "copy_from_auth", and "copy_confirm_auth" structured privileges.
>    This requirement to implement is not a requirement to use; for
>    example, a server may, depending on configuration, also allow
>    COPY_NOTIFY requests that use only AUTH_SYS.
>
>    If a server requires the use of an RPCSEC_GSSv3 copy_to_auth,
>    copy_from_auth, or copy_confirm_auth privilege and it is not used,
>    the server will reject the request with NFS4ERR_PARTNER_NO_AUTH.
>
> We don't (yet) have GSSv3 support, so we'd need to implement that in
> order to make this work right with krb5. Has anyone started looking at
> GSSv3?

Andy Adamson way back when implemented a draft gssv3 implementation
and I believe we still have those patches. Anna periodically have been
rebasing them but no more than that. I believe there might have been
even some patches for the copy piece but I believe those might be
lost. I'd have to dig around in my oldest laptop.

I'd like to address some other questions later as I'm out of the office tod=
ay.

> Incidentally, has anyone tried doing this with sec=3Dkrb5 in the current
> code? Does it actually work? I don't see any place where we return
> nfserr_partner_no_auth, so I wonder if we need to fix up the s2s COPY
> authentication and error handling?
>
> Another question: The v4.2 spec was written before the RPC over TLS
> spec. Should we aim to allow this to work by default if the client and
> both servers are using xprtsec=3Dmtls and are secured by the same CA?
>
> 1/ the client and servers are all using GSSv3 with krb5p (or some other
> encryption)
>
> ...or...
>
> 2/ the client and servers are all using mtls with certificates signed by
> the same CA
>
>
> ...I expect we'll probably be able to accomodate #2 before #1.
>
> Beyond that, we could allow for module or export option that still
> allows s2s copy to work and relaxes the above restrictions (to allow
> people to use it over plaintext with AUTH_SYS on "secure" networks).
>
> Anything I've overlooked here, or other thoughts?
>
> Cheers,
> --
> Jeff Layton <jlayton@kernel.org>
