Return-Path: <linux-nfs+bounces-10280-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00E9A400D2
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 21:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6E9440DAC
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 20:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A556253B4E;
	Fri, 21 Feb 2025 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SLlJd9r/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCD253B4C
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169621; cv=none; b=QRIN8djLHIpV/Qymtq+/iJoO2diMdEK2cDUrw/oU7htlWk3VvS2IRyzK5AVW/ylzrSYkprzBT1glSMopB1y1H4bWjoQKVXvYjkb9K8q2msCohxx2mLsq+m3HVkLoojVl1Oxkt8Jfrh0HD774Rl2tM6SrWxJwfNncW6otutrjLnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169621; c=relaxed/simple;
	bh=MRYJ2v01posqH4xJInkM8T8C0+X6rnXMYheEecFS2nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0UzznoCYfL2mGR2nR7xZ/1P4E+0qr60WOyRjpdkDMEv/A1oaLlq+RMjVP3ShXR0ZVjfGajuqFQ1xgUxFVOzDCzvVFZRWLEYFpuLzRDC9lypK74TbEkzkG0zOuWHO4q7sLa/ot03Vjq9uad0IvoaX9wtfbzVO455Ce4G1bzrYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SLlJd9r/; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740169610; bh=G/CoxvcYGaK7mPGM7GYL8Q4TeKpFM2hiMZJIIXSck00=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SLlJd9r/OfPEIUq/53aaTgLVWI9k3OOWHeANtjfZElBUrTupFr0hZzQnPnF6uPj1urSpTG0CMpIpcD5nHHTNBWi9hiheaGKWnbd6fHpFp1tRAviiZmlCWYmLDTPrg68L/WgWlhQFIQ37NcpP5ks8LAbLIaLsysymy6QgTy2yZGs/YYKgfUZ25/yZFXMuK/LLCjMUVqJakpYwOxxJ9VzCT7Zv34FsAwNit3nyhU47zteY5WIhczVXU+nK5vLNvmmcctVJ0Bs0TgzUdzKcam5iqkIXYwY8Bx8pzRz8pj5WI21tX0EMRwgNzNZHQ/JywnEzhplYvMcuvSPEpgQ4I7yXhw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740169610; bh=488CxoBEaBo8mQNRjRqAXH1IedgevDFI/funiUTF0Xb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TOPGG170aa0uBFbW2Z9VFr8Y9yfJ2rITU9xYjs95PUrYklzmBGaMflj5usU7R3G0tOOND7QL0yKoggp+NwwytCbMZ6zQLk9paGkY1lupk6BY8oWUju5us6LaC15Immoz6YAtEU/s1IviqokJcyqNQy75i+wz02Ppr35bLjRljedhuY24iRbqzW7YsPlwJqVQURUfwGDYUi5RfO0U+tI8XM6ZfoxSQnmrgCndp+V/WBePbX3PDICP7sf2tjf+ZWwP5jvPmUO6zhSVWhqyTuhLoxRuCZEPhPVAILMXF4Gv0hh35WUl9RwRCoe4d40WdVnUBVUnwDwo0ivC9RCHoVjlSw==
X-YMail-OSG: hgpN1tMVM1n1SquUeXn3iMbdqD74G7ZuCTRV4xxNvVbcbtEYkOLc8iwuROUnj05
 S6L0Uk8u4XiQPuzKrIeupWKO8x7RGONzV2JDG7naE1lHlg0IVhI73gkvkajjoFI6DoQsis6rMsto
 jKwX3Fa_FTdRRIOARY2EJbG_vgiNtpmCUURELKkxs9pdXAt9eH7BjqZcFs_Pg0ZTnOPiPlIPH7rx
 DG0MOnNUiGlSRBuzE_8BiBf4yC4j0EbvH4fVLTpzmXwyzoAiteuIIrThpR.LRHGf1mMANSWmdJ9H
 Bz.bEO9k1Z_MVFGWzc_YcT.saLRcQY3A7qmstCu3jXdy24K6yBcGxAwzs4iRsMzLtxoip8BFOQPN
 PHxwt76pZet0oM50fG5P1cQAuDcAkJ5aeIFRHYGcqMPL6B9c5axZzAer0E1fj9bspXkpsXXrlsTr
 jMpLJF0CkP3Mh4cKsrqNFshekGb2PIiAQiWBK9RUmddr9Jm445Cy5qBVZS8EMDC3pxGjPDBfs9FX
 yuRCUGZhb2fh3tUWzPCaoYP3JcUcYOEn9u7wFhRQ.5pnxAr9ZC7rbmQI9N8B5QZQhAupN4LAZQmm
 psHw4uDpaWEP7oJ3Oah5K_Hm0kOh4VuLb6HNkX2TmaZef6VwnDtJK9zj6QTmoSxHA7VefspwjrW9
 AIClG4ixQfUawqh5YPuvW_UWTlBJ52u2lFDmZCLO_Im9aLBcMExDtCP0D05bQxznePdBx5ik_ScT
 v.GXLOVdO0ZmY.teLnY6jSp1tlCs8BMprjdXw5yS7cIv9p5izIevpu5N.s2eH86aDWdX62zW.Nox
 AWmWl8gm.Y6RZ_Pbel3K.p5HbympCznP93PRLpEHDpuRMGHnrxTLzm_wgXdCN0awHoaEPEM4Loto
 QIG6e5pOans4Mp84wIqcKE._54LksWna6cYwQphbv.XJUwL51FNAYmoDIkD4NMPxNcsIWvHUbNN_
 okfULCS4LIX2Pq.zfAgarEniDsTtaYDdKjk55hRWZ_OURCOjVoUw4OiGOIYExSG.bV7TRHO3Ty0v
 zy8VVBJYTl.x_sMi.tPVuNRnJh0h..G414b0Kvm0OmzcQnnKHAqIEqCgCq97Uss1WS3X1Tk8bMiL
 c0LgymNw2luDetADaaD6oioPE8rHLVozkHc17hqI3Q0COCrVZcmKI_eh5Av7t2atR0uIUNjYphqa
 qlncPFoeAQkDME2_B3WdTNdFnCQ1tOGIflJPQnBGiY3yLIqSw8Yh8lO6leXx_XtiskgZd4_.X7u9
 b8rQRZz5XLgbJWteppB.7HNduceoST9XJyN99vLGWwtrxfucSpv0qdQLZWgFb3ahZrpFVqHk7txj
 SkWOMIVAUVt_qqCrFjZh0c_yD6v9Fa0RH9z5AnU7iHXKktOBtg8g.GOfiHjs6goOb_oemoICdpfM
 sBHwbB59kZTwVYxawOGXIt_Refj686uJHJ.EjlCQIe42m0upt1gxiEtqSZIq8rxo0.EOjonmkpD4
 KkYQUahzlZpns3WYddrADRE7zEmv5naAfEMFoHKHGWGcUObIj6C8gkG1766r_zhhhYJNl8XK6qS_
 wuVfit0VyAqYaaNJIRyTV3vpeRP5stejTBhI3HS0ts3dxBe7QLZVV0KA8sTTe3C5919dG8I6r8yq
 r0zAfvpIhPb_yiaM4cvV5bqRTVzUZPrgq2K7BYgKlDPOHrAdStncwr0zUN9.g6PwgB_gAZEw7ExK
 p6bGOjJ82x0av..BhqaQauKu4w6vT5VgqAwMa5dt._l6QLMvmtgRp1artkstaFgCFhFGRBYLjUWA
 DkaWiMVgNTe2MAsaJkUeVRe3fK3hcDcHTRud6.NmdXthzTgbDWgCW52CaL2hKk_MkxMVnO0ziOPx
 SI8wsL9XOwu3Hl_zFA0HaiJGRFITuxoA5CgyYLuI8dqmiudQxYm74NBtc2H6p1C4LCQpkj6wLAQ1
 UB8Op05n_D5sdh8BWBHxxghW.D1JrZL0URz7TOnWVdrHiOgY54w_3TCvOBlctiIBoUSnCSmz0.lN
 X.ELv6FwmxtFyeLquHimHMCJGyVli.frPdVbR.xOmR3SQFAcHAdj0NZ7nBt6zJ18CjKeJH7YqdTO
 WKwlQrq6QjRFJt7DuP.WTMUdMsDu85WnvnDiXhePeMZ8BEZmmuMwDLd6JDPqdQpd3VNuPA5epy10
 t05bhY6Qm.vHmHSJkZDW4gxx6MwDjF7iUCtvz2pwbeIhcY58xEggoM97HhBAtyRUFBxuDYW3UHXn
 Hf.fbqoIwJuC8tAxYxabPgFuAO2CfLy3WQmHdPpI4vyEG7akekh18kAYQZD2_jnvcNeROLPhAaRM
 l0ULLNV5n9EXqROL8
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 07289484-c522-4102-ba21-356d0e318f80
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Feb 2025 20:26:50 +0000
Received: by hermes--production-gq1-5dd4b47f46-fhdpd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 395a3326f26132392acb5c31e0c50d28;
          Fri, 21 Feb 2025 20:26:47 +0000 (UTC)
Message-ID: <71543c38-0103-4256-9553-04320b3403d4@schaufler-ca.com>
Date: Fri, 21 Feb 2025 12:26:45 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm,nfs: fix memory leak of lsm_context
To: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250220192935.9014-2-stephen.smalley.work@gmail.com>
 <CAHC9VhTXzweNA+h37ZBMjymbuar32tmr4aa9Qphk8JM4ya+y0A@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTXzweNA+h37ZBMjymbuar32tmr4aa9Qphk8JM4ya+y0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/21/2025 12:10 PM, Paul Moore wrote:
> On Thu, Feb 20, 2025 at 2:30 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
>> did not preserve the lsm id for subsequent release calls, which results
>> in a memory leak. Fix it by saving the lsm id in the nfs4_label and
>> providing it on the subsequent release call.
>>
>> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> ---
>>  fs/nfs/nfs4proc.c    | 7 ++++---
>>  include/linux/nfs4.h | 1 +
>>  2 files changed, 5 insertions(+), 3 deletions(-)
> Now that we've seen Casey's patch, I believe this patch is the better
> solution and we should get this up to Linus during the v6.14-rcX
> phase.  I've got one minor nitpick (below), but how would you like to
> handle this patch NFS folks?  I'm guessing you would prefer to pull
> this via the NFS tree, but if not let me know and I can pull it via
> the LSM tree (an ACK would be appreciated).
>
> Acked-by: Paul Moore <paul@paul-moore.com>

If you like that approach better it should use a lsm_context struct for
the nfs data rather than adding a lsm_id. Would you entertain that change?

>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index df9669d4ded7..c0caaec7bd20 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -133,6 +133,7 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>>         if (err)
>>                 return NULL;
>>
>> +       label->lsmid = shim.id;
>>         label->label = shim.context;
>>         label->len = shim.len;
>>         return label;
>> @@ -145,7 +146,7 @@ nfs4_label_release_security(struct nfs4_label *label)
>>         if (label) {
>>                 shim.context = label->label;
>>                 shim.len = label->len;
>> -               shim.id = LSM_ID_UNDEF;
>> +               shim.id = label->lsmid;
>>                 security_release_secctx(&shim);
>>         }
>>  }
>> @@ -6269,7 +6270,7 @@ static int _nfs4_get_security_label(struct inode *inode, void *buf,
>>                                         size_t buflen)
>>  {
>>         struct nfs_server *server = NFS_SERVER(inode);
>> -       struct nfs4_label label = {0, 0, buflen, buf};
>> +       struct nfs4_label label = {0, 0, 0, buflen, buf};
>>
>>         u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
>>         struct nfs_fattr fattr = {
>> @@ -6374,7 +6375,7 @@ static int nfs4_do_set_security_label(struct inode *inode,
>>  static int
>>  nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
>>  {
>> -       struct nfs4_label ilabel = {0, 0, buflen, (char *)buf };
>> +       struct nfs4_label ilabel = {0, 0, 0, buflen, (char *)buf };
>>         struct nfs_fattr *fattr;
>>         int status;
>>
>> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
>> index 71fbebfa43c7..9ac83ca88326 100644
>> --- a/include/linux/nfs4.h
>> +++ b/include/linux/nfs4.h
>> @@ -47,6 +47,7 @@ struct nfs4_acl {
>>  struct nfs4_label {
>>         uint32_t        lfs;
>>         uint32_t        pi;
>> +       u32             lsmid;
> I don't think this is a significant problem, but considering that
> lsm_context::id is an int, the lsmid field above should probably be an
> int too.
>
>>         u32             len;
>>         char    *label;
>>  };
>> --
>> 2.47.1

