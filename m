Return-Path: <linux-nfs+bounces-21163-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGIMNSwm72lE8AAAu9opvQ
	(envelope-from <linux-nfs+bounces-21163-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 11:02:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA41046F843
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 11:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E29C3004618
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533DC3AE19F;
	Mon, 27 Apr 2026 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+oUktCD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A063AA182
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280471; cv=pass; b=RvM0wLBbKKD7begA1BdVfVt4xnDDveJiUrXE4KBdXqjkwXwGMiDwlPotf6G58XHZEeMTX+Lvmdh/Q2hmr+4yM7qvHgDWGjmULVfYulVRyw+ux7mxbgwVbNlqRHhvzQvWa8zJLVgKEMj/WKgNqtrt1ckqEt4I3hgGARVAkPdtLJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280471; c=relaxed/simple;
	bh=QcHub8Dps9HH6b5gBVjzkKvO0kj/OCII6lMzDR7aRy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=g+HhGW/jl0nK4PWiLccoRbjPHy//KLgdmNpnC57bzf86MKK7hxuqyTubDpmnhBTItkwL7qRIozRpGnLKRiZ7yCKsUDdutX4dU0t6JYeB4RbeMmL7og09ulnEi5kW1FaQ40WM/GwAzS+3plYrOLaqrYjWWx78nI/RdBA5ax3XoqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+oUktCD; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso11033205a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 02:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777280468; cv=none;
        d=google.com; s=arc-20240605;
        b=RTGT9Sj01YdCG5RABLAdxB585I7E45J7Gohaccwnl6Qs/MnExbVU05YJRfdKwGNXw8
         cTgSU312Fh16aeQ4BqZjBoT/WeqBj2vpbwIn1PJnpvb9GTd0P9SkhfUvUtS1d33thCOF
         IVQZmE4Q26G6h3Jjiv254cWluqKH3Y+QuWg2geajBVo3jLwUmFPM1pm24QW/9bV1loNE
         GZDcQMeVoLCwArMUniut1/zXiz3UMzoJh52Wi2qvIFQM4SjXCpGP0i0LEoth0hW5XyQC
         4XSkgzCK3b4AL6Gv4FmOLfYp3WgtqEcHT+n/l8kT+zEtYlq+NwJG9sq7v8mclD8FeMip
         9dag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=QcHub8Dps9HH6b5gBVjzkKvO0kj/OCII6lMzDR7aRy4=;
        fh=Mys3y4MwsHRytUQMpdfGBn3oGRYLcLloxNwkFYMYMmg=;
        b=ScmYPnYGjwu6m8Oau4XRa3ryhU/6onhMVf04SO64Db2G4TRmUc0X3HzQIbcRyVDdQu
         bj3GM0yRwbYt0/GuKHzmkaGO4GPyJbfVg9C8rHYe3M3lKl0SCwXImYWB+SH165Vmy1eT
         ULb+Vu5HVPp5XKhSTTKo9httOkvxkS7jJ6V6lFoRP0cpniYTbUSoc/abZi8D9f9MElBR
         2Df8FTeS4KM4KWsTHkoJyE9q58araADlTjOhyfhKl7OLYSvhFGpWo9O8tOII/Sm9BJ2U
         NzeWphQSPImt9R5oWJd72TuD/yo56RCWz33W0ME8wG11DIOEagNenoIa9PHQHvIMFsU7
         uC5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777280468; x=1777885268; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcHub8Dps9HH6b5gBVjzkKvO0kj/OCII6lMzDR7aRy4=;
        b=o+oUktCDRDUwSEGRM68SQKCHKaOEF64/O/3xdMWXedjdaEZyDWfRizVpYc4CgDGUFW
         hSGIX4KKWrvcQcV/q2T7L3F1cAt2JIUZZAhbdF7ZlB89uM19j5V1aWsJvmAA8NaBFz1Q
         wZIcvh1DOMmqWFGGAZQhRnZodXnH0vk/rTivT67LN2ADDica7oc3BDr5iScETvs7yT53
         HLSVy2t8sIhAd5JQfXD8f4x6GLFXK8Y4aH7A71tBbVAUG3yZF8znIdc6f+0C2+fTSCH0
         KBLlzut5MtPzcZTqfaAGr0/YQxaRnx1V5E3OQz11NnD2sTn83z8S53y15d4XZ5hAOK6E
         jtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777280468; x=1777885268;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcHub8Dps9HH6b5gBVjzkKvO0kj/OCII6lMzDR7aRy4=;
        b=aCpCzrJdwwImMZcLQ1Jay8Qit3Dge8P20ul+Nlr4pQUOmr6mOCh8Vy6+xaXRnT1xWt
         agOgsLRNtFpqouxNmNNdD8esB+cbbRSc/TBG02brMAaaKDS0HgH/WMpuYVzeUbvZNi7+
         5t53vbpJvrcp+2Grm4H9+U6iz+PcaMAv4fn3vPXegf4VwWMHxkuGmO4ZzT7U5b5+CfDP
         c3xlavq9VdosFI+4LiECzp6qhqWGiYro5LkqhHu3aN0+V9d6VYQALvFx5De7tMtTz7/l
         Hf+p/qjn9s6iSE8ItGaHprLvy3lTq1Xqc7jT1VOBDxbJFe6KWFsoNEBE+Te9JCEGyrLh
         c33g==
X-Gm-Message-State: AOJu0YyuHjgcw+xg7VDpRx9+VO+MxzHN1QGGBkeN54g8oqibO3eLCETZ
	B9enKbMjfZlOT0HbgEVNA+opo9YJkkHF4znEbczaQv4O/s/43J3XGDqLhZjpuvgU+ViIth9UkIW
	65IGWdris8tsFBf4KGBSFRvCx7pg8B7i1nA==
X-Gm-Gg: AeBDievcbqCf3u8qfIVO1nGY15jGcf8Hud1RSArGwMz6K+xQBKVIlETDhaEj9CUlLLG
	U8zZabWnlecM9xzFVcM12XNKw/uhDoYLWrds79ohND+lj1o5/4XxfBfA/DCuPQCzLM/421pLx3V
	jaufK+0DvnExU8/40i1hY+DeAVgtwnkeTcWE4T8AGcEWq+0XzFPwnU3Unsx8hAtrG/dAqezizBF
	7lzZMwf0OGBMwyGxff8WL2RpvN1k2e2S3/72HQ9yMdRZACdnmmXOlQbpRgVRMc9/+FpFxjwZLTs
	0kvlKSNa/CEXgQSiFGWjkHVMm2U=
X-Received: by 2002:a05:6402:1598:b0:671:ab62:765b with SMTP id
 4fb4d7f45d1cf-672bfddfa38mr17764762a12.20.1777280467180; Mon, 27 Apr 2026
 02:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com> <20260424-case-sensitivity-v11-14-de5619beddaf@oracle.com>
In-Reply-To: <20260424-case-sensitivity-v11-14-de5619beddaf@oracle.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 27 Apr 2026 11:01:00 +0200
X-Gm-Features: AVHnY4InHXwzijq9_EHG8nzFNQiklw3j5gWxu4FalkCj60yRyccBUvVsyj8tjh0
Message-ID: <CAPJSo4USg0x-wfxLs6hP+hf3MfnbZUrgnLg+zAZxif7d9Xa-eQ@mail.gmail.com>
Subject: Re: [PATCH v11 14/15] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE
 and FATTR4_CASE_PRESERVING
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DA41046F843
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21163-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lionelcons1972@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,oracle.com:email]

On Sat, 25 Apr 2026 at 03:58, Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> NFSD currently provides NFSv4 clients with hard-coded responses
> indicating all exported filesystems are case-sensitive and
> case-preserving. This is incorrect for case-insensitive filesystems
> and ext4 directories with casefold enabled.
>
> Query the underlying filesystem's actual case sensitivity via
> nfsd_get_case_info() and return accurate values to clients. This
> supports per-directory settings for filesystems that allow mixing
> case-sensitive and case-insensitive directories within an export.

10 iterations later: What is the Linux target release for this patch
set? Linux 7.2?

Lionel

