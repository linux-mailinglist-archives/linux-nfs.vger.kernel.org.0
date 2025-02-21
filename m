Return-Path: <linux-nfs+bounces-10282-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515BCA40162
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 21:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 285C87AB2EE
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 20:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BE9228CBA;
	Fri, 21 Feb 2025 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BnpTl+qe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B61EE028
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171278; cv=none; b=LUySfe6pzIHLGOjL3BQpJbWY2LtYu19C2EnDwpppchKuSXjHj7vSuK5L+0mCy0KLrUThARTJ6isfwr1Rw9b5CqjWDavdwIYNMGRubiAMfW15JG+b1KjJj3RAeO3c/tJ5P9eecwzdpGX77o617kWkOvxed+yFccmICQtdHfle+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171278; c=relaxed/simple;
	bh=FWX6VunyZSY0Lrkv8UM/Vsz8Pn/RLg8puoVt7eB2Zr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LptD37FLEDtyNYjDO0lLFPV71j3o8xgz2xJw8tauG875TLSEjI9f/17n2W38KTjA/hTQ35EgILznsbRRUN8zpwIo36IEXjRVUcXtR/bxA86RwFZvtW97Bs6pB0fMGZv6yYn12qcCfjdMZovzhgCYv/YqOGZIwA/0NBPhzCiKAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BnpTl+qe; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740171269; bh=58EltJZFsCU8aZUzAHqmLuNtUZ64iWCEQUx9AvudAHY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BnpTl+qe642cR3xXVegn1UStRlHteqagCzZfMS/zgsiNJWXXYO31Q27HLW9SChB6KapXkOLQTrf0fZJT+xR0bwpKs8hYWCu2UrEEHNMYVk8GCIiDeNx7Dag4MgLPhDzSoXzyUFXJrSw/WIr8Z8cta0Kqq4JuxRjn2zdS6tp6++yHqgawo6FYyuTQiaDkKVf7dy/zaCyagGQH/1PXIzm2mRsoNWxIDeTFX0d0VU6HJ0b8qQiJZLR+1jHqolL+m5mxBqEARgeqd1Bj61cbFYFY+p7d3Jbzajk9CZRy2U+Hgy76KCS+T3OwrSQIBbpYOE46XuW8624sWztbLf4xeXCaeA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740171269; bh=SgTYnww6J3ursLoqHOMRz1oB8KTFtkqUuMqh9Yrks7Q=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=kZdv5/L/vQXI8CSIkjT/PtbdkL4dvYIsI8VZ7rGjwM45UP+v0DaoGHXO0XeJ6Mpskm+rkkdo85mxlcJDev65UULAnaHe/jz1m4Uygks7Ny4Gghp/1DwB1Ik8gt0B5nxI66deQ31F4HVEzfNbm+uUw1JihR+laeCO127i8gFPh1ubxag41MfhLHYEc5L2DMehH2eGwFukFxvt07ydMRkzDzDw33RLif+Tl+bIN5bsG+armVHuokvtjQ1U3SuBDiBPJUdVfahnQoWgaIXQ+X4t0HaO+GWApDZkNc+6VzlrkFrE0JimmVBGCYQJqRQbAZNJE47tuDAfGVM47Spgr2zGEA==
X-YMail-OSG: KyVtDucVM1kuqJ53DN99kSZwh8opZd4aQdzvbPMGxSZkqW2shDbx2NNqKOD7lBu
 bw3pQ7jHIQBNi1JA5tZs9PIxIKsx6W4Bk9WP41CoFiUAlkxlEQAcY1EWqP7Fz6JF6S2ofz75ogA.
 pXkz._t945mIVzx2DpnIJjauT8sYvNbdaz_gA.Eq22urfJ.fAj2aocQDAwQxYHYX5fRqXkKW4nqZ
 4dFZzqMo0gV7L8qYhAmC1YSbt.cUH7IKJPVshomSjlESHBGyX1UAw6eQM2fTo_TusShv1ALm6i2y
 vckVIcFlCA_h20cMXPwK_5CBit1UO45oTV2dL4t9oVSy_BIRVyqVW0EHJAxYX4_cmb0U63TDoy2W
 wKruTmxLycOwqEEeQ0_a_jDdtox_L6flnM0feIx_28GOneTxsrNagiIsdAKJOqJGxHP7CULQFiva
 RI.FULQvP.TDLMOqXrSo8HrlNCduyQIbXWBwF3yadSXh8_Z9FGFLysJ6IKwIkLmRq_CVuo4Om.Jg
 fRubYFEX2thPMKlbY748NHnSsYZGAAOlEOyV0QWuobhBV8h5N45Dy3meFqDPdlcsKSQsJZivwkKP
 3DpvJ6UiDZu6c1D2Ms64XBfyddtCR.w9OtcyOXcTr.Ftxj.oTZyqB5C5Gr9OoxtUL5uP.HA8en3i
 BpOfuMS2ikEj5UdwgwmrxnLNcTP3HOoYtpJ_wbmNHwULTEqSpZ16.i2NlvkpOowKbNtk_dfuRG_1
 6crRUM6.H8SRHQd70zSnYGQMQ70PcQrQy_5dpCv3_W.uZik7okubKCYk3hJKsZLvs19.8_QyA.Ok
 FSBIEmPGw7jP566_WIPxw9T83V9NdgDqhg7dLeq8PtvWJ5dsPOCb.5E7kTsapKIcn1gWNQbT7pit
 DKbWUAOaQnFy_N3AB85JubwiOxpE0X6OtI8QPVt_yCvajV2.G9kQ6RqLuU0mUKtS_YMnY4RD._OS
 CaVEvujL35Oq_RnMSEtb772Uu.LzHOxsOap5BAUwpAjzkKB4cYr21Ip8oqt_C4YmSHTmLWzvMQsj
 ya_UMU2BUl1chBlwYzRMIYdqX.I4e.wisHkwy6y.f4Ry.TBYw.M3Q85tUyE80W_WVKWXgyKXh8p6
 7HmdXmJOYdL8IAtNFe5dbEUIB8WcOpjG8JJEej2C1.i9jowletdiaD9jO1F0NttGQ6HO1kFuND2d
 .J2iHyjLwf8a65HqlnD.PM2NXk7Zl7Bhe_DGgfZ9ZhuWC8og2Q2GfSOvqR8memr6RngLVRVAtZz.
 XjI_h972j.yFiZEctcpvnrUXpLDCSdcK8eiHPp88CwXxxyhUyqY47wRiThv_fXdOlCp.JKrG5QA5
 GEEhY0veUbTzl15sFrMyu2Ot3cWrWnpHik01CKJLlDl2Y0k9ypPFaBMhwH.X_NAys2ugQf90mabL
 mixMzgEkKpY6OaFebi6elv1taVSGD2zlDi5ZxX1X_DBxUGE4RVXopk932cPWYIyCBl2fjm52FQcp
 cTZ8IBU1dHh5t35ACoasn9Q8NPPWoOd8wR8V9imv_g3Mt8sB0y8VRjvpdxLMr_GcpAWeQSQyXX_J
 tHgUP7ytiIkN4pHtSNx0Qsa3zgsF7Ol94SaT8sZCTtr7N2zEadWCmy64R.KJOf6sM.FRwouKkHl8
 9TUibgUUxU2_00yKIcSnBJmXawtvT3KDKVJ0fsCbocBBulfxVBo4KkIYJXsmjTrHS2BMohsjmW1Z
 Z3208Smgf.DJyQyT8GDo68eVRy9SV2motYJlE1wd_xsOA2pNl.zMC_8BQvtQZnRrTsqwtHBZeG0g
 Lu78Osl3cyPEtBbklPXZc7Ge2H7QqYHMP8eCR8g6unMv7.1cl6TjPKrgnIYFJLTBGqVHH1heQzV2
 jm2SPokKRlsUq4eAccQj44mD5EVxZaTXYnpPISrjNFf1e0Rk7Ig78KSxJ2rPm1OY.3n9Em3dGpLh
 p.SLu.xWqX_8gUhV3uWi_wpGQQc.0Akfv.gisOpE7CJrVKFqlewkY1_.JIPOv9WjiGIQLxdDv5P2
 CpcsThriA5yvgHZfMUM4SsgsZiCsgjJ0XdifN2X9x74a0Z80dkgF6Zhnn_0r4_0dE3EAmv_tgJSs
 CtHaopyHhW36vW80TfihRKidHmEpZuVDHHg0UoH5VEvuKxdCaurFKhbCVPxRF0WlN7BSDp2vFDz_
 _8KiMudMe8BecxpDUMHZnSqytdScwxPn2kwFMvCH779Aomj2LVf9XNUZvkYcuBVCw0WZMtZ5Q6G9
 FAe0by1.64.EAiekOWcwIO_oLZ8lrwbgQExOrYzaLdxGfLFy0IFFi_F0.X_UZECi33B.JfjSffrW
 syVz.1w5_
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3fdb93d4-fbd6-41a4-bab9-f5673e6464dd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Feb 2025 20:54:29 +0000
Received: by hermes--production-gq1-5dd4b47f46-5kxd4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a425192b73c64d1fdd3d2993af74dc83;
          Fri, 21 Feb 2025 20:54:24 +0000 (UTC)
Message-ID: <4607b306-d273-4190-9e3f-4063392cc6ef@schaufler-ca.com>
Date: Fri, 21 Feb 2025 12:54:21 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm,nfs: fix memory leak of lsm_context
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-nfs@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250220192935.9014-2-stephen.smalley.work@gmail.com>
 <CAHC9VhTXzweNA+h37ZBMjymbuar32tmr4aa9Qphk8JM4ya+y0A@mail.gmail.com>
 <71543c38-0103-4256-9553-04320b3403d4@schaufler-ca.com>
 <CAEjxPJ4+0HvbvBx6=XfMzD4uo1T2WHEFCZfGzt89X6CHB3DdcQ@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ4+0HvbvBx6=XfMzD4uo1T2WHEFCZfGzt89X6CHB3DdcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/21/2025 12:42 PM, Stephen Smalley wrote:
> On Fri, Feb 21, 2025 at 3:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 2/21/2025 12:10 PM, Paul Moore wrote:
>>> On Thu, Feb 20, 2025 at 2:30 PM Stephen Smalley
>>> <stephen.smalley.work@gmail.com> wrote:
>>>> commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
>>>> did not preserve the lsm id for subsequent release calls, which results
>>>> in a memory leak. Fix it by saving the lsm id in the nfs4_label and
>>>> providing it on the subsequent release call.
>>>>
>>>> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
>>>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>>> ---
>>>>  fs/nfs/nfs4proc.c    | 7 ++++---
>>>>  include/linux/nfs4.h | 1 +
>>>>  2 files changed, 5 insertions(+), 3 deletions(-)
>>> Now that we've seen Casey's patch, I believe this patch is the better
>>> solution and we should get this up to Linus during the v6.14-rcX
>>> phase.  I've got one minor nitpick (below), but how would you like to
>>> handle this patch NFS folks?  I'm guessing you would prefer to pull
>>> this via the NFS tree, but if not let me know and I can pull it via
>>> the LSM tree (an ACK would be appreciated).
>>>
>>> Acked-by: Paul Moore <paul@paul-moore.com>
>> If you like that approach better it should use a lsm_context struct for
>> the nfs data rather than adding a lsm_id. Would you entertain that change?
> I had considered that approach but doing so would require changing
> every user of nfs4_label to use the lsm_context fields instead of the
> current label/len fields (unless you are going to duplicate/alias
> them). And not all of these originate from an lsm_context IIUC.

Sigh. I would like to disagree with you, but I can't. You can add my
Acked-by: Casey Schaufler <casey@schaufler-ca.com>

>

