Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B6F61333F
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 11:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJaKIj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 06:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJaKIj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 06:08:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63994DF03
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 03:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E2FBB812A4
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 10:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2A3C433D6;
        Mon, 31 Oct 2022 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667210915;
        bh=huDJkYfzviHYx7yVvCMNWSIz3Ux44W/Fyagi1fZGPb0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Kgm2ovogoW7ObXaLB1dSgRlfOieZq7L3v6OHqmOnfhtYQQBCZJyBvYLeqQNjYOrpw
         rvrGzj4JbiUXSCZ/64NlELdfL8aKhtRVm8K4M1PyY1Z9h3uxeP2OUzd3cNN8tK/TWJ
         8/9hsiTrzcovdPQJkhdIp23h/9afiv0u4woxx9Y6+ZO6cKgtg5EybBPi7uanvPqg+Y
         bFmLT8Js652hHOmq5/lIA6KUnTApa/mhy/38wP3VhDllXABAu1otFkwkH4d+WqQ6Ol
         Uw5Xoe7L+ODsdrVyUMrcpT4Po1NhNxIPeQeCJO2/VhL484idcwuXIPewDM8gmhxvtO
         IeKz6WdJqpYLw==
Message-ID: <fb57d2cb6769dbc123e15e76ec2c23b1fa9f32be.camel@kernel.org>
Subject: Re: [PATCH v3 3/4] nfsd: close race between unhashing and LRU
 addition
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 31 Oct 2022 06:08:33 -0400
In-Reply-To: <1737B8C1-5B93-4887-A673-F9AFA6ED32C0@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
         <20221028185712.79863-4-jlayton@kernel.org>
         <08778EE0-CBDC-467B-ACA6-9D8E6719E1BB@oracle.com>
         <166716630911.13915.14442550645061536898@noble.neil.brown.name>
         <1737B8C1-5B93-4887-A673-F9AFA6ED32C0@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-31 at 02:51 +0000, Chuck Lever III wrote:
>=20
> > On Oct 30, 2022, at 5:45 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Sat, 29 Oct 2022, Chuck Lever III wrote:
> > >=20
> > > > On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
> > > > The list_lru_add and list_lru_del functions use list_empty checks t=
o see
> > > > whether the object is already on the LRU. That's fine in most cases=
, but
> > > > we occasionally repurpose nf_lru after unhashing. It's possible for=
 an
> > > > LRU removal to remove it from a different list altogether if we los=
e a
> > > > race.
>=20
> Can that issue be resolved by simply adding a "struct list_head nf_dispos=
e"
> field? That might be more straightforward than adding conditional logic.
>=20

Yes, though that would take more memory.

>=20
> > > I've never seen that happen. lru field re-use is actually used in oth=
er
> > > places in the kernel. Shouldn't we try to find and fix such races?
> > >=20
> > > Wasn't the idea to reduce the complexity of nfsd_file_put ?
> > >=20
> >=20
> > I think the nfsd filecache is different from those "other places"
> > because of nfsd_file_close_inode() and related code.  If I understand
> > correctly, nfsd can remove a file from the filecache while it is still
> > in use.
>=20
> Not sure about that; I think nfsd_file_close_inode() is invoked only
> when a file is deleted. I could be remembering incorrectly, but that
> seems like a really difficult race to hit.
>=20

I think that's correct. We have a notifier set up that tells us when the
link count goes to zero. At that point we want to unhash the thing and
try to get it out of the cache ASAP.

FWIW, the main impetus for this was NFS reexport. Keeping unlinked files
in the cache could cause the reexporting server to do a bunch of
unnecessary silly-renaming.

> > In this case it needs to be unhashed and removed from the lru -
> > and then added to a dispose list - while it might still be active for
> > some IO request.
> >=20
> > Prior to Commit 8d0d254b15cc ("nfsd: fix nfsd_file_unhash_and_dispose")
> > unhash_and_dispose() wouldn't add to the dispose list unless the
> > refcount was one.  I'm not sure how racy this test was, but it would
> > mean that it is unlikely for an nfsd_file to be added to the dispose li=
st
> > if it was still in use.
> >=20
> > After that commit it seems more likely that a nfsd_file will be added t=
o
> > a dispose list while it is in use.
>=20
> After it's linked to a dispose list via nf_lru, list_lru_add won't put
> it on the LRU -- it becomes a no-op because nf_lru is now !empty. I
> think we would have seen LRU corruption pretty quickly. Re-reading
> Jeff's patch description, that might not be the problem he's trying
> to address here.
>=20
> But, it would be easy to do some reality testing. I think you could
> add a WARN_ON or tracepoint in nfsd_file_free() or somewhere in the
> dispose-list path to catch an in-use nfsd_file?
>=20
>=20
> > As we add/remove things to a dispose list without a lock, we need to be
> > careful that no other thread will add the nfsd_file to an lru at the
> > same time.  refcounts will no longer provide that protection.  Maybe we
> > should restore the refcount protection, or maybe we need a bit as Jeff
> > has added here.
>=20
> I'm not opposed to defensive changes, in general. This one seems to be
> adding significant complexity without a clear hazard. I'd like to have
> a better understanding of exactly what misbehavior is being addressed.
>=20

The real danger is that we could end up trying to remove an entry from
the LRU, when it's actually sitting on a dispose list. Without some way
to distinguish where it is, we could cause memory corruption.

--=20
Jeff Layton <jlayton@kernel.org>
