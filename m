Return-Path: <linux-nfs+bounces-8329-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725DC9E2BFC
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 20:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C44EEBE55E6
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 16:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B3F1F76A4;
	Tue,  3 Dec 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGhdZpRU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D071F8918
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241744; cv=none; b=ogobNONAXNEBB4hN8w/NQU3bxf5lhnte63/OlpQsx41TnngaW5tdXXqD/Xo2cWJNaqEoIRObxOvIxEy8DcRZ9hyxJfJ1Z0nml4DSZUmaXvN0OuBsJZAeOvv8Ek8whtvOEcQQDPz2JvMSGESZSCFR8WgkGao/HqhFmQC1w2/W3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241744; c=relaxed/simple;
	bh=VBPkw8A8GZkmktt7nAjbfdFFM28sE1JXx6OCIu/3BSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THxzLIXUuq0UK5cwcsVwsI+2inIc/eQD5yjRWL19MN5tsZvFE97u1BLRV4AFyjoZWXvIDGnOFXDNymKHN8cuBK/nOiBBbeKhm/tfjylQqBIfWtoTOC3nbItStyBZ4eh+/RF8rNo8psmIIfq/qL89TiUvDC4qfn4B2kGqzJ1RRTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGhdZpRU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733241741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr2JEKSNH9mMX7Q32zz6AoC1+Mmy2k+3xBv1ybUJj0g=;
	b=HGhdZpRU1dMG9DHm+mPVU/mQYplrwL1/2K0nw4KUmTszlPak+/8BcUMnbjnyfVCQYP6gQ/
	Nqv8Or63gg24JQQLNtAAh8U3+VuSLPH9Egh97KVJmlw8ZM7mUX9EBHeYkku8Pcn+QEDzZB
	WKaz65e8xheXGo8I7nZVksEg1bzYp/I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-wqhcLXhoP5OGxc3MA-6pYQ-1; Tue, 03 Dec 2024 11:02:20 -0500
X-MC-Unique: wqhcLXhoP5OGxc3MA-6pYQ-1
X-Mimecast-MFC-AGG-ID: wqhcLXhoP5OGxc3MA-6pYQ
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46686a1565bso90207581cf.0
        for <linux-nfs@vger.kernel.org>; Tue, 03 Dec 2024 08:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733241739; x=1733846539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sr2JEKSNH9mMX7Q32zz6AoC1+Mmy2k+3xBv1ybUJj0g=;
        b=bf39VybS/y9IYtfioQJ46BGe8VUvGa1jUZR8xEjsH+KqfdmujPNAhQvAIWc0dvqOke
         s0THOewNFgqGCcax4KhuXOFKnEt3eqsJI4IUvaCwvyhBtNyRXSUnJRFUg8Hs8EWK4XnA
         JcwHqxQfhYuiAgAFwnAZn17IS5h1Ee8xQAE0Y42VSOF0ISxD4hsb8MFU91e9oBuwvMBP
         MXKzIlMiUWuYsTbUD1kZcceTt3XR0J2Wb5etf9gsmNeRBECNDuJes8LmakL2x5gdDEGS
         y+k8r1HfoyfEdKFkdweNChpzxPfsjVCfMi6JNNwFhHBK+ED7B0LYCQWH5sgChqs+r/9G
         XuEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVNrwwj4cR/u0+WK20kq5H1MH1NtlaxNDh0lUNi9xEoCzgZIfL/s91zbepvAOokhV5Fx5IU326DaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6DnY7TyiSjZL8j/oqHLtaVpFsrQzZglpgLv6Tc62scdKX0n6
	TK9aSKeZRu3PDaqf0FM+wQjJlIh6HijzSOibqG3G8BJD/lNjbTUd6UZFKIp0R/IZUMNBPkDGQPe
	LqOo/lGF2rw4hCoVq9sS4rdQhp5UJ9gqyf/DW8xDTTVPolwid1JKlqPJJXg==
X-Gm-Gg: ASbGncs+uqvkYQMWpjF5KuqJ9nsFjVx2eHrrwVEn2xIbOnZtIwFrLAY7+wjv1vfwsR1
	pLKj5BOxt/l2wu0dt+0tYNclM9jtQJELAVC1ZAkDXMhHuTxBxfwNaOYV80Xa+CqU/aR9IECOVU+
	ZZXcLXRMaN7UWxCi8Jk7qyKRlGY4FRV6ZE75E4YhVLsSK3za/wHr4UI/kv9retf0VsScHeU5ADG
	gVMzopQVT067AjdcGXi5sO08awUJ2xfGbvSOFuF/0KgBEv3lw==
X-Received: by 2002:ac8:5d4a:0:b0:460:aa51:840a with SMTP id d75a77b69052e-4670c3d16abmr29340451cf.45.1733241739271;
        Tue, 03 Dec 2024 08:02:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwPJ0UjVdMTbL7wu4OJ2K+HuMZhOGYKhECHt2PYw7dH50pOTlwTNh6YiS0Wfx600SY9iIykQ==
X-Received: by 2002:ac8:5d4a:0:b0:460:aa51:840a with SMTP id d75a77b69052e-4670c3d16abmr29340021cf.45.1733241738865;
        Tue, 03 Dec 2024 08:02:18 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c421f86dsm62619461cf.69.2024.12.03.08.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 08:02:17 -0800 (PST)
Message-ID: <5bd739e8-e4ed-446a-b443-2554dc20d57c@redhat.com>
Date: Tue, 3 Dec 2024 11:02:16 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] exports: Fix referrals when
 --enable-junction=no
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Scott Mayhew <smayhew@redhat.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
 <20241202203046.1436990-1-smayhew@redhat.com>
 <6b8990cc-ec29-4e01-acd6-8c7ec6487d99@redhat.com>
 <A47A9D21-EF59-4263-AC63-059FB0661CA8@oracle.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <A47A9D21-EF59-4263-AC63-059FB0661CA8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey!

On 12/3/24 9:28 AM, Chuck Lever III wrote:
> 
> 
>> On Dec 2, 2024, at 10:19 PM, Steve Dickson <SteveD@redhat.com> wrote:
>>
>> Hey,
>>
>> On 12/2/24 3:30 PM, Scott Mayhew wrote:
>>> Commit 15dc0bea ("exportd: Moved cache upcalls routines into
>>> libexport.a") caused write_fsloc() to be elided when junction support is
>>> disabled.  Get rid of the bogus #ifdef HAVE_JUNCTION_SUPPORT blocks so
>>> that referrals work again (the only #ifdef HAVE_JUNCTION_SUPPORT should
>>> be around actual junction code).
>> Why not just take the enable_junction config variable
>> out of configure.ac as well?
> 
> It's not generally good practice, but I will break up your
> sentence below to reply to each bit. There is something to
> unpack in each part.
I agree not being a good practice... But sometimes
config switches out live their usefulness...
Basically that's what I was thinking

> 
> 
>> If we want junctions/referrals (which are the same)
>> IMHO...
> 
> Junctions and refer= are related, but they aren't
> the same. As Scott demonstrated, a junction is a file
> system object that stores NFSv4 referral information.
> The "refer=" export option stores that information in
> /etc/exports.
Is there a point to have both ways?
What is the advantage of one way over the other?

> 
> The common part of these two mechanisms resides in
> NFSD, which turns that information into the response
> to a GETATTR(fs_locations).
Right... both ways use the same protocol.

> 
> 
>> on all the time...
> 
> We want "refer=" on all the time, yes.
Fine.. Scott's patch will be in the coming releases.

> 
> Junction support has to be enabled manually. This is
> because it depends on libxml2, which not every distro
> wants to, or can, pull into its nfs-utils package.
Yeah... libxml2 seems to be an Fedora only thing.

> 
> That is in fact exactly how Salvatore is using this
> option. The stable version of Debian's nfs-utils
> package does not want libxml2, so junction support is
> disabled there. But they /do/ want "refer=" support.
Yeah... The bug has been around for a while
(pre-pandemic ;-) ) so it appears somebody is
starting to use referrals...

> 
> 
>> Lets not be able to turn them off at all?
> 
> That would be nice, but it's not yet practical for
> every distro to enable it.
Understood.

> 
> I am told that Debian unstable's nfs-utils will
> enable junction support, and has added the libxml2
> dependency successfully.
> 
> We will get there eventually.
Patches are welcome! :-)

steved.



