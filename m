Return-Path: <linux-nfs+bounces-19753-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFc7ODdGqGlOrwAAu9opvQ
	(envelope-from <linux-nfs+bounces-19753-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 15:48:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F6201E56
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 15:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A043128DA9
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4EE3A873C;
	Wed,  4 Mar 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9Pmz57O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACCA37474D;
	Wed,  4 Mar 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634437; cv=none; b=n89HtrMUwJnwj4WJ3rElRaUd5SzXpgd4EDG6nC4wqdXpfFCpKkBQkyVMsbDsdkKcN2brUPRPLc/6U1Lz+o1VwUeAz67FgzfxmqDlQjSOU0FwyjM50OMz1CluILeAQgVJ/VNLZF7bcYFxG1Zf45A+jowbFV0BVbmQ+8FwIJEBiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634437; c=relaxed/simple;
	bh=JudY2E+RxzF6UxTLm0DE2MBtJYZZkh1AFdJTmpR1Zx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HA3tXIFWh1n9uoR5ilpWYJXC04PL3Iz34MagDcPJkrraZxVUO/VycuhsXzCGrv1HTLcTNyILzk8enKoy55hlpeziJPw9ivTw9gJgsPUgt4UrK51lDcoIpOeN6hdoudgPwnCXp7U2sFr6KDtqHtaGTq/Ykymzv5tHJa4RXy3PnNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9Pmz57O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D847AC2BC9E;
	Wed,  4 Mar 2026 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772634437;
	bh=JudY2E+RxzF6UxTLm0DE2MBtJYZZkh1AFdJTmpR1Zx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9Pmz57Oo7szCV4iwPb1d/AzzRDY0vhawctaKUqBOKiJtAwVt6t3H1lOe45bA1xoO
	 U3P7fX76qF876U+OBcf61YjrdjXVyTHeSVKRRDTvanq0wwWU3mIJX4L6DlveJ/w6Kf
	 CxDL05WY9pA173w5ty/1XKu2T45lw1TGsJGSycrBBDxE6VnHb8QRkM83RhZ+8QOF8u
	 TNKiBPVjtSnPwuxHnDcMNIX+Wf9avF+IZcS6VOh2ONll+zOEZExse4eDlVfBb4lrUu
	 7IeJPNhEYmOCgC/+mPzDi2l3ZyRPmlWAD/Cz6pdtyPDJ316jDvnggEhDtHxhaaayJ8
	 m8vXXwEnUGMyA==
From: Chuck Lever <cel@kernel.org>
To: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: xdr.h: fix all kernel-doc warnings
Date: Wed,  4 Mar 2026 09:27:13 -0500
Message-ID: <177263442643.249131.15665053279331005070.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228220922.2982492-1-rdunlap@infradead.org>
References: <20260228220922.2982492-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 520F6201E56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19753-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 28 Feb 2026 14:09:22 -0800, Randy Dunlap wrote:
> Correct a function parameter name (s/page/folio/) and add function
> return value sections for multiple functions to eliminate
> kernel-doc warnings:
> 
> Warning: include/linux/sunrpc/xdr.h:298 function parameter 'folio' not
>  described in 'xdr_set_scratch_folio'
> Warning: include/linux/sunrpc/xdr.h:337 No description found for return
>  value of 'xdr_stream_remaining'
> Warning: include/linux/sunrpc/xdr.h:357 No description found for return
>  value of 'xdr_align_size'
> Warning: include/linux/sunrpc/xdr.h:374 No description found for return
>  value of 'xdr_pad_size'
> Warning: include/linux/sunrpc/xdr.h:387 No description found for return
>  value of 'xdr_stream_encode_item_present'
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] SUNRPC: xdr.h: fix all kernel-doc warnings
      commit: fba9ddf80198d61673738d5118566250cfae936d

--
Chuck Lever


