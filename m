Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C088479D278
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 15:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjILNfq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjILNfb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 09:35:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E91410E2
        for <linux-nfs@vger.kernel.org>; Tue, 12 Sep 2023 06:35:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374BDC433C8;
        Tue, 12 Sep 2023 13:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694525727;
        bh=EyS9ebdYEsIExrkMOMj1OOaBcWG6kBlF9H3Bw7eiGqE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IzVJfBak7wHXavT7d/mXymH/ubB/nbUEQZC0hTPmXpuEkouoSwCV5NuSbb9Ut7TPt
         OiBQJFCVD8nTX02swsqdS+pUB8EJTY6EiBezwHeSZxL/opbSyg90nAfEaUzXV2fjhk
         NqBhRsqqVYkkk4yI7dndlBu/z5EspyZk6xM1WvQMem739XNe685ETEypngMfGEYm4a
         rphhvh1YHP77i3qfPjDZLiMW96gZGZDNPsle1DyC0DhFydxt4an+yYf4H0r4Vb03TH
         V1tEQQCIf/PgLqmO93OohpIjTdFqBp4xj0Wf5OE27Sac8HP6ZZB7xjFtPbizZvIe+G
         lDWVlMdR9nuMw==
Message-ID: <59d1e83dc878046348d20666c76bb34c21ba911b.camel@kernel.org>
Subject: Re: [PATCH] NFSD: fix possible oops when nfsd/pool_stats is closed.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS list <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Tue, 12 Sep 2023 09:35:25 -0400
In-Reply-To: <169448190063.19905.9707641304438290692@noble.neil.brown.name>
References: <169448190063.19905.9707641304438290692@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-09-12 at 11:25 +1000, NeilBrown wrote:
> If /proc/fs/nfsd/pool_stats is open when the last nfsd thread exits, then
> when the file is closed a NULL pointer is dereferenced.
> This is because nfsd_pool_stats_release() assumes that the
> pointer to the svc_serv cannot become NULL while a reference is held.
>=20
> This used to be the case but a recent patch split nfsd_last_thread() out
> from nfsd_put(), and clearing the pointer is done in nfsd_last_thread().
>=20
> This is easily reproduced by running
>    rpc.nfsd 8 ; ( rpc.nfsd 0;true) < /proc/fs/nfsd/pool_stats
>=20
> Fortunately nfsd_pool_stats_release() has easy access to the svc_serv
> pointer, and so can call svc_put() on it directly.
>=20
> Fixes: 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfssvc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 1582af33e204..551c16a72012 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1082,11 +1082,12 @@ int nfsd_pool_stats_open(struct inode *inode, str=
uct file *file)
> =20
>  int nfsd_pool_stats_release(struct inode *inode, struct file *file)
>  {
> +	struct svc_serv *serv =3D
> +		((struct seq_file *) file->private_data)->private;
>  	int ret =3D seq_release(inode, file);
> -	struct net *net =3D inode->i_sb->s_fs_info;
> =20
>  	mutex_lock(&nfsd_mutex);
> -	nfsd_put(net);
> +	svc_put(serv);
>  	mutex_unlock(&nfsd_mutex);
>  	return ret;
>  }

Reviewed-by: Jeff Layton <jlayton@kernel.org>
