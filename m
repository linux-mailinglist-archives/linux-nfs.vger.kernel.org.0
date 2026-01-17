Return-Path: <linux-nfs+bounces-18076-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBE7D38FD9
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 17:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 480FA3001636
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jan 2026 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EDB1B87C9;
	Sat, 17 Jan 2026 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn6PQtBK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D1E9475
	for <linux-nfs@vger.kernel.org>; Sat, 17 Jan 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768668622; cv=none; b=jxDmbmzpIayHlpdxdiIIheVqq4aFcAp9zMfNfcne2Ed4sTsEWiioce2ZWwdidM7jm6fsR3Dzcnani5t7pj8k/Qs5SxtL0yMEyUh/4URA7cktr7hpyKY8JuBzdXWVjO4TXY2wLkG+B6iITYs08v2CiqT7kCSXuktzxXdG5tj9PcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768668622; c=relaxed/simple;
	bh=6sS6f76TuLx1BVhaZkr1c4KD+Ll6OoB+659BlVBzcVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4X7AyOx6U25fgyM6lGp6QZ4O+4C+N34uUAHNmvvLvzR3mXMOZ54zPl2+INXQDBYBXIsrI+wjy46KYCudOut0QVxjCD9IHMH1meVOFRbMqZ67fQakp4pI9r2h1CACbwHQoBXqgnLXrMH/9xX6ELIwoomArIarrs4EFMYN/sGj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn6PQtBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D929EC4CEF7;
	Sat, 17 Jan 2026 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768668621;
	bh=6sS6f76TuLx1BVhaZkr1c4KD+Ll6OoB+659BlVBzcVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mn6PQtBK4E51BQFFn7UIxJ1FNrSr44w+K4NCt0YhkOwtepGtJW7kvue4kUWx9q9qS
	 93ko1tP00hYt1T7SDISAA4E0FxR6fDxSiyWUNTHUMzaxsGpRJ5vxXAeSseTVJdocaV
	 3IX0TKXwlPffc403oa9DDlbcz0HxH9VOAUW9Rq05qVKvfPEp8wUbivdhZ4GJJUlMNq
	 2ikBb4hHnEZ18+0GEQURgOxIDtagxrfPvLJCoKKlmeKipyv3eI9oRo+Zt9BZPi1HHs
	 3x5nbIO1LMKiMnzgWFpnRdhySGqyx1bW730iuIA03/QpmR81fgPm3vU24Cx6Ll7As5
	 sG883s2Wn9kEA==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@ownmail.net>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] sunrpc/cache: improve RCU safety in cache_list walking.
Date: Sat, 17 Jan 2026 11:50:17 -0500
Message-ID: <176866861224.9003.1319894955931732373.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <176074628319.1793333.3387532760794075868@noble.neil.brown.name>
References: <176074628319.1793333.3387532760794075868@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 18 Oct 2025 11:11:23 +1100, NeilBrown wrote:
> 1/ consistently use hlist_add_head_rcu() when adding to
>   the cachelist to reflect that fact that is can be concurrently
>   walked using RCU.  In fact hlist_add_head() has all the needed
>   barriers so this is no safety issue, primarily a clarity issue.
> 
> 2/ call cache_get() *before* adding the list with hlist_add_head_rcu().
>   It is generally safest to inc the refcount before publishing a
>   reference.  In this case it doesn't have any behavioural effect
>   as code which does an RCU walk does not depend on precision of
>   the refcount, and it will always be at least one.  But it look
>   more correct to use this order.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] sunrpc/cache: improve RCU safety in cache_list walking.
      commit: b4e702355adfd46215c52e14dcf661dc857afef0

--
Chuck Lever


