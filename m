Return-Path: <linux-nfs+bounces-20982-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPx3DOZZ52l87AEAu9opvQ
	(envelope-from <linux-nfs+bounces-20982-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 13:05:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5657439E4A
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 13:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8B393047BE8
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 11:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66BB3BE624;
	Tue, 21 Apr 2026 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="cJ0zXK8T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FAF3A450A
	for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776769253; cv=none; b=nUxESC6gsxeGGYil4BO+60nHqQT6KB91seSCiGx2gabaozxQTv/EC3fLASuetf5N2P+0glzVFHTokre3HsKYjvhphCpbkUdHIxviKRjBTk/DP2ywLiVWqxvVuqnuvaKXr7TspzXWa8dxkk4Xw0EHmI8KLJut1lN/2jPELq1elRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776769253; c=relaxed/simple;
	bh=ShnqzBoz//7TZHEpF/+hyFFWg8Z7mHDbUu1v7pWAbsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQZUfOxFrBB3+lDcrkCq/z+J1m23hyDyFQD2WTVq1IwkkugXqMudH6bqqzE1d0xIOfD5siZaS3bG87pMScrygaHsldA91fLPFQwqpBMQ8wgHibjb4kC06RBKtJdUVWRbrEDNG922aa6q9oo/ptx9OHy6EIpfdVfuKsfPR1T8lsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=cJ0zXK8T; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479f7e75a6bso54841b6e.2
        for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 04:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1776769250; x=1777374050; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ShnqzBoz//7TZHEpF/+hyFFWg8Z7mHDbUu1v7pWAbsg=;
        b=cJ0zXK8TrvmuUuLqC/geflzaYKuOKZ1o/C1sOvBtZaU8wO9DYzXJzGNZ4/f72R0kS+
         nMfgg5X3CqY916CX2E34tCCKUsfatDhD2aW41eU6k/avhZjPPCAo7ueLR71NFvsg3ZZV
         x9ESoUWLUGzML2dItqxPuHjmmGLbg0FTT+G/N5kiIaAGw1lOo9tW8K2n7DUTkyHrUYBz
         K17MT3cKR+35jx+DGWV0VCpRJj0Y/uB0aolru+1N3jSH1EU5TxNhEn2AmHMinWX3eEhQ
         AIyRIGDBvYW0OzJ+fsMKPdQZ3p4B9Q4870DTRbCZekGUcVLnnJNHMuulKiTfM3TX4tFw
         gpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776769250; x=1777374050;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShnqzBoz//7TZHEpF/+hyFFWg8Z7mHDbUu1v7pWAbsg=;
        b=P4CZUIp591xbFRkxQgxqW/8oNrr08BLjxMgk5IQ2W6GE8ax039lqZ4/djM1QCwpNnx
         sR56KOG+n9j67eNY7Rh33dQnIVqvAs+Olcz0iRgMsukzKUD1s9f/m57JbnZXeRDrTIgC
         Q3Obe+rqJ+hT1Wkq2egdtX6bSVGYZHhwh1TwvpPxVlOC6/6RKaRNt1ghI0yOCUwA6FZ/
         mH+TmVWwh28a7ag2/lJkSUxAanGeSiRPQi16LR/7Vw29dWRE5t4ZOULZEyPgszWkETUT
         /IG7Wp3OdMt2B6CobtmNDWdurdbCcy9pz/WLpbpfaYmMDGLGk0ybMI8KZx97QPTL5YTk
         /AUg==
X-Forwarded-Encrypted: i=1; AFNElJ83TTVw0BzdJr3ZQalSrze4Upz0ztW5lFPdWe+0lSue+Mrrq+epgGl6IUIa8n3XOWB4QtWyBczUQw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOALsLWyfIjwsBq07x1/dGRItorW880o2+gZ2dmqPoPG0diD7K
	t0YiAS3j+sf9RIfTJHhIMPxgpCvJg+5LiAlTknGFX/pLWPa0v65dwPHqV0HJENC1pZQ=
X-Gm-Gg: AeBDieuDrspkgOqs1AGBHutaZPIKpP+CHn++FjocotX3ffK4OVTqurMDjSBL35uetvH
	gDPApVkPm44nZQHLZM+bh7IUqqpQez9ZK1UZfc0s5uHqLTZIpExJXcF/WvqjQG58miwBg4lr97C
	mLy8V63regkF3V3JJ/acngQ2TJBeLnW6LNMdg4cfebzKLxd6U2DCju4mITUtTInZ02k+2DUfuM5
	zKLl2seLRH5mB5wFqJhlFUqZJZBeysto/IGsiQeu8X3C8EMHbIiO7OZSXmCWQvOwhuY/gRK8c0U
	K5bfA9+bmTjs4mE2s6gI/OngJZt4kmvmLNb/uZsD2urzex7HyuIaqHolDqZSXU3uKRR1KsOM6uU
	D649vanBmKlYS2eY33SXyZuP47TTtAvzcDuOwwSs76C0pptEtO/bpSJxWALyIAKv/zcbACQr1ty
	f6XtLqdt1VsS0JKxbdKGi6rd4zQFSPnzwh/LMkNDs1F7Y6C1U8sxyp1w==
X-Received: by 2002:a05:6808:10ce:b0:467:f62f:88c4 with SMTP id 5614622812f47-4799caa60b4mr9032428b6e.45.1776769249613;
        Tue, 21 Apr 2026 04:00:49 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a0391d45sm8481144b6e.17.2026.04.21.04.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:00:48 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>, trondmy@kernel.org, anna@kernel.org,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] NFS: Fix RCU dereference of cl_xprt in
 nfs_compare_super_address
Date: Tue, 21 Apr 2026 07:00:46 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <00DC338C-976F-43A7-B38F-3C9D8DD2D082@hammerspace.com>
In-Reply-To: <20260419163138.26963-3-seanwascoding@gmail.com>
References: <20260419163138.26963-1-seanwascoding@gmail.com>
 <20260419163138.26963-3-seanwascoding@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20982-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5657439E4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19 Apr 2026, at 12:31, Sean Chang wrote:

> The cl_xprt pointer in struct rpc_clnt is marked as __rcu. Accessing
> it directly in nfs_compare_super_address() is unsafe and triggers
> Sparse warnings.
>
> Fix this by using rcu_dereference() within an RCU read-side critical
> section to retrieve the transport pointer. This addresses the sparse
> warning and ensures atomic access to the pointer, as the transport
> can be updated via transport switching even while the superblock
> remains active under sb_lock.
>
> Fixes: 7e3fcf61abde ("nfs: don't share mounts between network namespaces")
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

Ben

