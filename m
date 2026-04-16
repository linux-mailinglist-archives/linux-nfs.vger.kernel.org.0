Return-Path: <linux-nfs+bounces-20902-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBtcFrkn4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20902-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:17:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B425B413A63
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B67A30C9594
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175C28248B;
	Thu, 16 Apr 2026 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCRcsvLe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DEC2F9D85
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363301; cv=none; b=o0cVdbdXLfiXaCOnpqha0lrxlGQ0uafae63FJNomSIykgPzBJC7N7y1ZofVPM4oVyLyolAol8qw3F1aUxogpdyH0Br3fZgsoaxwLA5C2WeDMB3ojGxXBbp7Ibg81fC9BAGFQCF5tD5wEXag1sK3Wm1YcmKqQT+kN2UdRAkP7Xyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363301; c=relaxed/simple;
	bh=Ih2lBFlbXaWo60cxdZOZNOgcm4ae6sxaf6san2O+SQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l2QCadInZMVa64iP2hPoamBQz6AuMGdvs/fHMW7DlMw0axFhK52o5Gvb4dATdPfO7TAo7Yfz5GYchcWF/aTRvwlM6g3imf6TQt4q3EPwqra8Y45Va4nCce09AUXqs/exYLkA+2PqERRQGmbBy0+flRbahC4tAhJCF08Otw+Ta4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCRcsvLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3869DC2BCB0;
	Thu, 16 Apr 2026 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363300;
	bh=Ih2lBFlbXaWo60cxdZOZNOgcm4ae6sxaf6san2O+SQA=;
	h=From:Subject:Date:To:Cc:From;
	b=KCRcsvLeWlXj5IYHK7oC00ETT2lvTJjTxGL1jZJAJxvquDxRgzjPWOXIGFnM0VCAR
	 7ZLdNLloA/yytMEiu7Gs7tI00cKctpeAfZmP7lH1f4VGkXV9hmxEm8QaTwoOBZk30B
	 8vrC+6m3oK4n1B0lnc9ohN0rbQiSMtKmSVsPxfdoJESjngZEtTMEyVZMclsW6IIUIs
	 GpgNwBF2dVUoSJukxfeiOG78csB2Sj6NkPpYnTjbbWYQehSUMduEUJMNGDcrGMD9wm
	 c5ViDoSUyJ2whp2F8oQpupNQT87w9P4mxI0yG/QHOVLt1tj1vKa3LReRZJC2gBA8b7
	 OAMSZKiV2kfcw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH pynfs v2 00/25] nfs4.1: add some directory delegation
 testcases
Date: Thu, 16 Apr 2026 11:14:32 -0700
Message-Id: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NSQ6DMBAEv4LmHEfeCMsp/4g4sAwwCrLROEJBy
 H+P5VOO1d2qviAgEwZoiwsYDwrkXQJ9K2Bce7egoCkxaKkf0hglJmIx4YaL6NVgbFXOtalLSPu
 dcaZvdr1gP90coEvxSuHj+cwPh8pllllZ/ckOJaQo7dg0NfZDpYfnG9nhdve8QBdj/AGBrXHyq
 gAAAA==
X-Change-ID: 20260331-dir-deleg-a1b3475f8385
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2763; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Ih2lBFlbXaWo60cxdZOZNOgcm4ae6sxaf6san2O+SQA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScZwfQWn5ksWd7m4adprGQ10oVWHg7R92IbS
 RwJ6oC6YfaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnGQAKCRAADmhBGVaC
 Fdf6EACR6Cj+h/qe5thFiJ5coDmezsJs3wP2UVy/vCCpsr/CrFJko8rRXJecCMHTQDT2K1Edg8z
 6kxqfReTav0hk6hkAtgdc/E6gHwtAs9xj3uev0mgAqalArzorJaplagW6D0kZc+ujV95fRuin8b
 TBPfX06e2XqIo4UHSpp9YOwKOHflfbruspzqsOevCZaAk9kG6UtO1FSi/IvhuzsqRr42C3zSHn9
 ZQw8z4EBvCxQulqDpIqRSPXAR8Y49nM+XEX2W9nz9XIh7cREBdh3G15qoeKX2kpjOFazNdX0iZw
 jur/ulbnUAhPaG9TQmxvHRuVVE6pdw0CCDhRaZabyInWbC090/PnLa3e2iDNuEDvsLOXVUKT1N2
 kC6jxwEwbmQa+eT9Tk+DLJy96+XtEA3g+mdtgUo/xBHKgjfdXbWzHBsO1NuKoIPiDi+4iaT4PBx
 ULnRnmxVJcpWQ3cyh18Nx+GaXrNA1WYrHAgozOT1hn24gB0FcnBxB/ACOUVp1DrNpmtWFTfy0WX
 VIZA8LtYUNKyq5jnUCBU540qZrfENaiyUn2XGeRzHseS67TBe69C7QatMF9iamP4hILPjZhHW3M
 otimk4Uc8CkRftUuTwyuYr43TQOBGw9ruauMOyffe78vJTq23qktRV4jBiOPx3igvz5NClAqVAr
 CrwMZ0kfH9uWfpw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20902-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B425B413A63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset adds some new testcases for directory delegations.

DIRDELEG1-7 should pass on current mainline kernels, with recall-only
support. The rest require CB_NOTIFY support. If the server doesn't
offer notifications, then the tests pass_warn (so there should be no
failures in those cases):

    https://lore.kernel.org/linux-nfs/20260416-dir-deleg-v2-0-851426a550f6@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>

---
Changes in v2:
- Added more tests for CB_NOTIFY behavior
- Link to v1: https://lore.kernel.org/r/20260407-dir-deleg-v1-0-54c998eab72b@kernel.org

---
Jeff Layton (25):
      nfs4.1: add proposed NOTIFY4_GFLAG_EXTEND flag
      nfs4.1: add a getfh() to the end of create_obj() compound
      server41tests: add a basic GET_DIR_DELEGATION test
      server41tests: add a test for duplicate GET_DIR_DELEGATION requests
      server41tests: pass_warn() when server doesn't support dir delegations
      server41tests: test remove triggers dir delegation recall
      server41tests: test rename triggers dir delegation recall
      server41tests: test mkdir triggers dir delegation recall
      server41tests: test link triggers dir delegation recall
      server41tests: test no notifications without GFLAG_EXTEND
      server41tests: test unrequested notification type triggers recall
      server41tests: add a test for removal from dir with dir delegation
      server41tests: add a test for directory add notifications
      server41tests: add test for RENAME event notifications
      server41tests: verify child attributes in ADD notification
      server41tests: test CHANGE_DIR_ATTRS notification
      server41tests: test mkdir triggers ADD notification
      server41tests: test DELEGRETURN stops notifications
      server41tests: verify filehandle in ADD notification
      server41tests: test cross-directory rename REMOVE notification
      server41tests: test cross-directory rename ADD notification on target
      server41tests: test link triggers ADD notification
      server41tests: test same-client changes don't trigger notifications
      server41tests: test cross-directory rename-over nad_old_entry
      server41tests: test within-directory rename-over nad_old_entry

 nfs4.1/nfs4client.py                 |    6 +
 nfs4.1/server41tests/__init__.py     |    1 +
 nfs4.1/server41tests/environment.py  |    2 +-
 nfs4.1/server41tests/st_dir_deleg.py | 1066 ++++++++++++++++++++++++++++++++++
 nfs4.1/xdrdef/nfs4.x                 |    3 +-
 5 files changed, 1076 insertions(+), 2 deletions(-)
---
base-commit: cd4701827a8261fedbfb4c6e39029fb9671321a6
change-id: 20260331-dir-deleg-a1b3475f8385

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


