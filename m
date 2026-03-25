Return-Path: <linux-nfs+bounces-20372-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABhtAtjZw2lwuQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20372-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 13:49:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6494C325266
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 13:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 839173111FE1
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 12:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98493D349A;
	Wed, 25 Mar 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b="l/u0Gf7K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-m19731102.qiye.163.com (mail-m19731102.qiye.163.com [220.197.31.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E953D1CC1
	for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2026 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442043; cv=none; b=YeqGIfXLUe124Bk4vdv7q7c+pI/ZBghBZLudSD5wljHnLlsoLh9ZgQaoZUugZx3X36ijhaAfoX1QRD25PYNAf2khGmW0WEYNb/pDwINeIPAFfiTft10jJ9x2jsxKGFlMlslPpzVAFXDWASj/3/RMyuPv/h3P/lQw+ZrLtdaeYAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442043; c=relaxed/simple;
	bh=HOGW1zbHsdxkLgondHaktZLt/yKSXKIn2AC8GVLuuOY=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=fCd9GOV96RQtRrY9HQiFiWeLzNKwcFKWGKR7Tkr0fTQCJ6Zvv2dB4TFraFqk36ThXnT7E3f0GkOjaXJitz5sAgpzFDMu0itRsuSKzMSNg2LgagOIwCXuYt71G9/tLURfIoumlR3363GLFWLlUFUpMxNeCLucFP7ZxFVNLW3uhKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=pass smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=l/u0Gf7K; arc=none smtp.client-ip=220.197.31.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucloud.cn
Received: from smtpclient.apple (unknown [106.75.220.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 18141b13d;
	Wed, 25 Mar 2026 20:33:51 +0800 (GMT+08:00)
From: user <wei.guo@ucloud.cn>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [BUG] NFSv4.1 client hang in OPEN reclaim path
 (rpc_wait_bit_killable) on 5.15
Date: Wed, 25 Mar 2026 20:33:40 +0800
References: <538B06AD-0307-4BD4-8E44-16BF6BAD7B4E@ucloud.cn>
To: linux-nfs@vger.kernel.org,
 trond.myklebust@hammerspace.com,
 anna@kernel.org
In-Reply-To: <538B06AD-0307-4BD4-8E44-16BF6BAD7B4E@ucloud.cn>
Message-Id: <D54322C3-58CA-459A-A195-CE4511225ECB@ucloud.cn>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-HM-Tid: 0a9d24fca8d0023bkunmac093f2b683122
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQkJKVksYH0tMThhIGUJLHlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKS01VTE5VSUlLVUlZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTElVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=l/u0Gf7Kzhg7akwoSt6zclZaEYm9AtJKGID8kVypfRtv4u0dlh0Zpt6VyM0GAMg+g37AZLf5gjG99m3W6w+D1t9Ytc8KBAFlJ08wb4UvviSOm0quuiwe1+1kw9rC0SxWh94gKodpb9Zxv+xFtj8+h1mkQhdBD9wPLXqpqv5srVA=; c=relaxed/relaxed; s=default; d=ucloud.cn; v=1;
	bh=HOGW1zbHsdxkLgondHaktZLt/yKSXKIn2AC8GVLuuOY=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ucloud.cn,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[ucloud.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ucloud.cn:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20372-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.guo@ucloud.cn,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ucloud.cn:dkim,ucloud.cn:email,ucloud.cn:mid]
X-Rspamd-Queue-Id: 6494C325266
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Server-side logs indicate that the client is sending stale stateids / =
sequence IDs, and the server responds with NFS4ERR_OLD_STATEID.

This suggests that the client state may not be properly updated after =
previous operations.


> 2026=E5=B9=B43=E6=9C=8825=E6=97=A5 =E4=B8=8B=E5=8D=888:11=EF=BC=8Cuser =
<wei.guo@ucloud.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi,
>=20
> I hope you are doing well.
>=20
> We are currently investigating an issue with an NFSv4.1 client on =
Linux kernel 5.15 (Ubuntu 22.04), and would really appreciate your =
guidance.
>=20
> The issue starts when the server returns NFS4ERR_EXPIRED. The client =
appears to enter recovery, but the reclaim process does not complete.
>=20
> The state manager thread is observed to be stuck with the following =
stack:
>=20
> rpc_wait_bit_killable
> __rpc_wait_for_completion_task
> nfs4_run_open_task
> nfs4_open_recover_helper
> nfs4_open_recover
> nfs4_do_open_expired
> nfs40_open_expired
> __nfs4_reclaim_open_state
> nfs4_reclaim_open_state
> nfs4_do_reclaim
> nfs4_state_manager
>=20
> During this time:
> - The server continues to return NFS4ERR_EXPIRED
> - The client does not appear to successfully reclaim state
> - IO operations continue but repeatedly fail
>=20
> =46rom RPC statistics:
> - ~30 million calls have been made
> - retransmissions are very low (94)
>=20
> This seems to suggest that the issue may not be caused by network loss =
or server unresponsiveness.
>=20
> Additionally, from our observations:
> - Network connectivity appears stable
> - The NFS server seems to be operating normally (no restart or =
failover observed)
>=20
> One detail that we found particularly interesting is that:
> - We do observe ongoing RENEW / SEQUENCE-related traffic from the =
client
> - However, the client still eventually encounters NFS4ERR_EXPIRED
>=20
> This makes us wonder whether lease renewal might not be effectively =
taking place, even though related traffic is being sent.
>=20
> Given that we are using NFSv4.1 (where lease renewal is implicit via =
SEQUENCE operations), we would greatly appreciate any insights on the =
following:
>=20
> 1. Under what conditions might a client still hit NFS4ERR_EXPIRED =
despite ongoing SEQUENCE activity and a seemingly healthy =
server/network?
> 2. Could there be scenarios where RPC completion, session slot =
handling, or sequence handling prevents the lease from being properly =
renewed?
> 3. Is this behavior something that has been observed before in the =
NFSv4.1 recovery or session handling paths, particularly in 5.15?
>=20
> At the moment, it looks like the client is stuck in the OPEN reclaim =
path waiting for RPC completion, and recovery is unable to make forward =
progress.
>=20
> If there are any known fixes or relevant patches in newer kernels =
(e.g., 5.19 or 6.x), we would also be very interested to learn about =
them.
>=20
> Thank you very much for your time and for any suggestions you may =
have.
>=20
> Best regards,
>=20


