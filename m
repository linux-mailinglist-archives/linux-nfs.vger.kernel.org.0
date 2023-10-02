Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B837B5483
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Oct 2023 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbjJBNuX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Oct 2023 09:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbjJBNuP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Oct 2023 09:50:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BF1120
        for <linux-nfs@vger.kernel.org>; Mon,  2 Oct 2023 06:50:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7C9C433C7;
        Mon,  2 Oct 2023 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696254600;
        bh=RcY6R+0mltVfXKcsQgGQ2suL5oN35tNfc8zTwWijepQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cEnNjiGG2QAjL40+Wc141clKOoWUUd4izyUQ32a87SpVbToR4E15quefSWPcJbSyh
         4X7yZFK2inUQW1r0m/XbQxRGYoy5ySqS7XcVKVgacdR2DtMbzhJfWMP8kiaEqvfBrt
         53+llquzdw+KOh5PYMGOyL9mrVQ6qXQ6Epri1dVmCqoizlQsUGahbigwEFBn3hkMKz
         1l5hKRqyz9C5s1svjXPJshRIMOcWUXrTm5DGK3eb++cvxL9PoSptYYEpqsaV1bVL17
         paxxdLga1QAx+Ip/G6gKjRK7UaZtx5cB9GgKJf4awH+S5cMZx/NAXyB8V4ZzdZNvYR
         /31nMRBHMR5HA==
Message-ID: <7b05e8044ef8b1eea8be3c9cf740c0617ab282eb.camel@kernel.org>
Subject: Re: [PATCH RFC 2/2] NFSD: Fix frame size warning in
 svc_export_parse()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 02 Oct 2023 09:49:58 -0400
In-Reply-To: <169618111635.65416.17904452739639303587.stgit@manet.1015granger.net>
References: <169618103606.65416.14867860807492030083.stgit@manet.1015granger.net>
         <169618111635.65416.17904452739639303587.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-10-01 at 13:25 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> fs/nfsd/export.c: In function 'svc_export_parse':
> fs/nfsd/export.c:737:1: warning: the frame size of 1040 bytes is larger t=
han 1024 bytes [-Wframe-larger-than=3D]
>     737 | }
>=20
> On my systems, svc_export_parse() has a stack frame of over 800
> bytes, not 1040, but nonetheless, it could do with some reduction.
>=20
> When a struct svc_export is on the stack, it's a temporary structure
> used as an argument, and not visible as an actual exported FS. No
> need to reserve space for export_stats in such cases.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310012359.YEw5IrK6-lkp@i=
ntel.com/
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/export.c |   30 +++++++++++++++++++++---------
>  fs/nfsd/export.h |    4 ++--
>  fs/nfsd/stats.h  |   12 ++++++------
>  3 files changed, 29 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 11a0eaa2f914..7cf26bfe199d 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -339,12 +339,16 @@ static int export_stats_init(struct export_stats *s=
tats)
> =20
>  static void export_stats_reset(struct export_stats *stats)
>  {
> -	nfsd_percpu_counters_reset(stats->counter, EXP_STATS_COUNTERS_NUM);
> +	if (stats)
> +		nfsd_percpu_counters_reset(stats->counter,
> +					   EXP_STATS_COUNTERS_NUM);
>  }
> =20
>  static void export_stats_destroy(struct export_stats *stats)
>  {
> -	nfsd_percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
> +	if (stats)
> +		nfsd_percpu_counters_destroy(stats->counter,
> +					     EXP_STATS_COUNTERS_NUM);
>  }
> =20
>  static void svc_export_put(struct kref *ref)
> @@ -353,7 +357,8 @@ static void svc_export_put(struct kref *ref)
>  	path_put(&exp->ex_path);
>  	auth_domain_put(exp->ex_client);
>  	nfsd4_fslocs_free(&exp->ex_fslocs);
> -	export_stats_destroy(&exp->ex_stats);
> +	export_stats_destroy(exp->ex_stats);
> +	kfree(exp->ex_stats);
>  	kfree(exp->ex_uuid);
>  	kfree_rcu(exp, ex_rcu);
>  }
> @@ -767,13 +772,13 @@ static int svc_export_show(struct seq_file *m,
>  	seq_putc(m, '\t');
>  	seq_escape(m, exp->ex_client->name, " \t\n\\");
>  	if (export_stats) {
> -		seq_printf(m, "\t%lld\n", exp->ex_stats.start_time);
> +		seq_printf(m, "\t%lld\n", exp->ex_stats->start_time);
>  		seq_printf(m, "\tfh_stale: %lld\n",
> -			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_FH_ST=
ALE]));
> +			   percpu_counter_sum_positive(&exp->ex_stats->counter[EXP_STATS_FH_S=
TALE]));
>  		seq_printf(m, "\tio_read: %lld\n",
> -			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_IO_RE=
AD]));
> +			   percpu_counter_sum_positive(&exp->ex_stats->counter[EXP_STATS_IO_R=
EAD]));
>  		seq_printf(m, "\tio_write: %lld\n",
> -			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_IO_WR=
ITE]));
> +			   percpu_counter_sum_positive(&exp->ex_stats->counter[EXP_STATS_IO_W=
RITE]));
>  		seq_putc(m, '\n');
>  		return 0;
>  	}
> @@ -819,7 +824,7 @@ static void svc_export_init(struct cache_head *cnew, =
struct cache_head *citem)
>  	new->ex_layout_types =3D 0;
>  	new->ex_uuid =3D NULL;
>  	new->cd =3D item->cd;
> -	export_stats_reset(&new->ex_stats);
> +	export_stats_reset(new->ex_stats);
>  }
> =20
>  static void export_update(struct cache_head *cnew, struct cache_head *ci=
tem)
> @@ -856,7 +861,14 @@ static struct cache_head *svc_export_alloc(void)
>  	if (!i)
>  		return NULL;
> =20
> -	if (export_stats_init(&i->ex_stats)) {
> +	i->ex_stats =3D kmalloc(sizeof(i->ex_stats), GFP_KERNEL);
> +	if (!i->ex_stats) {
> +		kfree(i);
> +		return NULL;
> +	}
> +
> +	if (export_stats_init(i->ex_stats)) {
> +		kfree(i->ex_stats);
>  		kfree(i);
>  		return NULL;
>  	}
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index 2df8ae25aad3..ca9dc230ae3d 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -64,10 +64,10 @@ struct svc_export {
>  	struct cache_head	h;
>  	struct auth_domain *	ex_client;
>  	int			ex_flags;
> +	int			ex_fsid;
>  	struct path		ex_path;
>  	kuid_t			ex_anon_uid;
>  	kgid_t			ex_anon_gid;
> -	int			ex_fsid;
>  	unsigned char *		ex_uuid; /* 16 byte fsid */
>  	struct nfsd4_fs_locations ex_fslocs;
>  	uint32_t		ex_nflavors;
> @@ -76,8 +76,8 @@ struct svc_export {
>  	struct nfsd4_deviceid_map *ex_devid_map;
>  	struct cache_detail	*cd;
>  	struct rcu_head		ex_rcu;
> -	struct export_stats	ex_stats;
>  	unsigned long		ex_xprtsec_modes;
> +	struct export_stats	*ex_stats;
>  };
> =20
>  /* an "export key" (expkey) maps a filehandlefragement to an
> diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
> index a3e9e2f47ec4..14f50c660b61 100644
> --- a/fs/nfsd/stats.h
> +++ b/fs/nfsd/stats.h
> @@ -61,22 +61,22 @@ static inline void nfsd_stats_rc_nocache_inc(void)
>  static inline void nfsd_stats_fh_stale_inc(struct svc_export *exp)
>  {
>  	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_FH_STALE]);
> -	if (exp)
> -		percpu_counter_inc(&exp->ex_stats.counter[EXP_STATS_FH_STALE]);
> +	if (exp && exp->ex_stats)
> +		percpu_counter_inc(&exp->ex_stats->counter[EXP_STATS_FH_STALE]);
>  }
> =20
>  static inline void nfsd_stats_io_read_add(struct svc_export *exp, s64 am=
ount)
>  {
>  	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_READ], amount);
> -	if (exp)
> -		percpu_counter_add(&exp->ex_stats.counter[EXP_STATS_IO_READ], amount);
> +	if (exp && exp->ex_stats)
> +		percpu_counter_add(&exp->ex_stats->counter[EXP_STATS_IO_READ], amount)=
;
>  }
> =20
>  static inline void nfsd_stats_io_write_add(struct svc_export *exp, s64 a=
mount)
>  {
>  	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_WRITE], amount);
> -	if (exp)
> -		percpu_counter_add(&exp->ex_stats.counter[EXP_STATS_IO_WRITE], amount)=
;
> +	if (exp && exp->ex_stats)
> +		percpu_counter_add(&exp->ex_stats->counter[EXP_STATS_IO_WRITE], amount=
);
>  }
> =20
>  static inline void nfsd_stats_payload_misses_inc(struct nfsd_net *nn)
>=20
>=20

Seems reasonable.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
