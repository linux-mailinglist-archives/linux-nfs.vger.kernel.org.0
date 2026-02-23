Return-Path: <linux-nfs+bounces-19136-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIB3IglxnGmcGAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19136-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 16:23:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E258E178AD2
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 16:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98BC33059AA1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF5E28505E;
	Mon, 23 Feb 2026 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQV5w5uU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvQz7P+7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882F927A107
	for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860006; cv=none; b=QhIYFco6WU0ux8XiF2X5Dnk4FBK8ckF9dtoYJltMFWWHtV+JsBt2bqSvCsKcOMgvlbZvBe8bDVGzHVNFO3Z4PkxRs4StKnaslAUnAVNkBmnTi5+1JA+c5bdtvMjn94Kxx5NFANuaysqWjzLiaKt7uPer6+BzqXtjvi8AehSJv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860006; c=relaxed/simple;
	bh=SMW54dkMxPwApN7cZmHnt7Uc0G2zXI8pUknWzsEed8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ht8iqVC1xQ0Nw38VvylbR8LzkjPFONgpk/gmPzxXsI3ItlQETEhqQEkEVSt9jIO8fBYjcxtnkliuv1ulWzZUC2s5Sj/Gf6n9oBZzJqH70FzDAV7RtXZM9GNxu4sghwllVJu/wNkfaIuitHknurdzeH/gDRaSxhtAGvTuWMjfR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQV5w5uU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvQz7P+7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771860004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pK2XtuQTTUx1Xy7HvCkO6jj5LO3P5vXMOu99U5zkxZs=;
	b=OQV5w5uU8isFV/BZTua0bHsMNwwhAoaeBtq3BUmaKHzYlkMUlKMNtiKddJSHgv0zO5k0u0
	9C4tDSPehCRxXfV/K332eS1NZmR8DNpJ5MTA1kDtpssKo21G8eSIjrDxN1A2gZRSm4zJGa
	yhxZTWSxj9LhKuVQQn/DDo4Fzno6xLo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-FGLVvieIONudVjMKNFrCtA-1; Mon, 23 Feb 2026 10:20:02 -0500
X-MC-Unique: FGLVvieIONudVjMKNFrCtA-1
X-Mimecast-MFC-AGG-ID: FGLVvieIONudVjMKNFrCtA_1771860002
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb403842b6so4756751085a.1
        for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 07:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771860002; x=1772464802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pK2XtuQTTUx1Xy7HvCkO6jj5LO3P5vXMOu99U5zkxZs=;
        b=QvQz7P+7dRzQNtUBInKjX9wq9iEWa81fE/+CYeloF9DZEroIgepQ99Uljc51jPzuLc
         LwaoQiOTPExCtqhhtGiqDOCieC3L1ZCa7LJt1kBONl+9S7eByK9D8QJ5ZOLuvQ/xaa67
         i9zEZtQ0D5iDdKIagP+7EUoESfLEqmkvO9lEMWZ2MUmVW62KK1SgLx76PbPp2yo0GdyH
         FBXVWWAVXyQzNxgHFM9w7fvXzmmtoNs3jrshrmucuq9BukPH0977KPADiw2Ajrtxwbbb
         /RC32SnAHVehGneL1M072wRjDXrtoRoVmC/AvNsowAGnV0gMDkjLJ2P0d5ChRjSXA/ZO
         KvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771860002; x=1772464802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pK2XtuQTTUx1Xy7HvCkO6jj5LO3P5vXMOu99U5zkxZs=;
        b=mgu6fZt2TSeanDVjcpdMbBrj5IWUH8tsJ4KRHZbm/3FuAXe0I1m0pjBJhgIzliFPEG
         ZFGx3MGTNipEcZgDza6Jz6oQmZ4uouyf9/wEkjwELnoTLnNf5NdFkzspzd5tpdyhZok9
         CDsMgqdUvMpJ6UKt7sS2uDEVZzWF+mdAj/MGTp11NKIoF/B6A/maMXKcA6bjEqma+4Rm
         IhswjUPTkYTm5BTdmWA9fClHNYbZu0CNxPerataHzrK1CUhXRARXhJf4AlIHNlhojngG
         Nr4rUZ6W+hm2Qs3fQfYv7EfWuex9kyjkfZAiGr7lNZ0wzsJd0oMhehdlVlOfM+3BYvUN
         soyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp9DkabLehJ2DpxLi/IfBMhDN1qQbxQkFg/fpazIZC8RkPlaXF9nJaOauC4mcyBnqo0FF7BHRg2rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlC1ItjDlZjHG9XzKjfai4e8EHxfovSZyTl7hB3et/8C0th/vi
	Fv4OLwGKOo4oRt3QlvR+ybnH0lBZC6IxhGk2p6+23bnuGOSx9/I2E773SLLb8yJZ0u58z31SUBu
	JwA7SMhbpsx52v4TSFqUho+QJhCPA+9/fGhckRnz48Cmw3ImIOBAKfDkspYvzdQ==
X-Gm-Gg: AZuq6aLxTSxHpuvywWej3Z/FQ02LokziuEBFqKH/3t2Fc57YOd2uBGRMrTNdjCpxR+g
	AFxccl+9BZCqvTfl0zqzPscUWUNlaKiyVKnPJpa/BWYJ62XViTUWPripbuP2QN36Rk8/zkmHXYF
	ehuGKEloF3htlMwFTJfY1HeGEpkV2swEBS4Gl23zm/o9SbtrwFJuyL12RshU7+Om0xyxLP1vlrS
	bAUcoU7ZZznVSP4O6f/+lxjLJp72xZCXOSnLXumF+5D3GnkZUxUAnmRsmGy2eXvD8FxqWD0Re69
	/WskXEmk7ysdzZAlt6R3ye0oTK1JRPIWgFpohKb5YBwR22qnFVarZOjw/sQYNvOOCzpcz//E8Dv
	d8aRRpQ+BcELH64vopYcd
X-Received: by 2002:a05:620a:3943:b0:8ca:3c67:891d with SMTP id af79cd13be357-8cb8ca76d85mr1058013885a.54.1771860001864;
        Mon, 23 Feb 2026 07:20:01 -0800 (PST)
X-Received: by 2002:a05:620a:3943:b0:8ca:3c67:891d with SMTP id af79cd13be357-8cb8ca76d85mr1057995985a.54.1771859999911;
        Mon, 23 Feb 2026 07:19:59 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d1202e2sm728593185a.44.2026.02.23.07.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 07:19:57 -0800 (PST)
Message-ID: <2e309a9f-9e3c-4de8-9435-efdb36a6f4f4@redhat.com>
Date: Mon, 23 Feb 2026 10:19:57 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v2 0/4] nfsdctl: properly handle older kernels
 that don't support min-threads
To: Jeff Layton <jlayton@kernel.org>
Cc: Ben Coddington <bcodding@hammerspace.com>,
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
References: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19136-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E258E178AD2
X-Rspamd-Action: no action



On 2/4/26 11:48 AM, Jeff Layton wrote:
> Ben reported a problem with using new userland with old kernel. If he
> tried to send down a setting that the kernel doesn't support, it returns
> -EINVAL to the call.
> 
> This patch series adds a mechanism for nfsdctl to tell what attributes
> are supported by the "threads" command. If can then use that to
> determine whether to pass down the min-threads attribute or report an
> error or warning.
> 
> This also removes the dependency on the UAPI headers by properly
> maintaining the private nfsd_netlink.h file.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Committed... (tag: nfs-utils-2-8-6-rc1)

steved.
> ---
> Changes in v2:
> - Add patch to unconditionally compile in min-threads support
> - Make getpolicy_handler() return NL_SKIP
> - Link to v1: https://lore.kernel.org/r/20260204-minthreads-v1-0-9f348608f884@kernel.org
> 
> ---
> Jeff Layton (4):
>        nfsdctl: unconditionally enable support for min-threads
>        nfsdctl: only resolve netlink family names once
>        nfsdctl: query netlink policy before sending the minthreads attribute to kernel
>        nfsdctl: remove unneeded newlines from xlog() format strings
> 
>   configure.ac                 |   6 +-
>   utils/nfsdctl/nfsd_netlink.h |   2 +
>   utils/nfsdctl/nfsdctl.c      | 204 ++++++++++++++++++++++++++++++++++---------
>   3 files changed, 168 insertions(+), 44 deletions(-)
> ---
> base-commit: 8f54511aefe1455161a6c4406ed8c770139f61e3
> change-id: 20260203-minthreads-402ce87096e0
> 
> Best regards,


