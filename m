Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D03481A0CE6
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2020 13:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgDGLdw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Apr 2020 07:33:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:47780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgDGLdw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 7 Apr 2020 07:33:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D35EAABD7;
        Tue,  7 Apr 2020 11:33:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 589C61E1233; Tue,  7 Apr 2020 13:33:48 +0200 (CEST)
Date:   Tue, 7 Apr 2020 13:33:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] MM: Discard NR_UNSTABLE_NFS, use NR_WRITEBACK
 instead.
Message-ID: <20200407113348.GG9482@quack2.suse.cz>
References: <draft-87d08kw57p.fsf@notabene.neil.brown.name>
 <878sj8w55y.fsf@notabene.neil.brown.name>
 <20200407102515.GB9482@quack2.suse.cz>
 <20200407112412.GO18914@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407112412.GO18914@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue 07-04-20 13:24:12, Michal Hocko wrote:
> On Tue 07-04-20 12:25:15, Jan Kara wrote:
> > > @@ -1707,8 +1706,16 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
> > >  static void *vmstat_next(struct seq_file *m, void *arg, loff_t *pos)
> > >  {
> > >  	(*pos)++;
> > > -	if (*pos >= NR_VMSTAT_ITEMS)
> > > +	if (*pos >= NR_VMSTAT_ITEMS) {
> > > +		/*
> > > +		 * Deprecated counters which are no longer represented
> > > +		 * in vmstat arrays. We just lie about them to be always
> > > +		 * 0 to not break userspace which might expect them in
> > > +		 * the output.
> > > +		 */
> > > +		seq_puts(m, "nr_unstable 0");
> > >  		return NULL;
> > > +	}
> > >  	return (unsigned long *)m->private + *pos;
> > >  }
> > 
> > Umm, how is this supposed to work? vmstat_next() should return next element
> > of the sequence, not fill anything into seq_file - that's the job of
> > vmstat_show(). Looking at seq_read() implementation it may actually end up
> > working fine but I wouldn't really bet much on it especially in corner
> > cases like when we are just about to fill the user buffer and then need to
> > restart reading close to an end of vmstat file or so.
> 
> Well, I have to confess I haven't really tested this myself but the
> logic was to have this output close to NR_VMSTAT_ITEMS break out of
> the counters loop.
> 
> > Michal, won't it be cleaner to have NR_VM_DEPRECATED_ITEMS included in
> > NR_VMSTAT_ITEMS, have names of these items in vmstat_text, and just set
> > appropriate number of 0 entries at the end of the array generated in
> > vmstat_start() and be done with it? That seems conceptually simpler and the
> > overhead is minimal.
> 
> Yes, that would be much nicer, albeit more code.  So I believe you meant
> something like this?
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 462f6873905a..a18611197bea 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -237,7 +237,6 @@ enum node_stat_item {
>  	NR_FILE_THPS,
>  	NR_FILE_PMDMAPPED,
>  	NR_ANON_THPS,
> -	NR_UNSTABLE_NFS,	/* NFS unstable pages */
>  	NR_VMSCAN_WRITE,
>  	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
>  	NR_DIRTIED,		/* page dirtyings since bootup */
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 78d53378db99..992e162f1886 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1162,7 +1162,6 @@ const char * const vmstat_text[] = {
>  	"nr_file_hugepages",
>  	"nr_file_pmdmapped",
>  	"nr_anon_transparent_hugepages",
> -	"nr_unstable",
>  	"nr_vmscan_write",
>  	"nr_vmscan_immediate_reclaim",
>  	"nr_dirtied",
> @@ -1293,9 +1292,13 @@ const char * const vmstat_text[] = {
>  	"swap_ra_hit",
>  #endif
>  #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
> +	/* Deprecated counters. Count them in NR_VM_DEPRECATED_ITEMS */
> +	"nr_unstable",
>  };
>  #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
>  
> +#define NR_VM_DEPRECATED_ITEMS 1
> +
>  #if (defined(CONFIG_DEBUG_FS) && defined(CONFIG_COMPACTION)) || \
>       defined(CONFIG_PROC_FS)
>  static void *frag_start(struct seq_file *m, loff_t *pos)
> @@ -1661,7 +1664,8 @@ static const struct seq_operations zoneinfo_op = {
>  			 NR_VM_NODE_STAT_ITEMS + \
>  			 NR_VM_WRITEBACK_STAT_ITEMS + \
>  			 (IS_ENABLED(CONFIG_VM_EVENT_COUNTERS) ? \
> -			  NR_VM_EVENT_ITEMS : 0))
> +			  NR_VM_EVENT_ITEMS : 0) + \
> +			  NR_VM_DEPRECATED_ITEMS)
>  
>  static void *vmstat_start(struct seq_file *m, loff_t *pos)
>  {
> @@ -1698,7 +1702,11 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
>  	all_vm_events(v);
>  	v[PGPGIN] /= 2;		/* sectors -> kbytes */
>  	v[PGPGOUT] /= 2;
> +	v += NR_VM_EVENT_ITEMS;
>  #endif
> +	for (i = 0; i < NR_VM_DEPRECATED_ITEMS)
					     ^^ ; i++ here

but otherwise yes, this is what I meant. Thanks!

> +		v[i] = 0;
> +
>  	return (unsigned long *)m->private + *pos;
>  }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
