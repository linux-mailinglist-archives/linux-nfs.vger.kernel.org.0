Return-Path: <linux-nfs+bounces-11143-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BBFA8AE41
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 04:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C64517DDC6
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Apr 2025 02:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBB5192B81;
	Wed, 16 Apr 2025 02:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RPhtYdBj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9071E1DEF
	for <linux-nfs@vger.kernel.org>; Wed, 16 Apr 2025 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744771314; cv=none; b=pNNkKk6Rvbj8979lW5JhP++LZGQkLfWbtbor91ifYAD/Rj4DdFskGmqQpRGvIrMMOqbmQEZXr+FY2LL4duEodaaWR3tbwbyY85+dN2ASqSlRoSib32cf79HhMsc24GWqxuchd1iAP/u8O6nOqKoSLzBUeaBUXT7mL84cS2/z7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744771314; c=relaxed/simple;
	bh=22h4C+OpN04lwST5LLLIP7sduXAqR2ifidIfay9QuEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HW+QWjZYZa5Ffiuqb7YKkh4GXixHbg23zA1YPxWVbTgkHd3U1VeHKXYpiF4BB0ymaiAhDlmknxND9+fVg4h7wXihwEpXNZpOelP5g6fR2I0SKtFSLyCCNoL07fq/jlfQ4hbPBrIv7fV79v7em7/ADxKbfvauw3Z3rhlSIK9Uroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RPhtYdBj; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 4siTutOroETiN4siXu7tja; Wed, 16 Apr 2025 04:41:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1744771303;
	bh=nR/fUwu93F7uJFDWmHPUvYfgHwVTIYA/Y/0xFhf2uxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=RPhtYdBjNCVi/qqATpWf4e8QX+tdTIzme2iDC4lUvGNwF7wqSjb6IBp4iXqKS2f6E
	 +cho3FwnT9noCxZblzNVUqiK7Qjo8ODT6kM6QjfBgmVzP4muoSLMFAE5PDbHFOHKco
	 MDQA/uVF8m/7qpzhI9C5JX8GM/dF8XGzTdvYclsL5/B8fEJYY9oj5JjqAvoVP3BrQm
	 dvr+1p4B49VeqlFxYSbKE69oPxBxifOXaQXj/ScfWgwwYiKYOeZEJ5+rymG1CJLbyD
	 bXziLWoRh9xo7CJNUk6GXzYCVT8BGqtsz1bSdcyvIqzBQL9SnVxhFiZexCOSJmHuUs
	 ZFquPXCzwzhqQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 16 Apr 2025 04:41:43 +0200
X-ME-IP: 124.33.176.97
Message-ID: <738e994b-1601-4ae0-a9a2-f74a6b797f23@wanadoo.fr>
Date: Wed, 16 Apr 2025 11:41:32 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
To: Mike Snitzer <snitzer@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna.schumaker@oracle.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>
References: <20250215120054.mfvr2fzs5426bthx@pali>
 <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
 <20250215163800.v4qdyum6slbzbmts@pali>
 <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
 <20250215165100.jlibe46qwwdfgau5@pali> <20250223182746.do2irr7uxpwhjycd@pali>
 <20250318190520.efwb45jarbyacnw4@pali>
 <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
 <Z-QYjLJk8_ttf-kW@kernel.org>
 <3911d932-5ad3-4cc9-98c9-408818cdb4cf@wanadoo.fr>
 <Z_coQbSdvMWD92IA@kernel.org>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <Z_coQbSdvMWD92IA@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+CC: Neil Brown
+CC: Olga Kornievskaia
+CC: Dai Ngo
+CC: Tom Talpey
+CC: Trond Myklebust
+CC: Anna Schumaker

(just to make sure that anyone listed in

  ./scripts/get_maintainer.pl fs/nfs_common/nfslocalio.c

get copied).

Here is the link to the full thread:

  https://lore.kernel.org/all/Z_coQbSdvMWD92IA@kernel.org/


On 10/04/2025 at 11:09, Mike Snitzer:
> Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
> so various compilers (e.g. gcc 8.5.0 and 9.5.0) can be used. Otherwise
> RCU code (rcu_dereference and rcu_access_pointer) will dereference
> what should just be an opaque pointer (by using typeof(*ptr)).
> 
> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
> Cc: stable@vger.kernel.org
> Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> Tested-by: Pali Rohár <pali@kernel.org>
> Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>

Hi everyone,

The build has been broken for several weeks already. Does anyone have
intention to pick-up this patch?

(please ignore if someone already picked it up and if it is already on
its way to Linus's tree).

Thank you,


Yours sincerely,
Vincent Mailhol


