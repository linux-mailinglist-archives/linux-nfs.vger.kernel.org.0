Return-Path: <linux-nfs+bounces-4528-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A450924236
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 17:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CD31F22811
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001B91BC067;
	Tue,  2 Jul 2024 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3MflTWF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D032926AE4
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933605; cv=none; b=M/4natTPbla7SWegZk13dr37bfWgO6MjXgh7uewNgd0iUJstg0bywScufcd+p1lCAgBOJo8WuZ+sMMvdJ4EHp3Blq8uNtehbtrO/g9IF+9iRiSUJmpffH5JYEESY6TV2KKXtstbdisiOFvRsuY1l47fUKlmHja64BZ55H9B7Q20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933605; c=relaxed/simple;
	bh=Ec7gj9ba8Pm89FiUs0t0GZBPnySrQS48jfaV+p3VT5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhyQMhDtDdqL91Y4B7f9uE7MmXtvg5Hae9L0UviYRsDDoC7b/edZaeumpYdKYykImuTkXIxEJMeh3mX8JRD9lNhEW76xx0naS/05hklGfdszygzwyxcTDzLvbeutJ3yNXtSWJ3yqlLX0m0fWUP7uQLcGbTca6X/ueMBebfTKuyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3MflTWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2583C2BD10;
	Tue,  2 Jul 2024 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719933605;
	bh=Ec7gj9ba8Pm89FiUs0t0GZBPnySrQS48jfaV+p3VT5c=;
	h=From:To:Cc:Subject:Date:From;
	b=u3MflTWFaArFDFIX+2XryObPwpdczmpOj9oU/WKVUWVqERgcFQEppjt8+kFOiaAVk
	 Q6EUEQ3oOZlWLo5ftA7XhwEKstM4MQ8izsE6zz2dif3M8GqUMqYI4GbBfH/vmt+AZ4
	 AayI3Tn1AR1B2HuxqDkAgkdebXgJy4+z6TgDM/mjGlAnldyVq7/x3WHNvTdttJHQUO
	 WogeoejZNnSNCW1UU3QxSEk1j10X/akTJ7RSGEF5U/8plwBRQirfWysy3wbbMSLDTy
	 eUxmAm40hMsQsDHhXvy3G7pr9Y3cSGu9Oc0Ipg84PDlnzsXbT3QzLjIEz8YiQdsPfw
	 6ST6tq0KtXfXQ==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/6] Add a client-side OFFLOAD_STATUS implementation
Date: Tue,  2 Jul 2024 11:19:48 -0400
Message-ID: <20240702151947.549814-8-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=935; i=chuck.lever@oracle.com; h=from:subject; bh=dItuZGPSbGadn75Atez4I41R+2T2s73ouc015U9wH8U=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmhBqTeC4xGOqJTaG2KlZluVCY3rYUIEDXcTGXG zedfLOLgVaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZoQakwAKCRAzarMzb2Z/ l8TWD/99VdxSfy+Z3fadqL8esZ0DH7AHV/MUbPxgNtIQ32m3isVGEEWA5eig1WVAKGPzYQjJy5A vpsbUKHH0AIrLbaHmEb+GsgQNu2X3a9m7OU8BQrNg0DtLfKxwmUhskO58Y5+oIQABj/RKLY7PNW dDxTgRgsdy4bTaDbZKE3oKimsnAmn+sQuBRGeWJ6ft9/EyG4ioehP1wuaI3LllOqSGvIK5nCJ1p vJypoCc3K/u9SinmRSM/ABGjVX45PLZk5ETwei7TFAMxpGm0XMkOHzJ/Zj550Z8LVs6mPCzKJVz VOryDQnMnt2fMDBJefmpDhlE+z32P6kTrmPHyrFtr8jB7OzmowUOEtTzZmQMVIgQPVGi8iQYgz4 aAZYcG3iZ4vMuZOzYJMEY1T8hHBYqHysgWDpQ2NXmQ6E4LviNTfh9sMW9aCX/NPqI0SP47VwtRa YpT5yObDak6qidnJZKlEe7FvGuIb4Jm0xVrPuh6cBCXBuOCHdoHTHopgu4p0AzMsFTDYJhBBDAM jqzqXdnCiFplWBR8rsj/AZVp4UcoR9xKaWczDuZqwZqeCTcOdUzs4NKvEe4zxZghEcT2S8Ym/mV L45N/U/8PeJ1LTCmUfqIxHMvIyU4MCnzmCIYZbH3A6o5Gm1rzvyUfDuxuHcsZUdtcH5hyyJNMAU oVa917Aw4NBCeuw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

*** COMPILE-TESTED ONLY ***

Not sure I've addressed all of Olga's concerns. This is more like a
progress report. I've more-or-less worked out how to sort through
the results of the operation and return a "bytes copied so far"
count to the caller.

Chuck Lever (6):
  NFS: Fix typo in OFFLOAD_CANCEL comment
  NFS: Implement NFSv4.2's OFFLOAD_STATUS XDR
  NFS: Rename struct nfs4_offloadcancel_data
  NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
  NFS: Use  NFSv4.2's OFFLOAD_STATUS operation
  NFS: Refactor trace_nfs4_offload_cancel

 fs/nfs/nfs42proc.c        | 173 ++++++++++++++++++++++++++++++++++----
 fs/nfs/nfs42xdr.c         |  88 ++++++++++++++++++-
 fs/nfs/nfs4trace.h        |  11 ++-
 fs/nfs/nfs4xdr.c          |   1 +
 include/linux/nfs4.h      |   1 +
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |   5 +-
 7 files changed, 260 insertions(+), 20 deletions(-)

-- 
2.45.2


