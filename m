Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 087D519EEC6
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2020 02:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgDFADu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Apr 2020 20:03:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgDFADt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 5 Apr 2020 20:03:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E79EAAC75;
        Mon,  6 Apr 2020 00:03:47 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Yihao Wu <wuyihao@linux.alibaba.com>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Date:   Mon, 06 Apr 2020 10:03:41 +1000
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3] SUNRPC/cache: Fix unsafe traverse caused double-free in cache_purge
In-Reply-To: <e0dd0339-a15e-814d-ac5a-5f51bc15d73c@linux.alibaba.com>
References: <4568a7cf87f110b8e59fda6f53fda34c550ab403.1586108200.git.wuyihao@linux.alibaba.com> <e0dd0339-a15e-814d-ac5a-5f51bc15d73c@linux.alibaba.com>
Message-ID: <87sghhwkde.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06 2020, Yihao Wu wrote:

> Deleting list entry within hlist_for_each_entry_safe is not safe unless
> next pointer (tmp) is protected too. It's not, because once hash_lock
> is released, cache_clean may delete the entry that tmp points to. Then
> cache_purge can walk to a deleted entry and tries to double free it.
>
> Fix this bug by holding only the deleted entry's reference.
>
> Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
> ---
> v1->v2: Use Neil's better solution
> v2->v3: Fix a checkscript warning
>
>  net/sunrpc/cache.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index af0ddd28b081..b445874e8e2f 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -541,7 +541,9 @@ void cache_purge(struct cache_detail *detail)
>  	dprintk("RPC: %d entries in %s cache\n", detail->entries, detail->name);
>  	for (i =3D 0; i < detail->hash_size; i++) {
>  		head =3D &detail->hash_table[i];
> -		hlist_for_each_entry_safe(ch, tmp, head, cache_list) {
> +		while (!hlist_empty(head)) {
> +			ch =3D hlist_entry(head->first, struct cache_head,
> +					 cache_list);
>  			sunrpc_begin_cache_remove_entry(ch, detail);
>  			spin_unlock(&detail->hash_lock);
>  			sunrpc_end_cache_remove_entry(ch, detail);
> --=20
> 2.20.1.2432.ga663e714

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks for finding the bug and testing the solution!
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6Kcd0ACgkQOeye3VZi
gbnFixAAgNieKy6tuW0ODMW2Rk7mJKO31gs1OQJ5sBrvgSOc4eJuRH64e2zYI7SE
idBUCcwdTCo6ldH1v9OG8trl2QXuiZA7/CW7bWa0Acr5zm048RWuegiqGmNnaC9g
GBKM0ucJa/Cb+GPmFEATUWT6lssnd44J5dYjC/HOlEKHkhI92pg8ZeBMo40xM67b
ogxTXIupSZDv6fe6p5OBrEL15HArXkz4aIGAH5Xm2OFSFkVn8RVZB3NEx2Fw1NPj
mj7gM41db8ehDzYjZp88mfwAdsNu6KEqGHYyNBnYyvDznLRIi64hSG+Tz+UsCU0l
mFJe1338DofkIwnlAsaOQTi4dvyKb7xat1htTv2zNIRJbZhSDe7Ef4gdYdkda4wI
NFFCB7c3ROd6kArKXeLupCwPkuX1hS4nR5Qn5hlLcyWey9Rt0XqDEMHDVUrWbk2g
55yUcE5woQLtLb8ESNJquuEFXb76qnaZlrHeTHm7eKD/OdKZqDoeC0kzA9lV57WR
5yuC1KtoUT7oSyFlSthRg1eydWg0l5NJWQLx9etCFPWzFQjX0JBmaz9M76AMbH0Q
VuIn1d1mOD/0qi+KZyh947mkoJXsF9huZJ/NQgu4L5d6at9mWwLhF/dQE8oSQeqH
4t6dzUiO1pFmZoYLOOQrl5J5TXVi64M4QY+F9QKV0RxunaeN4ak=
=I+T7
-----END PGP SIGNATURE-----
--=-=-=--
