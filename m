Return-Path: <linux-nfs+bounces-17361-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DBECEAF42
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 01:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A317F3012253
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 00:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68281F16B;
	Wed, 31 Dec 2025 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="H7M2JLVQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yP9gph4v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEB34A23
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767139857; cv=none; b=UIBU75ZYUT+GX/kc/HKj4j8pf15dDS3kl63idx8G7VUmeBEfF4g85Fb8+kPS72+3JrwwgYj9ALOuGDRcxCULvFhJELAyBfkFr2rmnrfynrCtfszKJ3369pvBeWIXoXAcXRdhh+BVurjTtFZR578HRvF//AQnD5gtU4v2bZv3xak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767139857; c=relaxed/simple;
	bh=xhv+oRtD18vt+d8xwbX91BIu6Pt9mXdVDbATBbXEzOE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=RQwvX/9Wsn6fYh5Nb/61oGTaeLma+XtWR/dD9Dd5WuWcMXYxzZyOv8Bb8Y61F/+FpTbY58r+LgcP42LsHO2MylfUhmkWDNbIxxj07ZDQGGevWcIUAsRMrwzFTdj6MxmewmgMfo4++uMQFA4Vm2a00QfVtKmA7Nt1CTXwNzdwqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=H7M2JLVQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yP9gph4v; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 692A9EC014C;
	Tue, 30 Dec 2025 19:10:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 30 Dec 2025 19:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1767139854; x=1767226254; bh=1y+v1JtivKQcEU8laV7KDE+NLuuMlfzbwjB
	yxB6lL+U=; b=H7M2JLVQp4EtZrV2I3F+9WexdpgxK7SWofJUJXdE2aqKqeCvjd5
	tyb/Nxwk8BwThuN9w3DSicAJWFZwic3xCwXXfp8N02kqDG2h9XlCTBrWwEc/W/aU
	IYydmEIJgJ4Mw+EgWwb7Sj3s/Qn3aP1WGWDQlL8pWFVnZdzwpDill6gGgVTWQkM7
	qtmHh/f0LxFtXtySQT5tYuGctStGxIVNNZ5FpUoyoYZZbrnkMrOU3G9D2PuzvEbG
	966LFcVe5XyAeNveB1SilNl4HTf350ThBXyIRwdGP7G650ztbCroog12q+GHRniP
	lu0Ve8H4m7ctDz93+EL5CE8bzoMYZ4AWqEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767139854; x=
	1767226254; bh=1y+v1JtivKQcEU8laV7KDE+NLuuMlfzbwjByxB6lL+U=; b=y
	P9gph4v+uzFQgvbDF9wxWC3KX7yo8dS2Du8nCOKoVL4UvA3LgfTMlgD6ss7tSKle
	aH6hXHfkLVKihQZ+0zlc/tiLaBrIbKAjbXz/LK8mEunxyXb9YEVtfZqoc7N4Pd3Q
	LSH2Rdkmx++osHNS+8DLytuDAAi+KJaw3SevhpKKhK7fvDDhydF5NHIpBk6qA7+V
	2ikPDRjmfFz+HGYEGyYx3Rj1frsTIdhP1QCWlCQthp0wDj35fB6YEPo4ZTtA6HM5
	d8n4QOAFUgsjGsB8Vlii+w4ev1BONG6S/EQQ4XXw8XMCx1AdrUNJ9Flkjj2MkLmc
	i/c+cjhA4Q8lNhHz6TULQ==
X-ME-Sender: <xms:DmpUaaz5UQgT4TU_eK_PrmQrEAA35lzM0Lw2F4xL8RBxyXJlsPO4hQ>
    <xme:DmpUaYjalYJwBwfrjb3kqwvJTm7xtMnkhN9fl5l3w0Kp4sWIL8iB5xuje5vK9TYS9
    tAcsVgVnJSnn5IDQglM8O26aum44MAPRlpuAzYzyv341QADFg>
X-ME-Received: <xmr:DmpUaekXyIxFLJTeWb-KOdC9gohkYphSKZmnyWWr83HUdnb3VaH5Fvc16Y7iBTPkgfiiWobv8KXl4QHCr5mp5jBnGgHgrQFsLXyLEO1KOFOG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DmpUaWjyKF4lbM-fvwjA_6capev8BV5pf8hrs-Pl2-z62LpGNM9-tw>
    <xmx:DmpUaa16zdA-xJKIH82spBWfuqyPydjnfDeBv-Qpe-URnT6P75nwoQ>
    <xmx:DmpUaXIJfvNSmsfjfD6TUxqOumRr4hb5UvrB2VZkmd6sFdtf9RmyMQ>
    <xmx:DmpUaSzNGO7_YHsSBF_gBXte3kHo0ZB3k_HjdSk-Ll5Wfrn6ICeUEg>
    <xmx:DmpUaUO6gi_FVeRhRlfgy83RhtooM1J2nZKztZVsSUKbdB8ITOq0Ylis>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 19:10:51 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject:
 Re: [PATCH v1 4/5] nfsd: revoke NFSv4 state when filesystem is unmounted
In-reply-to: <20251230141838.2547848-5-cel@kernel.org>
References: <20251230141838.2547848-1-cel@kernel.org>,
 <20251230141838.2547848-5-cel@kernel.org>
Date: Wed, 31 Dec 2025 11:10:48 +1100
Message-id: <176713984838.16766.9670701895901051660@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 31 Dec 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> When an NFS server's local filesystem is unmounted while NFS
> clients are still accessing it, NFSv4 state holds files open
> which pins the filesystem, preventing unmount.
>=20
> Currently, administrators have to manually revoke that state via
> /proc/fs/nfsd/unlock_fs before a formerly exported filesystem
> can be unmounted.
>=20
> Use the kernel's fs_pin mechanism to detect filesystem unmounts
> and revoke NFSv4 state and NLM locks associated with that
> filesystem. An xarray in nfsd_net tracks per-superblock pins. When
> any NFS state is created, a pin is registered (idempotently) for
> that superblock. When the filesystem is unmounted, VFS invokes the
> kill callback which queues work to:
>  - Cancel ongoing async COPY operations (nfsd4_cancel_copy_by_sb)
>  - Release NLM locks (nlmsvc_unlock_all_by_sb)
>  - Revoke NFSv4 state (nfsd4_revoke_states)
>=20
> The code uses pin_insert_group() to register superblock-only pins
> rather than pin_insert() which registers both mount and superblock
> pins. This is necessary because the VFS unmount sequence calls
> mnt_pin_kill() before clearing SB_ACTIVE, but group_pin_kill()
> after. Superblock-only pins with an SB_ACTIVE check after
> insertion reliably detect whether VFS invokes the kill callback.
>=20
> The revocation work runs on a dedicated workqueue (nfsd_pin_wq) to
> avoid deadlocks since the VFS kill callback runs with locks held.
> Synchronization between VFS unmount and NFSD shutdown uses
> xa_erase() atomicity: the path that successfully erases the xarray
> entry triggers work.
>=20
> If state revocation takes an unexpectedly long time (e.g., when
> re-exporting an NFS mount whose backend server is unresponsive),
> periodic warnings are emitted every 30 seconds. The wait is
> interruptible: if interrupted while work is already running, the
> kill callback returns and revocation continues in the background.
> Open files keep the superblock alive until revocation closes them.
> Note that NFSD remains pinned until revocation completes.
>=20
> The pin infrastructure is placed in a new file (pin.c) to keep it
> separate from NFSv4-specific state management code.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/Makefile    |   2 +-
>  fs/nfsd/netns.h     |   4 +
>  fs/nfsd/nfs4state.c |  24 ++++
>  fs/nfsd/nfsctl.c    |  10 +-
>  fs/nfsd/pin.c       | 270 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/state.h     |   7 ++
>  6 files changed, 314 insertions(+), 3 deletions(-)
>  create mode 100644 fs/nfsd/pin.c
>=20
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index f0da4d69dc74..b9ef1fe13164 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -13,7 +13,7 @@ nfsd-y			+=3D trace.o
>  nfsd-y 			+=3D nfssvc.o nfsctl.o nfsfh.o vfs.o \
>  			   export.o auth.o lockd.o nfscache.o \
>  			   stats.o filecache.o nfs3proc.o nfs3xdr.o \
> -			   netlink.o
> +			   netlink.o pin.o
>  nfsd-$(CONFIG_NFSD_V2) +=3D nfsproc.o nfsxdr.o
>  nfsd-$(CONFIG_NFSD_V2_ACL) +=3D nfs2acl.o
>  nfsd-$(CONFIG_NFSD_V3_ACL) +=3D nfs3acl.o
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index d83c68872c4c..4385a0619035 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -13,6 +13,7 @@
>  #include <linux/filelock.h>
>  #include <linux/nfs4.h>
>  #include <linux/percpu_counter.h>
> +#include <linux/xarray.h>
>  #include <linux/percpu-refcount.h>
>  #include <linux/siphash.h>
>  #include <linux/sunrpc/stats.h>
> @@ -213,6 +214,9 @@ struct nfsd_net {
>  	/* last time an admin-revoke happened for NFSv4.0 */
>  	time64_t		nfs40_last_revoke;
> =20
> +	/* fs_pin tracking for automatic state revocation on unmount */
> +	struct xarray		nfsd_sb_pins;
> +
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  	/* Local clients to be invalidated when net is shut down */
>  	spinlock_t              local_clients_lock;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 61f99bcce7f6..61b5df27362e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6445,6 +6445,15 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct s=
vc_fh *current_fh, struct nf
>  		status =3D nfserr_bad_stateid;
>  		if (nfsd4_is_deleg_cur(open))
>  			goto out;
> +		/*
> +		 * This is a new nfs4_file. Pin the superblock so that
> +		 * unmount can trigger revocation of NFSv4 state (opens,
> +		 * locks, delegations) held by clients on this filesystem.
> +		 */
> +		status =3D nfsd_pin_sb(SVC_NET(rqstp),
> +				     current_fh->fh_export->ex_path.mnt);
> +		if (status)
> +			goto out;
>  	}
> =20
>  	if (!stp) {
> @@ -8981,6 +8990,8 @@ static int nfs4_state_create_net(struct net *net)
>  	spin_lock_init(&nn->blocked_locks_lock);
>  	INIT_LIST_HEAD(&nn->blocked_locks_lru);
> =20
> +	nfsd_sb_pins_init(nn);
> +
>  	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
>  	/* Make sure this cannot run until client tracking is initialised */
>  	disable_delayed_work(&nn->laundromat_work);
> @@ -9098,6 +9109,8 @@ nfs4_state_shutdown_net(struct net *net)
>  	struct list_head *pos, *next, reaplist;
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
> +	nfsd_sb_pins_shutdown(nn);
> +
>  	shrinker_free(nn->nfsd_client_shrinker);
>  	cancel_work_sync(&nn->nfsd_shrinker_work);
>  	disable_delayed_work_sync(&nn->laundromat_work);
> @@ -9452,6 +9465,17 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *csta=
te,
>  	if (rfp !=3D fp) {
>  		put_nfs4_file(fp);
>  		fp =3D rfp;
> +	} else {
> +		/*
> +		 * This is a new nfs4_file. Pin the superblock so that
> +		 * unmount can trigger revocation of directory delegations
> +		 * held by clients on this filesystem.
> +		 */
> +		if (nfsd_pin_sb(clp->net,
> +				cstate->current_fh.fh_export->ex_path.mnt)) {
> +			put_nfs4_file(fp);
> +			return ERR_PTR(-EAGAIN);
> +		}
>  	}
> =20
>  	/* if this client already has one, return that it's unavailable */
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 6bf1acaddb04..2d3fcd941886 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2275,9 +2275,12 @@ static int __init init_nfsd(void)
>  	retval =3D nfsd4_create_laundry_wq();
>  	if (retval)
>  		goto out_free_cld;
> +	retval =3D nfsd_pin_init();
> +	if (retval)
> +		goto out_free_laundry;
>  	retval =3D register_filesystem(&nfsd_fs_type);
>  	if (retval)
> -		goto out_free_nfsd4;
> +		goto out_free_pin;
>  	retval =3D genl_register_family(&nfsd_nl_family);
>  	if (retval)
>  		goto out_free_filesystem;
> @@ -2291,7 +2294,9 @@ static int __init init_nfsd(void)
>  	genl_unregister_family(&nfsd_nl_family);
>  out_free_filesystem:
>  	unregister_filesystem(&nfsd_fs_type);
> -out_free_nfsd4:
> +out_free_pin:
> +	nfsd_pin_exit();
> +out_free_laundry:
>  	nfsd4_destroy_laundry_wq();
>  out_free_cld:
>  	unregister_cld_notifier();
> @@ -2314,6 +2319,7 @@ static void __exit exit_nfsd(void)
>  	remove_proc_entry("fs/nfs", NULL);
>  	genl_unregister_family(&nfsd_nl_family);
>  	unregister_filesystem(&nfsd_fs_type);
> +	nfsd_pin_exit();
>  	nfsd4_destroy_laundry_wq();
>  	unregister_cld_notifier();
>  	unregister_pernet_subsys(&nfsd_net_ops);
> diff --git a/fs/nfsd/pin.c b/fs/nfsd/pin.c
> new file mode 100644
> index 000000000000..f8d0d7cda404
> --- /dev/null
> +++ b/fs/nfsd/pin.c
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Filesystem pin management for NFSD.
> + *
> + * When a local filesystem is unmounted while NFS clients hold state,
> + * this code automatically revokes that state so the unmount can proceed.
> + *
> + * Copyright (C) 2025 Oracle. All rights reserved.
> + *
> + * Author: Chuck Lever <chuck.lever@oracle.com>
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/fs_pin.h>
> +#include <linux/slab.h>
> +#include <linux/sunrpc/svc.h>
> +#include <linux/lockd/lockd.h>
> +
> +#include "nfsd.h"
> +#include "netns.h"
> +#include "state.h"
> +
> +#define NFSDDBG_FACILITY	NFSDDBG_PROC
> +
> +static struct workqueue_struct *nfsd_pin_wq;
> +
> +/*
> + * Structure to track fs_pin per superblock for automatic state revocation
> + * when a filesystem is unmounted.
> + */
> +struct nfsd_fs_pin {
> +	struct fs_pin		pin;
> +	struct super_block	*sb;
> +	struct net		*net;
> +	struct work_struct	work;
> +	struct completion	done;
> +	struct rcu_head		rcu;
> +};
> +
> +static void nfsd_fs_pin_kill(struct fs_pin *pin);
> +
> +static void nfsd_fs_pin_free_rcu(struct rcu_head *rcu)
> +{
> +	struct nfsd_fs_pin *p =3D container_of(rcu, struct nfsd_fs_pin, rcu);
> +
> +	put_net(p->net);
> +	kfree(p);
> +}
> +
> +/*
> + * Work function for nfsd_fs_pin - runs in process context.
> + * Cancels async COPYs, releases NLM locks, and revokes NFSv4 state for
> + * the superblock.
> + */
> +static void nfsd_fs_pin_work(struct work_struct *work)
> +{
> +	struct nfsd_fs_pin *p =3D container_of(work, struct nfsd_fs_pin, work);
> +	struct nfsd_net *nn =3D net_generic(p->net, nfsd_net_id);
> +
> +	pr_info("nfsd: unmount of %s, revoking NFS state\n", p->sb->s_id);
> +
> +	nfsd4_cancel_copy_by_sb(p->net, p->sb);
> +	/* Errors are logged by lockd; no recovery is possible. */
> +	(void)nlmsvc_unlock_all_by_sb(p->sb);
> +	nfsd4_revoke_states(nn, p->sb);
> +
> +	pr_info("nfsd: state revocation for %s complete\n", p->sb->s_id);
> +
> +	pin_remove(&p->pin);
> +	complete(&p->done);
> +	call_rcu(&p->rcu, nfsd_fs_pin_free_rcu);
> +}
> +
> +/* Interval for progress warnings during unmount (in seconds) */
> +#define NFSD_STATE_REVOKE_INTERVAL	30
> +
> +/**
> + * nfsd_fs_pin_kill - Kill callback for nfsd_fs_pin
> + * @pin: fs_pin representing filesystem to be unmounted
> + *
> + * Queues state revocation and waits for completion. If interrupted,
> + * returns early; the work function handles cleanup. Open files keep
> + * the superblock alive until revocation closes them.
> + *
> + * Synchronization with nfsd_sb_pins_destroy(): xa_erase() is atomic,
> + * so exactly one of the two paths erases the entry and triggers work.
> + */
> +static void nfsd_fs_pin_kill(struct fs_pin *pin)
> +{
> +	struct nfsd_fs_pin *p =3D container_of(pin, struct nfsd_fs_pin, pin);
> +	struct nfsd_net *nn =3D net_generic(p->net, nfsd_net_id);
> +	unsigned int elapsed =3D 0;
> +	long ret;
> +
> +	if (!xa_erase(&nn->nfsd_sb_pins, (unsigned long)p->sb))
> +		return;
> +
> +	queue_work(nfsd_pin_wq, &p->work);
> +
> +	/*
> +	 * Block until state revocation completes. Periodic warnings help
> +	 * diagnose stuck operations (e.g., re-exports of an NFS mount
> +	 * whose backend server is unresponsive).
> +	 *
> +	 * The work function handles pin_remove() and freeing, so this
> +	 * callback can return early on interrupt. Open files keep the
> +	 * superblock alive until revocation closes them. Note that NFSD
> +	 * remains pinned until revocation completes.
> +	 */
> +	for (;;) {
> +		ret =3D wait_for_completion_interruptible_timeout(&p->done,
> +						NFSD_STATE_REVOKE_INTERVAL * HZ);
> +		if (ret > 0)
> +			return;
> +
> +		if (ret =3D=3D -ERESTARTSYS) {
> +			/*
> +			 * Interrupted by signal. If the work has not yet
> +			 * started, cancel it and run synchronously here.
> +			 * If already running, return and let work complete
> +			 * in background; open files keep superblock alive.
> +			 */
> +			if (cancel_work(&p->work)) {
> +				pr_warn("nfsd: unmount of %s interrupted, "
> +					"revoking state synchronously\n",
> +					p->sb->s_id);

I believe current policy to never break string literal to satisfy line
length restrictions.

But more importantly the message seem misleading.  The state revocation
is normally synchronous, so reporting that it is now synchronous seems
odd.
It runs in a separate thread, but as the main thread waits, it
synchronous.

And it isn't clear to me *why* you choose to run the work in the main
thread after an interrupt...


> +				nfsd_fs_pin_work(&p->work);
> +				return;
> +			}
> +			pr_warn("nfsd: unmount of %s interrupted; mount remains "
> +				"pinned until state revocation completes\n",
> +				p->sb->s_id);
> +			return;
> +		}
> +
> +		/* Timed out - print warning and continue waiting */
> +		elapsed +=3D NFSD_STATE_REVOKE_INTERVAL;
> +		pr_warn("nfsd: unmount of %s blocked for %u seconds "
> +			"waiting for NFS state revocation\n",
> +			p->sb->s_id, elapsed);
> +	}
> +}
> +
> +/**
> + * nfsd_pin_sb - register a superblock to enable state revocation
> + * @net: network namespace
> + * @mnt: vfsmount for the filesystem
> + *
> + * If NFS state is created for a file on this filesystem, pin the
> + * superblock so the kill callback can revoke that state on unmount.
> + * Returns nfs_ok on success, or an NFS error on failure.
> + *
> + * This function is idempotent - if a pin already exists for the
> + * superblock, no new pin is created.
> + */
> +__be32 nfsd_pin_sb(struct net *net, struct vfsmount *mnt)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct super_block *sb =3D mnt->mnt_sb;
> +	struct nfsd_fs_pin *new, *old;
> +
> +	old =3D xa_load(&nn->nfsd_sb_pins, (unsigned long)sb);
> +	if (old)
> +		return nfs_ok;
> +
> +	new =3D kzalloc(sizeof(*new), GFP_KERNEL);
> +	if (!new)
> +		return nfserr_jukebox;
> +
> +	new->sb =3D sb;
> +	new->net =3D get_net(net);
> +	init_fs_pin(&new->pin, nfsd_fs_pin_kill);
> +	INIT_WORK(&new->work, nfsd_fs_pin_work);
> +	init_completion(&new->done);
> +
> +	old =3D xa_cmpxchg(&nn->nfsd_sb_pins, (unsigned long)sb, NULL, new,
> +			 GFP_KERNEL);
> +	if (old) {
> +		/* Another task beat us to it */
> +		put_net(new->net);
> +		kfree(new);

That other task beat us to xa_cmpxchg() but might not have called
pin_insert_group() yet, so maybe could still fail.  So returning nfs_ok
here could be premature .. except...

> +		return nfs_ok;
> +	}
> +
> +	pin_insert_group(&new->pin, mnt);
> +
> +	/*
> +	 * Check if the superblock became inactive while the pin was being
> +	 * registered. If VFS already started unmount, group_pin_kill()
> +	 * may or may not invoke the kill callback depending on timing.
> +	 *
> +	 * If SB_ACTIVE is clear, clean up here. xa_erase() synchronizes
> +	 * with nfsd_fs_pin_kill() and nfsd_sb_pins_destroy(): the path
> +	 * that successfully erases the xarray entry performs cleanup;
> +	 * the other path skips it.
> +	 */
> +	if (!(READ_ONCE(sb->s_flags) & SB_ACTIVE)) {

I don't see how this could be possible. Any caller of nfsd_pin_sb() will
have an open file on the filesystem which will prevent unmount.
Maybe having a WARN_ON_ONCE() here could be useful, but I think this
case represents a bug, not a race.

Or do you see something that I don't?


> +		new =3D xa_erase(&nn->nfsd_sb_pins, (unsigned long)sb);
> +		if (new) {
> +			pin_remove(&new->pin);
> +			call_rcu(&new->rcu, nfsd_fs_pin_free_rcu);
> +		}
> +		return nfserr_stale;
> +	}
> +
> +	return nfs_ok;
> +}
> +
> +/**
> + * nfsd_sb_pins_init - initialize the superblock pins xarray
> + * @nn: nfsd_net for this network namespace
> + */
> +void nfsd_sb_pins_init(struct nfsd_net *nn)
> +{
> +	xa_init(&nn->nfsd_sb_pins);
> +}
> +
> +/*
> + * Clean up all fs_pins during NFSD shutdown.
> + *
> + * xa_erase() synchronizes with nfsd_fs_pin_kill(): the path that
> + * successfully erases an xarray entry performs cleanup for that pin.
> + * A NULL return indicates the VFS unmount path is performing cleanup.
> + */
> +static void nfsd_sb_pins_destroy(struct nfsd_net *nn)
> +{
> +	struct nfsd_fs_pin *p;
> +	unsigned long index;
> +
> +	xa_for_each(&nn->nfsd_sb_pins, index, p) {
> +		p =3D xa_erase(&nn->nfsd_sb_pins, index);
> +		if (!p)
> +			continue; /* VFS unmount path handling this pin */
> +		pin_remove(&p->pin);
> +		call_rcu(&p->rcu, nfsd_fs_pin_free_rcu);
> +	}
> +	xa_destroy(&nn->nfsd_sb_pins);
> +}
> +
> +/**
> + * nfsd_sb_pins_shutdown - shutdown superblock pins for a network namespace
> + * @nn: nfsd_net for this network namespace
> + *
> + * Must be called during nfsd shutdown before tearing down client state.
> + * Flushes any pending work and waits for RCU callbacks to complete.
> + */
> +void nfsd_sb_pins_shutdown(struct nfsd_net *nn)
> +{
> +	nfsd_sb_pins_destroy(nn);
> +	flush_workqueue(nfsd_pin_wq);
> +	/*
> +	 * Wait for RCU callbacks from nfsd_sb_pins_destroy() to complete.
> +	 * These callbacks release network namespace references via put_net()
> +	 * which must happen before the namespace teardown continues.
> +	 */
> +	rcu_barrier();
> +}
> +
> +int nfsd_pin_init(void)
> +{
> +	nfsd_pin_wq =3D alloc_workqueue("nfsd_pin", WQ_UNBOUND, 0);
> +	if (!nfsd_pin_wq)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +void nfsd_pin_exit(void)
> +{
> +	destroy_workqueue(nfsd_pin_wq);
> +}
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index f1c1bac173a5..6c1f22e200d8 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -850,6 +850,13 @@ static inline void nfsd4_revoke_states(struct nfsd_net=
 *nn, struct super_block *
>  }
>  #endif
> =20
> +/* superblock pin management (pin.c) */
> +int nfsd_pin_init(void);
> +void nfsd_pin_exit(void);
> +__be32 nfsd_pin_sb(struct net *net, struct vfsmount *mnt);
> +void nfsd_sb_pins_init(struct nfsd_net *nn);
> +void nfsd_sb_pins_shutdown(struct nfsd_net *nn);
> +
>  /* grace period management */
>  bool nfsd4_force_end_grace(struct nfsd_net *nn);
> =20
> --=20
> 2.52.0
>=20
>=20

Thanks,
NeilBrown

