Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1BC615318
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 21:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKAUVS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 16:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKAUVR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 16:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892721C114
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 13:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B836172B
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 20:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D559C433C1;
        Tue,  1 Nov 2022 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667334075;
        bh=G/SQ75DKjWq8Ish+7dRX0MRkCWB3wik2KcE1UmYq+dI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TxLdjn/qlaGQp3L1UjTOiQUhvhGUqcIrCUwzo5iorV/6i/Ngn1g2y3UZxsRwwwWl+
         ZJSCVkn6cXXQX489KuGwmWA92sj9P2SExzLZWmAxkTQUPGTmqTxPBLZJDbCwIgWm4U
         FqyhmzAqHkXTB3E9zciizIhUTkhGRg5ZN+M0Rsi1O9UqVMHtnt9BkPFZOvsmw49RKa
         i3CDb9sxxwpnefaNN6rJdGCkJUFlBvZs+SfRMxMhZpVWi4eyBRxbhEno95T37AIf8S
         pivCkzGms1l5JohGT3tex88JdTQ38KKS/fG1eTQHSg32v9NGit9diPm3fh9/6bIbUW
         ee4AaBspxcsCg==
Message-ID: <047f1ec3537279ed90c350898db26f7668dac007.camel@kernel.org>
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 01 Nov 2022 16:21:13 -0400
In-Reply-To: <0B609D3B-955F-4F15-9EDD-16B98087EF06@oracle.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
         <20221101144647.136696-4-jlayton@kernel.org>
         <42F8EAC1-7383-4B98-BAD1-D676950718E0@oracle.com>
         <17bf0292cbd63b6bb13f6595b5d82c2a173b3ee4.camel@kernel.org>
         <53599736e1733bd011325170a269e9adda2f2de1.camel@kernel.org>
         <0B609D3B-955F-4F15-9EDD-16B98087EF06@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-11-01 at 19:13 +0000, Chuck Lever III wrote:
>=20
> > On Nov 1, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Tue, 2022-11-01 at 14:03 -0400, Jeff Layton wrote:
> > > On Tue, 2022-11-01 at 17:25 +0000, Chuck Lever III wrote:
> > > >=20
> > > >=20
> > > > Test results:
> > > >=20
> > > > When I run my test I "watch cat /proc/fs/nfsd/filecache". The
> > > > workload is 12-thread "untar git && make git && make test" on
> > > > NFSv3. It's showing worse eviction behavior than the current
> > > > code.
> > > >=20
> > >=20
> > > What do you mean by "worse" here?
> > >=20
> > > > Basically all cached items appear to be immediately placed on
> > > > the LRU. Do you expect this behavior change? We want to keep
> > > > the LRU as short as possible; but maybe the LRU callback is
> > > > stopping after a few items, so it might not matter.
> > > >=20
> > >=20
> > > Could be. I'm not sure how that works.
> > >=20
> >=20
> > Looking more at the old LRU code, I'm not sure we can make a direct
> > comparison on behavior. I think that the old code was just broken, and
> > that it inappropriately took entries off the list when it shouldn't
> > have. That mostly worked out in the end, but I don't think the lifetime
> > of those entries was what was wanted or expected.
> >=20
> > With the new code, it's much more clear. The only entries on the LRU ar=
e
> > GC entries with no active references. Once nfsd_file_do_acquire is
> > called, the entry comes off the LRU.
>=20
> The new mechanism is not working the way you might have intended. I see
> the "total" and "LRU" numbers equaling each other throughout the test
> run, which is a sign the LRU is not working correctly. What you said
> here suggests that the "LRU" number is supposed to be less than the
> total number of cached items, and that's the way the old code behaved.
>=20
>=20

I've also watched that file while running xfstests on v3 and I do
occasionally see a small discrepancy between the two numbers, but they
track each other pretty closely.

That's more or less what I'd expect to see with NFSv3. In most cases
we're finding an entry for a READ/WRITE/COMMIT, using it, and then
putting it right away. GC'ed entries just live on the LRU most of the
time. We do take them off when we can, but we just can't that often.

That's ok though. Taking it off the LRU is still much cheaper than
opening a new struct file.

> > I don't see how we can make the LRU any shorter.
>=20
> I'll dig into it and see what's going on.
>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
