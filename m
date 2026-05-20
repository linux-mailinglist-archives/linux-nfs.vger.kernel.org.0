Return-Path: <linux-nfs+bounces-21727-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKBbLyVvDWp9xQUAu9opvQ
	(envelope-from <linux-nfs+bounces-21727-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 10:21:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B560589A28
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 10:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B564B302BBAF
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA2B3043C9;
	Wed, 20 May 2026 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NTFOkCTf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1A351C2E;
	Wed, 20 May 2026 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265302; cv=none; b=r6KNQM5BRQiWeVUBg3g/de597ae8m464stGUj6lcF+pHieFlyVrHSLdcd9IAOO71J2/NCfsP+8tONks06+P4FX8GWGbK73/6oR1e5epTpCemdxhdjwGXKOKhfPj/3o/U5xah42o8rwyz8AvXYvmpWVJv2I0g034dw9RfHyIvD2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265302; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASqX6JgY5W9Xmz0RozcFFY2hCCXBX2w3a0ScA2kpf5AZrSrqOgoH5k/2PtkIOxRKBDxi9dpO5chzfVFcmIMgqL5hoZlkvwkwMsZsCBDT81iCvNQHSw7iJMRclvMMJwZd5x4j6JsA3KbTfmQWITVCPCSsGh4RUwKeZvRlfdKcWXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NTFOkCTf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=NTFOkCTf1J4kVDle3xhR3/OQZ3
	soIYr17d2rIS1jhepzKZi4+75iBMrVkONbnLRcPtaYY6GfC81sOkr7LEAvDjf6bS01ozr5HXd3BSf
	2+IMrTnCoh1Jnf1uemoUGmrtQFFGvuUKJykSOGCZW4DKpoDza4m3AbPWG4RhnpGCDrzdEfE8WF8Qv
	9tn4dcnQu24jVbjFV4GI5UTWerd3wozdJop6EjMzl8oVEqUy5qerC2qRx3JT9PUPhPRcxVJZ3AYOw
	ilH38cD+PEZQYkXhpAX9knr1wodTH4+6lAEkiCxnO8rAwbXTZ7xmwa0MqfokY3CLh7ZUAhypBsEvp
	IoNPxPfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPcBQ-00000003wbo-3PjO;
	Wed, 20 May 2026 08:21:40 +0000
Date: Wed, 20 May 2026 01:21:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
Message-ID: <ag1vFHyBx_FaDqtT@infradead.org>
References: <20260520003503.2399326-1-dai.ngo@oracle.com>
 <20260520003503.2399326-3-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520003503.2399326-3-dai.ngo@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_FROM(0.00)[bounces-21727-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9B560589A28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


