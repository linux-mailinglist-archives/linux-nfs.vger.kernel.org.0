Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6566BFB94
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Mar 2023 17:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjCRQh7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Mar 2023 12:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRQh6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Mar 2023 12:37:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AE136084
        for <linux-nfs@vger.kernel.org>; Sat, 18 Mar 2023 09:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D7A860ECD
        for <linux-nfs@vger.kernel.org>; Sat, 18 Mar 2023 16:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15303C433D2;
        Sat, 18 Mar 2023 16:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679157476;
        bh=xjojnyYShdsXEgETvHuwwYYrNPkucLcBBakEbKcWDg0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YiMImVFi64mhpudWTIJh3fjEBAi/W/ZYc15yieZP2an1U5HdFL//ljgGSRSIaKzun
         XykMIFf7zpgV/66Ok5ys19Q3B7DZDOlmApK1Zso7lL2MGG42DvqiprT3Mdt9kjznTZ
         eVW7KFKMPjhBxinqgnqcRPoaaFHQwVdmIvZP/UwivJt7thz4FG9ZLCmpxfiu/ndic5
         VKXrULiYhqrXuyB+tws7IGdVL/xZmygJMGALl8xr/WUPEfOjZlaz6QY6oGtN8h6NX0
         /55JvSqC2lMv1Z5fv1koKEvD8h6niNBW3n2mLfg0teYOatuaycYQ9RuQA0Mnkl05lm
         h2XUa0v1x9AQA==
Message-ID: <e09daca61c29b70fcc990896c78ecdfd06532411.camel@kernel.org>
Subject: Re: [PATCH v1 0/3] rq_pages bounds checking
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>
Date:   Sat, 18 Mar 2023 12:37:54 -0400
In-Reply-To: <8356EDBD-7062-4F44-87F1-FF2BAE7F359F@oracle.com>
References: <167909365790.1672.13118429954916842449.stgit@klimt.1015granger.net>
         <cf2ad1349a19b472653c500cc7e287843a0cb8c7.camel@kernel.org>
         <8356EDBD-7062-4F44-87F1-FF2BAE7F359F@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 2023-03-18 at 15:20 +0000, Chuck Lever III wrote:
>=20
> > On Mar 18, 2023, at 6:04 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2023-03-17 at 19:01 -0400, Chuck Lever wrote:
> > > A slightly modified take on Jeff's earlier patches, tested with
> > > both NFSv3 and NFSv4.1 via simple fault injection in
> > > svc_rqst_replace_page().
> > >=20
> > > In general I'm in favor of more rq_pages bounds checking by
> > > replacing direct modification of the rq_respages and rq_next_page
> > > fields with accessor functions.
> > >=20
> > > ---
> > >=20
> > > Chuck Lever (2):
> > >      SUNRPC: add bounds checking to svc_rqst_replace_page
> > >      NFSD: Watch for rq_pages bounds checking errors in nfsd_splice_a=
ctor()
> > >=20
> > > Jeff Layton (1):
> > >      nfsd: don't replace page in rq_pages if it's a continuation of l=
ast page
> > >=20
> > >=20
> > > fs/nfsd/vfs.c                 | 15 +++++++++++++--
> > > include/linux/sunrpc/svc.h    |  2 +-
> > > include/trace/events/sunrpc.h | 25 +++++++++++++++++++++++++
> > > net/sunrpc/svc.c              | 15 ++++++++++++++-
> > > 4 files changed, 53 insertions(+), 4 deletions(-)
> > >=20
> > > --
> > > Chuck Lever
> > >=20
> >=20
> > Looks good, Chuck, thanks. You can add this to the last two:
> >=20
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> Excellent, thanks!
>=20
> When I started I expected 3/3 to be more substantial, but since it's
> just a handful of lines and the patch descriptions are about the same,
> I'm going to squash 2/3 and 3/3 together.
>=20
> Only question is whether to apply that to nfsd-next or nfsd-fixes.
> Since it's a defensive change, I was thinking nfsd-next. Let me know
> if you think it should get merged sooner.
>=20

No, that sounds fine for those. Patch #1 needs to go in ASAP, of course.
--=20
Jeff Layton <jlayton@kernel.org>
