Return-Path: <linux-nfs+bounces-3103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2332D8B8117
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 22:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523DD1C26562
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 20:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39CD199E99;
	Tue, 30 Apr 2024 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErG3bkvK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF817B514
	for <linux-nfs@vger.kernel.org>; Tue, 30 Apr 2024 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507527; cv=none; b=eEkRnK3y1rKB6E7zw7TgsxDki5u8fJM//X+y5Wis/FEI1R5O1BFMi12eKZMTd/d7qeMWBWvTNR2jr40iW0E0NBmDzhSFS/BCEA99Zel3qK24oZMe1ql802S9OdNw8HMT7ukTgIlHyhcXtN0EEAMgeOu0BUb/UAqUaXxis+JhCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507527; c=relaxed/simple;
	bh=5dw2QXOvxwfdU6Zq/Ka75EdsxoVWA6qT9j2ijF0XgYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oZB+WDS1CQ5VwdsqG/MQDq4YBE8NnOhM4o9ne3J9EjRPFkdumw1IPc4YuDG5z0QAtSN9RSoagSEmOwVo+zQ61fL4IpWDakbaRrIUO/btmZEPlbw/Yp35i+LkM4eOtgNDhKmk/7lKUBGOEkrLsft0av8t5ourekAHASR0ac0dvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErG3bkvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84F3C2BBFC;
	Tue, 30 Apr 2024 20:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714507527;
	bh=5dw2QXOvxwfdU6Zq/Ka75EdsxoVWA6qT9j2ijF0XgYE=;
	h=From:To:Cc:Subject:Date:From;
	b=ErG3bkvKsURy7aO9FCIWYNKzu7vYoSmlfd+z+HpCcsFrwqGj3TkwiXf4lwnXf1w7c
	 63msatp1E2ZW+Am+fLam+QWS+FGs4L1rEkGmROxoZupiQGaH3FTNGTWENNqbgJor9w
	 bQs1N1qK5qvAojjr5Id9MweOimq+IF9SDczJEyx2A0rplQs6fkieODKZzatJ9pfWe8
	 VofjM7c4/tm1cn7ADYkQIIwh85wltsw6rQkz/BcrdJHttojNtZxD1kfxaWNcjYRLiv
	 DePX1k5BOaOqIS95N7Esl/YRIfY8HjTsSQEIkAxMtq3y2kXQjZyjW+a9lV9oWmultM
	 C1EsypyGpxTBw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/2] NFSD: expand the implementation of OFFLOAD_STATUS
Date: Tue, 30 Apr 2024 16:05:09 -0400
Message-ID: <20240430200519.6253-1-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I'm looking at RFC 7862 to try to understand what the various
OFFLOAD_STATUS responses mean.

> 15.9.3.  DESCRIPTION
> 
>   OFFLOAD_STATUS can be used by the client to query the progress of an
>   asynchronous operation, which is identified by both CURRENT_FH and
>   the osa_stateid.  If this operation is successful, the number of
>   bytes processed is returned to the client in the osr_count field.

NFSD returns only the byte count today.

>   If the optional osr_complete field is present, the asynchronous
>   operation has completed.  In this case, the status value indicates
>   the result of the asynchronous operation.

NFSD currently never returns the status code -- NFSD's response XDR
encoder always stuffs "zero" in the array count for the osr_complete
array. IMO, zero is OK, but only for the “COPY is still running”
case.

Once the async COPY has completed, a subsequent OFFLOAD_STATUS
should show that the COPY succeeded (or failed), until the server
receives the client’s CB_OFFLOAD reply, or until the client’s lease
expires.

For the "COPY has completed successfully" case, the above text
suggests that OFFLOAD_STATUS returns NFS4_OK, and needs to return a
proper status code in the osr_complete array: Probably NFS4_OK.

A "COPY has completed but failed" status can be reported by
OFFLOAD_STATUS returning NFS4_OK and setting the osr_complete field
to the failing COPY status code.

The two patches here change NFSD in that direction.

Chuck Lever (2):
  NFSD: Record status of async copy operation in struct nfsd4_copy
  NFSD: Add COPY status code to OFFLOAD_STATUS response

 fs/nfsd/nfs4proc.c | 31 ++++++++++++++++++-------------
 fs/nfsd/nfs4xdr.c  |  7 ++++++-
 fs/nfsd/xdr4.h     |  5 ++++-
 3 files changed, 28 insertions(+), 15 deletions(-)


base-commit: 06cd86b25b980a58e5584e9cd38c080467b24c25
-- 
2.44.0


