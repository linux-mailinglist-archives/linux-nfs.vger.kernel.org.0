Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296C86F777B
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 22:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjEDUxh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 16:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjEDUxf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 16:53:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C72412487
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 13:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F327D639EE
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 20:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DD2C4339B
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 20:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683233513;
        bh=8jM0/Qj2WU4shRKzQc3upkrAdrwdleE+htj4DhBjlBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Az9Ug6xU8ZbKbC7tCDbi3Qux8tZCa0uyH9yoaZeMVtvuwoyvljJZWyX67zaGiLHox
         PdfwiZ6S3BOwQhDdTwa4uSJlXXWysH3uH9ey7/Wpz9EhTEHmtYS/0Ag3UrC7flUOBr
         UuoS1thl9G36siqGwjo6BRMKJY/HiR+DrxOs/ScEDG+mt0PbHFMQBB9ZgZXgwIWrx7
         zkNUwSRiDrHgYt2vC2H6iLNdW0eM2ESOEP7x0Jdh4dpLAMOlGR6zOYbM8GCnTUnUdc
         ejYWtQM6rZ0phV7YUBsdHqPvlL7g2vbOMkyUgM475BwbrYd43hDusRdRyDbUqjYRP9
         IDW3geoHeYNjg==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-75131c2997bso744244785a.1
        for <linux-nfs@vger.kernel.org>; Thu, 04 May 2023 13:51:53 -0700 (PDT)
X-Gm-Message-State: AC+VfDyHu6p5f4sZr8oGOgqA12UvxjLQvotesyPNXGtQY2p4pwPGqHPT
        AhRxehs91FUAzRo5sASFoLctKU6Zl3mHNjljX2s=
X-Google-Smtp-Source: ACHHUZ6F++MY2R65JYl5UZFbH9SO3PLTHp3Q1P3f7FPjpqtIRraj+PWsL9KXvKZsQcX8qyNK3BHAZoxTzEFeMEbk69Q=
X-Received: by 2002:a05:622a:510:b0:3ef:2eab:3451 with SMTP id
 l16-20020a05622a051000b003ef2eab3451mr8122711qtx.20.1683233512512; Thu, 04
 May 2023 13:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230421182738.901701-1-anna@kernel.org> <B1DC5ECE-ECA8-4282-92EB-7272D091AC87@redhat.com>
In-Reply-To: <B1DC5ECE-ECA8-4282-92EB-7272D091AC87@redhat.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 4 May 2023 16:51:36 -0400
X-Gmail-Original-Message-ID: <CAFX2Jf=rcZfTRXNOoiZj91=pTWQEPrkq8VqBHY3AyC7rBe8sew@mail.gmail.com>
Message-ID: <CAFX2Jf=rcZfTRXNOoiZj91=pTWQEPrkq8VqBHY3AyC7rBe8sew@mail.gmail.com>
Subject: Re: [RFC PATCH] NFS: add a sysfs file for enabling & disabling nfs features
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 4, 2023 at 8:56=E2=80=AFAM Benjamin Coddington <bcodding@redhat=
.com> wrote:
>
> On 21 Apr 2023, at 14:27, Anna Schumaker wrote:
>
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > And add some basic checking so we only enable features that are present
> > in a given NFS version.
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
>
> This is great, I like how you've kept the +/- notation similar to knfsd
> supported versions.
>
> Another way to do this would be an attribute file per capability, setting=
 it
> to 0 or 1 which is more inline with sysfs usage.
>
> I think if we do use this, we ought to leave readdir plus out of it becau=
se
> there's already a mount option for it.  Readdir plus can be turned on and
> off with a remount already.  The issue for me would be how to work out wh=
at
> the behavior should be when we have a mount that has "nordirplus" and the=
n
> someone tries to toggle it via sysfs.

That makes sense!
>
> Any other thoughts?

I guess if we remove the readdir plus option, then we could make it so
this file only shows up on v4.2 mounts.
>
> I'll add this patch to my future postings of sysfs work.

Do you want a v2 without the readdir plus line, and with the v4.2 restricti=
on?

Anna

>
> Ben
>
