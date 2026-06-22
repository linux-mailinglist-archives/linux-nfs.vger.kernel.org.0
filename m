Return-Path: <linux-nfs+bounces-22755-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /djPMEsbOWrDmwcAu9opvQ
	(envelope-from <linux-nfs+bounces-22755-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 13:23:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3484D6AF090
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 13:23:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=KblrSsBX;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22755-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22755-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A24F3009F12
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2026 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8C739A059;
	Mon, 22 Jun 2026 11:23:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B383998AE
	for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2026 11:23:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127430; cv=none; b=NwCfOH8+TBrNWo/1kVLNUEfLNKFbu9w9t4GBJrcQ1GAqVEhPhVKME323OXTBmpuBk3iHCaaBFtQG3ADZQD8FTwQaGCdxRwZR2Dj42Kb40tHzMFXCEL39yy1bmjTLda5tInoryfCR7pSua4yyQJw6gFdXblyOtBL+ySZXze4xZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127430; c=relaxed/simple;
	bh=cO02jLM/sX3PxApH0smnLkC73bA09isiSv76kmh21do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zg5wO65SqllKALwyKNm+WIscSWGqIkq88/kbAUPNhGdry3g4VveZK9BgyoCloodrx5TFdPANr8DtK6uHnK2UPAspxP6rS2WTEdT2FYAzIwcDFiVVg4sQo1DWgwDLiJlLkc9NIJmW1vdFZznHnM1X7ygFxoqjS1nv8FnInYJDpdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=KblrSsBX; arc=none smtp.client-ip=209.85.210.50
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e93e0a3364so2013185a34.3
        for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2026 04:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782127428; x=1782732228; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cO02jLM/sX3PxApH0smnLkC73bA09isiSv76kmh21do=;
        b=KblrSsBXtafZ1DBp8YYJIPsqO89QH+yxCrcaFuxVjXq23msNMPqpIugz9OoGNZ6twO
         xHc/MO79RKMKyqGzgBey1AO+xzSxDo0fT0pSYnikmIMdfMlvW8cYEMGKF2yNP5qjSBbe
         sRNd01qcZTp08aN04bJW6bTfNGfcnUs/YLUYfpq9aezuOegZ1KLY73Lyp8UVWbnRRJlS
         l6HZR8HHjyNHM2Rjk3Mfa0UTaUoKkKwnwwb7lK4gh4llNcSHjTobynHr4sUzIViUFCMH
         yLZsDjI+I4IM6FI92lvI6arIjjO8Zv9hj7LXQ/u+TnFhfPxVo7tObmrjFJAgjjPNpOLW
         Pl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782127428; x=1782732228;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cO02jLM/sX3PxApH0smnLkC73bA09isiSv76kmh21do=;
        b=BTpgiQli5vdUNhpijgHjt+Wbg9wJ1n2IwCinht6n3wF2pbuy06sHQFugFWwX1Hk6Q2
         aKPkI/ZO3nMh9cNPKDlbh+iorMEQaFcQoaVyi8IkiBR08F6REWxJGBUMQJY4xKzzTwiY
         1xqW+MzU7Sh4kM6nFMQB2E2PnGtOuZGki2mZC00QXwTM1jbMiQVRredPC+thB1/4460U
         bq4pv7zuuZBN3iS2xDuuorv+/16anSb/D79gYwHU0pszbaOKdFmfu3scTa2aDPJW43Gx
         AunMt54G0pAzuArIKcSpTWtPo209zF3Cm+w2LjgNzmEaSs2Gu9EMafds6U+/4OA/bbXE
         PYFw==
X-Forwarded-Encrypted: i=1; AFNElJ8a7oBEnRNeEWEmf8Hhol3Op36HPVSSjNNHqYkw5NSwCwFXDxZ1qPjp9P/oXcD30FgZlpbX3O/iVIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAFRV5AUNV57NTi4rW4qUH4Ps43w6cOMWIUhipC3d4y2SGmnEw
	upO4Hp/ZJ/bQTUDjew6KmVI5aQncNqYPf778qnaF/zmarLpDHHKNPMCc7XB3S2qBATA=
X-Gm-Gg: AfdE7cnnqs2jEeUakuObrUL3/GslBsdUC4pLiD1sywsARML8cMAabCE4ZIxiI6Bvrpp
	kJNkk43CZfXAp3PLgUZTwHgGqMmfAXsHHIvwNMwibwXQ5MFeFrAhWG/Wf/BdusoZPk1TtkKFpz7
	4fpHFJ6Y06XmPunbasdrXbwvjG3EWHPDP97mCn9I5h3VTTJzPOabMTwhSRw9v+O5OZq719yhiIY
	+BYlkFrOzFgP4Pm3bk0vP0Wt3uICk5SacWK0YzdrPAE2cqLn6lyNnCJCyEXz1Hy8zSG91ETyhA/
	ZsarpR/E8Qx7irUYxdSRY+vxYgDW4sIWWvfgpoKaCgD7WlbsGLzbKewJ0DqncXxFIV29DEfSWhz
	fhhRMjqyHltcvk+nuujzB90yPtPtTItZadVIjzqscsjsoQXjDEcC7gcCaXjYgavHYs7xj0AO8tf
	Pn8CqPUzrmwC9prQps/+OQCWuC51U4899KsYaOKkL2IDc=
X-Received: by 2002:a05:6808:1717:b0:48b:1e49:24a8 with SMTP id 5614622812f47-48b1e493095mr7671785b6e.11.1782127427953;
        Mon, 22 Jun 2026 04:23:47 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0e5e53sm4403466b6e.8.2026.06.22.04.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 04:23:46 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/4] nfs: remove the fileid field from struct nfs_inode
Date: Mon, 22 Jun 2026 07:23:44 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <343F5ECC-7662-4301-8D89-ED039594EFF0@hammerspace.com>
In-Reply-To: <20260512-nfsino-v1-0-284720522f4c@kernel.org>
References: <20260512-nfsino-v1-0-284720522f4c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22755-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3484D6AF090

On 12 May 2026, at 12:12, Jeff Layton wrote:

> v7.1-rc1 contains patches to make inode->i_ino to be a u64. With this
> change, there is no need to keep a separate "fileid" field in struct
> nfs_inode.
>
> This patchset eliminiates that field, and the inode number hashing
> machinery that is no longer needed. This shaves 8 bytes off of each
> nfs_inode.
>
> Trond/Anna: please consider this for v7.2.
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good,
Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

Ben

