Return-Path: <linux-nfs+bounces-6575-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F46E97D8F6
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 19:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2C128578C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 17:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73DA1C6BE;
	Fri, 20 Sep 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfDH0dbB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876DC1EF1D
	for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726852717; cv=none; b=MmImjBdNkFrjRGZYucIYokF+31ZU5U1o59eBw33T1xyCNSpKjLQ+TlLPrvU/ZEO8GHQb1Py6UgIbygqNkWCiRhh/ndU37Er54NXdl4uiUtLQQsCwkNnGb6j1eFe6ys1D4QNv4gHKgIhBmCB/XfNDaLebVPHeuFyPdBct5fmmO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726852717; c=relaxed/simple;
	bh=M5tXfKM9B7kJVbwrJzcOf98jgmmGTWhuv3wYpL3PKTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IA/mOeqt9Zs4n/2v8f5v2klaKg00Xzq8vEwZwIMpIgZjD5yZnvEEsJuXjIJ2PKA8o+fdN1eJirC71MY1Q52udE4JBCp2Rhuh18GMxLA8X8BnlnR45HXNje0j5QPZvlYdLFYOIGWoReDtPjK5kKCpBBkQtBmn9GsXc2o8OvcuYLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VfDH0dbB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726852714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGGHmQwiWpu+HmZYv09jQnRpWdvbWMnkU38HmdUfDl0=;
	b=VfDH0dbB1ImsG6ybCp+eyMWcOWk7iCvLciiZqDCvLRky46Ra+OcmgZuYi+UNB+32XYq7Rn
	0jSbosLKlgojooaxAHkYQ51c/RcjBkDpV8RtTXZaNV8wKFGkTYDIqVMduZG3mxLceP+37x
	jh3e7nnBp2/JXcOWW0BvJVkjxS4bIYc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-8Yc25PHjOTeoJ66PJaTJwg-1; Fri, 20 Sep 2024 13:18:33 -0400
X-MC-Unique: 8Yc25PHjOTeoJ66PJaTJwg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6c75e39b14dso42565856d6.1
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 10:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726852712; x=1727457512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGGHmQwiWpu+HmZYv09jQnRpWdvbWMnkU38HmdUfDl0=;
        b=xEERVuEANSQ/YwpeJfpHGAyhzogUNKY9RDqsEOiEx2G/U2rRpyGbApJUmDAn1dX21h
         mXwpx6VzV9SA2dVUsAafAe7K3DCsP9dlF+LyEjADx6V+PwNEoixhn+VnCccPNgG4O6Wo
         6pU2V8UWK4RJ+2yJBGhzDLbdfzMT05e86ygPcoL1eR6gOrK+f9mtJUzU9yQmNN2Amwur
         2zOHVfhgNCPmQqmae8v1jQA0YZB10qsHkzle04XwdEcsh4f1Sy9EbI/2Ka5Y6EnIXoTY
         GZsCH2zA/bj7TVJgeczLmzgoZMlk23zxOn/w5qXiZR/P83/4ZM4SJfex7XymEtS6eSH+
         /+9A==
X-Gm-Message-State: AOJu0YxksRmIWx6e56o/bimbLRM1x1T4feuNR8KIQq7Ma9tD+oCkKjTC
	B//jnh+Jk6Cm1i5Y0oKY21GWeLY/RvhvRodDUD8bYHGFCRsTKUAB/fRq0JlQODaUubZ10uZsPyM
	WSoQudoGO4YTlUv1Jv5VMiEOv5+XosYIK3k2TRjL87P5tS9GiBESAGf87PA==
X-Received: by 2002:a05:6214:53c9:b0:6c3:6560:af09 with SMTP id 6a1803df08f44-6c7bb7448d4mr62618246d6.0.1726852712497;
        Fri, 20 Sep 2024 10:18:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaDRhcvactpwqkcZVpKFrDxacMUSa9gW0qAA0IlvlFJVF89E2AltZ7GZgBFlc6a2HO6XcmEA==
X-Received: by 2002:a05:6214:53c9:b0:6c3:6560:af09 with SMTP id 6a1803df08f44-6c7bb7448d4mr62617916d6.0.1726852712089;
        Fri, 20 Sep 2024 10:18:32 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.241.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e57b4d7sm20042146d6.130.2024.09.20.10.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 10:18:31 -0700 (PDT)
Message-ID: <5e15780b-4225-4a16-966b-dd0beccd9faf@redhat.com>
Date: Fri, 20 Sep 2024 13:18:30 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mount.nfs: improve EPROTO error message for RDMA mounts
To: Dan Aloni <dan.aloni@vastdata.com>
Cc: linux-nfs@vger.kernel.org
References: <20240919151015.536917-1-dan.aloni@vastdata.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240919151015.536917-1-dan.aloni@vastdata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/24 11:10 AM, Dan Aloni wrote:
> When mounting NFS shares using RDMA, users may encounter this rather
> unclear error message:
> 
>      mount.nfs: Protocol error
> 
> Often there are either no RDMA interfaces existing, or that routing is
> being done via other interfaces. This patch enhances the `mount_error`
> function to provide a more informative message in such cases.
> 
> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
Committed... (tag: nfs-utils-2-7-2-rc1)

steved.

> ---
>   utils/mount/error.c     | 12 +++++++++++-
>   utils/mount/error.h     |  4 +++-
>   utils/mount/network.c   |  2 +-
>   utils/mount/network.h   |  2 ++
>   utils/mount/nfs4mount.c |  2 +-
>   utils/mount/nfsmount.c  |  2 +-
>   utils/mount/stropts.c   |  8 ++++----
>   utils/mount/utils.c     |  6 +++---
>   8 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/utils/mount/error.c b/utils/mount/error.c
> index 9ddbcc096f72..d6cbdea1933b 100644
> --- a/utils/mount/error.c
> +++ b/utils/mount/error.c
> @@ -40,6 +40,7 @@
>   #include "nls.h"
>   #include "mount.h"
>   #include "error.h"
> +#include "network.h"
>   
>   #ifdef HAVE_RPCSVC_NFS_PROT_H
>   #include <rpcsvc/nfs_prot.h>
> @@ -199,7 +200,8 @@ void sys_mount_errors(char *server, int error, int will_retry, int bg)
>    * @error: errno value to report
>    *
>    */
> -void mount_error(const char *spec, const char *mount_point, int error)
> +void mount_error(const char *spec, const char *mount_point, int error,
> +		 struct mount_options *options)
>   {
>   	switch(error) {
>   	case EACCES:
> @@ -250,6 +252,14 @@ void mount_error(const char *spec, const char *mount_point, int error)
>   	case EALREADY:
>   		/* Error message has already been provided */
>   		break;
> +	case EPROTO:
> +		if (options && po_rightmost(options, nfs_transport_opttbl) == 2)
> +			nfs_error(_("%s: %s: is routing being done via an interface supporting RDMA?"),
> +				  progname, strerror(error));
> +		else
> +			nfs_error(_("%s: %s"),
> +				  progname, strerror(error));
> +		break;
>   	default:
>   		nfs_error(_("%s: %s for %s on %s"),
>   			  progname, strerror(error), spec, mount_point);
> diff --git a/utils/mount/error.h b/utils/mount/error.h
> index ef80fd079b48..f9f282233563 100644
> --- a/utils/mount/error.h
> +++ b/utils/mount/error.h
> @@ -24,9 +24,11 @@
>   #ifndef _NFS_UTILS_MOUNT_ERROR_H
>   #define _NFS_UTILS_MOUNT_ERROR_H
>   
> +#include "parse_opt.h"
> +
>   char *nfs_strerror(unsigned int);
>   
> -void mount_error(const char *, const char *, int);
> +void mount_error(const char *, const char *, int, struct mount_options *);
>   void rpc_mount_errors(char *, int, int);
>   void sys_mount_errors(char *, int, int, int);
>   
> diff --git a/utils/mount/network.c b/utils/mount/network.c
> index 01ead49f0008..64293f6f8d51 100644
> --- a/utils/mount/network.c
> +++ b/utils/mount/network.c
> @@ -88,7 +88,7 @@ static const char *nfs_nfs_pgmtbl[] = {
>   	NULL,
>   };
>   
> -static const char *nfs_transport_opttbl[] = {
> +const char *nfs_transport_opttbl[] = {
>   	"udp",
>   	"tcp",
>   	"rdma",
> diff --git a/utils/mount/network.h b/utils/mount/network.h
> index 0fc98acd4bcb..26f4eec775df 100644
> --- a/utils/mount/network.h
> +++ b/utils/mount/network.h
> @@ -93,4 +93,6 @@ void mnt_closeclnt(CLIENT *, int);
>   int nfs_umount_do_umnt(struct mount_options *options,
>   		       char **hostname, char **dirname);
>   
> +extern const char *nfs_transport_opttbl[];
> +
>   #endif	/* _NFS_UTILS_MOUNT_NETWORK_H */
> diff --git a/utils/mount/nfs4mount.c b/utils/mount/nfs4mount.c
> index 3e4f1e255ca7..0fe142a7843e 100644
> --- a/utils/mount/nfs4mount.c
> +++ b/utils/mount/nfs4mount.c
> @@ -469,7 +469,7 @@ int nfs4mount(const char *spec, const char *node, int flags,
>   	if (!fake) {
>   		if (mount(spec, node, "nfs4",
>   				flags & ~(MS_USER|MS_USERS), &data)) {
> -			mount_error(spec, node, errno);
> +			mount_error(spec, node, errno, NULL);
>   			goto fail;
>   		}
>   	}
> diff --git a/utils/mount/nfsmount.c b/utils/mount/nfsmount.c
> index 3d95da9456de..a1c92fe83fa0 100644
> --- a/utils/mount/nfsmount.c
> +++ b/utils/mount/nfsmount.c
> @@ -858,7 +858,7 @@ noauth_flavors:
>   	if (!fake) {
>   		if (mount(spec, node, "nfs",
>   				flags & ~(MS_USER|MS_USERS), &data)) {
> -			mount_error(spec, node, errno);
> +			mount_error(spec, node, errno, NULL);
>   			goto fail;
>   		}
>   	}
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index a92c420011a4..2d5fa1f2e86e 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -1143,7 +1143,7 @@ static int nfsmount_fg(struct nfsmount_info *mi)
>   		}
>   	}
>   
> -	mount_error(mi->spec, mi->node, errno);
> +	mount_error(mi->spec, mi->node, errno, mi->options);
>   	return EX_FAIL;
>   }
>   
> @@ -1160,7 +1160,7 @@ static int nfsmount_parent(struct nfsmount_info *mi)
>   		return EX_SUCCESS;
>   
>   	if (nfs_is_permanent_error(errno)) {
> -		mount_error(mi->spec, mi->node, errno);
> +		mount_error(mi->spec, mi->node, errno, mi->options);
>   		return EX_FAIL;
>   	}
>   
> @@ -1237,7 +1237,7 @@ static int nfs_remount(struct nfsmount_info *mi)
>   {
>   	if (nfs_sys_mount(mi, mi->options))
>   		return EX_SUCCESS;
> -	mount_error(mi->spec, mi->node, errno);
> +	mount_error(mi->spec, mi->node, errno, mi->options);
>   	return EX_FAIL;
>   }
>   
> @@ -1261,7 +1261,7 @@ static int nfsmount_start(struct nfsmount_info *mi)
>   	 * NFS v2 has been deprecated
>   	 */
>   	if (mi->version.major == 2) {
> -		mount_error(mi->spec, mi->node, EOPNOTSUPP);
> +		mount_error(mi->spec, mi->node, EOPNOTSUPP, mi->options);
>   		return EX_FAIL;
>   	}
>   
> diff --git a/utils/mount/utils.c b/utils/mount/utils.c
> index 865a4a05f3fc..b7562a474f88 100644
> --- a/utils/mount/utils.c
> +++ b/utils/mount/utils.c
> @@ -123,15 +123,15 @@ int chk_mountpoint(const char *mount_point)
>   	struct stat sb;
>   
>   	if (stat(mount_point, &sb) < 0){
> -		mount_error(NULL, mount_point, errno);
> +		mount_error(NULL, mount_point, errno, NULL);
>   		return 1;
>   	}
>   	if (S_ISDIR(sb.st_mode) == 0){
> -		mount_error(NULL, mount_point, ENOTDIR);
> +		mount_error(NULL, mount_point, ENOTDIR, NULL);
>   		return 1;
>   	}
>   	if (getuid() != 0 && geteuid() != 0 && access(mount_point, X_OK) < 0) {
> -		mount_error(NULL, mount_point, errno);
> +		mount_error(NULL, mount_point, errno, NULL);
>   		return 1;
>   	}
>   


