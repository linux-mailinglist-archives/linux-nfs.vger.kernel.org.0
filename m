Return-Path: <linux-nfs+bounces-18325-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN1VKVR0cmlpkwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18325-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 20:02:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E60096CDC4
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 20:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1305C3017031
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1881B38A2A1;
	Thu, 22 Jan 2026 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSEoEKO7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954133E373;
	Thu, 22 Jan 2026 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108365; cv=none; b=fI9JdDqwvZqi8DoKo9XNuv88+jgR2D78CAsiHABTtbDfGdQ5m76XNEZcCuOZ9JRrj5+psPwqwsa3IZYDNI40rhOf4D3hxGKKR4maMzSmFsAVCihC4fU9ECBceQ516shwqqkcuF9ipdl8KG9eRPzVgkf8eiemBt6mIfT2Vf37cVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108365; c=relaxed/simple;
	bh=+1Ey24BQtioPecCQ6vA4bKTBWe3Mt+A02bbdvztYnyU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fLp2XEvI5oCIOLwGz0LdY/azvGSMiAuWMmRFfa0x6xTAuehw1dqTPEzVib7AsSW6xIKwhIFDZxMFIR152ZDBNvCn9p4Ik/w14IDVw7hmzC7yAnUnpVkMtFtU3kyj0OjVPPbOxMblIZ8MW/fo+4IKbk2uOd1nfhnsk0vLJRzEpOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSEoEKO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFADC116C6;
	Thu, 22 Jan 2026 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769108363;
	bh=+1Ey24BQtioPecCQ6vA4bKTBWe3Mt+A02bbdvztYnyU=;
	h=From:Subject:Date:To:Cc:From;
	b=qSEoEKO7xFn2tOyrGELgKiC/Vis49BdShXqtSqzaWhyfXAiZv06b3x+/UH5MRQJVV
	 NnZuFUlHwQVDXU3HSh0BKddDrjIUSF11e3Iw1z/7O+Yn7fFT3z3d1Ah6XxKJAUy4yU
	 JjKZo31VxCTsfr0WtQShoSqJO1uAtNkoee1AiRheqo9btHPFZLz+oi2HHIa4I3VK9i
	 mrBhknKM5/uaYUYxyp/pRbQM9+LpljSJUTCzSsnRSEUiPB1Iyzlm3HuafowjZcazrJ
	 mZFOdnzA+91XVke606Ok2wmTwZuO+SlUe4wUKKtDTE+5h5tH+Pv0zZjMY9Jlv5phF+
	 he+FXmkJjXIeQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] nfsd: move delegated timestamps to being runtime
 disabled instead of compile time
Date: Thu, 22 Jan 2026 13:59:14 -0500
Message-Id: <20260122-delegts-v1-0-40fbb180556c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyMj3ZTUnNT0kmJdQ1MDAzODxGTzZMtEJaDqgqLUtMwKsEnRsbW1ABT
 S0dtZAAAA
X-Change-ID: 20260122-delegts-150060ac7c9a
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=806; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+1Ey24BQtioPecCQ6vA4bKTBWe3Mt+A02bbdvztYnyU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpcnOJXS76ExyO8Hp976EW1wH5GR0yq0r08+P/p
 5F4KdJN7bOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaXJziQAKCRAADmhBGVaC
 FSpUEACmnlyLTGtxa5L63QLnZKb8f7kqyWVQ+TSpQhehBQJWdNxlGq5+0aYPl/KzIuvoQCGxa04
 cwgWD5tY+eEBqkf5dEbpQUxOlRXNJ/udW2Xm/Lx1Xk7VASbMHV/Val/3GspLXB+cuwlj2e8AbWp
 rT8jfxgK77/o04EmLreQBZtMHSKOgvqs7bs0DMrnG0LVUkUkat3I9r7s1kGvr823+w+vkfbMd1S
 2TcFSwFCFpQN5o7OH4i7HiAzSMoBEoGqtMfIZyX98Mv/1NpkTkoxD63Ud74UKpUVaLRtQJNUuDJ
 NNvauzDN32LHmqChPxKdvSRPeyfBFAVIOjHw8Y2GLhDlHngZIlCj58OEVdtONLnzDhR9TYDrQWk
 hYjaMS1MkMdU+t0CTpVA26C57sfWn08bXkuDIM8RN/9bmeFV6Y35dEwjlMRHu47fYPASIWyP3xW
 b6MpWce3v8jx5qx/l3xfcXUE0v5z6CfUcB5cLhUkkkO0W1vO7g+RylPJ4EP3IlhF5JrXMCe8Cs1
 IUjP3xhK/GWW/w9gK9X9X+34l5huMhDz/TxS4z+s4lkpTkmIBvzpek5S9O34AI8JWrCQrNJr/KE
 2V9UPw+UQOCJEX0ueDRxR+zIHTvg47XUBYZihfdmEKbTb8fBUHTQvlwFzKmhIq8oOx+UDp5F8vP
 0itvBv4iFcDNuHw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18325-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E60096CDC4
X-Rspamd-Action: no action

The delegated timestamp code seems to be working well enough that want
to just always enable it. There is a chance though that some clients or
workloads could still see problems, so this also adds a debugfs switch
to allow disabling them at runtime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      nfsd: add a runtime switch for disabling delegated timestamps
      nfsd: remove NFSD_V4_DELEG_TIMESTAMPS Kconfig option

 fs/nfsd/Kconfig     | 10 ----------
 fs/nfsd/debugfs.c   |  3 +++
 fs/nfsd/nfs4state.c | 11 ++++-------
 fs/nfsd/nfsd.h      |  1 +
 4 files changed, 8 insertions(+), 17 deletions(-)
---
base-commit: 2a1dde6dd823e94e0768e929566dd65cd74ca793
change-id: 20260122-delegts-150060ac7c9a

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


