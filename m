Return-Path: <linux-nfs+bounces-18448-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I1OgE6obdmmNLwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18448-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 14:33:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 863B280BB6
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 14:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FCB430037CC
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCD02DF68;
	Sun, 25 Jan 2026 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ESVY+IZQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69C224F3
	for <linux-nfs@vger.kernel.org>; Sun, 25 Jan 2026 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769348007; cv=none; b=jk7xJizfUox77E4NUKjYBcjWs3ONXTSjKG7iFRWtyNLNC+vHAbgCor95MsgjlWuICgo17VR/vgHAqIaDV8Jvf40tINuKJn8UfLopb3cPgqbjgJMlSVAl8X0tS+oCiNQNVHbuQDgnM6E9Ztn1UmiRcDEmOv+n/gtAgLmKvX5JBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769348007; c=relaxed/simple;
	bh=lIaIljlAm3+5VpG/9ZPdHEFB2CKJ/br/ExDUw+jUJqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oo5l6KC4y8+6grvqpuR1imajU07lMqvmKziAQHc2u2umNOphch7C6FemyERkb9732txQZoh/k4cIQ/p8eWg2nEm2p84HBilVPDH5EWZkgXLyxPbfh4YWqlcur4JLM1KILpdZNy3oypY2MUBVU6dCMfNRl3GyneBiHpVaVSt+ris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ESVY+IZQ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60P7TEHe1504860;
	Sun, 25 Jan 2026 05:33:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ae5F5ju3HVsTloT9TuRvjydWFVEElhB1MvO78uDH7Ns=; b=ESVY+IZQn/ec
	gelDh1Rsyx+/UANdV5FJLd60OfctClCUgMZz90qnB8SErTm3k/otUQ+DNXgpea7b
	xAWHXPvQ5lvlo8sJNEjay3l0DNpMvDFCbT15zfzMUq8d6AqS47ZtrZ+6h3IuIbEj
	8/NoMqKOCrn2fTXPYGL13Yxa/+j1LcxlcAdKTx/0FYlxGtLZYiWB4RxU8JezmB6S
	8qlrOSQTV1ahE/btOhwoQS6vVHmG9Z30Z0lbebUSH7Fz+7syXwDrY3uTFQwCPzHN
	VgBCRK01KA1DY2eLZN3Z+8dZAIUUB6O/HP3xJnruQo6J/CqZpeK76CofLKyO/92p
	uRrNZ+1H4A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bvt93xg2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Jan 2026 05:33:19 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Sun, 25 Jan 2026 13:33:18 +0000
From: Chris Mason <clm@meta.com>
To: Christoph Hellwig <hch@lst.de>
CC: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 22/24] NFS: add a separate delegation return list
Date: Sun, 25 Jan 2026 05:30:07 -0800
Message-ID: <20260125133300.2723227-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107072720.1744129-23-hch@lst.de>
References: <20260107072720.1744129-1-hch@lst.de> <20260107072720.1744129-23-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI1MDExMyBTYWx0ZWRfXz371FmgOIAD4
 IgItkDahN2z9txEOL8LJbcJqKsU7x6rre2BFx1uEqjGUw/myoNpwlrBk3pzASRNO9Q6HCIsc+48
 pqGwQ5G28I/nZLWQEaXP1lKre/bK1XqAiOln5YLuSgsHTyyk+oKPdPhovUbuxPvK2CvWHHMT/75
 ZTDs1R/Lytp2eXGPEhAH44j510Ts524GQWrQDASsvuLeMI0IZkNhcEUj3BLr4WnpmNIxoYiOPpU
 auJFn+emnmj8BaqfCOlqdNcf5wshFCrzbecKn2IkdYTtA1aAkVlHjjMbaYXvqivN6qr6HGeXr5F
 TPuBMEPG/P5sNssPn1UZ8v1nIQdwinKXFKyHzlBmgxflr4rqYO0ncE3ITctWLfWt3B6ZgYmboZD
 cxZNuNVrclh7Wp3y+PJk4c7o0Q6QKy75ruHOH383l/jo/UGItFgCWEAtqki1N0z6lZGS0aV5ow+
 Xa/lvSSOun605a7X2YA==
X-Authority-Analysis: v=2.4 cv=HoR72kTS c=1 sm=1 tr=0 ts=69761b9f cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=rc_i4G9jLmr0IctmWxwA:9
X-Proofpoint-ORIG-GUID: y4auikv9HSi9pu8DiYuwMaTpG6_ADXJJ
X-Proofpoint-GUID: y4auikv9HSi9pu8DiYuwMaTpG6_ADXJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-25_03,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18448-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 863B280BB6
X-Rspamd-Action: no action

Christoph Hellwig <hch@lst.de> wrote:
> Searching for returnable delegations in the per-server delegations list
> can be very expensive.  While commit e04bbf6b1bbe ("NFS: Avoid quadratic
> search when freeing delegations.") reduced the overhead a bit, the
> fact that all the non-returnable delegations have to be searched limits
> the amount of optimizations that can be done.

Hi everyone,

I ran some linux-next commits through AI review prmopts, and this one
was flagged.  The spinlock concern looks valid to me, but I didn't try to
confirm the RETURN_DELAYED comments.

> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c

[ ... ]

> @@ -674,15 +667,15 @@ static bool nfs_server_clear_delayed_delegations(struct nfs_server *server)
>
>  	if (!test_and_clear_bit(NFS4SERV_DELEGRETURN_DELAYED,
>  				&server->delegation_flags))
> -		goto out;
> -	list_for_each_entry_rcu (d, &server->delegations, super_list) {
> -		if (!test_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags))
> -			continue;
> -		nfs_mark_return_delegation(server, d);
> -		clear_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags);
> +		return false;
> +
> +	spin_lock(&server->delegations_lock);
> +	list_for_each_entry_rcu(d, &server->delegations_return, entry) {
> +		if (test_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags))
> +			clear_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags);
>  		ret = true;
>  	}
> -out:
> +
>  	return ret;
>  }

Is there a missing spin_unlock() here? The spin_lock() is taken but
the function returns without releasing it. This appears to cause a
deadlock when delegations_lock is next acquired.

[ ... ]

> +static int nfs_return_one_delegation(struct nfs_server *server)
> +{
> +	struct nfs_delegation *delegation;
> +	struct inode *inode;
> +	int err = 0;
> +
> +	spin_lock(&server->delegations_lock);
> +	delegation = list_first_entry_or_null(&server->delegations_return,
> +			struct nfs_delegation, entry);
> +	if (!delegation) {
> +		spin_unlock(&server->delegations_lock);
> +		return 0; /* no more delegations */
> +	}
> +	list_del_init(&delegation->entry);
> +	spin_unlock(&server->delegations_lock);
> +
> +	spin_lock(&delegation->lock);
> +	inode = delegation->inode;
> +	if (!inode || !igrab(inode)) {
> +		spin_unlock(&delegation->lock);
> +		goto out_put_delegation;
> +	}
> +	if (test_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags) ||
> +	    test_bit(NFS_DELEGATION_REVOKED, &delegation->flags) ||
> +	    test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
> +		spin_unlock(&delegation->lock);
> +		goto out_put_inode;
> +	}

When a delegation has RETURN_DELAYED set, the code removes it from
delegations_return (via list_del_init above) and then skips to
out_put_inode without re-adding it to the list. Since
nfs_server_clear_delayed_delegations() only iterates delegations_return,
will this delegation ever have its RETURN_DELAYED flag cleared so it
can be processed again?

The scenario is: nfs_end_delegation_return() returns -EAGAIN, which
sets RETURN_DELAYED via nfs_abort_delegation_return(), then
nfs_mark_return_delegation() re-adds the delegation to
delegations_return. On the next iteration of the loop, this check
triggers and the delegation is dropped from the list without being
re-queued.

> +	clear_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
> +	spin_unlock(&delegation->lock);

[ ... ]


