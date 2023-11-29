Return-Path: <linux-nfs+bounces-164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777AE7FD6D0
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 13:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D951C210E8
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010D31DDDB;
	Wed, 29 Nov 2023 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUMHky8W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A93CBD
	for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 04:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701261218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSQ9OdUpDjwrP9JNd4zGN0mMgweg82LJR9hkpH1MBIU=;
	b=YUMHky8WmlynCQDjQJVpuhQKnFTU07McbQGdnLepF6IuBCo6mGKEUhLJaedS+qkG93kRnL
	v0sEuUiB5C/H6VKjfpeYKklnbj7mKvcb9KxhRwrQpJ7zClW9mdPsDpVDlwk+C/Ukcj3inp
	NBKKwC9Fq2+Vz5xlzRdHLwDfYKJA2rw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-EvOxJTFzOaSGdvnPIeKEhQ-1; Wed, 29 Nov 2023 07:33:37 -0500
X-MC-Unique: EvOxJTFzOaSGdvnPIeKEhQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-67a542b737fso6327516d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 04:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701261217; x=1701866017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSQ9OdUpDjwrP9JNd4zGN0mMgweg82LJR9hkpH1MBIU=;
        b=HPDcHm/AiLF5lGBgcleYEVOW6/eVhD6lzwdsC44aDeauzQ/a8kM8XyyKteDt5SP0BK
         wH5aYM5vaY/cMzRVSCdgwDggIBa/GDvkfOXAfWIleQYe/YU3BeTEpaY0LjXvq2fUx4P7
         9Bs6s2HLjN3LrzIL7J5iMV2kgkN7RvLpRqr+1M3dGllL7eio6bSA/e89FA2tSsflk0Ge
         8f54fjPcdUNXE9z9Ks19vLmbw02UoJR4a/2sY+Jy6ybvSx4K8XzhkjcJSf6RHMTW87bi
         kG4fIssUAGaJFv6IlVDbZlfFyQ8hSG5YQ6ZdfRwx69xKj2fyclG6QwJt6huii9AOUrG1
         Cw6g==
X-Gm-Message-State: AOJu0YwuspqCsHbbsw3FJXYUz6jyJxIyDUy34IIPsQsHFilr7YXP1/o4
	7cNcRSybEQyVHnXEOfmlUGl9jwJHQzITuvGCOy4+0384cDvBCohMiGW/YMok9qWigkyT2GLE07B
	9p7lx92EYqL/LcCOr42kPC41+z8tn
X-Received: by 2002:a05:6214:2f02:b0:67a:1458:aacd with SMTP id od2-20020a0562142f0200b0067a1458aacdmr18853065qvb.1.1701261216731;
        Wed, 29 Nov 2023 04:33:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE53edRcMk17Cfl6eblsfwixKCWLepYn4Om/7Ba6B+weSlRWlVwlwabXpCtzik6i43DYDGTjQ==
X-Received: by 2002:a05:6214:2f02:b0:67a:1458:aacd with SMTP id od2-20020a0562142f0200b0067a1458aacdmr18853051qvb.1.1701261216335;
        Wed, 29 Nov 2023 04:33:36 -0800 (PST)
Received: from [172.31.1.12] ([70.109.186.209])
        by smtp.gmail.com with ESMTPSA id z20-20020a0cda94000000b0067266b7b903sm6098546qvj.5.2023.11.29.04.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 04:33:36 -0800 (PST)
Message-ID: <0d3f422b-5cb0-4c1b-be26-938518121cbd@redhat.com>
Date: Wed, 29 Nov 2023 07:33:35 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] exportfs: remove warning if neither
 subtree_check or no_subtree_check is given
Content-Language: en-US
To: NeilBrown <neilb@suse.de>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <170044868651.19300.8600752002784382234@noble.neil.brown.name>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <170044868651.19300.8600752002784382234@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/19/23 9:51 PM, NeilBrown wrote:
> 
> This warning was only ever intended as a transitional aid.
> It doesn't serve any purpose any longer.  Let's remove it.
> 
> Also clean up some white-space issues.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-7-1-rc1)

steved
> ---
>   support/export/export.c  |  2 +-
>   support/export/xtab.c    |  2 +-
>   support/include/nfslib.h |  2 +-
>   support/nfs/exports.c    | 43 +++++++++++++++++-----------------------
>   4 files changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/support/export/export.c b/support/export/export.c
> index 3e48c42def19..100912cb29c3 100644
> --- a/support/export/export.c
> +++ b/support/export/export.c
> @@ -119,7 +119,7 @@ export_read(char *fname, int ignore_hosts)
>   	int reexport_found = 0;
>   
>   	setexportent(fname, "r");
> -	while ((eep = getexportent(0,1)) != NULL) {
> +	while ((eep = getexportent(0)) != NULL) {
>   		exp = export_lookup(eep->e_hostname, eep->e_path, ignore_hosts);
>   		if (!exp) {
>   			if (export_create(eep, 0))
> diff --git a/support/export/xtab.c b/support/export/xtab.c
> index e210ca99d574..282f15bc79cd 100644
> --- a/support/export/xtab.c
> +++ b/support/export/xtab.c
> @@ -47,7 +47,7 @@ xtab_read(char *xtab, char *lockfn, int is_export)
>   	setexportent(xtab, "r");
>   	if (is_export == 1)
>   		v4root_needed = 1;
> -	while ((xp = getexportent(is_export==0, 0)) != NULL) {
> +	while ((xp = getexportent(is_export==0)) != NULL) {
>   		if (!(exp = export_lookup(xp->e_hostname, xp->e_path, is_export != 1)) &&
>   		    !(exp = export_create(xp, is_export!=1))) {
>                           if(xp->e_hostname) {
> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
> index bdbde78d9ebd..eff2a486307f 100644
> --- a/support/include/nfslib.h
> +++ b/support/include/nfslib.h
> @@ -111,7 +111,7 @@ struct rmtabent {
>    * configuration file parsing
>    */
>   void			setexportent(char *fname, char *type);
> -struct exportent *	getexportent(int,int);
> +struct exportent *	getexportent(int);
>   void 			secinfo_show(FILE *fp, struct exportent *ep);
>   void			xprtsecinfo_show(FILE *fp, struct exportent *ep);
>   void			putexportent(struct exportent *xep);
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index 15dc574cc21a..a6816e60d62e 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -59,7 +59,7 @@ static int	*squids = NULL, nsquids = 0,
>   
>   static int	getexport(char *exp, int len);
>   static int	getpath(char *path, int len);
> -static int	parseopts(char *cp, struct exportent *ep, int warn, int *had_subtree_opt_ptr);
> +static int	parseopts(char *cp, struct exportent *ep, int *had_subtree_opt_ptr);
>   static int	parsesquash(char *list, int **idp, int *lenp, char **ep);
>   static int	parsenum(char **cpp);
>   static void	freesquash(void);
> @@ -109,7 +109,7 @@ static void init_exportent (struct exportent *ee, int fromkernel)
>   }
>   
>   struct exportent *
> -getexportent(int fromkernel, int fromexports)
> +getexportent(int fromkernel)
>   {
>   	static struct exportent	ee, def_ee;
>   	char		exp[512], *hostname;
> @@ -147,7 +147,7 @@ getexportent(int fromkernel, int fromexports)
>   	 * we're not reading from the kernel.
>   	 */
>   	if (exp[0] == '-' && !fromkernel) {
> -		if (parseopts(exp + 1, &def_ee, 0, &has_default_subtree_opts) < 0)
> +		if (parseopts(exp + 1, &def_ee, &has_default_subtree_opts) < 0)
>   			return NULL;
>   
>   		has_default_opts = 1;
> @@ -185,20 +185,20 @@ getexportent(int fromkernel, int fromexports)
>   	}
>   	ee.e_hostname = xstrdup(hostname);
>   
> -	if (parseopts(opt, &ee, fromexports && !has_default_subtree_opts, NULL) < 0) {
> -                if(ee.e_hostname)
> -                {
> -                    xfree(ee.e_hostname);
> -                    ee.e_hostname=NULL;
> -                }
> -                if(ee.e_uuid)
> -                {
> -                    xfree(ee.e_uuid);
> -                    ee.e_uuid=NULL;
> -                }
> +	if (parseopts(opt, &ee, NULL) < 0) {
> +		if(ee.e_hostname)
> +		{
> +			xfree(ee.e_hostname);
> +			ee.e_hostname=NULL;
> +		}
> +		if(ee.e_uuid)
> +		{
> +			xfree(ee.e_uuid);
> +			ee.e_uuid=NULL;
> +		}
>   
>   		return NULL;
> -        }
> +	}
>   	/* resolve symlinks */
>   	if (realpath(ee.e_path, rpath) != NULL) {
>   		rpath[sizeof (rpath) - 1] = '\0';
> @@ -433,7 +433,7 @@ mkexportent(char *hname, char *path, char *options)
>   	}
>   	strncpy(ee.e_path, path, sizeof (ee.e_path));
>   	ee.e_path[sizeof (ee.e_path) - 1] = '\0';
> -	if (parseopts(options, &ee, 0, NULL) < 0)
> +	if (parseopts(options, &ee, NULL) < 0)
>   		return NULL;
>   	return &ee;
>   }
> @@ -441,7 +441,7 @@ mkexportent(char *hname, char *path, char *options)
>   int
>   updateexportent(struct exportent *eep, char *options)
>   {
> -	if (parseopts(options, eep, 0, NULL) < 0)
> +	if (parseopts(options, eep, NULL) < 0)
>   		return 0;
>   	return 1;
>   }
> @@ -632,7 +632,7 @@ void fix_pseudoflavor_flags(struct exportent *ep)
>    * Parse option string pointed to by cp and set mount options accordingly.
>    */
>   static int
> -parseopts(char *cp, struct exportent *ep, int warn, int *had_subtree_opt_ptr)
> +parseopts(char *cp, struct exportent *ep, int *had_subtree_opt_ptr)
>   {
>   	int	had_subtree_opt = 0;
>   	char 	*flname = efname?efname:"command line";
> @@ -852,13 +852,6 @@ bad_option:
>   	ep->e_nsqgids = nsqgids;
>   
>   out:
> -	if (warn && !had_subtree_opt)
> -		xlog(L_WARNING, "%s [%d]: Neither 'subtree_check' or 'no_subtree_check' specified for export \"%s:%s\".\n"
> -				"  Assuming default behaviour ('no_subtree_check').\n"
> -				"  NOTE: this default has changed since nfs-utils version 1.0.x\n",
> -
> -				flname, flline,
> -				ep->e_hostname, ep->e_path);
>   	if (had_subtree_opt_ptr)
>   		*had_subtree_opt_ptr = had_subtree_opt;
>   


