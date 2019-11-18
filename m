Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D36E100BA1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2019 19:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfKRSmW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Nov 2019 13:42:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbfKRSmW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Nov 2019 13:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574102541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFS56ZvTR3v0xCQW5IYE1BVPvyWyv+c3G3DlT6mXd7E=;
        b=gPiyfZ4BDvtFJxIJM1JW8h2Z6T3YkkUHApR3lxi7tNMauAyH1xH8Ph9ayYXB1VT9aY3WU0
        3jozJ8ibL+4YXqs3J2pByJzSooh0ERxSOzkI4uZmc21vZr0V4qAT0p4o9//nZSY/IF/Rzz
        x+52hzua61gXQoNXRDk7w8Z0FFRba5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-Zpc5qKINMpi8wJicHXSWgg-1; Mon, 18 Nov 2019 13:42:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A50261005500;
        Mon, 18 Nov 2019 18:42:16 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-206.phx2.redhat.com [10.3.116.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D734319C4F;
        Mon, 18 Nov 2019 18:42:15 +0000 (UTC)
Subject: Re: [RFC PATCH] NFS: allow deprecation of NFS UDP protocol
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
References: <20191108213201.66194-1-olga.kornievskaia@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <90930069-baaa-03b7-56a5-e9012a85cae6@RedHat.com>
Date:   Mon, 18 Nov 2019 13:42:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191108213201.66194-1-olga.kornievskaia@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Zpc5qKINMpi8wJicHXSWgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/8/19 4:32 PM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
>=20
> Add a kernel config CONFIG_NFS_DISABLE_UDP_SUPPORT to disallow NFS
> UDP mounts.
>=20
> I took the same approach as Chuck's deprecation of DES enc types
> to start with default to still allow but I think the ultimate
> goal is to disable
>=20
> Question: how do we have folks trying this unless we set it to false?
Exactly... Why not do the opposite? Off by default... instead of
having to set the variable to turn UDP off?

steved.
=20
>=20
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/Kconfig  | 10 ++++++++++
>  fs/nfs/client.c |  4 ++++
>  fs/nfs/super.c  |  8 ++++++++
>  3 files changed, 22 insertions(+)
>=20
> diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> index 295a7a2..6320113 100644
> --- a/fs/nfs/Kconfig
> +++ b/fs/nfs/Kconfig
> @@ -196,3 +196,13 @@ config NFS_DEBUG
>  =09depends on NFS_FS && SUNRPC_DEBUG
>  =09select CRC32
>  =09default y
> +
> +config NFS_DISABLE_UDP_SUPPORT
> +=09bool "NFS: Disable NFS UDP protocol support"
> +=09depends on NFS_FS
> +=09default n
> +=09help
> +=09  Choose Y here to disable the use of NFS over UDP. NFS over UDP
> +=09  on modern networks (1Gb+) can lead to data corruption caused by
> +=09  fragmentation during high loads.
> +=09  The default is N because many deployments still use UDP.
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 02110a3..24ca314 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -474,6 +474,7 @@ void nfs_init_timeout_values(struct rpc_timeout *to, =
int proto,
>  =09=09=09to->to_maxval =3D to->to_initval;
>  =09=09to->to_exponential =3D 0;
>  =09=09break;
> +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
>  =09case XPRT_TRANSPORT_UDP:
>  =09=09if (retrans =3D=3D NFS_UNSPEC_RETRANS)
>  =09=09=09to->to_retries =3D NFS_DEF_UDP_RETRANS;
> @@ -484,6 +485,7 @@ void nfs_init_timeout_values(struct rpc_timeout *to, =
int proto,
>  =09=09to->to_maxval =3D NFS_MAX_UDP_TIMEOUT;
>  =09=09to->to_exponential =3D 1;
>  =09=09break;
> +#endif
>  =09default:
>  =09=09BUG();
>  =09}
> @@ -580,8 +582,10 @@ static int nfs_start_lockd(struct nfs_server *server=
)
>  =09=09default:
>  =09=09=09nlm_init.protocol =3D IPPROTO_TCP;
>  =09=09=09break;
> +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
>  =09=09case XPRT_TRANSPORT_UDP:
>  =09=09=09nlm_init.protocol =3D IPPROTO_UDP;
> +#endif
>  =09}
> =20
>  =09host =3D nlmclnt_init(&nlm_init);
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index a84df7d6..21e59da 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1011,7 +1011,9 @@ static void nfs_set_port(struct sockaddr *sap, int =
*port,
>  static void nfs_validate_transport_protocol(struct nfs_parsed_mount_data=
 *mnt)
>  {
>  =09switch (mnt->nfs_server.protocol) {
> +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
>  =09case XPRT_TRANSPORT_UDP:
> +#endif
>  =09case XPRT_TRANSPORT_TCP:
>  =09case XPRT_TRANSPORT_RDMA:
>  =09=09break;
> @@ -1033,8 +1035,10 @@ static void nfs_set_mount_transport_protocol(struc=
t nfs_parsed_mount_data *mnt)
>  =09=09=09return;
>  =09switch (mnt->nfs_server.protocol) {
>  =09case XPRT_TRANSPORT_UDP:
> +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
>  =09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
>  =09=09break;
> +#endif
>  =09case XPRT_TRANSPORT_TCP:
>  =09case XPRT_TRANSPORT_RDMA:
>  =09=09mnt->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
> @@ -2204,6 +2208,10 @@ static int nfs_validate_text_mount_data(void *opti=
ons,
>  #endif /* CONFIG_NFS_V4 */
>  =09} else {
>  =09=09nfs_set_mount_transport_protocol(args);
> +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
> +=09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
> +=09=09=09goto out_invalid_transport_udp;
> +#endif
>  =09=09if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_RDMA)
>  =09=09=09port =3D NFS_RDMA_PORT;
>  =09}
>=20

