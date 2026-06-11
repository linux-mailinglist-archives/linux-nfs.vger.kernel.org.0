Return-Path: <linux-nfs+bounces-22499-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id URq8EmgUK2o+2QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22499-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:02:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7E5674E9F
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:02:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Iw52Asxw;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22499-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22499-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC2AE3158AF8
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB88538CFEF;
	Thu, 11 Jun 2026 20:01:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6209389E05;
	Thu, 11 Jun 2026 20:01:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208072; cv=none; b=csjx8Dbfa+q4EReRZR68aGjDT/QFnG+ztD6sINVH8dTZ1lMkWOmX6MDwJHcrrX/QOog4IyYCRTMBUaYnujPLcGzz2nT5PwV356nAGC3Zw3YT66pzw+oK7AwZ3ahZa7QW1fRKBkQcrg7yrC0exGmouQk611IYMbx6tWccg0CHQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208072; c=relaxed/simple;
	bh=UcyniYrgdklKohwqOSjznlAOhFMrpAAaEdmtNCcgQzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LF4EhaATMOSkyaUb30Fza89RXMNi5pZiYIRQW4RPTrawUQPcyfmkLzl8klRyafL8x9G3dCMsICfwjiCW9dKm2V0IIcJQYTLqyokBNcWZ178tzmQnZP1h0+Yuljr8VgddkVI5Gvn+n2Nm5r4e27H0etFF41zvS09Mc/aSTJBRFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw52Asxw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99A51F00A3F;
	Thu, 11 Jun 2026 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208071;
	bh=oDiaR3AX5VPl8hUvSaDYt8zboOCbbg8Ha08a196qhP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Iw52AsxwPXXXy8Ui8qXXO+A9/Gk6B5r1ufZyE6nA9jZvMN3mUjZ/3AV4mOkwnQ1Yr
	 nbUKlwawgRGbPqrA4oh0+utWHCEEuo06e/bTZxcJXm/gm0IUfpcsLoJ65RpOrSxixp
	 rA6x0BWsD2SFQt3YNzyiX3kdaciIeSCf9cQcr6nEPu/QCE/RoW3HNVfz39Iol+j3TF
	 ocMg7qx8BNKn9oHiRKeuQ7IAMuNdygll1aGjMiYKFFyec2+IAdrpmuv2Nrb9nAITqg
	 5T43XsuotTjvldB7Twu1nnjxCevO2fH8v3Aw1ixXMKPnhDBsDP3rvu+2RWfI+IE3ZH
	 qemkgm4viF59g==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:48 -0400
Subject: [PATCH v2 05/21] nfsd: check nfsd4_acl_to_attr() return value in
 nfsd4_create()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-nfsd-testing-v2-5-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UcyniYrgdklKohwqOSjznlAOhFMrpAAaEdmtNCcgQzo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxP9BUAz7Ka6aVXfSFIEhstMKL2XSiFfItMyC
 oRH0/VokwGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisT/QAKCRAADmhBGVaC
 FfKeD/9hvOUixcq3TOZKpL253HTM15l4dAOGyaxsnfZhu8b73MnB7GJH0BUG95BEMTAbqQb/W6C
 QTz1kjBSmA1x0aSCpwx0Z1YiLxoawlh3XC/Pv9fYLs7rOcQyfPHhlK5JbIGbr+kTsLRrrWgrnrk
 5zzUqYTZ0R/xClXy8JPexcofu9puTapMK1zmcXPrm3+GIdYbobbjHAURxEf20cXW9rUfQ1OyYhy
 zUdSfCSivOi4T1ZOMTgEqFuNd/oEBVreHiA1yw5gxZl1v/2s13uK4DXgSv/t8Ufs2IeRwr2VxHO
 uNFBWx/JFaTaSBMidEKUSNc1jgWB7q/mQjkExVtsu8J4jYfRrgb4MxuX7nEizdFNGQfoJ6ASOEo
 Tt79QvngRP8sgUqJVf7KIeJOB3zwO1rcZ3G8B0tkTrNQZv90w8gntOhujeGFBMEJg2X4FDYu2av
 sN/LcvIWxJMHlmn17mqFlJGylh7QGm4YUMr5hwczCl4gE/AdjnRpfw9n0gKMsYdzjX90mpZ0Jk1
 72cnxX9T3YQqCRmjp3v3VHb9JeYTYIqC+KaIM6peNYi8os9eOQgcheuYxKB5+ExT3OVSOX/ka0o
 r5aFk/IU/cBoOR48tSdIzFVnrHfzuldhAkxvdyyePRkfQ/m4rtczrN5jjBtA9jVIY7vs//g8dji
 bFyQ7RtD7psHBjA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22499-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED7E5674E9F

nfsd4_create() stores the return value of nfsd4_acl_to_attr() in
status, but the switch(create->cr_type) block unconditionally
overwrites it in every branch. ACL translation errors are silently
discarded, and the CREATE proceeds without the requested ACL.

Add an early exit check after nfsd4_acl_to_attr(), matching the
pattern already used in nfsd4_setattr().

Fixes: 4c10614c7b47 ("NFSD: move setting of ACLs into nfsd_setattr()")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0c37d7c6d28c..69fee481581d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -855,6 +855,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		}
 		status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl,
 								&attrs);
+		if (status != nfs_ok)
+			goto out_aftermask;
 	}
 	current->fs->umask = create->cr_umask;
 	switch (create->cr_type) {

-- 
2.54.0


