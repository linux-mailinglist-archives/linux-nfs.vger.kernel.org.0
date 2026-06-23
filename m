Return-Path: <linux-nfs+bounces-22793-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5TxZBCrkOmo7KQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22793-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 21:53:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ADB6B9CA5
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 21:53:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=a2bTDQ25;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22793-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22793-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F7D93010B82
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 19:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA8930BF4E;
	Tue, 23 Jun 2026 19:53:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FC3939B6
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 19:52:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244379; cv=none; b=tiQp7qoZkYV3nAYKNlvgKwo7OH6Da/qBqCrQydWOOrmuPaJhydqKpu9VdHFLU23bWBMedxm91ntmvOTstcqB7nr7UreOPvWY+n+5McjHbQ2Iz4v46Uy445xPbu0KfmnV2bksrksBoaB9aVpj3ItaE+XprKcJq0OGPQj55MBCwRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244379; c=relaxed/simple;
	bh=COaA0CAq0uDzZI/TLUxiOJfNJ1hFDNcNwYPA1V9azw8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jwY8N3H3EHrvTF/1/oMtWxY9Z0xV2PB1ZLArqZbHv0uZz7XtTp7bn3m9ha/xQC8DHVrZdEYfJaSbiU3Jo2b8zWcPDFTubSGMr/HJhvFRzhH1IEt13jPe0OAs4HPBOr/mAqhljWOg7ypfQy0F0FGsy79psy/4r59Hcd/D3h9YRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2bTDQ25; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE4D1F00A3A;
	Tue, 23 Jun 2026 19:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782244378;
	bh=COaA0CAq0uDzZI/TLUxiOJfNJ1hFDNcNwYPA1V9azw8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=a2bTDQ25OtNOl3uRaqotVmcSvDYeZvPMcu4WKz5g+h2knV+CiupKQbXgAZHiGMwqc
	 3OnvYoWTNaSptl4613U3/DCI3IC43dLUwXkH6tNRsL/g3NwgYfLKYHzIy4hm49H2Gh
	 DPE6nt9ONZucTUmhdJPGNMbGomQsvtRMA/6OmOrBTxGv70NGla3XCCrOOb9zwBYWgB
	 otAZTy1q5jLzKD3zD9hBIHHE94aD7THrMfkRotkVR+kbn368jxF6O1rDgV1iHEmff1
	 zLA2THFFK50wii5oNE9mmI/3C1B5wf4nsDRNhAGIJccgkZ5HDZiK3YEHdyu94N0BRq
	 4SGTOL42ukB/w==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5399BF40085;
	Tue, 23 Jun 2026 15:52:57 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Tue, 23 Jun 2026 15:52:57 -0400
X-ME-Sender: <xms:GeQ6anWvoMIUIOopsy2QqC_OfIHYd9GbuQkspBW1y5OKbb8SVohemQ>
    <xme:GeQ6aqameE0tkGsfteNoM80HwDfhLVz4VZZ7yIAEHjcLuF8KtCQMyxT3Qrvp9ebFZ
    -kV3zMWlrx40vSDiAdzfHx9iPsKlUXxTNbKrMAV9J5P2FKWdnmNqQ>
X-ME-Proxy-Cause: dmFkZTF5PF0Jl3shlwDNXYhFT2lcy4coMZumzMJIgKbL6yG70n6B8NS1ojXnTfTVuSUiE1
    on9YNWDaPM8IHJksXYf2lkCMQqcJAmpJdX9AxVBhO7ESpBX3dyLmVTSBsiRDgnob2wQS5w
    SBV73cKdYNkIp+hn0INmj3Xn80+JY8NOHZ98GtBKbeGsNKdlfkagB+dkUqQCH+p6LKAc52
    XLDuFitLwOMYFY1DCDtWOOznwcx+45a7BcU2/q7ruI0qLRUiA2KXitvqwJVCRgA2soGB6f
    3zDRgNWPcZc0T6M8NYVTAL+ihcX0fnDQ5uMJCuJl+Y5rr049C8Rzt4/f4pWyYtxYKqZjL/
    PPPSqe+8WAcjYiXv5sQE7cUeuGEI24bnSNYEMvXiTmdncPOZytVci+wabRRL8A2VeLHUY5
    lUxBszA/rqvzFAet6EVrnznVYdY4bzSlSQAM8kuoXAyKMfd4ARf+f2TphQKFy9QYpby+N5
    MBoh92sSNOsg+ZIYzpSO8Pb7I3AgHCaZo394FH6BOqHFPDATMul8XTfoJO25vj5R/EKzxI
    i841I13vApC2m8Ihx10ehczToXdwg6HEU8V64REtrmAk7Iv+Ag04OOJXbZ1HpPdIOm4R77
    uXYi+mkmoR7QLHLDZcZUO8m9ZI5wNdkPf6Uu1NGEa3tfpIxJ/9f/JYiOPaUA
X-ME-Proxy: <xmx:GeQ6aqeqyTqLUaeE0v93TBQwblQ9rwGjONUlBaIJ2hZmu5HQ77-g-g>
    <xmx:GeQ6agAeVRiomhOaPS5QO7Q1-raPKlrTheHF0f69p8oe_22vA2EY8Q>
    <xmx:GeQ6am7_gkWgXfwOQXWVDvgHMxVHIOC1UpKTX5Qmawren6qhP83hjg>
    <xmx:GeQ6ahfTWVoPVKGWjgqSaezYFtPEoYN6tyu44LuVa1yBfSg3WBSZVQ>
    <xmx:GeQ6akshpP3rE-xe9t-wOxQLSZOa-59x9zzF9r39AfYA52CECrmBFkCo>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2FB3BB6006F; Tue, 23 Jun 2026 15:52:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Apl2SExQFExw
Date: Tue, 23 Jun 2026 15:52:35 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: yangerkun <yangerkun@huawei.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huaweicloud.com, lilingfeng3@huawei.com,
 zhangjian496@h-partners.com, yi.zhang@huawei.com,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-Id: <261c255e-2cc5-4f27-8239-e708f1c9f95a@app.fastmail.com>
In-Reply-To: <9b27efad-f22a-45b9-b080-1552acf50016@huawei.com>
References: <20260226012203.3962997-1-yangerkun@huawei.com>
 <dcf0b02002857a6be502e372ebb3e175412d7184.camel@kernel.org>
 <163aebb3-4233-4aaa-872c-c36aa3fcb3af@huawei.com>
 <403e3267-70ef-4fb3-9700-0a14d28abc4c@huawei.com>
 <9b27efad-f22a-45b9-b080-1552acf50016@huawei.com>
Subject: Re: [RFC PATCH] nfs: use nfsi->rwsem to protect traversal of the file lock
 list
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yangerkun@huawei.com,m:jlayton@kernel.org,m:trondmy@kernel.org,m:chuck.lever@oracle.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yangerkun@huaweicloud.com,m:lilingfeng3@huawei.com,m:zhangjian496@h-partners.com,m:yi.zhang@huawei.com,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22793-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-nfs.org:url];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59ADB6B9CA5

Hi Erkun,

On Tue, Jun 23, 2026, at 3:37 AM, yangerkun wrote:
> Gently ping...
>
> This patch has been reviewed, but leave alone here for a long time...

The patch is in my linux-next branch right here: https://git.linux-nfs.o=
rg/?p=3Danna/linux-nfs.git;a=3Dcommit;h=3D4837fb36219e6c08b666bc31a86841=
bad8526358

Anna

>
> =E5=9C=A8 2026/5/8 16:33, yangerkun =E5=86=99=E9=81=93:
>> Gently ping...
>>=20
>> =E5=9C=A8 2026/4/16 11:01, yangerkun =E5=86=99=E9=81=93:
>>> Hi Anna and Trond,
>>>
>>> Could you please help check if there are any issues with this patch,=
 and
>>> if there are none, could you help merge it in?
>>>
>>> Thanks,
>>> Erkun.
>>>
>>> =E5=9C=A8 2026/3/9 22:09, Jeff Layton =E5=86=99=E9=81=93:
>>>> On Thu, 2026-02-26 at 09:22 +0800, Yang Erkun wrote:
>>>>> Lingfeng identified a bug and suggested two solutions, but both ap=
pear
>>>>> to have issues.
>>>>>
>>>>> Generally, we cannot release flc_lock while iterating over the fil=
e=20
>>>>> lock
>>>>> list to avoid use-after-free (UAF) problems with file locks. Howev=
er,
>>>>> functions like nfs_delegation_claim_locks and nfs4_reclaim_locks c=
annot
>>>>> adhere to this rule because recover_lock or nfs4_lock_delegation_r=
ecall
>>>>> may take a long time. To resolve this, NFS switches to using nfsi-=20
>>>>> >rwsem
>>>>> for the same protection, and nfs_reclaim_locks follows this approa=
ch.
>>>>> Although nfs_delegation_claim_locks uses so_delegreturn_mutex inst=
ead,
>>>>> this is inadequate since a single inode can have multiple nfs4_sta=
te
>>>>> instances. Therefore, the fix is to also use nfsi->rwsem in this c=
ase.
>>>>>
>>>>> Furthermore, after commit c69899a17ca4 ("NFSv4: Update of VFS byte=20
>>>>> range
>>>>> lock must be atomic with the stateid update"), the functions
>>>>> nfs4_locku_done and nfs4_lock_done also break this rule because th=
ey
>>>>> call locks_lock_inode_wait without holding nfsi->rwsem. Simply add=
ing
>>>>> this protection could cause many deadlocks, so instead, the call to
>>>>> locks_lock_inode_wait is moved into _nfs4_proc_setlk. Regarding th=
e bug
>>>>> fixed by commit c69899a17ca4 ("NFSv4: Update of VFS byte range
>>>>> lock must be atomic with the stateid update"), it has been resolved
>>>>> after commit 0460253913e5 ("NFSv4: nfs4_do_open() is incorrectly=20
>>>>> triggering
>>>>> state recovery") because all slots are drained before calling
>>>>> nfs4_do_reclaim, which prevents concurrent stateid changes along=20
>>>>> this path.
>>>>> Also, nfs_delegation_claim_locks does not cause this concurrency e=
ither
>>>>> since when _nfs4_proc_setlk is called with NFS_DELEGATED_STATE, no=20
>>>>> RPC is
>>>>> sent, so nfs4_lock_done is not called. Therefore,
>>>>> nfs4_lock_delegation_recall from nfs_delegation_claim_locks is the=20
>>>>> first
>>>>> time the stateid is set.
>>>>>
>>>>> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>>> Closes: https://lore.kernel.org/all/20250419085709.1452492-1-=20
>>>>> lilingfeng3@huawei.com/
>>>>> Closes: https://lore.kernel.org/all/20250715030559.2906634-1-=20
>>>>> lilingfeng3@huawei.com/
>>>>> Fixes: c69899a17ca4 ("NFSv4: Update of VFS byte range lock must be=20
>>>>> atomic with the stateid update")
>>>>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>>>>> ---
>>>>> =C2=A0 fs/nfs/delegation.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++++=
+++-
>>>>> =C2=A0 fs/nfs/nfs4proc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 =
+++++++++++-----------
>>>>> =C2=A0 include/linux/nfs_xdr.h |=C2=A0 1 -
>>>>> =C2=A0 3 files changed, 19 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
>>>>> index 122fb3f14ffb..9546d2195c25 100644
>>>>> --- a/fs/nfs/delegation.c
>>>>> +++ b/fs/nfs/delegation.c
>>>>> @@ -173,6 +173,7 @@ int nfs4_check_delegation(struct inode *inode,=20
>>>>> fmode_t type)
>>>>> =C2=A0 static int nfs_delegation_claim_locks(struct nfs4_state *st=
ate,=20
>>>>> const nfs4_stateid *stateid)
>>>>> =C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inode *inode =3D state->inod=
e;
>>>>> +=C2=A0=C2=A0=C2=A0 struct nfs_inode *nfsi =3D NFS_I(inode);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file_lock *fl;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file_lock_context *flctx =3D=
 locks_inode_context(inode);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *list;
>>>>> @@ -182,6 +183,9 @@ static int nfs_delegation_claim_locks(struct=20
>>>>> nfs4_state *state, const nfs4_state
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list =3D &flctx->flc_posix;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 /* Guard against reclaim and new lock/unlock c=
alls */
>>>>> +=C2=A0=C2=A0=C2=A0 down_write(&nfsi->rwsem);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&flctx->flc_lock);
>>>>> =C2=A0 restart:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_file_lock(fl, list) {
>>>>> @@ -189,8 +193,10 @@ static int nfs_delegation_claim_locks(struct=20
>>>>> nfs4_state *state, const nfs4_state
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 continue;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock=
(&flctx->flc_lock);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D =
nfs4_lock_delegation_recall(fl, state, stateid);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status < 0)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status < 0) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 up_write(&nfsi->rwsem);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto out;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&=
flctx->flc_lock);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (list =3D=3D &flctx->flc_posix) {
>>>>> @@ -198,6 +204,7 @@ static int nfs_delegation_claim_locks(struct=20
>>>>> nfs4_state *state, const nfs4_state
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto restar=
t;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&flctx->flc_lock);
>>>>> +=C2=A0=C2=A0=C2=A0 up_write(&nfsi->rwsem);
>>>>> =C2=A0 out:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return status;
>>>>> =C2=A0 }
>>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>>> index 91bcf67bd743..9d6fbca8798b 100644
>>>>> --- a/fs/nfs/nfs4proc.c
>>>>> +++ b/fs/nfs/nfs4proc.c
>>>>> @@ -7076,7 +7076,6 @@ static void nfs4_locku_done(struct rpc_task=20
>>>>> *task, void *data)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (task->tk_status) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 renew_lease(calldata->server, calldata->timestamp);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 locks_lock_inode_wait(calldata->lsp->ls_state->inode,=20
>>>>> &calldata->fl);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (nfs4_update_lock_stateid(calldata->lsp,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &calldata->=
res.stateid))
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>> @@ -7344,11 +7343,6 @@ static void nfs4_lock_done(struct rpc_task=20
>>>>> *task, void *calldata)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renew_lease=
(NFS_SERVER(d_inode(data->ctx->dentry)),
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->timestamp);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->arg.new_lock=
 && !data->cancelled) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 data->fl.c.flc_flags &=3D ~(FL_SLEEP | FL_ACCESS);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (locks_lock_inode_wait(lsp->ls_state->inode, &data-=20
>>>>> >fl) < 0)
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto out_restart;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->a=
rg.new_lock_owner !=3D 0) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 nfs_confirm_seqid(&lsp->ls_seqid, 0);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 nfs4_stateid_copy(&lsp->ls_stateid, &data->res.stateid);
>>>>> @@ -7459,11 +7453,10 @@ static int _nfs4_do_setlk(struct nfs4_stat=
e=20
>>>>> *state, int cmd, struct file_lock *f
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg.rpc_argp =3D &data->arg;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg.rpc_resp =3D &data->res;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 task_setup_data.callback_data =3D d=
ata;
>>>>> -=C2=A0=C2=A0=C2=A0 if (recovery_type > NFS_LOCK_NEW) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (recovery_type =3D=3D=
 NFS_LOCK_RECLAIM)
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 data->arg.reclaim =3D NFS_LOCK_RECLAIM;
>>>>> -=C2=A0=C2=A0=C2=A0 } else
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->arg.new_lock =3D=
 1;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 if (recovery_type =3D=3D NFS_LOCK_RECLAIM)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->arg.reclaim =3D =
NFS_LOCK_RECLAIM;
>>>>> +
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 task =3D rpc_run_task(&task_setup_d=
ata);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(task))
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_=
ERR(task);
>>>>> @@ -7573,6 +7566,13 @@ static int _nfs4_proc_setlk(struct nfs4_sta=
te=20
>>>>> *state, int cmd, struct file_lock
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 up_read(&nfsi->rwsem);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&sp->so_delegreturn_mu=
tex);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D _nfs4_do_setlk(state, cm=
d, request, NFS_LOCK_NEW);
>>>>> +=C2=A0=C2=A0=C2=A0 if (status)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 down_read(&nfsi->rwsem);
>>>>> +=C2=A0=C2=A0=C2=A0 request->c.flc_flags &=3D ~(FL_SLEEP | FL_ACCE=
SS);
>>>>> +=C2=A0=C2=A0=C2=A0 status =3D locks_lock_inode_wait(state->inode,=
 request);
>>>>> +=C2=A0=C2=A0=C2=A0 up_read(&nfsi->rwsem);
>>>>> =C2=A0 out:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request->c.flc_flags =3D flags;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return status;
>>>>> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
>>>>> index ff1f12aa73d2..9599ad15c3ad 100644
>>>>> --- a/include/linux/nfs_xdr.h
>>>>> +++ b/include/linux/nfs_xdr.h
>>>>> @@ -580,7 +580,6 @@ struct nfs_lock_args {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs_lowner=C2=A0=C2=A0=C2=A0=
 lock_owner;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned char=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 block : 1;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned char=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reclaim : 1;
>>>>> -=C2=A0=C2=A0=C2=A0 unsigned char=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 new_lock : 1;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned char=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 new_lock_owner : 1;
>>>>> =C2=A0 };
>>>>
>>>> Nice work!
>>>>
>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>>
>>>>
>>>
>>=20
>>=20
>>

