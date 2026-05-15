Return-Path: <linux-nfs+bounces-21636-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH/5KQ8YB2qYrgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21636-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 14:56:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF02550026
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 14:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10D12300D1C5
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 12:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF134266581;
	Fri, 15 May 2026 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLVCYe7N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nlPP4voE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B1B273803
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849565; cv=none; b=g1fc+JLkDzVj8X1F7VSwkUQ2CjsEx6wpmmNsRhT57Rnob5kab0MtUR4SBudJOHFCR3DruAiHq/AyBRtfeYMDz9YFa10lFW/HNm9MK5Ic1KurI+gqTHTpTsAG/dUuLqlGvz/km8HZrXljPkk43t+bH/qy58IH55oUIA0DWIfuQk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849565; c=relaxed/simple;
	bh=QNOClf6hc5XIi7Dgst4MPSvMc+eLqvteBf2W9EnMJEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Txu75FaAfz+A05MGjfIuoQnEcYGbLgn8skDNx8GszToWHmg+Imr1I0hlpI/oJi+jTkaEAM4gLDin5yGMxvizrysRwJ3Ex3UunIas4NfzWnvkeudis4wcgryDHU2Bv5p7YxDmHw7NyExGsTLgurYpoNsV2KC0Q/DXgocPPMqumyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLVCYe7N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nlPP4voE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778849562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4kHQjIpHGpiKqWr9KQxdFJPb5oWwnEpR2nX/D3buC6g=;
	b=WLVCYe7NtJWGyykKKHUi2tpjVUpbwgujl8HRTHoDJ5n5qEgSF9R7bLkR3FXu8IQ+54NOGa
	9nkkB7k8hZzZ63npl9GeDSwDoxNI9nqiEG1CiYWqgs2+r6al7f46scYMArDnlksgkqgBhU
	vL9n4Z54KtzCtLufyKqoStMTDaOnY7Y=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-IQ5u_n79O-KvvrUecBuZXg-1; Fri, 15 May 2026 08:52:41 -0400
X-MC-Unique: IQ5u_n79O-KvvrUecBuZXg-1
X-Mimecast-MFC-AGG-ID: IQ5u_n79O-KvvrUecBuZXg_1778849561
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-909120afff9so700645085a.1
        for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 05:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778849561; x=1779454361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4kHQjIpHGpiKqWr9KQxdFJPb5oWwnEpR2nX/D3buC6g=;
        b=nlPP4voEmdFkM7VkehPtxOI8mmhET/PzLlWLE0ji1QUs9JKVnKPzc0Yvz/jsVvXNU4
         l/KqrBN4tWJLIxKediChSD94x5n4PTar44x+Ux9UyGuZsrLSF71NaSFWOY/ouj3RchTY
         6KbVD7PPwU5aSy/dLKwOj7TH6q3PVKizW7DUP8AWcJJq5WziAT7L48u2m3e2DfsUBN1F
         YQz9gOrHQZbdfbECzxXrn2d9ED77FROSrCMCKLmnBbHQUuxHefkyItUDPUYbP2xnx9Ah
         nXYV0DOXKQwad2JkJKJqJjSrn3kHTtwy/I0hHhD2LSm9tENrArkKpOWwLsClow4v/B1v
         MKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849561; x=1779454361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kHQjIpHGpiKqWr9KQxdFJPb5oWwnEpR2nX/D3buC6g=;
        b=eK2tjQZ5pQc5TccI0xyjockjWSROl31icQe8BmIzA3bW00CV/zLK5PVLL6DTHDNsYy
         8pwjFX731tALmnOgJVl4/+tAeRbRn9oTGYckAFOXho+f+qgaR2tMlyvrIExW2lfP4Ujz
         LkIYSEIXIB7HuOkPOuzWJ7F2WLhx9JeBlvohQKDaXtzc+wCXar0CeelT6Gm8OkeJ/bZS
         ycxHsxAehwIlszARGISAApqJLFBj1JBmdLeqWo8XfKZv/vGR6Dgv9n/UUOTi8XxMNRkP
         EdZ34HRDMZoScBMG1gIMBgPkI+myvrF9Txs+IRkiRgGCwkfta+M6TxPv/Hz5ZyYN+mYv
         jf/Q==
X-Gm-Message-State: AOJu0YwwHNDKLxpBi7KU0fF80Ee3GS5t+A9wqV9O4yyal5487SPOEH5B
	h/VwMSRVMWxrfUbxDaNxe1RR8dGrv/wXvcv51AbOhgU60NXF40bI2m1hUCrwEEBwK7LncZ+hjE/
	bBVQv6yEQacVz2GKkupOXpkxlWHQG/n+MUPftt1RslFT2e2hgEuKTwP1rIrlS/Q==
X-Gm-Gg: Acq92OFF20otcGAuw9QXZikVcZlVHDixo8VRvTzqXjZTb8qkWR4kTMr6e/+hMJ5hucx
	5sENGTarwHSbsw6ggkvfFWVU3WM/IqrJSfnM5lTctDPHktyZB7zI9zPUH5DZB7V67uNwFMP3OV5
	E0wEkBRAwsg+tChr+0fsGWaM7jdP6wcBqJARmzuPX4y8Xb7tMPKwrXDk+1PGsJ8mZ0BvycNf3/w
	5iDBOmXKPBts22F6j1QbUvzpfuN3RgFzuIRsNFSgAmMy78y3OUlIpa2Ji4Up5C9a6g96WHtYRC4
	+z2II4oFpcxl4A/hyM/dw0oIpg0IW3U2Km0eB24iO8Lsclj7pGxkH6bXQNRKnatRLAFvYXFWJoN
	7sFuJuHaOvFmiwDU53sKYEg==
X-Received: by 2002:a05:620a:4046:b0:912:c611:8110 with SMTP id af79cd13be357-912c61187ffmr55016785a.46.1778849560849;
        Fri, 15 May 2026 05:52:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4046:b0:912:c611:8110 with SMTP id af79cd13be357-912c61187ffmr55012085a.46.1778849560277;
        Fri, 15 May 2026 05:52:40 -0700 (PDT)
Received: from [10.17.16.21] ([144.121.52.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83bbf5sm537382985a.28.2026.05.15.05.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 05:52:39 -0700 (PDT)
Message-ID: <76589a96-28b0-4f43-8448-5c88bbef11b0@redhat.com>
Date: Fri, 15 May 2026 08:52:38 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exportfs: drop unused is_export parameter from
 xtab_read() and xtab_write()
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20260514-exportd-v1-1-be603d7fac41@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260514-exportd-v1-1-be603d7fac41@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4BF02550026
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-21636-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



On 5/14/26 3:40 PM, Jeff Layton wrote:
> The is_export parameter is always passed as 1. Remove it and simplify
> both functions by eliminating the dead is_export == 0 code paths.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Committed (tag: nfs-utils-2-9-2-rc3)

steved
> ---
>   support/export/xtab.c | 39 +++++++++++++--------------------------
>   1 file changed, 13 insertions(+), 26 deletions(-)
> 
> diff --git a/support/export/xtab.c b/support/export/xtab.c
> index 282f15bc79cd..0a9660512b26 100644
> --- a/support/export/xtab.c
> +++ b/support/export/xtab.c
> @@ -33,11 +33,8 @@ int v4root_needed;
>   static void cond_rename(char *newfile, char *oldfile);
>   
>   static int
> -xtab_read(char *xtab, char *lockfn, int is_export)
> +xtab_read(char *xtab, char *lockfn)
>   {
> -    /* is_export == 0  => reading /proc/fs/nfs/exports - we know these things are exported to kernel
> -     * is_export == 1  => reading /var/lib/nfs/etab - these things are allowed to be exported
> -     */
>   	struct exportent	*xp;
>   	nfs_export		*exp;
>   	int			lockid;
> @@ -45,11 +42,10 @@ xtab_read(char *xtab, char *lockfn, int is_export)
>   	if ((lockid = xflock(lockfn, "r")) < 0)
>   		return 0;
>   	setexportent(xtab, "r");
> -	if (is_export == 1)
> -		v4root_needed = 1;
> -	while ((xp = getexportent(is_export==0)) != NULL) {
> -		if (!(exp = export_lookup(xp->e_hostname, xp->e_path, is_export != 1)) &&
> -		    !(exp = export_create(xp, is_export!=1))) {
> +	v4root_needed = 1;
> +	while ((xp = getexportent(0)) != NULL) {
> +		if (!(exp = export_lookup(xp->e_hostname, xp->e_path, 0)) &&
> +		    !(exp = export_create(xp, 0))) {
>                           if(xp->e_hostname) {
>                               free(xp->e_hostname);
>                               xp->e_hostname=NULL;
> @@ -60,17 +56,10 @@ xtab_read(char *xtab, char *lockfn, int is_export)
>                           }
>   			continue;
>   		}
> -		switch (is_export) {
> -		case 0:
> -			exp->m_exported = 1;
> -			break;
> -		case 1:
> -			exp->m_xtabent = 1;
> -			exp->m_mayexport = 1;
> -			if ((xp->e_flags & NFSEXP_FSID) && xp->e_fsid == 0)
> -				v4root_needed = 0;
> -			break;
> -		}
> +		exp->m_xtabent = 1;
> +		exp->m_mayexport = 1;
> +		if ((xp->e_flags & NFSEXP_FSID) && xp->e_fsid == 0)
> +			v4root_needed = 0;
>                   if(xp->e_hostname) {
>                       free(xp->e_hostname);
>                       xp->e_hostname=NULL;
> @@ -90,7 +79,7 @@ xtab_read(char *xtab, char *lockfn, int is_export)
>   int
>   xtab_export_read(void)
>   {
> -	return xtab_read(etab.statefn, etab.lockfn, 1);
> +	return xtab_read(etab.statefn, etab.lockfn);
>   }
>   
>   /*
> @@ -100,7 +89,7 @@ xtab_export_read(void)
>    * fix the auth_reload logic as well...
>    */
>   static int
> -xtab_write(char *xtab, char *xtabtmp, char *lockfn, int is_export)
> +xtab_write(char *xtab, char *xtabtmp, char *lockfn)
>   {
>   	struct exportent	xe;
>   	nfs_export		*exp;
> @@ -114,9 +103,7 @@ xtab_write(char *xtab, char *xtabtmp, char *lockfn, int is_export)
>   
>   	for (i = 0; i < MCL_MAXTYPES; i++) {
>   		for (exp = exportlist[i].p_head; exp; exp = exp->m_next) {
> -			if (is_export && !exp->m_xtabent)
> -				continue;
> -			if (!is_export && ! exp->m_exported)
> +			if (!exp->m_xtabent)
>   				continue;
>   
>   			/* write out the export entry using the FQDN */
> @@ -137,7 +124,7 @@ xtab_write(char *xtab, char *xtabtmp, char *lockfn, int is_export)
>   int
>   xtab_export_write(void)
>   {
> -	return xtab_write(etab.statefn, etab.tmpfn, etab.lockfn, 1);
> +	return xtab_write(etab.statefn, etab.tmpfn, etab.lockfn);
>   }
>   
>   /*
> 
> ---
> base-commit: cbbf618b31b64198de06a350c4f5744c76e51ecb
> change-id: 20260514-exportd-ceb123e6fff2
> 
> Best regards,


