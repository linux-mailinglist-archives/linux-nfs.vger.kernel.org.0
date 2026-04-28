Return-Path: <linux-nfs+bounces-21260-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA6kEAEK8Wn1cAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21260-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 21:26:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8CA48B1F2
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 21:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAE5A3053CC5
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 19:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74D047CC7C;
	Tue, 28 Apr 2026 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q7vwjsmM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605F47D923
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777404392; cv=pass; b=Kemy4FEYzztWvZ7g0DiXEnwxj4N/37F9no7Hm+ME4hrtF7Rx9lqtwlmXGW9UIFYIZJ3QmbEcYOP1fjLEUpBbsMFME4JgcVIIrEX9lQ+8NN2ANITDIOunmZQWPn9EhoTbG/5enpUYXh3H2cTLE/susMNNngWH85WC91pt1BORjUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777404392; c=relaxed/simple;
	bh=U/O8kY35FSPyilg0S9fhApP710nRPp9xFdci0TwAFQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jj3k5eNQZKqURmKNT1jdACfaV/VWN4jh5XJDSnL4tirLhmM0vyOpau2SHQEmS5OeHuii8CBOeMxqUU7C9VuH8+Oez9eeV3l/V+WvT/XFS5Hs9eCLy4jrK7igwOUY2WfAG5ujEvFbC03qPRdhtY51f2wDAWFiQDMPGI1zj7uDZ9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q7vwjsmM; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c79467f11abso7972184a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 12:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777404388; cv=none;
        d=google.com; s=arc-20240605;
        b=aMM5eRoUgJy8H8URqWZLLk0N8bx1etVOi22/JGKxzL3Ld7GtJmD9FPCO+TA6/CKhK2
         unMU7auV6g7veCoR3gm318hM3ndVqe82EVhqgCoAdiL7qAJHE7ywubsNAJ214/cZToRe
         0ekQB0s+Vby9WAv8RWC8TVTS95xZUwBYckb5pjbOhJ8PHZXAWR/dlcC+nxgBW0ZuJTzH
         FVyJScj7obJ8IFh7KZgZf9qj7gSNSL2gBD4cHBMZtWbzy/OA2h0+lR7R1JtFUT960dwb
         iYN8Y57JLqaHqLuL+6t+4xgQu7WX/If3ZrfFwVL27TvY2U90Ozb7tlFU7smg6wEjskjH
         GUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AnfM8zUa1lWAp+XFfhTnKVtdHMyqVSknxxMlh2RVx+s=;
        fh=7HFmZ+KAMv7SPxTW9E5bPFnLddUTM4PgNZyikIFz5/A=;
        b=Oa9J19o5CO7mPa9lZxFaDWX+E72B7eBDIL2KSuh58EzpdR3mYIcU22guBOoXsZeN7n
         NrKkjI5d+qrXhSlKaf4H/sGyEnocabu/qKi7HcE/g3ALtTn/zPt3aa4JOY13IU7R9cpc
         zo3VkKBq0l55D9pTD26h4Vrw3QHprN4i4CaebNd/+FRfxIj14DnYkXjWGpscwt2G/0iW
         FTl1GRAmjNKwo7LqOg7TA7iTxb6BViCrDTphI+UYcgQrb4CyTMuz/VkIjHo1WBCUnHWr
         o1K+gu6zFEo4dUhzI+yFduCCLYLdlfXBTsU7C0TXyQkmtJ8k8CQ8qoL+OMt+GGQE/e7D
         forw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777404388; x=1778009188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnfM8zUa1lWAp+XFfhTnKVtdHMyqVSknxxMlh2RVx+s=;
        b=Q7vwjsmMKcT1l9AXMv9x+KpTvpFxUKicUV6cTZMYhfBbNByB0fZF26MMPg+TFYXldO
         wAJnS+xEWXJ9B32JBTBrBIiic2/TeFFLzWJgSXX971s8U5GdjVU5swP5jQNe/htLdkI3
         ZdgeBBL205oAlmG8o0ZHP3gwEnRf6+CuAq1bnKD7K0LesxTfN2B6HATKPShdePiNxe9l
         5IKU/kkmPcPleMi63gfxcs/0a3ucVgI8dCjkUP2X6731EBcWvHp3wHrzOUzZpdkcqCUB
         hKkLZBo5SE7N74E8O4Q5Nvc3gLmrBdIjySsJTh6B0ctBuAz0XLTvOffHG0QD5sJswMLI
         q6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777404388; x=1778009188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AnfM8zUa1lWAp+XFfhTnKVtdHMyqVSknxxMlh2RVx+s=;
        b=juLGirgz9BdmIWOe/f0rh32IdOKDRmnYGJBmnQC99esjL181GT/B3c7aXpXQNcJR3Y
         deRCoM4kos80pEro+29L5m8qJE4xBkWfjc4IL5hfFlsg+NWCxPSApyHYalFq67UauzYV
         FaWJwgM/D5f6m7bjj7Cf+uHJGVIcrlA+j16Ue/N0XmVNSP/F80/vJiFvS94XcZvidGdm
         D0SyQArpf93CunwhYqj90YKjC4VkvZGLf56IXw2eEL4bvQdOGSujZG4XoPyHy1Ow09L5
         j6OkG1QeH7wbpYKwtNAptlMMDjEGgpoL2N3ZpS4fJwlmmgDyYsg24L+Ldq7TnvI9w2Ae
         qmLw==
X-Forwarded-Encrypted: i=1; AFNElJ+T7hNAo0D2KMmNyinn5UGO6F6YXu2vK+RRgS3AD2VLDTWDS6hQvFOs1eeYdJ5Nfd4n2Z5JTf+lDZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwECvh1YeLPN9ZPofYKSnFiwDnoqBWJ4XYDgj8AOwlMi3Md2c3E
	IDhWVB3K5S8ZJdgirc49J2kZ6XWo+J6K2sCUWmcPpyE+jujyPG90Mf8xcXT8EAsqQBLO1km5+tp
	bhz9p+GNyrxRSEKDC9y5xEyeUsCF6ASPAH3CbKl/q
X-Gm-Gg: AeBDietR3UjfUIUvD44Gs7fEjnAUBX/u0mPd7OtFMEDgGpVcY6ATZtijHWUhdeDpBaT
	joVvt6BEZU/87/XRGhvKqHSkWmJnzTtg2ndenugcqudyJvWH62wqBhQAxHUbFALnXh3OckLjqyN
	+zOGXrL5zL/I4nMT90xSTp3gVz1Ix1wRD66Ze/7JLr32MwH/HADTYD1cKfK4yax5CwMqHekBYsF
	kaVKQ7KMteo6b0qeKMTBU0T0P3MiJT2hD7VsXU7hfeSFGUhw13X1JLH84pPxda2m6ejpioulPk4
	78bfP0AxQ2zx5emFXQ==
X-Received: by 2002:a05:6a00:b610:b0:82f:5f2c:dc1e with SMTP id
 d2e1a72fcca58-834ddbefc48mr4513385b3a.30.1777404388228; Tue, 28 Apr 2026
 12:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com> <20260428192119.226244-2-paul@paul-moore.com>
In-Reply-To: <20260428192119.226244-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Apr 2026 15:26:15 -0400
X-Gm-Features: AVHnY4JfXj5rdz057afaM2yOoDKKiXKQXh_FDv64DRP8yW2NVR2QdpNqmASHI1Q
Message-ID: <CAHC9VhSDPg2U9UYZ7Na_A8RA-KN8OsNj5S+QwscW6X20tojhjA@mail.gmail.com>
Subject: Re: [PATCH ported/repost v2] security,fs,nfs,net: update
 security_inode_listsecurity() interface
To: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc: stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AD8CA48B1F2
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
	TAGGED_FROM(0.00)[bounces-21260-lists,linux-nfs=lfdr.de];
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

On Tue, Apr 28, 2026 at 3:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> From: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Update the security_inode_listsecurity() interface to allow
> use of the xattr_list_one() helper and update the hook
> implementations.
>
> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.small=
ey.work@gmail.com
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> [PM: forward porting to bring this patch up to v7.1-rc1+]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/nfs/nfs4proc.c             |  7 ++-----
>  fs/xattr.c                    | 11 +++++++----
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      |  5 +++--
>  security/security.c           | 16 ++++++++--------
>  security/selinux/hooks.c      | 10 +++-------
>  security/smack/smack_lsm.c    | 13 ++++---------
>  7 files changed, 29 insertions(+), 37 deletions(-)

With the security_inode_listsecurity() cleanup shipping in Linux v7.0,
I wanted to get this patch ready for the next merge window.  As
expected, some borderline non-trivial porting was needed, so I'm
posting the ported version in case anyone wants to review the patch
again.  If I don't hear anything over the next few days, I'll plan to
merge this into lsm/dev later this week.

The SELinux test suite runs clean for both local and NFS test runs.

--=20
paul-moore.com

