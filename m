Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AF261332E
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 11:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJaKCG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 06:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJaKCF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 06:02:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208E6DF1E
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 03:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C510FB812A4
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 10:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18609C433D6;
        Mon, 31 Oct 2022 10:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667210521;
        bh=K5ZBjWK5ebVsAPn2pTIc+F/QmAHvrm8KGvqPVS6jbD4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PMNo8lGfVRgZ38YKHE787s38oDhL+2HqiATb7sTH1erQkB444h4nds/GyQyxn7NB3
         XTUakHQ+bYa/GcuneIlxy6WmCgegQ9ZP8XnR9e+3NVJMOnxjCj48lAGOBjdy/CAAk/
         Ou2GjzUUO5bPknOrg7RhtSUtDfI25Sf1IyRmjnEDLgjwnlD/hKtx7lPO/G76ycEgji
         3qNtKNiUVoDFwPW1qVZ8YgATK9D5W7zaCT1shl3qXc2cc6rwzInjQ7YSw//bRHqwtY
         5U/JN8bnYqEvF0CUX1C1SNDB53UrVTK2R461I0Nz+tzyNL0aZGjST/Bj5YdO+5YTJB
         2GZa2/befbtsA==
Message-ID: <c2679cde30fc64bb1df1a0bfea49c1efdbb77ec4.camel@kernel.org>
Subject: Re: [PATCH v3 3/4] nfsd: close race between unhashing and LRU
 addition
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 31 Oct 2022 06:01:59 -0400
In-Reply-To: <166716630911.13915.14442550645061536898@noble.neil.brown.name>
References: <20221028185712.79863-1-jlayton@kernel.org>
        , <20221028185712.79863-4-jlayton@kernel.org>
        , <08778EE0-CBDC-467B-ACA6-9D8E6719E1BB@oracle.com>
         <166716630911.13915.14442550645061536898@noble.neil.brown.name>
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

On Mon, 2022-10-31 at 08:45 +1100, NeilBrown wrote:
> On Sat, 29 Oct 2022, Chuck Lever III wrote:
> >=20
> > > On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > The list_lru_add and list_lru_del functions use list_empty checks to =
see
> > > whether the object is already on the LRU. That's fine in most cases, =
but
> > > we occasionally repurpose nf_lru after unhashing. It's possible for a=
n
> > > LRU removal to remove it from a different list altogether if we lose =
a
> > > race.
> >=20
> > I've never seen that happen. lru field re-use is actually used in other
> > places in the kernel. Shouldn't we try to find and fix such races?
> >=20
> > Wasn't the idea to reduce the complexity of nfsd_file_put ?
> >=20
>=20
> I think the nfsd filecache is different from those "other places"
> because of nfsd_file_close_inode() and related code.  If I understand
> correctly, nfsd can remove a file from the filecache while it is still
> in use.  In this case it needs to be unhashed and removed from the lru -
> and then added to a dispose list - while it might still be active for
> some IO request.
>=20
> Prior to Commit 8d0d254b15cc ("nfsd: fix nfsd_file_unhash_and_dispose")
> unhash_and_dispose() wouldn't add to the dispose list unless the
> refcount was one.  I'm not sure how racy this test was, but it would
> mean that it is unlikely for an nfsd_file to be added to the dispose list
> if it was still in use.
>=20

I'm pretty sure that was racy. By the time you go to put it on the
dispose list, the refcount may no longer be one since it can be
incremented at any time.

> After that commit it seems more likely that a nfsd_file will be added to
> a dispose list while it is in use.
> As we add/remove things to a dispose list without a lock, we need to be
> careful that no other thread will add the nfsd_file to an lru at the
> same time.  refcounts will no longer provide that protection.  Maybe we
> should restore the refcount protection, or maybe we need a bit as Jeff
> has added here.
>=20

If we have an entry on a list, then it can't be added to the LRU (since
the list_empty check would fail). The real danger is that we could end
up trying to remove it from the LRU and inadvertantly remove it from a
private dispose list instead. Since that is done without a lock, we
could easily corrupt memory.

--=20
Jeff Layton <jlayton@kernel.org>
