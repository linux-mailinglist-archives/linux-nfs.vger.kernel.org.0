Return-Path: <linux-nfs+bounces-8504-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E99EB0F5
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 13:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915D728671C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 12:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E528C1A38F9;
	Tue, 10 Dec 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEt7v5Gp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CEA1A2860
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834274; cv=none; b=ZK5asAM3o80NUjj4QHUSz4M2jZE7cLPqABrpwUEOqTOkC89Ytuv94HFESkZ7GGn1MvwlL2MEFXUCc8CWukFezI7qjthpYyriixIoLQnueXNfnVM2kP6xB5CoZSGgcyzGab1vt7agP2TomitFnkbGuU8zLn+ndo1v88lGStcM6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834274; c=relaxed/simple;
	bh=F6IriTITRrHPQTsd7tgkHuilxXlZ1mTrfKNZ02CuMRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jyq2bLq+cmpjzYgFNx+Oig5opbEPt6edVuW/ANgGMieywOkWHADuagD+bm0xJobcSX+63p+kQk7MH+K4vKsp4wlMQKfgczZN0VZaqfTbdnhN0UTvgNxxXBo37LtGhiEIOgv+dlArhURxpiiRAOeoqrWPTd6l+u5SCPUzK7YXYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEt7v5Gp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733834270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAMAXDfFuAuHc29bNRiouWPdgoG23U2ENuPscy2uiGk=;
	b=hEt7v5Gpj7vyAaA71YqV20xIK2uzHqesdDVL1Mf4AgKkxMZmvxdGnknwuY4kpeo+vn34oc
	eznv2xJ3jOAhRWEu+77yETZ/S1lBIfvnHyx61b7BdqZrn5ieKM8HEpigwFx31Pju1hoH8H
	DRbl2PWJcgUmOEeOEnIXHXQ4lgpFYAQ=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-c_I4Ed4lOTeL3jV03uYDnw-1; Tue, 10 Dec 2024 07:37:49 -0500
X-MC-Unique: c_I4Ed4lOTeL3jV03uYDnw-1
X-Mimecast-MFC-AGG-ID: c_I4Ed4lOTeL3jV03uYDnw
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a814c7d58eso41144435ab.1
        for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 04:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733834267; x=1734439067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAMAXDfFuAuHc29bNRiouWPdgoG23U2ENuPscy2uiGk=;
        b=GVOE1t2EeNR4KYX/QW7X+HuFojIGM/nFrs9uWnReOhZAs8GBR3mH8w9CwkJwqTiVJi
         mSp1L6YV7RWKH/T+blJ8CHbyC1AOKHzmOFQsquh7v58i+deWoO8PiNt5pl4qvdOG6hrU
         KIRRmn7+FJ/7jOc/ukyGg/oHchF9WwKb3nOJcnynmVPPVSx1jGIXpp21kmo872bkNSsC
         a+TXg2MvnYEroPSIFgXyHMJGRMeI/n0n7RfSIySvYD1FO5yWq9LuCU05WS8rVsrchIT1
         Jf+7tHVMsK6x5t8U7G+M6XWYkqToKaut9BP7nXh1JQQ3wIkYEhBNFBZZHDAusnGCIvI6
         RnZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpo4XiEk1bipZCB//+vtfuke3P/wXNrR8118qpELSKmwgaMPe5rCC2MKqjmLKcKlOJbFn5eWUmi7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHczbbCBAk3iGDSas/AX6uzCA8HzSPbmcUwOkpD7350ItZWHhi
	L39jy2T6fHOht9qNTF1gbmfUy2KH6ZWXDsWKvRtt40Arq8ZYLzC2rfr8AKw2c+3SFvDWBof28K5
	wYsejBnT9XoT/+hTGF/+QnmIbmOwFHmxtRwqEsQkAUDfQIa3UJUAuPpWJGxi8inntCg==
X-Gm-Gg: ASbGncsJAu9CEyVw3S8DQU3APGjJtS8z3+tUL0bxCSKywqCJmXan/ie/DL1aCQPqvt+
	6qS9F9nmDdAfw5nUXTuKpGnN3aR6h/vGLqrKOKlpdfmY5VDGOUVGIMK//RuUGWEm81cAjk0Y6mk
	Bs2BmQ0OzhEhbqlTnfaEjynIEu8h/N2Fh2dS320ivIp6q/IZswB53MRXyxABcfeEC0Cptp5uEJY
	A+kpPjXXOVNWJ2zjcHCdbxyW+34125sHYmTBU8wTWw5ILC1Lfe1sA==
X-Received: by 2002:a05:6e02:1527:b0:3a7:85ee:fa78 with SMTP id e9e14a558f8ab-3a9dbb1eb0fmr45170115ab.18.1733834267441;
        Tue, 10 Dec 2024 04:37:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV3dw++yHVZgrrBuTW8j3iyjWxhcuDQCPX7Q1JMbPjQUfkzvabbWMqmTC4H6T/cGqRVw0z8w==
X-Received: by 2002:a05:6e02:1527:b0:3a7:85ee:fa78 with SMTP id e9e14a558f8ab-3a9dbb1eb0fmr45169705ab.18.1733834266671;
        Tue, 10 Dec 2024 04:37:46 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9628ba832sm19736785ab.64.2024.12.10.04.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 04:37:45 -0800 (PST)
Message-ID: <eb4a1148-93cb-437a-a2a9-1271e9a4badc@redhat.com>
Date: Tue, 10 Dec 2024 07:37:43 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mount.nfs4: Add support for nfs://-URLs
To: Roland Mainz <roland.mainz@nrubsig.org>,
 Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20241210122846.821199-1-roland.mainz@nrubsig.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20241210122846.821199-1-roland.mainz@nrubsig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/10/24 7:28 AM, Roland Mainz wrote:
> Add support for RFC 2224-style nfs://-URLs as alternative to the
> traditional hostname:/path+-o port=<tcp-port> notation,
> providing standardised, extensible, single-string, crossplatform,
> portable, Character-Encoding independent (e.g. mount point with
> Japanese, Chinese, French etc. characters) and ASCII-compatible
> descriptions of NFSv4 server resources (exports).
> 
> Reviewed-by: Martin Wege <martin.l.wege@gmail.com>
> Signed-off-by: Marvin Wenzel <marvin.wenzel@rovema.de>
> Signed-off-by: Cedric Blancher <cedric.blancher@gmail.com>
> ---
>   utils/mount/Makefile.am  |   3 +-
>   utils/mount/mount.c      |   3 +
>   utils/mount/nfs4mount.c  |  69 +++++++-
>   utils/mount/nfsmount.c   |  93 ++++++++--
>   utils/mount/parse_dev.c  |  67 ++++++--
>   utils/mount/stropts.c    |  96 ++++++++++-
>   utils/mount/urlparser1.c | 358 +++++++++++++++++++++++++++++++++++++++
>   utils/mount/urlparser1.h |  60 +++++++
>   utils/mount/utils.c      | 155 +++++++++++++++++
>   utils/mount/utils.h      |  23 +++
>   10 files changed, 890 insertions(+), 37 deletions(-)
>   create mode 100644 utils/mount/urlparser1.c
>   create mode 100644 utils/mount/urlparser1.h
I would like to see a man page update explaining how
to use the URLs.

steved.

> 
> diff --git a/utils/mount/Makefile.am b/utils/mount/Makefile.am
> index 83a8ee1c..0e4cab3e 100644
> --- a/utils/mount/Makefile.am
> +++ b/utils/mount/Makefile.am
> @@ -13,7 +13,8 @@ sbin_PROGRAMS	= mount.nfs
>   EXTRA_DIST = nfsmount.conf $(man8_MANS) $(man5_MANS)
>   mount_common = error.c network.c token.c \
>   		    parse_opt.c parse_dev.c \
> -		    nfsmount.c nfs4mount.c stropts.c\
> +		    nfsmount.c nfs4mount.c \
> +		    urlparser1.c urlparser1.h stropts.c \
>   		    mount_constants.h error.h network.h token.h \
>   		    parse_opt.h parse_dev.h \
>   		    nfs4_mount.h stropts.h version.h \
> diff --git a/utils/mount/mount.c b/utils/mount/mount.c
> index b98f9e00..2ce6209d 100644
> --- a/utils/mount/mount.c
> +++ b/utils/mount/mount.c
> @@ -29,6 +29,7 @@
>   #include <string.h>
>   #include <errno.h>
>   #include <fcntl.h>
> +#include <locale.h>
>   #include <sys/mount.h>
>   #include <getopt.h>
>   #include <mntent.h>
> @@ -386,6 +387,8 @@ int main(int argc, char *argv[])
>   	char *extra_opts = NULL, *mount_opts = NULL;
>   	uid_t uid = getuid();
>   
> +	(void)setlocale(LC_ALL, "");
> +
>   	progname = basename(argv[0]);
>   
>   	nfs_mount_data_version = discover_nfs_mount_data_version(&string);
> diff --git a/utils/mount/nfs4mount.c b/utils/mount/nfs4mount.c
> index 0fe142a7..8e4fbf30 100644
> --- a/utils/mount/nfs4mount.c
> +++ b/utils/mount/nfs4mount.c
> @@ -50,8 +50,10 @@
>   #include "mount_constants.h"
>   #include "nfs4_mount.h"
>   #include "nfs_mount.h"
> +#include "urlparser1.h"
>   #include "error.h"
>   #include "network.h"
> +#include "utils.h"
>   
>   #if defined(VAR_LOCK_DIR)
>   #define DEFAULT_DIR VAR_LOCK_DIR
> @@ -182,7 +184,7 @@ int nfs4mount(const char *spec, const char *node, int flags,
>   	int num_flavour = 0;
>   	int ip_addr_in_opts = 0;
>   
> -	char *hostname, *dirname, *old_opts;
> +	char *hostname, *dirname, *mb_dirname = NULL, *old_opts;
>   	char new_opts[1024];
>   	char *opt, *opteq;
>   	char *s;
> @@ -192,15 +194,66 @@ int nfs4mount(const char *spec, const char *node, int flags,
>   	int retry;
>   	int retval = EX_FAIL;
>   	time_t timeout, t;
> +	int nfs_port = NFS_PORT;
> +	parsed_nfs_url pnu;
> +
> +	(void)memset(&pnu, 0, sizeof(parsed_nfs_url));
>   
>   	if (strlen(spec) >= sizeof(hostdir)) {
>   		nfs_error(_("%s: excessively long host:dir argument\n"),
>   				progname);
>   		goto fail;
>   	}
> -	strcpy(hostdir, spec);
> -	if (parse_devname(hostdir, &hostname, &dirname))
> -		goto fail;
> +
> +	/*
> +	 * Support nfs://-URLS per RFC 2224 ("NFS URL
> +	 * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> +	 * including custom port (nfs://hostname@port/path/...)
> +	 * and URL parameter (e.g. nfs://.../?param1=val1&param2=val2
> +	 * support
> +	 */
> +	if (is_spec_nfs_url(spec)) {
> +		if (!mount_parse_nfs_url(spec, &pnu)) {
> +			goto fail;
> +		}
> +
> +		/*
> +		 * |pnu.uctx->path| is in UTF-8, but we need the data
> +		 * in the current local locale's encoding, as mount(2)
> +		 * does not have something like a |MS_UTF8_SPEC| flag
> +		 * to indicate that the input path is in UTF-8,
> +		 * independently of the current locale
> +		 */
> +		hostname = pnu.uctx->hostport.hostname;
> +		dirname = mb_dirname = utf8str2mbstr(pnu.uctx->path);
> +
> +		(void)snprintf(hostdir, sizeof(hostdir), "%s:/%s",
> +			hostname, dirname);
> +		spec = hostdir;
> +
> +		if (pnu.uctx->hostport.port != -1) {
> +			nfs_port = pnu.uctx->hostport.port;
> +		}
> +
> +		/*
> +		 * Values added here based on URL parameters
> +		 * should be added the front of the list of options,
> +		 * so users can override the nfs://-URL given default.
> +		 *
> +		 * FIXME: We do not do that here for |MS_RDONLY|!
> +		 */
> +		if (pnu.mount_params.read_only != TRIS_BOOL_NOT_SET) {
> +			if (pnu.mount_params.read_only)
> +				flags |= MS_RDONLY;
> +			else
> +				flags &= ~MS_RDONLY;
> +		}
> +        } else {
> +		(void)strcpy(hostdir, spec);
> +
> +		if (parse_devname(hostdir, &hostname, &dirname))
> +			goto fail;
> +	}
>   
>   	if (fill_ipv4_sockaddr(hostname, &server_addr))
>   		goto fail;
> @@ -247,7 +300,7 @@ int nfs4mount(const char *spec, const char *node, int flags,
>   	/*
>   	 * NFSv4 specifies that the default port should be 2049
>   	 */
> -	server_addr.sin_port = htons(NFS_PORT);
> +	server_addr.sin_port = htons(nfs_port);
>   
>   	/* parse options */
>   
> @@ -474,8 +527,14 @@ int nfs4mount(const char *spec, const char *node, int flags,
>   		}
>   	}
>   
> +	mount_free_parse_nfs_url(&pnu);
> +	free(mb_dirname);
> +
>   	return EX_SUCCESS;
>   
>   fail:
> +	mount_free_parse_nfs_url(&pnu);
> +	free(mb_dirname);
> +
>   	return retval;
>   }
> diff --git a/utils/mount/nfsmount.c b/utils/mount/nfsmount.c
> index a1c92fe8..e61d718a 100644
> --- a/utils/mount/nfsmount.c
> +++ b/utils/mount/nfsmount.c
> @@ -63,11 +63,13 @@
>   #include "xcommon.h"
>   #include "mount.h"
>   #include "nfs_mount.h"
> +#include "urlparser1.h"
>   #include "mount_constants.h"
>   #include "nls.h"
>   #include "error.h"
>   #include "network.h"
>   #include "version.h"
> +#include "utils.h"
>   
>   #ifdef HAVE_RPCSVC_NFS_PROT_H
>   #include <rpcsvc/nfs_prot.h>
> @@ -493,7 +495,7 @@ nfsmount(const char *spec, const char *node, int flags,
>   	 char **extra_opts, int fake, int running_bg)
>   {
>   	char hostdir[1024];
> -	char *hostname, *dirname, *old_opts, *mounthost = NULL;
> +	char *hostname, *dirname, *mb_dirname = NULL, *old_opts, *mounthost = NULL;
>   	char new_opts[1024], cbuf[1024];
>   	static struct nfs_mount_data data;
>   	int val;
> @@ -521,29 +523,79 @@ nfsmount(const char *spec, const char *node, int flags,
>   	time_t t;
>   	time_t prevt;
>   	time_t timeout;
> +	int nfsurl_port = -1;
> +	parsed_nfs_url pnu;
> +
> +	(void)memset(&pnu, 0, sizeof(parsed_nfs_url));
>   
>   	if (strlen(spec) >= sizeof(hostdir)) {
>   		nfs_error(_("%s: excessively long host:dir argument"),
>   				progname);
>   		goto fail;
>   	}
> -	strcpy(hostdir, spec);
> -	if ((s = strchr(hostdir, ':'))) {
> -		hostname = hostdir;
> -		dirname = s + 1;
> -		*s = '\0';
> -		/* Ignore all but first hostname in replicated mounts
> -		   until they can be fully supported. (mack@sgi.com) */
> -		if ((s = strchr(hostdir, ','))) {
> +
> +	/*
> +	 * Support nfs://-URLS per RFC 2224 ("NFS URL
> +	 * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> +	 * including custom port (nfs://hostname@port/path/...)
> +	 * and URL parameter (e.g. nfs://.../?param1=val1&param2=val2
> +	 * support
> +	 */
> +	if (is_spec_nfs_url(spec)) {
> +		if (!mount_parse_nfs_url(spec, &pnu)) {
> +			goto fail;
> +		}
> +
> +		/*
> +		 * |pnu.uctx->path| is in UTF-8, but we need the data
> +		 * in the current local locale's encoding, as mount(2)
> +		 * does not have something like a |MS_UTF8_SPEC| flag
> +		 * to indicate that the input path is in UTF-8,
> +		 * independently of the current locale
> +		 */
> +		hostname = pnu.uctx->hostport.hostname;
> +		dirname = mb_dirname = utf8str2mbstr(pnu.uctx->path);
> +
> +		(void)snprintf(hostdir, sizeof(hostdir), "%s:/%s",
> +			hostname, dirname);
> +		spec = hostdir;
> +
> +		if (pnu.uctx->hostport.port != -1) {
> +			nfsurl_port = pnu.uctx->hostport.port;
> +		}
> +
> +		/*
> +		 * Values added here based on URL parameters
> +		 * should be added the front of the list of options,
> +		 * so users can override the nfs://-URL given default.
> +		 *
> +		 * FIXME: We do not do that here for |MS_RDONLY|!
> +		 */
> +		if (pnu.mount_params.read_only != TRIS_BOOL_NOT_SET) {
> +			if (pnu.mount_params.read_only)
> +				flags |= MS_RDONLY;
> +			else
> +				flags &= ~MS_RDONLY;
> +		}
> +        } else {
> +		(void)strcpy(hostdir, spec);
> +		if ((s = strchr(hostdir, ':'))) {
> +			hostname = hostdir;
> +			dirname = s + 1;
>   			*s = '\0';
> -			nfs_error(_("%s: warning: "
> -				  "multiple hostnames not supported"),
> +			/* Ignore all but first hostname in replicated mounts
> +			   until they can be fully supported. (mack@sgi.com) */
> +			if ((s = strchr(hostdir, ','))) {
> +				*s = '\0';
> +				nfs_error(_("%s: warning: "
> +					"multiple hostnames not supported"),
>   					progname);
> -		}
> -	} else {
> -		nfs_error(_("%s: directory to mount not in host:dir format"),
> +			}
> +		} else {
> +			nfs_error(_("%s: directory to mount not in host:dir format"),
>   				progname);
> -		goto fail;
> +			goto fail;
> +		}
>   	}
>   
>   	if (!nfs_gethostbyname(hostname, nfs_saddr))
> @@ -579,6 +631,14 @@ nfsmount(const char *spec, const char *node, int flags,
>   	memset(nfs_pmap, 0, sizeof(*nfs_pmap));
>   	nfs_pmap->pm_prog = NFS_PROGRAM;
>   
> +	if (nfsurl_port != -1) {
> +		/*
> +		 * Set custom TCP port defined by a nfs://-URL here,
> +		 * so $ mount -o port ... # can be used to override
> +		 */
> +		nfs_pmap->pm_port = nfsurl_port;
> +	}
> +
>   	/* parse options */
>   	new_opts[0] = 0;
>   	if (!parse_options(old_opts, &data, &bg, &retry, &mnt_server, &nfs_server,
> @@ -863,10 +923,13 @@ noauth_flavors:
>   		}
>   	}
>   
> +	mount_free_parse_nfs_url(&pnu);
> +
>   	return EX_SUCCESS;
>   
>   	/* abort */
>    fail:
> +	mount_free_parse_nfs_url(&pnu);
>   	if (fsock != -1)
>   		close(fsock);
>   	return retval;
> diff --git a/utils/mount/parse_dev.c b/utils/mount/parse_dev.c
> index 2ade5d5d..d9f8cf59 100644
> --- a/utils/mount/parse_dev.c
> +++ b/utils/mount/parse_dev.c
> @@ -27,6 +27,8 @@
>   #include "xcommon.h"
>   #include "nls.h"
>   #include "parse_dev.h"
> +#include "urlparser1.h"
> +#include "utils.h"
>   
>   #ifndef NFS_MAXHOSTNAME
>   #define NFS_MAXHOSTNAME		(255)
> @@ -179,17 +181,62 @@ static int nfs_parse_square_bracket(const char *dev,
>   }
>   
>   /*
> - * RFC 2224 says an NFS client must grok "public file handles" to
> - * support NFS URLs.  Linux doesn't do that yet.  Print a somewhat
> - * helpful error message in this case instead of pressing forward
> - * with the mount request and failing with a cryptic error message
> - * later.
> + * Support nfs://-URLS per RFC 2224 ("NFS URL
> + * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> + * including port support (nfs://hostname@port/path/...)
>    */
> -static int nfs_parse_nfs_url(__attribute__((unused)) const char *dev,
> -			     __attribute__((unused)) char **hostname,
> -			     __attribute__((unused)) char **pathname)
> +static int nfs_parse_nfs_url(const char *dev,
> +			     char **out_hostname,
> +			     char **out_pathname)
>   {
> -	nfs_error(_("%s: NFS URLs are not supported"), progname);
> +	parsed_nfs_url pnu;
> +
> +	if (out_hostname)
> +		*out_hostname = NULL;
> +	if (out_pathname)
> +		*out_pathname = NULL;
> +
> +	/*
> +	 * Support nfs://-URLS per RFC 2224 ("NFS URL
> +	 * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> +	 * including custom port (nfs://hostname@port/path/...)
> +	 * and URL parameter (e.g. nfs://.../?param1=val1&param2=val2
> +	 * support
> +	 */
> +	if (!mount_parse_nfs_url(dev, &pnu)) {
> +		goto fail;
> +	}
> +
> +	if (pnu.uctx->hostport.port != -1) {
> +		/* NOP here, unless we switch from hostname to hostport */
> +	}
> +
> +	if (out_hostname)
> +		*out_hostname = strdup(pnu.uctx->hostport.hostname);
> +	if (out_pathname)
> +		*out_pathname = utf8str2mbstr(pnu.uctx->path);
> +
> +	if (((out_hostname)?(*out_hostname == NULL):0) ||
> +		((out_pathname)?(*out_pathname == NULL):0)) {
> +		nfs_error(_("%s: out of memory"),
> +			progname);
> +		goto fail;
> +	}
> +
> +	mount_free_parse_nfs_url(&pnu);
> +
> +	return 1;
> +
> +fail:
> +	mount_free_parse_nfs_url(&pnu);
> +	if (out_hostname) {
> +		free(*out_hostname);
> +		*out_hostname = NULL;
> +	}
> +	if (out_pathname) {
> +		free(*out_pathname);
> +		*out_pathname = NULL;
> +	}
>   	return 0;
>   }
>   
> @@ -223,7 +270,7 @@ int nfs_parse_devname(const char *devname,
>   		return nfs_pdn_nomem_err();
>   	if (*dev == '[')
>   		result = nfs_parse_square_bracket(dev, hostname, pathname);
> -	else if (strncmp(dev, "nfs://", 6) == 0)
> +	else if (is_spec_nfs_url(dev))
>   		result = nfs_parse_nfs_url(dev, hostname, pathname);
>   	else
>   		result = nfs_parse_simple_hostname(dev, hostname, pathname);
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index 23f0a8c0..ad92ab78 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -42,6 +42,7 @@
>   #include "nls.h"
>   #include "nfsrpc.h"
>   #include "mount_constants.h"
> +#include "urlparser1.h"
>   #include "stropts.h"
>   #include "error.h"
>   #include "network.h"
> @@ -50,6 +51,7 @@
>   #include "parse_dev.h"
>   #include "conffile.h"
>   #include "misc.h"
> +#include "utils.h"
>   
>   #ifndef NFS_PROGRAM
>   #define NFS_PROGRAM	(100003)
> @@ -643,24 +645,106 @@ static int nfs_sys_mount(struct nfsmount_info *mi, struct mount_options *opts)
>   {
>   	char *options = NULL;
>   	int result;
> +	int nfs_port = 2049;
>   
>   	if (mi->fake)
>   		return 1;
>   
> -	if (po_join(opts, &options) == PO_FAILED) {
> -		errno = EIO;
> -		return 0;
> -	}
> +	/*
> +	 * Support nfs://-URLS per RFC 2224 ("NFS URL
> +	 * SCHEME", see https://www.rfc-editor.org/rfc/rfc2224.html),
> +	 * including custom port (nfs://hostname@port/path/...)
> +	 * and URL parameter (e.g. nfs://.../?param1=val1&param2=val2
> +	 * support
> +	 */
> +	if (is_spec_nfs_url(mi->spec)) {
> +		parsed_nfs_url pnu;
> +		char *mb_path;
> +		char mount_source[1024];
> +
> +		if (!mount_parse_nfs_url(mi->spec, &pnu)) {
> +			result = 1;
> +			errno = EINVAL;
> +			goto done;
> +		}
> +
> +		/*
> +		 * |pnu.uctx->path| is in UTF-8, but we need the data
> +		 * in the current local locale's encoding, as mount(2)
> +		 * does not have something like a |MS_UTF8_SPEC| flag
> +		 * to indicate that the input path is in UTF-8,
> +		 * independently of the current locale
> +		 */
> +		mb_path = utf8str2mbstr(pnu.uctx->path);
> +		if (!mb_path) {
> +			nfs_error(_("%s: Could not convert path to local encoding."),
> +				progname);
> +			mount_free_parse_nfs_url(&pnu);
> +			result = 1;
> +			errno = EINVAL;
> +			goto done;
> +		}
> +
> +		(void)snprintf(mount_source, sizeof(mount_source),
> +			"%s:/%s",
> +			pnu.uctx->hostport.hostname,
> +			mb_path);
> +		free(mb_path);
> +
> +		if (pnu.uctx->hostport.port != -1) {
> +			nfs_port = pnu.uctx->hostport.port;
> +		}
>   
> -	result = mount(mi->spec, mi->node, mi->type,
> +		/*
> +		 * Insert "port=" option with the value from the nfs://
> +		 * URL at the beginning of the list of options, so
> +		 * users can override it with $ mount.nfs4 -o port= #,
> +		 * e.g.
> +		 * $ mount.nfs4 -o port=1234 nfs://10.49.202.230:400//bigdisk /mnt4 #
> +		 * should use port 1234, and not port 400 as specified
> +		 * in the URL.
> +		 */
> +		char portoptbuf[5+32+1];
> +		(void)snprintf(portoptbuf, sizeof(portoptbuf), "port=%d", nfs_port);
> +		(void)po_insert(opts, portoptbuf);
> +
> +		if (pnu.mount_params.read_only != TRIS_BOOL_NOT_SET) {
> +			if (pnu.mount_params.read_only)
> +				mi->flags |= MS_RDONLY;
> +			else
> +				mi->flags &= ~MS_RDONLY;
> +		}
> +
> +		mount_free_parse_nfs_url(&pnu);
> +
> +		if (po_join(opts, &options) == PO_FAILED) {
> +			errno = EIO;
> +			result = 1;
> +			goto done;
> +		}
> +
> +		result = mount(mount_source, mi->node, mi->type,
> +			mi->flags & ~(MS_USER|MS_USERS), options);
> +		free(options);
> +	} else {
> +		if (po_join(opts, &options) == PO_FAILED) {
> +			errno = EIO;
> +			result = 1;
> +			goto done;
> +		}
> +
> +		result = mount(mi->spec, mi->node, mi->type,
>   			mi->flags & ~(MS_USER|MS_USERS), options);
> -	free(options);
> +		free(options);
> +	}
>   
>   	if (verbose && result) {
>   		int save = errno;
>   		nfs_error(_("%s: mount(2): %s"), progname, strerror(save));
>   		errno = save;
>   	}
> +
> +done:
>   	return !result;
>   }
>   
> diff --git a/utils/mount/urlparser1.c b/utils/mount/urlparser1.c
> new file mode 100644
> index 00000000..d4c6f339
> --- /dev/null
> +++ b/utils/mount/urlparser1.c
> @@ -0,0 +1,358 @@
> +/*
> + * MIT License
> + *
> + * Copyright (c) 2024 Roland Mainz <roland.mainz@nrubsig.org>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in all
> + * copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + */
> +
> +/* urlparser1.c - simple URL parser */
> +
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <ctype.h>
> +#include <stdio.h>
> +
> +#ifdef DBG_USE_WIDECHAR
> +#include <wchar.h>
> +#include <locale.h>
> +#include <io.h>
> +#include <fcntl.h>
> +#endif /* DBG_USE_WIDECHAR */
> +
> +#include "urlparser1.h"
> +
> +typedef struct _url_parser_context_private {
> +	url_parser_context c;
> +
> +	/* Private data */
> +	char *parameter_string_buff;
> +} url_parser_context_private;
> +
> +#define MAX_URL_PARAMETERS 256
> +
> +/*
> + * Original extended regular expression:
> + *
> + * "^"
> + * "(.+?)"				// scheme
> + * "://"				// '://'
> + * "("					// login
> + *	"(?:"
> + *	"(.+?)"				// user (optional)
> + *		"(?::(.+))?"		// password (optional)
> + *		"@"
> + *	")?"
> + *	"("				// hostport
> + *		"(.+?)"			// host
> + *		"(?::([[:digit:]]+))?"	// port (optional)
> + *	")"
> + * ")"
> + * "(?:/(.*?))?"			// path (optional)
> + * "(?:\?(.*?))?"			// URL parameters (optional)
> + * "$"
> + */
> +
> +#define DBGNULLSTR(s) (((s)!=NULL)?(s):"<NULL>")
> +#if 0 || defined(TEST_URLPARSER)
> +#define D(x) x
> +#else
> +#define D(x)
> +#endif
> +
> +#ifdef DBG_USE_WIDECHAR
> +/*
> + * Use wide-char APIs on WIN32, otherwise we cannot output
> + * Japanese/Chinese/etc correctly
> + */
> +#define DBG_PUTS(str, fp)		fputws(L"" str, (fp))
> +#define DBG_PUTC(c, fp)			fputwc(btowc(c), (fp))
> +#define DBG_PRINTF(fp, fmt, ...)	fwprintf((fp), L"" fmt, __VA_ARGS__)
> +#else
> +#define DBG_PUTS(str, fp)		fputs((str), (fp))
> +#define DBG_PUTC(c, fp)			fputc((c), (fp))
> +#define DBG_PRINTF(fp, fmt, ...)	fprintf((fp), fmt, __VA_ARGS__)
> +#endif /* DBG_USE_WIDECHAR */
> +
> +static
> +void urldecodestr(char *outbuff, const char *buffer, size_t len)
> +{
> +	size_t i, j;
> +
> +	for (i = j = 0 ; i < len ; ) {
> +		switch (buffer[i]) {
> +			case '%':
> +				if ((i + 2) < len) {
> +					if (isxdigit((int)buffer[i+1]) && isxdigit((int)buffer[i+2])) {
> +						const char hexstr[3] = {
> +							buffer[i+1],
> +							buffer[i+2],
> +							'\0'
> +						};
> +						outbuff[j++] = (unsigned char)strtol(hexstr, NULL, 16);
> +						i += 3;
> +					} else {
> +						/* invalid hex digit */
> +						outbuff[j++] = buffer[i];
> +						i++;
> +					}
> +				} else {
> +					/* incomplete hex digit */
> +					outbuff[j++] = buffer[i];
> +					i++;
> +				}
> +				break;
> +			case '+':
> +				outbuff[j++] = ' ';
> +				i++;
> +				break;
> +			default:
> +				outbuff[j++] = buffer[i++];
> +				break;
> +		}
> +	}
> +
> +	outbuff[j] = '\0';
> +}
> +
> +url_parser_context *url_parser_create_context(const char *in_url, unsigned int flags)
> +{
> +	url_parser_context_private *uctx;
> +	char *s;
> +	size_t in_url_len;
> +	size_t context_len;
> +
> +	/* |flags| is for future extensions */
> +	(void)flags;
> +
> +	if (!in_url)
> +		return NULL;
> +
> +	in_url_len = strlen(in_url);
> +
> +	context_len = sizeof(url_parser_context_private) +
> +		((in_url_len+1)*6) +
> +		(sizeof(url_parser_name_value)*MAX_URL_PARAMETERS)+sizeof(void*);
> +	uctx = malloc(context_len);
> +	if (!uctx)
> +		return NULL;
> +
> +	s = (void *)(uctx+1);
> +	uctx->c.in_url = s;		s+= in_url_len+1;
> +	(void)strcpy(uctx->c.in_url, in_url);
> +	uctx->c.scheme = s;		s+= in_url_len+1;
> +	uctx->c.login.username = s;	s+= in_url_len+1;
> +	uctx->c.hostport.hostname = s;	s+= in_url_len+1;
> +	uctx->c.path = s;		s+= in_url_len+1;
> +	uctx->c.hostport.port = -1;
> +	uctx->c.num_parameters = -1;
> +	uctx->c.parameters = (void *)s;		s+= (sizeof(url_parser_name_value)*MAX_URL_PARAMETERS)+sizeof(void*);
> +	uctx->parameter_string_buff = s;	s+= in_url_len+1;
> +
> +	return &uctx->c;
> +}
> +
> +int url_parser_parse(url_parser_context *ctx)
> +{
> +	url_parser_context_private *uctx = (url_parser_context_private *)ctx;
> +
> +	D((void)DBG_PRINTF(stderr, "## parser in_url='%s'\n", uctx->c.in_url));
> +
> +	char *s;
> +	const char *urlstr = uctx->c.in_url;
> +	size_t slen;
> +
> +	s = strstr(urlstr, "://");
> +	if (!s) {
> +		D((void)DBG_PUTS("url_parser: Not an URL\n", stderr));
> +		return -1;
> +	}
> +
> +	slen = s-urlstr;
> +	(void)memcpy(uctx->c.scheme, urlstr, slen);
> +	uctx->c.scheme[slen] = '\0';
> +	urlstr += slen + 3;
> +
> +	D((void)DBG_PRINTF(stdout, "scheme='%s', rest='%s'\n", uctx->c.scheme, urlstr));
> +
> +	s = strstr(urlstr, "@");
> +	if (s) {
> +		/* URL has user/password */
> +		slen = s-urlstr;
> +		urldecodestr(uctx->c.login.username, urlstr, slen);
> +		urlstr += slen + 1;
> +
> +		s = strstr(uctx->c.login.username, ":");
> +		if (s) {
> +			/* found passwd */
> +			uctx->c.login.passwd = s+1;
> +			*s = '\0';
> +		}
> +		else {
> +			uctx->c.login.passwd = NULL;
> +		}
> +
> +		/* catch password-only URLs */
> +		if (uctx->c.login.username[0] == '\0')
> +			uctx->c.login.username = NULL;
> +	}
> +	else {
> +		uctx->c.login.username = NULL;
> +		uctx->c.login.passwd = NULL;
> +	}
> +
> +	D((void)DBG_PRINTF(stdout, "login='%s', passwd='%s', rest='%s'\n",
> +		DBGNULLSTR(uctx->c.login.username),
> +		DBGNULLSTR(uctx->c.login.passwd),
> +		DBGNULLSTR(urlstr)));
> +
> +	char *raw_parameters;
> +
> +	uctx->c.num_parameters = 0;
> +	raw_parameters = strstr(urlstr, "?");
> +	/* Do we have a non-empty parameter string ? */
> +	if (raw_parameters && (raw_parameters[1] != '\0')) {
> +		*raw_parameters++ = '\0';
> +		D((void)DBG_PRINTF(stdout, "raw parameters = '%s'\n", raw_parameters));
> +
> +		char *ps = raw_parameters;
> +		char *pv; /* parameter value */
> +		char *na; /* next '&' */
> +		char *pb = uctx->parameter_string_buff;
> +		char *pname;
> +		char *pvalue;
> +		ssize_t pi;
> +
> +		for (pi = 0; pi < MAX_URL_PARAMETERS ; pi++) {
> +			pname = ps;
> +
> +			/*
> +			 * Handle parameters without value,
> +			 * e.g. "path?name1&name2=value2"
> +			 */
> +			na = strstr(ps, "&");
> +			pv = strstr(ps, "=");
> +			if (pv && (na?(na > pv):true)) {
> +				*pv++ = '\0';
> +				pvalue = pv;
> +				ps = pv;
> +			}
> +			else {
> +				pvalue = NULL;
> +			}
> +
> +			if (na) {
> +				*na++ = '\0';
> +			}
> +
> +			/* URLDecode parameter name */
> +			urldecodestr(pb, pname, strlen(pname));
> +			uctx->c.parameters[pi].name = pb;
> +			pb += strlen(uctx->c.parameters[pi].name)+1;
> +
> +			/* URLDecode parameter value */
> +			if (pvalue) {
> +				urldecodestr(pb, pvalue, strlen(pvalue));
> +				uctx->c.parameters[pi].value = pb;
> +				pb += strlen(uctx->c.parameters[pi].value)+1;
> +			}
> +			else {
> +				uctx->c.parameters[pi].value = NULL;
> +			}
> +
> +			/* Next '&' ? */
> +			if (!na)
> +				break;
> +
> +			ps = na;
> +		}
> +
> +		uctx->c.num_parameters = pi+1;
> +	}
> +
> +	s = strstr(urlstr, "/");
> +	if (s) {
> +		/* URL has hostport */
> +		slen = s-urlstr;
> +		urldecodestr(uctx->c.hostport.hostname, urlstr, slen);
> +		urlstr += slen + 1;
> +
> +		/*
> +		 * check for addresses within '[' and ']', like
> +		 * IPv6 addresses
> +		 */
> +		s = uctx->c.hostport.hostname;
> +		if (s[0] == '[')
> +			s = strstr(s, "]");
> +
> +		if (s == NULL) {
> +			D((void)DBG_PUTS("url_parser: Unmatched '[' in hostname\n", stderr));
> +			return -1;
> +		}
> +
> +		s = strstr(s, ":");
> +		if (s) {
> +			/* found port number */
> +			uctx->c.hostport.port = atoi(s+1);
> +			*s = '\0';
> +		}
> +	}
> +	else {
> +		(void)strcpy(uctx->c.hostport.hostname, urlstr);
> +		uctx->c.path = NULL;
> +		urlstr = NULL;
> +	}
> +
> +	D(
> +		(void)DBG_PRINTF(stdout,
> +			"hostport='%s', port=%d, rest='%s', num_parameters=%d\n",
> +			DBGNULLSTR(uctx->c.hostport.hostname),
> +			uctx->c.hostport.port,
> +			DBGNULLSTR(urlstr),
> +			(int)uctx->c.num_parameters);
> +	);
> +
> +
> +	D(
> +		ssize_t dpi;
> +		for (dpi = 0 ; dpi < uctx->c.num_parameters ; dpi++) {
> +			(void)DBG_PRINTF(stdout,
> +				"param[%d]: name='%s'/value='%s'\n",
> +				(int)dpi,
> +				uctx->c.parameters[dpi].name,
> +				DBGNULLSTR(uctx->c.parameters[dpi].value));
> +		}
> +	);
> +
> +	if (!urlstr) {
> +		goto done;
> +	}
> +
> +	urldecodestr(uctx->c.path, urlstr, strlen(urlstr));
> +	D((void)DBG_PRINTF(stdout, "path='%s'\n", uctx->c.path));
> +
> +done:
> +	return 0;
> +}
> +
> +void url_parser_free_context(url_parser_context *c)
> +{
> +	free(c);
> +}
> diff --git a/utils/mount/urlparser1.h b/utils/mount/urlparser1.h
> new file mode 100644
> index 00000000..515eea9d
> --- /dev/null
> +++ b/utils/mount/urlparser1.h
> @@ -0,0 +1,60 @@
> +/*
> + * MIT License
> + *
> + * Copyright (c) 2024 Roland Mainz <roland.mainz@nrubsig.org>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in all
> + * copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + */
> +
> +/* urlparser1.h - header for simple URL parser */
> +
> +#ifndef __URLPARSER1_H__
> +#define __URLPARSER1_H__ 1
> +
> +#include <stdlib.h>
> +
> +typedef struct _url_parser_name_value {
> +	char *name;
> +	char *value;
> +} url_parser_name_value;
> +
> +typedef struct _url_parser_context {
> +	char *in_url;
> +
> +	char *scheme;
> +	struct {
> +		char *username;
> +		char *passwd;
> +	} login;
> +	struct {
> +		char *hostname;
> +		signed int port;
> +	} hostport;
> +	char *path;
> +
> +	ssize_t num_parameters;
> +	url_parser_name_value *parameters;
> +} url_parser_context;
> +
> +/* Prototypes */
> +url_parser_context *url_parser_create_context(const char *in_url, unsigned int flags);
> +int url_parser_parse(url_parser_context *uctx);
> +void url_parser_free_context(url_parser_context *c);
> +
> +#endif /* !__URLPARSER1_H__ */
> diff --git a/utils/mount/utils.c b/utils/mount/utils.c
> index b7562a47..3d55e997 100644
> --- a/utils/mount/utils.c
> +++ b/utils/mount/utils.c
> @@ -28,6 +28,7 @@
>   #include <unistd.h>
>   #include <sys/types.h>
>   #include <sys/stat.h>
> +#include <iconv.h>
>   
>   #include "sockaddr.h"
>   #include "nfs_mount.h"
> @@ -173,3 +174,157 @@ int nfs_umount23(const char *devname, char *string)
>   	free(dirname);
>   	return result;
>   }
> +
> +/* Convert UTF-8 string to multibyte string in the current locale */
> +char *utf8str2mbstr(const char *utf8_str)
> +{
> +	iconv_t cd;
> +
> +	cd = iconv_open("", "UTF-8");
> +	if (cd == (iconv_t)-1) {
> +		perror("utf8str2mbstr: iconv_open failed");
> +		return NULL;
> +	}
> +
> +	size_t inbytesleft = strlen(utf8_str);
> +	char *inbuf = (char *)utf8_str;
> +	size_t outbytesleft = inbytesleft*4+1;
> +	char *outbuf = malloc(outbytesleft);
> +	char *outbuf_orig = outbuf;
> +
> +	if (!outbuf) {
> +		perror("utf8str2mbstr: out of memory");
> +		(void)iconv_close(cd);
> +		return NULL;
> +	}
> +
> +	int ret = iconv(cd, &inbuf, &inbytesleft, &outbuf, &outbytesleft);
> +	if (ret == -1) {
> +		perror("utf8str2mbstr: iconv() failed");
> +		free(outbuf_orig);
> +		(void)iconv_close(cd);
> +		return NULL;
> +	}
> +
> +	*outbuf = '\0';
> +
> +	(void)iconv_close(cd);
> +	return outbuf_orig;
> +}
> +
> +/* fixme: We should use |bool|! */
> +int is_spec_nfs_url(const char *spec)
> +{
> +	return (!strncmp(spec, "nfs://", 6));
> +}
> +
> +int mount_parse_nfs_url(const char *spec, parsed_nfs_url *pnu)
> +{
> +	int result = 1;
> +	url_parser_context *uctx = NULL;
> +
> +	(void)memset(pnu, 0, sizeof(parsed_nfs_url));
> +	pnu->mount_params.read_only = TRIS_BOOL_NOT_SET;
> +
> +	uctx = url_parser_create_context(spec, 0);
> +	if (!uctx) {
> +		nfs_error(_("%s: out of memory"),
> +			progname);
> +		result = 1;
> +		goto done;
> +	}
> +
> +	if (url_parser_parse(uctx) < 0) {
> +		nfs_error(_("%s: Error parsing nfs://-URL."),
> +			progname);
> +		result = 1;
> +		goto done;
> +	}
> +	if (uctx->login.username || uctx->login.passwd) {
> +		nfs_error(_("%s: Username/Password are not defined for nfs://-URL."),
> +			progname);
> +		result = 1;
> +		goto done;
> +	}
> +	if (!uctx->path) {
> +		nfs_error(_("%s: Path missing in nfs://-URL."),
> +			progname);
> +		result = 1;
> +		goto done;
> +	}
> +	if (uctx->path[0] != '/') {
> +		nfs_error(_("%s: Relative nfs://-URLs are not supported."),
> +			progname);
> +		result = 1;
> +		goto done;
> +	}
> +
> +	if (uctx->num_parameters > 0) {
> +		int pi;
> +		const char *pname;
> +		const char *pvalue;
> +
> +		/*
> +		 * Values added here based on URL parameters
> +		 * should be added the front of the list of options,
> +		 * so users can override the nfs://-URL given default.
> +		 */
> +		for (pi = 0; pi < uctx->num_parameters ; pi++) {
> +			pname = uctx->parameters[pi].name;
> +			pvalue = uctx->parameters[pi].value;
> +
> +			if (!strcmp(pname, "rw")) {
> +				if ((pvalue == NULL) || (!strcmp(pvalue, "1"))) {
> +					pnu->mount_params.read_only = TRIS_BOOL_FALSE;
> +				}
> +				else if (!strcmp(pvalue, "0")) {
> +					pnu->mount_params.read_only = TRIS_BOOL_TRUE;
> +				}
> +				else {
> +					nfs_error(_("%s: Unsupported nfs://-URL "
> +						"parameter '%s' value '%s'."),
> +						progname, pname, pvalue);
> +					result = 1;
> +					goto done;
> +				}
> +			}
> +			else if (!strcmp(pname, "ro")) {
> +				if ((pvalue == NULL) || (!strcmp(pvalue, "1"))) {
> +					pnu->mount_params.read_only = TRIS_BOOL_TRUE;
> +				}
> +				else if (!strcmp(pvalue, "0")) {
> +					pnu->mount_params.read_only = TRIS_BOOL_FALSE;
> +				}
> +				else {
> +					nfs_error(_("%s: Unsupported nfs://-URL "
> +						"parameter '%s' value '%s'."),
> +						progname, pname, pvalue);
> +					result = 1;
> +					goto done;
> +				}
> +			}
> +			else {
> +				nfs_error(_("%s: Unsupported nfs://-URL "
> +						"parameter '%s'."),
> +					progname, pname);
> +				result = 1;
> +				goto done;
> +			}
> +		}
> +	}
> +
> +	result = 0;
> +done:
> +	if (result != 0) {
> +		url_parser_free_context(uctx);
> +		return 0;
> +	}
> +
> +	pnu->uctx = uctx;
> +	return 1;
> +}
> +
> +void mount_free_parse_nfs_url(parsed_nfs_url *pnu)
> +{
> +	url_parser_free_context(pnu->uctx);
> +}
> diff --git a/utils/mount/utils.h b/utils/mount/utils.h
> index 224918ae..465c0a5e 100644
> --- a/utils/mount/utils.h
> +++ b/utils/mount/utils.h
> @@ -24,13 +24,36 @@
>   #define _NFS_UTILS_MOUNT_UTILS_H
>   
>   #include "parse_opt.h"
> +#include "urlparser1.h"
>   
> +/* Boolean with three states: { not_set, false, true */
> +typedef signed char tristate_bool;
> +#define TRIS_BOOL_NOT_SET (-1)
> +#define TRIS_BOOL_TRUE (1)
> +#define TRIS_BOOL_FALSE (0)
> +
> +#define TRIS_BOOL_GET_VAL(tsb, tsb_default) \
> +	(((tsb)!=TRIS_BOOL_NOT_SET)?(tsb):(tsb_default))
> +
> +typedef struct _parsed_nfs_url {
> +	url_parser_context *uctx;
> +	struct {
> +		tristate_bool read_only;
> +	} mount_params;
> +} parsed_nfs_url;
> +
> +/* Prototypes */
>   int discover_nfs_mount_data_version(int *string_ver);
>   void print_one(char *spec, char *node, char *type, char *opts);
>   void mount_usage(void);
>   void umount_usage(void);
>   int chk_mountpoint(const char *mount_point);
> +char *utf8str2mbstr(const char *utf8_str);
> +int is_spec_nfs_url(const char *spec);
>   
>   int nfs_umount23(const char *devname, char *string);
>   
> +int mount_parse_nfs_url(const char *spec, parsed_nfs_url *pnu);
> +void mount_free_parse_nfs_url(parsed_nfs_url *pnu);
> +
>   #endif	/* !_NFS_UTILS_MOUNT_UTILS_H */


