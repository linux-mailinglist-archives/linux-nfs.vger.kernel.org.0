Return-Path: <linux-nfs+bounces-10232-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05634A3E543
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 20:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1285419C45F5
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 19:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65AD1B21BD;
	Thu, 20 Feb 2025 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="N44UApgd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7916F858
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080767; cv=none; b=JgZsAZFchRUecfaOGgQzsUbN4eWLOveUReuh5XypAd52WrXx7JYNkjYwaJLT8wWRy7V4v2M2q9j51RM/2EoCmfH765dF50+Q1x6hP1Rf4FI0oM3sc9hhGcfEHmLWTYZhhkUKgGk/grKFzzclb8/yk8epmak48/i7mk5vc1UH9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080767; c=relaxed/simple;
	bh=Tub2y9j1yX5P9vmN22KNbBKVjcPGwbcBG1eOuBn9Zbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjRjwoCsJgJIAnY8drC5BhQp8mZO0he6v8xqg9AhX1uCfbyYjMfoVq/6TUt4MaE3AdGWcV13VZdSdtfp3Y419Rcl1Fu9vA7qSUZBltYk6ZslIMpy9Hqacx2sw2Lp1djbcaRQeRR0KljDqVjM4UPzlnLgdcwakdgorAbiBPGhx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=N44UApgd; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740080765; bh=ZlhQVWM+zP4UUmubrTcMGr978DLTh2hDXVwN7IBnie8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=N44UApgdBwsOqp7wSEVOFEe0Wf6KHbsFdiFbcSBn3h8IWmoUIresMp1gYrbDDpd/xUPiKvCIg/J2GO6DY0fu88DYv9P7nmWJJAERvBhzlvmzA+3o0ffqiZWHHys0+Wcq9ZRYcr+Uo/j24r5xpaokMbTKtU+A7YSXZinjHEk2e9lfV5zFsVa3mTjpCNLLeaNrhYiSwc1ArYWk8/2ZSeUDc5Wek5a+/2hqQOvaEDqwID2qidftb0xd+5W+ttXJkYVae8fK7yL9BwysgOsMSmNfz7r0/US8i09C+gEozNqB2gerV1Fc8MJPvCuYNu+cM5pZFU1vRt1uyWCsXBTSvPkwAw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740080765; bh=VOcHEGqwuDp/mMahoSPyfXlPlu0+BfsIFiM3PWQ7X7S=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Ra3V611aTJWQPuKJcvmNebXRO02LCxcF4UeMAUGfUMvyxe4s9FilnoB+ldQd2TSBxjllGmQxm24P9p206jYmqaR41BlyEOjkNszX2ShgEzsi0xHO+WI7mMsrBQsOh9oGaxnb3uvOoRAM2SdhjggL4Ixd1C2rCAu3A1jVFgf23KDyxAnc0sQ4XLK5W8nIpbJvn93pYMN1cRbEM75W6hckgyNQboIvTBOnAuWne7xU6kEpdmyJOgwLaDI8VyehMOscfyYFqAVl9FIe49upr65iVKQQpE9V0tf+TsE5PB8FHmg2hDimj7i25tzaXEqlc+0YDNcmIegQHH+Pb7RYhvr65g==
X-YMail-OSG: 5G4ZzP8VM1ngVhkc3trhtmhdZCUHODWJK1SHjZaeAjQpusOAe19dh_Zsq4T4KpA
 b6PAZpWLWQDDOc35hIMzUXqGWsXnvdcfn1weYKZfrAbVyJ5AAX9rwKyRXPEL5ogIfPdK1qvaUZUy
 34AuJW7vl8mClcSXJzaeKp9CkN5uETL0S4o5zJVZJk_9w6J_ZLOQiFJ9WSdrNClC8KNZ.uBdDMf_
 c2a5OiLbjtg1juSR3TSdJYbA_vX.yUE6SBcYKPl_OSG2P6diluKb_bOElZC2stWgRRvUlF53g6FK
 D_pT.ZdKFhuPiIgJBVLV86Uo2HajuWn_HvnxBZQSRl4jksWFnrxA08wpAmckYmyxeq4YTMNXyNjE
 dVe1FI8FQSmJ7IfD4fhxlUeiokSIlbcWbIIUXDa4muOY9toT4DB9zzuJjZkeSuOW3T5Rn3EEwWle
 XxKzVieMDX_qD2Ieae3KP3AMlBEWpJa_mo2_jSVUEWZoHbSWogsdLVLlIjgW58G9wRvKr81VMdYO
 xDM3cuEO0aytyUTYdfc5b0XAp4ljrLhf9O0h8z.1SBm0a8ohRJ9G8Wg8NdhrPq4y2aFXHXgsBcpO
 tF1WFHDdNv2rQHf4y6GpPfJPo8UwSg8YfMbQgooa_xOEoDZ44mt_vD7oS50elql_0hgXIDgJqxla
 cl4xnuJbRHY6s9nQ2hGpCvhGWQnSZaOLkUgAIpYuy2yzKvhWHZDvtm9HpeDCCW22Jiw3tYovzRUO
 exjbQpou5c.pnuuAWcFhTwS2lXnGTzCERxUAlvL5sJA7Qq6KzwgQdC28Z50FvRohrNYuDtllDuZt
 JlplxLMfnBCC7M5m0GM28aZzSjDStuBUZdtsuB_9Hg9qvJ7A.Z5COZNWts6BzpwYRIc0rXznw1AR
 Jlkc4B0hbOXZcmU9QQ.NSejSMn0EbawI.Zjufqp22rh6GdmiQiWIXGBsq3FMd2rTEiKt6MWMJFNF
 GvfEC4DzOoF1N8YDSD0QiRtzv481cDEa8qxys0pZDPLww8yH_vS28lVeoF.2QnP_9Oyjy7wGbLLu
 hcm5j4emvsyJfcG8wyQVvgxOkEDVzFrjNwzrnjxANl4pFuG2AbbAOcACJ3LWpS4uqYqi0TFYehcA
 XUR4jPtrZTpMWR_WsHOe.Etnb3Wdm_y2.XQCD4Pow7dB..Y3wYSfVE2XMulgd7X3bY0IEksa19X8
 IuRKX6VzxygxxtbfaLYDRsvtWqx0ZHOtmHjBF5nyD0iPdjPLnZkuOpfNsY383Q6IraTIy39RK5Og
 Fd3Gxusf.wKHRI4T9QSOJhB3IM6RH_fiwnLAIRo3cq9Ws..sh1N0z4TJkectxCRmhMQYPZRBU81o
 6lBN3w78Sfg9FjiaFWLiWwkkJyGuJt0CZn6lgOrK7Paa5QN95Ja72X00UHmvZopBESQcCKX82Gsz
 pn8tafRPV2xgil08ucj8eZI6NkiFLqB6g_qv.kfXQd.YVOUMgpjL3.FiQmU.mCBbNcynXJhlorQ1
 h3eEZ.KWGDiqLDjM3mQpk7vJW4745uQJs1sAMxzPk9GP6e.Uj6Be2fMkesKELHGU4XBNVw5J._fD
 Qe7pMmWHPibfevDpJ4cAnos56gueuhkEOq3dRdCkkJU6utEgX6mvCVAIbDx9AdY_wV2eeuik9Khr
 a98IXNqWBcBo4Vp3sOZdfiSO.jH.dwh2txo3lAZ.TMdfHr86pAuldb2fRFxfvPIeAl.rd.4Xt2Ne
 0bQgMaRMoqz3kwsDwxXHCdWyzz7l8a5QWrRcIbFLGWrKC3sa1TFw2bIz5nnWeJnTXr5KbrwvRT_0
 lbOC29x8Hsot1IUO4b5.8A85kPxeKmw1qoVQ5hOGqluybaIAxKqy6egq.NhKepWBRJguFlZuDF6i
 vHONiXxMNmKmOYhqFNYDQvxjS5J6ApXpu43KapJYB9umeu_eVzEF_PRfQO4H6M1jEOdE9gckVV8G
 TrzWoYxRrBuZwZ92PddL6T5uJIV78_q3HKwPn4zU6yjxqQ6t4GzVMnLVKsEEva2pdMJ3w3r1xEED
 SVrFRENNTwmtgiEGq76W9Ss2E2qUzydrw41.bOCoko3rfScCkpA1ETNbLrTrzOK43vTDREHSba5L
 Wnl5Q.Lfek4i2q.zElPGA4PL1NRytZcBR9BXoI.QHy3Tq_ru219sPtwgvOBQnMPR_ixR1kKq_u6T
 pdq9QDBH._x44L3FQKbWmAghiVmtTLp0yxAjsxDM8CkOU2WbOGKdZGgplfIBVxdyjn.BENvtvZOd
 CLFamA7EWLEVXhobVehFIZ65p5JaX4UnXOHZ0eaazoRa167KYTKbnJyx.N6MDyj3bONejlLNzKjV
 0Heo2B5qe0Ya62SvyWBcbEgI-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 23ff3bde-6f05-456b-b97d-6416f6eb0c97
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Feb 2025 19:46:05 +0000
Received: by hermes--production-gq1-5dd4b47f46-k4d2j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 13da4c503da8beb60c4bf48516c9d5dc;
          Thu, 20 Feb 2025 19:35:56 +0000 (UTC)
Message-ID: <6bf60899-fbc2-404f-b6e9-378fd828f303@schaufler-ca.com>
Date: Thu, 20 Feb 2025 11:35:54 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm,nfs: fix memory leak of lsm_context
To: Stephen Smalley <stephen.smalley.work@gmail.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: linux-nfs@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250220192935.9014-2-stephen.smalley.work@gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250220192935.9014-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/20/2025 11:29 AM, Stephen Smalley wrote:
> commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
> did not preserve the lsm id for subsequent release calls, which results
> in a memory leak. Fix it by saving the lsm id in the nfs4_label and
> providing it on the subsequent release call.
>
> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Please don't accept this. I will have a better, simpler, more appropriate
fix promptly.

> ---
>  fs/nfs/nfs4proc.c    | 7 ++++---
>  include/linux/nfs4.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index df9669d4ded7..c0caaec7bd20 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -133,6 +133,7 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>  	if (err)
>  		return NULL;
>  
> +	label->lsmid = shim.id;
>  	label->label = shim.context;
>  	label->len = shim.len;
>  	return label;
> @@ -145,7 +146,7 @@ nfs4_label_release_security(struct nfs4_label *label)
>  	if (label) {
>  		shim.context = label->label;
>  		shim.len = label->len;
> -		shim.id = LSM_ID_UNDEF;
> +		shim.id = label->lsmid;
>  		security_release_secctx(&shim);
>  	}
>  }
> @@ -6269,7 +6270,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
>  					size_t buflen)
>  {
>  	struct nfs_server *server = NFS_SERVER(inode);
> -	struct nfs4_label label = {0, 0, buflen, buf};
> +	struct nfs4_label label = {0, 0, 0, buflen, buf};
>  
>  	u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
>  	struct nfs_fattr fattr = {
> @@ -6374,7 +6375,7 @@ static int nfs4_do_set_security_label(struct inode *inode,
>  static int
>  nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
>  {
> -	struct nfs4_label ilabel = {0, 0, buflen, (char *)buf };
> +	struct nfs4_label ilabel = {0, 0, 0, buflen, (char *)buf };
>  	struct nfs_fattr *fattr;
>  	int status;
>  
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index 71fbebfa43c7..9ac83ca88326 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -47,6 +47,7 @@ struct nfs4_acl {
>  struct nfs4_label {
>  	uint32_t	lfs;
>  	uint32_t	pi;
> +	u32		lsmid;
>  	u32		len;
>  	char	*label;
>  };

