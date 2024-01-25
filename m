Return-Path: <linux-nfs+bounces-1441-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A85D83CF02
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 22:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD57E297EF0
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 21:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41981131E4F;
	Thu, 25 Jan 2024 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bldgZtKh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673AD13AA3C
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219811; cv=none; b=Q704Hwlp4OcVmXoWjq3OZRHrkeWBDv+5YyijPaNrv90dtxgmNO2BawdbRI2m2bQnZXBP30yLd28KAkcnuQLca415VRBaOK4aKGDnZpmpORLhos7ko8jDU9ze27GmZKwNZJlPEmbs0BRTkMEtHPiYze30L79Ghq4Sa2/SUGpmwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219811; c=relaxed/simple;
	bh=fhYKtUGHMh5Ngr2NOyFOQ/6gRTBgW9pNz3s180zvSMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TExG965pA6r2N6kbAHHvTD+qh8v7Jw22iGwoFr+N9TrG0qeDxvzsVEXJ9mczCCq1wm/MDrbQkLUnEfPaWd/19+zreRCaFr3LVzPAj8Jbq2r9Dfq3VBAmWjxdd2ZAD5WdpvNPMAqr3YanQQOg2f6h7VGg+iimX2d8gheTeqacIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bldgZtKh; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ff847429d4so1584487b3.1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 13:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706219808; x=1706824608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EonWoVMmZzUe8cUTbeAT1QeaLZcRszW4DwuYLm8AuR8=;
        b=bldgZtKhHnrWACP/bBLxaCNlDTgnjI6FYaJxR4Xn2+ydYIyusRuJcEjSqYYb0zL/lI
         5gPWixDItxFvvdxlWAQ7/l3nGMdisUPEm4jDBV3kr+t5ubNjqc1ptdpos4SMwkMeeu9W
         mWcZMrSUSlmrYuRdckSkvsygOTWCzBsAljmkTGNhZhzib2WyT5e2aVhqrvcINrczeq8w
         KnZV1g80uQPvR/X08OkCzPrUJJgm07iAMoZQKChSMJonIWUqPXk2J2A6775hGEYBBDSm
         zLL0MI6V6iUWzfCuWWf3Fk8xi+qpGqnXAlodevwAMwIIDkIMgmvIT+fDo1jkZAdJaw4Y
         1JSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706219808; x=1706824608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EonWoVMmZzUe8cUTbeAT1QeaLZcRszW4DwuYLm8AuR8=;
        b=XSf8BIDqJVz5NlWe9wWvQMfm7eGYz4ltuMzPyoEyHf0kDp5KepS06pSsQETaxJGDyK
         /rxy+KWzzJlDoS/d3Rt+1jcpcvLV2NokTsAjIUKw4gokafMdEW6LBzn62lZN8kcD07T5
         lnLuJBaGUILruuYmwdkU9cE5bGhEWgcFsIX9FxRGGPY3EE2XxEHQJhmdmUhHIJXTwyKy
         eN0EsSgzyRqUkHgb7Z45KWQ4mm/zqtOM6IhZq9aL7Nc4LPZz/BZZqINUyp5uBXFM1IzU
         /dEwyqPWkqt07lj2sI0I3CPiQs43kWILomUOZLKgxxHaYtnoijvvm8KcUucRIorZ+hNO
         JacA==
X-Gm-Message-State: AOJu0Yype+tJQXA4W7JJkmYlSN+4IpC5/HlP60XmmJM8Geha9UdSrVtx
	514uX7A59V/ZyD7gZcjf5XblGei3m8csbVpIQuQR2Cy/5bpOGj2mMIBgtTu7dew=
X-Google-Smtp-Source: AGHT+IHfZTLUPlAswe3Vbq9J4VJaSF+ZHm3lQX5LPLDmp1dkDX58YL/613VRIeIa4fPHqae70Bwgbg==
X-Received: by 2002:a81:834f:0:b0:5d7:1941:3567 with SMTP id t76-20020a81834f000000b005d719413567mr645901ywf.78.1706219808261;
        Thu, 25 Jan 2024 13:56:48 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id dt2-20020a05690c250200b005ffde38415dsm929255ywb.15.2024.01.25.13.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 13:56:48 -0800 (PST)
Date: Thu, 25 Jan 2024 16:56:47 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 03/13] sunrpc: pass in the sv_stats struct through
 svc_create*
Message-ID: <20240125215647.GC1602047@perftesting>
References: <cover.1706212207.git.josef@toxicpanda.com>
 <ff6afd3ab9a70bf5ab90872497068719f2c1ec03.1706212208.git.josef@toxicpanda.com>
 <ZbLK4BsvReiFpCUo@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbLK4BsvReiFpCUo@tissot.1015granger.net>

On Thu, Jan 25, 2024 at 03:56:00PM -0500, Chuck Lever wrote:
> On Thu, Jan 25, 2024 at 02:53:13PM -0500, Josef Bacik wrote:
> > Since only one service actually reports the rpc stats there's not much
> > of a reason to have a pointer to it in the svc_program struct.  Adjust
> > the svc_create* functions to take the sv_stats as an argument and pass
> > the struct through there as desired instead of getting it from the
> > svc_program->pg_stats.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/lockd/svc.c             |  2 +-
> >  fs/nfs/callback.c          |  2 +-
> >  fs/nfsd/nfssvc.c           |  3 ++-
> >  include/linux/sunrpc/svc.h |  8 ++++----
> >  net/sunrpc/svc.c           | 17 ++++++++++-------
> >  5 files changed, 18 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> > index ab8042a5b895..8fbbfc9aad69 100644
> > --- a/fs/lockd/svc.c
> > +++ b/fs/lockd/svc.c
> > @@ -337,7 +337,7 @@ static int lockd_get(void)
> >  		nlm_timeout = LOCKD_DFLT_TIMEO;
> >  	nlmsvc_timeout = nlm_timeout * HZ;
> >  
> > -	serv = svc_create(&nlmsvc_program, LOCKD_BUFSIZE, lockd);
> > +	serv = svc_create(&nlmsvc_program, NULL, LOCKD_BUFSIZE, lockd);
> >  	if (!serv) {
> >  		printk(KERN_WARNING "lockd_up: create service failed\n");
> >  		return -ENOMEM;
> > diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> > index 8adfcd4c8c1a..4d56b4e73525 100644
> > --- a/fs/nfs/callback.c
> > +++ b/fs/nfs/callback.c
> > @@ -202,7 +202,7 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
> >  	if (minorversion)
> >  		return ERR_PTR(-ENOTSUPP);
> >  #endif
> > -	serv = svc_create(&nfs4_callback_program, NFS4_CALLBACK_BUFSIZE,
> > +	serv = svc_create(&nfs4_callback_program, NULL, NFS4_CALLBACK_BUFSIZE,
> >  			  threadfn);
> >  	if (!serv) {
> >  		printk(KERN_ERR "nfs_callback_create_svc: create service failed\n");
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index a0b117107e86..d640f893021a 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -661,7 +661,8 @@ int nfsd_create_serv(struct net *net)
> >  	if (nfsd_max_blksize == 0)
> >  		nfsd_max_blksize = nfsd_get_default_max_blksize();
> >  	nfsd_reset_versions(nn);
> > -	serv = svc_create_pooled(&nfsd_program, nfsd_max_blksize, nfsd);
> > +	serv = svc_create_pooled(&nfsd_program, &nfsd_svcstats,
> > +				 nfsd_max_blksize, nfsd);
> >  	if (serv == NULL)
> >  		return -ENOMEM;
> >  
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index 67cf1c9efd80..2a1447fa5ef2 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -402,8 +402,8 @@ struct svc_procedure {
> >  int svc_rpcb_setup(struct svc_serv *serv, struct net *net);
> >  void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net);
> >  int svc_bind(struct svc_serv *serv, struct net *net);
> > -struct svc_serv *svc_create(struct svc_program *, unsigned int,
> > -			    int (*threadfn)(void *data));
> > +struct svc_serv *svc_create(struct svc_program *, struct svc_stat *,
> > +			    unsigned int, int (*threadfn)(void *data));
> >  struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
> >  					struct svc_pool *pool, int node);
> >  bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
> > @@ -411,8 +411,8 @@ bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
> >  void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
> >  void		   svc_rqst_free(struct svc_rqst *);
> >  void		   svc_exit_thread(struct svc_rqst *);
> > -struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
> > -				     int (*threadfn)(void *data));
> > +struct svc_serv *  svc_create_pooled(struct svc_program *, struct svc_stat *,
> > +				     unsigned int, int (*threadfn)(void *data));
> >  int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
> >  int		   svc_pool_stats_open(struct svc_info *si, struct file *file);
> >  void		   svc_process(struct svc_rqst *rqstp);
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index d2e6f3d59218..f76ef8a3dd43 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -451,8 +451,8 @@ __svc_init_bc(struct svc_serv *serv)
> >   * Create an RPC service
> >   */
> >  static struct svc_serv *
> > -__svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
> > -	     int (*threadfn)(void *data))
> > +__svc_create(struct svc_program *prog, struct svc_stat *stats,
> > +	     unsigned int bufsize, int npools, int (*threadfn)(void *data))
> >  {
> >  	struct svc_serv	*serv;
> >  	unsigned int vers;
> > @@ -463,7 +463,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
> >  		return NULL;
> >  	serv->sv_name      = prog->pg_name;
> >  	serv->sv_program   = prog;
> > -	serv->sv_stats     = prog->pg_stats;
> > +	serv->sv_stats     = stats;
> >  	if (bufsize > RPCSVC_MAXPAYLOAD)
> >  		bufsize = RPCSVC_MAXPAYLOAD;
> >  	serv->sv_max_payload = bufsize? bufsize : 4096;
> > @@ -521,34 +521,37 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
> >  /**
> >   * svc_create - Create an RPC service
> >   * @prog: the RPC program the new service will handle
> > + * @stats: the stats struct if desired
> >   * @bufsize: maximum message size for @prog
> >   * @threadfn: a function to service RPC requests for @prog
> >   *
> >   * Returns an instantiated struct svc_serv object or NULL.
> >   */
> 
> Here's the only minor quibble I have so far:
> 
> svc_create's callers don't use stats, so maybe you don't need
> to add an @stats argument for this API.
> 
> Fwiw, I haven't gotten all the way to the end of the series yet.

Yup you're right, I can drop this bit.  Thanks,

Josef

