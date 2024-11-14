Return-Path: <linux-nfs+bounces-7949-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 361289C804D
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 02:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29006B256AA
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 01:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DBB1E009F;
	Thu, 14 Nov 2024 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAvhWLnk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262EF1CCEF0;
	Thu, 14 Nov 2024 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731549362; cv=none; b=ItfcjNwKBr2ly3uZbr76BJriflxYI/+1Gl5Z5LLm0/m/OxNI0c6V7jtnodfvxCrLc5qiwMC9KdtZWGHwlKK/OZHDYs0GTdCUxTxmwpc4RMinRUxbU+2goUEJTyApVAP0rX0a+Iv4Uyd/38kTGvyLTKb6r35yA9VLV5iBGHhQq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731549362; c=relaxed/simple;
	bh=+ppJhPjbKbgvCrYm2ur/fCyE9SXnPm9iBZt8v3EHEN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akLwmSftcmb5Cbkef2p4ocgECfB60gHtx/+jRyzIDFBIsHDAersVLtfI18kcv3Vnp0WsOGxGLDGi5RrlJKNLsgbpvIfCDSD+Cv8BQQMv+9764UhqmoDxQREQg6uidO1ff1UERGkI+K8wBi+L1cU0vC56tWy7hfkFApadLdikv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAvhWLnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF89C4CEC3;
	Thu, 14 Nov 2024 01:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731549362;
	bh=+ppJhPjbKbgvCrYm2ur/fCyE9SXnPm9iBZt8v3EHEN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EAvhWLnki8htZbI/xybCc1S+6uWtQ5V5qceEBp7/KuJJ30Pi75x4d1XWzieSwgEJp
	 BSCXvJ7wSGkRtKxUNnBLVPKwEbq44+j7Ca6/JBWDBI2JZLeait6H67SGeVKZNBnn5+
	 S5pUxaywk4i5WKQV497FFT1P3YNJV67pfGP0nwxa8OFPmCWjgF+qT8HvYjw7AtjjhG
	 OqT7IuaQNJ+DZlSkHJr4aO4MBlkBgS9RCuEH7XMFCiQc71L8Akgxif2qvN7hA7DJqo
	 N53UX1aVdfthmrjoZ0ay5vlzUJr7dHBxFMFmaZJqPlrjX6goYKeYS3P3MnR8fzX6fD
	 x9WzPJnbdBXmA==
Date: Wed, 13 Nov 2024 17:56:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Liu Jian <liujian56@huawei.com>
Cc: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
 <okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
 <trondmy@kernel.org>, <anna@kernel.org>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <ebiederm@xmission.com>, <kuniyu@amazon.com>, <linux-nfs@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net v4] sunrpc: fix one UAF issue caused by sunrpc
 kernel tcp socket
Message-ID: <20241113175600.3001daca@kernel.org>
In-Reply-To: <20241112135434.803890-1-liujian56@huawei.com>
References: <20241112135434.803890-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 21:54:34 +0800 Liu Jian wrote:
> Subject: [PATCH net v4] sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket

To avoid any subject-tag-based confusion, we're not planning to take
this via netdev/net unless nfs folks tell us to.

