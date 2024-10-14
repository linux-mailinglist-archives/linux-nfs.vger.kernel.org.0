Return-Path: <linux-nfs+bounces-7161-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB1399D75A
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 21:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A828B1C214F6
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 19:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA591CB330;
	Mon, 14 Oct 2024 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCwNd6IK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346A7F7FC;
	Mon, 14 Oct 2024 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934030; cv=none; b=ZPMvwoRXJHjTLp98O7jF9cKhpz12MCEvpNkuz2KVVkU1V2mV5rislY+TYoxygyxX9HbHKN5QFuuU/oWiVa1D3wz8/fmcPEx6Br2R2f8QCZutBoeZ8W/oA9WNYP1jxkMxFO2f+b/swzq/neZzbGkqW+K41KWjU5i1JhA4+Gmd/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934030; c=relaxed/simple;
	bh=F6vEvPmuUdtzsK0vCJAXI7DtzpOr0J56DU/nlL3w+1c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b2qf1L/f08ow4+oWuL6lVChXueMIaSLuEUmc+yc4rFC+Nwn3Of4vSJdK6+FkFnhqtF8gAIiZYqC57uN2kLv/nMnz12/8XYKkbOUpZtOaBqaoV9ieSxlmFtdt3DQCVL3FegT+OzTtJ//zVgJDmIOtj7JI7QK3ZTZnUBIEge+82Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCwNd6IK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FABCC4CEC3;
	Mon, 14 Oct 2024 19:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728934029;
	bh=F6vEvPmuUdtzsK0vCJAXI7DtzpOr0J56DU/nlL3w+1c=;
	h=From:Subject:Date:To:Cc:From;
	b=vCwNd6IKrX3beID6+DUJOEPbN70gTY94qULkF38vHTSbGI73VhAvNkNu3jD6lDoUO
	 kM6iCy5YNd20/q8PzR9NG7R7duT2ym+cmu7xqh5+mh8Cs5hAazosHi5bt5ONNSlKCb
	 lT4FUmdgqepPnzjmJB6vunkmpyHW0g3ble3vT7DCmlpCuSd9LT50KEX6z8M1m5D6kr
	 DIFjXwK4yBXNzWcs5xxqjNx3t65+L09lzAAd2AMPLp4xl9lMgsofFQgBIWy6JklJsn
	 /+nL9MSQ+qeKwKI39YMamiEFb1LLQ66GbRwUit/mif7BL0Wpf8qSxZHhAsqHx3gzoo
	 kl5nwSOE2Y++g==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/6] nfsd: update the delstid patches for latest draft
 changes
Date: Mon, 14 Oct 2024 15:26:48 -0400
Message-Id: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHlwDWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MT3ZTUnOKSzBTdpDQDUyMjg8QUSxNDJaDqgqLUtMwKsEnRsbW1AAc
 6tx9ZAAAA
X-Change-ID: 20241014-delstid-bf05220ad941
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Thomas Haynes <loghyr@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2115; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=F6vEvPmuUdtzsK0vCJAXI7DtzpOr0J56DU/nlL3w+1c=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnDXCECmSggnwshJHB1PlHjFbrF/jhRbiBMvOER
 kEd4/HX9D+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZw1whAAKCRAADmhBGVaC
 FaxYEACWuq4gR9UPFxChyhw/pKyDLBEtdIotg7syeB7Mj0n/a4/mX1MY/UIPv/qiTccxhNaRNqQ
 SnQo7zOKWZW6cIwuJVWYwY2vmuzi7vyUG2B0S3KAuj2L2AbCFLrxhASyqmQXHH70zuxE5Z80RmC
 LiTGzmDN/TUx8wPlEmDsBbpdHwcId3hvGCRv23nM7UYstFjH9TDf6gHWZhVBOwcCujcr8QlmkAl
 YaMxPxJgL2ekzRB1QCWQABDV4jrce9OJj06zN5YiU3Mc16OrnqAgyib1BotrQUuPEI2dhqp+nYa
 cvjxveuCxhrs5CqsaOrGAV7TQdK4Dm1RHmSh7agnPkwE5lL7FPmmy0RByRZUpKgAeGBs8DSO31J
 p31mc8E55ATK3HnLltBRBVPuB2n3iS6bjz9zMJEXR/Ze+Ti3KJjPZqp01zfobiDLec6lj6HrxtP
 YmygEOTtNxObDpJ1jqJuokt9DrC9OC9HJIwxs9RVNYR6WEaaz6d0L+rZyynAUfGqbeawOsOZCfo
 Qo6uM5VWf4h02uIsLKh+ptebQ1B7z2VEsrI6uBwPSjqY4y5K3MaN0iIXflaLh5pN99mDAhYdMqA
 e4/b5vR7u/Kkhype2CLbzPIyIbQcLNZZkk50bT4r4LQWRKHfVODhwntzgmGYRDHbmBoQXxGW30P
 6oyF2JYFqmvIs5g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patchset is an update to the delstid patches that went into Chuck's
nfsd-next branch recently. The original versions of the spec left out
OPEN_DELEGATE_READ_ATTRS_DELEG and OPEN_DELEGATE_WRITE_ATTRS_DELEG. This
set adds proper support for them.

My suggestion is to drop these two patches from nfsd-next:

    544c67cc0f26 nfsd: handle delegated timestamps in SETATTR
    eee2c04ca5c1 nfsd: add support for delegated timestamps

...and then apply this set on top of the remaining pile. The resulting
set is a bit larger than the original, as I took the liberty of adding
some more symbols to the autogenerated part of the spec.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (6):
      nfsd: drop inode parameter from nfsd4_change_attribute()
      nfsd: switch to autogenerated definitions for open_delegation_type4
      nfsd: rename NFS4_SHARE_WANT_* constants to OPEN4_SHARE_ACCESS_WANT_*
      nfsd: prepare delegation code for handing out *_ATTRS_DELEG delegations
      nfsd: add support for delegated timestamps
      nfsd: handle delegated timestamps in SETATTR

 Documentation/sunrpc/xdr/nfs4_1.x    |  22 ++++-
 fs/nfsd/nfs4callback.c               |  42 ++++++++-
 fs/nfsd/nfs4proc.c                   |  26 ++++-
 fs/nfsd/nfs4state.c                  | 178 ++++++++++++++++++++++++++---------
 fs/nfsd/nfs4xdr.c                    |  57 ++++++++---
 fs/nfsd/nfs4xdr_gen.c                |  19 +++-
 fs/nfsd/nfs4xdr_gen.h                |   2 +-
 fs/nfsd/nfsd.h                       |   2 +
 fs/nfsd/nfsfh.c                      |  11 +--
 fs/nfsd/nfsfh.h                      |   3 +-
 fs/nfsd/state.h                      |  18 ++++
 fs/nfsd/xdr4cb.h                     |  10 +-
 include/linux/nfs4.h                 |   2 +-
 include/linux/sunrpc/xdrgen/nfs4_1.h |  35 ++++++-
 include/linux/time64.h               |   5 +
 15 files changed, 348 insertions(+), 84 deletions(-)
---
base-commit: 9f8009c5be9367d01cd1627d6a379b4c642d8a28
change-id: 20241014-delstid-bf05220ad941

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


