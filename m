Return-Path: <linux-nfs+bounces-20713-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIw2Jp4O1WlQzwcAu9opvQ
	(envelope-from <linux-nfs+bounces-20713-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 16:03:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D66AB3AFA29
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 16:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E2433009F39
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FD93AA504;
	Tue,  7 Apr 2026 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHNjEWgM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B8315D46
	for <linux-nfs@vger.kernel.org>; Tue,  7 Apr 2026 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570197; cv=none; b=YEhdZbwAMegRiN3v5u6x0TlB13g+n9Pb2nFu4BuFtxLmkkB8bFIO8kGLs/Mg3FmAOGd06ppyXtCrSSzfag/+2hgWhhvsCP4fhl8Qk+evfL4Tejed4Kl1QvUTUNEtxqcZmVJuF86TDjmMPJyHdeZ0XY0ls3RTdi0ilyiA6icPnds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570197; c=relaxed/simple;
	bh=LZ9QEZfhYUypw5xNgz+XYLWiiMwFrK3EPlv4dR7IPis=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uFQNvo8sn4RAp6UcpudWLVAmRsscl5gge2b6KfMVpKJCAACkJ7/UNSvelIlRuR0DB94YYGNiOmXHoEQC+4p1QZlReSH0PTHL6XphRT7X9my4gPBHsPt5/YjJTlPGr9nWqqRNaYDP+Me6Sx1Q3Yn73gBZkzsTKVtVD7hZXVcrBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHNjEWgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6356C19424
	for <linux-nfs@vger.kernel.org>; Tue,  7 Apr 2026 13:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775570196;
	bh=LZ9QEZfhYUypw5xNgz+XYLWiiMwFrK3EPlv4dR7IPis=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EHNjEWgM1H44hC70C2KFi6bxE9OFpRMAX69p9sWaeIIGLxdiyKeNzf4P2HemNaWgW
	 wKD07gDTsWWs1CPQO4R4AQob3W6U2tnLOQwKwOJz0T/Vi5z9dRiLXk0L3atzpIlXbY
	 gzfiX90f3Pm2kVoZS7gKwv2ji4uTFF9+CECsOZ4S8wx439dN9Hnaf1EvKa08Dk7+DP
	 l8o3TCJims71gIRvNsE5KMxQyQ0kzc4nvnr0aRp1yC0+ShqoovqB3WsK/YcJoP+gKc
	 0HLSq959UVyCW2Uq/Bp/ucy3tc6UkPpXF8xmHlFu4KtbWcL25LAdbXCCyxllrc7zUD
	 EujbKV9RIFB7Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B7B34F4006E;
	Tue,  7 Apr 2026 09:56:35 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 07 Apr 2026 09:56:35 -0400
X-ME-Sender: <xms:Ew3VaV4mC5O9F70wBqvzWVk75mCroQR48xX-eGAvpJytoP64LGC-8g>
    <xme:Ew3Vadudbl7sAAXDfvIkiQYGTyeGUEkVoSyt5hmYlKDwDPOM-M9NMV8Icc6P05375
    JDilUzMLevyfx5KZ2RHxeTXkBK8MyBIU9BhNjTc0r7y2en33VWPwUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvtdekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpth
    htohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsmhgrhihh
    vgifsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomh
    dprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ew3VaeMiXBk7kg3q0Wn1SRjoCGivhubc_Nv_NRM3rKm1rebhR9uXqA>
    <xmx:Ew3VaW_qvwvWz_jeDD9yODHv8Xp0k75gZs0aB08UJKV1KBlAhOVenw>
    <xmx:Ew3Vab4Z6fXKaPZCQTsqCUrua7etoGyd-8UxRJBqQykuMnuAgHLqJA>
    <xmx:Ew3Vac6nQIHYDoQ0kdFpfNlHVxZBRx4wmPsZ0-ajjsh2OYw7II5q9A>
    <xmx:Ew3VaUrX9feq0ga55a7H0diu6fX9PMQN04DfJzHV3Lk9GW7zJo1DSMwf>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8F526780070; Tue,  7 Apr 2026 09:56:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ASRCxwBTfAP-
Date: Tue, 07 Apr 2026 09:56:15 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Scott Mayhew" <smayhew@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Message-Id: <328cf96b-ed6c-4dc9-aee1-a1bcf2efa230@app.fastmail.com>
In-Reply-To: <20260407113243.1754585-1-smayhew@redhat.com>
References: <20260407113243.1754585-1-smayhew@redhat.com>
Subject: Re: [PATCH v3] nfsd: fix file change detection in CB_GETATTR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20713-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D66AB3AFA29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, Apr 7, 2026, at 7:32 AM, Scott Mayhew wrote:
> RFC 8881, section 10.4.3 doesn't say anything about caching the file
> size in the delegation record, nor does it say anything about comparing
> a cached file size with the size reported by the client in the
> CB_GETATTR reply for the purpose of determining if the client holds
> modified data for the file.
>
> What section 10.4.3 of RFC 8881 does say is that the server should
> compare the *current* file size with size reported by the client holding

^with size reported^with the size reported

One more below.


> the delegation in the CB_GETATTR reply, and if they differ to treat it
> as a modification regardless of the change attribute retrieved via the
> CB_GETATTR.
>
> Doing otherwise would cause the server to believe the client holding the
> delegation has a modified version of the file, even if the client
> flushed the modifications to the server prior to the CB_GETATTR.  This
> would have the added side effect of subsequent CB_GETATTRs causing
> updates to the mtime, ctime, and change attribute even if the client
> holding the delegation makes no further updates to the file.
>
> Modify nfsd4_deleg_getattr_conflict() to obtain the current file size
> via i_size_read().  Retain the ncf_cur_fsize field, since it's a
> convenient way to return the file size back to nfsd4_encode_fattr4(),
> but don't use it for the purpose of detecting file changes.
>
> Also, if we recall the delegation (because the client didn't respond to
> the CB_GETATTR), then skip the logic that checks the nfs4_cb_fattr
> fields.
>
> Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fa657badf5f8..369f30c42115 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -9516,11 +9516,16 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst 
> *rqstp, struct dentry *dentry,
>  		if (status != nfserr_jukebox ||
>  		    !nfsd_wait_for_delegreturn(rqstp, inode))
>  			goto out_status;
> +		status = nfs_ok;
> +		goto out_status;
> +	}
> +	if (!ncf->ncf_file_modified) {
> +		if (ncf->ncf_initial_cinfo != ncf->ncf_cb_change) {
> +			ncf->ncf_file_modified = true;
> +		} else if (i_size_read(inode) != ncf->ncf_cb_fsize) {
> +			ncf->ncf_file_modified = true;
> +		}
>  	}
> -	if (!ncf->ncf_file_modified &&
> -	    (ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
> -	     ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
> -		ncf->ncf_file_modified = true;
>  	if (ncf->ncf_file_modified) {
>  		int err;
> 
> -- 
> 2.53.0

May I request an additional minor related clean-up?

The grant-time write of ncf_cur_fsize has been dead with respect to
the consumer (nfs4xdr.c:3930) since the original commit c5967721e106.
Your patch removes the last other reader of that value -- the now-
incorrect size comparison -- making the dead write obvious.


-- 
Chuck Lever

