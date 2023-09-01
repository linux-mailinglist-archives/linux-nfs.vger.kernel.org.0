Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4F5790282
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Sep 2023 21:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244941AbjIAThK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Sep 2023 15:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIAThJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Sep 2023 15:37:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C1010E0;
        Fri,  1 Sep 2023 12:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B4F61CE247B;
        Fri,  1 Sep 2023 19:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849D7C433C7;
        Fri,  1 Sep 2023 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693597022;
        bh=XMuuQBVV2UQRiCaXUEOiDJLqO+1HAaVkGsWD9GVBhz4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XYuLoXgP5P6LMfKtgfBri0uxpH9dI7GgTzVTH4j3utctNy7PbYKRU+1VjFsEQUBDF
         DTl1KFh8GDE1qVd9aZ4bTPytR9za0ln4S0TtEetDZlz+AE5GBkiEmpAqkCQA9AmWH7
         ejWKeQ9N8OyEnhxrMZ7HuC7DAJqb7hkd+NqyfAW49QHmYnBH0C27IpIxvozQrrA2li
         OWC/EATVuOADyiz0RGA6cSqg7BgbsYbfv8VLdgVOa7ml2mpY2tUoJIOEBAAPZ8bhwx
         zc9IRGpfXF3x1cQErtiEMGVAPrP+Om5rnRl0T1qoqksJmct3NIT4vlSd8g6r2LzwO1
         2PBmaElMRtFpA==
Message-ID: <a00bbc4466a517f81cd02bc1f72dce92a8b14ca2.camel@kernel.org>
Subject: Re: [PATCH fstests v2 1/3] generic/294: don't run this test on NFS
From:   Jeff Layton <jlayton@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 01 Sep 2023 15:37:01 -0400
In-Reply-To: <20230901191944.lx3b643f2bwmcn3t@zlang-mailbox>
References: <20230901-nfs-skip-v2-0-9eccd59bc524@kernel.org>
         <20230901-nfs-skip-v2-1-9eccd59bc524@kernel.org>
         <20230901191944.lx3b643f2bwmcn3t@zlang-mailbox>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 2023-09-02 at 03:19 +0800, Zorro Lang wrote:
> On Fri, Sep 01, 2023 at 01:39:55PM -0400, Jeff Layton wrote:
> > When creating a new dentry (of any type), NFS will optimize away any
> > on-the-wire lookups prior to the create since that means an extra
> > round trip to the server. Because of that, it consistently fails this
> > test.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  tests/generic/294 | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tests/generic/294 b/tests/generic/294
> > index 406b1b3954b9..46c7001234a5 100755
> > --- a/tests/generic/294
> > +++ b/tests/generic/294
> > @@ -15,8 +15,10 @@ _begin_fstest auto quick
> > =20
> >  # real QA test starts here
> > =20
> > -# Modify as appropriate.
> > -_supported_fs generic
> > +# NFS will optimize away the on-the-wire lookup before attempting to
> > +# create a new file (since that means an extra round trip).
> > +_supported_fs ^nfs generic
>=20
> If we use black list, don't need to use "generic" to specify white list. =
E.g.
>=20
>   $ grep -rsn _supported_fs tests/generic/|grep \\^
>   tests/generic/699:25:_supported_fs ^overlay
>   tests/generic/631:41:_supported_fs ^overlay
>   tests/generic/679:27:_supported_fs ^xfs
>   tests/generic/500:45:_supported_fs ^btrfs
>=20
> Anyway, others look good to me, if no objection from nfs list, I can help
> to merge this patchset without the "generic" :)
>=20

Ok, I was looking at the _support_fs implementation and it looked like
you needed a "generic" entry on the end or it wouldn't pass for other
fs, but if you're sure, that sounds good to me.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
