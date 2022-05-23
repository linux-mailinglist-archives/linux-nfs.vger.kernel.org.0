Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF25319D2
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 22:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiEWUck (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 16:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiEWUcj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 16:32:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7731B98587
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 13:32:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29557B815C6
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 20:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954D8C385AA;
        Mon, 23 May 2022 20:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653337948;
        bh=gDd+KzurLAt2VpEKIBfSRbt/bdTtiXOEA1hCzRSW6Mw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QZZjKFVoollCsMZy8TUQHrVyaDmN6HtGn4V4cOL/aRWNZ1lysCqARO6KUK8JkY1YE
         nADnXGcHSbFV6d0dPIKnTcLY714MN1R1l4zuUSIYaJ26OrhMSbrcJySDPNUsDw8nWb
         sNKO3iwE3cvNLyaAZFo7YYvWeaCJjOwHssiR2INjmVmsNGUZM75fqey0Nl9Mpc2Pnj
         4h+ob2XlIskheDEZTk2b8VOIrwdz+XCgmBoToz0txL/gY+qqTFEs+VLeGkb0aUvw7y
         cNCtDn8bLYiT64cYzy4D1dszgTjFAappRPT4Of3gSkH0axa4+XDq8E+5trVHaiJik9
         vnk4Sj3jltz8A==
Message-ID: <b0ffb06ca7c270e2e3c3ae1b25596c32b6c5b54a.camel@kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 23 May 2022 16:32:26 -0400
In-Reply-To: <20220523201752.GI24163@fieldses.org>
References: <165323344948.2381.7808135229977810927.stgit@bazille.1015granger.net>
         <fe3f9ece807e1433631ee3e0bd6b78238305cb87.camel@kernel.org>
         <510282CB-38D3-438A-AF8A-9AC2519FCEF7@oracle.com>
         <c3d053dc36dd5e7dee1267f1c7107bbf911e4d53.camel@kernel.org>
         <1A37E2B5-8113-48D6-AF7C-5381F364D99E@oracle.com>
         <c357e63272de96f9e7595bf6688680879d83dc83.camel@kernel.org>
         <FF7F2939-C3DE-4584-BFFA-13B554706B9C@oracle.com>
         <f20de886f02402970c86c5195ea344de128afd91.camel@kernel.org>
         <9D7CE6C9-579D-4DF3-9425-4CE0099E75E0@oracle.com>
         <aed59b68ecbd312972fbcba0c369b39f6812fe2b.camel@kernel.org>
         <20220523201752.GI24163@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-05-23 at 16:17 -0400, J. Bruce Fields wrote:
> On Mon, May 23, 2022 at 03:43:28PM -0400, Jeff Layton wrote:
> > On Mon, 2022-05-23 at 19:35 +0000, Chuck Lever III wrote:
> > >=20
> > > > On May 23, 2022, at 1:38 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
> > > > On Mon, 2022-05-23 at 17:25 +0000, Chuck Lever III wrote:
> > > > >=20
> > > > > > On May 23, 2022, at 12:37 PM, Jeff Layton <jlayton@kernel.org> =
wrote:
> > > > > >=20
> > > > > > His suggestion was just to keep a counter in the lockowner of h=
ow many
> > > > > > locks are associated with it. That seems like a good suggestion=
, though
> > > > > > you'd probably need to add a parameter to lm_get_owner to indic=
ate
> > > > > > whether you were adding a new lock or just doing a conflock cop=
y.
> > > > >=20
> > > > > locks_copy_conflock() would need to take a boolean parameter
> > > > > that callers would set when they actually manipulate a lock.
> > > > >=20
> > > >=20
> > > > Yep. You'd also have to add a bool arg to lm_put_owner so that you =
know
> > > > whether you need to decrement the counter.
> > >=20
> > > It's the lm_put_owner() side that looks less than straightforward.
> > > Suggestions and advice welcome there.
> > >=20
> >=20
> > Maybe add a new fl_flags value that indicates that a particular lock is
> > a conflock and not a lock record? Then locks_release_private could use
> > that to pass the appropriate argument to lm_put_owner.
> >=20
> > That's probably simpler overall than trying to audit all of the
> > locks_free_lock callers.
>=20
> Should conflock parameters really be represented by file_lock structures
> at all?  It always seemed a little wrong to me.  But, that's a bit of
> derail, apologies.
>=20

Probably not.

Lock requests should also not be represented by struct file_lock, but
that decision was made quite some time ago. We could change these things
these days, but it'd be a lot of churn.

Even if we did use a different struct for conflocks though, it would
still need a way to point at the lockowner (or clone/free its info
somehow). It wouldn't materially change what we need to do here.
--=20
Jeff Layton <jlayton@kernel.org>
