Return-Path: <linux-nfs+bounces-9381-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5323A15C1F
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jan 2025 10:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF373166AD0
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jan 2025 09:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE5217C9F1;
	Sat, 18 Jan 2025 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yf+lZUsw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F9412B17C
	for <linux-nfs@vger.kernel.org>; Sat, 18 Jan 2025 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737192060; cv=none; b=tq2rFg5Bn3MFNA9qHYXpevgOA99m0tuTQDyC9zcwNCBj3vF6lHGrAM/suouXHrM5CR6dJfA6i6IEjZWz1teGzqQVbNtAvZjlARxzAVvbroXGBbViVYdEsOKa9vf9SN9Mxn0pqlqCCJxv4lnGhVR8HyTkrQh9McGsgr0HF6v2EVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737192060; c=relaxed/simple;
	bh=h+Dqfpgnu4777bPYJcHzlDnESm8k4RtnSzSHklqRC1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDkga/+zNvaZ6v+HC2/ruqMUdkovSKmiQrVMMRLtS1QS9T1XDlHGEOL5NMYcNxJzaTYmu533U+c+7ydKk7IRZxfT7DsMs8dqZ/p14fhDD/DLCAqIKvIU23x2lgnQdKvFouzROuGkfxElF6tPEbMrOoCglpdjZfAUt6WDPx4/aU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yf+lZUsw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737192057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NYPn57Hcj89mgLxuQDYPeYMIk1hhujH45a9Hb9CEQU=;
	b=Yf+lZUsw9AQqWiRLrroDrxJ0PBiBt9mIl/xbEwWP1Z0Xr4M1WUE6ja8/Vev5jk+rAZ17aN
	dq2LulXb5Xen3VjZHzlSUNpFJxcDYmYRbBvjIb7KTayYoQcuHPWV37rshbWbhbw4BfgEvf
	1/lVdZXOy2xYkgR1r44fVz+13uY3VpM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-b_LKukwBNP24tlwkSSqycw-1; Sat, 18 Jan 2025 04:20:55 -0500
X-MC-Unique: b_LKukwBNP24tlwkSSqycw-1
X-Mimecast-MFC-AGG-ID: b_LKukwBNP24tlwkSSqycw
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6f482362aso413123685a.1
        for <linux-nfs@vger.kernel.org>; Sat, 18 Jan 2025 01:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737192054; x=1737796854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NYPn57Hcj89mgLxuQDYPeYMIk1hhujH45a9Hb9CEQU=;
        b=VmCAm1fDGCFDYCOTKz/kiZdGMK/V/JatScQYamxRJuGXS3+NnfKxTw3h8lR5LQ5BvW
         SxnLDvRLG5uFmTlvqHHzi4jarVV3qjxVH8H5Sq40J/RN8KpeyDTL2r/dQct5NDLH+pL+
         QJheUhn+kItggqa2/0J7pp1OAwV9tgDRwn3X/ddjJCJjv6GmPo610yabueoi/S7W6qwF
         iKxNmgYIJY47agw47SB8LOdKlBOYCbUX4Thza5g9hqYz85qRRX507PDwG+Tf0Kg7R42L
         ExW8qEPYNZ9rbU6IS0/u3OcKtaPIG6Bn4zT5M/4mEPdRKCrechZPsdwFlsYoGkbdg6On
         3A4A==
X-Forwarded-Encrypted: i=1; AJvYcCUd9vjNX7cm25EoKcZNwArpw8nHUz/WZfhRcYbYwYIAHFctoZ2HKCG7ZySGhoutBVPU+zKj1FgVRMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG9stxbp0xC7a4l2aU0OBYAiURkro73iN+hsFhrrSuzaqYpwki
	aIvB2EpEdt83od3Q8Hvt3z+7D4UbPLX/T9R3VyRoQ2L6A6unSQZ8bgddAes/9WwAU3B7HCQQO+N
	ecQkHUK/P8jkCJSX8zpOVCE8f6QSrDPy6ow4kc2XjsRNkG/QSQ2of6kh+mA==
X-Gm-Gg: ASbGncsd+Wm2TCou33e5EFPaAzRfIy3OUrcdNpf9QmzZswwjLW9qFz5ep4/8tTXNWrY
	4HAFVYcaRpLoymPL1TrVeH99X2yrt04zcI1UlmyZIY39J2nGxLJXPO+mNPfXCy/tZA5m/PcAGjv
	dKawZtAjQyuv/Ba1ObbfqoZ/jA8DwmNpiLe8SaLjto75u6+wf0jnPKU97/f162GIebeKnZ+8UzS
	62a2jmblZ708LlbYofZoEOWXoqBAfgeVB1+63usW3TBOXPjMQ5LSe8A8OyVz9O+h+5GTw==
X-Received: by 2002:a05:620a:1923:b0:7b6:6c33:994e with SMTP id af79cd13be357-7be6321995cmr1025625085a.6.1737192054533;
        Sat, 18 Jan 2025 01:20:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8PYmbd5WQF0ImD6GJ736UvQE8ut7FyJRAUKiQWsli2CHs0KmLJEceT4XemFuzsb0RSREsPg==
X-Received: by 2002:a05:620a:1923:b0:7b6:6c33:994e with SMTP id af79cd13be357-7be6321995cmr1025623185a.6.1737192054076;
        Sat, 18 Jan 2025 01:20:54 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be61473c74sm212909985a.1.2025.01.18.01.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 01:20:52 -0800 (PST)
Message-ID: <243a251a-a06d-496e-9de3-a21f6a74c661@redhat.com>
Date: Sat, 18 Jan 2025 04:20:51 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFS export symlink vulnerability fix - Replaced dangerous
 use of realpath within support/nfs/export.c with nfsd_realpath variant that
 is executed within the chrooted thread rather than main thread. - Implemented
 nfsd_path.h methods to work securely within chrooted thread using
 nfsd_run_task() helper
To: Christopher Bii <christopherbii@hyub.org>
Cc: neilb@suse.de, linux-nfs@vger.kernel.org
References: <20250107211122.28305-1-christopherbii@hyub.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250107211122.28305-1-christopherbii@hyub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/7/25 4:11 PM, Christopher Bii wrote:
> Signed-off-by: Christopher Bii <christopherbii@hyub.org>
> ---
>   support/include/nfsd_path.h |   5 +-
>   support/misc/nfsd_path.c    | 255 +++++++++++-------------------------
>   support/nfs/exports.c       |   3 +-
>   3 files changed, 80 insertions(+), 183 deletions(-)
Committed... (tag: nfs-utils-2-8-3-rc2)

steved.

> 
> diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
> index 214bde47..8085ddfd 100644
> --- a/support/include/nfsd_path.h
> +++ b/support/include/nfsd_path.h
> @@ -8,6 +8,7 @@
>   
>   struct file_handle;
>   struct statfs;
> +struct nfsd_task_t;
>   
>   void 		nfsd_path_init(void);
>   
> @@ -23,8 +24,8 @@ int		nfsd_path_statfs(const char *pathname,
>   
>   char *		nfsd_realpath(const char *path, char *resolved_path);
>   
> -ssize_t		nfsd_path_read(int fd, char *buf, size_t len);
> -ssize_t		nfsd_path_write(int fd, const char *buf, size_t len);
> +ssize_t		nfsd_path_read(int fd, void* buf, size_t len);
> +ssize_t		nfsd_path_write(int fd, void* buf, size_t len);
>   
>   int		nfsd_name_to_handle_at(int fd, const char *path,
>   				       struct file_handle *fh,
> diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
> index 0f727d3b..38f0a394 100644
> --- a/support/misc/nfsd_path.c
> +++ b/support/misc/nfsd_path.c
> @@ -19,10 +19,21 @@
>   #include "nfsd_path.h"
>   #include "workqueue.h"
>   
> -static struct xthread_workqueue *nfsd_wq;
> +static struct xthread_workqueue *nfsd_wq = NULL;
>   const char      *rootdir;
>   size_t          rootdir_pathlen = 0;
>   
> +struct nfsd_task_t {
> +        int             ret;
> +        void*           data;
> +};
> +/* Function used to offload tasks that must be ran within the correct
> + * chroot environment.
> + * */
> +static void
> +nfsd_run_task(void (*func)(void*), void* data){
> +        nfsd_wq ? xthread_work_run_sync(nfsd_wq, func, data) : func(data);
> +};
>   
>   const char*
>   nfsd_path_rootdir(void)
> @@ -97,224 +108,119 @@ nfsd_path_init(void)
>   }
>   
>   struct nfsd_stat_data {
> -	const char *pathname;
> -	struct stat *statbuf;
> -	int ret;
> -	int err;
> +	const char      *pathname;
> +	struct stat     *statbuf;
> +        int             (*stat_handler)(const char*, struct stat*);
>   };
>   
>   static void
> -nfsd_statfunc(void *data)
> -{
> -	struct nfsd_stat_data *d = data;
> -
> -	d->ret = xstat(d->pathname, d->statbuf);
> -	if (d->ret < 0)
> -		d->err = errno;
> -}
> -
> -static void
> -nfsd_lstatfunc(void *data)
> +nfsd_handle_stat(void *data)
>   {
> -	struct nfsd_stat_data *d = data;
> -
> -	d->ret = xlstat(d->pathname, d->statbuf);
> -	if (d->ret < 0)
> -		d->err = errno;
> +        struct nfsd_task_t*     t = data;
> +	struct nfsd_stat_data*  d = t->data;
> +        t->ret = d->stat_handler(d->pathname, d->statbuf);
>   }
>   
>   static int
> -nfsd_run_stat(struct xthread_workqueue *wq,
> -		void (*func)(void *),
> -		const char *pathname,
> -		struct stat *statbuf)
> +nfsd_run_stat(const char *pathname,
> +	        struct stat *statbuf,
> +                int (*handler)(const char*, struct stat*))
>   {
> -	struct nfsd_stat_data data = {
> -		pathname,
> -		statbuf,
> -		0,
> -		0
> -	};
> -	xthread_work_run_sync(wq, func, &data);
> -	if (data.ret < 0)
> -		errno = data.err;
> -	return data.ret;
> +        struct nfsd_task_t      t;
> +        struct nfsd_stat_data   d = { pathname, statbuf, handler };
> +        t.data = &d;
> +        nfsd_run_task(nfsd_handle_stat, &t);
> +	return t.ret;
>   }
>   
>   int
>   nfsd_path_stat(const char *pathname, struct stat *statbuf)
>   {
> -	if (!nfsd_wq)
> -		return xstat(pathname, statbuf);
> -	return nfsd_run_stat(nfsd_wq, nfsd_statfunc, pathname, statbuf);
> +        return nfsd_run_stat(pathname, statbuf, stat);
>   }
>   
>   int
> -nfsd_path_lstat(const char *pathname, struct stat *statbuf)
> -{
> -	if (!nfsd_wq)
> -		return xlstat(pathname, statbuf);
> -	return nfsd_run_stat(nfsd_wq, nfsd_lstatfunc, pathname, statbuf);
> -}
> -
> -struct nfsd_statfs_data {
> -	const char *pathname;
> -	struct statfs *statbuf;
> -	int ret;
> -	int err;
> +nfsd_path_lstat(const char* pathname, struct stat* statbuf){
> +        return nfsd_run_stat(pathname, statbuf, lstat);
>   };
>   
> -static void
> -nfsd_statfsfunc(void *data)
> -{
> -	struct nfsd_statfs_data *d = data;
> -
> -	d->ret = statfs(d->pathname, d->statbuf);
> -	if (d->ret < 0)
> -		d->err = errno;
> -}
> -
> -static int
> -nfsd_run_statfs(struct xthread_workqueue *wq,
> -		  const char *pathname,
> -		  struct statfs *statbuf)
> -{
> -	struct nfsd_statfs_data data = {
> -		pathname,
> -		statbuf,
> -		0,
> -		0
> -	};
> -	xthread_work_run_sync(wq, nfsd_statfsfunc, &data);
> -	if (data.ret < 0)
> -		errno = data.err;
> -	return data.ret;
> -}
> -
>   int
> -nfsd_path_statfs(const char *pathname, struct statfs *statbuf)
> +nfsd_path_statfs(const char* pathname, struct statfs* statbuf)
>   {
> -	if (!nfsd_wq)
> -		return statfs(pathname, statbuf);
> -	return nfsd_run_statfs(nfsd_wq, pathname, statbuf);
> -}
> +        return nfsd_run_stat(pathname, (struct stat*)statbuf, (int (*)(const char*, struct stat*))statfs);
> +};
>   
> -struct nfsd_realpath_data {
> -	const char *pathname;
> -	char *resolved;
> -	int err;
> +struct nfsd_realpath_t {
> +        const char*     path;
> +        char*           resolved_buf;
> +        char*           res_ptr;
>   };
>   
>   static void
>   nfsd_realpathfunc(void *data)
>   {
> -	struct nfsd_realpath_data *d = data;
> -
> -	d->resolved = realpath(d->pathname, d->resolved);
> -	if (!d->resolved)
> -		d->err = errno;
> +        struct nfsd_realpath_t *d = data;
> +        d->res_ptr = realpath(d->path, d->resolved_buf);
>   }
>   
> -char *
> -nfsd_realpath(const char *path, char *resolved_path)
> +char*
> +nfsd_realpath(const char *path, char *resolved_buf)
>   {
> -	struct nfsd_realpath_data data = {
> -		path,
> -		resolved_path,
> -		0
> -	};
> -
> -	if (!nfsd_wq)
> -		return realpath(path, resolved_path);
> -
> -	xthread_work_run_sync(nfsd_wq, nfsd_realpathfunc, &data);
> -	if (!data.resolved)
> -		errno = data.err;
> -	return data.resolved;
> +        struct nfsd_realpath_t realpath_buf = {
> +                .path = path,
> +                .resolved_buf = resolved_buf
> +        };
> +        nfsd_run_task(nfsd_realpathfunc, &realpath_buf);
> +        return realpath_buf.res_ptr;
>   }
>   
> -struct nfsd_read_data {
> -	int fd;
> -	char *buf;
> -	size_t len;
> -	ssize_t ret;
> -	int err;
> +struct nfsd_rw_data {
> +	int             fd;
> +	void*           buf;
> +	size_t          len;
> +        ssize_t         bytes_read;
>   };
>   
>   static void
>   nfsd_readfunc(void *data)
>   {
> -	struct nfsd_read_data *d = data;
> -
> -	d->ret = read(d->fd, d->buf, d->len);
> -	if (d->ret < 0)
> -		d->err = errno;
> +        struct nfsd_rw_data* t = (struct nfsd_rw_data*)data;
> +        t->bytes_read = read(t->fd, t->buf, t->len);
>   }
>   
>   static ssize_t
> -nfsd_run_read(struct xthread_workqueue *wq, int fd, char *buf, size_t len)
> +nfsd_run_read(int fd, void* buf, size_t len)
>   {
> -	struct nfsd_read_data data = {
> -		fd,
> -		buf,
> -		len,
> -		0,
> -		0
> -	};
> -	xthread_work_run_sync(wq, nfsd_readfunc, &data);
> -	if (data.ret < 0)
> -		errno = data.err;
> -	return data.ret;
> +        struct nfsd_rw_data d = { .fd = fd, .buf = buf, .len = len };
> +        nfsd_run_task(nfsd_readfunc, &d);
> +	return d.bytes_read;
>   }
>   
>   ssize_t
> -nfsd_path_read(int fd, char *buf, size_t len)
> +nfsd_path_read(int fd, void* buf, size_t len)
>   {
> -	if (!nfsd_wq)
> -		return read(fd, buf, len);
> -	return nfsd_run_read(nfsd_wq, fd, buf, len);
> +	return nfsd_run_read(fd, buf, len);
>   }
>   
> -struct nfsd_write_data {
> -	int fd;
> -	const char *buf;
> -	size_t len;
> -	ssize_t ret;
> -	int err;
> -};
> -
>   static void
>   nfsd_writefunc(void *data)
>   {
> -	struct nfsd_write_data *d = data;
> -
> -	d->ret = write(d->fd, d->buf, d->len);
> -	if (d->ret < 0)
> -		d->err = errno;
> +	struct nfsd_rw_data* d = data;
> +	d->bytes_read = write(d->fd, d->buf, d->len);
>   }
>   
>   static ssize_t
> -nfsd_run_write(struct xthread_workqueue *wq, int fd, const char *buf, size_t len)
> +nfsd_run_write(int fd, void* buf, size_t len)
>   {
> -	struct nfsd_write_data data = {
> -		fd,
> -		buf,
> -		len,
> -		0,
> -		0
> -	};
> -	xthread_work_run_sync(wq, nfsd_writefunc, &data);
> -	if (data.ret < 0)
> -		errno = data.err;
> -	return data.ret;
> +        struct nfsd_rw_data d = { .fd = fd, .buf = buf, .len = len };
> +        nfsd_run_task(nfsd_writefunc, &d);
> +	return d.bytes_read;
>   }
>   
>   ssize_t
> -nfsd_path_write(int fd, const char *buf, size_t len)
> +nfsd_path_write(int fd, void* buf, size_t len)
>   {
> -	if (!nfsd_wq)
> -		return write(fd, buf, len);
> -	return nfsd_run_write(nfsd_wq, fd, buf, len);
> +	return nfsd_run_write(fd, buf, len);
>   }
>   
>   #if defined(HAVE_NAME_TO_HANDLE_AT)
> @@ -325,23 +231,18 @@ struct nfsd_handle_data {
>   	int *mount_id;
>   	int flags;
>   	int ret;
> -	int err;
>   };
>   
>   static void
>   nfsd_name_to_handle_func(void *data)
>   {
>   	struct nfsd_handle_data *d = data;
> -
> -	d->ret = name_to_handle_at(d->fd, d->path,
> -			d->fh, d->mount_id, d->flags);
> -	if (d->ret < 0)
> -		d->err = errno;
> +	d->ret = name_to_handle_at(d->fd, d->path, d->fh, d->mount_id, d->flags);
>   }
>   
>   static int
> -nfsd_run_name_to_handle_at(struct xthread_workqueue *wq,
> -		int fd, const char *path, struct file_handle *fh,
> +nfsd_run_name_to_handle_at(int fd, const char *path,
> +                struct file_handle *fh,
>   		int *mount_id, int flags)
>   {
>   	struct nfsd_handle_data data = {
> @@ -350,25 +251,19 @@ nfsd_run_name_to_handle_at(struct xthread_workqueue *wq,
>   		fh,
>   		mount_id,
>   		flags,
> -		0,
>   		0
>   	};
>   
> -	xthread_work_run_sync(wq, nfsd_name_to_handle_func, &data);
> -	if (data.ret < 0)
> -		errno = data.err;
> +	nfsd_run_task(nfsd_name_to_handle_func, &data);
>   	return data.ret;
>   }
>   
>   int
> -nfsd_name_to_handle_at(int fd, const char *path, struct file_handle *fh,
> +nfsd_name_to_handle_at(int fd, const char *path,
> +                struct file_handle *fh,
>   		int *mount_id, int flags)
>   {
> -	if (!nfsd_wq)
> -		return name_to_handle_at(fd, path, fh, mount_id, flags);
> -
> -	return nfsd_run_name_to_handle_at(nfsd_wq, fd, path, fh,
> -			mount_id, flags);
> +        return nfsd_run_name_to_handle_at(fd, path, fh, mount_id, flags);
>   }
>   #else
>   int
> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
> index a6816e60..21ec6486 100644
> --- a/support/nfs/exports.c
> +++ b/support/nfs/exports.c
> @@ -32,6 +32,7 @@
>   #include "xio.h"
>   #include "pseudoflavors.h"
>   #include "reexport.h"
> +#include "nfsd_path.h"
>   
>   #define EXPORT_DEFAULT_FLAGS	\
>     (NFSEXP_READONLY|NFSEXP_ROOTSQUASH|NFSEXP_GATHERED_WRITES|NFSEXP_NOSUBTREECHECK)
> @@ -200,7 +201,7 @@ getexportent(int fromkernel)
>   		return NULL;
>   	}
>   	/* resolve symlinks */
> -	if (realpath(ee.e_path, rpath) != NULL) {
> +	if (nfsd_realpath(ee.e_path, rpath) != NULL) {
>   		rpath[sizeof (rpath) - 1] = '\0';
>   		strncpy(ee.e_path, rpath, sizeof (ee.e_path) - 1);
>   		ee.e_path[sizeof (ee.e_path) - 1] = '\0';


