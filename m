Return-Path: <linux-nfs+bounces-12127-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0931ACEE20
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 12:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD85C3A1A11
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 10:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E123C17;
	Thu,  5 Jun 2025 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijEk0eSM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2320E031
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120827; cv=none; b=k3WTFA80IDcJ7iNxGQt9cDIIOMTiF44NEWL5IxLkR54ydPFqK01WIWAY2xFu1S1VciVve4GiuuPO51OMUNPG8TSSVNnO2Z3WVsmckkFJMP9ayX9GMLST2KeQH3Evdxjg/uECtSUsVUXPnp0gYMxb7tAb8O7WmsM8vJo314EdnOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120827; c=relaxed/simple;
	bh=9puZ0ZhwXI5JCQTpbEus9rSoP82urKkvbN4MkKCVPiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nLqpqNkzgsSogBAroqnUB8l+/OMiat2+E5tMzi0L74gcPEnxRa2AsgD/ZUb0xgT1ieVvNeTssNRsLnrcWUG90g89s7b/3wuKwNQoED6L7wyxUHGNktjOBtr+XdOLrOPiqTeCgHcttEd267YrnJL81BzKaHWSSMn1zfhq5owMT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijEk0eSM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749120823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgqCUXto8iILe4ttn1BtFmXWvz7pMe3sZgRUwWjJxJE=;
	b=ijEk0eSMnjuxIEBhK7EoWkQLkn6o2Ri+A7g5BR+G6J3LBZZovcprfsSk6HbIcVYnmh385s
	3mtcgFUllz8eieaOrshsyqPpKHxvE5Gu2BjkE12vC48CrDn8HVJmPhPMBP67chnhj4WSGd
	n+z18jfrDr41z/ybuvGf+OGUTfzhsE0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-LKLxTHdSODuNCaGDKw7ulw-1; Thu, 05 Jun 2025 06:53:42 -0400
X-MC-Unique: LKLxTHdSODuNCaGDKw7ulw-1
X-Mimecast-MFC-AGG-ID: LKLxTHdSODuNCaGDKw7ulw_1749120822
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7caee990715so218581585a.3
        for <linux-nfs@vger.kernel.org>; Thu, 05 Jun 2025 03:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120822; x=1749725622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgqCUXto8iILe4ttn1BtFmXWvz7pMe3sZgRUwWjJxJE=;
        b=rIw6H8s4rskbFUyriPGOWSR/nVU6D2ZINTfK9jaa1adcd5QUwXkLCus02f8PqgjZv2
         XSgi+wBSi7MN9jRs4/gOq36/Z8JuS7zmfB23lSgZxR3BAjp0tdmJfck5Fu/b23K18tiP
         D/bt5koj7GdvC7RjHOE+0OHpqK6dsWRQOQIUfT7+C7WS1whe9Wx8tVyzt95u9LQebM7j
         TK8rF93TYg7tv0ceQh9Ephc+fQKyV1BP8N64ErpNEu32rRPESRJfx78xuEU5owNq97WM
         W/3ZFnGYrHOVXMdx/xo3bf911BoA7ix74OT+dJsXx4nQZavCMVfMKuOo7EJRexsC9SbF
         M+qw==
X-Forwarded-Encrypted: i=1; AJvYcCXaquiaFvyc1MhB7fstTsnWT6+ncGK1laPFZt7BpcOaf6VDYxDAYGaau9txjHfOi++d5rc0DB/pLrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWisyqxespT8DGC7uK3TvVFKeDahV/4QQRdS4GmSFA/C+Pab/I
	sAJ8y1GlKDdFHzULiFqWV6ZXFyFN/1Q1dqDbrXFH4FPycefWM21xrIhzhOpHXtKjGXwIJ0pSBwN
	g0Undu7nXncnxE1gJwy2nZSFoPb/wak464GUcWV9Vv89SByQzDWnhLEst5FBDIA==
X-Gm-Gg: ASbGncs7XqdAh1Rd8kQZ5FZa+PqpopxnYPt90l46Wx8JCHPtbLj78i21Bfck5+0EQsq
	cWmYlUTCoCHYTpPysMtkaIfJU9aMKmRScKqXtOAKvAsvUlCIiiJiyExQuHlCYJOe8EwFPrzTGie
	I+znm5w2YIlDtHUIDQT6PLWAWO0OA7Rm4xbWYOmiekklfPh8RYvt+cfYqxXS+RKRBuPNUjhoiz3
	GQsgMsEpgeec6vvV9zqNAF/GiRVBJQJ0K/fr7XBQWGYMuqB2Xud/88fx3bad9N34u2IsMdYImU2
	E3ToQp3pYHA=
X-Received: by 2002:a05:620a:370f:b0:7ce:f5c6:e48 with SMTP id af79cd13be357-7d21989393amr1017211185a.21.1749120821914;
        Thu, 05 Jun 2025 03:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRrYUWbbehPvdOqle77UEZ5wIM2AaEJ7uP4n+JNzZBA1mwSiu5kgPzIc1e0RW0AL9/HwESjA==
X-Received: by 2002:a05:620a:370f:b0:7ce:f5c6:e48 with SMTP id af79cd13be357-7d21989393amr1017208385a.21.1749120821477;
        Thu, 05 Jun 2025 03:53:41 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.242.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a19548dsm1233305185a.67.2025.06.05.03.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:53:40 -0700 (PDT)
Message-ID: <87cb8ba6-39f0-45ec-96a2-f0cfa6ff0602@redhat.com>
Date: Thu, 5 Jun 2025 06:53:39 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] systemd: Add a generator to mount /sysroot via NFSv4
 in the initrd
To: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>,
 linux-nfs@vger.kernel.org
References: <cover.1747753109.git.antonio.feijoo@suse.com>
 <6cb1a43a10841aded94efcdb2ab4f2c2ed8450f2.1747753109.git.antonio.feijoo@suse.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <6cb1a43a10841aded94efcdb2ab4f2c2ed8450f2.1747753109.git.antonio.feijoo@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/22/25 2:59 AM, Antonio Alvarez Feijoo wrote:
> This patch adds the nfsroot-generator to parse the following kernel
> command line options in the initrd:
> 
> - root=/dev/nfs nfsroot=[<server>:]<path>[,<options>]
> 
>    Defined in <kernel_source>/Documentation/admin-guide/nfs/nfsroot.rst
> 
> - root=nfs[4]:[<server>:]<path>[:<options>]
> 
>    Defined in dracut.cmdline(7).
> 
> Since systemd does not create the sysroot.mount unit when nfsroot is
> requested [1], this generator can create it so the real root will be
> mounted in /sysroot, and also add the dependency to
> initrd-root-fs.target to automatically continue the boot process.
> 
> [1] https://github.com/systemd/systemd/commit/77b8e92de8264c0b656a7d2fb437dd8d598ab597
> 
> Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Committed... (tag: nfs-utils-2-8-4-rc2)

steved.
> ---
>   .gitignore                  |   1 +
>   systemd/Makefile.am         |   8 +-
>   systemd/nfs.systemd.man     |  62 +++++++--
>   systemd/nfsroot-generator.c | 243 ++++++++++++++++++++++++++++++++++++
>   systemd/systemd.c           |  16 ++-
>   systemd/systemd.h           |   1 +
>   6 files changed, 320 insertions(+), 11 deletions(-)
>   create mode 100644 systemd/nfsroot-generator.c
> 
> diff --git a/.gitignore b/.gitignore
> index 08ce7cdf..622134bb 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -80,6 +80,7 @@ tests/nsm_client/nlm_sm_inter_svc.c
>   tests/nsm_client/nlm_sm_inter_xdr.c
>   utils/nfsidmap/nfsidmap
>   utils/nfsref/nfsref
> +systemd/nfsroot-generator
>   systemd/nfs-server-generator
>   systemd/rpc-pipefs-generator
>   systemd/nfs-config.service
> diff --git a/systemd/Makefile.am b/systemd/Makefile.am
> index b4483222..5e481421 100644
> --- a/systemd/Makefile.am
> +++ b/systemd/Makefile.am
> @@ -59,15 +59,19 @@ EXTRA_DIST = $(unit_files) $(udev_files) $(man5_MANS) $(man7_MANS)
>   
>   generator_dir = $(unitdir)/../system-generators
>   
> -EXTRA_PROGRAMS	= nfs-server-generator rpc-pipefs-generator
> +EXTRA_PROGRAMS	= nfsroot-generator nfs-server-generator rpc-pipefs-generator
>   genexecdir = $(generator_dir)
>   
>   COMMON_SRCS = systemd.c systemd.h
>   
> +nfsroot_generator_SOURCES = $(COMMON_SRCS) nfsroot-generator.c
> +
>   nfs_server_generator_SOURCES = $(COMMON_SRCS) nfs-server-generator.c
>   
>   rpc_pipefs_generator_SOURCES = $(COMMON_SRCS) rpc-pipefs-generator.c
>   
> +nfsroot_generator_LDADD = ../support/nfs/libnfs.la
> +
>   nfs_server_generator_LDADD = ../support/export/libexport.a \
>   			     ../support/nfs/libnfs.la \
>   			     ../support/misc/libmisc.a \
> @@ -78,7 +82,7 @@ nfs_server_generator_LDADD = ../support/export/libexport.a \
>   rpc_pipefs_generator_LDADD = ../support/nfs/libnfs.la
>   
>   if INSTALL_SYSTEMD
> -genexec_PROGRAMS = nfs-server-generator rpc-pipefs-generator
> +genexec_PROGRAMS = nfsroot-generator nfs-server-generator rpc-pipefs-generator
>   install-data-hook: $(unit_files) $(udev_files)
>   	mkdir -p $(DESTDIR)/$(unitdir)
>   	cp $(unit_files) $(DESTDIR)/$(unitdir)
> diff --git a/systemd/nfs.systemd.man b/systemd/nfs.systemd.man
> index f49e7776..a8476038 100644
> --- a/systemd/nfs.systemd.man
> +++ b/systemd/nfs.systemd.man
> @@ -14,13 +14,13 @@ The
>   .I nfs-utils
>   package provides a suite of
>   .I systemd
> -unit files which allow the various services to be started and
> -managed.  These unit files ensure that the services are started in the
> -correct order, and the prerequisites are active before dependant
> -services start.  As there are quite  few unit files, it is not
> -immediately obvious how best to achieve certain results.  The
> -following subsections attempt to cover the issues that are most likely
> -to come up.
> +unit files and generators which allow the various services to be
> +started and managed.  These unit files and generators ensure that the
> +services are started in the correct order, and the prerequisites are
> +active before dependant services start.  As there are quite a few unit
> +files and generators, it is not immediately obvious how best to achieve
> +certain results.  The following subsections attempt to cover the issues
> +that are most likely to come up.
>   .SS Configuration
>   The standard systemd unit files do not provide any easy way to pass
>   any command line arguments to daemons so as to configure their
> @@ -166,6 +166,52 @@ file is present.  If a site needs this file present but does not want
>   running, it can be masked with
>   .RS
>   .B systemctl mask rpc-gssd
> +.SS Generators
> +systemd unit generators are small executables placed in
> +.I /usr/lib/systemd/system-generators/
> +to dynamically extend the unit file hierarchy.  The
> +.I nfs-utils
> +package provides three:
> +.TP
> +.B nfsroot-generator
> +It creates the
> +.B sysroot.mount
> +unit to mount /sysroot via NFSv4 in the initrd, if it detects one the
> +following options in the kernel command line:
> +.PP
> +.RS
> +.B root=/dev/nfs nfsroot=[<server>:]<path>[,<options>]
> +.PP
> +.RS
> +Defined in
> +.I <kernel_source>/Documentation/admin-guide/nfs/nfsroot.rst
> +.RE
> +.RE
> +.PP
> +.RS
> +.B root=nfs[4]:[<server>:]<path>[:<options>]
> +.PP
> +.RS
> +Defined in
> +.BR dracut.cmdline (7).
> +.PP
> +.B NOTE:
> +Although "nfs" can be used as type indicator for the mountpoint, the
> +mount unit will use always "nfs4".
> +.RE
> +.RE
> +.TP
> +.B nfs-server-generator
> +It creates ordering dependencies between
> +.I nfs-server.service
> +and various filesystem mounts: it should start before any "nfs"
> +mountpoints are mounted, in case they are loop-back mounts, and after
> +all exported filesystems are mounted, so there is no risk of exporting
> +the underlying directory.
> +.TP
> +.B rpc-pipefs-generator
> +It creates ordering dependencies between NFS services and the
> +rpc_pipefs mountpoint.
>   .RE
>   .SH FILES
>   /etc/nfs.conf
> @@ -180,6 +226,8 @@ and in related
>   .I conf.d
>   drop-in directories.
>   .SH SEE ALSO
> +.BR bootup (7),
> +.BR systemd.generator (7),
>   .BR systemd.unit (5),
>   .BR nfs.conf (5),
>   .BR nfsmount.conf (5).
> diff --git a/systemd/nfsroot-generator.c b/systemd/nfsroot-generator.c
> new file mode 100644
> index 00000000..52bd0752
> --- /dev/null
> +++ b/systemd/nfsroot-generator.c
> @@ -0,0 +1,243 @@
> +/*
> + * nfsroot-generator:
> + *   systemd generator to mount /sysroot via NFSv4 in the initrd
> + */
> +
> +#include <sys/stat.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include "nfslib.h"
> +#include "systemd.h"
> +
> +struct nfsroot_info {
> +	char	*server;
> +	char	*path;
> +	char	*options;
> +};
> +
> +/* Valid kernel command line options:
> + *
> + * - root=/dev/nfs nfsroot=[<server>:]<path>[,<options>]
> + *
> + *   Defined in <kernel_source>/Documentation/admin-guide/nfs/nfsroot.rst
> + *
> + * - root=nfs[4]:[<server>:]<path>[:<options>]
> + *
> + *   Defined in dracut.cmdline(7).
> + *
> + * Allow to use both "nfs" or "nfs4" as type indicator,
> + * although the mount unit will use always "nfs4".
> + *
> + * If <server> is not set, it is determined by the 2nd
> + * token of the ip parameter:
> + *
> + *     ip=<client-ip>:<server-ip>:...
> + *
> + * <options> can be appended with the prefix ":" or ","
> + * and are separated by ",".
> + */
> +static int get_nfsroot_info_from_cmdline(struct nfsroot_info *info)
> +{
> +	FILE	*f;
> +	char	buf[4096], *p;
> +	char	*root = NULL, *nfsroot = NULL, *ip = NULL;
> +	char	*colon, *slash, *comma;
> +	size_t	size;
> +
> +	f = fopen("/proc/cmdline", "r");
> +	if (!f)
> +		return errno;
> +
> +	if (fgets(buf, sizeof(buf), f) == NULL)
> +		return EIO;
> +
> +	fclose(f);
> +
> +	size = strlen(buf);
> +	if (buf[size - 1] == '\n')
> +		buf[size - 1] = '\0';
> +	for (p = strtok(buf, " "); p; p = strtok(NULL, " ")) {
> +		if (!strncmp(p, "root=", strlen("root=")))
> +			root = p + strlen("root=");
> +		else if (!strncmp(p, "nfsroot=", strlen("nfsroot=")))
> +			nfsroot = p + strlen("nfsroot=");
> +		else if (!strncmp(p, "ip=", strlen("ip=")))
> +			ip = p + strlen("ip=");
> +	}
> +
> +	if (!strcmp(root, "/dev/nfs")) {
> +		/* Require the nfsroot parameter with the pseudo-NFS-device */
> +		if (!nfsroot)
> +			return EINVAL;
> +
> +	} else if (root) {
> +		/* Mount type: "nfs" or "nfs4" */
> +		colon = strchr(root, ':');
> +		if (colon == NULL)
> +			return EINVAL;
> +		if (strncmp(root, "nfs:", strlen("nfs:")) &&
> +			strncmp(root, "nfs4:", strlen("nfs4:")))
> +			return EINVAL;
> +
> +		nfsroot = colon + 1;
> +	}
> +
> +	slash = strchr(nfsroot, '/');
> +	if (slash == NULL)
> +		return EINVAL;
> +
> +	if (slash - nfsroot > 0) {
> +		if ((slash - 1)[0] != ':')
> +			return EINVAL;
> +
> +		info->server = strndup(nfsroot, slash - nfsroot - 1);
> +		nfsroot = slash;
> +	} else {
> +		/* Require the ip parameter if <server> is unset */
> +		if (!ip)
> +			return EINVAL;
> +
> +		colon = strchr(ip, ':');
> +		if (colon == NULL)
> +			return EINVAL;
> +		ip = colon + 1;
> +		colon = strchr(ip, ':');
> +		if (colon == NULL)
> +			return EINVAL;
> +		info->server = strndup(ip, colon - ip);
> +	}
> +	if (!info->server)
> +		return ENOMEM;
> +
> +	colon = strchr(nfsroot, ':');
> +	if (colon != NULL) {
> +		info->path = strndup(nfsroot, colon - nfsroot);
> +		nfsroot = colon + 1;
> +	} else {
> +		comma = strchr(nfsroot, ',');
> +		if (comma == NULL) {
> +			info->path = strdup(nfsroot);
> +		} else {
> +			info->path = strndup(nfsroot, comma - nfsroot);
> +			nfsroot = comma + 1;
> +		}
> +	}
> +	if (!info->path)
> +		return ENOMEM;
> +
> +	if ((colon || comma) && strlen(nfsroot) > 0) {
> +		/* Skip checking <options> format */
> +		info->options = strdup(nfsroot);
> +		if (!info->options)
> +			return ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int generate_sysroot_mount_unit(const struct nfsroot_info *info,
> +			       const char *dirname)
> +{
> +	int 	ret = 0;
> +	char	*path, *rpath;
> +	char	dirbase[] = "/initrd-root-fs.target.requires";
> +	char	filebase[] = "/sysroot.mount";
> +	FILE	*f;
> +
> +	path = malloc(strlen(dirname) + 1 + sizeof(filebase));
> +	if (!path)
> +		return ENOMEM;
> +	sprintf(path, "%s", dirname);
> +	mkdir(path, 0755);
> +	strcat(path, filebase);
> +	f = fopen(path, "w");
> +	if (!f) {
> +		ret = errno;
> +		goto cleanup;
> +	}
> +
> +	fprintf(f, "# Automatically generated by nfsroot-generator\n\n[Unit]\n");
> +	fprintf(f, "Description=NFSv4 Root File System\n");
> +	fprintf(f, "SourcePath=/proc/cmdline\n");
> +	fprintf(f, "Requires=modprobe@sunrpc.service rpc_pipefs.target\n");
> +	fprintf(f, "Wants=nfs-idmapd.service network-online.target remote-fs-pre.target\n");
> +	fprintf(f, "After=modprobe@sunrpc.service nfs-idmapd.service network-online.target remote-fs-pre.target rpc_pipefs.target\n");
> +	fprintf(f, "Before=initrd-root-fs.target remote-fs.target\n");
> +	fprintf(f, "\n[Mount]\n");
> +	fprintf(f, "What=%s:%s\n", info->server, info->path);
> +	fprintf(f, "Where=/sysroot\n");
> +	fprintf(f, "Type=nfs4\n");
> +	if (info->options)
> +		fprintf(f, "Options=%s\n", info->options);
> +
> +	fclose(f);
> +
> +	rpath = malloc(strlen(dirname) + 1 + sizeof(dirbase) + sizeof(filebase));
> +	if (!rpath) {
> +		ret = ENOMEM;
> +		goto cleanup;
> +	}
> +	sprintf(rpath, "%s%s", dirname, dirbase);
> +	mkdir(rpath, 0755);
> +	strcat(rpath, filebase);
> +
> +	if (symlink(path, rpath) < 0 && errno != EEXIST)
> +		ret = errno;
> +
> +	free(rpath);
> +cleanup:
> +	free(path);
> +
> +	return ret;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int 	ret;
> +	struct nfsroot_info	info = {
> +		.server = NULL,
> +		.path = NULL,
> +		.options = NULL,
> +	};
> +
> +	/* Avoid using any external services */
> +	xlog_syslog(0);
> +
> +	if (argc != 4 || argv[1][0] != '/') {
> +		fprintf(stderr, "nfsroot-generator: mount /sysroot via NFSv4 in the initrd\n");
> +		fprintf(stderr, "Usage: normal-dir early-dir late-dir\n");
> +		exit(1);
> +	}
> +
> +	if (!systemd_in_initrd())
> +		exit(0);
> +
> +	ret = get_nfsroot_info_from_cmdline(&info);
> +	if (ret) {
> +		fprintf(stderr, "nfsroot-generator: failed to get nfsroot from kernel command line: %s\n",
> +			strerror(ret));
> +		goto cleanup;
> +	}
> +
> +	if (info.server && info.path) {
> +		ret = generate_sysroot_mount_unit(&info, argv[1]);
> +		if (ret) {
> +			fprintf(stderr, "nfsroot-generator: failed to generate sysroot.mount unit: %s\n",
> +				strerror(ret));
> +		}
> +	}
> +
> +cleanup:
> +	if (info.server)
> +		free(info.server);
> +	if (info.path)
> +		free(info.path);
> +	if (info.options)
> +		free(info.options);
> +
> +	exit(ret);
> +}
> diff --git a/systemd/systemd.c b/systemd/systemd.c
> index c7bdb4d2..fe749a99 100644
> --- a/systemd/systemd.c
> +++ b/systemd/systemd.c
> @@ -1,13 +1,12 @@
>   /*
>    * Helper functions for systemd generators in nfs-utils.
> - *
> - * Currently just systemd_escape().
>    */
>   
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <ctype.h>
>   #include <string.h>
> +#include <unistd.h>
>   #include "systemd.h"
>   
>   static const char hex[16] =
> @@ -132,3 +131,16 @@ out:
>   	sprintf(p, "%s", suffix);
>   	return result;
>   }
> +
> +/*
> + * check if the system is running in the initrd, following the same logic as
> + * systemd, described in os-release(5):
> + *
> + *     In the initrd[2] and exitrd, /etc/initrd-release plays the same role as
> + *     os-release in the main system. Additionally, the presence of that file
> + *     means that the system is in the initrd/exitrd phase.
> + */
> +int systemd_in_initrd(void)
> +{
> +	return (access("/etc/initrd-release", F_OK) >= 0);
> +}
> diff --git a/systemd/systemd.h b/systemd/systemd.h
> index 25235ec8..72a04c86 100644
> --- a/systemd/systemd.h
> +++ b/systemd/systemd.h
> @@ -2,5 +2,6 @@
>   #define SYSTEMD_H
>   
>   char *systemd_escape(char *path, char *suffix);
> +int systemd_in_initrd(void);
>   
>   #endif /* SYSTEMD_H */


