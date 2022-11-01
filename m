Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ADE614C75
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 15:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKAOTa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 10:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKAOT1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 10:19:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D441B9C6
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 07:19:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78DC7B81DBF
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 14:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD47C433C1;
        Tue,  1 Nov 2022 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667312362;
        bh=R5WzqtOMulKEcsxui/rDMa9X5ftlbzPPKd0L5RPdhF4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SJ1o8FbglKdbObxXVaLrW0XoThTyOr/j7ZzMIfZIGCnoebeb0cxTYNBfWdc3b2zTY
         ojkiW/Ke1ZNN8BSDNLESrBWIypi+pRHZgJsE0rjqGJTbuOKWvekZMdLrqTZfLbJAFi
         hdSqMD/n698UVOxv6wnRURwM6Rcuqp3d0ICY6TQwFvEki0u/lXL/KUVlSs8qvk5XVh
         q02wCSRxKufG+l+mCh+W71LbHPJodoZpLiIsPAi4TDODU5GBaJAFS4n0GEPLRVSczw
         NKZRqSfvMnAvpSQ43sMlMk1bjXNX3aln5CFysigui4t22ZZjSjY+VaHAPwXa4B2lpm
         1opw+Oht5PY7w==
Message-ID: <fe3e05e8ecd318468b7c544709e036d72b41d1cf.camel@kernel.org>
Subject: Re: [PATCH v3 2/4] nfsd: rework refcounting in filecache
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Tue, 01 Nov 2022 10:19:20 -0400
In-Reply-To: <494CEF8A-E9AD-400B-92E6-EEE3B2DB431D@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
         <20221028185712.79863-3-jlayton@kernel.org>
         <96D34180-0E11-4582-8B45-B3FD9CD8F2DB@oracle.com>
         <432239da4d20337f6f14c91f40fb4432e637a662.camel@kernel.org>
         <494CEF8A-E9AD-400B-92E6-EEE3B2DB431D@oracle.com>
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

On Tue, 2022-11-01 at 13:58 +0000, Chuck Lever III wrote:
>=20
> > On Oct 28, 2022, at 4:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2022-10-28 at 19:49 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
> >=20
> > > I'm still not sold on the idea of a synchronous flush in nfsd_file_fr=
ee().
> >=20
> > I think that we need to call this there to ensure that writeback errors
> > are handled. I worry that if try to do this piecemeal, we could end up
> > missing errors when they fall off the LRU.
> >=20
> > > That feels like a deadlock waiting to happen and quite difficult to
> > > reproduce because I/O there is rarely needed. It could help to put a
> > > might_sleep() in nfsd_file_fsync(), at least, but I would prefer not =
to
> > > drive I/O in that path at all.
> >=20
> > I don't quite grok the potential for a deadlock here. nfsd_file_free
> > already has to deal with blocking activities due to it effective doing =
a
> > close(). This is just another one. That's why nfsd_file_put has a
> > might_sleep in it (to warn its callers).
> >=20
> > What's the deadlock scenario you envision?
>=20
> I never answered this question.
>=20
> I'll say up front that I believe this problem exists in the current code
> base, so what follows is meant to document an existing issue rather than
> a problem with this patch series.
>=20
> The filecache sets up a shrinker callback. This callback uses the same
> or similar code paths as the filecache garbage collector.
>=20
> Dai has found that trying to fsync inside a shrinker callback will
> lead to deadlocks on some filesystems (notably I believe he was testing
> btrfs at the time).
>=20
> To address this, the filecache shrinker callback could avoid evicting
> nfsd_file items that are open for write.
>=20

Ok, that makes sense, particularly if btrfs needs to wait on reclaim in
order to allocate.

We already skip entries that are dirty or under writeback:

       /*                                        =20
         * Don't throw out files that are still undergoing I/O or
         * that have uncleared errors pending.
         */
        if (nfsd_file_check_writeback(nf)) {  =20
                trace_nfsd_file_gc_writeback(nf);
                return LRU_SKIP;       =20
        }                            =20

...and nfsd_file_check_writeback does:

        return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
                mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);

If that flush is due to shrinker deadlock, then you'd have to hit a
pretty tight race window, I think.

Actually...this may have been due to a race in the existing lru
callback. It didn't properly decrement the refcount when isolating
entries from the LRU, which left a pretty big window open for new
references to be grabbed while we were trying to reap the thing. These
patches may improve that if so.

FWIW, I think we're "within our rights" to not fsync on close here. The
downside of not doing that though is that if there are writeback errors,
they may go unreported to the client (aka silent data corruption). I'd
prefer to keep that in, unless we can demonstrate that it's a problem.
--=20
Jeff Layton <jlayton@kernel.org>
