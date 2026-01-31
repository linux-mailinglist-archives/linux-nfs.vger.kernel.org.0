Return-Path: <linux-nfs+bounces-18624-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPT8MK4jfmn6VwIAu9opvQ
	(envelope-from <linux-nfs+bounces-18624-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 16:45:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A55C2BF8
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 16:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A465300C26E
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 15:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B823314AB;
	Sat, 31 Jan 2026 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="f56QB62P";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="IicfNT8P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from cvsmtppost105.wmail.worksmobile.com (cvsmtppost105.wmail.worksmobile.com [125.209.209.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04C330B0C
	for <linux-nfs@vger.kernel.org>; Sat, 31 Jan 2026 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769874341; cv=none; b=UkJLgrKFi8Bei7TYwQofOuzFAO0hOS4yKnBOtkIMR/4/1Kr1IkUibcWFxKvQELLa1bYsqT9q2rO+rNuO8xMuKIcShobnWupFt7eVUJ6bhnOZJTMEnRauJA9NVz1rM+8N+VlxAFBR4vs77SBQ9r3H2iZL36Hpr8v2wOLXNXYZgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769874341; c=relaxed/simple;
	bh=uQvuKJMPTb2kGLU42WlyrbK+GTLXFrf00MyLkxWvjHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F53BydkReCRyDOFjUWf+Gf0tSxaCHRiWfDcgPL/P0KSu+Gz9Fo177ssFQBP1pGINqDl43VbmBmaneRdhCRZBdpeBatIBEbTPrNrjr8jnp3brwNQMFP2tKXAlJ1dUtPQyOVNisEe6HM4LhYxZxvink7cNTh7vIbOXP9SQSMtqgtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=f56QB62P; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=IicfNT8P; arc=none smtp.client-ip=125.209.209.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1769873122;
	bh=uQvuKJMPTb2kGLU42WlyrbK+GTLXFrf00MyLkxWvjHw=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=f56QB62Pss918jALthWPoljl9JNRjr96WxyZvtCgRX/ZWvK0H2LiXJYt39Kjpt7MI
	 Slq+n26zfAK4j0eG6EgBWiliJJJonYtSirCP78AZPFfwOq+pyIJpBExI/wKRpvMM6Q
	 7HhZPZ7MTanhN6HQqp6WhzSHGmwjM+yRSzr+ZLBAe55aDBGuJZLSXiBoXL2yyOAGe0
	 DUoAE7oWWlDUyWmsdNH6/KbfBh7s1ARmfYsvJAJM4t4Fe9OeWoXGdYV/UyignolvGi
	 FOcpF0OZeI4XkeRtp2Wbja+a5IgnT21HDTSfv9u0cUZ8vq/GR9BerQnT/l28JsZqOQ
	 iUglwW7dEQDjg==
Received: from cvsendbo004.wmail ([10.113.20.173])
  by cvsmtppost105.wmail.worksmobile.com with ESMTP id b+kiwZwIQJWZNcBIl2-wWg
  for <linux-nfs@vger.kernel.org>;
  Sat, 31 Jan 2026 15:25:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1769873122;
	bh=uQvuKJMPTb2kGLU42WlyrbK+GTLXFrf00MyLkxWvjHw=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=IicfNT8PvIEq+CDaAwq9IZEwlrHDq8ueKEA4ueyMFulYMGGalehiVeljPFvEs2PKi
	 3o8pkq+2YiMr+zrMswu4qnMoJGWITqg6xf6T3q48jPPOijGhBTq/DI5e2uMjHz/EkP
	 ZBpdNily8C9htc3Sj92lU209WUlPMF00xWKRAxJw=
X-Session-ID: Khmh68bkRnqCzBp+aO4WSQ
X-Works-Send-Opt: kendjAJYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: AwYdaAvrFqJZ+HmZKobm+6E=
Received: from s2lab05.. ([163.152.163.130])
  by cvnsmtp101.wmail.worksmobile.com with ESMTP id Khmh68bkRnqCzBp+aO4WSQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 31 Jan 2026 15:25:22 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: linux-nfs@vger.kernel.org
Cc: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [Question] Dead code in rpcauth_wrap_req_encode() error handling?
Date: Sun,  1 Feb 2026 00:25:21 +0900
Message-Id: <20260131152521.3305424-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[korea.ac.kr,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[worksmobile.com:s=s20171120,korea.ac.kr:s=naverworks];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18624-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ingyujang25@korea.ac.kr,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[worksmobile.com:+,korea.ac.kr:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,worksmobile.com:dkim]
X-Rspamd-Queue-Id: B6A55C2BF8
X-Rspamd-Action: no action

Hi,

I noticed that in net/sunrpc/auth.c, the function
rpcauth_wrap_req_encode() always returns 0.

The function (at line 739) simply performs:
  - encode(task->tk_rqstp, xdr, task->tk_msg.rpc_argp)
  - return 0

However, in net/sunrpc/auth_gss/auth_gss.c, there are multiple
places where the return value is checked and error handling exists:

1. gss_wrap_req_integ() at line 1759:
   if (rpcauth_wrap_req_encode(task, xdr))
       goto wrap_failed;

2. gss_wrap_req_priv() at line 1856:
   if (rpcauth_wrap_req_encode(task, xdr))
       goto wrap_failed;

3. gss_wrap_req() at lines 1926 and 1931:
   status = rpcauth_wrap_req_encode(task, xdr);
   (checked in switch statement)

Since rpcauth_wrap_req_encode() never fails, these error paths
appear to be dead code.

Is this intentional defensive coding for potential future changes,
or could this be cleaned up by making the function return void?

Thanks,
Ingyu Jang

