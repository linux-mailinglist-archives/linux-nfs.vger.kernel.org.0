Return-Path: <linux-nfs+bounces-21468-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDs4KazkAWoEmAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21468-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 16:16:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B95E350FE6F
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 16:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CB32302EC9B
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C553FADE9;
	Mon, 11 May 2026 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHh6BeNV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B63F9F49;
	Mon, 11 May 2026 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508182; cv=none; b=B/AFR9whW6CQTPj048sUbvRNIb+t/SGEdcYKqYcWsleek5MzBE3idjtboRZKR+XEDsN6TqXa6Mf9Ivyr+M2uav8ZciNQ1k8v8A2ymeQbj9rRiKg54MjsDw7+QzAsO8q+RyHgYY3rz4EvaEKgY83jZ6xAzHkanUS6AjPnaGzPKJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508182; c=relaxed/simple;
	bh=RgTi2HyJCaLeMiU8Fz6KzxgFZeGWAYkpKt4i7qk5j/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqvSoZ7qj0+5TPseX0KDmdPtHfBhTOiGATLmbTvu5CadB/lVPPk2obYYsLKXLe4AkUjwmmHEhCoClLpczI7+q4HlIBd9tWmjPoGbrnEYsyBeRHdgykvivenBfrAVif3bluqjg7FZb9fJvRDzRx56s1QigJoZiZtK6TfBu8aQdk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHh6BeNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2C9C2BCC9;
	Mon, 11 May 2026 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508181;
	bh=RgTi2HyJCaLeMiU8Fz6KzxgFZeGWAYkpKt4i7qk5j/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHh6BeNVXR5vm2TUiXQsksN3VWXztHJjQkFUZMOC+Qda/fWEMcns/JjxLR3zxNEF8
	 RW0LUH87ebCxHlpBnjBEVZ4eYSBHU4SYUwgBJCjBf8Oy9rdsZ6jiuKrkH4PhwjeWk+
	 pe416YP5BjHKZ6H49uqVf0DOF3Oe+9zXQF0ovomTWTQ1O058SCn8LVYT9gf3zbHgNW
	 1tItZO73KnbZttQj67r7+SUNkYvwl10aiIUwOq17sqCObXi6e5mT3HSiViqfG4oHS3
	 I3+ifllP0AIc51Xw+F4Pn3DQNxAwmqb99mPNsRgVCLfqrI/k4HWqH+BGQHyUBSJQFn
	 RPDIjjlkL5JEw==
Date: Mon, 11 May 2026 16:02:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	sj1557.seo@samsung.com, yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, anna@kernel.org, 
	jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org, 
	Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Roland Mainz <roland.mainz@nrubsig.org>, Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH v14 00/15] Exposing case folding behavior
Message-ID: <20260511-verhielt-osten-3fbfde3e491f@brauner>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
X-Rspamd-Queue-Id: B95E350FE6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21468-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 04:52:53AM -0400, Chuck Lever wrote:
> Christian, let's lock this one in. I will post subsequent changes
> as delta patches.

Perfect!

