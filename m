Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0201D6BEF95
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 18:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCQRYL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCQRYK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 13:24:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559254FCC5
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 10:23:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 052F7B82641
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 17:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5119EC433EF;
        Fri, 17 Mar 2023 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679073836;
        bh=rfz/iZAirJx/VfFdsx2OzYJ9El+SVEA3EththuZMBRM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cQuMJvW+cSB4Dp75KZ9YPP5QmvA1suPyrJvTa0C8glch1cR3fZ6QY5iun7RbYf+7W
         GUMAvZCN8PIOwm2retcrxEZF37muNsdLR6bTdqJF98Fp1yZofTsOaMaoazLbjJkebR
         RLpfXQTC0CINh3TR2JfVry/lwiLp7d6q1ZF2Rbc+Vuu+drb4Nc031vq4YyMtsVyRsz
         rFkMloPPTNbFl4HhCjKCSd53zKbhl1EWhbDs/6w/Ug7E8QPUgxMGtv421qri4YmD+M
         oADJavjDXkiN2EqElKh8czOasYb0CKlm3lWOPNdfY99ENcUEtSdKPHzRl4yKfVEJKi
         zXFpiIbr3P1Fg==
Message-ID: <c40c8cb067f0d33d0eb5cb70c236ec5402535990.camel@kernel.org>
Subject: Re: [PATCH 1/2] nfsd: don't replace page in rq_pages if it's a
 continuation of last page
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>
Date:   Fri, 17 Mar 2023 13:23:55 -0400
In-Reply-To: <9EAA4947-0139-481D-8D0A-6DF30444342D@oracle.com>
References: <20230317105608.19393-1-jlayton@kernel.org>
         <c57b48f500b859a3daf6f95ccefdfbec72e1c9de.camel@kernel.org>
         <65C84563-6BCD-41CE-AF68-80E1869D217F@oracle.com>
         <c1d4fbaf83c6e1e41e31f77d58d889adaecb6d35.camel@kernel.org>
         <9EAA4947-0139-481D-8D0A-6DF30444342D@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-03-17 at 15:04 +0000, Chuck Lever III wrote:
>=20
> > On Mar 17, 2023, at 10:59 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2023-03-17 at 14:16 +0000, Chuck Lever III wrote:
> >=20
> > > In the patch description, would you mention that this case
> > > arises if the READ request is not page-aligned?
> >=20
> > Does it though? I'm not sure that page alignment has that much to do
> > with it. I imagine you can hit this even with aligned I/Os.
>=20
> Maybe, but no-one has actually seen that. The vast majority of
> reports of this problem are with unaligned I/O, which POSIX OS
> NFS clients (like the Linux NFS client) usually avoid.
>=20
> I didn't mean to exclude the possibility of hitting this issue
> in other ways, but simply observing a common way it is hit.
>=20

An unaligned read will consume an extra page, so maybe it just makes it
more likely to overrun the array in that case?
--=20
Jeff Layton <jlayton@kernel.org>
