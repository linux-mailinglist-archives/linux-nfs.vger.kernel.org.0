Return-Path: <linux-nfs+bounces-2464-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF6888A6D5
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 16:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DDE21F6204F
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E6E71B4B;
	Mon, 25 Mar 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6mYxZM6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA040BE7
	for <linux-nfs@vger.kernel.org>; Mon, 25 Mar 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372033; cv=none; b=F9eDpezWLfbPlqo8SHnmg+domCbEPvgpOnbZWHyP/TS0Hb6CtOkqBt8xm3VWn7ocTtZ9RTDn98/L6nUzFJoHNEfTfpVR38jkcCI3XXpO0ySYgLdhpLxKVuZY+4wGbrXKUm/tG40cFIMEc43IKjC+ULZnckWtJZt01kC59biIwWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372033; c=relaxed/simple;
	bh=ISDiLRi1eR8IIezG44U3a1MeoGMcNDJ3Lx7Dh1CUADI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dujp5ykATBewa4R84V0gimp3cSMtocoMLfFNid9Zn9c8YVJyIhc+h/Re8mmbsEDId1i51fsBSIRLe3N+4YY4sfExJ8I7Pm8TYGLqBS9SW2NTopfikrZTIwePnJB9J/DgACBZ8oxdpEl+PCMN6RbKl2TmrNyzUjc6GaIFW3bJato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6mYxZM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124C9C43390;
	Mon, 25 Mar 2024 13:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711372032;
	bh=ISDiLRi1eR8IIezG44U3a1MeoGMcNDJ3Lx7Dh1CUADI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=b6mYxZM6XoQL9sRlmYKBpF/6187GnI/vO3OB86XtAwlcFZ9FgIJjR8Shs2Ty4k3rN
	 QNi8dAnPvr5Yx20vO3mK5+urCTbJMk/GiHy6xztrR3ExUFsdB+aFGAhu8XtABoAfDG
	 u7HYXSHrYg2xrkx9riD2ndjFYMiZv823Cfm3V1Ts7iLWhoc9j2e0TswqEstSrO0iop
	 okUF3FAUtZBVfT2UglBWLINjzQ8vf9t/H+G8yMRKqLhzJUl1HckY8+Sz01NPPQSMb/
	 4IrpoHjDt9cIeC6W350PNt/rV+/DClbiENUGisvkNMiuHaZ8qMd+eDvV6UMuFxCbg6
	 eRDvd1cSwfDDw==
Message-ID: <5301e185c4c4117650b57e9c36de169be0cd8655.camel@kernel.org>
Subject: Re: [PATCH v2] fs: nfsd: use group allocation/free of per-cpu
 counters API
From: Jeff Layton <jlayton@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Chuck Lever
 <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>,  Dennis Zhou <dennis@kernel.org>
Cc: linux-nfs@vger.kernel.org
Date: Mon, 25 Mar 2024 09:07:10 -0400
In-Reply-To: <20240325132139.113933-1-wangkefeng.wang@huawei.com>
References: <20240325132139.113933-1-wangkefeng.wang@huawei.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-25 at 21:21 +0800, Kefeng Wang wrote:
> Use group allocation/free of per-cpu counters api to accelerate
> nfsd percpu_counters init/destroy(), and also squash the
> nfsd_percpu_counters_init/reset/destroy() and nfsd_counters_init/destroy(=
)
> into callers to simplify code.
>=20
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2:
> - directly use percpu_counter_*_many helpers and drop wrappers,
>   suggested by Jeff Layton
>=20
>  fs/nfsd/export.c | 16 ++++++++++------
>  fs/nfsd/nfsctl.c |  5 +++--
>  fs/nfsd/stats.c  | 42 ------------------------------------------
>  fs/nfsd/stats.h  |  5 -----
>  4 files changed, 13 insertions(+), 55 deletions(-)
>=20

An even nicer diffstat!

> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 7b641095a665..50b3135d07ac 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -334,21 +334,25 @@ static void nfsd4_fslocs_free(struct nfsd4_fs_locat=
ions *fsloc)
>  static int export_stats_init(struct export_stats *stats)
>  {
>  	stats->start_time =3D ktime_get_seconds();
> -	return nfsd_percpu_counters_init(stats->counter, EXP_STATS_COUNTERS_NUM=
);
> +	return percpu_counter_init_many(stats->counter, 0, GFP_KERNEL,
> +					EXP_STATS_COUNTERS_NUM);
>  }
> =20
>  static void export_stats_reset(struct export_stats *stats)
>  {
> -	if (stats)
> -		nfsd_percpu_counters_reset(stats->counter,
> -					   EXP_STATS_COUNTERS_NUM);
> +	if (stats) {
> +		int i;
> +
> +		for (i =3D 0; i < EXP_STATS_COUNTERS_NUM; i++)
> +			percpu_counter_set(&stats->counter[i], 0);
> +	}
>  }
> =20
>  static void export_stats_destroy(struct export_stats *stats)
>  {
>  	if (stats)
> -		nfsd_percpu_counters_destroy(stats->counter,
> -					     EXP_STATS_COUNTERS_NUM);
> +		percpu_counter_destroy_many(stats->counter,
> +					    EXP_STATS_COUNTERS_NUM);
>  }
> =20
>  static void svc_export_put(struct kref *ref)
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index ecd18bffeebc..93c87587e646 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1672,7 +1672,8 @@ static __net_init int nfsd_net_init(struct net *net=
)
>  	retval =3D nfsd_idmap_init(net);
>  	if (retval)
>  		goto out_idmap_error;
> -	retval =3D nfsd_stat_counters_init(nn);
> +	retval =3D percpu_counter_init_many(nn->counter, 0, GFP_KERNEL,
> +					  NFSD_STATS_COUNTERS_NUM);
>  	if (retval)
>  		goto out_repcache_error;
>  	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
> @@ -1704,7 +1705,7 @@ static __net_exit void nfsd_net_exit(struct net *ne=
t)
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
>  	nfsd_proc_stat_shutdown(net);
> -	nfsd_stat_counters_destroy(nn);
> +	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>  	nfsd_idmap_shutdown(net);
>  	nfsd_export_shutdown(net);
>  	nfsd_netns_free_versions(nn);
> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
> index be52fb1e928e..bb22893f1157 100644
> --- a/fs/nfsd/stats.c
> +++ b/fs/nfsd/stats.c
> @@ -73,48 +73,6 @@ static int nfsd_show(struct seq_file *seq, void *v)
> =20
>  DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
> =20
> -int nfsd_percpu_counters_init(struct percpu_counter *counters, int num)
> -{
> -	int i, err =3D 0;
> -
> -	for (i =3D 0; !err && i < num; i++)
> -		err =3D percpu_counter_init(&counters[i], 0, GFP_KERNEL);
> -
> -	if (!err)
> -		return 0;
> -
> -	for (; i > 0; i--)
> -		percpu_counter_destroy(&counters[i-1]);
> -
> -	return err;
> -}
> -
> -void nfsd_percpu_counters_reset(struct percpu_counter counters[], int nu=
m)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < num; i++)
> -		percpu_counter_set(&counters[i], 0);
> -}
> -
> -void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int =
num)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < num; i++)
> -		percpu_counter_destroy(&counters[i]);
> -}
> -
> -int nfsd_stat_counters_init(struct nfsd_net *nn)
> -{
> -	return nfsd_percpu_counters_init(nn->counter, NFSD_STATS_COUNTERS_NUM);
> -}
> -
> -void nfsd_stat_counters_destroy(struct nfsd_net *nn)
> -{
> -	nfsd_percpu_counters_destroy(nn->counter, NFSD_STATS_COUNTERS_NUM);
> -}
> -
>  void nfsd_proc_stat_init(struct net *net)
>  {
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
> index d2753e975dfd..04aacb6c36e2 100644
> --- a/fs/nfsd/stats.h
> +++ b/fs/nfsd/stats.h
> @@ -10,11 +10,6 @@
>  #include <uapi/linux/nfsd/stats.h>
>  #include <linux/percpu_counter.h>
> =20
> -int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
> -void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num=
);
> -void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int n=
um);
> -int nfsd_stat_counters_init(struct nfsd_net *nn);
> -void nfsd_stat_counters_destroy(struct nfsd_net *nn);
>  void nfsd_proc_stat_init(struct net *net);
>  void nfsd_proc_stat_shutdown(struct net *net);
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

