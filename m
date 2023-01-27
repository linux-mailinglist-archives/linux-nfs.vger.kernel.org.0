Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D7667ED02
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jan 2023 19:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjA0SED (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Jan 2023 13:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjA0SED (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Jan 2023 13:04:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0987B73768
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 10:03:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90C98618C5
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 18:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE65C433EF;
        Fri, 27 Jan 2023 18:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674842637;
        bh=cvyL+KMKGVJEOim9sQxyX0Ar4TlIjTbNCCce7xBcWQE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fQAB/wl03miOZU21Y+PzWbSKOq+b6pWbgLHXqDLfsFeMI5zcgW2oGt8Iti96jAIxg
         IZk67s/l/y/7KnqIE2i5RSDqbjmF9MN/zCtcZykkW/hg0uxZTH6Tik6r7ol84OMdr4
         DbBVXVZwoK08TtyIFfLu5LRAy0UqOmfR5X2kaO6RUcVhvKUNOdl+JQe0ErfSuRKTZB
         J94JZadBRvlFm/m2wjg2HDzxTocWLYg8dmbn1irBJgEWiUj2IAx0d9O4pY7JWxNkLB
         cKsSezjUy/jwUYrmukhul3BMxnM9J2WM5tyCqm2HW3e2KzTqfyo0HLpSubNUntIRoC
         fveW+Jullgu5w==
Message-ID: <0412daf06541dfa71866be1efedef5456e524ece.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix race to check ls_layouts
From:   Jeff Layton <jlayton@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 27 Jan 2023 13:03:56 -0500
In-Reply-To: <49815925-FB60-456F-8633-79B4C203B782@redhat.com>
References: <979eebe94ef380af6a5fdb831e78fd4c0946a59e.1674836262.git.bcodding@redhat.com>
         <C9FA580A-52A6-4208-AFA2-91E8BCB36B9F@oracle.com>
         <49815925-FB60-456F-8633-79B4C203B782@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-01-27 at 11:42 -0500, Benjamin Coddington wrote:
> On 27 Jan 2023, at 11:34, Chuck Lever III wrote:
>=20
> > > On Jan 27, 2023, at 11:18 AM, Benjamin Coddington <bcodding@redhat.co=
m> wrote:
> > >=20
> > > Its possible for __break_lease to find the layout's lease before we'v=
e
> > > added the layout to the owner's ls_layouts list.  In that case, setti=
ng
> > > ls_recalled =3D true without actually recalling the layout will cause=
 the
> > > server to never send a recall callback.
> > >=20
> > > Move the check for ls_layouts before setting ls_recalled.
> > >=20
> > > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> >=20
> > Did this start misbehaving recently, or has it always been broken?
> > That is, does it need:
> >=20
> > Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls") ?
>=20
> I'm doing some new testing of racing LAYOUTGET and CB_LAYOUTRETURN after
> running into a livelock, so I think it has always been broken and the Fix=
es
> tag is probably appropriate.
>=20
> However, now I'm wondering if we'd run into trouble if ls_layouts could b=
e
> empty but the lease still exist..  but that seems like it would be a
> different bug.
>=20

Yeah, is that even possible? Surely once the last layout is gone, we
drop the stateid? In any case, this patch looks fine. You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
