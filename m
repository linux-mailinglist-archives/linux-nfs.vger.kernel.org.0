Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF5E604797
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 15:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiJSNmQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 09:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiJSNlk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 09:41:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F1016C230
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 06:29:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B579B822E4
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 10:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A38C433C1;
        Wed, 19 Oct 2022 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666176521;
        bh=FsQtlUHeJQalKwHLzeQF0x+oKTVAlPfHDpCSe3ejaos=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZO8TofeRZPv80ZcL2eDv//A07vquKVoTwSyZV0yzGM5hkjMKIvwUyQovZycgHBaOp
         tIVXjIbWT6Ku8oFclT3ZoMGqGfrIkLMv5Bv9X32vkNDDwCDalG83OGu35AchGgU8la
         C7ePxskI4BlCrlt7CJnlhFsVvCpRkWTQPP1YwN9gMPjfd7vulg8qFsMG4MctYilL1L
         bf5vY43aXKTYOg2XHGKr+oVCGAKAA6x3dVKEOedGnMeTQTSjkV1inNh7yej5AFhy1b
         WsO3GESeGi4Y7sg2kdZbfYmuP+UnKVx8N4hGKkZn8nB+holwRmXN+qI8Pt05SSrhLV
         QsOxOm8YFICYQ==
Message-ID: <25454461d696b25482a1b48aed10abda1d1c2060.camel@kernel.org>
Subject: Re: [PATCH v4 2/7] NFSD: Revert "NFSD: NFSv4 CLOSE should release
 an nfsd_file immediately"
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Wed, 19 Oct 2022 06:48:39 -0400
In-Reply-To: <166612311196.1291.3976661000746956975.stgit@manet.1015granger.net>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
         <166612311196.1291.3976661000746956975.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-10-18 at 15:58 -0400, Chuck Lever wrote:
> This reverts commit 5e138c4a750dc140d881dab4a8804b094bbc08d2.
>=20
> That commit attempted to make files available to other users as soon
> as all NFSv4 clients were done with them, rather than waiting until
> the filecache LRU had garbage collected them.
>=20
> It gets the reference counting wrong, for one thing.
>=20
> But it also misses that DELEGRETURN should release a file in the
> same fashion. In fact, any nfsd_file_put() on an file held open
> by an NFSv4 client needs potentially to release the file
> immediately...
>=20
> Clear the way for implementing that idea.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c |   18 ------------------
>  fs/nfsd/filecache.h |    1 -
>  fs/nfsd/nfs4state.c |    4 ++--
>  3 files changed, 2 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index a2adfc247648..b7aa523c2010 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -444,24 +444,6 @@ nfsd_file_put(struct nfsd_file *nf)
>  		nfsd_file_put_noref(nf);
>  }
> =20
> -/**
> - * nfsd_file_close - Close an nfsd_file
> - * @nf: nfsd_file to close
> - *
> - * If this is the final reference for @nf, free it immediately.
> - * This reflects an on-the-wire CLOSE or DELEGRETURN into the
> - * VFS and exported filesystem.
> - */
> -void nfsd_file_close(struct nfsd_file *nf)
> -{
> -	nfsd_file_put(nf);
> -	if (refcount_dec_if_one(&nf->nf_ref)) {
> -		nfsd_file_unhash(nf);
> -		nfsd_file_lru_remove(nf);
> -		nfsd_file_free(nf);
> -	}
> -}
> -
>  struct nfsd_file *
>  nfsd_file_get(struct nfsd_file *nf)
>  {
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index 8e8c0c47d67d..f81c198f4ed6 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -52,7 +52,6 @@ void nfsd_file_cache_shutdown(void);
>  int nfsd_file_cache_start_net(struct net *net);
>  void nfsd_file_cache_shutdown_net(struct net *net);
>  void nfsd_file_put(struct nfsd_file *nf);
> -void nfsd_file_close(struct nfsd_file *nf);
>  struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
>  void nfsd_file_close_inode_sync(struct inode *inode);
>  bool nfsd_file_is_cached(struct inode *inode);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c5d199d7e6b4..2b850de288cf 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -820,9 +820,9 @@ static void __nfs4_file_put_access(struct nfs4_file *=
fp, int oflag)
>  			swap(f2, fp->fi_fds[O_RDWR]);
>  		spin_unlock(&fp->fi_lock);
>  		if (f1)
> -			nfsd_file_close(f1);
> +			nfsd_file_put(f1);
>  		if (f2)
> -			nfsd_file_close(f2);
> +			nfsd_file_put(f2);
>  	}
>  }
> =20
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
