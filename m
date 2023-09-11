Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD879C061
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355443AbjIKV7g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244202AbjIKTf0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 15:35:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AC612A
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 12:35:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CFEC433C7;
        Mon, 11 Sep 2023 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694460920;
        bh=6qIhTIcCM4bRNjwfE3XkQqR71+1ia8V4QkG+Pt6qJrc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cC9RqQw+fgquSDWlWwPmAAPvV4p755spzuLIlDQ36/YEN1JM48lgz5jq3rBkZ6NAj
         bP7gbJjVmC+LACAMjy77aQCoV9a/ZvGfhnZQ2RinshtwnuWNbZHYFVGvDZZuN2k2gl
         kl17iNeXX8o4Ofc8JNtieQySdChifXXlAjAAAoas+9nZw8eyyJt7kQN1pcrLGiX4L2
         PH2bgTOamr3/uJyjT/5elZ1riTIR4ntm08yMe0YSW0Hctc9RSkFZxkQ0+HJje0wsJQ
         xa6i8NMtIpTdDRwCFjNLhG8A7oLF6yFemMRA/krU9pNQrhQPYPXOgFMijofMMubBay
         i6Phljdh3W6Tg==
Message-ID: <2edfeee39a9aeece7436509eb92871868404eb4d.camel@kernel.org>
Subject: Re: [PATCH v8 2/3] NFSD: introduce netlink rpc_status stubs
From:   Jeff Layton <jlayton@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com, neilb@suse.de,
        netdev@vger.kernel.org
Date:   Mon, 11 Sep 2023 15:35:18 -0400
In-Reply-To: <ce3bc230e1b8d0c741a240c17d99f5a2072e7ce1.1694436263.git.lorenzo@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
         <ce3bc230e1b8d0c741a240c17d99f5a2072e7ce1.1694436263.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-09-11 at 14:49 +0200, Lorenzo Bianconi wrote:
> Generate empty netlink stubs and uAPI through nfsd_server.yaml specs:
>=20
> $./tools/net/ynl/ynl-gen-c.py --mode uapi \
>  --spec Documentation/netlink/specs/nfsd_server.yaml \
>  --header -o include/uapi/linux/nfsd_server.h
> $./tools/net/ynl/ynl-gen-c.py --mode kernel \
>  --spec Documentation/netlink/specs/nfsd_server.yaml \
>  --header -o fs/nfsd/nfs_netlink_gen.h
> $./tools/net/ynl/ynl-gen-c.py --mode kernel \
>  --spec Documentation/netlink/specs/nfsd_server.yaml \
>  --source -o fs/nfsd/nfs_netlink_gen.c
>=20
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  fs/nfsd/Makefile                 |  3 +-
>  fs/nfsd/nfs_netlink_gen.c        | 32 +++++++++++++++++++++
>  fs/nfsd/nfs_netlink_gen.h        | 22 ++++++++++++++
>  fs/nfsd/nfsctl.c                 | 16 +++++++++++
>  include/uapi/linux/nfsd_server.h | 49 ++++++++++++++++++++++++++++++++
>  5 files changed, 121 insertions(+), 1 deletion(-)
>  create mode 100644 fs/nfsd/nfs_netlink_gen.c
>  create mode 100644 fs/nfsd/nfs_netlink_gen.h
>  create mode 100644 include/uapi/linux/nfsd_server.h
>=20
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index 6fffc8f03f74..6ae1d5450bf6 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -12,7 +12,8 @@ nfsd-y			+=3D trace.o
> =20
>  nfsd-y 			+=3D nfssvc.o nfsctl.o nfsfh.o vfs.o \
>  			   export.o auth.o lockd.o nfscache.o \
> -			   stats.o filecache.o nfs3proc.o nfs3xdr.o
> +			   stats.o filecache.o nfs3proc.o nfs3xdr.o \
> +			   nfs_netlink_gen.o
>  nfsd-$(CONFIG_NFSD_V2) +=3D nfsproc.o nfsxdr.o
>  nfsd-$(CONFIG_NFSD_V2_ACL) +=3D nfs2acl.o
>  nfsd-$(CONFIG_NFSD_V3_ACL) +=3D nfs3acl.o
> diff --git a/fs/nfsd/nfs_netlink_gen.c b/fs/nfsd/nfs_netlink_gen.c
> new file mode 100644
> index 000000000000..4d71b80bf4a7
> --- /dev/null
> +++ b/fs/nfsd/nfs_netlink_gen.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-=
Clause)
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/nfsd_server.yaml */
> +/* YNL-GEN kernel source */
> +
> +#include <net/netlink.h>
> +#include <net/genetlink.h>
> +
> +#include "nfs_netlink_gen.h"
> +
> +#include <uapi/linux/nfsd_server.h>
> +
> +/* Ops table for nfsd_server */
> +static const struct genl_split_ops nfsd_server_nl_ops[] =3D {
> +	{
> +		.cmd	=3D NFSD_CMD_RPC_STATUS_GET,
> +		.start	=3D nfsd_server_nl_rpc_status_get_start,
> +		.dumpit	=3D nfsd_server_nl_rpc_status_get_dumpit,
> +		.done	=3D nfsd_server_nl_rpc_status_get_done,
> +		.flags	=3D GENL_CMD_CAP_DUMP,
> +	},
> +};
> +
> +struct genl_family nfsd_server_nl_family __ro_after_init =3D {
> +	.name		=3D NFSD_SERVER_FAMILY_NAME,
> +	.version	=3D NFSD_SERVER_FAMILY_VERSION,
> +	.netnsok	=3D true,
> +	.parallel_ops	=3D true,
> +	.module		=3D THIS_MODULE,
> +	.split_ops	=3D nfsd_server_nl_ops,
> +	.n_split_ops	=3D ARRAY_SIZE(nfsd_server_nl_ops),
> +};
> diff --git a/fs/nfsd/nfs_netlink_gen.h b/fs/nfsd/nfs_netlink_gen.h
> new file mode 100644
> index 000000000000..f66b29e528c1
> --- /dev/null
> +++ b/fs/nfsd/nfs_netlink_gen.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-=
Clause) */
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/nfsd_server.yaml */
> +/* YNL-GEN kernel header */
> +
> +#ifndef _LINUX_NFSD_SERVER_GEN_H
> +#define _LINUX_NFSD_SERVER_GEN_H
> +
> +#include <net/netlink.h>
> +#include <net/genetlink.h>
> +
> +#include <uapi/linux/nfsd_server.h>
> +
> +int nfsd_server_nl_rpc_status_get_start(struct netlink_callback *cb);
> +int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb);
> +
> +int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> +					 struct netlink_callback *cb);
> +
> +extern struct genl_family nfsd_server_nl_family;
> +
> +#endif /* _LINUX_NFSD_SERVER_GEN_H */
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 33f80d289d63..1be66088849c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1495,6 +1495,22 @@ static int create_proc_exports_entry(void)
> =20
>  unsigned int nfsd_net_id;
> =20
> +int nfsd_server_nl_rpc_status_get_start(struct netlink_callback *cb)
> +{
> +	return 0;
> +}
> +
> +int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb)
> +{
> +	return 0;
> +}
> +
> +int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> +					 struct netlink_callback *cb)
> +{
> +	return 0;
> +}
> +
>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace
> diff --git a/include/uapi/linux/nfsd_server.h b/include/uapi/linux/nfsd_s=
erver.h
> new file mode 100644
> index 000000000000..c9ee00ceca3b
> --- /dev/null
> +++ b/include/uapi/linux/nfsd_server.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-=
Clause) */
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/nfsd_server.yaml */
> +/* YNL-GEN uapi header */
> +
> +#ifndef _UAPI_LINUX_NFSD_SERVER_H
> +#define _UAPI_LINUX_NFSD_SERVER_H
> +
> +#define NFSD_SERVER_FAMILY_NAME		"nfsd_server"
> +#define NFSD_SERVER_FAMILY_VERSION	1
> +
> +enum nfsd_rpc_status_comp_attr {
> +	NFSD_ATTR_RPC_STATUS_COMP_UNSPEC,
> +	NFSD_ATTR_RPC_STATUS_COMP_OP,
> +
> +	__NFSD_ATTR_RPC_STATUS_COMP_MAX,
> +	NFSD_ATTR_RPC_STATUS_COMP_MAX =3D (__NFSD_ATTR_RPC_STATUS_COMP_MAX - 1)
> +};
> +
> +enum nfsd_rpc_status_attr {
> +	NFSD_ATTR_RPC_STATUS_UNSPEC,
> +	NFSD_ATTR_RPC_STATUS_XID,
> +	NFSD_ATTR_RPC_STATUS_FLAGS,
> +	NFSD_ATTR_RPC_STATUS_PROG,
> +	NFSD_ATTR_RPC_STATUS_VERSION,
> +	NFSD_ATTR_RPC_STATUS_PROC,
> +	NFSD_ATTR_RPC_STATUS_SERVICE_TIME,
> +	NFSD_ATTR_RPC_STATUS_PAD,
> +	NFSD_ATTR_RPC_STATUS_SADDR4,
> +	NFSD_ATTR_RPC_STATUS_DADDR4,
> +	NFSD_ATTR_RPC_STATUS_SADDR6,
> +	NFSD_ATTR_RPC_STATUS_DADDR6,
> +	NFSD_ATTR_RPC_STATUS_SPORT,
> +	NFSD_ATTR_RPC_STATUS_DPORT,
> +	NFSD_ATTR_RPC_STATUS_COMPOND_OP,
> +
> +	__NFSD_ATTR_RPC_STATUS_MAX,
> +	NFSD_ATTR_RPC_STATUS_MAX =3D (__NFSD_ATTR_RPC_STATUS_MAX - 1)
> +};
> +
> +enum nfsd_commands {
> +	NFSD_CMD_UNSPEC,
> +	NFSD_CMD_RPC_STATUS_GET,
> +
> +	__NFSD_CMD_MAX,
> +	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> +};
> +
> +#endif /* _UAPI_LINUX_NFSD_SERVER_H */


Acked-by: Jeff Layton <jlayton@kernel.org>
