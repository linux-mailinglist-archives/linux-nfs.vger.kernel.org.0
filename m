Return-Path: <linux-nfs+bounces-7346-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A3C9A94A1
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 02:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F194B22152
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 00:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F414C80;
	Tue, 22 Oct 2024 00:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="p1GefdVD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic316-20.consmr.mail.bf2.yahoo.com (sonic316-20.consmr.mail.bf2.yahoo.com [74.6.130.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87F4C62
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556310; cv=none; b=S2fKKt0p4YzsOSHw2jh5sDdyFpTu8J43W49rpyIO5STml+AJCrgdf85NiZJJ9dk25+uhND1aDB0hR7qvTjvH1lckQq8bgqcm2pGkF//Iz+u+TolKNP3Nc34G9dyxAaM/fbwAFIvL8n0xPZTOe0lB7LIFfBAdllYUPjdhltqPjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556310; c=relaxed/simple;
	bh=z181btsfxt9PDb/yCV5oeTIzDXg22ExnqXko3wxsUyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIfgda7y5fw7SzFiB93ULnPsf5hPFdd80Hdp9TVJ3YhaPFhDU/Hc17mwLN56WnyWiLYEqsEMZpxC+QGuyaM9XwykOv4pz4JbcybL8AIdp4XL1vwP/pFXDtg2U+ClBy/t3moE7VASgcIZRSj3XRkSbmVMMdPQl8+zf5FNuct/r/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=p1GefdVD; arc=none smtp.client-ip=74.6.130.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729556305; bh=jDj5CXvHcjdpLFA63d1hBsH/DNQTd4LCrH9oYp0BA9k=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=p1GefdVDrEnCj6qg8mk3e+4y/2HQxV9+lNkrRCQbPikmEsM4pb/Uy/XJ+Q6J4VqQn2Zkdkc6tqFY+KR/6Eh0V+qysnZhs9xGqiv4x+LLJ9k4Ved9qhZHfaS75QtVt9izWErsTxF+gEwanqCMdsLTojrT6jTaaiKkKvHt5NKPLc7Tc3WggUvZ8/rmLQQ9IQtX73jsUQKtW36EGgP+rO+/9URloWB6xwZWILO18J/TL3ZOWXTmRRS6il+uOYIlRyaX/opF0Ily1BOfAtSXJ8eBnABvC8FvMojmDJ74mhUQeyy7Qzv9GfLF99nxBfoL5kTlyydgLo8epOxZO9EIj5sZ5w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729556305; bh=MSibLBA/JAWhL8Mrc4FRbODZV3fTrdebBmLCST84DJm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Y5EyCF1sCo2ohtKOnyA47o/Prb1Gq5ZcQxGa1UNQrQL+k4Nk4IitNqgB9MCJJqHnzZlIgg4glElLoo2kUPSgnoSQKjTo9ZFAFEElmWHTKlehAbuW+IoOx6A+XOtJJvblBqUn2hXRM02wlaNEOLYhLVgiTZ/15aPZlkrHHpazSAQRSMSmvCR9KgeDOZHSFAK6000qja3i3mqmBz4sjvFhd/RzHqcyWexagK9fPCcMeBtUhUcDogCxIXanrF2jtzj4EZuyan0Ca4dxdrVa90I1J83Czz/sC9FPAvD7KxztOpwyiX7tAAhAOq9Xw6YJnZxp60R0bJSiM/50Ls088VgLzg==
X-YMail-OSG: b2yzTPoVM1kqh1.EwrToqFS8bYbeVZJNIjI.Kk2vyBkUxMzHeh2OGEfb.5M_G8a
 caYx0blk.h1r1bV4YN_OAoE.IRzvTTXTSnzCQcSU4gtvFBzTeaIXywdXu3HJvLOkV6XCtldVVxMw
 dgZgB0Znesy6Kk7kvD3MqKSrrIyiwQ3cJ4kna6ET5IenSIlkAFwnUvqJylv8Y8A4172ukwZRHIDP
 O8kjM_UFJDE.dIcxB2sq24l4kwFCQjsHBscxni9ro49CXe_pSgqLY.UJs5y8lqrcdG6qT.8oIDt3
 bd60la9XrBPhj6d2wxs1AOnmDmU6Hw7eJlaT4fwZsg6bYnBVFMZgaHwfuZapCOcgGQHItOw.s6z9
 xPCRVh_QEWMzImhe3Sgl.AW2izuJOCcL7kWi7cFmChg9QvKK5XHEmkG1rCKZcvr.vm_bFUvpxSci
 OZdSXuuiXCBLAsrOfNu5aMCjKOqAisnoh8h7lSl2quSXTG9cr9rloQk_CkZFZvQOmNakT2Kw7osG
 P62ZFlIXjRNZy7fAv7NOAZtv3MMRzoPrF5quf6WMkB2yIOX6c8zdba8ntmtAYMHazHV3VHXF5U3k
 TBMgF4OWBKzt4qpHwdrr_C6Z5lose0Kn9KqWcQCnj79YQISGUare7Lo8Lj.RoPpg5QEQISK.zHt3
 Ealo9KLhdGrO0HOTinQPZw0.HMFDoWc7Co6II5n7MzACbpfkP1SPTHZqdDLl4SpdvbaM6TYcIvor
 raXui3x0PS71vF8wCCjqdP4uQqvXy5uOtOB.wyGMRm67OBWTbimO6ICTnn2EbYfjx5cpNs0My9G.
 3faeKmhxtcoczYAlsQK3a.DKLnwzXH2gNSRtSJb6rfxriY8umm48IZyuEEFFvZeFGDmIEyFck_pl
 PdDlIg5zg0Lkr8LqRj_lvaYVwQU6CQHP1zQ_InT9vh8q9VmVuLNS_9TVDICqdTllwzHMAx4HBkVG
 3yrf2gaoX3s2PkG_f.CwCU.nYqpuzAqLDoopDjuW45swdLM3DKLXZIe_mzxNIorFwglH2.umXl8c
 mJ4mkmzdb0ZgWLiL8jDSfvkwpO7avdLs_EZ.943h8W4k_n2PZtMZYIEB7qwkyrRaadyTGhFFknMs
 URDcXkqTv5SvQXHgQNdz2UNoghYU4DUIMp2dkvazE51Scp5aAOxUSH0ORelHdxkPu4DufgDoBa.o
 a_kNSxDe2Lp4VuxlcCSnvYR4E6wp5RvxtV.Mikmd86gJaJIRs8nUbHOHiCyHekqeCICgsQddoHHA
 gd1K.AsqyVYWOeb7BhqoOd3ZuLhVIOCCvvqwKME9zQ.STxPA7OV7T43W1w7HIrwwaGZe7JiWnawQ
 Qf2R.v.EaagLQKnXMmwp5uWv1u0kh2dXVRjxhj6t8QLRb8zo._P2CaZ8uD_4TZu9Qk72aioNrWS2
 5tzPDjDQs1bXUdHGhvswSIE7djPKNymNXwNoM46ACuK0iF2ppF_DH.y_q_J6nPDiXQNmZeEMAYjL
 2Z58Dg.KGOX.p_FOsGyfY8Gh07TZpmGo5UPapi6zkiAX4seqINgb3uOc7MkrrXAECitfBInCkl0R
 rXHPhhFYvcMqpz0I4qMb9CoXhHI7uQOliNHhVlYL4yHzxN65qMToiUmXtH0pVgKr7VowTtKKwsOY
 OzoFXMrsdUfwTRaU52Ysas4nBYQKAIp6vHDIUkdd9kDRXC2VxcJ5De_IWKvGJmkpW4nK0RoSL_K6
 JMggscSlleLiK5xRebHR7MkrF2igdFjl5ZvS5heKDjJbd1RHVxO0_xMLSx.yjhyaJh_hZvLGn0lv
 dhQy8ZEDKaKL_QmZZY41yzgqqWM1nKs0iW2Cx_GLMM6jg4Gw11KEXx_J4GA6QhAFx32m9UCkttRF
 naUnX8zIROEMipfwIhxc281.PAW3jWAkJ6Dd2vPtZv7weIlzC_DWv_H6dKUuKGxDNDcc9WSeApAX
 KRt46ho9Ab9_BikIZBuhgOvCVPk3wllK_c1z8zofi8DjYTWVe2SgR0yY5IwGwB9tzKHzRXxSTBU3
 ezmeEKMQUB0EyCFORAkAlIvFW3uUWKjGvILbXUMCIzvNOBO4h_uCKx5JeMkr4By_ARrcO6p3vBas
 5K.ZVQV5CV8RouHp1aOSwKFnIxEtGqE0lcvyLMpt5v9kzB1sdOEXTEGj8jtmQZ1dCEfKZLqT3tGy
 RRsWhT5xtuMj1lvqhpMGUcQ7quw5.wa.0m5Tr54JbUrJash0lGewbia0MKOph4atefNKA6yoILiM
 9mnk.K7PwUuQskT01Azw8gox3.k1FXnJ1GAvd3.8NzBKBPUqR9OxLCBoCXp5kqaii5fIjiGkkVbB
 U.5Ict_X.wZNL6_d6IqPOaA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 566483e5-b146-4668-90c8-890eb38b538e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Tue, 22 Oct 2024 00:18:25 +0000
Received: by hermes--production-gq1-5dd4b47f46-wrqn7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c72af3b73ce19b5992080d7cc4add89a;
          Mon, 21 Oct 2024 23:58:10 +0000 (UTC)
Message-ID: <bab1de2e-0205-40dd-af3e-5956ff349948@schaufler-ca.com>
Date: Mon, 21 Oct 2024 16:58:08 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] LSM: Ensure the correct LSM context releaser
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, mic@digikod.net, linux-integrity@vger.kernel.org,
 netdev@vger.kernel.org, audit@vger.kernel.org,
 netfilter-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Todd Kjos <tkjos@google.com>, Casey Schaufler <casey@schaufler-ca.com>
References: <20241014151450.73674-2-casey@schaufler-ca.com>
 <dad74779768e7c00d2a3c9bf8c60045d@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <dad74779768e7c00d2a3c9bf8c60045d@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/21/2024 4:39 PM, Paul Moore wrote:
> On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Add a new lsm_context data structure to hold all the information about a
>> "security context", including the string, its size and which LSM allocated
>> the string. The allocation information is necessary because LSMs have
>> different policies regarding the lifecycle of these strings. SELinux
>> allocates and destroys them on each use, whereas Smack provides a pointer
>> to an entry in a list that never goes away.
>>
>> Update security_release_secctx() to use the lsm_context instead of a
>> (char *, len) pair. Change its callers to do likewise.  The LSMs
>> supporting this hook have had comments added to remind the developer
>> that there is more work to be done.
>>
>> The BPF security module provides all LSM hooks. While there has yet to
>> be a known instance of a BPF configuration that uses security contexts,
>> the possibility is real. In the existing implementation there is
>> potential for multiple frees in that case.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: linux-integrity@vger.kernel.org
>> Cc: netdev@vger.kernel.org
>> Cc: audit@vger.kernel.org
>> Cc: netfilter-devel@vger.kernel.org
>> To: Pablo Neira Ayuso <pablo@netfilter.org>
>> Cc: linux-nfs@vger.kernel.org
>> Cc: Todd Kjos <tkjos@google.com>
>> Reviewed-by: Serge Hallyn <sergeh@kernel.org>
>> ---
>>  drivers/android/binder.c                | 24 ++++++-------
>>  fs/ceph/xattr.c                         |  6 +++-
>>  fs/nfs/nfs4proc.c                       |  8 +++--
>>  fs/nfsd/nfs4xdr.c                       |  8 +++--
>>  include/linux/lsm_hook_defs.h           |  2 +-
>>  include/linux/security.h                | 35 +++++++++++++++++--
>>  include/net/scm.h                       | 11 +++---
>>  kernel/audit.c                          | 30 ++++++++---------
>>  kernel/auditsc.c                        | 23 +++++++------
>>  net/ipv4/ip_sockglue.c                  | 10 +++---
>>  net/netfilter/nf_conntrack_netlink.c    | 10 +++---
>>  net/netfilter/nf_conntrack_standalone.c |  9 +++--
>>  net/netfilter/nfnetlink_queue.c         | 13 ++++---
>>  net/netlabel/netlabel_unlabeled.c       | 45 +++++++++++--------------
>>  net/netlabel/netlabel_user.c            | 11 +++---
>>  security/apparmor/include/secid.h       |  2 +-
>>  security/apparmor/secid.c               | 11 ++++--
>>  security/security.c                     |  8 ++---
>>  security/selinux/hooks.c                | 11 ++++--
>>  19 files changed, 167 insertions(+), 110 deletions(-)
> ..
>
>> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
>> index 1bc2d0890a9f..8303bbcfc543 100644
>> --- a/net/netlabel/netlabel_unlabeled.c
>> +++ b/net/netlabel/netlabel_unlabeled.c
>> @@ -1127,14 +1122,14 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>>  		secid = addr6->secid;
>>  	}
>>  
>> -	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
>> +	ret_val = security_secid_to_secctx(secid, &ctx.context, &ctx.len);
>>  	if (ret_val != 0)
>>  		goto list_cb_failure;
>>  	ret_val = nla_put(cb_arg->skb,
>>  			  NLBL_UNLABEL_A_SECCTX,
>> -			  secctx_len,
>> -			  secctx);
>> -	security_release_secctx(secctx, secctx_len);
>> +			  ctx.len,
>> +			  ctx.context);
> Nitpicky alignment issue; please keep the arguments aligned as they
> are currently.

Not a problem, although it looks like it's correct to me. I'll check to make sure.

>
>> +	security_release_secctx(&ctx);
>>  	if (ret_val != 0)
>>  		goto list_cb_failure;
>>  
> --
> paul-moore.com
>

