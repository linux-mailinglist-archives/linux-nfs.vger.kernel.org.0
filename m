Return-Path: <linux-nfs+bounces-8224-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173C79D9A07
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 15:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816D4281258
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2024 14:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD61F22334;
	Tue, 26 Nov 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVc93oP4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8F28F5
	for <linux-nfs@vger.kernel.org>; Tue, 26 Nov 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633049; cv=none; b=HmxLQ5Wk0fYWF4muDVWYBYBPsWRZVaLYUHxYnCzDF/JVKKu7Gl1lnkz1WC4c5Kb9M94PNOKq/l+A+aagaNNMuk9q1m7KAHnrkyd+RpuPm8G/ZLtKfKrJ2MkNOzfOC3A/rOjb0wLQydwZtVnstFgQDFFtdKjK1aBudr473r7Slog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633049; c=relaxed/simple;
	bh=bDofWbLbml95bsIKfCQbhqQCrV7K3GHr1CBKo/RI/88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8M63NYYpDx+cphqEgSbkT++kI8lmJ5wjfZtubFM96JDOMp9B3Me331qOPYvfdkDyB8UjWZTePzPD2ImpJAopKLiYTKkhITMYN51Skq2kIhkOAE/yc7YVKsuO/EhqQ/8vohpI0X13+wjSy+R/6G5fGzS+fj4A5ilXcI5cvNcQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVc93oP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F617C4CECF;
	Tue, 26 Nov 2024 14:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732633049;
	bh=bDofWbLbml95bsIKfCQbhqQCrV7K3GHr1CBKo/RI/88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jVc93oP4oSVRNPAvKxb5zdSF38Etsn3EV+Gbw3Tx/IKlapL6LU74WuwOX2kSNMbdd
	 0t6rZObuC+yXDxHcbZC3jlJ9OIL8mNqxk/kYZMJgFxyqkH9vFgrEtwTrhwNJtZd4gU
	 /IENOllUeHZKfLZuJQp01UU+darsybn1SgZ9WIZTij/AvZnVNLbdYIKT36+F+KT5zK
	 H4/s/3yNg9YMuSbshasOneC4PsFrjc27qdVPEWPwmQxwV2oMu9qclql7srcabHEZ4e
	 ggNrB4fIuxY/RJUDMr6bgGqare2e62U4sEmJCCNgv53bI50blDbEGssqVa/2PkabY4
	 hYuj9EHRCkGog==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: trace: remove redundant stateid even deleg_recall
Date: Tue, 26 Nov 2024 09:57:23 -0500
Message-ID: <173263298050.143981.1082962198641891547.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122022506.1536-1-chenhx.fnst@fujitsu.com>
References: <20241122022506.1536-1-chenhx.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 22 Nov 2024 10:18:25 +0800, Chen Hanxiao wrote:
> Since commit e56dc9e2949e ("nfsd: remove fault injection code") remove
> all nfsd_recall_delegations codes,
> we don't need trace_nfsd_deleg_recall any more.
> 
> 

Applied to nfsd-testing for v6.14, thanks!

[1/1] nfsd: trace: remove redundant stateid even deleg_recall
      commit: c5dd3c39ef0a4f2ee654a9f8f3870ad2609a7bf2

--
Chuck Lever


