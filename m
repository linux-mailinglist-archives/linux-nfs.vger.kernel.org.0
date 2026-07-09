Return-Path: <linux-nfs+bounces-23228-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gQ7ODGcQUGosswIAu9opvQ
	(envelope-from <linux-nfs+bounces-23228-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 23:19:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE5735CB4
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 23:19:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hVohIjt9;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23228-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23228-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8CD33007AD9
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 21:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D68D33067C;
	Thu,  9 Jul 2026 21:18:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561717BB21;
	Thu,  9 Jul 2026 21:18:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631921; cv=none; b=ZlHnzxrJBUhTnG6bM4LsWOQ17vH7Foph6Y1lmFDGgPlG4Za+CWgimH/qp3jPTqDpgPFckLHXKysoSt6iXwQ5wpNDceyWt2/KlWcjrb3Jpq6tHqLF+OoprHrLkkJQ7PsY1Khlirw3lTOWzAau/5SvxkK6uPQ3o9f2ZKh8UxS2ISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631921; c=relaxed/simple;
	bh=u6jWFHlNBcjeRFuYBNI7HyfGpbDDNuaOJIJNVzYwrps=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jhE1huks+uCsr1Spv4LDxVN10CuuAu7tRP9eTHIzmtAg8HQY1QRtgVm1/y0gnRoT57DD5DJVovLFH8PyfubLj98/ttsULb5kuHuU8tnTsvcekRMslA2D2QvUWLF8nSoXJjjdiW8ZjC1G8VlewC+KwdEDzSO8lV0TRCSsM7YoI5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVohIjt9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3694A1F00A3D;
	Thu,  9 Jul 2026 21:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783631919;
	bh=6tA/AkueJVVCryxoPengSYVhMo/gv7kgTKjpTgzF1ss=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=hVohIjt9FWIuLri3hxxh58w7KCzsFIM7H1JDtcPltJDhvYAV29TWuR8yj4iO5QmLS
	 nMoaDVKDkWx9ukSwS9OXKQbpnG63Qy1r6NNDxFmh8zG7DWS4nAX5gUal34Hbv3/cU+
	 7fpKFenaVNIfcUa4Tse2ZSp/ohSuB4Vk/Ts3Z+KahVXk2rUoFeLQoBmyCKaa+nvL1u
	 PUcUmKVLywF7/IaF7e931BljnyVTDKfCZqEPEfqbg/79y2P3+3phib2wRkNtFT0KOy
	 GG8425CKMJaRuxR7voYBtDcbknJPa/pd/SjJjhr0QpvLUSM8ckjVdqw8+dpUAAjC/M
	 bwsnBiYODTr6w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 44268F40072;
	Thu,  9 Jul 2026 17:18:38 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 09 Jul 2026 17:18:38 -0400
X-ME-Sender: <xms:LhBQavz9jcuOW1uzqacz7mmSKPcLj5wkW6FnoB8mdVA-M-Eygpy2ug>
    <xme:LhBQaiFghMXZzDwg5aPCJbSaZfgznDUTn5lAWylvi6omHH1PDZDUa17P2oMleGZ36
    h925CE0UOpProR80U7GEf3OTHUEw6pvoxMBTxktnYSqjvmy6ENfmw>
X-ME-Proxy-Cause: dmFkZTF0PmM/JyJzX9zNRDx4cykCeE6rnr2HmfnKw0rnF31LQiS+DNkCtoTjL3h7W1bveU
    IUM9Bk52F6oxKY5qy2qhWGxFmmMVP5L6VxTBWLIR1jr+sdBJ/gvxUlgZpXWErlf81hs8TL
    SEb9n/ubhGGkCUDQmBI180tv0viTXdYNdouhuBqywUNtUUvMXIU8DAqpsrGnhpMkYQPE1l
    A1qZlwWPw+CfaF4XWEdvOZ5odS6kDr+TesxDuF7KK/dQukwQ6FVfmFF/za/YoGmbroL5Ku
    w2Y1NtQ5SV4seCnAGlyoY02Ybohcvon99jx7MgOJloYElmkUZZoaaMK6j6eV/AQXuKp+ae
    cpqSc6OdMZRKvbqgkcBmhirzolMqBicCNSlzsFwpOIG+i3yLwrR2QFpbl/pv9gj1AsuGSL
    ahcyaKcUCXBS7ssjav00PU/8bR2cV/A58G2KvPteQEVHwEnuJA6+5+dbStvkCBGTmVuo67
    3jX4ShJ2D3PpmVXb+auki9I0NT2je9/724E15fWaVSWKzptWSz58ELKWFFQ6j8S6gdqVZQ
    bIMkFKf8EnCDKrkpt4Qa6b5vi8HLytdKv2SlauF/5PVd7gDoT12Pn/8vmBtm6vFxZp56IX
    qAVv+lD5W/V89SwcoWFW/STKN2vxTJNchrrQNLOGH4sYif1CXaly9vbiKZdw
X-ME-Proxy: <xmx:LhBQalBZfsJRdX4Ktk2dw2rNdkzJmJ_SDIXp2Of6wQKYqQTk5qbZxQ>
    <xmx:LhBQaj-daxvy-dYU_QW--RSE_3q-BHXFISIKp7eveAsYuM1_ntKG0Q>
    <xmx:LhBQahSKM72dJmLpy7g1Nr07uUSPEAcWpq0diWoFTbjxZBd7_a3b5Q>
    <xmx:LhBQanWpO_cYKK-pxLVbjxK_CZcgw4X9a-4uZTODchVZ045978zscA>
    <xmx:LhBQarR9KADjmEadF0drKyxlLYaZkxi_mnYt--RZc91Mm4G7D3L6_HaS>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1D457780AB5; Thu,  9 Jul 2026 17:18:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7uBYZMR0p1N
Date: Thu, 09 Jul 2026 17:18:17 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Andy Adamson" <andros@netapp.com>
Cc: "Chris Mason" <clm@meta.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <ca213f42-b6eb-42bb-bfd1-f89d7dfc03bd@app.fastmail.com>
In-Reply-To: <20260709-nfsd-testing-v2-3-0a1ba233bf87@kernel.org>
References: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
 <20260709-nfsd-testing-v2-3-0a1ba233bf87@kernel.org>
Subject: Re: [PATCH v2 03/10] nfsd: fix stale s2s_cp_stateids IDR entry for async COPY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23228-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:andros@netapp.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78EE5735CB4



On Thu, Jul 9, 2026, at 2:47 PM, Jeff Layton wrote:
> For an async COPY, nfsd4_copy() called nfs4_init_copy_state() before
> dup_copy_fields(), so the s2s_cp_stateids IDR was pointed at
> &u->copy->cp_stateid -- memory in the per-rqstp COMPOUND buffer that is
> reused by the next request. dup_copy_fields() copies only the value into
> async_copy, so the IDR slot dangled at the transient buffer for the whole
> background copy. Any IDR walker then dereferences reused request memory:
> the laundromat reads cs_type from it and, if the bytes look like an
> expired NFS4_COPYNOTIFY_STID, follows into
> refcount_dec()/idr_remove()/kfree() on garbage; manage_cpntf_state() has
> the same exposure via idr_find().
>
> Duplicate the fields first, then register the stateid on the stable
> async_copy. result->cb_stateid is unchanged.
>
> Fixes: e0639dc5805a ("NFSD introduce async copy feature")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index fad01d67bf3f..1c674479d4ca 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2272,11 +2272,21 @@ nfsd4_copy(struct svc_rqst *rqstp, struct 
> nfsd4_compound_state *cstate,
>  		async_copy->cp_src = kmalloc_obj(*async_copy->cp_src);
>  		if (!async_copy->cp_src)
>  			goto out_dec_async_copy_err;
> -		if (!nfs4_init_copy_state(nn, copy))
> +		dup_copy_fields(copy, async_copy);
> +		/*
> +		 * Register the copy stateid on the long-lived async_copy
> +		 * rather than on the transient COMPOUND argument buffer
> +		 * (&u->copy). nfs4_init_copy_state() installs a pointer to
> +		 * the copy_stateid_t in nn->s2s_cp_stateids, and that pointer
> +		 * outlives this call (it is removed only when the background
> +		 * copy finishes). Pointing it at &u->copy would leave a stale
> +		 * pointer into reused request memory that the laundromat and
> +		 * OFFLOAD_CANCEL later dereference.
> +		 */
> +		if (!nfs4_init_copy_state(nn, async_copy))
>  			goto out_dec_async_copy_err;
> -		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
> +		memcpy(&result->cb_stateid, &async_copy->cp_stateid.cs_stid,
>  			sizeof(result->cb_stateid));
> -		dup_copy_fields(copy, async_copy);
>  		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
>  			       FMODE_NOCMTIME) != 0)
>  			async_copy->attr_update = true;
>
> -- 
> 2.55.0

Sashiko spotted some severe issues:

- [Critical] Async copy cancellation paths remove the copy from `clp->async_copies` and free the `async_copy` object, but fail to call `nfs4_free_copy_state()`. This leaks the IDR entry in `nn->s2s_cp_stateids` and leaves it pointing to freed memory, causing a remote Use-After-Free (UAF) DoS.
- [High] Reordering `dup_copy_fields()` before `nfs4_init_copy_state()` leaves `async_copy->cp_res.cb_stateid` uninitialized, causing the server to send an invalid (all-zero) stateid in the `CB_OFFLOAD` callback.

The second one was also spotted by gpt-5.6-sol.

The new code comment here is a design breadcrumb. Probably not useful
to carry it as part of the code, but YMMV.


-- 
Chuck Lever

