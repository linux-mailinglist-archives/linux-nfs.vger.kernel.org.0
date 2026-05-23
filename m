Return-Path: <linux-nfs+bounces-21861-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOXtCr+tEWpSowYAu9opvQ
	(envelope-from <linux-nfs+bounces-21861-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 15:38:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 274805BF11D
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 15:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 272F730055D2
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 13:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AB438A700;
	Sat, 23 May 2026 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MXb/XX8/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8263D23815B;
	Sat, 23 May 2026 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779543479; cv=none; b=c4xRdxjk5UbYUpclmVXrjBKdgfqUXDzCZhJNfo5EazOlKY1rrhBIXtKpAMCzkG9X0gHwC9J68IVuwfhiffT0hM9hMD1TgNDqE3wpkp4TFTf85IctG3evnydiG0O0Dm5Jg0tQjASU6wJNBXpQuCjtpiXv0ljUyrQSowtM/yQKJSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779543479; c=relaxed/simple;
	bh=z/w3AIqE9JMM4GHHqTfojWs/OGHT8k8OQ93+JCLeFWs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=PMN9zLaqnq4fACqsi0MYdFP5x7uAvq7kaUgrratu48+biLeZpfxYQLaui2ezd2M9/KqiS4BPK833BeLex0yKDm+D1Gurr1AmjZhPUofcWqwDLdgGK3K8jim/T4u3mwMd7q9i6O7+ddh5lPKFTVpyRg8iIKCFVu9M6MOQ4cM68qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MXb/XX8/; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779543456; x=1780148256; i=markus.elfring@web.de;
	bh=z/w3AIqE9JMM4GHHqTfojWs/OGHT8k8OQ93+JCLeFWs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MXb/XX8/WeFVvuqs9zlJbDvBQqToK6b4d7MoI3SjTSvqyQbMKyWgB6qGlrBnJNx3
	 EcjE5uljpZ6vm8WtoFcYI+sZGQ51FUTZJBYILFxPX+x/hLLPydutK66Necx4ijxAW
	 cf8BwD5AazmQ+BV96suxvXc7zcMRZ3PCFLjSigeK0BMCBwDSG0O/6TX2AEvU7axv2
	 3CDYOdrquzXa4lrfjUD6/OsLUon8vj+MlvwuhF5hM7+4hrSonI7ujyA/bqTZF+Ul4
	 6NRnYHv2dju6cm0m9jpDEzDGfsQx0sTONuPeq4ZoMhn404bpW+FYBH58jTc3NqhDV
	 3rkPqiAu6DEBIDnzJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mo6O7-1x6gw733W7-00frDG; Sat, 23
 May 2026 15:37:36 +0200
Message-ID: <e1a26af8-1849-4631-b529-6de644e43a03@web.de>
Date: Sat, 23 May 2026 15:37:31 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-nfs@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20260518131036.1337001-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] pNFS: Fix use-after-free in pnfs_update_layout()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260518131036.1337001-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lmj2vCBXqE+v+8Vg/KOq4DRuWutu4EubfPxJiQIHzsHDNZmVD39
 OLD1ojRDgLSL8+6+f7HT+9YGpHZ4uyGUVWE493uWaDdvqEtSY4q/mNSLhXWyLON8czES29c
 3wZ7AL5HEf2c6p4HJyh1dlEV8Qt5gw6RMMig6Fo0vyhKTpkubsndQQhCjxTawKfPF4SfIF0
 kXxXNPhI7sSLnSQ1dUTMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NMjd5aLcWpk=;iwZOhbzpHFX5tj0YXlU9b5P+D0O
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21861-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 274805BF11D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E2=80=A6
> Fix this by moving the tracepoint call before pnfs_put_layout_hdr(lo).

Or:
Thus move a pnfs_put_layout_hdr(lo) call between a trace_pnfs_update_layou=
t() call
and a goto statement.


How do you think about to avoid a bit of duplicate source code
in the implementation of the function =E2=80=9Cpnfs_update_layout=E2=80=9D=
 then?
https://elixir.bootlin.com/linux/v7.1-rc4/source/fs/nfs/pnfs.c#L2128-L2385
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.1-rc4#n526


Were any source code analysis tools involved in the detection of improvabl=
e places?

Regards,
Markus

