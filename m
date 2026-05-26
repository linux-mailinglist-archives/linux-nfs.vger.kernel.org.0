Return-Path: <linux-nfs+bounces-21938-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMoeOEpIFWqLUAcAu9opvQ
	(envelope-from <linux-nfs+bounces-21938-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 09:14:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8726A5D190C
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 09:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 644493005992
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 07:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8CF3B5826;
	Tue, 26 May 2026 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE+3QAot"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E913BD237
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779655; cv=none; b=JU9+7yNrzNp4CLmYELUYGFCdsCbMQBvmvD5HfpYB3YG7bbDngvbg1C1sXq5Es+jTdTQAU8YPVft0WUorRu4d3MPQsz193uwZNYf8aU/ouL5dShcsS8Vn+xlTvBnRFzPRVJwBLCldmNM7m4/18JFwngBK/jBaHLUIdVqaQHrS77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779655; c=relaxed/simple;
	bh=66qizlrtCwOvYCskc9Z4D9GEOxk4juRD1CgGxs7OKeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0pFvwqpKhDuemcQmRnziIcJlUuI0bLhVMIJMDQYRfHn/7tL8Fscu98ljHuK9PyQythnVK3bOu6L/UfNwnvxxibJgegXaXmh2N4vk+Y3ITyjQr0vgOkZolI9h6Ls/DwC563FQDCJZQtnaG6KX3VaDIbaomQD+N8JX9uuTK/NucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EE+3QAot; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso87433425e9.2
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779779652; x=1780384452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dj+eE+RlTPGlS54IS4RQITRV1ozUmgsawvGomWzpqKc=;
        b=EE+3QAotCYI9UYfOJl2vpzmReX9EcSclOxkBFtklY4GiEgvV38DuvZ7FNTfNKybyLP
         2Y2H9UdWn1coLehfXcMyPHqSii8afHze9LYFA55tJ+cPVTTMGoyEX6GyPhPVIuj6KwQM
         DRGg+1TxiX1EnG7UuEFcuhVsZxWutUAIDhEM2VXnQRCXYoGbIGno5Xyqo2zciT5mCDS7
         5xwXVrGysxQ/M6SN6gQLBPeeR+rKgDTtV2oIZD9r03EVwSXCRxFOQ6/rAOa+c9hCmjhn
         6HhmKoZf66Ac4KPSxn0hFh+nFnM5XwpeXHaHq6frCFaMBtmZ9PtIxm62izAYu6DKr6ob
         zk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779779652; x=1780384452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dj+eE+RlTPGlS54IS4RQITRV1ozUmgsawvGomWzpqKc=;
        b=Z+z758ps3mnL3icwtdoeob/FS27S66Giogw5tWai0o/DwIrgLDG6yu8d2o3+wEexxt
         sGe2/pBH1Sca2zBubmLRLrId0EBVDE2K4O0w+BZeNjRvWIPKv5frlQtzhkh51kxPqhKy
         Sf+uQYyCelSZIAlrhG+G2HUjrgyBy4afj8Ywxbgd61HXVE6iHe08f+I6JEZGHJn5tOd1
         WwNjVKBmdR0Gd1fsIqaXiHT63KNc8DdsXLTyaO/d4HxG5bc4a9viP+tUhB+q4Kh8DHZW
         doo7CLmCmzf11I3MzuFZ0u7eR9DQ9wJevDFZLEGvo+YQ+NKqewaE4/3qylU6FBHxulgl
         8+1w==
X-Forwarded-Encrypted: i=1; AFNElJ9gXGpYDGmq1K54/ZhaUuX1cDpDvPrKGalTShvSAnGwYItuOfXMwKv1lL97P32MII3Qjv1u/NG1dtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKurQvKmFkL52sd59edDuxo4vSISbiCL9e8m9/uefoeHWgbud
	pRMixHS35WZvpLu0ZVhD+ImPZvIQTm9AWKNDxKhxbZy+bM+VuVBmTl/H
X-Gm-Gg: Acq92OFh6sVon4v/FmDI4O9xaDGnYnE9VfbRTGD1BGN4zrINrMTVutpbk9FCkaGpwEf
	lP7zCNEPtAFOyM3jmCRgiXUclykWdqTErOOWS7xu7/QCAH7O2jPsi6SMLtVhHo/Y/7R0HjdrB7L
	3PWqOtmtLD0k8/PCc7TtjDxAtPbinZgziIrEnDufd0jr0otsSxIqLNFskBtzgE+vytm0Q/4qqIg
	JmXKWV3oqCH9gVJTlnIbkKRW5hXfpeNvyzenzDdm4lKrce6xUBSUUPvMg4okSPQ+aCMP3Se29/5
	LePHj9kKSg0UtzWFAV7WY/fySAZehUHI6xZBI5Xp39z327gfO9QLbR46tN1QEq0T91wjb69dcVA
	XiGitYEVJ2EMWvTV6X8MzStwgr12XJeqExcH0md9u+CpHSFAcYbor1nXTDLvxk+877gUONY+SQ8
	GOnMkSPfCDieb/Y+eIjwRLQ8ZQYzMO2WPidiuzUpMUWqHymLeW6QkgxQurKbwpIvzCBUexpdg=
X-Received: by 2002:a05:600c:4591:b0:490:6869:46c6 with SMTP id 5b1f17b1804b1-490686947a8mr90576555e9.31.1779779652251;
        Tue, 26 May 2026 00:14:12 -0700 (PDT)
Received: from f (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490418b27b5sm104970705e9.11.2026.05.26.00.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 00:14:11 -0700 (PDT)
Date: Tue, 26 May 2026 09:13:28 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Benjamin Coddington <bcodding@redhat.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] VFS: fix possible failure to unlock in
 nfsd4_create_file()
Message-ID: <36bvv2anew3cegsd374uzwdgue2txpgnzo2357ye5pldqi4by6@lafavyjgevqo>
References: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21938-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8726A5D190C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 04:23:45PM +1000, NeilBrown wrote:
> 
> atomic_create() in fs/namei.c drops the reference to the dentry
> when it returns an error.
> This behaviour was imported into dentry_create() so that it
> will drop the reference if an error is returned from atomic_create(),
> though not if vfs_create() returns an error (in the case where
> ->atomic_create is not supported).
> 
> The caller - nfsd4_create_file() - is made aware of this by checking
> path->dentry, which will either be a counted reference to a dentry, or
> an error pointer.
> 
> However the change to use start_creating()/end_creating() (which landed
> shortly before the dentry_create() change landed, though was likely
> developed around the same time) means that nfsd4_create_file() *needs* a
> valid dentry so that it can unlock the parent.
> 
> The net result is that if NFSD exports a filesystem which uses
> ->atomic_create, and if a call to ->atomic_create returns an error, then
> nfsd4_create_file() will pass an error pointer to end_creating()
> and the parent will not be unlocked.
> 
> Fix this by changing dentry_create() to make sure path->dentry is always
> a valid dentry, never an error-pointer.  The actual error is already
> returned a different way.
> 
[..]
> +		/* atomic_open will dput(dentry) on error */
> +		dget(orig_dentry);
>  		dentry = atomic_open(path, dentry, file, flags, mode);
>  		error = PTR_ERR_OR_ZERO(dentry);
>  
> +		if (IS_ERR(dentry))
> +			/* keep the original */
> +			dentry = orig_dentry;
> +		else
> +			/* Drop the extra reference */
> +			dput(orig_dentry);
> +

atomic_open() is a static func with only 2 callers. perhaps it would be
better to change its semantics instead?

I'm asking because the vfs layer is very slow single-threaded and this
here just adds even more slowdown due to avoidable 2 rmw atomics.

Granted the affected routine is only used by overlayfs and nfs, but even
then this should not be necessary.

