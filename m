Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82180665FD1
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 16:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjAKP5G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 10:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbjAKP5A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 10:57:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB286BF42
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 07:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673452574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NtBxmxD3RZNKKSmNnlZUoU2QTnz48ocgcqRD17r3rfc=;
        b=dkInraSTv1GjzsWpIRJRPcUxAOqLO5ci6vkYUed33vvMlrF1enlMXh+CFiIJ5uCmQ+GpEI
        QIWBS1Ab7YsaW2b0dfBlPgNAn12dSkLWP9B4INWCRNZuCN8WyJxuP0+31zRMr2+XFvXxil
        jSZkoU6weRCJsmeMNUweBNjU+Dy/nbs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-199-uhV4442JOwOdcz7SK5poNA-1; Wed, 11 Jan 2023 10:56:12 -0500
X-MC-Unique: uhV4442JOwOdcz7SK5poNA-1
Received: by mail-qt1-f198.google.com with SMTP id a13-20020ac8610d000000b003a8151cadebso7391992qtm.10
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 07:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtBxmxD3RZNKKSmNnlZUoU2QTnz48ocgcqRD17r3rfc=;
        b=GLWayfyw9Z2Id51Qh24EI590aI7jr0xpD74rKAliLf/RwdG3THHrEkHIM5GD2EeiFb
         mJkXMXTHGS+rk4+ZapkeURxFYDrLxm+aqC/TKs9OO2zG4yWduUK/rjnbGoSORLSSTeBS
         HzK1V0YB831N0GckuiSbBufz5HzH56rHMxc/x3NHXxmFssDYUG0lNhKVAXTUu3g2vRIW
         PiTDRrrEFfzAyKbJ1roiaK9MniHwDb+blQGhtSzWuG0J0yOD80TGt9OFyOKWRr/Mu3af
         MCzYQInDAnJqzOkV/aATolDDuifaNMpZu4zoxi5JrmkjqPUIg+ZZLFxeCnYEYGcnMIV/
         H7QA==
X-Gm-Message-State: AFqh2kqRgfJxCA6ynlBazbVtAPK0Dx0B5hJkkcG28a37hr5U4a3+vnOO
        Llp3DBehn/OX9xily7LhqEzGffGet1JLjrg85o2sG2e9fJLI6cRSE19zwBdFnWSwYPSDhf+Wbu2
        rIKKS1n9h+4z6BHmbPAjU
X-Received: by 2002:ad4:57c5:0:b0:532:ae2:9059 with SMTP id y5-20020ad457c5000000b005320ae29059mr3541730qvx.33.1673452572219;
        Wed, 11 Jan 2023 07:56:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvZidPrqk9Z8J+Xi+ib3UHDsjKvDLbZ1llimxel5ZKP2sux2A47PmqfnMZMvaggfqrG9vlO4w==
X-Received: by 2002:ad4:57c5:0:b0:532:ae2:9059 with SMTP id y5-20020ad457c5000000b005320ae29059mr3541702qvx.33.1673452571872;
        Wed, 11 Jan 2023 07:56:11 -0800 (PST)
Received: from [172.31.1.6] ([70.109.130.165])
        by smtp.gmail.com with ESMTPSA id l22-20020a05620a28d600b0070531c5d655sm9387871qkp.90.2023.01.11.07.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:56:11 -0800 (PST)
Message-ID: <2c88eb01-9df1-fb7d-96ad-5a5ba1bca160@redhat.com>
Date:   Wed, 11 Jan 2023 10:56:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] Replace statfs64 with statfs
Content-Language: en-US
To:     Khem Raj <raj.khem@gmail.com>, linux-nfs@vger.kernel.org
References: <20221215213605.4061853-1-raj.khem@gmail.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20221215213605.4061853-1-raj.khem@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 12/15/22 4:36 PM, Khem Raj wrote:
> autoconf AC_SYS_LARGEFILE is used by configure to add needed defines
> when needed for enabling 64bit off_t, therefore replacing statfs64 with
> statfs should be functionally same. Additionally this helps compiling
> with latest musl where 64bit LFS functions like statfs64 and friends are
> now moved under _LARGEFILE64_SOURCE feature test macro, this works on
> glibc systems because _GNU_SOURCE macros also enables
> _LARGEFILE64_SOURCE indirectly. This is not case with musl and this
> latest issue is exposed.
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
Committed... (tag: nfs-utils-2-6-3-rc6)

steved.
> ---
>   support/export/cache.c      | 14 +++++++-------
>   support/include/nfsd_path.h |  6 +++---
>   support/misc/nfsd_path.c    | 24 ++++++++++++------------
>   utils/exportfs/exportfs.c   |  4 ++--
>   4 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/support/export/cache.c b/support/export/cache.c
> index a5823e9..2497d4f 100644
> --- a/support/export/cache.c
> +++ b/support/export/cache.c
> @@ -346,27 +346,27 @@ static int uuid_by_path(char *path, int type, size_t uuidlen, char *uuid)
>   
>   	/* Possible sources of uuid are
>   	 * - blkid uuid
> -	 * - statfs64 uuid
> +	 * - statfs uuid
>   	 *
> -	 * On some filesystems (e.g. vfat) the statfs64 uuid is simply an
> +	 * On some filesystems (e.g. vfat) the statfs uuid is simply an
>   	 * encoding of the device that the filesystem is mounted from, so
>   	 * it we be very bad to use that (as device numbers change).  blkid
>   	 * must be preferred.
> -	 * On other filesystems (e.g. btrfs) the statfs64 uuid contains
> +	 * On other filesystems (e.g. btrfs) the statfs uuid contains
>   	 * important info that the blkid uuid cannot contain:  This happens
>   	 * when multiple subvolumes are exported (they have the same
> -	 * blkid uuid but different statfs64 uuids).
> +	 * blkid uuid but different statfs uuids).
>   	 * We rely on get_uuid_blkdev *knowing* which is which and not returning
> -	 * a uuid for filesystems where the statfs64 uuid is better.
> +	 * a uuid for filesystems where the statfs uuid is better.
>   	 *
>   	 */
> -	struct statfs64 st;
> +	struct statfs st;
>   	char fsid_val[17];
>   	const char *blkid_val = NULL;
>   	const char *val;
>   	int rc;
>   
> -	rc = nfsd_path_statfs64(path, &st);
> +	rc = nfsd_path_statfs(path, &st);
>   
>   	if (type == 0 && rc == 0) {
>   		const unsigned long *bad;
> diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
> index 3b73aad..aa1e1dd 100644
> --- a/support/include/nfsd_path.h
> +++ b/support/include/nfsd_path.h
> @@ -7,7 +7,7 @@
>   #include <sys/stat.h>
>   
>   struct file_handle;
> -struct statfs64;
> +struct statfs;
>   
>   void 		nfsd_path_init(void);
>   
> @@ -18,8 +18,8 @@ char *		nfsd_path_prepend_dir(const char *dir, const char *pathname);
>   int 		nfsd_path_stat(const char *pathname, struct stat *statbuf);
>   int 		nfsd_path_lstat(const char *pathname, struct stat *statbuf);
>   
> -int		nfsd_path_statfs64(const char *pathname,
> -				   struct statfs64 *statbuf);
> +int		nfsd_path_statfs(const char *pathname,
> +				   struct statfs *statbuf);
>   
>   char *		nfsd_realpath(const char *path, char *resolved_path);
>   
> diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
> index 65e53c1..c3dea4f 100644
> --- a/support/misc/nfsd_path.c
> +++ b/support/misc/nfsd_path.c
> @@ -184,46 +184,46 @@ nfsd_path_lstat(const char *pathname, struct stat *statbuf)
>   	return nfsd_run_stat(nfsd_wq, nfsd_lstatfunc, pathname, statbuf);
>   }
>   
> -struct nfsd_statfs64_data {
> +struct nfsd_statfs_data {
>   	const char *pathname;
> -	struct statfs64 *statbuf;
> +	struct statfs *statbuf;
>   	int ret;
>   	int err;
>   };
>   
>   static void
> -nfsd_statfs64func(void *data)
> +nfsd_statfsfunc(void *data)
>   {
> -	struct nfsd_statfs64_data *d = data;
> +	struct nfsd_statfs_data *d = data;
>   
> -	d->ret = statfs64(d->pathname, d->statbuf);
> +	d->ret = statfs(d->pathname, d->statbuf);
>   	if (d->ret < 0)
>   		d->err = errno;
>   }
>   
>   static int
> -nfsd_run_statfs64(struct xthread_workqueue *wq,
> +nfsd_run_statfs(struct xthread_workqueue *wq,
>   		  const char *pathname,
> -		  struct statfs64 *statbuf)
> +		  struct statfs *statbuf)
>   {
> -	struct nfsd_statfs64_data data = {
> +	struct nfsd_statfs_data data = {
>   		pathname,
>   		statbuf,
>   		0,
>   		0
>   	};
> -	xthread_work_run_sync(wq, nfsd_statfs64func, &data);
> +	xthread_work_run_sync(wq, nfsd_statfsfunc, &data);
>   	if (data.ret < 0)
>   		errno = data.err;
>   	return data.ret;
>   }
>   
>   int
> -nfsd_path_statfs64(const char *pathname, struct statfs64 *statbuf)
> +nfsd_path_statfs(const char *pathname, struct statfs *statbuf)
>   {
>   	if (!nfsd_wq)
> -		return statfs64(pathname, statbuf);
> -	return nfsd_run_statfs64(nfsd_wq, pathname, statbuf);
> +		return statfs(pathname, statbuf);
> +	return nfsd_run_statfs(nfsd_wq, pathname, statbuf);
>   }
>   
>   struct nfsd_realpath_data {
> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
> index 0897b22..6d79a5b 100644
> --- a/utils/exportfs/exportfs.c
> +++ b/utils/exportfs/exportfs.c
> @@ -513,7 +513,7 @@ validate_export(nfs_export *exp)
>   	 */
>   	struct stat stb;
>   	char *path = exportent_realpath(&exp->m_export);
> -	struct statfs64 stf;
> +	struct statfs stf;
>   	int fs_has_fsid = 0;
>   
>   	if (stat(path, &stb) < 0) {
> @@ -528,7 +528,7 @@ validate_export(nfs_export *exp)
>   	if (!can_test())
>   		return;
>   
> -	if (!statfs64(path, &stf) &&
> +	if (!statfs(path, &stf) &&
>   	    (stf.f_fsid.__val[0] || stf.f_fsid.__val[1]))
>   		fs_has_fsid = 1;
>   

