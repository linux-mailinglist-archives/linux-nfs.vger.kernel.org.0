Return-Path: <linux-nfs+bounces-13553-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9253CB20C48
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 16:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E233A9CB5
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 14:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1F42561A2;
	Mon, 11 Aug 2025 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLjtngQq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3A253920;
	Mon, 11 Aug 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923037; cv=none; b=fV+yTQ+9EhMv3XFowyoP6xVlEtYpF41ryNnt1Trl1Jmux48WK0cx7COyBy1UoVoqPnr0Omc31hGNSamkwcyzUm9P02HAaFR42PlHq5MZ0PxwcbFjto07u+hdw8SO4CBnIWDL/XnyhNW1y7Vg5QszeWJGUcLYRSNsQycf5Uz+Vqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923037; c=relaxed/simple;
	bh=0jqNQiltMl9SsNhCyAHVVgEBiwxnDq9kbpyYH1hhvH0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q6GX10TuKSZA9urRiBP/LlSc4gAXLZd6VMQ5dqIqHHPYnEvDFNP0UHebitqnp/XkYZXsnL6pbKT/ACtUltK3sApkg17Tguo8siI/ar6RCJCQBQ0EI/TCjgkk4TX3gjeA5aj/chi5psbVcHhvDmncW9CyGhd6u7RTKqo0WWUiu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLjtngQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F512C4CEED;
	Mon, 11 Aug 2025 14:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754923036;
	bh=0jqNQiltMl9SsNhCyAHVVgEBiwxnDq9kbpyYH1hhvH0=;
	h=From:Subject:Date:To:Cc:From;
	b=tLjtngQquWmcwUodrjNrXZ3imprtiDBdWFrydeXpsPim8+Eghk3FOzi6ZLhg7zMqy
	 CgwxO6epuqv7v6G9HXV1t4ej411iaMYkPaObLY4Dnw/d/zd1vTN9d9q3/2k0M3f6lP
	 Wx6xLs0AzGThe9LYpvSsh8g4R3KNayjQV15DDXpn6Mc9s6JITpyMW8c4veUcKTgBZy
	 doaEfjBx2IqAiGNkOjrx93eVbcLHTMGsF6cCyGHRG8ZxrXZGeE/GQ2UP8V6JSwNvAX
	 jiy675mncw2tCHyOImdtqGh6jQ3/Bu9m9bGEmj7lBT+H3yRHeKWh+2qJ/YJktO8TzQ
	 Pb5iWot5vfxrw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] sunrpc: cleanup patches for svc_tcp_sendto() and
 svc_tcp_sendmsg()
Date: Mon, 11 Aug 2025 10:37:06 -0400
Message-Id: <20250811-nfsd-testing-v1-0-f9a21bbf238b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABIAmmgC/x3MTQqAIBBA4avIrBP8IYquEi2GHG02Fo5EEN49a
 fkt3ntBqDAJLOqFQjcLn7nDDgr2A3MizaEbnHGjma3VOUrQlaRyTtp4xBi89Tg56MlVKPLz79a
 ttQ/ye9O5XgAAAA==
X-Change-ID: 20250811-nfsd-testing-03aafd313a72
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=622; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0jqNQiltMl9SsNhCyAHVVgEBiwxnDq9kbpyYH1hhvH0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBomgAWnVTVgMc7hLR5gNXA3JtSHW0dBZWYRs+Bi
 yIykd89fxKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaJoAFgAKCRAADmhBGVaC
 FVSjD/sGOwJgw+yLP6Q6fF2+T1T9nl4FZfAMQejFm/RmQudxx3bUT1mlnrtrmLNYfirKPE7JuPe
 XWH/cVITiB/BtbE/Vf5XhL7xZJaUZZEotZhPVvtMsCUbyYwrZBRrFXhj3cIuMJunl+6povMq+eh
 hN9A6LgKrGcI+1ZKXkZSpif64hC/JefwgGsnZbQMoCYNPq4UwlsGGkGoWqZumiqMcRA6wUJB83V
 RI0PGTp02W8ZQIdIyzvYj8VRl3bscP8Oh11xbwPayZNqWkpp3AUquip5Pgj0kqbu6wiFHZxA3JW
 lsOwJoYy0ez3ZH3UgkrWMpK/648soLjH3UBqgJud97bkrieLlbW7F1LXhjHva0/uh5xCMJ+B6Le
 AxgMPQ12COWx1pe9un3TfmlcpIIIHy/QzPlJiveKimxiyrFV90lvrYxMpKSLRISwwXh5VuUWqwJ
 /KSQexCFOnMrLSjtSsivB6htdbSjxgivcQ9dKn9YBOnpwH6wK/lSgCNHypd1xqZIpfa0XbAFMM8
 oYyyakyujJxOoJhZXcK85JMop1otY6ZMSMEVVbk837t9CvjzIdz9FNIEyyjW3BY+ArjGGi/fmRL
 zvkVqsQj3rhcK0adLs12W24+vhoZEwmRulgIGYWFW/gKqnqCqjtkDFr8xW4jTSvmgKKxzfNgnMr
 t04eILIBfwUFS4w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

These patches fix a minor annoyance in a pr_notice() and clean up
svc_tcp_sendmsg() to not require a return pointer. Please consider for
v6.18.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      sunrpc: fix pr_notice in svc_tcp_sendto() to show correct length
      sunrpc: eliminate return pointer in svc_tcp_sendmsg()

 net/sunrpc/svcsock.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-nfsd-testing-03aafd313a72

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


