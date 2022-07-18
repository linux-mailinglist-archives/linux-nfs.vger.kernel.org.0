Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCFE578D07
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jul 2022 23:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiGRVnM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Jul 2022 17:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiGRVnK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Jul 2022 17:43:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D17A95
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 14:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0547F6134A
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 21:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40E0C341C0;
        Mon, 18 Jul 2022 21:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658180588;
        bh=9gts2YddiISx7UKw1kbfsRFtfp+qD9OdFpADSnud0Iw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sVrajkV+hJOraxTRmcRzeQfPGlJoX/KOfRQvzzbDsWwuSiUsZFoOzOExq3A5XTnSW
         mj7W9Q5bpgbhcaVJa3Kow97pVwCyBm3EdLnc3RcaBATfsngV0e/p+F5jRpstyiLCQh
         A2cj0poBNjrOqyEdl5EI9j1WjWsGI8C0d3ZDj/BERc7rpuuJ+lMt50fiOCI3jkmgOI
         ZOfKDCNMiZj9quaJr7MY4mB3iHrL1ukb+D4DdOPwOHJ4+bn2GGCPbkZbVT+fOS9edu
         nxbqidjz4rlzZO+WY9JHSYeATrWPHitUeyqlacK4f3o2Ar7TQWOw/qphBrHXaCk62X
         fZ+QQ2YyHEIfQ==
Message-ID: <d55ffcb38edc125a8b91c6a885e01c857238caf9.camel@kernel.org>
Subject: Re: [RFC PATCH 0/3] nfsd: close potential race between open and
 setting delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, neilb@suse.de, linux-nfs@vger.kernel.org
Date:   Mon, 18 Jul 2022 17:43:06 -0400
In-Reply-To: <20220718211819.GA28925@fieldses.org>
References: <20220714152819.128276-1-jlayton@kernel.org>
         <20220718211819.GA28925@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-07-18 at 17:18 -0400, J. Bruce Fields wrote:
> On Thu, Jul 14, 2022 at 11:28:16AM -0400, Jeff Layton wrote:
> > Here's a first stab at a patchset to close a potential race when settin=
g
> > a delegation on a file. Between the point where we open the file and
> > where we set the delegation, another task or client could unlink or
> > rename the dentry. If that occurs, we shouldn't hand out a delegation
> > in the open response, but we don't prevent that today.
> >=20
> > The basic idea here is to re-do the lookup after setting the delegation=
.
> > If the resulting dentry is not the one we have in the open, then we can
> > reject handing out a delegation.
>=20
> I have this distinct memory of actually doing that before.
>=20
> But looking through the git history all I find is 4335723e8e9f "nfsd4:
> fix delegation-unlink/rename race", from 2014, which claims to fix a
> similar-sounding race in a different way.
>=20
> How are you reproducing this?
>=20
> --b.
>=20

I'm not at all, so far. This race is entirely theoretical. Probably we
could reproduce it by introducing some artificial delays or something.

> >=20
> > Only lightly tested, so this is an RFC for now.
> >=20
> > Jeff Layton (3): nfsd: drop fh argument from alloc_init_deleg nfsd:
> > rework arguments to nfs4_set_delegation nfsd: vet the opened dentry
> > after setting a delegation
> >=20
> >  fs/nfsd/nfs4state.c | 65
> >  ++++++++++++++++++++++++++++++++++++++------- 1 file changed, 55
> >  insertions(+), 10 deletions(-)
> >=20
> > -- 2.36.1

--=20
Jeff Layton <jlayton@kernel.org>
