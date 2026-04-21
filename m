Return-Path: <linux-nfs+bounces-20981-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJlUCMdX52nz6gEAu9opvQ
	(envelope-from <linux-nfs+bounces-20981-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 12:56:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E447439D01
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 12:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BEFC303FFD1
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA40280CD5;
	Tue, 21 Apr 2026 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQp4PkgK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576D3B584B
	for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768699; cv=pass; b=tC0IDb/GsPdN2mIYDk6NETeQuwwxO5O5SpLlsaFixxTEMKb+S+IoVcSVLAVTdrQc38BcYD6Ranye1e19Gz4vNMjQNkBQ2IMPp/tNkBMMaCEtB9G+jYzQDx6qKBK9KyP8xcA0xoSTBE0njJSjyx/PLVaMy/R+IKwR91I0ksW+t3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768699; c=relaxed/simple;
	bh=3gQdH2XViUb4B4km0Nb3Hpe/7ffwiZtX/PY2AeE8X/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LS2NqbyOgVhQaeVTReolnIHBXd5mitnBcco6Nmj6N1hi1Pv9hVfYjF4yexx78im+5KoHTqw45uq7Js7kBXAq+dwUbRO+qOBz/ZeO8GdPc59nKpWnmEvDDjXcyPd5USKnR8YchOlzefGOVfUMOjxF6Na/5AeCeAKpJDBB8OkqpNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQp4PkgK; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66f8f556f39so5194391a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 03:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776768696; cv=none;
        d=google.com; s=arc-20240605;
        b=R69sqmyH9AGmwV2m2KUECaJOqjc0VXnuG80lvhA+cv1rtoqg602hR6zbbXjBlK19SB
         GcgopcdCOzOa4Yij2aH1HNWZVsC71A30qGfc5UTPlF/lxfiEb1Eiq5Wk1NgOQ07fsuNe
         PDLeHIea6+ifqzJg7/z+jbv1KrLoPlNNJkKJAh8IT4AAyvMFMnoGFmTMETdtK7oD4gO5
         uQbbzQu2VR71HBOdLHODqDeozgGKW6ZD3fkpPoEPAF+MbgxoajJwV+p+owXgoAhOPeDL
         osX66f14GbS+AGJOhyo9u/FlDjlCsCvRgzFjT+KGSqw5nW3mjOggPXDQgsmaUVm7f+NO
         FgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=3gQdH2XViUb4B4km0Nb3Hpe/7ffwiZtX/PY2AeE8X/4=;
        fh=A6VhHI7NKHnmfjjs9vgKiwsl8TnYIjA9XaJXQoRXXsA=;
        b=Ybe9OIvLJabeRAa40Aec6JIq3XI917B9y8wzZXSRIXQzYbX2gCp848ck68qDArsa11
         Aw6+Qk9XC/eluwA21ptB+Tz9pm9VKc839glwAHgAG2B/NPChG1NR9jbcpo87hNXtb2kA
         4GofNkbdezmUr/YFeWbm4xkZjetc6SAT9LeSncEps/ycMbEqkJA5vpnoHY8N83X3qADr
         cvVsBRyizTHaGJvqjySyMcvrcrdrRJD6kpqALeNECiahx8EuEUN2RiYXCOSoeioVIfwf
         HSLibcsd6kVUUugfyhuNnPVf9bryKWhxVmafm28uJDX7CjhetE8prT6ECH+0KDiaevAq
         ezcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776768696; x=1777373496; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gQdH2XViUb4B4km0Nb3Hpe/7ffwiZtX/PY2AeE8X/4=;
        b=fQp4PkgKwfKvauv1OZvmVIl0cjO0mDhPodd/vtBGdHJmguySwWeLJe13niLaVCO/zH
         mL2PdEkoD5nocuyYF0Eo8OMRSIhlg1eyEIO4tbrtte2UnczcnjqUouHletLuN4ZtQ4Kh
         XFFmmKAKHjpQwH3+ZYNuCUH1HA6Qgo1xH9/sgBAu8Q058SzyWhHoAnl53cckluh7EDG5
         JngQpzIkDlGBiWIQ0YKG293VEJ/gc/EvP5Nd0YAvnrwgz9f/aEEkpoCZMYz7b+7EoCNX
         3Y8lYZWkn3jC7oCUT4768S2bJqvp+swOWghnpw8rMC3GJWy2R9sjJn5i8eiCOllKyYbO
         70LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776768696; x=1777373496;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gQdH2XViUb4B4km0Nb3Hpe/7ffwiZtX/PY2AeE8X/4=;
        b=E9B6ZcywZqHI+01fj7qfdzcDRtoKbo99C9YE6zDTLx7oVFtZsH05+0prk2jW0RRfZi
         3O/aVUYrlBwIMMw8HvCB3nwMVO9sso1xghgW3a8W0ja8LwgoOWtmgVDPDpcN6OVaoti/
         SkEdwgLbuClBLffBIN2Uk5btOkfKk3KFtLc0/DN3gxc3B3g7Ahw5bOABsQdsPdYMsyjD
         qXswldEthkyqSdIFW0BiU+4hlwrfEbEpSi7HboN02az8VDNHqa0M+xhzG0L3KCPN0Mfg
         0+h6T5GbW9/Sb4dLUl2bPsqOIP3IOhXY+gqy3nX3nAQVRN+k9f2ey97SiYV9qHOPSdAv
         cxFQ==
X-Gm-Message-State: AOJu0YzOUrQM9hwUnrd0gFLHWciQq94UB/TusmDYEylRU6zNSH5ad7VU
	E2KIvwAVKEFXqwAynjNuoIUvwn5wkr86b1APlflH75fHexJawBpOcryi16LqoGjmThG5bOpr1ZQ
	HYZsyU8iU8F5qsL1/5bMMXWd7yyUu0hqMTl9O
X-Gm-Gg: AeBDiesul+oJDpXV5tD4S/UReTkL+YYGC+LcPZrxz86qVmnmPCqCoopZZvvyVHf8EAk
	W2DTgybMxR36B93vN2osBp2vxzouV2t1fyL5bPEYZO1DxZawaGEJzIJVbvNfEidLZtH4JKqhT2Z
	ac4IesLsRYAS6iENYWv9JobnD+XwuF+QO9yuyilpe4X1bghntz843cYijVTXYQ0DwCQXX/vt9++
	RG4yrgNnrPo/3Mtg5rIWlM3MpADfLyMmKUMqK/wJUB4x4S+h+dyZ3FtK0vsEilYOuFW5az5JtIe
	Cuz4eQQWPBrVtUXd8A==
X-Received: by 2002:a05:6402:e9c:b0:673:f729:c7a1 with SMTP id
 4fb4d7f45d1cf-673f729efcdmr6290116a12.14.1776768696249; Tue, 21 Apr 2026
 03:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPJSo4WEkdPfLUcMN3t1Ea2ZTp3Ga6WEo=Y4UJ+FrEzidwxRGw@mail.gmail.com>
In-Reply-To: <CAPJSo4WEkdPfLUcMN3t1Ea2ZTp3Ga6WEo=Y4UJ+FrEzidwxRGw@mail.gmail.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Tue, 21 Apr 2026 12:50:59 +0200
X-Gm-Features: AQROBzDBlkP2WB0Wuy3xpVUNHvAOzAQ4YOvDYCcv2_zxrr4fogQJwvxNwf3m2cY
Message-ID: <CAPJSo4WTedqW4N3Zs2-+RcNMGkaqw3U3818WtNTF0_B72u_g9g@mail.gmail.com>
Subject: Fwd: Eregex support in nfsmount.conf for [ Server "Server_Name" ]?
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20981-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lionelcons1972@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E447439D01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[[Repost, somehow the list didn't forward this]]
---------- Forwarded message ---------
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 20 Apr 2026 at 09:20
Subject: Eregex support in nfsmount.conf for [ Server "Server_Name" ]?
To: linux-nfs <linux-nfs@vger.kernel.org>


Would it be possible to support POSIX extended regular expressions for
[ Server "Server_Name" ]?

It is a great mess with /etc/nfsmount.conf when you have Kubernetes,
or just lots of NFS servers, say 15000 NFS server machines. POSIX
eregex matching would reduce the pain a lot.

Lionel

