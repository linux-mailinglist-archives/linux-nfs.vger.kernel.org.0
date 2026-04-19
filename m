Return-Path: <linux-nfs+bounces-20949-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCQ7M/Lb5GnCbAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20949-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 15:43:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24629424368
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 15:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 238F53010515
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 13:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FC737C931;
	Sun, 19 Apr 2026 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="iJ1w+Fbr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541037BE6C
	for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606180; cv=none; b=OPokrzk+23BpvXucufjS/3fBLp7Udpwb8/pBh+QQjznJEmEiOx0TExlejttWHTL46d1p6cASHODT0dG2jih6JDzGXQ8IorpDP2jM49r2b6MPOCSd3Vt/4NDUtQaByXcTEL0YcTHMrSM4oXqCiDvXGUpiO82CNFQ6uGBDuwYY/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606180; c=relaxed/simple;
	bh=qXcMH75Wt1sC2GxS8Ckii2ysSuKAzkBFtgxWEaxnyUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shSJz2r9VCDCTcxUYuKmbhrvwOC2+SjRqRKqvNy5EscLCRHayQKY8bZ5yfr399lEggK8KMVgLYycvGWpAZFY9ck94Od2cubdL7ZhFIKFN4FvDDGLJ9BIlf8ZflWitSqR7UfGfu2YVUrTuZPvu2uOArqm+XFWuBaWFM37G8VusW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=iJ1w+Fbr; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479554880bcso607723b6e.1
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2026 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1776606177; x=1777210977; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXcMH75Wt1sC2GxS8Ckii2ysSuKAzkBFtgxWEaxnyUU=;
        b=iJ1w+FbrzNF88KuCXqSpm3R+ec/J/GcOSeYPRKGFRnnd5mbdP6G+pFPUPxzu0+r6k/
         MvpV8YVxjEtZjYa6MxFwHFh4Ht0iXI7L49Z2XBIkQOBfHXIm0WFCfCEZr6BbW89MY7dc
         JwwEABh/X6aVgDVtLhv4SHXx5YF0KeeLXOFPeQCYqkeLG7kKJrCHpdve9HC897lWXV+u
         Koz9tjNhlxUSz2MGVny4ifz6l6dAGRQAMWXMQj4lXDvkt6xSFZ1B8WeVMOrSAOdfw3Uy
         vNYqsRvL9vTY/uh1CiY38/vfLquhZDhji31TtkEqG1F7AkamVLuBx5mxOoH2jyyRInci
         /Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606177; x=1777210977;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXcMH75Wt1sC2GxS8Ckii2ysSuKAzkBFtgxWEaxnyUU=;
        b=Ws4XVVAoSsDhbCVR2QxHJl8N0H3Cc63iE+G8er/kW8ZlSCX5ELHaD43W1lzXZ9NnR1
         iEqcruHAjTPh760GxqlORjZO2Rp4G7dPFC1zVFRohOw6DD1VLfiq7S0dA+FQT2kcnPXO
         bS67IZILMaUXAvSuq0xqBzDToPU711vqPY2fRQh3Vr0JQcvSGGe4lqX3eZCYEd4lGI89
         pBD1ZWnkvihLQ41Yq8dPBZrgCnItmeBuzmlHMpWkEMmNWIKthDV72VX88I/pIIdCFLAP
         0wzcLDGX3cFiOaAkpqKdZj5QQlj3H5yOBDqUw1PM6qnI1YcuaHC3+TslHnhbSuHzblLK
         5pNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QJWEFmqrLtTzFY12XYLACpdGsyUri3rGm69bW/7zFP1FHmrZKqrg1DGxCh8KbCDCyJoLTfCE5hHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5QZ6lzEIeZh/6xMEMK7bbumKayc6pvqhzhrDR1JzYxblHoMYb
	Q+GuWABe2Fncp0bxYZ7PVJ+dB4guQnfCDkYB4uhFiec5xQ2CPEIlV7JgTW2VMKUd+GU=
X-Gm-Gg: AeBDievHvB+AguHmJGC/x01Ty3cj6t0KBiIPeRhOFMtO+I/tOJysoJAYDHsaS8RalJG
	Xwb8zdZ2jIB/hpgn9u7ohCsqT6sFZKdc47kRBs4S3PiXG7tNbaREYNfbCnEhMxkHUX4mOAvaK7T
	6pp/a/NudJWRdL9iNhVEKowiM7WbPvDn7J59ECZV3t4ni7Cr130bOwar9x0+QbqnlgDwqd/TSZd
	D4z4QBGSUqwfBABH/hDc5WUf0sQwYdTXBevgMyVV4E6rwCG4by51fyHNRVWBU2DboMkM/HVImJg
	sADl+zE5r4m9+FOx55Dw4un/A8qxSgHC9I14gP8jkc13JeAxdbwNRGsqpAKp3j9V3AvzSmEk3Dt
	MZDK9Yv2eWMlIqsFy9aV5R8Lwqj2ile47gRQgGdORDS1+MFbzywgo3uBLoJG9/+uQ6lIR4k83Ph
	YM+0pNWyaAA5KY1L9B7/ro6NWxUiGvei2NLIMuKormPg2JsfZ98AU=
X-Received: by 2002:a05:6808:17a6:b0:46a:6e9f:dec1 with SMTP id 5614622812f47-4799c9d4daamr5137765b6e.35.1776606176970;
        Sun, 19 Apr 2026 06:42:56 -0700 (PDT)
Received: from [192.168.37.1] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799ff36814sm5121811b6e.7.2026.04.19.06.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 06:42:56 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>, trondmy@kernel.org, anna@kernel.org,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] NFS: remove redundant __private attribute from
 nfs_page_class
Date: Sun, 19 Apr 2026 06:42:54 -0700
X-Mailer: MailMate (2.0r6272)
Message-ID: <214845EF-2787-4923-8226-436ED7D4632A@hammerspace.com>
In-Reply-To: <20260419100128.20546-2-seanwascoding@gmail.com>
References: <20260419100128.20546-1-seanwascoding@gmail.com>
 <20260419100128.20546-2-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20949-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: 24629424368
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19 Apr 2026, at 3:01, Sean Chang wrote:

> The nfs_page_class tracepoint uses a pointer for the 'req' field marked
> with the __private attribute. This causes Sparse to complain about
> dereferencing a private pointer within the trace ring buffer context,
> specifically during the TP_fast_assign() operation.
>
> This fixes a Sparse warning introduced in commit b6ef079fd984 ("nfs:
> more in-depth tracing of writepage events") by removing the redundant
> __private attribute from the 'req' field.
>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

Ben

