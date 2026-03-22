Return-Path: <linux-nfs+bounces-20312-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML0jDVZRwGm3GAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20312-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Mar 2026 21:30:14 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBB32EAB36
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Mar 2026 21:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AF893003370
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Mar 2026 20:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3541DF248;
	Sun, 22 Mar 2026 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWvgs1/n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wy0oXbn5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD64A23
	for <linux-nfs@vger.kernel.org>; Sun, 22 Mar 2026 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774211410; cv=none; b=J9jxTwj4/95qlA6aD+KlmI9juw527nkdbVPMi8wrDloW5J2VwDEFAt6jseWmHe/4Xhc+aa8oSWbG+HQTA+DFMaFEvlM3pTQ89Hxj/whUgldwFLLUE4AF29phcP+93W3knioWFmkW03a1QsIhmj6zJvmHqJmOg7pyeNataL9Xa+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774211410; c=relaxed/simple;
	bh=5vGl8TPpKmyq9T5wP3ehIrds54MdxglVWjo7VST0mVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpLrq2IuDcrogllTtitTAvy1IQLnwKg7EV0waidDXiDsuxKCcD2qkoINIw3l8A2nVxVAhWOMeO8EynGj+3HiFMlOab/Ep5NRFBh/u/qX5gDZab+vF6+9/p64UkRbyOPiS3dKvIP/HzdQauoCDDC8f4E22rNLovc6KboxscRndKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWvgs1/n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wy0oXbn5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774211408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uieeOuvdtxWpUW1ijATEQyRKo7EuHdoTa4GUx9OwoIs=;
	b=GWvgs1/nFcqu0JOScrifRgqJ1YKbQb2cFiFz1JKdaHQPIChb1DuMnFc/L2jNw5duxyHeik
	3i5gDa0kaFLdludNMnsB9XWq1GlR9T8GzvFNdCJnqrkAx28Q2mH8pLlqQJepPOFaJ6LDZn
	JaENoZgL6d1Kq4MgEX0yx/fW9ZFgP/c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-PRTpV_-jPUiA50FJrSqwAA-1; Sun, 22 Mar 2026 16:30:06 -0400
X-MC-Unique: PRTpV_-jPUiA50FJrSqwAA-1
X-Mimecast-MFC-AGG-ID: PRTpV_-jPUiA50FJrSqwAA_1774211406
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89c4ec516e5so21196086d6.0
        for <linux-nfs@vger.kernel.org>; Sun, 22 Mar 2026 13:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774211406; x=1774816206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uieeOuvdtxWpUW1ijATEQyRKo7EuHdoTa4GUx9OwoIs=;
        b=Wy0oXbn57Df3a328lgJ7OM5gT9hXwjLmIl7ZWSQlnkIZqaIpyRGwOkgPl5VnZspcHt
         p2urFDcHds0ar1J2CdTqf2qUfYjk1SF85TyhmtIVshEb0XFG94apCBVafMwNtQE5fvzx
         Q/6jrblAxJ4mvMveh0hbgwzowv977mGxYimpfB3H+Km9WQ/eAzdkPhQxYQE7ZSGjLsci
         r0n+QzDKEi3svkaEA/ysMIy2nnZkLWctQahpMLdLG68uSgPw3DouU3fTVCAIog2ZW0Bh
         N7h9O0ZT/GfGlsfc+9EYZaxiPFWMTGqTh3zZYfl/4LQ8G1KTeGsDdU00T/3w4bF0duTn
         lTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774211406; x=1774816206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uieeOuvdtxWpUW1ijATEQyRKo7EuHdoTa4GUx9OwoIs=;
        b=kdhI7652gVllIeVjhgocPmkZQWPZbvqUjEaEkz7iG9rpnkeJrMjGaiwqdajErLyL5q
         Lb+qdo7U0gj8NF7Mxjct/QYav17eUszd7hm1Q8Ulqp8APlDtoJ8nxrWJ2U9DN2ohuHa0
         0oRWlmr1OXJukG/bGAG1zGgZdlKf3cJybs3O5PQ6FHNXmucpnRYnI/LkW+xuUvkrpXmd
         MC9JBJd3PPZKOLySF6nJvSxEkJkWW34xwbj0lfh37OlK9UsCxY8hef1uMc2wzLYlZI/i
         2aUtXcEq+JqeWjT5Ll7QB4vLCgeLCmZ9quq0eYKJa6vSQTF1Xha9LBb25qeZLC6/pYUc
         duVA==
X-Gm-Message-State: AOJu0YwpDlal2k2vSnSwz3qxMM1/GSePtloD6HkFsMj2YVRpjlHB1usp
	nPD3XDrTxeH4OBMp3E5J6THfpk93ms9KY/I8YUbWD8YT2MOcnZKOJM6Rw7lWKt7sSCsA7smqckI
	wQUXYV7UvchjS0gFhUDgF6RbiUyn0Fs1ItSUYbfuo5KF9OfsbAyKJ4+/S6QrO9Q==
X-Gm-Gg: ATEYQzxxG38BsgWBJQkMCXc8UdNOyIYrQvQNYqrOxFcvTCq/K41nL+3NO+Et8YfianK
	E49gtNSj7oy7ttjhOhK7eVGhTtTmjhxwLNP9psXk9ZkRVAG8A7NkFb5FfWbwRteyf66Zb3tzp9i
	JjR3l071WtW+BZqL+uLQemZtVmIg4FGX+JZ3EC36W/HPDF9IS8LekP2zlrSgB8oEB5KmRORFVWt
	pzr8il3XKxDz4XU+UUuI57eB63/LQLLASLIdCpdHEY18DA8A+WydcgG09DZQnUydKohxYBiNPeb
	J7xl7OoXwL/d0PnV/hG9VUNvgJrb5O3GMKEGZ+wGF76n13KyRMvi+JjYxaAtjUYq/35+0KcZhac
	GbOviKeT+Se3iCPyVeKJLaQ==
X-Received: by 2002:a05:6214:268b:b0:89a:360:3b72 with SMTP id 6a1803df08f44-89c85a78d0dmr166374776d6.46.1774211405937;
        Sun, 22 Mar 2026 13:30:05 -0700 (PDT)
X-Received: by 2002:a05:6214:268b:b0:89a:360:3b72 with SMTP id 6a1803df08f44-89c85a78d0dmr166374286d6.46.1774211405506;
        Sun, 22 Mar 2026 13:30:05 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.244.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c85237126sm71842646d6.12.2026.03.22.13.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 13:30:03 -0700 (PDT)
Message-ID: <a04afd6b-e295-4100-a785-2b6feb6b3cf7@redhat.com>
Date: Sun, 22 Mar 2026 16:30:02 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nfsd/nfsdctl: default to starting with v4.0 servers
 disabled
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20251008-master-v1-0-c879be4973c8@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20251008-master-v1-0-c879be4973c8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20312-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEBB32EAB36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 10/8/25 4:13 PM, Jeff Layton wrote:
> At this week's NFS Bakeathon, we had a discussion around deprecating the
> NFSv4.0 protocol. To prepare for that eventuality, make the NFS server
> only accept NFSv4.0 if it was explicitly requested in the config file or
> in command-line options.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (2):
>        nfsd: disable v4.0 by default
>        nfsdctl: disable v4.0 by default
> 
>   utils/nfsd/nfsd.c       | 5 +++--
>   utils/nfsdctl/nfsdctl.c | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)
> ---
> base-commit: 612e407c46b848932c32be00b835a7b5317e3d08
> change-id: 20251008-master-724587cca99a
> 
> Best regards,
Committed... (tag: nfs-utils-2-9-1-rc1)

My apologies for taking so long... The CVE
took longer than expected and there was
some issues with recent patches,
which caused another release..

Turning off a protocol version (v4.0)
on the server by default which this rc
release does, is not a small thing
although with the 7.X kernels the
v4.0 client is already off.

So the next rc releases will contain
the current outstanding patches (a rc
release for each patch set) then creating
another release (2.9.1)...

Definitely in time for the upcoming Bakeathon!

steved.



