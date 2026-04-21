Return-Path: <linux-nfs+bounces-20988-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFj4ENbV52nTBQIAu9opvQ
	(envelope-from <linux-nfs+bounces-20988-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 21:53:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5B743F1D7
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 21:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90844300FC63
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8DD33F8BC;
	Tue, 21 Apr 2026 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="EKVAb+xN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574841FBEBC
	for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801065; cv=none; b=HodYvq+Ff9hojwwCQUiw/L4AbzPhF3oTz8ceihaMNMgVbuBAe9K5vrlYcb+e/WDj1W4mhDEiTzbdS6OSLdDNOFME2UjW2+OfpvnS4pZV6sSsQFlqINGwNhwGQiLfhR5JXiNM8Mpxsgntv0YFixWuipfIJUiUpZ1SEb2jljUOafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801065; c=relaxed/simple;
	bh=ZM8PdXQiLnSSOGQ3Y0upTV2unBCcm1tqv+vl6JDf2L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOPrklDePYAHHSrF52/kQ9fltdxudU6/xedP3mVc2C9pqFzDzJyQi2czixpHFdqqELmYzcU9b2oM9nHLgtbD+Qrtpgeh3BW56RylKdz4AtkrPVyV7H1NuXVADa2KreQjePRtGYO5ZlG1pojaCfg1Bjqw34BEBtBfxZysi22gDGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=EKVAb+xN; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-479810de04bso1624259b6e.1
        for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1776801063; x=1777405863; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM8PdXQiLnSSOGQ3Y0upTV2unBCcm1tqv+vl6JDf2L4=;
        b=EKVAb+xN6ST3lsegH6AODL+gl/l1V1+sIxof/spTjhI0J//gnkd8Y9n950UJHSb1wr
         mwdXaz+UtAjf+ayZ00icr8IH4BpJNHEGdfHNe6IbbA9VljKbtC9H5Xald7RZgzI7WIrq
         VrwM0iNP05935Cw0kbjnbW2S9SdgwSuFmZJIr6EjP5iPn4YY1fnN7SrkXadDIx6UsQQ9
         pKMSgSCG/wUCUgLaw2lab8Z8uaFV04KE897IWPtdUgNzKO8z4W6kySuqqArYjFhYlmv9
         UjZIoXtMiSP85DWKN+NLcqf//xoliXZF6/RU7FyMHq8B5lqcKUZsMJu8RE6w/lDTU195
         yrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801063; x=1777405863;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZM8PdXQiLnSSOGQ3Y0upTV2unBCcm1tqv+vl6JDf2L4=;
        b=dbMIHiZQT2i3U1WRudmigMYTYqbx+4qcEBOojlryBX/ywFg91yJRCY5wks/Nwj2dfi
         AOEWQcBxghxvfpKqnoDUbKlT6DjpDSJL1xGen3G7RJA+0wo5kx6ZVsjVGUXK4F1cl8fr
         PyigG9gy8Ya8m6xPvoi0YmISThmH4e9WRviQBLSu7/cx4o1LKRzJOkqux3GJ2IReUFzs
         4cAXz0t6gMou8t3Kl/sCqb8O2AuxJVgA3sc+ScQXXjMI1lD1h1mj5U6p5YWH5Imk7lVs
         QvH7fS8t64CQUjvMBZphtxRSbKPF8nzvsH9H2/SlnLARbAsw9I0aIo/6tzdX4lftPsmm
         uI0w==
X-Forwarded-Encrypted: i=1; AFNElJ8PG1FqJCLfj5B5cWVE00puJxdtcxcAVTQx0gTH5JdtK4bd3WPRGqnJMwkq1vRZsWQ38Q/V9f6+Opg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NZDYs5NMlygpfcbwSmdh2B7B/AMrXY6zrWJp66IeGR2ph0T+
	e8CvzTlWPhkybp3Vs5VNZm1V29Wt8khjFoFgtLhHfe6iWpEv6H4X6Ydr1XczdnCN5ISdwRjac+p
	OokeaFi4=
X-Gm-Gg: AeBDietRin14F/OIikj73h2Vad13JgKI1GdDLboHw6koXSQgCwhemTtZGTnjCAOEETI
	LAwIZ1eTOHJMfYV3VAsFHwxmIp068nowbpLWoObizAnA4PDodhaiChPGfcNYAorHlJEEMX6SmlG
	sJeb6gvX70MxR84BWBCtpzdu41gi5wCIQ/WP0pZC8dkhOrLHAE2SHKWt15ROvGRVqQilJFfKjBq
	sl5gHbTvuG8qWhGqWQzeGI+No5vjau7rCuTufa87B8d9E5frAyvmMIi1N3XwM8N0m7b8QK7kp2c
	+ulB0Hj6BFSpxrdc7RbimEWBcYSylw4MKki54ctSLBNnojEvt6DsSMeVIjC4eck+aQeknnfRCm8
	NGuzi/mL5JoXyBH3QG5kOrmiMIgZNoSYN7mHNlNfqsvFVOfbWce1smjme44QQYY/RLP3KAMhIeW
	6vFVKHhYqXm36D8Ap/9hiYYcKq1+VPgfxFVToXnQIK4Kpm4sks/2M54A==
X-Received: by 2002:a05:6808:1394:b0:468:2a6:e32c with SMTP id 5614622812f47-4799c914da6mr11587939b6e.10.1776801062917;
        Tue, 21 Apr 2026 12:51:02 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799fef6dd0sm9770434b6e.5.2026.04.21.12.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:51:02 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, jaeyeong <fin@spl.team>
Subject: Re: [PATCH] NFSD: Report whether fh_key was actually updated
Date: Tue, 21 Apr 2026 15:51:00 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <DE0E96E0-3DF4-4D55-BE80-EFD3FD02AF61@hammerspace.com>
In-Reply-To: <20260421192021.428052-1-cel@kernel.org>
References: <20260421192021.428052-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20988-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org,spl.team];
	RCVD_TLS_LAST(0.00)[];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spl.team:email,hammerspace.com:email,hammerspace.com:dkim,hammerspace.com:mid]
X-Rspamd-Queue-Id: EC5B743F1D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21 Apr 2026, at 15:20, Chuck Lever wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> The nfsd_ctl_fh_key_set tracepoint was introduced to capture
> operator activity on the filehandle signing key. Earlier revisions
> logged the key bytes verbatim; the version that landed hashes the
> 16 key bytes through crc32_le and stores the result.
>
> CRC32 is a linear projection of its input rather than a one-way
> function, and truncating any hash of fixed-size secret material
> leaves the key recoverable under offline brute force when the
> threat model includes an attacker with access to the trace ring.
>
> The operational question the fingerprint was meant to answer is
> whether a NFSD_CMD_THREADS_SET call that carries an
> NFSD_A_SERVER_FH_KEY attribute actually replaced the active key or
> re-installed the value already in place. Answer that question
> directly: compare the incoming key bytes against the current
> nn->fh_key inside nfsd_nl_fh_key_set() and surface a single bit to
> the tracepoint. The event now prints "updated" when the stored
> key changed and "unmodified" otherwise. A first set that fails
> kmalloc reports "unmodified" because no key was installed.
>
> Reported-by: jaeyeong <fin@spl.team>
> Fixes: 62346217fd72 ("NFSD: Add a key for signing filehandles")
> Cc: Benjamin Coddington <bcodding@hammerspace.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

Ben

