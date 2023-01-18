Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7950867227A
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 17:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjARQGl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 11:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjARQGO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 11:06:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0494589BA
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 08:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674057743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hiMzFHa6vn9qE7yooc5qdXggq/ibnI2kdxrThSA73HI=;
        b=bhN2elVCGwcL4l/rR8KtKMer+/lpXnbFmdt84ArXOakiTNsmuRUlJCeS2dkOFRkdKWDOK9
        63927SMoEK3Ari3Ia6xLTbBav+FX2hsFBqgGInUIcGSg5K/Dsgn3gg3Z8XIoCccYHexUUG
        mg8qTvemJ2mrsdlJn34DP7GmncffaGg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-244-KoK4ZGwjMzCxPJtCZ2W4dQ-1; Wed, 18 Jan 2023 11:02:20 -0500
X-MC-Unique: KoK4ZGwjMzCxPJtCZ2W4dQ-1
Received: by mail-oi1-f199.google.com with SMTP id c5-20020a544e85000000b00361126f6443so9658564oiy.16
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 08:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiMzFHa6vn9qE7yooc5qdXggq/ibnI2kdxrThSA73HI=;
        b=HAWl4YInD2b9gYcT1I1EGQy9rhe3eMtOwBdAEa2fnUTD6eVWFdA0IdFKHHSY0a2bY6
         eJ1+Pm5FN1tRnqb70CPltM3+eQR8jWIsZc3Z8G8w9d3U/NnxCYi2QBdzi58yv6678LFU
         uaDkDqRRNpnwEH0m91QQ+QuRvxYsOcxbBXi3a1e4WbYmuV3HMsdNgMvkIc+2PD4FLtiw
         zrFVGUdYscKNVRucY3UfaPXbJvtZlytUvza7HLsXs4BldRwiz8pd8gU9iSo6DUoO1AmX
         o57Rb7ErI6SOVcBAIrfDg8IxDaKLQf+CuLJfq4/+KmkJ83jK+IwDV2sqR53416IFO/Xl
         aVWA==
X-Gm-Message-State: AFqh2kos2DAVDL1k7rMSHcjR9Qw8lCIZrQQw8gof62BDDh5846cqu82/
        zylLITZKVMj19HqZz7vv6S3RxtOeUXy78tU6E0tPysr7ZtmFo91khLIpRlqEDYjMwfvycEfwSGs
        vq/BNnkp9e+XK9Mv71iUw
X-Received: by 2002:a05:6870:1b86:b0:15f:14cb:eebb with SMTP id hm6-20020a0568701b8600b0015f14cbeebbmr4094467oab.40.1674057739234;
        Wed, 18 Jan 2023 08:02:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuXG/KeMADpB1tftjJTWWRNlVWexlA62bftD0m1Dv60ZS2jLu3nc9dXB72y0VhVuOLfFBk0YQ==
X-Received: by 2002:a05:6870:1b86:b0:15f:14cb:eebb with SMTP id hm6-20020a0568701b8600b0015f14cbeebbmr4094432oab.40.1674057738600;
        Wed, 18 Jan 2023 08:02:18 -0800 (PST)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05620a319a00b00706a1551408sm3065760qkb.4.2023.01.18.08.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:02:18 -0800 (PST)
Message-ID: <0b96ee92145831afba9d099d948fdd0af1b3180c.camel@redhat.com>
Subject: Re: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
From:   Simo Sorce <simo@redhat.com>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, linux-kselftest@vger.kernel.org
Date:   Wed, 18 Jan 2023 11:02:17 -0500
In-Reply-To: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-01-15 at 12:20 -0500, Chuck Lever wrote:
> The purpose of this series is to improve/harden the security
> provided by the Linux kernel's RPCSEC GSS Kerberos 5 mechanism.
> There are lots of clean-ups in this series, but the pertinent
> feature is the addition of a clean deprecation path for the DES-
> and SHA1-based encryption types in accordance with Internet BCPs.
>=20
> This series disables DES-based enctypes by default, provides a
> mechanism for disabling SHA1-based enctypes, and introduces two
> modern enctypes that do not use deprecated crypto algorithms.
>=20
> Not only does that improve security for Kerberos 5 users, but it
> also prepares SunRPC for eventually switching to a shared common
> kernel Kerberos 5 implementation, which surely will not implement
> any deprecated encryption types (in particular, DES-based ones).
>=20
> Today, MIT supports both of the newly-introduced enctypes, but
> Heimdal does not appear to. Thus distributions can enable and
> disable kernel enctype support to match the set of enctypes
> supported in their user space Kerberos libraries.
>=20
> Scott has been kicking the tires -- we've found no regressions with
> the current SHA1-based enctypes, while the new ones are disabled by
> default until we have an opportunity for interop testing. The KUnit
> tests for the new enctypes pass and this implementation successfully
> interoperates with itself using these enctypes. Therefore I believe
> it to be safe to merge.
>=20
> When this series gets merged, the Linux NFS community should select
> and announce a date-certain for removal of SunRPC's DES-based
> enctype code.
>=20
> ---
>=20
> Changes since v1:
> - Addressed Simo's NAK on "SUNRPC: Improve Kerberos confounder generation=
"
> - Added Cc: linux-kselftest@ for review of the KUnit-related patches
>=20
>=20
> Chuck Lever (41):
>       SUNRPC: Add header ifdefs to linux/sunrpc/gss_krb5.h
>       SUNRPC: Remove .blocksize field from struct gss_krb5_enctype
>       SUNRPC: Remove .conflen field from struct gss_krb5_enctype
>       SUNRPC: Improve Kerberos confounder generation
>       SUNRPC: Obscure Kerberos session key
>       SUNRPC: Refactor set-up for aux_cipher
>       SUNRPC: Obscure Kerberos encryption keys
>       SUNRPC: Obscure Kerberos signing keys
>       SUNRPC: Obscure Kerberos integrity keys
>       SUNRPC: Refactor the GSS-API Per Message calls in the Kerberos mech=
anism
>       SUNRPC: Remove another switch on ctx->enctype
>       SUNRPC: Add /proc/net/rpc/gss_krb5_enctypes file
>       NFSD: Replace /proc/fs/nfsd/supported_krb5_enctypes with a symlink
>       SUNRPC: Replace KRB5_SUPPORTED_ENCTYPES macro
>       SUNRPC: Enable rpcsec_gss_krb5.ko to be built without CRYPTO_DES
>       SUNRPC: Remove ->encrypt and ->decrypt methods from struct gss_krb5=
_enctype
>       SUNRPC: Rename .encrypt_v2 and .decrypt_v2 methods
>       SUNRPC: Hoist KDF into struct gss_krb5_enctype
>       SUNRPC: Clean up cipher set up for v1 encryption types
>       SUNRPC: Parametrize the key length passed to context_v2_alloc_ciphe=
r()
>       SUNRPC: Add new subkey length fields
>       SUNRPC: Refactor CBC with CTS into helpers
>       SUNRPC: Add gk5e definitions for RFC 8009 encryption types
>       SUNRPC: Add KDF-HMAC-SHA2
>       SUNRPC: Add RFC 8009 encryption and decryption functions
>       SUNRPC: Advertise support for RFC 8009 encryption types
>       SUNRPC: Support the Camellia enctypes
>       SUNRPC: Add KDF_FEEDBACK_CMAC
>       SUNRPC: Advertise support for the Camellia encryption types
>       SUNRPC: Move remaining internal definitions to gss_krb5_internal.h
>       SUNRPC: Add KUnit tests for rpcsec_krb5.ko
>       SUNRPC: Export get_gss_krb5_enctype()
>       SUNRPC: Add KUnit tests RFC 3961 Key Derivation
>       SUNRPC: Add Kunit tests for RFC 3962-defined encryption/decryption
>       SUNRPC: Add KDF KUnit tests for the RFC 6803 encryption types
>       SUNRPC: Add checksum KUnit tests for the RFC 6803 encryption types
>       SUNRPC: Add encryption KUnit tests for the RFC 6803 encryption type=
s
>       SUNRPC: Add KDF-HMAC-SHA2 Kunit tests
>       SUNRPC: Add RFC 8009 checksum KUnit tests
>       SUNRPC: Add RFC 8009 encryption KUnit tests
>       SUNRPC: Add encryption self-tests
>=20
>=20
>  fs/nfsd/nfsctl.c                         |   74 +-
>  include/linux/sunrpc/gss_krb5.h          |  196 +--
>  include/linux/sunrpc/gss_krb5_enctypes.h |   41 -
>  net/sunrpc/.kunitconfig                  |   30 +
>  net/sunrpc/Kconfig                       |   96 +-
>  net/sunrpc/auth_gss/Makefile             |    2 +
>  net/sunrpc/auth_gss/auth_gss.c           |   17 +
>  net/sunrpc/auth_gss/gss_krb5_crypto.c    |  656 +++++--
>  net/sunrpc/auth_gss/gss_krb5_internal.h  |  232 +++
>  net/sunrpc/auth_gss/gss_krb5_keys.c      |  416 ++++-
>  net/sunrpc/auth_gss/gss_krb5_mech.c      |  730 +++++---
>  net/sunrpc/auth_gss/gss_krb5_seal.c      |  122 +-
>  net/sunrpc/auth_gss/gss_krb5_seqnum.c    |    2 +
>  net/sunrpc/auth_gss/gss_krb5_test.c      | 2040 ++++++++++++++++++++++
>  net/sunrpc/auth_gss/gss_krb5_unseal.c    |   63 +-
>  net/sunrpc/auth_gss/gss_krb5_wrap.c      |  124 +-
>  net/sunrpc/auth_gss/svcauth_gss.c        |   65 +
>  17 files changed, 4001 insertions(+), 905 deletions(-)
>  delete mode 100644 include/linux/sunrpc/gss_krb5_enctypes.h
>  create mode 100644 net/sunrpc/.kunitconfig
>  create mode 100644 net/sunrpc/auth_gss/gss_krb5_internal.h
>  create mode 100644 net/sunrpc/auth_gss/gss_krb5_test.c
>=20
> --
> Chuck Lever

I reviewed the whole patchset (except the Camellia related commits):
Reviewed-by: Simo Sorce <simo@redhat.com>

Simo.

--=20
Simo Sorce
RHEL Crypto Team
Red Hat, Inc



