Return-Path: <linux-nfs+bounces-19983-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDCNHDotsGlHgwIAu9opvQ
	(envelope-from <linux-nfs+bounces-19983-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 15:39:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E54252358
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 15:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6288D32FA18B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CBB38D69B;
	Tue, 10 Mar 2026 13:56:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ECB2FFF90;
	Tue, 10 Mar 2026 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150974; cv=none; b=Qk4/Xrgt5Sj9P95xXLzQSzP3bfCVB+xh5G6PbnPTyGgXknF1nIwFyDD4BheE+1PFH4RbQIJspfylvolmZBxmc2OIKLujB+PDdXK2DOn9YGSUijqFBwmAgM/niwzj+34UXZO65dOV8+5pm8gMp0V0dH61m4yTpayLAgN7r1Fjxss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150974; c=relaxed/simple;
	bh=FDMwXaHKDrOM7khDAib7qUUe1UeRwowP+SR16jql6lQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTIc6zSixu52GG6Cq6DFY5tJLrjwcodwjvew156TLPu3UZdI/AjKkUoXgOHKlz5EhlvD0JwfW9l6hkoTCobqwWX4GpFOJz/Rmhc6shERJ+T2pbqVQYjj2Ua3YEWV9POuFDCGFdks1EToRJhzERQReKQXEpnzrNJCKxMa84Jkcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 539B3433BD;
	Tue, 10 Mar 2026 13:55:53 +0000 (UTC)
Message-ID: <375c7c30c184d331c199876e45920976030f3cbc.camel@hadess.net>
Subject: Re: [PATCH 25/61] net/bluetooth: Prefer IS_ERR_OR_NULL over manual
 NULL check
From: Bastien Nocera <hadess@hadess.net>
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, 	linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, 	linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, 	linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, 	linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, 	samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, 	target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, 	v9fs@lists.linux.dev
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Mar 2026 14:55:52 +0100
In-Reply-To: <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	 <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepheefleeufeegfeefueffpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepheejpdhrtghpthhtohepphhhrghhnhdqohhsshesrghvmhdruggvpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvu
 ggvshhkthhophdrohhrghdprhgtphhtthhopegrphhprghrmhhorheslhhishhtshdruhgsuhhnthhurdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghphhdquggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrh
X-GND-State: clean
X-GND-Score: -100
X-Rspamd-Queue-Id: 12E54252358
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19983-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[hadess.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[57];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hadess@hadess.net,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.289];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[holtmann.org:email,hadess.net:mid,hadess.net:email,avm.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 2026-03-10 at 12:48 +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>=20
> Change generated with coccinelle.
>=20
> To: Marcel Holtmann <marcel@holtmann.org>
> To: Johan Hedberg <johan.hedberg@gmail.com>
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
> =C2=A0net/bluetooth/mgmt.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index
> a7238fd3b03bb54f39af1afee74dc1acd931c324..06d2da67bbe14e17ee478aa939d
> e26526c333d91 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4169,7 +4169,7 @@ static void set_default_phy_complete(struct
> hci_dev *hdev, void *data, int err)
> =C2=A0		mgmt_phy_configuration_changed(hdev, cmd->sk);
> =C2=A0	}
> =C2=A0
> -	if (skb && !IS_ERR(skb))
> +	if (!IS_ERR_OR_NULL(skb))
> =C2=A0		kfree_skb(skb);
> =C2=A0
> =C2=A0	mgmt_pending_free(cmd);
> @@ -5730,7 +5730,7 @@ static void read_local_oob_data_complete(struct
> hci_dev *hdev, void *data,
> =C2=A0			=C2=A0 MGMT_STATUS_SUCCESS, &mgmt_rp, rp_size);
> =C2=A0
> =C2=A0remove:
> -	if (skb && !IS_ERR(skb))
> +	if (!IS_ERR_OR_NULL(skb))
> =C2=A0		kfree_skb(skb);
> =C2=A0
> =C2=A0	mgmt_pending_free(cmd);
> @@ -8277,7 +8277,7 @@ static void
> read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
> =C2=A0				 mgmt_rp, sizeof(*mgmt_rp) +
> eir_len,
> =C2=A0				 HCI_MGMT_OOB_DATA_EVENTS, cmd->sk);
> =C2=A0done:
> -	if (skb && !IS_ERR(skb))
> +	if (!IS_ERR_OR_NULL(skb))
> =C2=A0		kfree_skb(skb);
> =C2=A0
> =C2=A0	kfree(mgmt_rp);

