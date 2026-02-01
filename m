Return-Path: <linux-nfs+bounces-18627-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SkhkHweOf2k9tgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18627-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:31:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B72DEC6BC3
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Feb 2026 18:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 334D73003317
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Feb 2026 17:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A074A26FA6F;
	Sun,  1 Feb 2026 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qjqnqbdq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r0c6MPWX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54B926738D
	for <linux-nfs@vger.kernel.org>; Sun,  1 Feb 2026 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769967108; cv=none; b=e2ZZeO0If9m5PdoD0sI12poNjANVtCC+aM5rSmNbJjSh1YGShBMrr079PZaLqE9Mrx1adiwUr4ZeeuCy6BSBejClft4bscH+HX0BiOPrcxIKdebj+j7YYcIEP/P9M2QcTGFvKl+1lrwuWAE093bVOpP2VJgv6d+aAN4sHYD+sGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769967108; c=relaxed/simple;
	bh=/mlFC/DLzEsuRVBWuTb8nOep3qaVNDei0OeZaiRY7WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnUK+P2DlDTmjXftvcilyNzrVAwnZdYsGVjs5dYr519GQOzgjtKr3TLRFgeGNC4qSlCOg7L0J9E/HpXfPNlvkxk5s4+tNRUeHh6PpMhTF4qfmJjSJ1c9exPwoTGN43qvaKrGDb6t7m3xrj4SC0m93T2fuaKGbn3O/QY9syyq40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qjqnqbdq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r0c6MPWX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769967105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFOZZh82SGmdbFHIgL0ebNOlmAoBVgXPfFfVc8QuMKU=;
	b=Qjqnqbdq0hvLXQdzLWiFpKOaTcGv3blrxQnyM+HodMXFUEhXIPngmHhVtFa4tU8JGPzfLd
	C/Mhdi9LlGDlrOCMRSlXH//legBRj2lqtsVY+r81uTNCY65HpianOmqhBNT2di3sxrrY2Q
	OIS+NNKxh8Y64kIFTVsrsnQHCi4uHvU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-AHKOSoJEMImyXcAP6bgPZA-1; Sun, 01 Feb 2026 12:31:44 -0500
X-MC-Unique: AHKOSoJEMImyXcAP6bgPZA-1
X-Mimecast-MFC-AGG-ID: AHKOSoJEMImyXcAP6bgPZA_1769967104
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8946f1b8691so104419176d6.3
        for <linux-nfs@vger.kernel.org>; Sun, 01 Feb 2026 09:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769967101; x=1770571901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFOZZh82SGmdbFHIgL0ebNOlmAoBVgXPfFfVc8QuMKU=;
        b=r0c6MPWX2Kk5PmCItx6mHJCMTdkU1g/rZ0JXEVeDUckwnk/YNUbYXr+A8ErQC8covG
         UENC662JnD7uQOGl/nk/XcFILCxmTF1DQU2uOio6+8qVHHkTQ7hmK+Z2Pg0qzmUT2X0C
         gI27m58Lf9h10fzB6gAbWOFrnuL50MB2UaY2gFBfZObhvtzcI5nFGSqMN9PqUsaeM/Xa
         9QOws0o/+JXPm7CMk/D5SXuwtHA10qGYUZPI6k/2RCgT04JwcNTmfLEn7aI8vWwbqFnT
         4mfkxE657k7w0fFDb+oYNz+ULdui6JRNmf0vvtbVcHNTUkKpGcmSLjDUqnUSFXBXIse2
         WS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769967101; x=1770571901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFOZZh82SGmdbFHIgL0ebNOlmAoBVgXPfFfVc8QuMKU=;
        b=dKaSMxl1Il7kzfgGTxIqXTsQZUW4bnzjJyssUj6xYRjAHvzp/2tRkt0QY+CDq01cls
         rxG73cxDjcuL9UBhzrV6zV/4/N4r//Ad8mdR3x3w++tx9TimVUgVlP83VbuiPd/qpXq6
         +eH4Iw/hTzooOk5WIlug52wxwpxojCtZvvue4Bx7pJKZ1IyRZ3MiS/X0x2aqGOm4IVqy
         l2DKyeCEJzLBfbUjzDFWYBcckx25I9907vaPqMcKZxP1LkDavHw8ZqunVfuGje+eoAdK
         b9hEDhBkzXkTUYUQ10AeD6+y6gwbUG+l/YAjtLBSdIxoXrYSWm0dgy2gcSCAdW02KG2k
         jtKA==
X-Forwarded-Encrypted: i=1; AJvYcCU8oexvXoTfQL0VDaF8wXX1t3uaHtGFxeTdCTT8Emx1ID5nXg4IPU9whKen6CumEgSWif3Sedda6/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6J3j/hoZTqzX1BQXM6dmBQSahLLNup1unfEJ+AszmDoOf3Ugs
	q0y9xiVHGou0bQhxocyYxVrJKUPJM0Iy6pTABxXL7Q+MrwdqdlDQ5pqUPF7TqrqRLqp98QKyQ0S
	V6Z76HI90lBo2Ut9Ou54IuYXE/yUBxuRUpTw/HDe8Ex8TgFz8tFLhi7osoCNSeg==
X-Gm-Gg: AZuq6aIxOx+of2pFrESaDDO5QLHlh+TOigaHoOYHhBz5bg1ssgTgIowiS72aHBqAXX0
	dlCgUhiW5xb+8HRKEKSnKt1FfiHxVGuiQ0I87z0ONWkJSM0JfbMmqTgXCmV3RtT7YCfxgaq+qni
	krIh98MFX58BGK0iD+/4jTR7TnDdoadCw3kiFiBCcgTGv6qL4rWbVduKslBBxGRJTuw0hgDCItd
	zN+WQyuRL4XBM2A/6rRpiW0Ojiujgh3epw2uLSFZE3CHYyaW4jF+lCvmf+oX1eDfkc0jEgA+2jP
	9yy8RqVuuFi8nL5NolC1x4SNcgk5WsBdcaWI2wDHwCwp6jaMGaZw9/vweYNZnmYTg7aSWF3hzwy
	gxRqSE6vw
X-Received: by 2002:a05:6214:1311:b0:87d:c7ab:e5d0 with SMTP id 6a1803df08f44-894ea096c06mr131343366d6.55.1769967101015;
        Sun, 01 Feb 2026 09:31:41 -0800 (PST)
X-Received: by 2002:a05:6214:1311:b0:87d:c7ab:e5d0 with SMTP id 6a1803df08f44-894ea096c06mr131343056d6.55.1769967100587;
        Sun, 01 Feb 2026 09:31:40 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375c0d8sm98697506d6.43.2026.02.01.09.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 09:31:39 -0800 (PST)
Message-ID: <671224fc-7c42-420e-9dbe-ae125bfdad4d@redhat.com>
Date: Sun, 1 Feb 2026 12:31:37 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v2] nfsdctl: add support for min-threads
 parameter
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20260123-minthreads-v2-1-9bfbae745845@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260123-minthreads-v2-1-9bfbae745845@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18627-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B72DEC6BC3
X-Rspamd-Action: no action



On 1/23/26 1:48 PM, Jeff Layton wrote:
> This patch adds proper support to nfsdctl to manage nfsd's new dynamic
> threading when NFSD_A_SERVER_MIN_THREADS is defined in the header:
> 
> If the user sets min-threads, and has a new enough kernel, the
> traditional threads parameters will represent the max number of threads.
> The min-threads value represents the minimum number of threads to run in
> each pool. The kernel will start the minimum number of threads at
> startup time, and the thread count will dynamically fluctuate between
> the min and max based on load.
> 
> Allow the "autostart" subcommand to find the "min-threads" parameter in
> nfs.conf and set it in the netlink call appropriately. If it's not set,
> then assume that it's 0, which will disable dynamic threading.
> 
> For the "threads" subcommand, add a new command-line option. If it's not
> set, then don't send it in the netlink command at all. That allows the
> kernel's existing setting to remain as-is, unless explicitly changed.
> 
> Also, update the documentation with info about min-threads.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Committed... (tag: nfs-utils-2-8-5-rc3)

steved.

> ---
> This just has a couple of minor revisions to the earlier set. Steve,
> does this look acceptable?
> ---
> Changes in v2:
> - properly handle getopt in threads_func()
> - #ifdef out the --minthreads help text when compiled out
> - Link to v1: https://lore.kernel.org/r/20260112-minthreads-v1-1-30c5f4113720@kernel.org
> ---
>   configure.ac               |  3 ++-
>   systemd/nfs.conf.man       |  3 ++-
>   utils/nfsdctl/nfsdctl.8    | 20 +++++++++++++++++--
>   utils/nfsdctl/nfsdctl.adoc | 13 ++++++++++++
>   utils/nfsdctl/nfsdctl.c    | 49 ++++++++++++++++++++++++++++++++++++++++------
>   5 files changed, 78 insertions(+), 10 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 6da23915836d34ff4d9bdef79af13499990688f9..33866e869666d8ebdebc8d7b5b08bf6ffbe92aa2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -262,6 +262,8 @@ AC_ARG_ENABLE(nfsdctl,
>   		PKG_CHECK_MODULES(LIBNLGENL3, libnl-genl-3.0 >= 3.1)
>   		PKG_CHECK_MODULES(LIBREADLINE, readline)
>   		AC_CHECK_HEADERS(linux/nfsd_netlink.h)
> +		AC_CHECK_DECLS([NFSD_A_SERVER_MIN_THREADS], , ,
> +			       [#include <linux/nfsd_netlink.h>])
>   
>   		# ensure we have the pool-mode commands
>   		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/nfsd_netlink.h>]],
> @@ -620,7 +622,6 @@ AC_CHECK_SIZEOF(socklen_t,, [AC_INCLUDES_DEFAULT
>                                # include <sys/socket.h>
>                                #endif])
>   
> -
>   dnl *************************************************************
>   dnl Export some path names to config.h
>   dnl *************************************************************
> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
> index e6a84a9725da5a3cc40611f45d343a670fdb94ca..484de2c086db91ede38490e49411e1514a5da754 100644
> --- a/systemd/nfs.conf.man
> +++ b/systemd/nfs.conf.man
> @@ -162,6 +162,7 @@ option.
>   .B nfsd
>   Recognized values:
>   .BR threads ,
> +.BR min-threads ,
>   .BR host ,
>   .BR scope ,
>   .BR port ,
> @@ -179,7 +180,7 @@ Recognized values:
>   Version and protocol values are Boolean values as described above,
>   and are also used by
>   .BR rpc.mountd .
> -Threads and the two times are integers.
> +Threads, min-threads and the two times are integers.
>   .B port
>   and
>   .B rdma
> diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
> index d69922448eb17fb155f05dc4ddc9aefffbf966e4..a86ffe8e1f4d39ef7041ac0f6867792466c40af0 100644
> --- a/utils/nfsdctl/nfsdctl.8
> +++ b/utils/nfsdctl/nfsdctl.8
> @@ -2,12 +2,12 @@
>   .\"     Title: nfsdctl
>   .\"    Author: Jeff Layton
>   .\" Generator: Asciidoctor 2.0.20
> -.\"      Date: 2025-01-09
> +.\"      Date: 2026-01-12
>   .\"    Manual: \ \&
>   .\"    Source: \ \&
>   .\"  Language: English
>   .\"
> -.TH "NFSDCTL" "8" "2025-01-09" "\ \&" "\ \&"
> +.TH "NFSDCTL" "8" "2026-01-12" "\ \&" "\ \&"
>   .ie \n(.g .ds Aq \(aq
>   .el       .ds Aq '
>   .ss \n[.ss] 0
> @@ -147,6 +147,22 @@ value of 0 will shut down the NFS server. Run this without arguments to
>   get the current number of running threads in each pool.
>   .RE
>   .sp
> +.if n .RS 4
> +.nf
> +.fam C
> +These options are specific to the "threads" subcommand:
> +
> +\-m, \-\-min\-threads=
> +    If set to a positive, non\-zero value, then dynamic threading is enabled for
> +    nfsd.  In this mode, the traditional "threads" values are treated as a maximum
> +    number of threads. This specifies the minimum number of threads per pool. The
> +    kernel will start the minimum number and dynamically start and stop threads as
> +    needed. If the minimum is larger than the maximum, then dynamic threadis is
> +    disabled, and the maximum number is started.
> +.fam
> +.fi
> +.if n .RE
> +.sp
>   \fBversion\fP
>   .RS 4
>   Get/set the enabled NFS versions for the server. Run without arguments to
> diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
> index 0207eff6118d2dcc5a794d2013c039d9beb11ddc..e85348e29ed815470d35b6365a212d8872cf645c 100644
> --- a/utils/nfsdctl/nfsdctl.adoc
> +++ b/utils/nfsdctl/nfsdctl.adoc
> @@ -84,6 +84,19 @@ Each subcommand can also accept its own set of options and arguments. The
>     value of 0 will shut down the NFS server. Run this without arguments to
>     get the current number of running threads in each pool.
>   
> +[source,bash]
> +----
> +These options are specific to the "threads" subcommand:
> +
> +-m, --min-threads=
> +    If set to a positive, non-zero value, then dynamic threading is enabled for
> +    nfsd.  In this mode, the traditional "threads" values are treated as a maximum
> +    number of threads. This specifies the minimum number of threads per pool. The
> +    kernel will start the minimum number and dynamically start and stop threads as
> +    needed. If the minimum is larger than the maximum, then dynamic threadis is
> +    disabled, and the maximum number is started.
> +----
> +
>   *version*::
>   
>     Get/set the enabled NFS versions for the server. Run without arguments to
> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> index e7a0e12495277d2e98a6c21c7cee29fe459f37cc..1e60b9ae6d9ec61ca243fc62623a1a4b9a3b45a7 100644
> --- a/utils/nfsdctl/nfsdctl.c
> +++ b/utils/nfsdctl/nfsdctl.c
> @@ -19,6 +19,7 @@
>   #include <string.h>
>   #include <sched.h>
>   #include <sys/queue.h>
> +#include <limits.h>
>   
>   #include <netlink/genl/family.h>
>   #include <netlink/genl/ctrl.h>
> @@ -323,6 +324,11 @@ static void parse_threads_get(struct genlmsghdr *gnlh)
>   		case NFSD_A_SERVER_THREADS:
>   			pool_threads[i++] = nla_get_u32(attr);
>   			break;
> +#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
> +		case NFSD_A_SERVER_MIN_THREADS:
> +			printf("min-threads: %u\n", nla_get_u32(attr));
> +			break;
> +#endif
>   		default:
>   			break;
>   		}
> @@ -518,7 +524,7 @@ out:
>   }
>   
>   static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
> -			int pool_count, int *pool_threads, char *scope)
> +			int pool_count, int *pool_threads, char *scope, int minthreads)
>   {
>   	struct genlmsghdr *ghdr;
>   	struct nlmsghdr *nlh;
> @@ -540,6 +546,10 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
>   			nla_put_u32(msg, NFSD_A_SERVER_LEASETIME, lease);
>   		if (scope)
>   			nla_put_string(msg, NFSD_A_SERVER_SCOPE, scope);
> +#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
> +		if (minthreads >= 0)
> +			nla_put_u32(msg, NFSD_A_SERVER_MIN_THREADS, minthreads);
> +#endif
>   		for (i = 0; i < pool_count; ++i)
>   			nla_put_u32(msg, NFSD_A_SERVER_THREADS, pool_threads[i]);
>   	}
> @@ -580,23 +590,49 @@ out:
>   
>   static void threads_usage(void)
>   {
> -	printf("Usage: %s threads [ pool0_count ] [ pool1_count ] ...\n", taskname);
> +	printf("Usage: %s threads { --min-threads=X } [ pool0_count ] [ pool1_count ] ...\n", taskname);
> +#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
> +	printf("    --min-threads= set the minimum thread count per pool to value\n");
> +#endif
>   	printf("    pool0_count: thread count for pool0, etc...\n");
>   	printf("Omit any arguments to show current thread counts.\n");
>   }
>   
> +#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
> +static const struct option threads_options[] = {
> +	{ "help", no_argument, NULL, 'h' },
> +	{ "min-threads", required_argument, NULL, 'm' },
> +	{ },
> +};
> +#define THREADS_OPTSTRING "hm:"
> +#else
> +#define threads_options help_only_options
> +#define THREADS_OPTSTRING "h"
> +#endif
> +
>   static int threads_func(struct nl_sock *sock, int argc, char **argv)
>   {
>   	uint8_t cmd = NFSD_CMD_THREADS_GET;
>   	int *pool_threads = NULL;
> +	int minthreads = -1;
>   	int opt, pools = 0;
>   
>   	optind = 1;
> -	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
> +	while ((opt = getopt_long(argc, argv, THREADS_OPTSTRING, threads_options, NULL)) != -1) {
>   		switch (opt) {
>   		case 'h':
>   			threads_usage();
>   			return 0;
> +#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
> +		case 'm':
> +			errno = 0;
> +			minthreads = strtoul(optarg, NULL, 0);
> +			if (minthreads == ULONG_MAX && errno != 0) {
> +				fprintf(stderr, "Bad --min-threads value.");
> +				return 1;
> +			}
> +			break;
> +#endif
>   		}
>   	}
>   
> @@ -624,7 +660,7 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
>   			}
>   		}
>   	}
> -	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL);
> +	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL, minthreads);
>   }
>   
>   /*
> @@ -1578,7 +1614,7 @@ static void autostart_usage(void)
>   
>   static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>   {
> -	int *threads, grace, lease, idx, ret, opt, pools;
> +	int *threads, grace, lease, idx, ret, opt, pools, minthreads;
>   	struct conf_list *thread_str;
>   	struct conf_list_node *n;
>   	char *scope, *pool_mode;
> @@ -1659,9 +1695,10 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>   
>   	lease = conf_get_num("nfsd", "lease-time", 0);
>   	scope = conf_get_str("nfsd", "scope");
> +	minthreads = conf_get_num("nfsd", "min-threads", 0);
>   
>   	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
> -			   threads, scope);
> +			   threads, scope, minthreads);
>   out:
>   	free(threads);
>   	return ret;
> 
> ---
> base-commit: 0e71be58cdead21b7bc0285fa6afbf1d0eca3049
> change-id: 20260109-minthreads-7906eecedf99
> 
> Best regards,


