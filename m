Return-Path: <linux-nfs+bounces-8625-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E42879F4EB0
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 16:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8EF18955ED
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 14:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3511F7585;
	Tue, 17 Dec 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0bIniH/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E91F3D55;
	Tue, 17 Dec 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447356; cv=none; b=k0V2A0B9/bExXQF09pLMLPtyBOheq57Kw0zYl115fEp3iv2q3zWb/mR1ttnIdpXglhS5xUweDc+3Me2NrU2R6DOe3JtfIriyF8n/ON1zFOSkX9VT0jTjaZ8LEsLc7mlpJeASCd1ock0H1Q2FkXmyZ6bmrPRiOkVpuxxgqG0Md9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447356; c=relaxed/simple;
	bh=kn0QEklhu4DlNWlEmwaB2mgPMFaePNYpED7/K5qStjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a76NCY0psSP1asn9uYTvKF2Eqghd6AUJQcU7/7KAk1kO6CtLB/c4PKGJBFmtWERWHEc2MpbvYxY4OCgRcLtwyf9q4DNZG6z/gWnBBWd9fa7wfF8+QOjO5DQFWAoreTLsGC4ghwXd98vrAe2MqBmNLdvP/7AqydDFVz5cpgK35kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0bIniH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB297C4CED3;
	Tue, 17 Dec 2024 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447356;
	bh=kn0QEklhu4DlNWlEmwaB2mgPMFaePNYpED7/K5qStjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L0bIniH/dUhmNJi6+1W2iKhEHFHeE/yOosauVw9/cGJnFoaCRJkpJy0lDSXnmX4Vd
	 +P5NZSe3iWZI6RNXBDJ0bhjxuCj9+A3WM6A9qW86Tjhe4dWoMcljsH8/kGjzDLhiZh
	 FUYe12bPalgLSxL2oD8Z9e5VCB0Exvp5NWHYxleGXdq7BJLsepXl3WOehWomKtuU0E
	 0StRdB+6FXFxS/DpuUmVCWuGyiGLOlh6os6eCp8UfEiQnaIfdnQYQwM13pcDaF96jQ
	 fI2rAS0bpezXGYIcdQAB8LAxGA+60BLKC/LtXly0rFEUOPzXw78plOYxFf/jj3PdAB
	 qLF+L+UAgQcnA==
From: cel@kernel.org
To: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	Yang Erkun <yangerkun@huaweicloud.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	yangerkun@huawei.com,
	yi.zhang@huawei.com
Subject: Re: [RFC PATCH 0/5] nfsd/sunrpc: cleanup resource with sync mode
Date: Tue, 17 Dec 2024 09:55:51 -0500
Message-ID: <173444730015.11407.7732863315759421903.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216142156.4133267-1-yangerkun@huaweicloud.com>
References: <20241216142156.4133267-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=803; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=bCpsI78rnO1daEnMZ/gkQy9wK8/UsEBtF3olU6NP0s0=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnYZD4tzBPXPGa+ATOlwlWuO2Sj5kVZQgZrhLvq cyx5nkAg7CJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZ2GQ+AAKCRAzarMzb2Z/ lywUD/oD2XN1mmhgg0n2tgpnSZS+ETc6q9Pb6rII3F4NW5kUSXrvkLV0VjNDTOme55ejXw4OjYQ Spey+JT2ELUFH0fhJs2aIMsboXpysm8tFfOEOfps/pPI5vWx2RwsvBc8FC3mknVtt8rTLF7Z3hd qF5bejQAp5Q3V5y0MKqYAq4w19VKMMAjxJcsFBGryrL0d4eH2GmT+rXM4nyJn1FXlNTlii7+zBC hBrGPQBPZ2JkuBT7RmoRRnu7oHd+2zMk/Q53OEQQulOYkehSe8m4xw9ykpjtBbn7a21pH4RHiU3 KLJ9DKviMlh0v+9GgZHm94gDio+kO4TWGKJoUTX3A/G42jSOPxgbDj1HdfH2Zy3IBPzh5IMnaYg w1xFIaqVzK773Ks2G/8S8inN2gGiWJY/IDsF8uuUofAhdQ69JOgmBi4nvhYAFYlDHYksN4zP3Ai 1yDCQ/mb9ocNiXBxoIbsdbF8BwrTfoOq9QIXHlgPU30vFAr9D69iLkJpwMVhRcsgzK1coWvYt9a poRhhcKEpyLD8XJWbyTM6E+yPIBgxWZfvDsIIYUD1act+eDIlIfMdavOhNzSGp9nPgt5uMtd2Nw tzBwBKxQ85Ox+9Dx2GjgzGiggNsBhCpd3SY9F2C8IwvzQ5t+k6oQUXUysXdSXLpLIwL2NWBBcjS KaqBZeD
 B/86dP7w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 16 Dec 2024 22:21:51 +0800, Yang Erkun wrote:
> After f8c989a0c89a ("nfsd: release svc_expkey/svc_export with
> rcu_work"), svc_export_put/expkey_put will call path_put with async
> mode. This can lead some unexpected failure:
> 
> mkdir /mnt/sda
> mkfs.xfs -f /dev/sda
> echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
> echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
> exportfs -ra
> service nfs-server start
> mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
> mount /dev/sda /mnt/sda
> touch /mnt1/sda/file
> exportfs -r
> umount /mnt/sda # failed unexcepted
> 
> [...]

Applied to nfsd-fixes for v6.13, thanks!

[1/5] nfsd: Revert "nfsd: release svc_expkey/svc_export with rcu_work"
      commit: 69d803c40edeaf94089fbc8751c9b746cdc35044

--
Chuck Lever


