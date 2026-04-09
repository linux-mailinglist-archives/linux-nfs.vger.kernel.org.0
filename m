Return-Path: <linux-nfs+bounces-20799-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGpfOznu12kbUwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20799-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 20:21:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 227033CEA58
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 20:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 343613026CC4
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2026 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F5C274B2B;
	Thu,  9 Apr 2026 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="V/aumy5P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E0204C3B
	for <linux-nfs@vger.kernel.org>; Thu,  9 Apr 2026 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775758901; cv=none; b=saE9H6ZSb0sWesBMU/IF/A9UZRlCbjJTJEKjnMCVfyDYdlsc1GzgI+y6EY3zA3QYEskkQijTT8D7rxbe3tis44HpypgFkS2zdIozVp5zynRM3u3+PAzQxDJtu7ITFa1u52zPvYiG+8pY8/ISb3ulF4B4RWxnOLWlluLUvEX63gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775758901; c=relaxed/simple;
	bh=qHL0MIuDWzk8m3++W3UvwFh8SqPdZKYDM1OqPAjV0Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCUFgjTWrJnFYGWNFLHoynaVdWXx7aywSq10FgaeNv1tg4rwHC0lTjaMjSj/qwlbjhPRdho52GjOmFEVsrcN+G65kQCvC97gurfhk4DbuHNvjKRGP9HWIiiN9C4qRjADB7jcMhzWtCIJukoKbOAnaM545FMZjnd6nYbokxqn9WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=V/aumy5P; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8dbbc6c16b2so146334885a.0
        for <linux-nfs@vger.kernel.org>; Thu, 09 Apr 2026 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1775758899; x=1776363699; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHL0MIuDWzk8m3++W3UvwFh8SqPdZKYDM1OqPAjV0Ek=;
        b=V/aumy5PDHcSqS5aKkTuovYkWpaD0lmKveyjfjSBJir3QULBJzKuy5gr1A+Vsu2OdU
         7F4W7HDveV1jSF6kbZBjZ5oWQb4Wk2j2fpu41AIiuKL1Ua6UGZKacvLsJKB9pArFwZol
         ege6J5AMsoqJr9TUCQ5AKkLXBouogXLKX4OpcVwDZrk7wJRbcQ4sroCGaxybbH+YWRGP
         IHKnlfUvUeilV2ymTpTq+nxSF/UK1xB32iwpTrKY6KgthDHfrYXwz3bb9SqOKR38c5bG
         pongAnXx+r+h02a0weJc//ecrA55DeQGDZyrahUgVxoteZm9Fe5MFEP0zV2jxE+KMC8y
         OjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775758899; x=1776363699;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHL0MIuDWzk8m3++W3UvwFh8SqPdZKYDM1OqPAjV0Ek=;
        b=nMTKWF6Q8x1HpjjH/FTKkjFcl+mRt8slvVx9Bmc/KB42CmCC6E3YIlpu0gz+vP7ecR
         z1o7eQKEAETFq4V+vzpXt0ADcbPTBc6Q0FmApxSEICoXFO8DWLC/w4yZ/k312y+3tniJ
         PODFIo1LLYGmzxpRG5KWRkWT+/I5HAF4Br81bp0P7O2UpTBuTJpgANCUE4JO6J2N5uEX
         ZCVrE818ieRtQ0ailFmEzSiwFnw4ZqechOuDPLHovqcFUnuDGJ7dbK5LiM2HSbwJ/jvH
         xNVMboc82k39bM5JfKv67qBi0w+C9LBHMfRvmijP8iQSiMFQpVI/mLUvJFbFHL1+b6rL
         7C4g==
X-Forwarded-Encrypted: i=1; AJvYcCV9hr3c8l4nvcLw7ZhiHmq5dy1JTHyLrtmYO5d3o39lIo9IxPwMYEPy6hdVXo2aBHHsk8XQQ+StdKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7X35gqGB1PDJ0RmH+YrP6z+RDSxXexuT91EeKQ8Fxtcvt7TE
	pwf6Kv47nLCV7Z57HcK6zVDWKqE8Ai3BsmuMZCxIfOJfU++Bb3iFFnzZD01lFWrwwEw=
X-Gm-Gg: AeBDies1lCv4T2hsxNnwasxxstUqMVEx36ehlzm/J1S3ObR7V0/oQ8I5RLF3X22pYXq
	YjiNRfmTqDgHSGKVDZpnJ6B4H/33KKBVRZk4M/shJnuUx6BbeZUVUiYyWPoFUOOI1C3rjaApKqM
	JL2sQNoshcVVnZ/5YPBWflVUBTPsVhYLmE3Ed0SDxmWjq6VsAP4aAr/iiOOOYJq9cDxZZdD/A94
	O4F/JYlgYb3tkU91SqrCOhdBr2DxhLKpcC+fzBTV/nzUMw/q/5QY2cfRDd8Ekyk85lWHevqmyc9
	dw0auEgzgYXDPjtD7gM16xhaFaz42r0vxVKnYLgWriCsVOhBCVMA88gPXgTjiAy+tY9F86V+T4t
	pozY3k1uJe6+goquHDGroIGow/i9yLWiwmYJqCHJ6nYEzd2LAE6GBuWC027jBrETTOigV7AIweW
	uD3jIm0nUeT3gpe56x+wA1iKAQk/GH0Jwo0OdQFscS
X-Received: by 2002:a05:620a:c90:b0:8d5:8815:ffc6 with SMTP id af79cd13be357-8dc44b832e9mr466060185a.13.1775758898906;
        Thu, 09 Apr 2026 11:21:38 -0700 (PDT)
Received: from [192.168.37.1] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb5f88a99sm13898185a.9.2026.04.09.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 11:21:38 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFS: fix RENAME attr in presence of directory
 delegations
Date: Thu, 09 Apr 2026 14:21:36 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <2928497A-DE2F-49AC-AF48-B3AC1830D316@hammerspace.com>
In-Reply-To: <20260402231236.46595-1-okorniev@redhat.com>
References: <20260402231236.46595-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20799-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 227033CEA58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2 Apr 2026, at 19:12, Olga Kornievskaia wrote:

> Since commit 6f9bda2337f8 ("NFS: Fix directory delegation
> verifier checks") xfstest generic/309 is failing because after
> the rename (mv) operation, client's mtime/ctime is the same.
> Update the delegated mtime when directory delegations are
> present in rename.
>
> Fixes: 6f9bda2337f8 ("NFS: Fix directory delegation verifier checks")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

Ben

