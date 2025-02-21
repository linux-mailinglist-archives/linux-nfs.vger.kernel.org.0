Return-Path: <linux-nfs+bounces-10272-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2D3A3FA62
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 17:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245C417F175
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAB2212FAA;
	Fri, 21 Feb 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PJA/Zv8X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE71D212B07
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153554; cv=none; b=H5nldgh1OUUFj9+gEPr0dlsK/6rjpLC7S1qKS4ZYwmvwgN22e6PMLmRR/BPHMRbwzn/14K2X+sIW9WvxoPCMoxe3X36tDHlwYrj6nGyTXa8FhkB+eqKL8JUHfMUuJQMl+QORaa8sW011DOwHjZ47Fh4sDolEzJxwrEu4YWKod8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153554; c=relaxed/simple;
	bh=db6te4m+sCMvgTVmKh+oZCF5YeW77eGS4R8oxUbD4xw=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type:
	 References; b=qB3gWSvbgwWniImQ9qbQfloTp9Smm+xoGZa/Tr0LQlO4as95/560hE78enTP4KRVlBJGJVC+Re9OEca1Tn++bfK/paDySJ/YirVS9paPw5r9Ojpr/Za9Xw2dcghmPX0Q9hThjIo2vbxvHh3i3wvgsTYcRZfjm27iShrxNcmNRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PJA/Zv8X; arc=none smtp.client-ip=66.163.185.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740153544; bh=sspHfWx8ycvI6P03gAVUkjw/qOVU8F8R3aQbFxvcGH8=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=PJA/Zv8XFzPIWXHelwx77K0hFK+KXZB7i4t2cB9Z5CmqrUP3F1/92vFyVq7b0+BsTqHtLmz3zVRs5c7ap8IBex0zulkZOPLCZGTX+2HXK8CpZSxKOBG5hoJxks/hf2k/VvjMQZgzwf/4iku8A1zq7+3VekIkYSP3eWLY4901qAF822jdRFIBIk+DEZXfGSBOdxoy8h8IENSeLDT4UwDg2BiUsdwktZU+o1ARDQTFCxGQxOqjgA2rS0IwkZuGOliSXrsoaI/hGgvClubWrhCFMQ5y8NsReu/85Hk+TUdC8Gcls9h+g67CNgaunGR+q8lUA/O3MNEfvG3SPSvov3Xw6A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740153544; bh=x+iMLlkqR1FxB6E3L63dEJqO+yr3VZvk7x7JFFN+hmo=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=pXaV4L2C2BgjCbJWfWLL8b+g1UmtGCYJ5bPmsCgpJqPLHLBiy4/qnvWFCeudcrdfIGlYw6X3yKuOCofukZNecn+Vq12wPKnheQj2tFnb3sTW867XdUXDm9+7tccPao2E3QDiWtTCpHvHpif7/UkwBQ2JDAK3JMYJ9kMh02ACWfOb5tj9QvoKNkAWnIRGHi43PTeGtW+gdaCJF9sijoPJ985HRQGI8Iaymi3a4rHFXm+RS7Y+6rCyS1c+xQlUrk+8blUTM4gB/l91cxnqoqRBIBb9sxdi8gEjtgXBrO10YgmCj9P1GfPGBcy9CmvbHG03DiXGu3Gu2ktBgfJu/xgrvg==
X-YMail-OSG: XbP_sdoVM1loH3BMm6lrg32wuoVEj5bmknxberTwz5Z08qxrYeZn53dCuWBqocA
 hORwjRfg0SyOqciO_IspeP1BQ5kOQdL37tRMYMXa.9Zt4KtWuFy1G25jcpLbXWU4w3TiXaV2TyqU
 zdpOyLaVKway1OZnQVqJtZ0DwiJ_EBIRAPyzej71z2UraioFeHNTkrjEHUx4dVvdvv3Gq8PMogZv
 4TGW4LfPQCtFHr_C61owAGI.jY2VHBZw108h.D6j5Ta8wOUQimwS8AJXDd6tP_TByS0z2wABBSEL
 fePtwCciUGyxIOUC6ABunOq.gtf71bgh_x1mU0oM_SmReKGJqfyLmrZNlDT5s6FgUQEes_1APP4M
 4jFLEmLcQV7ZcPS.ffU8QBLjJr9IF02A1PXKg_NTD4rXv9lUfYgCUyUZRSF_IcRLoDZF3f58WgNt
 C.14tDtvgRA4wbSC48fBBGzwPXOrCCI0_685DZzEaCXxuv7B.ZW7Q6XASMX0s1oRNlDDYhlXeftY
 WhzjUECtas9N78FMjCq1YEJt5hMJBoLunxNGvqigZcwE7FJmInSwaAl7Dkd4vhDiI4xftfWIKvyK
 AnXYxT09wzi1G.E8M2urAB.LrpSfYj5CymgaCZ4k09w5B6dIf9lhqwfiDD8xo6qdzM.z1gEgHR1y
 _sg0a9L.V40Stk6jBY78K73f9CfI4Bdr0eZYP1cqg_NsHJDcbsNZD.V7NPLLI0m6IrsUXBiooyMh
 g5TD6b51aMtRaHiTcvC4w72kXO0fThIEkDgLuS7oNkhye.o.cUhqzXAkZyuuZ_pJoG59uweZL9.w
 3QqCxIzpwXtcVG8Zu1t08gVJLwjcnZIyKW8UuvtnuitzR3xN3zOZlGNKszh_gpz8yNBeUsUFCNVl
 psd17dZ2YMgx1QJRE957N5Ho3ZhNMV1vULMw61MLAEIMr_4TCZpUnox9X.7Lne4oUDBh7cmWWMYC
 eT2ssDdb5Q6RNwfpZ0c4_O4AsjDiyaMmG2DdYLTi9Z1kp2E3s2j5XqClzZRbV7V3y5QnClHqmP6r
 yVGSpqSiyG2Q26eOIqXQfs4y5QIj6vZDnhUzsmPt05efGvzJ6rFI4jsiV10JKV.jG5sHVRPOd6el
 e396G5ljNC0l1Ulf7YMC4.1o3e58jH9DK0L9EA9zT_m_CWmVE6aWU6ee6N3Kjr13iZ70yT2_KSGo
 ERpMiICInEknpNLNxOVl7noJbdcS_szQdySnY25pt.TtrsnBmOhbWP90ZlaYkgf3eWeCpExk0UFQ
 GIAWv4TbBLzwquyYTWIW8ld2bHCSAR0_sWIigUb1GEc9iLyACFa4ko30ItjkBXKNftQ7njJKS_Y9
 ._QAY87JQhlwV13NkGg5YmqJVzODAQAIVrMesTk3kqHaFmU2d5_fQAS3eTYSnyu8LS_iHZLglUPO
 QaNegrli_IpDCM5TAvjMUBxbogqkpXBEm_uHpVnssgEqKUrbUx2fH3EHLYdrGow06WU4n6myY3TI
 rHMCiEmtNzKIlC.wPCSa6FZUAs4I6FzQF2OVSvjOFFmXcTTP5s2yBIyghsfJH4SGJK9G9l0lPo0D
 a2HbtjXrqsfQN.3qio_js47edEKYn8LutIWAnfpgo1atmj6e8IsWTpLe5Nx3LyguJ3qdIwIIJlwx
 KVlQuQeuyXjw682_rrk5VKHX2mp_uwuc8JQTFYOU00tPoZMSogMyUU.FpAf0nyDShbPmgJTq2Gjp
 oyH6sBYMjV8_FwovewPTZi2s9Jd0Ea0Yzk7pw7XS9fngBFidWD1VgKaKIkIaJoGWXQcHd8jqm2Vb
 Zy37E2GHHjQt1gIKngWYcgTmE9i7OzD5ly5lur_0.kVsy4MxmXMhUAVbOnM5cX2uBYRtIwFScfcK
 LFZU0SxVQgztKWa_gztNg1u0rj.6UYkLDM5qXnHXHAMD7tWlMElXsvU4YWnVBrxcwoN8ywSRoB2c
 a1tI_SSJIonu.Ice5fBIpLisUjEG16hyJq4jXP5OOs2sJykpQeyxPJMHai8UZWaqPEBkWOC5e9s4
 olfEDIHPkuiMiIdc0l4hhOY78ProtYDZTKuVJy2_6eWskizRDw7Oq4ItPhtl0jHyEy0D3XRYOFuW
 VuKAD0DCdYLeK_UoQGPJAtl.WPfzCCWI_vNpuTJ65VhBlYh8nnJv3Rs.IzxFQVEeq9H5jl.dkJNz
 5fhDusXYJlqHOlT8o2Qpbws9PPClFZT2QoE_gOQQMSSGI574ZE1nra70rd7z4miSJou5e17Lu8vz
 HozBFpKtHdfigmdvpNHhV0.2XOj4hLbMjb946nFLhcc87AV4bxxJcWTxbsMd7rFG1uJKHDCAajyV
 YU8c5S3YGJJjm8t2Sk_Q-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: beddc269-80cf-4b6a-a520-8a4560205c07
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Feb 2025 15:59:04 +0000
Received: by hermes--production-gq1-5dd4b47f46-wrqn7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a4bd0c1f9e26f822d065f56915198d14;
          Fri, 21 Feb 2025 15:59:01 +0000 (UTC)
Message-ID: <d5fa8ace-8bc4-4261-bf34-c32e7c948bb8@schaufler-ca.com>
Date: Fri, 21 Feb 2025 07:59:00 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
To: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 LSM List <linux-security-module@vger.kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] lsm,nfs: fix NFS4 memory leak of lsm_context
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <d5fa8ace-8bc4-4261-bf34-c32e7c948bb8.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

The NFS4 security label code does not support multiple labels, and
is intentionally unaware of which LSM is providing them. It is also
the case that currently only one LSM that use security contexts is
permitted to be active, as enforced by LSM_FLAG_EXCLUSIVE. Any LSM
that receives a release_secctx that is not explicitly designated as
for another LSM can safely carry out the release process. The NFS4
code identifies the lsm_context as LSM_ID_UNDEF, so allowing the
called LSM to perform the release is safe. Additional sophistication
will be required when context using LSMs are allowed to be used
together.

Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/secid.c | 2 +-
 security/selinux/hooks.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 28caf66b9033..db484c214cda 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -108,7 +108,7 @@ int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
 void apparmor_release_secctx(struct lsm_context *cp)
 {
-	if (cp->id == LSM_ID_APPARMOR) {
+	if (cp->id == LSM_ID_APPARMOR || cp->id == LSM_ID_UNDEF) {
 		kfree(cp->context);
 		cp->context = NULL;
 		cp->id = LSM_ID_UNDEF;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..b89d3438b3df 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6673,7 +6673,7 @@ static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
 static void selinux_release_secctx(struct lsm_context *cp)
 {
-	if (cp->id == LSM_ID_SELINUX) {
+	if (cp->id == LSM_ID_SELINUX || cp->id == LSM_ID_UNDEF) {
 		kfree(cp->context);
 		cp->context = NULL;
 		cp->id = LSM_ID_UNDEF;


