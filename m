Return-Path: <linux-nfs+bounces-13263-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6347FB12D0A
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Jul 2025 01:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CE71899CEF
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jul 2025 23:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA5621C166;
	Sat, 26 Jul 2025 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evYtjJE6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB05917DFE7
	for <linux-nfs@vger.kernel.org>; Sat, 26 Jul 2025 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753571690; cv=none; b=THhS+Zw3FnkOYw7vYm0F4LaRt8TCoAfJKgVt7dJ77Kf5bpQvuPqw9QCU1cGnWLhOn6sOvXSyqx68iR19FKhhPjdcLgKFvWcZfJ68jSQ3xzdoQ9GmDRo5dwJ0U9wTxB5qzrbrOxAToPJmTud9Phw17BgS1eK1QERh+m3K1tmz4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753571690; c=relaxed/simple;
	bh=2aJSitVn/B2Ec/8DN0/lXiQXqUfyI5biDfD76QE3UOE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o4iFudIg5uO9W7rxii39OwCdWJh/15LSXVxetw67wVd4r69VxmRlN/qZUC3xR7druA7OVVjQdhLB299O17ztA7haIdpaxlYGOHv2mLQUtvDHM0aujG80okJV3xs5rUK4iSPm0EQgP7n677AsFXpy3GsUEeGNZaNHWOfYDdrGK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evYtjJE6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753571687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MPr6PiifGFvLWT2HKuPV0Z34tFFoJxTIs8mjvhcyIs=;
	b=evYtjJE6XizNJ7SSFmOmB1dGECaCKKkGDLp/bEzH/p4GAz45aFrnX914Nd5tfo9LBNsOEc
	fP4Kv4l1ioNDVO/Htkq5weyZJVZ96Fzg8SQ37vv8yX8p+0WUd/l1QeVyhOryBgDMZmpNgQ
	QPFHENtD5ebU1U2njwteahp1csY784Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-3OIpaFGCOLuq9QXeP4Hslw-1; Sat, 26 Jul 2025 19:14:46 -0400
X-MC-Unique: 3OIpaFGCOLuq9QXeP4Hslw-1
X-Mimecast-MFC-AGG-ID: 3OIpaFGCOLuq9QXeP4Hslw_1753571686
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb5f71b363so69331566d6.2
        for <linux-nfs@vger.kernel.org>; Sat, 26 Jul 2025 16:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753571686; x=1754176486;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MPr6PiifGFvLWT2HKuPV0Z34tFFoJxTIs8mjvhcyIs=;
        b=sT3o6M/lQh9qa1ezaGIHuH1uVzgUxgCrrR0PGE8dVPtN/8X3HqPCJqLcoybzps0cCw
         7xPWX/qaB9EcVUs2lZ3Oze83EMLl7lieNZUCXxprExU750YANeQo9i4QgZqsuW79srrO
         PZbKUBKam34S5m4uGHy95Ffwo840fekyQOHib+lRBR0rr/DXZ3bXLLONJsrVUR38FJn7
         r94OSqo7jJfegEsuDYDBkSftt5xjcq7ubIeOCdjuP5EX6/gk5qvFda0LB8i+QdDG/kBi
         HvZUdozCmcFajyw0LmEueQ5Xj8o5/Y+Tu1UzTpYAZf1mocuR1cWXY1LhRWugtwgzKfKp
         b5gA==
X-Gm-Message-State: AOJu0YyHExK2rocmQcY/xA8VtyTSHH9ooRbtAPvBg1mYcRVxPd0P6+DC
	NH1lp2nAPnY2XC/Fq/y0pab/orAC/iga48DlhY6HRKBHLAQ67owKcan3hRKv5bc+6mZoAeCs4wc
	RW9Vz4wO7sKDJRrjujsUMm82iQ1N2WxPy/9NTd6qWUoo3eCTpT3KQwi/a/w0mWA==
X-Gm-Gg: ASbGnctkWmVItelpXQUknnpy+nCpCAT6JSoC/EG6yIbxLohacUnkj9xRmQNUr4f+OE7
	q6ynqdqKUT1oWpkVXwiqr/4WGArJGblnGoJDO2XjlYUVR490P+J9j7aAbrV1XGwecsbKb8hUOBC
	mYQS2YtKV5cd2QxUzEE4w3q2hUZcMC9CxTGyWNCXwnn12f3SNhHNKy6zLheD+JuUD3YedpE/KVM
	uEHH+Iup/HJrfmcX9rqcQM++j7+aBh2Eea/3umCIFfvo0Aege3Q+1Obe6XNSv3jiMpt4ynBqwN/
	7u5ly/XP46RLI8tVVxO4ZpSgYuI4hE1QhQoxMU9m
X-Received: by 2002:a05:6214:cc4:b0:707:2628:3cb1 with SMTP id 6a1803df08f44-70726284170mr95222296d6.28.1753571685895;
        Sat, 26 Jul 2025 16:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPfyFBF8NtudGmtY6gZTLHy/OSphAzWdvZYm5ZczW1CDoTEikh1rpTFj/TcMKVDqqElXkYfg==
X-Received: by 2002:a05:6214:cc4:b0:707:2628:3cb1 with SMTP id 6a1803df08f44-70726284170mr95222086d6.28.1753571685427;
        Sat, 26 Jul 2025 16:14:45 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.240.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729a6237esm14976806d6.25.2025.07.26.16.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 16:14:44 -0700 (PDT)
Message-ID: <a29f2040-2ae6-468c-a91c-668f1a52ddd5@redhat.com>
Date: Sat, 26 Jul 2025 19:14:44 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpcinfo: Removed a number of "old-style function
 definition" warnings
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20250726210000.37744-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20250726210000.37744-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/26/25 5:00 PM, Steve Dickson wrote:
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed... (tag: rpcbind-1_2_8-rc3)

steved.

> ---
>   src/rpcinfo.c | 142 +++++++++++++++++++++-----------------------------
>   1 file changed, 58 insertions(+), 84 deletions(-)
> 
> diff --git a/src/rpcinfo.c b/src/rpcinfo.c
> index 006057a..c59e8b4 100644
> --- a/src/rpcinfo.c
> +++ b/src/rpcinfo.c
> @@ -356,9 +356,7 @@ local_rpcb (rpcprog_t prog, rpcvers_t vers)
>   
>   #ifdef PORTMAP
>   static enum clnt_stat
> -ip_ping_one(client, vers)
> -     CLIENT *client;
> -     u_int32_t vers;
> +ip_ping_one(CLIENT * client, u_int32_t vers)
>   {
>     struct timeval to = { .tv_sec = 10, .tv_usec = 0 };
>   
> @@ -376,11 +374,7 @@ ip_ping_one(client, vers)
>    * version 0 calls succeeds, it tries for MAXVERS call and repeats the same.
>    */
>   static void
> -ip_ping (portnum, proto, argc, argv)
> -     u_short portnum;
> -     char *proto;
> -     int argc;
> -     char **argv;
> +ip_ping (u_short portnum, char *proto, int argc, char **argv)
>   {
>     CLIENT *client;
>     enum clnt_stat rpc_stat;
> @@ -480,9 +474,7 @@ ip_ping (portnum, proto, argc, argv)
>    * Dump all the portmapper registerations
>    */
>   static void
> -pmapdump (argc, argv)
> -     int argc;
> -     char **argv;
> +pmapdump (int argc, char **argv)
>   {
>     struct pmaplist *head = NULL;
>     struct timeval minutetimeout;
> @@ -581,11 +573,8 @@ pmapdump (argc, argv)
>    * the address using rpcb_getaddr.
>    */
>   CLIENT *
> -ip_getclient(hostname, prognum, versnum, proto)
> -     const char *hostname;
> -     rpcprog_t prognum;
> -     rpcvers_t versnum;
> -     const char *proto;
> +ip_getclient(const char *hostname, rpcprog_t prognum,
> +	rpcvers_t versnum, const char *proto)
>   {
>     void *handle;
>     enum clnt_stat saved_stat = RPC_SUCCESS;
> @@ -674,10 +663,10 @@ sa_len(struct sockaddr *sa)
>    */
>   
>    /*ARGSUSED*/ static bool_t
> -reply_proc (res, who, nconf)
> -     void *res;			/* Nothing comes back */
> -     struct netbuf *who;	/* Who sent us the reply */
> -     struct netconfig *nconf;	/* On which transport the reply came */
> +reply_proc (
> +     void *res,			/* Nothing comes back */
> +     struct netbuf *who,	/* Who sent us the reply */
> +     struct netconfig *nconf)	/* On which transport the reply came */
>   {
>     char *uaddr;
>     char hostbuf[NI_MAXHOST];
> @@ -703,9 +692,7 @@ reply_proc (res, who, nconf)
>   }
>   
>   static void
> -brdcst (argc, argv)
> -     int argc;
> -     char **argv;
> +brdcst (int argc, char **argv)
>   {
>     enum clnt_stat rpc_stat;
>     u_long prognum, vers;
> @@ -731,9 +718,7 @@ brdcst (argc, argv)
>   }
>   
>   static bool_t
> -add_version (rs, vers)
> -     struct rpcbdump_short *rs;
> -     u_long vers;
> +add_version (struct rpcbdump_short *rs, u_long vers)
>   {
>     struct verslist *vl;
>   
> @@ -752,9 +737,7 @@ add_version (rs, vers)
>   }
>   
>   static bool_t
> -add_netid (rs, netid)
> -     struct rpcbdump_short *rs;
> -     char *netid;
> +add_netid (struct rpcbdump_short *rs, char *netid)
>   {
>     struct netidlist *nl;
>   
> @@ -773,11 +756,11 @@ add_netid (rs, netid)
>   }
>   
>   static void
> -rpcbdump (dumptype, netid, argc, argv)
> -     int dumptype;
> -     char *netid;
> -     int argc;
> -     char **argv;
> +rpcbdump (
> +     int dumptype,
> +     char *netid,
> +     int argc,
> +     char **argv)
>   {
>     rpcblist_ptr head = NULL;
>     struct timeval minutetimeout;
> @@ -1021,10 +1004,10 @@ error:fprintf (stderr, "rpcinfo: no memory\n");
>   static char nullstring[] = "\000";
>   
>   static void
> -rpcbaddrlist (netid, argc, argv)
> -     char *netid;
> -     int argc;
> -     char **argv;
> +rpcbaddrlist (
> +     char *netid,
> +     int argc,
> +     char **argv)
>   {
>     rpcb_entry_list_ptr head = NULL;
>     struct timeval minutetimeout;
> @@ -1143,9 +1126,7 @@ rpcbaddrlist (netid, argc, argv)
>    * monitor rpcbind
>    */
>   static void
> -rpcbgetstat (argc, argv)
> -     int argc;
> -     char **argv;
> +rpcbgetstat (int argc, char **argv)
>   {
>     rpcb_stat_byvers inf;
>     struct timeval minutetimeout;
> @@ -1379,10 +1360,10 @@ rpcbgetstat (argc, argv)
>    * Delete registeration for this (prog, vers, netid)
>    */
>   static void
> -deletereg (netid, argc, argv)
> -     char *netid;
> -     int argc;
> -     char **argv;
> +deletereg (
> +     char *netid,
> +     int argc,
> +     char **argv)
>   {
>     struct netconfig *nconf = NULL;
>   
> @@ -1414,11 +1395,11 @@ deletereg (netid, argc, argv)
>    * Exit if cannot create handle.
>    */
>   static CLIENT *
> -clnt_addr_create (address, nconf, prog, vers)
> -     char *address;
> -     struct netconfig *nconf;
> -     u_long prog;
> -     u_long vers;
> +clnt_addr_create (
> +     char *address,
> +     struct netconfig *nconf,
> +     u_long prog,
> +     u_long vers)
>   {
>     CLIENT *client;
>     static struct netbuf *nbuf;
> @@ -1456,11 +1437,11 @@ clnt_addr_create (address, nconf, prog, vers)
>    * sent directly to the services themselves.
>    */
>   static void
> -addrping (address, netid, argc, argv)
> -     char *address;
> -     char *netid;
> -     int argc;
> -     char **argv;
> +addrping (
> +     char *address,
> +     char *netid,
> +     int argc,
> +     char **argv)
>   {
>     CLIENT *client;
>     struct timeval to;
> @@ -1583,10 +1564,10 @@ addrping (address, netid, argc, argv)
>    * then sent directly to the services themselves.
>    */
>   static void
> -progping (netid, argc, argv)
> -     char *netid;
> -     int argc;
> -     char **argv;
> +progping (
> +     char *netid,
> +     int argc,
> +     char **argv)
>   {
>     CLIENT *client;
>     struct timeval to;
> @@ -1729,8 +1710,7 @@ usage ()
>   }
>   
>   static u_long
> -getprognum (arg)
> -     char *arg;
> +getprognum (char *arg)
>   {
>     char *strptr;
>     register struct rpcent *rpc;
> @@ -1761,8 +1741,7 @@ getprognum (arg)
>   }
>   
>   static u_long
> -getvers (arg)
> -     char *arg;
> +getvers (char *arg)
>   {
>     char *strptr;
>     register u_long vers;
> @@ -1784,10 +1763,10 @@ getvers (arg)
>    * a good error message.
>    */
>   static int
> -pstatus (client, prog, vers)
> -     register CLIENT *client;
> -     u_long prog;
> -     u_long vers;
> +pstatus (
> +     register CLIENT *client,
> +     u_long prog,
> +     u_long vers)
>   {
>     struct rpc_err rpcerr;
>   
> @@ -1806,10 +1785,10 @@ pstatus (client, prog, vers)
>   }
>   
>   static CLIENT *
> -clnt_rpcbind_create (host, rpcbversnum, targaddr)
> -     char *host;
> -     int rpcbversnum;
> -     struct netbuf **targaddr;
> +clnt_rpcbind_create (
> +     char *host,
> +     int rpcbversnum,
> +     struct netbuf **targaddr)
>   {
>     static char *tlist[3] = {
>       "circuit_n", "circuit_v", "datagram_v"
> @@ -1842,11 +1821,11 @@ clnt_rpcbind_create (host, rpcbversnum, targaddr)
>   }
>   
>   static CLIENT *
> -getclnthandle (host, nconf, rpcbversnum, targaddr)
> -     char *host;
> -     struct netconfig *nconf;
> -     u_long rpcbversnum;
> -     struct netbuf **targaddr;
> +getclnthandle (
> +     char *host,
> +     struct netconfig *nconf,
> +     u_long rpcbversnum,
> +     struct netbuf **targaddr)
>   {
>     struct netbuf addr;
>     struct addrinfo hints, *res;
> @@ -1898,9 +1877,7 @@ getclnthandle (host, nconf, rpcbversnum, targaddr)
>   }
>   
>   static void
> -print_rmtcallstat (rtype, infp)
> -     int rtype;
> -     rpcb_stat *infp;
> +print_rmtcallstat (int rtype, rpcb_stat *infp)
>   {
>     register rpcbs_rmtcalllist_ptr pr;
>     struct rpcent *rpc;
> @@ -1924,9 +1901,7 @@ print_rmtcallstat (rtype, infp)
>   }
>   
>   static void
> -print_getaddrstat (rtype, infp)
> -     int rtype;
> -     rpcb_stat *infp;
> +print_getaddrstat (int rtype, rpcb_stat *infp)
>   {
>     rpcbs_addrlist_ptr al;
>     register struct rpcent *rpc;
> @@ -1945,8 +1920,7 @@ print_getaddrstat (rtype, infp)
>   }
>   
>   static char *
> -spaces (howmany)
> -     int howmany;
> +spaces (int howmany)
>   {
>     static char space_array[] =	/* 64 spaces */
>       "                                                                ";


