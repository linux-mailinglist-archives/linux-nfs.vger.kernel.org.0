Return-Path: <linux-nfs+bounces-11335-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F32A9FA82
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 22:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3A33AF726
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 20:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A13C1DF269;
	Mon, 28 Apr 2025 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngtJUsvl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204F1DA617;
	Mon, 28 Apr 2025 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871882; cv=none; b=gsqMCVrVl+M8KYB9wYWogobN+hSA6pFm9y9ku4PwqcYbtwNSL4eJ0Q5IbhCoYOIYvtoJhdhE3w9+UYLpbeUuY4JDUMumnKZjqP09XRPwtyiJ3oMKrHQGBEEQ694yFuqgl65uHAfEDTp4nC+FUuCYZkBI54dd3cxBDojJS6fR+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871882; c=relaxed/simple;
	bh=EwvpbPG6QlZRxW3isNMsSz+cgScu08I8seIYeLihg5U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eNx9HLIbi/OSTMXdk43QCESUahszvdfXZZElViiGJtfC38f+QXiCrzi3H4bYq4q760Q91LhB45MatUVeu7g/aNPVSEte+SCrziaWeC+kWV09xLQ1+WAyJLaAj6bITcwiP1Bsjl9o2n1svOEztHjjd3lm8l5EjM5i/QElcLiW5RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngtJUsvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C022C4CEE4;
	Mon, 28 Apr 2025 20:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745871881;
	bh=EwvpbPG6QlZRxW3isNMsSz+cgScu08I8seIYeLihg5U=;
	h=From:Subject:Date:To:Cc:From;
	b=ngtJUsvlZbOShO9w6mKW5QQm/a2gPN7etfn/VkwU+7pEvyVJ/QabYNXcCXk/S4FyH
	 RfqKrAyG6wlkfErxPcv+REBoV9obNTSpV6gELC+pHTGTarosbxVmyCZKlsftAScY8g
	 l6LcO/EUVj3F0mQ1sY0PZNgzmGrTRg9Fyb2kMWsp/B1/G/7s6TWctohdJ9cxOrIuBy
	 NqsIaN/PemnI+fF7d5Snb50pESWnoldhpPsl7+vBVXkEXSX4pSnL4xcwz5/CfevAcM
	 iS9mpbXqg4VWsG9PCvaBFM8m2G2N93f3Y3ueSYVoDh6ij1ShkrMpFJMT424v+3g7bT
	 +ogxqQlM6R4wA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH RFC 0/2] nfs: free leftover lsegs before freeing a layout
 in pnfs_put_layout_hdr
Date: Mon, 28 Apr 2025 13:24:37 -0700
Message-Id: <20250428-nfs-6-16-v1-0-2d45b80facef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAXkD2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyML3by0Yl0zXUMzXQtzAzOjxEQjSwvLFCWg8oKi1LTMCrBR0UpBbs5
 KsbW1AGqGn6dfAAAA
X-Change-ID: 20250428-nfs-6-16-87062aa2989d
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, Chris Mason <clm@fb.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EwvpbPG6QlZRxW3isNMsSz+cgScu08I8seIYeLihg5U=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoD+QIwSBqP+I8u6EzvPzPLdJ0IlnwhETTMdZ3c
 lVpdp6GrfKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaA/kCAAKCRAADmhBGVaC
 FaSoEACQVVqlo3aMey9Xj4jMlt8flCe5b7xMWgk6HRdiGr/tRwhZaBMoIXUOVNC5Ok/44CA5Vzj
 /FBExISLin1BAUrkyGOWOMVNlufHXU3SxWci0D8dTumh6UrUoMh2+HmdSSu4nR8rPRuYIENFvQw
 B8dX7e5V2JltDDTADkMgvRsc9Mil5lKqddaUwOZ3efFZ/36byfOgex5sPWOibq4WSFMknKAuT+e
 v+WhW8CC8pXjlKvRzERiA00IV12bCUngH3DwCS28hGdvspF7fOYZxYBHleEvgpJ9X/kapZbvgAb
 qYoBgzgHlXKre/FmyRxv0epVqgI4V26hHnvFbWU9fPt/7eDX6CG3z4GG14qho7mxoXBKOj6U68z
 fdmtaEP2JzYj4muf19mvvc+RQ9vQS147zNmVywYXGLT/IbIPZZuqthOhFUXABh6ISGlrqOXsw44
 m9yQKXaXnANVFLLM9LrN/4xAniEjo0hWOB5rwxHs8Ubp5rbNmeCu58CgVuLn9nHydbutVglr7YZ
 5Mp4rs9bnZ8fh1E7RofSuOtL+fKBTHeWLoRUBvthGWsHtbh2wK7s8UoUTwpC09fcqi0YrJJle7w
 Cmp/hcRZQpGiPG/tceBYEaZ118CZwR1sqQ5rVdZT1vVsT8sOfPQb3g4zANZAP1VfT4GnTLXfI9Y
 SRxBXAwmEbXJBMA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Sending this as an RFC as I don't have a reliable reproducer for the
problem that Omar reported. I'm also not sure this is the best fix for
the problem. There is probably a case to be made that the real bug is in
the error handling for pnfs_layoutreturn_before_put_layout_hdr().

My guess is that the issue is that we end up with entries on the
plh_return_segs list just before the network goes down. That causes the
LAYOUTRETURN to fail with something that looks retryable, and the lsegs
on the list aren't freed.

It's possible that we just need to catch ENETUNREACH in the LAYOUTRETURN
error handling, but I'm not sure I correctly understand the problem. If
entries are racing onto the list just before the refcount decrement,
then that wouldn't fix it.

The first patch should fix the issue of the leaked lsegs, and the second
should let us know if it ever crops up again.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      nfs: free leftover lsegs before freeing a layout in pnfs_put_layout_hdr
      nfs: pr_warn if plh_segs or plh_return_segs are non-empty when freeing

 fs/nfs/pnfs.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)
---
base-commit: 5bc1018675ec28a8a60d83b378d8c3991faa5a27
change-id: 20250428-nfs-6-16-87062aa2989d

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


