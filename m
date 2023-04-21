Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D359B6EACEA
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 16:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjDUOaB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 10:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjDUO37 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 10:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F778AD12
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682087349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xRBcypUraCtzZJFQMCB7l2NT7D5GcycZJmpCQOTXIYY=;
        b=OOWLYYLU53nvRHwDEUFLhn06mWdwjuaSLxzW1E7fiwPCTx+XzSdzjstOySRzKaRz/4IbtG
        5LwrPPTqSpNH9h3GRMOgt9QNXmUC79k/cO995uOvYexJUDgA4fe8Nnt9PwiPr740k9/tBh
        ow9QxZT+HOl28rQRDW05unbI4jsV2Q0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-md0FmX9ZPsuLj6uX5rgeMg-1; Fri, 21 Apr 2023 10:29:08 -0400
X-MC-Unique: md0FmX9ZPsuLj6uX5rgeMg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74df5c5fd00so162210685a.3
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 07:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682087347; x=1684679347;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xRBcypUraCtzZJFQMCB7l2NT7D5GcycZJmpCQOTXIYY=;
        b=Sk3ng6ahzrwGHmCRJRGrB41Pw42NsU2sYxi1HKIC/GIGbMp3v5roU19jkIoV7xPPIW
         lWJfTBf6Y4cz2NxmKNBhlN4HfmK3uBrGWKygF+vhjQUsUJHYG+bG3631mNjkCj+AsJtD
         b/Ccs6DHUL7uJ04GL+kU+gVvluAt/0uhu2NO+D2IsCOlrLUDO/8WyN1s6z00J9JIeyj1
         O7QmAx7qDUCdndtp60HmwrnkHTpTfCMQkaABK9d9NVAs5F1Fj8OM9a56pQjKRTJ4P+GU
         zXMl/ED4oCLqpZjlwIWHh+3SbW3Sf+Qal5ChS4xdxf2DlqkryRH4QS9kXJS1xM1ILDM9
         e1sw==
X-Gm-Message-State: AAQBX9eyWQwWzpai1YpwsBGKXduZ+e3DdRDBw/y0PXqqGCxd1+ypxZtV
        3OGG1CoK84d5wOh3Xsk1ni2jEPfP2zwPiy70e2vFFq8TfeWCBBqU1fqWypSp8o272PNdzAiyBSz
        uIxpVnTLs6ilGUqoH499JN8RDZT12
X-Received: by 2002:ac8:5e0d:0:b0:3ef:3edb:7676 with SMTP id h13-20020ac85e0d000000b003ef3edb7676mr8907203qtx.61.1682087347514;
        Fri, 21 Apr 2023 07:29:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350YSBTp29qJT43yxFm9b6eKQiEPpNgDdYktYXW3qbmDTYpvGM0Xxv6zwjdzay0nvd7IMkXUtJg==
X-Received: by 2002:ac8:5e0d:0:b0:3ef:3edb:7676 with SMTP id h13-20020ac85e0d000000b003ef3edb7676mr8907180qtx.61.1682087347268;
        Fri, 21 Apr 2023 07:29:07 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id z42-20020a05620a262a00b00745f3200f54sm1347268qko.112.2023.04.21.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:29:06 -0700 (PDT)
Message-ID: <16786c40c480b96cfe3a1727cad6d7f389f8f17f.camel@redhat.com>
Subject: Re: Fedora packages for ktls testing available
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>
Date:   Fri, 21 Apr 2023 10:29:06 -0400
In-Reply-To: <2CFA4DB8-7EAD-46CB-970F-67CD5FCF9D36@oracle.com>
References: <85ee133945a9f816ffb9612146a6f835c6d443ec.camel@redhat.com>
         <2CFA4DB8-7EAD-46CB-970F-67CD5FCF9D36@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-04-21 at 13:32 +0000, Chuck Lever III wrote:
>=20
> > On Apr 20, 2023, at 12:17 PM, Jeff Layton <jlayton@redhat.com> wrote:
> >=20
> > I have a Fedora COPR repo set up with the latest RPC with TLS bits from
> > Chuck:
> >=20
> >    https://copr.fedorainfracloud.org/coprs/jlayton/rpctls/
> >=20
> > It has a kernel package (currently based on v6.3-rc7), an updated nfs-
> > utils package (only needed by the NFS server), and a new ktls-utils
> > package (0.8 based currently) that I'm working to get into the main
> > Fedora repos after the kernel patches are merged.
> >=20
> > My goal is to keep this up to date until the relevant code starts
> > landing in the main Fedora repos.
>=20
> Hi Jeff-
>=20
> Excellent work!
>=20
> I've had questions about building ktls-utils so I'm interested in
> your experience packaging it.
>=20
> On Fedora, folks have installed keyutils-lib and keyutils-lib-devel
> but ./configure still reports:
>=20
>   Package 'libkeyutils', required by 'virtual:world', not found
>=20
> Did you encounter this issue, and if so, how did you resolve it?
>=20

Thanks! I missed adding the client patches to the most recent kernel
build, but they should be in there in the next one (brewing now).

No, I haven't seen that error. I did go several rounds with failed
package builds due to build dependencies. The current specfile has this:

    BuildRequires:  gcc make gnutls-devel libnl3-devel systemd-rpm-macros
    BuildRequires:  autoconf automake keyutils-libs-devel glib2-devel

...and that allowed it to build on f37 and up for me.
--=20
Jeff Layton <jlayton@redhat.com>

