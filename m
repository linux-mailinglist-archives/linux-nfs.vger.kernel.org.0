Return-Path: <linux-nfs+bounces-19865-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG3bKFxprGnPpQEAu9opvQ
	(envelope-from <linux-nfs+bounces-19865-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 07 Mar 2026 19:07:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BAC22D283
	for <lists+linux-nfs@lfdr.de>; Sat, 07 Mar 2026 19:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78C07300ACA3
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Mar 2026 18:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1363332E729;
	Sat,  7 Mar 2026 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFq52zdW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDwfKGaK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69736B07B
	for <linux-nfs@vger.kernel.org>; Sat,  7 Mar 2026 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772906842; cv=none; b=N5l3OmsOabLkbDdEcl8Ri6F4mBx6w2R1/fzFC05ojBkIi6unIKLzJeVLOy3jUsVVcK3M+1sVILtRDhoVpdgGYPkEeUavSh0jDaSDziSaiCzWcP1lUy6B+xKqfP+gQxz8QMU/GRkIZdw885PYPAVHRbSgbq2Cs8uptt1muNoouHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772906842; c=relaxed/simple;
	bh=jlszh24sCYniRVgi7buG+Z4iSsIQXXpj0sO3WBpe/lo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=sMiYAzPfh9e7ZkGKwNTnCz0Qq2cVlwA0j+Qy8IPBiS7M53rJxbr21NDc5viakbB39qZroRVOHr7/4o0r5Sc/4xM0PBqXWOpbQjWK9tOhallcPuER84m/ZVT4LSvePPzeKCMxsdfxRySOxxYPxKewZoSXApCgXNDeglN0PAR/Pi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFq52zdW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDwfKGaK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772906839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sVby9sUfDHZTb2s4P5uq0Eo4wg3NJ+2ERT24UxDx7o=;
	b=OFq52zdWvRoItWgpcrQb+NdLdvb3sIfIv//klJAWl3ivb2ZRzF62Uj7lvhLFLMmTWX1fUu
	3SupHs662Na5z8ydTmm9Sm2iWR34sg8hI64MjXA4/IW/ymAeCsgJFbWj0xnRzXIUzAEN9p
	4vAeAL3KeJkfq22popLeXZaAcFq7gDI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-PD_CnCsMOza_mIky5Dsz8Q-1; Sat, 07 Mar 2026 13:07:17 -0500
X-MC-Unique: PD_CnCsMOza_mIky5Dsz8Q-1
X-Mimecast-MFC-AGG-ID: PD_CnCsMOza_mIky5Dsz8Q_1772906837
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89a0013d87bso390346446d6.2
        for <linux-nfs@vger.kernel.org>; Sat, 07 Mar 2026 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772906836; x=1773511636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sVby9sUfDHZTb2s4P5uq0Eo4wg3NJ+2ERT24UxDx7o=;
        b=FDwfKGaKEX/KlVtetDU96C91VDnSlQ8BToqWEs4Hs8UFOUvN/tCTv21mMt8CpBHgKf
         oNMcwkQ82ZxRvkl881DP54WQjHukN3/+hMq8KonIsWAU6RsCYHjDILOdyM3I22zdPfTg
         eHjPAhNkyO709XzfLJFCkN/tnyEp+edDmU5ITMZmLR+OlV/PPKtdI9ffqp2C29q4eQPG
         sb6t8FatrXN0ZCtNYVrMjmqdcYtTicjZnO7jIJ96d9AMvFWw+SQ8YPEzUTt/U5GImRnn
         MoklVZQGiUVpevYiiJVFAOM5gPJg3erqB0Fn/p4Ry06jKqhaHtIFTv5hgfn7CFqYZ4HF
         p9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772906836; x=1773511636;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3sVby9sUfDHZTb2s4P5uq0Eo4wg3NJ+2ERT24UxDx7o=;
        b=xAoEvrkES6z0oEIWAxpJ5XR2oLjZ1UgalGZS/eyXDSndfZF0noAciDABtDQNjOXMjV
         q3zUcqrCmnDQpCVeZLLpQC3WlqGKVsKg4d85QlbRnocmajZb7vKhkItpwPRw1jnNHMhW
         egE3j4D3HVvrE6SeRE6u9GFTUi2raROl8Oo4pRtBJbHPKbnSGMENlYui9yv9PF88LZF8
         9hTtzKuuoqoFuerHl64W+izI+ca8d6FoUUnnV4xTKNyuLbu6l/Ux4FCEWCCUt9GiuvPT
         4rMOMSqDAJRgK2PHCBpmmCVFivz2ZSe2LlJgHSAoKY8Ni9EIQM7UzyIwtPTodzdp60qu
         FT8A==
X-Gm-Message-State: AOJu0Yxa23P7NZ46+sgsw17n/17Z2lv8ShUZdAA9I7tIO7sUROtUkYyN
	9qaF1+TyqjUyGcyJBYB0/v1ayTREIpNqHdhbnWoj3Ru5M+op2i8iDn/698L8O0LCtrQsTGniMCA
	nig4XR+aXynoGsr6kHl1w8r1XKxgzl/NOTj4+4RafCw9/e/GOyfLIWrdL0Egvolr797FpaG+4iY
	IRk2CgR6nOOHCxd+TrF7++JGa53OVSA63rxLiEMegd4+Q=
X-Gm-Gg: ATEYQzwacoPJEP+hYbz7G1iFt/7Rb0Vi8VpAdaXZ8pYTWfbr0lgwJvUPrADp0JW7SAR
	+uqCeaSd8hUICYIu6xP+tYtNzQkoXUjNdS48+mSnNi0PNLJ9lwzZrL55c8fyiFw1c2c1sWu0edk
	6rP/iZBBZ3I8YdeHYri7/ZpuA8eEqDJuvbNb3e0NDzWoa9N2T1wFrwl2ng285BbIGv3rQ1JD1gf
	tGN55LjHWPWrbCaokiIyJrLykzUeph412CVc9GhgZuE+kMSCSv0y3HHVvA16R2LLs4h26ZlrVxV
	JpB+tgMvtwEq+MLRVhRk5nAtlUn1V7Tp9xop4LYne3nFCkUCif74NywPQQRic00XkbhhB6BIAJ/
	RORjNxDtgPAk+u+OC7wcp
X-Received: by 2002:a05:6214:e4c:b0:897:255:d5c2 with SMTP id 6a1803df08f44-89a30a4d3cdmr88977396d6.26.1772906836018;
        Sat, 07 Mar 2026 10:07:16 -0800 (PST)
X-Received: by 2002:a05:6214:e4c:b0:897:255:d5c2 with SMTP id 6a1803df08f44-89a30a4d3cdmr88976916d6.26.1772906835399;
        Sat, 07 Mar 2026 10:07:15 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3140e6c9sm42575366d6.2.2026.03.07.10.07.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 10:07:14 -0800 (PST)
Message-ID: <45d9dc7f-6445-4d5b-abdc-d0ff1b255b45@redhat.com>
Date: Sat, 7 Mar 2026 13:07:13 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] rpc.mountd CVE-2025-12801 announcement
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20260305155948.11261-1-steved@redhat.com>
Content-Language: en-US
In-Reply-To: <20260305155948.11261-1-steved@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 49BAC22D283
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19865-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/5/26 10:59 AM, Steve Dickson wrote:
> Vulnerability discovered in rpc.mountd in the nfs-utils package
> 
> A vulnerability was recently discovered in the rpc.mountd daemon in the
> nfs-utils package for Linux, that allows a NFSv3 client to escalate the
> privileges assigned to it in the /etc/exports file at mount time. In
> particular, it allows the client to access any subdirectory or subtree
> of an exported directory, regardless of the set file permissions, and
> regardless of any 'root_squash' or 'all_squash' attributes that would
> normally be expected to apply to that client.
> 
> The vulnerability does affect all known instances of the Linux kernel
> NFS server exporting the NFSv2 and/or NFSv3 protocols. It does not
> affect those Linux kernel NFS servers that only export filesystems
> using the NFSv4 protocol.
> 
> This issue has been fixed in nfs-utils 2.8.6 and later, with an upgrade
> advised for all users.
> 
> Trond Myklebust (4):
>    mountd: Minor refactor of get_rootfh()
>    mountd: Separate lookup of the exported directory and the mount path
>    support: Add a mini-library to extract and apply RPC credentials
>    Fix access checks when mounting subdirectories in NFSv3
> 
>   aclocal/libtirpc.m4         |  12 +++
>   nfs.conf                    |   1 +
>   support/include/Makefile.am |   1 +
>   support/include/nfs_ucred.h |  44 ++++++++++
>   support/include/nfsd_path.h |   8 ++
>   support/misc/Makefile.am    |   2 +-
>   support/misc/nfsd_path.c    |  59 +++++++++++++
>   support/misc/ucred.c        | 162 ++++++++++++++++++++++++++++++++++++
>   support/nfs/Makefile.am     |   2 +-
>   support/nfs/ucred.c         | 147 ++++++++++++++++++++++++++++++++
>   utils/mountd/mountd.c       | 111 +++++++++++++++++++-----
>   utils/mountd/mountd.man     |  26 ++++++
>   12 files changed, 552 insertions(+), 23 deletions(-)
>   create mode 100644 support/include/nfs_ucred.h
>   create mode 100644 support/misc/ucred.c
>   create mode 100644 support/nfs/ucred.c
> 
Committed... (tag: nfs-utils-2-8-6-rc5)

steved.


