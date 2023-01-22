Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D2A676A7B
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Jan 2023 01:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjAVA5C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Jan 2023 19:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAVA5C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Jan 2023 19:57:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3371F48D
        for <linux-nfs@vger.kernel.org>; Sat, 21 Jan 2023 16:57:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8CBD1FEF3;
        Sun, 22 Jan 2023 00:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674349018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09awVGZq+d6u6lxVQbo/RBKiXqvrO9go8iBcvazw2aY=;
        b=xq4hlVJR7Yxm0f51nkyD2nxh1GhXm+Oasb4sOudLjn4GKAagTWwBpeZthUdG7yOFlJ/VYh
        JhH6wQrPinhZgkKokyk6wzSfOK3DHKTv2745vmZWRFqS9z4HNHicRmAHPy489gps36rTM1
        4vY2h2cvkxUfly55ldWhLABiv96vVv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674349018;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09awVGZq+d6u6lxVQbo/RBKiXqvrO9go8iBcvazw2aY=;
        b=/SnjPmU8Ch4A9dziqLxzBzUUWCZaWBxjRJKH1EHb8eTyMMMi6ld/a6YraV5ftHzU8q2D9f
        CGYSuxjQKCjxQyDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D59E61357F;
        Sun, 22 Jan 2023 00:56:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uM+LHNeJzGPHXgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 22 Jan 2023 00:56:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Salvatore Bonaccorso" <carnil@debian.org>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "yangerkun" <yangerkun@huawei.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: Question about CVE-2022-43945
In-reply-to: <Y8vyFuQ0UdiiEJRw@eldamar.lan>
References: <48b858aa-028b-1f56-3740-e59eb7a5fca2@huawei.com>,
 <265166ff-cd0b-ea5f-ad28-fed756dfd4ff@huawei.com>,
 <B00F6DD5-8215-457B-A681-39D7A64B7668@oracle.com>,
 <Y8vyFuQ0UdiiEJRw@eldamar.lan>
Date:   Sun, 22 Jan 2023 11:56:50 +1100
Message-id: <167434901069.18331.4062086072451365294@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 22 Jan 2023, Salvatore Bonaccorso wrote:
> Hi Chuck,=20
>=20
> On Sat, Nov 12, 2022 at 04:11:47PM +0000, Chuck Lever III wrote:
> >=20
> >=20
> > > On Nov 12, 2022, at 4:04 AM, yangerkun <yangerkun@huawei.com> wrote:
> > >=20
> > > On 2022/11/12 13:01, yangerkun wrote:
> > >> Hi, Chuck Lever,
> > >> CVE-2022-43945(https://nvd.nist.gov/vuln/detail/CVE-2022-43945) descri=
be that a normal request header ended with garbage data can trigger the nfsd =
overflow since nfsd share the request and response with the same pages array.
> > >> It seems that the patchset(https://lore.kernel.org/linux-nfs/166204973=
526.1435.6068003336048840051.stgit@manet.1015granger.net/T/#t) has solved NFS=
v2/NFSv3, but leave NFSv4 still vulnerably?
> >=20
> > I asked the folks who reported this issue to check NFSv4 as well.
> > They were not able to exploit NFSv4 in the same way. For now we
> > believe this vulnerability does not impact the NFSv4 code paths.
> >=20
> >=20
> > >> Another question, for stable branch like lts-5.10, since NFSv2/NFSv3 d=
id not switch to xdr_stream, the nfs_request_too_big in nfsd_dispatch will re=
ject the request like READ/READDIR with too large request. So it seems branch=
 without that "switch" seems ok for NFSv2/NFSv3, but NFSv3 still vulnerably. =
right?
> > >> Looking forward to your reply!
> > >=20
> > > Sorry, notice that 76ce4dcec0dc ("NFSD: Cap rsize_bop result based on s=
end buffer size") fix same problem for NFSv4.
> >=20
> > 76ce4dcec0dc is a defensive fix. But, as I stated above, we haven't
> > yet found that NFSD's NFSv4 implementation is vulnerable to this
> > issue.
> >=20
> >=20
> > > So, for the stable branch like lts-5.10 which NFSv2/NFSv3 do not switch=
 to xdr_stream, it seems we only need 76ce4dcec0dc"NFSD: Cap rsize_bop result=
 based on send buffer size"). Right?
> >=20
> > At this time we don't believe 76ce4dcec0dc is required. But if
> > you want it applied to v5.10 (or any LTS kernel) please first
> > test that it does not result in a regression, and then make a
> > request to the usual stable maintainers.
>=20
> I was reviewing open CVEs for Debian, based on the 5.10.y stable
> series, and noticed CVE-2022-43945 is yet unfixed in 5.10.162. I see
> SUSE did some backporting, with Neil Brown, according to
> https://bugzilla.suse.com/show_bug.cgi?id=3D1205128#c4 . From the set of
> fixes the first two of=20
>=20
> Commit 90bfc37b5ab9 ("SUNRPC: Fix svcxdr_init_decode's end-of-buffer calcul=
ation")
> Commit 1242a87da0d8 ("SUNRPC: Fix svcxdr_init_encode's buflen calculation")
> Commit 00b4492686e0 ("NFSD: Protect against send buffer overflow in NFSv2 R=
EADDIR")
> Commit 640f87c190e0 ("NFSD: Protect against send buffer overflow in NFSv3 R=
EADDIR")
> Commit 401bc1f90874 ("NFSD: Protect against send buffer overflow in NFSv2 R=
EAD")
> Commit fa6be9cc6e80 ("NFSD: Protect against send buffer overflow in NFSv3 R=
EAD")
> Commit 76ce4dcec0dc ("NFSD: Cap rsize_bop result based on send buffer size")
>=20
> would not be needed, but still the others, though won't apply cleanly
> as thei need substantial changes. Neil, would it be possible to have
> the fixes backported to the 5.10.y series as well?

You can find my 5.3 patches at
  https://github.com/SUSE/kernel-source/commit/e93318a3f8b5618afcda871b6d8201=
466af333a8
and earlier - follow the "parent" link.

Feel free to check they apply to 5.10.y, review them, and forward to
stable@vger.kernel.org.

NeilBrown

>=20
> Regards,
> Salvatore
>=20
