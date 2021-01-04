Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E27F2EA027
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 23:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbhADWuN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 17:50:13 -0500
Received: from fieldses.org ([173.255.197.46]:49908 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbhADWuN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Jan 2021 17:50:13 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 62F466EAE; Mon,  4 Jan 2021 17:49:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 62F466EAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1609800570;
        bh=WH0CAWIdMz+j7bK7pdazBRHdeIOItz13Wjngc+zeWSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BRqnkwJ8+mBjayh+stMjRVfwVy/dA0lDT4FBLFNX6M6L6V2OaeCoFEmqfa/nzGR2F
         h/fkPEB/Y/hBSDkrd1I4RBtMjvXvVmGn9KhlZ+ZZFES1aZYl/ULXHi8U/gQfysGQZc
         796BylYwsXEI+GAJqM72Ru52V+0oZ58WOoiuFGrg=
Date:   Mon, 4 Jan 2021 17:49:30 -0500
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@poochiereds.net>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] nfsd: report per-export stats
Message-ID: <20210104224930.GC27763@fieldses.org>
References: <20201228170344.22867-1-amir73il@gmail.com>
 <20201228170344.22867-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228170344.22867-3-amir73il@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 28, 2020 at 07:03:44PM +0200, Amir Goldstein wrote:
> Collect some nfsd stats per export in addition to the global stats.

Seems like a reasonable thing to do.

> A new nfsdfs export_stats file is created.  It uses the same ops as the
> exports file to iterate the export entries and we use the file's name to
> determine the reported info per export.  For example:
> 
>  $ cat /proc/fs/nfsd/export_stats
>  # Version 1.1
>  # Path Client Start-time
>  #	Stats
>  /test	localhost	92
> 	fh_stale: 0
> 	io_read: 9
> 	io_write: 1
> 
> Every export entry reports the start time when stats collection
> started, so stats collecting scripts can know if stats where reset
> between samples.

Yes, you expect svc_export to be created (or destroyed) when a
filesystem is exported (or unexported), or when nfsd starts (or stops).

But actually it's just a cache entry and can be removed and recreated at
any time.  Not much we can do about losing statistics when that happens,
but the start time at least gives us some hope of interpreting the
statistics.

Why weren't there existing file system statistics that would do the job
in your case?

--b.

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/nfsd/export.c | 68 ++++++++++++++++++++++++++++++++++++++++++------
>  fs/nfsd/export.h | 17 ++++++++++++
>  fs/nfsd/nfsctl.c |  3 +++
>  fs/nfsd/nfsfh.c  |  7 +++--
>  fs/nfsd/vfs.c    |  2 ++
>  5 files changed, 87 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 21e404e7cb68..e6f4ccdcdf82 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -331,12 +331,29 @@ static void nfsd4_fslocs_free(struct nfsd4_fs_locations *fsloc)
>  	fsloc->locations = NULL;
>  }
>  
> +static int export_stats_init(struct export_stats *stats)
> +{
> +	stats->start_time = ktime_get_seconds();
> +	return nfsd_percpu_counters_init(stats->counters, EXP_STATS_COUNTERS_NUM);
> +}
> +
> +static void export_stats_reset(struct export_stats *stats)
> +{
> +	nfsd_percpu_counters_reset(stats->counters, EXP_STATS_COUNTERS_NUM);
> +}
> +
> +static void export_stats_destroy(struct export_stats *stats)
> +{
> +	nfsd_percpu_counters_destroy(stats->counters, EXP_STATS_COUNTERS_NUM);
> +}
> +
>  static void svc_export_put(struct kref *ref)
>  {
>  	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
>  	path_put(&exp->ex_path);
>  	auth_domain_put(exp->ex_client);
>  	nfsd4_fslocs_free(&exp->ex_fslocs);
> +	export_stats_destroy(&exp->ex_stats);
>  	kfree(exp->ex_uuid);
>  	kfree_rcu(exp, ex_rcu);
>  }
> @@ -686,22 +703,47 @@ static void exp_flags(struct seq_file *m, int flag, int fsid,
>  		kuid_t anonu, kgid_t anong, struct nfsd4_fs_locations *fslocs);
>  static void show_secinfo(struct seq_file *m, struct svc_export *exp);
>  
> +static int is_export_stats_file(struct seq_file *m)
> +{
> +	/*
> +	 * The export_stats file uses the same ops as the exports file.
> +	 * We use the file's name to determine the reported info per export.
> +	 * There is no rename in nsfdfs, so d_name.name is stable.
> +	 */
> +	return !strcmp(m->file->f_path.dentry->d_name.name, "export_stats");
> +}
> +
>  static int svc_export_show(struct seq_file *m,
>  			   struct cache_detail *cd,
>  			   struct cache_head *h)
>  {
> -	struct svc_export *exp ;
> +	struct svc_export *exp;
> +	bool export_stats = is_export_stats_file(m);
>  
> -	if (h ==NULL) {
> -		seq_puts(m, "#path domain(flags)\n");
> +	if (h == NULL) {
> +		if (export_stats)
> +			seq_puts(m, "#path domain start-time\n#\tstats\n");
> +		else
> +			seq_puts(m, "#path domain(flags)\n");
>  		return 0;
>  	}
>  	exp = container_of(h, struct svc_export, h);
>  	seq_path(m, &exp->ex_path, " \t\n\\");
>  	seq_putc(m, '\t');
>  	seq_escape(m, exp->ex_client->name, " \t\n\\");
> +	if (export_stats) {
> +		seq_printf(m, "\t%lld\n", exp->ex_stats.start_time);
> +		seq_printf(m, "\tfh_stale: %lld\n",
> +			   percpu_counter_sum_positive(&exp->ex_stats.fh_stale));
> +		seq_printf(m, "\tio_read: %lld\n",
> +			   percpu_counter_sum_positive(&exp->ex_stats.io_read));
> +		seq_printf(m, "\tio_write: %lld\n",
> +			   percpu_counter_sum_positive(&exp->ex_stats.io_write));
> +		seq_putc(m, '\n');
> +		return 0;
> +	}
>  	seq_putc(m, '(');
> -	if (test_bit(CACHE_VALID, &h->flags) && 
> +	if (test_bit(CACHE_VALID, &h->flags) &&
>  	    !test_bit(CACHE_NEGATIVE, &h->flags)) {
>  		exp_flags(m, exp->ex_flags, exp->ex_fsid,
>  			  exp->ex_anon_uid, exp->ex_anon_gid, &exp->ex_fslocs);
> @@ -742,6 +784,7 @@ static void svc_export_init(struct cache_head *cnew, struct cache_head *citem)
>  	new->ex_layout_types = 0;
>  	new->ex_uuid = NULL;
>  	new->cd = item->cd;
> +	export_stats_reset(&new->ex_stats);
>  }
>  
>  static void export_update(struct cache_head *cnew, struct cache_head *citem)
> @@ -774,10 +817,15 @@ static void export_update(struct cache_head *cnew, struct cache_head *citem)
>  static struct cache_head *svc_export_alloc(void)
>  {
>  	struct svc_export *i = kmalloc(sizeof(*i), GFP_KERNEL);
> -	if (i)
> -		return &i->h;
> -	else
> +	if (!i)
> +		return NULL;
> +
> +	if (export_stats_init(&i->ex_stats)) {
> +		kfree(i);
>  		return NULL;
> +	}
> +
> +	return &i->h;
>  }
>  
>  static const struct cache_detail svc_export_cache_template = {
> @@ -1239,10 +1287,14 @@ static int e_show(struct seq_file *m, void *p)
>  	struct cache_head *cp = p;
>  	struct svc_export *exp = container_of(cp, struct svc_export, h);
>  	struct cache_detail *cd = m->private;
> +	bool export_stats = is_export_stats_file(m);
>  
>  	if (p == SEQ_START_TOKEN) {
>  		seq_puts(m, "# Version 1.1\n");
> -		seq_puts(m, "# Path Client(Flags) # IPs\n");
> +		if (export_stats)
> +			seq_puts(m, "# Path Client Start-time\n#\tStats\n");
> +		else
> +			seq_puts(m, "# Path Client(Flags) # IPs\n");
>  		return 0;
>  	}
>  
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index e7daa1f246f0..bbd419fa1fc8 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -6,6 +6,7 @@
>  #define NFSD_EXPORT_H
>  
>  #include <linux/sunrpc/cache.h>
> +#include <linux/percpu_counter.h>
>  #include <uapi/linux/nfsd/export.h>
>  #include <linux/nfs4.h>
>  
> @@ -46,6 +47,21 @@ struct exp_flavor_info {
>  	u32	flags;
>  };
>  
> +/* Per-export stats */
> +struct export_stats {
> +	time64_t		start_time;
> +	/* Reference to below counters as array for init/destroy */
> +	struct percpu_counter	counters[0];
> +	struct percpu_counter   fh_stale;       /* FH stale error */
> +	struct percpu_counter	io_read;	/* bytes returned to read requests */
> +	struct percpu_counter	io_write;	/* bytes passed in write requests */
> +	/* End of array of couters */
> +	struct percpu_counter	counters_end[0];
> +#define EXP_STATS_COUNTERS_NUM \
> +	((offsetof(struct export_stats, counters_end) - \
> +	  offsetof(struct export_stats, counters)) / sizeof(struct percpu_counter))
> +};
> +
>  struct svc_export {
>  	struct cache_head	h;
>  	struct auth_domain *	ex_client;
> @@ -62,6 +78,7 @@ struct svc_export {
>  	struct nfsd4_deviceid_map *ex_devid_map;
>  	struct cache_detail	*cd;
>  	struct rcu_head		ex_rcu;
> +	struct export_stats	ex_stats;
>  };
>  
>  /* an "export key" (expkey) maps a filehandlefragement to an
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 258605ee49b8..4f6e514192bd 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -32,6 +32,7 @@
>  enum {
>  	NFSD_Root = 1,
>  	NFSD_List,
> +	NFSD_Export_Stats,
>  	NFSD_Export_features,
>  	NFSD_Fh,
>  	NFSD_FO_UnlockIP,
> @@ -1348,6 +1349,8 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	static const struct tree_descr nfsd_files[] = {
>  		[NFSD_List] = {"exports", &exports_nfsd_operations, S_IRUGO},
> +		/* Per-export io stats use same ops as exports file */
> +		[NFSD_Export_Stats] = {"export_stats", &exports_nfsd_operations, S_IRUGO},
>  		[NFSD_Export_features] = {"export_features",
>  					&export_features_operations, S_IRUGO},
>  		[NFSD_FO_UnlockIP] = {"unlock_ip",
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 1879758bbaa5..4b49e8f630b6 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -327,7 +327,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  __be32
>  fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
>  {
> -	struct svc_export *exp;
> +	struct svc_export *exp = NULL;
>  	struct dentry	*dentry;
>  	__be32		error;
>  
> @@ -399,8 +399,11 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
>  			access, ntohl(error));
>  	}
>  out:
> -	if (error == nfserr_stale)
> +	if (error == nfserr_stale) {
>  		percpu_counter_inc(&nfsdstats.fh_stale);
> +		if (exp)
> +			percpu_counter_inc(&exp->ex_stats.fh_stale);
> +	}
>  	return error;
>  }
>  
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 6adb7aba2575..456874060e78 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -890,6 +890,7 @@ static __be32 nfsd_finish_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  {
>  	if (host_err >= 0) {
>  		percpu_counter_add(&nfsdstats.io_read, host_err);
> +		percpu_counter_add(&fhp->fh_export->ex_stats.io_read, host_err);
>  		*eof = nfsd_eof_on_read(file, offset, host_err, *count);
>  		*count = host_err;
>  		fsnotify_access(file);
> @@ -1032,6 +1033,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>  	}
>  	*cnt = host_err;
>  	percpu_counter_add(&nfsdstats.io_write, *cnt);
> +	percpu_counter_add(&exp->ex_stats.io_write, *cnt);
>  	fsnotify_modify(file);
>  
>  	if (stable && use_wgather) {
> -- 
> 2.17.1
