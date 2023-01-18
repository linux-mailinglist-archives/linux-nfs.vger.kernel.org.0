Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79EB6728A3
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 20:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjARTm3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 14:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjARTm2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 14:42:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043AB5867C
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 11:42:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91A8D619E6
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 19:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9807C433D2;
        Wed, 18 Jan 2023 19:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674070947;
        bh=7GLWOSqZ5AHaIG77AA8+hWBdi8OFev1aF3ukJHGewOc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LEjtSslh5Lywwe6C4NVj65JfDEgOqHOeAcqlyNuE5w0iNpdGxIZypWLADB7HPo0Ov
         FcABWYE9689NVi9qAXeYKace+/QkFR+TXf8s809L40Y7e1GEPnRfSKGqlTpbGjyBVL
         sclJMoMcCaoaWCwsrQuGRZEGRYrphpeWfnPNKEW5RG8L2TRWH0665WvBU/w4mKqzGo
         lhWutNppTdJPUtuOqQ9HJ219tbGyw1IZp4/sbc+cDet8KvCmQcyhM5x9P7sRNhM4Cu
         07jflueOHpKdqlFId1APXrNHMr7Z4i2QxRS07S+UEIVM2DFeFSwvHw2/kf5/nvWXPg
         bK/fQi0apWlCQ==
Message-ID: <7c2f30279da9f1c927ee3141fa14a7c14ca50297.camel@kernel.org>
Subject: Re: [PATCH 3/6] nfsd: simplify the delayed disposal list code
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 18 Jan 2023 14:42:25 -0500
In-Reply-To: <0BDD4ABB-2470-483A-A2F7-C65B84546FB5@oracle.com>
References: <20230118173139.71846-1-jlayton@kernel.org>
         <20230118173139.71846-4-jlayton@kernel.org>
         <0BDD4ABB-2470-483A-A2F7-C65B84546FB5@oracle.com>
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

On Wed, 2023-01-18 at 19:08 +0000, Chuck Lever III wrote:
>=20
> > On Jan 18, 2023, at 12:31 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > When queueing a dispose list to the appropriate "freeme" lists, it
> > pointlessly queues the objects one at a time to an intermediate list.
> >=20
> > Remove a few helpers and just open code a list_move to make it more
> > clear and efficient. Better document the resulting functions with
> > kerneldoc comments.
>=20
> I'd like to freeze the filecache code until we've sorted out the
> destroy_deleg_unhashed crashes. Shall I simply maintain 3/6 and
> 4/6 and any subsequent filecache changes (like my rhltable
> rewrite) on a topic branch?
>=20
> One good reason to do that is to enable an eventual fix to be
> backported to stable kernels without also needing to pull in
> intervening clean-up patches.
>=20
> I've already applied a couple small changes that I would rather
> wait on for this reason. I might move those over to the topic
> branch as well... I promise to keep it based on nfsd-next so it
> makes sense to continue developing filecache work on top of the
> topic branch.
>=20
> The other patches in this series are sensible clean-ups that I
> plan to apply for v6.3 if there are no other objections.
>=20

So that means you won't take patches 3 and 4, but the rest are ok?
--=20
Jeff Layton <jlayton@kernel.org>
