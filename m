Return-Path: <linux-nfs+bounces-18951-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFn9I+d4k2mb5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-18951-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 21:07:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F24C71475EB
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 21:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2A59301C931
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 20:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEFD263C9F;
	Mon, 16 Feb 2026 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Oq41XslW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF58F48;
	Mon, 16 Feb 2026 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771272420; cv=none; b=WxukrpDMbnWnte91b4CkHDpy19b0hPqN3FgyNLyF6asc6QjfIF0zftG4NpARfn51x6/bmNi7pE/XfDtgDCGxTcsN0JdOPPSNZsZI4IXm3iqlLsahzd9zcDez9QzvEpjWhtbJTNP0R1amYA/mm9rw1Hp6YM+EwimRk6ajdMtGSUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771272420; c=relaxed/simple;
	bh=5GBMCRE8UCLJ9erqNAlkjoQpsSVsvIhltKco9VN9c0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRmOwcvKq6yu6xe0T2Bqvvy1PMNdkN01EYapaHxCb9Fgd16QMy6mmhfRN4q11/pBL3cW+Wi1CahcG2pdADnIfKCZ3BiZBQ/FrQl4AI4saW8RWutwVun/9SR0ytBAgOv0HbH0rMWRESKUAw69V6gXFqoVO5bprNxz828z1BPUeLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Oq41XslW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VfiQCERnDN/V9UQWqJheCNEEa/e8Tkm80+erHpLO2ZU=; b=Oq41XslWxQLPIPB5QZdSAh646j
	DPEEy8BxGU+btilCkYJFQ/1ZecYARusx+O6RDmQj0HAFQiIIGyphGlVCwkpleyFxY8vMek38Jlcad
	Hl3Q+eTaj3QK/GYmqKf32B7LwFFlORBWw0seh2no7NH/4uldV6ICGndNGo8M1DgTkq2E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vs4rq-007XKK-Bx; Mon, 16 Feb 2026 21:06:50 +0100
Date: Mon, 16 Feb 2026 21:06:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Chang <seanwascoding@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com, anna@kernel.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nfs: fix unused variable warnings
Message-ID: <2e3bf4db-cea6-4f55-a82b-4e99bb3f44fe@lunn.ch>
References: <20260216174950.455244-1-seanwascoding@gmail.com>
 <20260216174950.455244-2-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216174950.455244-2-seanwascoding@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18951-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F24C71475EB
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 01:49:49AM +0800, Sean Chang wrote:
> Add __maybe_unused to variables only used in specific configurations
> to silence compiler warnings found during RISC-V builds.

Could you give more details.

>  int nfs4_proc_create_session(struct nfs_client *clp, const struct cred *cred)
>  {
>  	int status;
> -	unsigned *ptr;
> +	unsigned *ptr __maybe_unused;
>  	struct nfs4_session *session = clp->cl_session;
>  	struct nfs4_add_xprt_data xprtdata = {
>  		.clp = clp,

Lets look at this function

int nfs4_proc_create_session(struct nfs_client *clp, const struct cred *cred)
{
	int status;
	unsigned *ptr;
	struct nfs4_session *session = clp->cl_session;
	struct nfs4_add_xprt_data xprtdata = {
		.clp = clp,
	};
	struct rpc_add_xprt_test rpcdata = {
		.add_xprt_test = clp->cl_mvops->session_trunk,
		.data = &xprtdata,
	};

	dprintk("--> %s clp=%p session=%p\n", __func__, clp, session);

	status = _nfs4_proc_create_session(clp, cred);
	if (status)
		goto out;

	/* Init or reset the session slot tables */
	status = nfs4_setup_session_slot_tables(session);
	dprintk("slot table setup returned %d\n", status);
	if (status)
		goto out;

	ptr = (unsigned *)&session->sess_id.data[0];
	dprintk("%s client>seqid %d sessionid %u:%u:%u:%u\n", __func__,
		clp->cl_seqid, ptr[0], ptr[1], ptr[2], ptr[3]);
	rpc_clnt_probe_trunked_xprts(clp->cl_rpcclient, &rpcdata);
out:
	return status;
}

There is no #ifdef'ery here. How is ptr not used? Is status always
true, so the goto it always taken? But then rpcdata should also be
unused?

	Andrew


