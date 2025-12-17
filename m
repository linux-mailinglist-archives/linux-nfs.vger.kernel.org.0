Return-Path: <linux-nfs+bounces-17137-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A08ACC7818
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Dec 2025 13:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 054BE302DB57
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Dec 2025 12:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CE324BBEE;
	Wed, 17 Dec 2025 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaLfYuC9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A47B3E1
	for <linux-nfs@vger.kernel.org>; Wed, 17 Dec 2025 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973468; cv=none; b=iujtM9YEDp1SRlPhMLmHs6tOi1PP8w4tdD8+JwLXw8MUtyignzt/odBF4gUaYZAjPupHm/95pRh0kFOUo5PKTaE+phkqlBkqDPpTaspsXTXNmTc0Vh9V3LFYWXlRdnbHVkk8ZBRt3xT/VrdehBLF0Ra3QjpEevEFs9VFm8zD7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973468; c=relaxed/simple;
	bh=+44g5J9tYT683SKLVTNxg9YLgcAKwIHQ3kxdTFrjjfM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zy5dfXqzEmCaE0IRh6c8W0x+PmRm3lFknoI2nQKnefE3064O/BsPEPjORTR40ic2N11h2ZMRpsTT3S+FBPKn5NeYWJ+3r/MYhQUMmGS8zU0zTSuXe6dDV4qsLmTR1bd+uC+h2+oQp07ZMzCbuimQIMs9dqI6LVpQFCZDmfmN+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaLfYuC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E75C113D0;
	Wed, 17 Dec 2025 12:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765973466;
	bh=+44g5J9tYT683SKLVTNxg9YLgcAKwIHQ3kxdTFrjjfM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AaLfYuC9TpuTeozGHUdXentsHNZSMmFzoHlJN4MUDOrDuGS1MfysDdQ0k+A/BpIrM
	 mx0CYuO/dH/gT0Yvj18vRG2DTeLR3n1F6p+lt8OwKfWVA11W1poG9rs6kmpNVgdbjD
	 bEzsg+9+OV78toV4WXWCKngqmu/XtXqg88qg06QXPf2KOdG/lnhrQj3pCGE6stTrOZ
	 DibdftVabqceKd35Dun5DyVXVF3qm5OAfm7ynIfZtfvIu8UyYI2oipXH7SncZVNlXB
	 qgz7xZYhEj4+OJtM0nkcFGbVl2Ht1V8XAj0KFEOlH6olfCDHy8NBjbF3FCCYVwW54x
	 pqPw0TYcrZ8Zw==
Message-ID: <42d3e730e4f92669838b036e2ca902eeac93ef5a.camel@kernel.org>
Subject: Re: [PATCH] pynfs: Fix bitmask check and handle NFS4ERR_DELAY in
 CB_GETATTR
From: Jeff Layton <jlayton@kernel.org>
To: Suhas Athani <suhas2012athani@gmail.com>, calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org, sathani@redhat.com, Suhas Athani
	 <Suhas.Athani@ibm.com>
Date: Wed, 17 Dec 2025 07:11:04 -0500
In-Reply-To: <20251217100942.63158-1-sathani@redhat.com>
References: <20251217100942.63158-1-sathani@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 15:39 +0530, Suhas Athani wrote:
> From: Suhas Athani <Suhas.Athani@ibm.com>
>=20
> This patch fixes logic errors in the _testCbGetattr helper
> function (used by DELEG24 and DELEG25).
>=20
> Changes:
> - Fix Open Arguments Mask: The test previously used
> OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS directly
> as a mask. It is now correctly shifted (1 << Constant) to check
> the capability bit properly.
> - Handle NFS4ERR_DELAY: Added a retry loop for the GETATTR
> operation. The test now retries instead of failing immediately.
> - Fix Callback Verification: Updated the completion check to
> verify cb.is_set() at the end of the test. Previously, the test
> tracked completion via a variable captured before the retry loop,
> which could lead to false failures if the callback arrived during
> a retry.
>=20

This all looks fine, but it's generally preferred to have one patch per
issue. I'd suggest splitting this into 3 patches, since you're fixing 3
problems.

> Signed-off-by: Suhas Athani <Suhas.Athani@ibm.com>
> ---
>  nfs4.1/server41tests/st_delegation.py | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests=
/st_delegation.py
> index f27e852..ef8fc2a 100644
> --- a/nfs4.1/server41tests/st_delegation.py
> +++ b/nfs4.1/server41tests/st_delegation.py
> @@ -1,6 +1,7 @@
>  from .st_create_session import create_session
>  from .st_open import open_claim4
>  from xdrdef.nfs4_const import *
> +import time
> =20
>  from .environment import check, fail, create_file, open_file, close_file=
, do_getattrdict
>  from xdrdef.nfs4_type import *
> @@ -315,7 +316,7 @@ def _testCbGetattr(t, env, change=3D0, size=3D0):
>          fail("FATTR4_OPEN_ARGUMENTS not supported")
> =20
>      if caps[FATTR4_SUPPORTED_ATTRS] & FATTR4_OPEN_ARGUMENTS:
> -        if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want & OPEN_ARGS_=
SHARE_ACCESS_WANT_DELEG_TIMESTAMPS:
> +        if caps[FATTR4_OPEN_ARGUMENTS].oa_share_access_want & (1<<OPEN_A=
RGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS):
>              openmask |=3D 1<<OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMP=
S
> =20
>      fh, deleg =3D __create_file_with_deleg(sess1, env.testname(t), openm=
ask)
> @@ -344,12 +345,26 @@ def _testCbGetattr(t, env, change=3D0, size=3D0):
>                                                            1<<FATTR4_TIME=
_ACCESS | 1<<FATTR4_TIME_MODIFY)])
> =20
>      # wait for the CB_GETATTR
> -    completed =3D cb.wait(2)
> +    cb.wait(2)
>      res =3D sess2.listen(slot)
> +
> +    # Handle NFS4ERR_DELAY - retry until we get NFS4_OK
> +    retry_count =3D 0
> +    max_retries =3D 5
> +    while res.status =3D=3D NFS4ERR_DELAY and retry_count < max_retries:
> +        time.sleep(0.1)
> +        res =3D sess2.compound([op.putfh(fh), op.getattr(1<<FATTR4_CHANG=
E | 1<<FATTR4_SIZE |
> +            1<<FATTR4_TIME_ACCESS | 1<<FATTR4_TIME_MODIFY)])
> +        retry_count +=3D 1
> +
> +    if res.status =3D=3D NFS4ERR_DELAY:
> +        fail(f"GETATTR still returning DELAY after {max_retries} retries=
")
> +
>      attrs2 =3D res.resarray[-1].obj_attributes
>      sess1.compound([op.putfh(fh), op.delegreturn(deleg.write.stateid)])
> -    check(res, [NFS4_OK, NFS4ERR_DELAY])
> -    if not completed:
> +    # Only expect NFS4_OK now since we handle DELAY
> +    check(res, [NFS4_OK])
> +    if not cb.is_set():
>          fail("CB_GETATTR not received")
>      return attrs1, attrs2
> =20


--=20
Jeff Layton <jlayton@kernel.org>

