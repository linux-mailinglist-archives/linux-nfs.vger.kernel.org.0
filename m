Return-Path: <linux-nfs+bounces-22887-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XBMsOimdQ2qldQoAu9opvQ
	(envelope-from <linux-nfs+bounces-22887-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 12:40:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B896E3059
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 12:40:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sfOSDGLd;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22887-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22887-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4119A3030105
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2907C389E02;
	Tue, 30 Jun 2026 10:38:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6C3F23B3
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 10:38:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815924; cv=none; b=pQzKOZ4PMDJ/loaiNiS5fNaqjWKo99zWMV6g52hOnkpXlaOJ7mkon9gW+da8eBaDwOszHBzsInQPTloaJUe5HgxbGSUCZgnyfHp7MCwvMnctHR9jyjNV00JvnKz4h6r89vPdDLpxkd2limCrAm8TPIfelKfrNEne0tYDDWCyovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815924; c=relaxed/simple;
	bh=ejga8Dxh/6lWQgQQuhEmr2bBEbn3EFgeSvX/8+FanOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFN3d/+DAyL00v1QARni0ODcRVgE4Zg2p39f8w12rIoyfb8e59rzNqUnis2PVHJ1EiFIUpg/1ekbWAU1GYXQJY3Pp8JBfj8IFu/mppySmZab25rdBPk+Ekzwfl/FdTCmvvdO4JzLshA3hFwPoUgdbIoE+/ZjmlBlphWuxT6+ggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfOSDGLd; arc=none smtp.client-ip=74.125.82.169
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30ec3dfbcd1so3317973eec.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782815922; x=1783420722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ejga8Dxh/6lWQgQQuhEmr2bBEbn3EFgeSvX/8+FanOM=;
        b=sfOSDGLdgxLs7tgkWmNdqmP3sO+1jADuHIXBWEpSPOyjfyqN7SXxFmuTF4bzH9Uc3j
         NEB4i7J/J+ndmk6ueN2rDaZZy3KPQvxPDh+pjFWA9twHdYjLpDTlnq/4uQko8SsjCbgx
         ofbP2TfieMzm7Lqa5qXYf2Q0fccpV86kkF5XgS+8BKpcL91N1sdWxNuwWE5ZESJE6CBs
         UCwRpqEKSPFoTdUPkXHvweYF8V7iv/WwlERx01aNqzK6mf5P+xR5dTjrWMMbuW9E7cg/
         4Dy0Qpcx6d9cHl2Aqursb2zkNvMWmxLu9OfO8TnC8z4fmNJf46XQ2dOsz7lXwp2A+bKV
         rang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782815922; x=1783420722;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ejga8Dxh/6lWQgQQuhEmr2bBEbn3EFgeSvX/8+FanOM=;
        b=ACH7C0ftDVXkbHESfB65Q0HFhXmG3jTLm8lB71kmDCoI+oVmYgIa90KEhYMewzY8gV
         Cqjuehg/3BwRZzCjuKs8xaFWKcxOnH1EEYd2LdnS2tz1+0qOD/2Jt/Txq/iriuwZ+fDJ
         Q5P6UGN+sSiVjWPDuFu/Qh80RwedgzptlqwDuHNsgR4JLJdrMRzJ65WmGl4T7A6Wieix
         ISOpkKJTQGFbTTSQnDWKO4kFFwfu9h/lbIXy1XAKcGHgSkN1RskVVMHYrxUFmAV53H86
         BiJcVFeVoZnLOQ/pq1GandkH8CHTihsZ1513i+oy9FRR5zaH7LbDly/5AKw6bE0rYqKi
         boRA==
X-Gm-Message-State: AOJu0YyrIL3OcYRjRGft3DZERIgfR2AmjJX8becWCaTrybThBMhFNCHz
	sweGGNLYVdnN5BJn3/VAuLDdbHJgfkw11uNcEl0agYJubNuqHbsadWDgPMoIKLVGrgs5nM0m
X-Gm-Gg: AfdE7ckZee19w1foKevy0K2BhbmiHkL+yiR13gSvP/8Eff2TktgsKcDvqwFyyT1HCAV
	EdFQh1IpNVyGC3JEx4Kzg1+Hq4mTubmdt5QftCodX3UoBUM5jhtO+sraFHQbjH1DcqYfDDEW7QR
	cUDCQxxjuImujv97PJXBVrCbwDoYIS8rzYqGlHf3r4+GKdU2it+lz5Nt1jbQ0Sv7Bo1Enx2aMC5
	4Opsf5su+Qiwlq6UPIQ26djzfb+6JKDcfyfGP3Jjm0eSo/hDUB8z6GBohUjtnA3sKoAMI7yO8JW
	6p+SdOFHs1lQmUd59IQc5/5ffLTdeEQrDeCbgDeQ0Edvie//88GN5RTyTT3wd0Y4Q83j1ZwCt2O
	/y9kCD0kzhVYNmPCwOnp1YB8YY8XAtkwpqDD1VrwtIcXXo7PB3EA5j0K2krdP2AWNEuKO4R79HW
	fh4D4=
X-Received: by 2002:a05:7301:3f19:b0:30c:99c8:2b1b with SMTP id 5a478bee46e88-30ee1344fbamr2327129eec.10.1782815921831;
        Tue, 30 Jun 2026 03:38:41 -0700 (PDT)
Received: from houminxi ([38.34.12.160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee3265ab6sm7126901eec.30.2026.06.30.03.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:38:41 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: linux-nfs@vger.kernel.org
Cc: Minxi Hou <houminxi@gmail.com>
Subject: Re: [PATCH] NFS: pnfs: fix stale references in pnfs.rst
Date: Tue, 30 Jun 2026 18:38:38 +0800
Message-ID: <20260630103838.105808-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619142040.3970345-1-houminxi@gmail.com>
References: <20260619142040.3970345-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22887-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[houminxi@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:houminxi@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5B896E3059

Hi,

Friendly ping on this documentation fix. It corrects two stale
references in pnfs.rst (a removed struct field and a renamed
function). Happy to respin if any changes are needed.

Thanks,
Minxi

