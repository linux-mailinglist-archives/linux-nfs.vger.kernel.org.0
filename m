Return-Path: <linux-nfs+bounces-23142-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T/+wB+xPTWrNyAEAu9opvQ
	(envelope-from <linux-nfs+bounces-23142-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:13:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E071F0E9
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 21:13:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="TpavXi/R";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23142-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23142-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 220ED3012CE4
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 19:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AA33A4F34;
	Tue,  7 Jul 2026 19:12:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4866D37AA99;
	Tue,  7 Jul 2026 19:12:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451525; cv=none; b=WqdEtNlujbKTGCsZNmyzxboTwHGc+FRL9A4kYz3mH7QEqhjdc3xQoX3bgu8rebGlea20lQ6hoRubM9WxKGwYufitwQ3hcSFp3yUNJGuKWyCHJfLExvjN+xdcoLCQcaGtFDj7qlsOVodAhF3o/1euaw6G+GdH0EtASSNi9YvWmTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451525; c=relaxed/simple;
	bh=44VKvjn3zH+ed8C5+r9SHoD//b0QOuNFQuKtucXSpd4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NZ75Hqa4Yv/PYIXYDM3/Sq6fSO2TM5knms90vP/kJODTakcEzOfqP9lQXXEg6gAZDKDILOEYAlGY0e59yIA2IfgTUY1uIFea0w4y3v9AvMRy5zb6Fr63EYUA3knE8J41kerDk9d7Nf8N0PXSdnQAKGKkVYczhrZYJvkfA7drhr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpavXi/R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C1D1F00A3A;
	Tue,  7 Jul 2026 19:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451524;
	bh=uZGM/aRa0R9k1x7/pFopPs9j32SFQ8orVX71ypPevUc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=TpavXi/R7P8S8dqydExT9QjInD0Tv0ItzC096QAE0qpP2bAkT5ZlX3tWD0DXC6DZv
	 FdlIWEXidZhF9lCt79LlslOGRxeS5jUDxno8nQNruqhB+lgbwb0TiMsrbEmfbgNK9i
	 mRXPBuDZ1dREr19d6YZIUp90d1qUMWowKtfNVguMJYLoE0aSraShKab/r+zhMB93WD
	 1Alazl2ODJt9C6PyLOLnhQa2eXz5qDlH61GPZk3hGrZOXdCeODTpzv2b6ekMFuKCiO
	 29Nvaj0G94J4Dn0mNed5+RoVJfKFNwP6wi2kRtE1DasTOxSUV7N5IJ9aplred6tIEm
	 YvMoWYTk/jsSA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id F1FDDF40071;
	Tue,  7 Jul 2026 15:12:02 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Tue, 07 Jul 2026 15:12:02 -0400
X-ME-Sender: <xms:gk9NakqULcx44AF0MUUWLTahEqp1wakbYAIPOTuVtTxKj404NeOKhw>
    <xme:gk9NaldzaZ4_g0JruXg9ihGBhBosEudAQsvhpJeJ2l-WQ0RgcBABmORQPFOfAH-Wv
    LgmiC_bacCvbBLDW_Cx-7JQsd1RwH4fVdCRbkP1uWAP1PtrhLGoJQ>
X-ME-Proxy-Cause: dmFkZTGRmgKoH5201GbnSTNC/iwOx73IfpeCuhQvzJVJv+PKy6ZL6Vt8UOGq9G/2RHaanH
    gJQ+GxWCAQI9d+OsxMa5jI7GlQ3ZJ5lCq/t3QzT6Y122OgbHVVr3/SZxZ8tRhUVdQsm6X/
    COItR+/ReOZoplYSJHeTtBPD/XO9QwB0AY7M8C9Ts3JudJ+KiIS3bi3zH68ivdcqDzljxH
    q/age6fqtwjZut1LSkAYz7Ak1SK5I7U7dmQp7pqkl+xyZV0eAwLFURVi/hP1tsIog2wXwO
    LLiLw4cx4XzL85Q2t54Uq2Uw1D2HOPPHY7d6vzF9kb2qxtA0VeY4WwRC24B//lByDOGQf7
    zEl2/b1G5Dox4JV8KnI3V5godkJSrEugKrn0t+e/RCfwukIR9CDw8Kx8UHM/XEblqLB/9L
    OB0RMqMBlC8Gjn9K/4RhHEmCDVUqd23Eq0wzfQMetv2l+Fd3woKmqCvxSHN/UAidA6lMj/
    qVyoWMoFgvLnORE0r+Xe7ah1tW2JSP2gbcPQQV13fgBU6AjUFqVKk6vqBq5pt8jmsReiAH
    aV45FKVo8SeHLRUFDrhlYZwKpwJfex0RfVX8JoQ75FTT+Zs1DHeMHk6Kmt4J3ddO+uRQpN
    yJJD5H3q3IUalfhrIH+7TuixH0mvUrWuZ3ETiklzAz4kcR1LIVr1kq+Sll8A
X-ME-Proxy: <xmx:gk9Navtqi7VuTAQaAzeaStgQYs9mtpD15DU_2vP3AYjcVlwoA0km4Q>
    <xmx:gk9NavgJR2YNgMvnQKPzVUPnJVbxxqQEkU5-sbjLCWJwtFFt7zYixg>
    <xmx:gk9Nao_MYDPuc_Zti540RcLV1xL6DyW63rBLbho_SiLr29yUUdsSEg>
    <xmx:gk9NaquwvOIspOWI-ECROEI2IHy7e_ki8OZ2JUqTjq6txKcP7_8rqw>
    <xmx:gk9Nakpp82Bv9dwcgja2tvPZzucI3kPCo_TIZtvtMhN-2DhpGaLFWWYx>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C9605B6006E; Tue,  7 Jul 2026 15:12:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ai_QtJ2nJmQs
Date: Tue, 07 Jul 2026 15:11:42 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Paul Moore" <paul@paul-moore.com>,
 "Achilles Gaikwad" <achillesgaikwad@gmail.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>, stephen.smalley.work@gmail.com,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
Message-Id: <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com>
In-Reply-To: 
 <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com>
 <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23142-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,paul-moore.com:url,paul-moore.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,app.fastmail.com:mid];
	FREEMAIL_TO(0.00)[paul-moore.com,gmail.com];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:achillesgaikwad@gmail.com,m:trondmy@kernel.org,m:stephen.smalley.work@gmail.com,m:linux-nfs@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D5E071F0E9



On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> <achillesgaikwad@gmail.com> wrote:
>>
>> A call to listxattr() with a buffer size of 0 returns the actual
>> size of the buffer needed for a subsequent call. On an NFSv4.2
>> mount this triggers the following oops:
>>
>>   [  399.768687] BUG: kernel NULL pointer dereference, address: 00000=
00000000000
>>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
>>   [  399.768722] Call Trace:
>>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
>>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
>>   [  399.768731]  nfs4_listxattr+0x21f/0x250
>>   [  399.768733]  vfs_listxattr+0x55/0xa0
>>   [  399.768736]  listxattr+0x23/0x160
>>   [  399.768737]  path_listxattrat+0xba/0x1e0
>>   [  399.768739]  do_syscall_64+0xe2/0x680
>>
>> security_inode_listsecurity() (via the xattr_list_one() helper) now
>> decrements the remaining size even when the buffer pointer is NULL, so
>> in the size-query case, 'left' underflows to a huge size_t value. As a
>> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a real o=
ne,
>> leading to a NULL pointer dereference in _copy_from_pages().
>>
>> security_inode_listsecurity() does not return the number of bytes
>> it added to the list, so the code derived it as
>> 'size - error - left'. That is also wrong in the size-query case:
>> the generic_listxattr() contribution is only subtracted from 'left'
>> when a buffer is present. Thus, the query result comes up short by
>> exactly that contribution (e.g., "system.nfs4_acl" on a mount with
>> ACL support), and a caller that allocates the returned size gets
>> -ERANGE on the subsequent call.
>>
>> Declare 'left' as ssize_t, use a scratch copy to measure security
>> hook consumption, and only decrement 'left' if a buffer is present.
>>
>> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_list=
security() interface")
>> Suggested-by: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
>> ---
>> Changes in v2:
>>  - Use a scratch variable to track security label size directly,
>>    replacing the old formula that undercounted the size-query case.
>>  - Drop the now-unneeded NULL-buffer special case for
>>    nfs4_listxattr_nfs4_user().
>>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
>>    (the same accounting bug caused both the oops and the undercount).
>> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achillesg=
aikwad@gmail.com/
>>  fs/nfs/nfs4proc.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> [CC'd the LSM and SELinux lists for visibility]
>
> Unfortunately my testing was unsuccessful due to an NFS problem that
> started with the v7.2 merge window that I haven't had the time to
> bisect yet.  Assuming the NFS folks are okay with this change, I
> figure they will want to send it up to Linus via their tree, if not
> let me know and I can send this up via the LSM tree.

Yeah, we'll send it through the NFS tree. I'll be curious to hear
what problem you're hitting, and what patch is the culprit once you
do that bisect!

Anna

>
> Reviewed-by: Paul Moore <paul@paul-moore.com>
>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 1360409d8de9..a3415082d610 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -10585,7 +10585,8 @@ const struct nfs4_minor_version_ops *nfs_v4_m=
inor_ops[] =3D {
>>  static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, siz=
e_t size)
>>  {
>>         ssize_t error, error2, error3;
>> -       size_t left =3D size;
>> +       ssize_t left =3D size;
>> +       ssize_t left2;
>>
>>         error =3D generic_listxattr(dentry, list, left);
>>         if (error < 0)
>> @@ -10595,10 +10596,13 @@ static ssize_t nfs4_listxattr(struct dentry=
 *dentry, char *list, size_t size)
>>                 left -=3D error;
>>         }
>>
>> -       error2 =3D security_inode_listsecurity(d_inode(dentry), &list=
, &left);
>> +       left2 =3D left;
>> +       error2 =3D security_inode_listsecurity(d_inode(dentry), &list=
, &left2);
>>         if (error2 < 0)
>>                 return error2;
>> -       error2 =3D size - error - left;
>> +       error2 =3D left - left2;
>> +       if (list)
>> +               left -=3D error2;
>>
>>         error3 =3D nfs4_listxattr_nfs4_user(d_inode(dentry), list, le=
ft);
>>         if (error3 < 0)
>>
>> base-commit: 6eb8711ece2ce27e52e327a5b7a628ed39b97f45
>> --
>> 2.55.0
>
> --=20
> paul-moore.com

