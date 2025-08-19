Return-Path: <linux-nfs+bounces-13784-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A304AB2CC32
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 20:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CE416CECB
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 18:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8992A30C345;
	Tue, 19 Aug 2025 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahx6PEK0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4B930DD37
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628679; cv=none; b=sVSfLn751nSj013eWye3Ib/bA6CUygbwIbBHF5Qx2K3sMrXxRbz8BSpqIfcNiovUkgsiRRMjLa+lmIP+22o1OdOnmkh1v8PUK5Qh+EO68EAyyeHCLNMx1mrhABReT+NX1eQZZQH9UZiPJBqzqomGnymFEK/vZ7U8Fn7P4WCd8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628679; c=relaxed/simple;
	bh=xHN0Hp9kn9JP+w8T2itzIKfGtctWwpaKboQj/jA/O/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxasRp7fSJMfk8C+XjDm5/KbGvvRJ/nWpREUJoatAfWWUr69uoyzPOlt9t9P6u3TtQoq/pgRjU/0tDBbbFvnj7UJKZ1quhjnD3qTfo9v5OKO4B+YlLxkCYbmt/9JuvIs+IlEherK9oZSd0t+/8r4/7drvo07+Fm0eMAenTvB/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahx6PEK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D7FC4CEF1;
	Tue, 19 Aug 2025 18:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755628678;
	bh=xHN0Hp9kn9JP+w8T2itzIKfGtctWwpaKboQj/jA/O/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahx6PEK0dnJsT+9b6EMxbOsvQwl0WJqwPf3ZJlbUJsZc6TWE9uyl1tWK6p9kD83C4
	 ttu7FGoS7YJpBrJsDoSbavB699FeP+zAMFcGGZKTiP+p8WwfXRCXSVrdxZU/0BK1Me
	 diYlz8QXw4kt1bEE3Kgvu8YSaZl+boF+WuQ3qDMx1MWNkDKcgNbFGktSrdmFQlAgVD
	 LK76cu9+kW0PD4mhaoP5eN2vsNy6zvQzEhsUAp6SGDPyQGn4xZBKbdXVZzOjjnPPXb
	 fzWXtkG0aj0QkjrkP9nWHIfRPi/JQDQfh/I2YvCrlMwDP1IjAoAkp9iXGOgM3lGZhu
	 Chm0CflDnsk7g==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH v2 1/1] nfsd: unregister with rpcbind when deleting a transport
Date: Tue, 19 Aug 2025 14:37:55 -0400
Message-ID: <175562866407.82362.4004457783832759176.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250819180403.33090-1-okorniev@redhat.com>
References: <20250819180403.33090-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 19 Aug 2025 14:04:02 -0400, Olga Kornievskaia wrote:
> When a listener is added, a part of creation of transport also registers
> program/port with rpcbind. However, when the listener is removed,
> while transport goes away, rpcbind still has the entry for that
> port/type.
> 
> When deleting the transport, unregister with rpcbind when appropriate.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: unregister with rpcbind when deleting a transport
      commit: deda4eb2c069843658eb8a102882984f54e80f27

--
Chuck Lever


