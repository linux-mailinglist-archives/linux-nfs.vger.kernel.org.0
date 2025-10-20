Return-Path: <linux-nfs+bounces-15417-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E46BF27D5
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 18:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B1334E37FD
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F647328633;
	Mon, 20 Oct 2025 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2bnOGWg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9626980B
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978669; cv=none; b=E2XgWOdxg0qPNcajI2VyxE5sBe95A1b68jDo9dH5Cn9SlonNQf+3Ne6jdjYGJZKdwqd2dY+uyhPgwODoWoi0RbALw09TsAtK+q/zQkjp9fw28AToM5MZZtHLfYpFxVjn9hj1Nvckgec0JLtF5CaJqP5kKqGXir1zo3zCTs4+zIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978669; c=relaxed/simple;
	bh=sALAqEB6rDKylCv1FDe47w0/JdYpl69JFkgXpOGQYiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMj8i3XSiwn3SDr1+EV1MzVxh/zDTUSg4KMpa0lT0eanYn2dr3ytqKdNczl6dw6kMIPg9jSMGe5SvbNIlKW8Mye2qXfOzZrz8WD+rL3Bfd8DGrAs/W6+91vcowwgFbtgVpsGEUF1SWTQJOauUjbUVQlT03sZlw4I8e50/d6zbL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2bnOGWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE67CC4CEF9;
	Mon, 20 Oct 2025 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760978668;
	bh=sALAqEB6rDKylCv1FDe47w0/JdYpl69JFkgXpOGQYiQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u2bnOGWg61gw1qBVK2ckfP+SmI5tEDR3mq5PG8mVc/gNPImofiDRsKy0JkaDrvGA6
	 H0BIgbboVarbmWOENbtJXrsC69CrLs2T6dCnzyouaSqtCacgoesALSResLKk3uengB
	 N/Ece03mZ8i7I/nRKo+AhYDOnmG1VS3VCNT/3VQI09neHMOL1BEtIzD0Gle2Hce0c+
	 /d+38HSyLMC87m/jIe4+9Q3N2t8ylz3YRadrw3jze+yolHZWHBYKiLprF7XqwEk8cw
	 blt7LJwOS7Uy34NcH0fNYFTD8MEYhhFqlLMpzdJudIr3IsCs18lrhIkVo37c9yN9wP
	 AwDI48RnS05rQ==
Message-ID: <c5e0409a-5fce-4adc-bdd4-584a7c384c95@kernel.org>
Date: Mon, 20 Oct 2025 12:44:26 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251020162546.5066-1-cel@kernel.org>
 <aPZkYqyFZ4SGnMbF@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPZkYqyFZ4SGnMbF@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 12:33 PM, Mike Snitzer wrote:
> On Mon, Oct 20, 2025 at 12:25:42PM -0400, Chuck Lever wrote:
> Just a bit concerned about removing IOCB_SYNC in that
> we're altering stable_how to be NFS_FILE_SYNC.
Commit 3f3503adb332 ("NFSD: Use vfs_iocb_iter_write()") introduces
the first use of IOCB_ flags in NFSD's write path, and it uses
IOCB_DSYNC. The patch has Reviewed-by's from Christoph, Neil, and
Jeff.

Should we be concerned that IOCB_DSYNC does not persist time stamp
changes that might be lost during an unplanned server boot?

As a reminder to the thread, Section 3.3.7 of RFC 1813 says:

         If stable is FILE_SYNC, the server must commit the data
         written plus all file system metadata to stable storage
         before returning results.

The text is a bit blurry about whether "file system metadata" means
all of the outstanding metadata changes for every file, or just the
metadata changes for the target file handle.

NFSD has historically treated DATA_SYNC and FILE_SYNC identically,
as the Linux NFS client does not use DATA_SYNC (IIRC).


-- 
Chuck Lever

