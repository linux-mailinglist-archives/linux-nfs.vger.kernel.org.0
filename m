Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B664D56B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Dec 2022 04:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLODDY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Dec 2022 22:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLODDW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Dec 2022 22:03:22 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412FA50D7E
        for <linux-nfs@vger.kernel.org>; Wed, 14 Dec 2022 19:03:20 -0800 (PST)
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3C49341546
        for <linux-nfs@vger.kernel.org>; Thu, 15 Dec 2022 03:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1671073397;
        bh=Shp823L6RZfDJayvg71t5HMZdkNSNeqW9yhC4NveSrM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=WZu28dwR0wBInT+BwehCkkNczEcQdCpp82syNu2rFOdYFgg2+RJNHIxQifYnUV6Oc
         qwAIBEoQtQzVvjpNdLOEFFb9AFLRD5+J3No6QnL/1Qe2MAM1Q+4Cirpm3jWg4PjGL9
         pR9AxA5Z2KYBmk2WRjzeYZsnGMzyMQf42TIucAHkOFlXuJLFoAN2o7dmL17ExqJy8h
         dgjnXJZHxYv6OeXT5j78Sns1wWh/CR+lUI5NXsvDQIHAMQKuXsW52DzPWP3qOJnw/D
         jzP/7xs7SD0cTlFIdZfrYjWnjoaXPNN+jh2eIBtH9ON/CY+yg3zpvsXVW0wqpwI4PJ
         t0IaD/UTcSqxw==
Received: by mail-ua1-f72.google.com with SMTP id s15-20020ab04a8f000000b0042be99707aaso736523uae.16
        for <linux-nfs@vger.kernel.org>; Wed, 14 Dec 2022 19:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Shp823L6RZfDJayvg71t5HMZdkNSNeqW9yhC4NveSrM=;
        b=zQGbjVOD6dNvVV/5xCddZ1X5KGmaeWgpNPlogbbmCZG2puhNWlz+3aB0YK34p21qh0
         +JgKKG20b952cJh6qi4Q5BnXPZaoEbDSxCoaMlEg47R+uc8qUr8aJ9B6lcAWJ9pC/CFT
         UZ5gC0+FQc+g5OfeREdumOr+FAVWOJFaSHdjBaWDZgUkBGre0D6SlEsJZYzQ2QrIcoz9
         C6NJWnW7yC5kE6gXj9XZ2XKPwB4JbUTUg9bSI5O5B0uY0Z3uk6bng3324JlaeXiBoEBv
         4Q8Y56wZ9YFP7sIlj6zsCk+jjWiYS4iSibrUCzFifRiqZq0qYvu71f5q9O2SJt1GRpAk
         Fh5Q==
X-Gm-Message-State: ANoB5plkYm3faRTIY6sn0Y8AgtCNLlbmTWnmJnE5DGIcSBpAle4ZInx+
        /glv2WAtO5Rru38oMZXVmCMs4HPCNPfMnNx9+azv/aYVAn056wuxglmhEL2QtOxTuCWVfeQAXuW
        vqQhQgC9/KEb4lRzRP6jaYR99AZ+HJwvzhYujfF0Tmv/K7cXQ9pyptA==
X-Received: by 2002:a1f:5f4c:0:b0:3be:70c:a357 with SMTP id t73-20020a1f5f4c000000b003be070ca357mr3380395vkb.33.1671073395750;
        Wed, 14 Dec 2022 19:03:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf46V6j7wzDnosdj+mEU9Q0vSVnXoj4ddMLL3vH6ARqPUJaQ33n20wStZ51pvKCVN9OTKGVL+cbJSwoyOemQZN8=
X-Received: by 2002:a1f:5f4c:0:b0:3be:70c:a357 with SMTP id
 t73-20020a1f5f4c000000b003be070ca357mr3380392vkb.33.1671073395491; Wed, 14
 Dec 2022 19:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20221214084730.296936-1-chengen.du@canonical.com> <2B6CD9C5-EE21-4275-9F6E-AF1C1C5E164F@hammerspace.com>
In-Reply-To: <2B6CD9C5-EE21-4275-9F6E-AF1C1C5E164F@hammerspace.com>
From:   Chengen Du <chengen.du@canonical.com>
Date:   Thu, 15 Dec 2022 11:03:04 +0800
Message-ID: <CAPza5qdWzbNcBt7ZvUxtonB38v07cDVPkBOtdBPvK=3_Y+rWgg@mail.gmail.com>
Subject: Re: [PATCH] NFS: fix client permission error after adding user to
 permissible group
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Charles Edward Lever <chuck.lever@oracle.com>,
        Jeffrey Layton <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

Thanks for your information.

Best regards,
Chengen Du

On Thu, Dec 15, 2022 at 3:42 AM Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>
>
>
> > On Dec 14, 2022, at 03:47, Chengen Du <chengen.du@canonical.com> wrote:
> >
> > The access cache only expires if either NFS_INO_INVALID_ACCESS flag is =
on
> > or timeout (without delegation).
> > Adding a user to a group in the NFS server will not cause any file
> > attributes to change.
> > The client will encounter permission errors until other file attributes
> > are changed or the memory cache is dropped.
> >
> > Steps to reproduce the issue:
> > 1.[client side] testuser is not part of testgroup
> >  testuser@kinetic:~$ ls -ld /mnt/private/
> >  drwxrwx--- 2 root testgroup 4096 Nov 24 08:23 /mnt/private/
> >  testuser@kinetic:~$ mktemp -p /mnt/private/
> >  mktemp: failed to create file via template
> >  =E2=80=98/mnt/private/tmp.XXXXXXXXXX=E2=80=99: Permission denied
> > 2.[server side] add testuser into testgroup, which has access to folder
> >  root@kinetic:~$ usermod -aG testgroup testuser &&
> >  echo `date +'%s'` > /proc/net/rpc/auth.unix.gid/flush
> > 3.[client side] create a file again but still fail
> >  testuser@kinetic:~$ mktemp -p /mnt/private/
> >  mktemp: failed to create file via template
> >  =E2=80=98/mnt/private/tmp.XXXXXXXXXX=E2=80=99: Permission denied
> >
>
> Thanks, but the correct way to deal with this is to log out and log back =
in again, the way the POSIX gods intended. See commit 0eb43812c027 ("NFS: C=
lear the file access cache upon login=E2=80=9D).
>
> _________________________________
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
