Return-Path: <linux-nfs+bounces-12878-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD212AF81A1
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 21:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B89A3ACB3C
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 19:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9662FEE0A;
	Thu,  3 Jul 2025 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B69faiPn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B22FEE03;
	Thu,  3 Jul 2025 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572408; cv=none; b=C3Q/wCvdLgeMWCg/y7cv+bqS2tOJ4/KEBicLcK6GCc2KR9IbA5GtvQ33T17XdVi34gFKe3Ukz39jZchahaohVuyiwkU5xxLueu/lgu8Xe5O9MpZZWuy6xaxQ8OaN/NDrZeC+xyhOKobAEfHu5OaqCHsbFERnPJuMv1UFcFeQo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572408; c=relaxed/simple;
	bh=mEROvQjZLLfatk0AEuzzJsIE04UWUpqW5mTXRL9Gjp8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YMMkhhK1AhesIDRDOwfdZvOzlWM7sn00Z2Bkg/QWAqX8VZAn9P/pF8PhlvSszDMrFjNMCAmGMD9U2Zjp8dqKN3yNC0vgQsUBCaRmFPZSiqP9YG4ER1KuCMNEEhnylI02nLDJi7xk6jN0KfuvUDqcnRB5rDE7gS62uPjRfHw8I3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B69faiPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBE1C4CEE3;
	Thu,  3 Jul 2025 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751572407;
	bh=mEROvQjZLLfatk0AEuzzJsIE04UWUpqW5mTXRL9Gjp8=;
	h=From:Subject:Date:To:Cc:From;
	b=B69faiPnEG8hLVUk5D+bXlXOpRYkg9a2VO/4CadIQTkqmq577/fMy2QKgIr8b9Qit
	 8et/v/SVkx/Oz7elCWuingXgEaJbX3bq9k1an3u3kh5o64EHUVh2HDS3FJc1MySJXv
	 0lVVCaCV719AstSjssCgfhaksUWBo3fI0WkHRhV3BohdGhVwf3JSUoBM9km+B1vu1S
	 sBkqCs3lSqXK2HorpMzVMKg5B8uEWLG2Gk4fjFrYS+DoBNDv1Nlp6m96PnmedUiayC
	 JsnuE1Y3sDr6gAfrLX7zVOYxpRe+DXe3d3zUP5r6O7rjNUsEH8/0dGCvYj/sCJ/PSf
	 8n4/X6G7vRPvg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH RFC 0/2] nfsd: issue POSIX_FADV_DONTNEED after
 READ/WRITE/COMMIT
Date: Thu, 03 Jul 2025 15:53:11 -0400
Message-Id: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKffZmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwND3by04hTdktTiksy8dF1Do1TzZIuURNM0w2QloJaCotS0zAqwcdF
 KQW7OSrG1tQB+JYtHYwAAAA==
X-Change-ID: 20250701-nfsd-testing-12e7c8da5f1c
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4663; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mEROvQjZLLfatk0AEuzzJsIE04UWUpqW5mTXRL9Gjp8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoZt+uRqDX54kwM/uVSX0hJvmzm9NY12SImXhVu
 OPM7TaJti6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaGbfrgAKCRAADmhBGVaC
 FTsKEADLcyHXLUDOiSCdiP4Zy84ys3E8t1vIpALWoPAMggoEpVuqJzs6ZLaGyghYwBkLPmRwx+k
 2Ek6LbUU+pxO7DaN2C1/b9qw7ont4VCH3VynJ/NxB8LBCRnthR4PB3hhrxlQmKGeBBFXX1jNUrM
 j801kTNwlwah4NLPTPJjF8TE9L5AwsxxLIABW2hVauG1ArzzaJFKheYawIla16SqpCpJanff0ag
 I3D6xd1AHaQjQGvQzDHGTfAjEfjvevY6b7Zj0nhumoRrmIMZ/KIpjmT8GA/z6cfETvf1KlwpdgC
 CosmaO5viCXf20zWKX3LEI6TDYWkARdg/Z6C/+hxUg0meHpfK2j66P/EfwU5WHt5c/Tiaw91tZ1
 PrQXe84K51rMQwf1GlVCslh66FkXlopoaZJvQhqxUNWSnfkCy9hPwfc1qqXKmiwB/jJSK/atJAt
 pvUvlsxcvsiNV/qvhKhjh38BGBA6Sz4LaEfwz3+rQzDGRNwo7qOh4y1agOfpI1LAUerrR5wNBEB
 vdoDUKSzePcB8HOP5XfOrE/11iOjGF8xTgiU8vQd89KVgwj1nd5cCKXmqXN17+tdk7nPxCj16Bb
 U0JrInkmP4RZzW6hc7N3l3QJ3Tf3IMHiSV63Wk7i5hZpd5Yg3KjZWOZ3AtbUenqPBFJXHVLBbAf
 FLwL9DZvAAj17QA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Chuck and I were discussing RWF_DONTCACHE and he suggested that this
might be an alternate approach. My main gripe with DONTCACHE was that it
kicks off writeback after every WRITE operation. With NFS, we generally
get a COMMIT operation at some point. Allowing us to batch up writes
until that point has traditionally been considered better for
performance.

Instead of RWF_DONTCACHE, this patch has nfsd issue generic_fadvise(...,
POSIX_FADV_DONTNEED) on the appropriate range after any READ, stable
WRITE or COMMIT operation. This means that it doesn't change how and
when dirty data gets flushed to the disk, but still keeps resident
pagecache to a minimum.

For reference, here are some numbers from a fio run doing sequential
reads and writes, with the server in "normal" buffered I/O mode, with
Mike's RWF_DONTCACHE patch enabled, and with fadvise(...DONTNEED).

Jobfile:

[global]
name=fio-seq-RW
filename=fio-seq-RW
rw=rw
rwmixread=60
rwmixwrite=40
bs=1M
direct=0
numjobs=16
time_based
runtime=300

[file1]
size=100G
ioengine=io_uring
iodepth=16

::::::::::::::::::::::::::::::::::::

3 runs each.

Baseline (nothing enabled):
Run status group 0 (all jobs):
   READ: bw=2999MiB/s (3144MB/s), 185MiB/s-189MiB/s (194MB/s-198MB/s), io=879GiB (944GB), run=300014-300087msec
  WRITE: bw=1998MiB/s (2095MB/s), 124MiB/s-126MiB/s (130MB/s-132MB/s), io=585GiB (629GB), run=300014-300087msec

   READ: bw=2866MiB/s (3005MB/s), 177MiB/s-181MiB/s (185MB/s-190MB/s), io=844GiB (906GB), run=301294-301463msec
  WRITE: bw=1909MiB/s (2002MB/s), 117MiB/s-121MiB/s (123MB/s-127MB/s), io=562GiB (604GB), run=301294-301463msec

   READ: bw=2885MiB/s (3026MB/s), 177MiB/s-183MiB/s (186MB/s-192MB/s), io=846GiB (908GB), run=300017-300117msec
  WRITE: bw=1923MiB/s (2016MB/s), 118MiB/s-122MiB/s (124MB/s-128MB/s), io=563GiB (605GB), run=300017-300117msec

RWF_DONTCACHE:
Run status group 0 (all jobs):
   READ: bw=3088MiB/s (3238MB/s), 189MiB/s-195MiB/s (198MB/s-205MB/s), io=906GiB (972GB), run=300015-300276msec
  WRITE: bw=2058MiB/s (2158MB/s), 126MiB/s-129MiB/s (132MB/s-136MB/s), io=604GiB (648GB), run=300015-300276msec

   READ: bw=3116MiB/s (3267MB/s), 191MiB/s-197MiB/s (201MB/s-206MB/s), io=913GiB (980GB), run=300022-300074msec
  WRITE: bw=2077MiB/s (2178MB/s), 128MiB/s-131MiB/s (134MB/s-137MB/s), io=609GiB (654GB), run=300022-300074msec

   READ: bw=3011MiB/s (3158MB/s), 185MiB/s-191MiB/s (194MB/s-200MB/s), io=886GiB (951GB), run=301049-301133msec
  WRITE: bw=2007MiB/s (2104MB/s), 123MiB/s-127MiB/s (129MB/s-133MB/s), io=590GiB (634GB), run=301049-301133msec

fadvise(..., POSIX_FADV_DONTNEED):
   READ: bw=2918MiB/s (3060MB/s), 180MiB/s-184MiB/s (188MB/s-193MB/s), io=855GiB (918GB), run=300014-300111msec
  WRITE: bw=1944MiB/s (2038MB/s), 120MiB/s-123MiB/s (125MB/s-129MB/s), io=570GiB (612GB), run=300014-300111msec

   READ: bw=2951MiB/s (3095MB/s), 182MiB/s-188MiB/s (191MB/s-197MB/s), io=867GiB (931GB), run=300529-300695msec
  WRITE: bw=1966MiB/s (2061MB/s), 121MiB/s-124MiB/s (127MB/s-130MB/s), io=577GiB (620GB), run=300529-300695msec

   READ: bw=2971MiB/s (3115MB/s), 181MiB/s-188MiB/s (190MB/s-197MB/s), io=871GiB (935GB), run=300015-300077msec
  WRITE: bw=1979MiB/s (2076MB/s), 122MiB/s-125MiB/s (128MB/s-131MB/s), io=580GiB (623GB), run=300015-300077msec

::::::::::::::::::::::::::::::

The numbers are pretty close, but it looks like RWF_DONTCACHE edges out
the other modes. Also, with the RWF_DONTCACHE and fadvise() modes the
pagecache utilization stays very low on the server (which is of course,
the point).

I think next I'll test a hybrid mode. Use RWF_DONTCACHE for READ and
stable WRITE operations, and do the fadvise() only after COMMITs.

Plumbing this in for v4 will be "interesting" if we decide this approach
is sound, but it shouldn't be too bad if we only do it after a COMMIT.

Thoughts?

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      sunrpc: delay pc_release callback until after sending a reply
      nfsd: call generic_fadvise after v3 READ, stable WRITE or COMMIT

 fs/nfsd/debugfs.c  |  2 ++
 fs/nfsd/nfs3proc.c | 59 +++++++++++++++++++++++++++++++++++++++++++++---------
 fs/nfsd/nfsd.h     |  1 +
 fs/nfsd/nfsproc.c  |  4 ++--
 fs/nfsd/vfs.c      | 21 ++++++++++++++-----
 fs/nfsd/vfs.h      |  5 +++--
 fs/nfsd/xdr3.h     |  3 +++
 net/sunrpc/svc.c   | 19 ++++++++++++++----
 8 files changed, 92 insertions(+), 22 deletions(-)
---
base-commit: 38ddcbef7f4e9c5aa075c8ccf9f6d5293e027951
change-id: 20250701-nfsd-testing-12e7c8da5f1c

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


