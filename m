Return-Path: <linux-nfs+bounces-22886-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EKDPLlCaQ2pedAoAu9opvQ
	(envelope-from <linux-nfs+bounces-22886-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 12:28:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B1F6E2D6C
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 12:28:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vastdata.com header.s=google header.b=JxdHXPT+;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22886-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22886-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=vastdata.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 893A63093D26
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435853E275E;
	Tue, 30 Jun 2026 10:22:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE43EF670
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 10:22:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814955; cv=none; b=vCvboTbD/yX8aHun9MxsefxnkiLAFfAYNzF8+f73tvO1/WXdyYexWCVs/0kJBsYE4W5DE+UGVo48o+Es/58gdZqKu6IwpLKsPCNXYsX1dmZvkHxzbpOqcfnSZuEIt9r6DwZx/MmquWFkFQCKTrKrfq9TcmYH8VPQCkNb00W9G/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814955; c=relaxed/simple;
	bh=W3QIhHui5sACyeafMJCdCxKaxwJ/5JwxUciGy0YZlU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMkCcq6jkdYu6tXU8pNpk09fTQfRT6vzTj15+fH/yThl4Hsft/XUJUO39dyb1iPL+Nl8IclBov2QSOH86SCStHV+6JISBeY6GrWpVsO71duuGSmasbCj6di0rAvvKdkXqovqayWvKcSv9CZgKOuBt7+sOtzrx19SXarwm/WZZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=JxdHXPT+; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b691cb44so10359485e9.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 03:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1782814952; x=1783419752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3QIhHui5sACyeafMJCdCxKaxwJ/5JwxUciGy0YZlU4=;
        b=JxdHXPT+OtOvcnx0XhrQo359RYJpXZhc5/MIjlLPTqFuSxfvwg+t2d9yYuVNmxcUYM
         V/vzXf00Edk75bZPGA25Lpk6GPG64jkkGHpjwHFMcZi8p6dLv5a2SLqKpTkiffic+74C
         Ao6SDKkucmEbFxjaKksk91D4VWe5EAGZ9XeCwO5uMglPwzalOb+zrxvIZXnu5/de8Mqu
         5GDuI/hIRNPLJo53DeyYWm3f1k6EqusSvEDiLvw8EIx3ZFrRygl3LG76y5d2OCj+WVCz
         sVsunKc5z686nCWHC++2gbNqB4+N08CEsV29VFSwv1ZvfRpKFPpbF1qfg/dkjpNU55HN
         c9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814952; x=1783419752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3QIhHui5sACyeafMJCdCxKaxwJ/5JwxUciGy0YZlU4=;
        b=l3Lf4ouiQEjP9dGSewCzkneXevkR33YmkFJR8ADeFFiZJY7fuerWWmdDf38Z1BmRFj
         c5LgVVUVHz7ux4jtXOCdJBBldM34tn48KzT51CQB9+qQWx26R8OwEEFyRwsKitHLUvZ1
         BM4w7n4eGfzL5gKrU9Kyo362nJtSD4u73tBG8j4eQqtZjYzzPNCUGKHvq+7gO7z2QwWZ
         By/QN6YkwuVTEtAQg8kEtItToL3KI/KPsZKrqQ8Jix/yUGUPHuiDqz/y7vqmbRZlZyhZ
         rHtCL7c0LtkKCS6sF8EIW5T0GvrEEd4PI3EuNHf2hzsBCnngPDZpbfsiCG5SHwe7292v
         CCsQ==
X-Gm-Message-State: AOJu0YzutXlHRE4XH+qUvE31VOBLIQwklgTEkCsOLqd1C5TXjrP9xNwr
	timfDTsCWIRTAA6QhBHqvZyvjabP12aEW2PX6BwxQhletANt6XSKZ87qIII61ZLIrg==
X-Gm-Gg: AfdE7cmq8tE25K4ewBJvp+egu45AyOQWxOw9Ap+baS3IjkxafvtnIbKof2nkR1wF9gL
	X8+TEdjzbQbP62G8lVLLcAin641gfn71RluYkm//SL71zNekoGqXAe3EHJbknzCvY+qf8RGlb0E
	MH7izQQy4Oa51eYP/scuMlxwZh77ujNDCm3I7fVDj3+J7DpCHX9swrPMnO85f14l6Tr3G02CKME
	iqeORfQf8GqePMnZc53l5gjbrcP2Xt6u2vAe/mgVp6YjRed56mhSyFtbvqmkddcuhxfZFdL5zUn
	ZBmu8eKlM23L2VTDSrwRsZCoQHkGXJgmbK3utuySClKP27QlFQgzFgaL5yRdjK8/wffpHGESRn4
	RNH1YpRKrP5Oz0FVETKROGI+q2Zr9S4UadKbjyOL3N0mIDJUmFAvzEgMstPmh+2UieuZyb68crL
	DdCdegAMYDMZ0Vfk6YrqR6Z61a2f8VxXvf9rXK5zzVxB5OyGyRhYI2zsasoBA/eF8R3hU2rdNxG
	GRSTZL4/ZyXTQv4b0HJNw==
X-Received: by 2002:a05:600c:3114:b0:492:5e71:f6ab with SMTP id 5b1f17b1804b1-493b82ae6e8mr46957835e9.20.1782814952393;
        Tue, 30 Jun 2026 03:22:32 -0700 (PDT)
Received: from [10.50.4.64] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8cd2a3esm62474275e9.4.2026.06.30.03.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 03:22:31 -0700 (PDT)
Message-ID: <27ab9b8b-7b50-497a-880d-593eb07694b6@vastdata.com>
Date: Tue, 30 Jun 2026 13:22:30 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: fix ENXIO on O_CREAT open of existing symlink over
 NFSv3
To: trondmy@kernel.org, anna@kernel.org, neil@brown.name
Cc: linux-nfs@vger.kernel.org
References: <20260614122911.3485467-1-michael.nemanov@vastdata.com>
Content-Language: en-US
From: Michael Nemanov <michael.nemanov@vastdata.com>
In-Reply-To: <20260614122911.3485467-1-michael.nemanov@vastdata.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[vastdata.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[vastdata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22886-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[vastdata.com:server fail,vger.kernel.org:server fail,sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[vastdata.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michael.nemanov@vastdata.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.nemanov@vastdata.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,vastdata.com:dkim,vastdata.com:mid,vastdata.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17B1F6E2D6C



On 14/06/2026 15:29, Michael Nemanov wrote:
> When open(2) is called with O_CREAT on a path that already exists as a
> symlink, over an NFSv3 mount with a cold dcache, the kernel returns
> ENXIO instead of following the symlink to its target.
> ...

Trying again


