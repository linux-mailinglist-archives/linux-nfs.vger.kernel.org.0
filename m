Return-Path: <linux-nfs+bounces-21340-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DL3MUrO9GkDFAIAu9opvQ
	(envelope-from <linux-nfs+bounces-21340-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 18:01:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBFD4ADDBB
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B38A23007CAE
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48BD3D8917;
	Fri,  1 May 2026 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CBpXWxAg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5913D8909
	for <linux-nfs@vger.kernel.org>; Fri,  1 May 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651270; cv=pass; b=a+LDiEZyY2gyu2WDbR/zhuPwEOaJehd+OkTDz0A5sp5f+/D972JXq10IvtkUPQbNNP/ACpb+XY3CMBQDYXAdmYT7Z4t6OBABeiva2o0acPXhyeqavp+DelUrZ2Gxm57AGHoLGeLCDtGzZmoPLbdMhEtMv/puwUUKLr8K/vn4X9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651270; c=relaxed/simple;
	bh=i7dJg+Ad/jLF4unFEZVC9YnfPvnVtLzsZxdPQEi9eo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRphWMZgfdDfw0I4BGnQ0X8eEDaxKWTXEEjRein7s3awSsxRB/kOqtLBBflqJKo5iKOAJOg8uKo2J9ECQyamxuSgZxXXLmg4PPbdC2DAzp/hZ1xYj9kxQUrgvsRO0ZTBzGbNoXjf+kRZXT+rvgZRHQmaWNrJUdlrFFiHW7XZuaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CBpXWxAg; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3650a4eb605so121364a91.0
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2026 09:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777651268; cv=none;
        d=google.com; s=arc-20240605;
        b=bJoyV4OEKmotIPKI1crCDUpgq2dIAkcJA8neT6aDYLjOlc95xeTGJKHHihk4tcMai1
         ho0HyEtJ6n3VPt7QoEDPLFIfbR7WY2yXxlr/JjBFzpU1+xIbqCW1OeC+PjxKYaUiASJ0
         hP/qtpPQ8DJhf0kdKe/OyEXLx9dAmZYOdmYh+o9y3sDSutPG3P7UMQ07Pi+M86p9jpBp
         pJXcgXzW6xqJUjNkNElEshjlFGPR/SzZCAWiliXKf2Ks9ONN5AVj4yjfSfCcY34xsym7
         ACXewaJBOpSSpVeIWjkt/Ioxi9MYgVI29OM0YsWAK4mlgN5T0BZYeQgevc7zSY2UtLYi
         YAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aWEjhQ0FAeyXxMzwj0dAwfsic/KJmsxnSKQcD3Tkenc=;
        fh=Onh1+m2r2UkXf8yzfDhc6O3Iz5p8QB0xSKNTAm1eT6Q=;
        b=P8+2Gn24MwjhmebcEljTPXyqS60f7MqRIv/4fBF1p7EuGm4iP4swPV89Xy2rN429AM
         Aa27BGGIlVDSzJdpDXOu5pBm1n63wGEXcKAXzjFljIuheHHhXEsGsAJFTTYI0RNymF2w
         GFAhNjpSnA9rYjt/Zu2nbt4zprUUkeJBrBfmNJQGMlwz7OdAmEFCuP0xo6JyNpdKDq6J
         SB5DZEYh5p/akQaIer7yBkncKJKIdFdhFmAEGCbGG+2QZXvJeyvtJb0Ov8zTEUGwULcs
         jW6+uGmUcS95Yxu/EOYLMbO7kleXLl4hlaadITDwE0bW+zi1PfGDONnjN/l6jJQNdS2m
         vddw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777651268; x=1778256068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWEjhQ0FAeyXxMzwj0dAwfsic/KJmsxnSKQcD3Tkenc=;
        b=CBpXWxAgBMkmjB8Xok4tXdUjTk929M0ao0dwZZEZEC6mdNe9MdvnjuOqpXVhH0NVP8
         MVcuN+TdNx4bHaIVDMKE2NTrh4B1QxcsMAFFACegusAQ4fwaFQEcNIXEDftiBSX7jwq3
         q/SmkzexRfa9nDb7/V4yLE9wStgCCclIsEHddAwRHNbOp2cwwrEp7vkLqK0InWac4bAq
         2zD4RQ/eFr/aWwBqnBxLLMBZP5q+wUfXpFJuQ84EA6yXWZPOJkY5TovrNl3CV30ma2gw
         0uvlQevr2alGJ+x1/OliNj9p21ToXn3hJrZVf5RvBTDJg7JZDaYqlcRLmqbLNnzpO6yp
         EHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777651268; x=1778256068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWEjhQ0FAeyXxMzwj0dAwfsic/KJmsxnSKQcD3Tkenc=;
        b=Y4MpQ9Esvt77o5Vi+nRdh/CzZEPI0ZACuBksUiYSRyZYsGS6cv4OlAFBI5O814RebE
         DKNEJupp5GZzrOqMsswD56hcoDCVr6ILKkLOz63w0v07P3w0jSLv0/ypda+OgvBEnmQq
         o2gEKYiWmw1ML1fOhYeeDt/wfWIclh46QA8va8XPpfVNe9Fyepp+oAMPKcFrfTTcb/Vl
         hbzupm+o6si0jzTxHbyVU1IuyOzAaam6wMjcXCDrZzOcRCGOjHHPQVo4ImVWLe1HBh1N
         yizkTOpNKm2Syz0WGPbYavaUK7WF4OoMSJ0v1r8TEgf92XxjSunIamGaWOTbHc3Dx4nd
         M6Sg==
X-Forwarded-Encrypted: i=1; AFNElJ97Hhhb+SBQwYhy3ddbzr3G1IlYsvmW3r9+He45JPCat+thTVTC3uaFcX6ggqKo0IpyEl3jhq6b/QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6R6YMQyQZyzdIndt9lb+45XMesoKsDAfyDybcyljsedRDdyg
	lZd/AiiI31E0rGhslQXq/r/d0HCoLRwD5zPneSwrGTn/gDW6rTSf5xrH4zAIDmEwycTvlbkrfj8
	CHD7N3yHA8pMdhiydZABdMFlnFcR2W31OpLpbazSH
X-Gm-Gg: AeBDiesAbyPq0g15ZptQXri84NXiPuocEKF0Y+bEuMY1J836UfkrmxIG4xpQGCNERNX
	+y+pL2+8SyGXnZ6m0OSjQY7TlvvPTRHZycHc426lZeAfWfn7L4Vx95addEYAV2ds2NvMGHATJQt
	oy+ODWcU7OAUbIOGgPmR63SSUI4FC9z6VwyXM0lbAi1ShqUKUfWQOw4im/0XRkNWH27ayzoROXz
	efcbM99dB9OmyVrsEOLtLL6P2T2kTEgAiWWjaeTDdPUd/U7uTiaV9L0+EQi4D031X9QmojLI4yu
	zrZqIYSKwfwmEutXLg==
X-Received: by 2002:a05:6a20:6a0a:b0:3a2:d838:bfda with SMTP id
 adf61e73a8af0-3a45fe26b94mr4353703637.46.1777651267760; Fri, 01 May 2026
 09:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <20260428192119.226244-2-paul@paul-moore.com> <CAHC9VhSDPg2U9UYZ7Na_A8RA-KN8OsNj5S+QwscW6X20tojhjA@mail.gmail.com>
In-Reply-To: <CAHC9VhSDPg2U9UYZ7Na_A8RA-KN8OsNj5S+QwscW6X20tojhjA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 May 2026 12:00:55 -0400
X-Gm-Features: AVHnY4L3FM6UrambQrN7cixYHO4W-gQ46kIRQQMq31UfNN7fq0b5uZg5p-YAHAw
Message-ID: <CAHC9VhSyDVLOQ2vr0YL1PUCdS-jh0gvwcDruW1f6t9g1WTDS7Q@mail.gmail.com>
Subject: Re: [PATCH ported/repost v2] security,fs,nfs,net: update
 security_inode_listsecurity() interface
To: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc: stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1DBFD4ADDBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21340-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,paul-moore.com:email,paul-moore.com:dkim,paul-moore.com:url]

On Tue, Apr 28, 2026 at 3:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Apr 28, 2026 at 3:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > From: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Update the security_inode_listsecurity() interface to allow
> > use of the xattr_list_one() helper and update the hook
> > implementations.
> >
> > Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.sma=
lley.work@gmail.com
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > [PM: forward porting to bring this patch up to v7.1-rc1+]
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  fs/nfs/nfs4proc.c             |  7 ++-----
> >  fs/xattr.c                    | 11 +++++++----
> >  include/linux/lsm_hook_defs.h |  4 ++--
> >  include/linux/security.h      |  5 +++--
> >  security/security.c           | 16 ++++++++--------
> >  security/selinux/hooks.c      | 10 +++-------
> >  security/smack/smack_lsm.c    | 13 ++++---------
> >  7 files changed, 29 insertions(+), 37 deletions(-)
>
> With the security_inode_listsecurity() cleanup shipping in Linux v7.0,
> I wanted to get this patch ready for the next merge window.  As
> expected, some borderline non-trivial porting was needed, so I'm
> posting the ported version in case anyone wants to review the patch
> again.  If I don't hear anything over the next few days, I'll plan to
> merge this into lsm/dev later this week.

This has now been merged into lsm/dev, thanks all.

> The SELinux test suite runs clean for both local and NFS test runs.

--=20
paul-moore.com

