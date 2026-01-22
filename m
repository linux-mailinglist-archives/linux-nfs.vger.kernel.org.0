Return-Path: <linux-nfs+bounces-18328-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BiMDHd9cmmklQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18328-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 20:41:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E946D25B
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 20:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C90C307257D
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BFF3994BE;
	Thu, 22 Jan 2026 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if7jTXIN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED235FF45;
	Thu, 22 Jan 2026 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110592; cv=none; b=HL6K8djFNdd+YeJbRpKKdIWPOJoRxistwSxi4xZMV2U2mwueXB7iUKV56AiyaR5dvhw7Snq/ugQzD5CHp3cvdnEo0VNOVVh0uxcuZc6fPBaYqqOf3v8eMdeYG2zouZqT6tNEnVrdtjQ+pW/J34O11a0KEjAvlu9EJbTzfvkQOzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110592; c=relaxed/simple;
	bh=3kWbwxpK3SvyV1OTreSwy9ij/mNgNWrCeYJu7HqKl4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWzhppfdCrNm5TxWZHlp5Wco8d7iCXxMHVTsMzWIjnxbaDhXfQRPoROY72hRQhwpOI9d38zol2t9TmzB8TmXI83PMG4z9jT6IszwNL4tCfJ3HBEpEEH+RHA4XiOeBubpqDg9wC/7UFkxD4zQKxAihcMGM7YZfNHM1RjwmAUkJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if7jTXIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A1EC19424;
	Thu, 22 Jan 2026 19:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769110589;
	bh=3kWbwxpK3SvyV1OTreSwy9ij/mNgNWrCeYJu7HqKl4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=if7jTXINZAKjt9clPTzaoplU4q+F0Uc/G9Etw0l8rPqDaWSEk3bGtfJAlMDjGkSfc
	 mMW/d5876k4Nov5UsCqWpFqSHt1Yt0NxbApv4jhcZ0TLFy2f9tCzDPPjkX1uVnvG0d
	 Z8o/N0Ba0Tzr5FhQDyhid4rnfqp/ymYkvHS+wZERSweP0yfKHeJ+CMi6+KO/AQxIZn
	 921fRkx5AR+44TuQV7BNrKeZuXNlVXrSgZATusQ7biO4iiXSFCyqb1p1BNGRkvPoeo
	 8jdg5dip4DFr5Uf0aZZBRj4LcvzbZvwA0p4CDATozWe9uZ676LWLh1nRnuP9FShkYw
	 FxCXeq558mugg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: remove min_threads file from nfsdfs
Date: Thu, 22 Jan 2026 14:36:25 -0500
Message-ID: <176911049554.1126364.18140238216896313921.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122-minthreads-v1-1-e6d967a90ddb@kernel.org>
References: <20260122-minthreads-v1-1-e6d967a90ddb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18328-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95E946D25B
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

On Thu, 22 Jan 2026 13:56:42 -0500, Jeff Layton wrote:
> It was handy while I was developing the dynamic threading patches, but
> we don't have any plans to make this setting available via legacy
> rpc.nfsd. Remove the min_threads file from nfsdfs since only netlink
> interfaces were intended to get support for this.
> 
> 

The dynamic thread series is still in nfsd-testing for a few more
days, so I squashed this one into "nfsd: add controls to set the
minimum number of threads per pool" and updated the commit
message to reflect the change.

The update will appear on git.kernel.org in a few minutes.

[1/1] nfsd: remove min_threads file from nfsdfs
      (no commit info)

--
Chuck Lever


