Return-Path: <linux-nfs+bounces-13883-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03217B34527
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 17:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F102A0796
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 15:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6545A2FC88C;
	Mon, 25 Aug 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRhdu2RG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA2E2F2917
	for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134268; cv=none; b=eB4vDGYP8QZ56ZnXl/v/UoLXGTYtF/R+B6t7uRzvGIgZFYXXVok0UMpBn/JW9U89k1zv5R/4pYlavME3eQOnmQXd2xdeRb+a7W8C7CRyWtxPMQXojTXPG12uxa87Iuuusxd6Kl596Jqghjii2rtimkXz6YIAgL/xGKXdHHsy1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134268; c=relaxed/simple;
	bh=2QCbIv3AKubhWO7z3yPh1yd1n1rm6szfYbAyM1gJjRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFO6o+Z3yp3yInYlwroWjO503VL7aL7vflQZMMNTbI3x45TOCRfSwU4XkU3Os1zpJg2rdcXHuS21xPuiTAoZKeYVmR3VFHsC5zv76E5NMSoZctebOZrkv79m+872SapXr53CJbzdGKKekW/vPjqAOGfW8gUTIlDjQv5U09kykEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRhdu2RG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756134265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4C+SBZQZvXVR6CjlNg6DWvle34y4quPoQEvTCSKjsY=;
	b=bRhdu2RGJ+aINW+YlVCmDplfwKNQOMLACIsRMkKzBqMP7XkdpPfLAjN9En8CxTyha/f7pm
	PbFpY3yhN2Gi5Msaj3QuBixKg9qQhwFcpCD3pZJQp0WZ5/4uUu+qV1Zww1aEUNq5ZLAN/q
	M44liiOweEuuxsegrypCXuDDCQoXhPk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-XU2DrILIN6uooSl_f8TlDA-1; Mon, 25 Aug 2025 11:04:18 -0400
X-MC-Unique: XU2DrILIN6uooSl_f8TlDA-1
X-Mimecast-MFC-AGG-ID: XU2DrILIN6uooSl_f8TlDA_1756134258
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e953c60abd3so2437714276.0
        for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 08:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756134258; x=1756739058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4C+SBZQZvXVR6CjlNg6DWvle34y4quPoQEvTCSKjsY=;
        b=MtvYK5h2uul55A6+InYyRf1/wcF4pcpg69iAhEDbNmA7qawLwA4cFPZWohB8Hw3YyQ
         m69Wfk7sYG4hFY9csJxRPSJomyLRzqeGc3l4rv7x4fXrv81UgJRBazam+XPDXoO0RYMP
         IWrjaY4QOm//aV9yvW3VQGhAHAKZki3w0a9EOzjMFsgauvBhXFylTV5fSD4gMoOsNEdV
         saZ8f3NrL3vu7Fyr1xL9aek4OL1TmVT45bO9d80+anRXVddkN7aUVQsES7sTTS0hEjQI
         f8TEonJPB+298xIhTIU6pWYJhM14/+483ZlBtDeZsPQJswqt6jsNcp7vv9pra5QKgFft
         7NdQ==
X-Gm-Message-State: AOJu0YyznICAAL8f7kkAO4vKm1zjp+1NdPz+0dqPbdjGNGwMNfQOIBeG
	v4yzCeF6dqieLVEYgevZBFCsClvWnjjERgomOySwsXWRWsDLYUXuYFymMUoQCqiuh4spbJqTEiJ
	ShktasacVCshhTtrLGAMrL/JW4vrLuFtfDYEKyYkj8zIn3MxXDRAMmzHO8haNJw==
X-Gm-Gg: ASbGnctDWMP2VZ9rgPCZwJAyzyaDao1S9rYt2HCvTVrsLY0Fj+xOFzhcWZzE28Lz71U
	dXqQyGgBZnwtB+jleUsEgYWUaNmPgTIQylX4JSiBSHWt+NJt3qPRU/lrjKSMSqT8dNxLVFDnomz
	BHGrWy6N5fh03OkobwZ9I3+oLp9yWYwHpOG6YW6yl6nqqWA3v0O4z/aEbOcP5ACVNTBnD+0uYcm
	JaX9uZEFcYj9OWzhDs6MfJTl+gvku8dyqLVfQ7G7ggARc5Wvco/se+5AtxIqb1Hwn5mYU5HmTle
	RpXO5tsXjmtrL3N5BUBQaqfojkUkUQTzZae39cid
X-Received: by 2002:a05:6902:338a:b0:e95:2eea:a25e with SMTP id 3f1490d57ef6-e952eeaa490mr7427901276.9.1756134257397;
        Mon, 25 Aug 2025 08:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5Sheu8HoJ25HZSkJpqnSQCbrd4/7XA91d+R9Xz9qOgVqTyw9CXPYLz/t3RhMd8bukf9Atyg==
X-Received: by 2002:a05:6902:338a:b0:e95:2eea:a25e with SMTP id 3f1490d57ef6-e952eeaa490mr7427835276.9.1756134256619;
        Mon, 25 Aug 2025 08:04:16 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.241.207])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e95e48d78aesm1141008276.34.2025.08.25.08.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 08:04:15 -0700 (PDT)
Message-ID: <3aecba8b-558b-44be-8763-6e5432a46cf5@redhat.com>
Date: Mon, 25 Aug 2025 11:04:14 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Add conditional version script support
To: Khem Raj <raj.khem@gmail.com>, libtirpc-devel@lists.sourceforge.net
Cc: linux-nfs@vger.kernel.org
References: <20250812180809.2182301-1-raj.khem@gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250812180809.2182301-1-raj.khem@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/25 2:08 PM, Khem Raj wrote:
> This patch adds conditional symbol versioning to libtirpc, allowing
> GSS-API, DES crypto, and RPC database symbols to be conditionally
> included in the version script based on build configuration.
> 
> LLD is strict about undefined symbols referenced in a version script.
> Some libtirpc symbols (rpcsec_gss, old DES helpers, rpc database
> helpers) are optional and may not be built depending on configure
> options or missing deps. GNU ld tolerated this; LLD errors out.
> 
> This change keeps the canonical symbol map in src/libtirpc.map, but
> adds a make-time rule to generate a filtered copy
> where names from disabled features are deleted. The lib is then linked
> against the generated linker map file.
> 
> Fixes linking errors when these features are not available.
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
Committed... (tag: libtirpc-1-3-7-rc4)

steved.
> ---
> v2: Fix access to generated libtirpc.map when Srcdir != Builddir
> v3: Fix problems where getrpcent.c was not being built with --enable-rpcdb
> 
>   configure.ac                          | 49 +++++++++++++++++++++++++++
>   src/Makefile.am                       | 30 ++++++++++++----
>   src/{libtirpc.map => libtirpc.map.in} | 48 +++++---------------------
>   3 files changed, 80 insertions(+), 47 deletions(-)
>   rename src/{libtirpc.map => libtirpc.map.in} (84%)
> 
> diff --git a/configure.ac b/configure.ac
> index e813b14..e79bf59 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -77,6 +77,19 @@ if test "x$enable_ipv6" != xno; then
>   	AC_DEFINE(INET6, 1, [Define to 1 if IPv6 is available])
>   fi
>   
> +# RPC database support
> +AC_ARG_ENABLE(rpcdb,
> +    [AS_HELP_STRING([--enable-rpcdb], [Enable RPC Database support @<:@default=no@:>@])],
> +    [], [enable_rpcdb=no])
> +AM_CONDITIONAL(RPCDB, test "x$enable_rpcdb" = xyes)
> +if test "x$enable_rpcdb" != "xno"; then
> +    AC_CHECK_FUNCS([getrpcent getrpcbyname getrpcbynumber], [have_rpcdb=yes])
> +
> +    if test "x$have_rpcdb" = "xyes"; then
> +        AC_DEFINE([RPCDB], [1], [Define if RPC database support is available])
> +    fi
> +fi
> +
>   AC_ARG_ENABLE(symvers,
>   	[AS_HELP_STRING([--disable-symvers],[Disable symbol versioning @<:@default=no@:>@])],
>         [],[enable_symvers=maybe])
> @@ -97,6 +110,33 @@ fi
>   
>   AM_CONDITIONAL(SYMVERS, test "x$enable_symvers" = xyes)
>   
> +# Generate symbol lists for version script
> +if test "x$enable_gssapi" = "xyes"; then
> +    GSS_SYMBOLS="_svcauth_gss; authgss_create; authgss_create_default; authgss_free_private_data; authgss_get_private_data; authgss_service; gss_log_debug; gss_log_hexdump; gss_log_status; rpc_gss_get_error; rpc_gss_get_mech_info; rpc_gss_get_mechanisms; rpc_gss_get_principal_name; rpc_gss_get_versions; rpc_gss_qop_to_num; rpc_gss_seccreate; rpc_gss_set_callback; rpc_gss_set_defaults; rpc_gss_set_svc_name; rpc_gss_svc_max_data_length;"
> +
> +    GSS_SYMBOLS_031="svcauth_gss_get_principal; svcauth_gss_set_svc_name;"
> +else
> +    GSS_SYMBOLS=""
> +    GSS_SYMBOLS_031=""
> +fi
> +
> +if test "x$enable_authdes" = "xyes"; then
> +    DES_SYMBOLS="cbc_crypt; ecb_crypt; xdr_authdes_cred; xdr_authdes_verf; xdr_rpc_gss_cred; xdr_rpc_gss_data; xdr_rpc_gss_init_args; xdr_rpc_gss_init_res;"
> +else
> +    DES_SYMBOLS=""
> +fi
> +
> +if test "x$enable_rpcdb" = "xyes"; then
> +    RPCDB_SYMBOLS="endrpcent; getrpcent; getrpcbynumber; getrpcbyname; setrpcent;"
> +else
> +    RPCDB_SYMBOLS=""
> +fi
> +
> +AC_SUBST([GSS_SYMBOLS])
> +AC_SUBST([GSS_SYMBOLS_031])
> +AC_SUBST([DES_SYMBOLS])
> +AC_SUBST([RPCDB_SYMBOLS])
> +
>   AC_CANONICAL_BUILD
>   # Check for which host we are on and setup a few things
>   # specifically based on the host
> @@ -167,7 +207,16 @@ AC_CHECK_FUNCS([getpeereid getrpcbyname getrpcbynumber setrpcent endrpcent getrp
>   AC_CHECK_TYPES(struct rpcent,,, [
>         #include <netdb.h>])
>   AC_CONFIG_FILES([Makefile src/Makefile man/Makefile doc/Makefile])
> +AC_CONFIG_FILES([src/libtirpc.map])
>   AC_CONFIG_FILES([libtirpc.pc])
>   AC_OUTPUT
>   
> +# Configuration summary
> +AC_MSG_NOTICE([
> +libtirpc configuration summary:
> +  GSS-API support: $enable_gssapi
> +  DES crypto support: $enable_authdes
> +  RPC database support: $enable_rpcdb
> +  Symbol versioning: $enable_symvers
> +])
>   
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 0cef093..cfda770 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -6,6 +6,9 @@
>   ## anything like that.
>   
>   noinst_HEADERS = rpc_com.h debug.h
> +EXTRA_DIST = libtirpc.map.in
> +# Generated files
> +BUILT_SOURCES = libtirpc.map
>   
>   AM_CPPFLAGS = -I$(top_srcdir)/tirpc -include config.h -DPORTMAP -DINET6 \
>   		-D_GNU_SOURCE -Wall -pipe
> @@ -15,10 +18,19 @@ lib_LTLIBRARIES = libtirpc.la
>   libtirpc_la_LDFLAGS = @LDFLAG_NOUNDEFINED@ -no-undefined @PTHREAD_LIBS@
>   libtirpc_la_LDFLAGS += -version-info @LT_VERSION_INFO@
>   
> +# Generate version script from template
> +libtirpc.map: $(srcdir)/libtirpc.map.in
> +	$(AM_V_GEN)$(SED) \
> +		-e 's|@GSS_SYMBOLS@|$(GSS_SYMBOLS)|g' \
> +		-e 's|@GSS_SYMBOLS_031@|$(GSS_SYMBOLS_031)|g' \
> +		-e 's|@DES_SYMBOLS@|$(DES_SYMBOLS)|g' \
> +		-e 's|@RPCDB_SYMBOLS@|$(RPCDB_SYMBOLS)|g' \
> +		< $(srcdir)/libtirpc.map.in > $@ || rm -f $@
> +
>   libtirpc_la_SOURCES = auth_none.c auth_unix.c authunix_prot.c \
>           binddynport.c bindresvport.c \
>           clnt_bcast.c clnt_dg.c clnt_generic.c clnt_perror.c clnt_raw.c clnt_simple.c \
> -        clnt_vc.c rpc_dtablesize.c getnetconfig.c getnetpath.c getrpcent.c \
> +        clnt_vc.c rpc_dtablesize.c getnetconfig.c getnetpath.c \
>           getrpcport.c mt_misc.c pmap_clnt.c pmap_getmaps.c pmap_getport.c \
>           pmap_prot.c pmap_prot2.c pmap_rmt.c rpc_prot.c rpc_commondata.c \
>           rpc_callmsg.c rpc_generic.c rpc_soc.c rpcb_clnt.c rpcb_prot.c \
> @@ -34,19 +46,23 @@ endif
>   libtirpc_la_SOURCES += xdr.c xdr_rec.c xdr_array.c xdr_float.c xdr_mem.c xdr_reference.c xdr_stdio.c xdr_sizeof.c
>   
>   if SYMVERS
> -    libtirpc_la_LDFLAGS += -Wl,--version-script=$(srcdir)/libtirpc.map
> +    libtirpc_la_LDFLAGS += -Wl,--version-script=$(builddir)/libtirpc.map
>   endif
>   
>   ## Secure-RPC
>   if GSS
> -    libtirpc_la_SOURCES += auth_gss.c authgss_prot.c svc_auth_gss.c \
> -			   rpc_gss_utils.c
> -    libtirpc_la_LIBADD = $(GSSAPI_LIBS)
> -    libtirpc_la_CFLAGS = -DHAVE_RPCSEC_GSS $(GSSAPI_CFLAGS)
> +libtirpc_la_SOURCES += auth_gss.c authgss_prot.c svc_auth_gss.c rpc_gss_utils.c
> +libtirpc_la_LIBADD = $(GSSAPI_LIBS)
> +libtirpc_la_CFLAGS = -DHAVE_RPCSEC_GSS $(GSSAPI_CFLAGS)
> +endif
> +
> +# Conditionally add RPC database sources
> +if RPCDB
> +libtirpc_la_SOURCES += getrpcent.c
>   endif
>   
>   libtirpc_la_SOURCES += key_call.c key_prot_xdr.c getpublickey.c
>   libtirpc_la_SOURCES += netname.c netnamer.c rpcdname.c rtime.c
>   
> -CLEANFILES	       = cscope.* *~
> +CLEANFILES	       = cscope.* libtirpc.map *~
>   DISTCLEANFILES	       = Makefile.in
> diff --git a/src/libtirpc.map b/src/libtirpc.map.in
> similarity index 84%
> rename from src/libtirpc.map
> rename to src/libtirpc.map.in
> index 21d6065..6cf563b 100644
> --- a/src/libtirpc.map
> +++ b/src/libtirpc.map.in
> @@ -34,16 +34,10 @@ TIRPC_0.3.0 {
>       _svcauth_none;
>       _svcauth_short;
>       _svcauth_unix;
> -    _svcauth_gss;
>   
>       # a*
>       authdes_create;
>       authdes_seccreate;
> -    authgss_create;
> -    authgss_create_default;
> -    authgss_free_private_data;
> -    authgss_get_private_data;
> -    authgss_service;
>       authnone_create;
>       authunix_create;
>       authunix_create_default;
> @@ -54,7 +48,6 @@ TIRPC_0.3.0 {
>   
>       # c*
>       callrpc;
> -    cbc_crypt;
>       clnt_broadcast;
>       clnt_create;
>       clnt_create_timed;
> @@ -79,10 +72,8 @@ TIRPC_0.3.0 {
>       clntunix_create;
>   
>       # e*
> -    ecb_crypt;
>       endnetconfig;
>       endnetpath;
> -    endrpcent;
>   
>       # f*
>       freenetconfigent;
> @@ -92,13 +83,7 @@ TIRPC_0.3.0 {
>       getnetconfig;
>       getnetconfigent;
>       getnetpath;
> -    getrpcent;
> -    getrpcbynumber;
> -    getrpcbyname;
>       getrpcport;
> -    gss_log_debug;
> -    gss_log_hexdump;
> -    gss_log_status;
>   
>       # n*
>       nc_perror;
> @@ -118,21 +103,6 @@ TIRPC_0.3.0 {
>       rpc_call;
>       rpc_control;
>       rpc_createerr;
> -    rpc_gss_get_error;
> -    rpc_gss_get_mech_info;
> -    rpc_gss_get_mechanisms;
> -    rpc_gss_get_principal_name;
> -    rpc_gss_get_versions;
> -    rpc_gss_getcred;
> -    rpc_gss_is_installed;
> -    rpc_gss_max_data_length;
> -    rpc_gss_mech_to_oid;
> -    rpc_gss_qop_to_num;
> -    rpc_gss_seccreate;
> -    rpc_gss_set_callback;
> -    rpc_gss_set_defaults;
> -    rpc_gss_set_svc_name;
> -    rpc_gss_svc_max_data_length;
>       rpc_nullproc;
>       rpc_reg;
>       rpcb_getaddr;
> @@ -147,7 +117,6 @@ TIRPC_0.3.0 {
>       # s*
>       setnetconfig;
>       setnetpath;
> -    setrpcent;
>       svc_auth_reg;
>       svc_create;
>       svc_dg_create;
> @@ -194,8 +163,6 @@ TIRPC_0.3.0 {
>       # x*
>       xdr_accepted_reply;
>       xdr_array;
> -    xdr_authdes_cred;
> -    xdr_authdes_verf;
>       xdr_authunix_parms;
>       xdr_bool;
>       xdr_bytes;
> @@ -228,10 +195,6 @@ TIRPC_0.3.0 {
>       xdr_replymsg;
>       xdr_rmtcall_args;
>       xdr_rmtcallres;
> -    xdr_rpc_gss_cred;
> -    xdr_rpc_gss_data;
> -    xdr_rpc_gss_init_args;
> -    xdr_rpc_gss_init_res;
>       xdr_rpcb;
>       xdr_rpcb_entry;
>       xdr_rpcb_entry_list_ptr;
> @@ -275,14 +238,20 @@ TIRPC_0.3.0 {
>       xdrstdio_create;
>       xprt_register;
>       xprt_unregister;
> +    # GSS-API symbols (conditionally included)
> +@GSS_SYMBOLS@
> +    # DES crypto symbols (conditionally included)
> +@DES_SYMBOLS@
> +    # RPC database symbols (conditionally included)
> +@RPCDB_SYMBOLS@
>   
>     local:
>       *;
>   };
>   
>   TIRPC_0.3.1 {
> -    svcauth_gss_get_principal;
> -    svcauth_gss_set_svc_name;
> +# GSS-API symbols (conditionally included)
> +@GSS_SYMBOLS_031@
>   } TIRPC_0.3.0;
>   
>   TIRPC_0.3.2 {
> @@ -290,7 +259,6 @@ TIRPC_0.3.2 {
>       getpublicandprivatekey;
>       getpublickey;
>       host2netname;
> -    key_call_destroy;
>       key_decryptsession;
>       key_decryptsession_pk;
>       key_encryptsession;
> 


