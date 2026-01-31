Return-Path: <linux-nfs+bounces-18626-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDF7C21VfmlPXQIAu9opvQ
	(envelope-from <linux-nfs+bounces-18626-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 20:18:05 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 876F0C3A3C
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 20:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79C91301ABA7
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 19:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237F835D5E1;
	Sat, 31 Jan 2026 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4HGd38p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9916E2F0C45
	for <linux-nfs@vger.kernel.org>; Sat, 31 Jan 2026 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769887081; cv=none; b=X1SmbIkffHx/WjZo4KMGxKLwGu//M58x/zid/DjXK6zKZHnhlciZYw6ETzxV98AUyIvTSqpfwNeuPZzwPDjwoa7ufV9N7yPmXY3g59aulvxIE5IlIEKp3gjuJS5VH1S3FIYcoOCUsXcuMEf6NLv5kn42lER4ulO/LUaAEHDzGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769887081; c=relaxed/simple;
	bh=e/PfmY0FE7C+k2IGJX/fiRIBv+reifdPxa3dhe5Et6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKfEmmLhhM85BuTjC6iYutM4sN8JDJHfiPvKoEyK9F7Dpo6HCiz0r0x9ZzkFeg6ku49op+lMuJSYJkUsL54AMPMYIirqUwSz4syMenZ2GtyPy/XT728kmzbLxQOcHyjZ0zhDeasxGptvDgT3AtVH3gSDVIxTNMSE0e5pfqHus3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4HGd38p; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso33291305e9.2
        for <linux-nfs@vger.kernel.org>; Sat, 31 Jan 2026 11:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769887078; x=1770491878; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f2vXbp9S4vh8jrV4gBZZMI+qdSqhg08BiwZQDLQb1QY=;
        b=T4HGd38paX14AxxXHGwDbhOo5zalJt3hbr/JP6UkKcO/xvNOf8vt6WLn1oHc7uvxm8
         JiSTw8BVfHjskMUc6cA0HibuaVkqIl3ZwelsjKfoofw5NYvhEENQbHx3pAKvIpcTeRwE
         3iUyDUo0lu0v/6IYq6Dybd0o1aqg1SWU6E4oLOe2k96oPqZJoxZwcaIS2y7PwEQ9MJN9
         hvTnbFP7SvERwY7BvFyzouRfL5RSve7QRAVZamoGgA0CyOnfIYyH4W39amuueEekGIf7
         2yY5eyAJOca7vfyVVev2T2LA+I9xzjG/Vgt6IJfRMVj5+K1AYVRWwdnY6VaRiKGwTNSb
         XLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769887078; x=1770491878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2vXbp9S4vh8jrV4gBZZMI+qdSqhg08BiwZQDLQb1QY=;
        b=VGQem+tePqYvj7u2rfPUAxnEtfSor4BhP36QCMN6gFhqC25QQ1YzvISrIUWLYlHZb4
         HDYz52RYmhfbIhJr0u4K+Q56auZSHq4PrJZZhZEwnRa5ylSdzRoyYFnnkDjpJtEkZCAU
         jFRba7TPkJ6n1KEhZ0CD+3pfNTxW83oCD1rZlH/ZNcIC2Ebkw12ePxnwpR1FJAHq4vIq
         9zW4R92tIKvwTtXM2u1XbJ3HbVmS+hOc6vAjtr7Eh/x2xSh2lzsnfJ24DwPo4fA5TeEl
         JGW7m+QBvWZAn5louJBW9eyQIGetkwGl47eFzMiH2Yfn2W78hX6jGfWbRKG5CsFA23qt
         bmyA==
X-Forwarded-Encrypted: i=1; AJvYcCUu9LnXsL/ZFuLc6dQBNaM/Z6pTnnZQw6hVGmbVKRY9ZedH7JXuiIfxs0cin1801Bnch1nIjmVfI98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5MfA5W4UYc/nxCWUsZIniwx42rpx81FjHCZeQ2AfAbNjCEL/Y
	kaB2uPhRQ9PwK132H1SNRE2GLInCZsbUCJtxFA9pxV1gTRbWGCEkhLgI
X-Gm-Gg: AZuq6aK1rqA0akSuzuClqJPMMiyGdryJ8FRtcjZZZQgOUVA+1qAJyqkH99xBxNlNRQ0
	Ha/WSPdTYBRBWfJhmJmrhGi2Rm6BsXSF4dSiVEepeSqmrdF17YOf7SBdM+Gv6ISbH5E4s9BpITY
	gWVi5c8rWIE1z5zl+csajPl48iZN8L3wEMqxemM8NbfFE9mIWXUgCKJpemwU8maGQ6890A24T29
	ZzP9udefVNzn4M97/76edg3MmPh5Z1TAsj9TenD20sehgG/XTPMtHrQLqNSc+FXuDlsd8yWNA38
	jQY30R4W3xBHADhNPju/Jx2EjzVv4ivAtl1ZCGx33gS9Wemlk2Jz6ga6r+4e5vvSMgFq7rCndr0
	fll90FX30NFwEj37Oyyt/on0Au3VqaeNG6BCcOZfAfvl7grababmB4AzGRTLt5zJe7cPyOehvsr
	GFjLwYqsaHNsk=
X-Received: by 2002:a05:600c:8b61:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-482db4567cbmr93509625e9.7.1769887077698;
        Sat, 31 Jan 2026 11:17:57 -0800 (PST)
Received: from pc ([196.235.54.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066be77b5sm328881815e9.2.2026.01.31.11.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 11:17:56 -0800 (PST)
Date: Sat, 31 Jan 2026 20:17:53 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Benjamin Coddington <bcodding@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: fix memory leak in nfs_sysfs_init if kset_register
 fails
Message-ID: <aX5VYbmg35vAw3IP@pc>
References: <20260131000937.229276-1-salah.triki@gmail.com>
 <9EF0F792-3B22-4A20-8A37-9C4B2236740C@hammerspace.com>
 <6d56e691114294ed3187e7a6f281c98293393a1a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d56e691114294ed3187e7a6f281c98293393a1a.camel@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18626-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[salahtriki@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 876F0C3A3C
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 11:54:06AM -0500, Trond Myklebust wrote:
> 
> If you take a look at kset_register(), you'll see that it does free the
> kobj.name pointer if there is an error when adding the kobject.
> 
> IOW: there is no bug in the current code.

Thanks for the clarification.

You're right, kset_register() already frees kobj.name on failure, and the
kobject is not fully initialized at that point. I double-checked the
error path in kset_register(), and the current cleanup in nfs_sysfs_init()
is correct.

Apologies for the noise — I'll drop this patch.

Thanks for taking the time to explain.

Salah

