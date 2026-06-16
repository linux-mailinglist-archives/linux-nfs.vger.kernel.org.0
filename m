Return-Path: <linux-nfs+bounces-22566-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jRSnNDrJMGp/XQUAu9opvQ
	(envelope-from <linux-nfs+bounces-22566-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 05:55:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3119B68BC62
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 05:55:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SWXpczCQ;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22566-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22566-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 038C1302C14C
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 03:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F31D23C512;
	Tue, 16 Jun 2026 03:55:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44C239567
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 03:55:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781582136; cv=pass; b=UC63qlmik7ZYvyd16K3Eri9sTCBy9/DrCrNAcBWRoaMnaFAvAYoFYVpZVzwAFe9JG3y/uZ+94cJeYnWkoTTYKAZPJiQJbiMW8crB46Sj6TMyVM19NhurcjuYVv65w5HBTBgrz+Fd7Canqs2t85UZiPktazZQNWaN0B9+K93tAns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781582136; c=relaxed/simple;
	bh=vSOrIBc5PJwwtRLwoFItVRIdHi+QtwapH4V/RTFOW/A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jjXcyvd3rbAMZ9F9NcpojWET64JbSGzZXemCzBuY0Ikb4YXmf5pFuMpWTBX6Wea/rNcLdkIciu8YIWFMSnr9GNrhgWxWcTzAG8NY26f6SjM16LrosWKBDjsBjsRLmKOMp5Ab0oKzt6hLT4kY7FeWGIlnNH08hgcERLZ3frCTfw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWXpczCQ; arc=pass smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68acf0a15b3so6217510a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2026 20:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781582133; cv=none;
        d=google.com; s=arc-20240605;
        b=H24LvcFuEddKs3IyT1TSD5VIEC6L1pjA4mSPq2g24PWd8lrkrORy1CE7Nz3qsudJlh
         hlCLi3OiKNR/cfZtlvlvQS1SU+XUF62X8luowqRQcIBBh0eEZ7omGtf9GUJnnyZWNrVd
         J01hGmC21/J2zW4sl00WnyQgTVheGiDfVQ7Oom0xYtPRC06N2naPZZuqapjQhG1N1HdN
         IuhbN+mODE+VIa0ywU2wK73JQwQuPljbq6ND447GzsnFfokaJfldNN+ckG8wgfGe7it5
         /HmJd0ztj7O1vz9CGGM0SH+GuOcDZxhY5Cff0FN2XDgBXTgdlocrly7YfuSkAR9yKWMh
         3Kpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NlkMMQXKZ3qMnVNE0DvQcTJV1l3bEvFLSu0esX+xef4=;
        fh=mdVthUph643wvMPqcsH9juwYJXbTtSWZeuYeXi3eUwk=;
        b=eJU5xqGuTaFFs0HYaLhEon9Rl30SsPoLi3k5KzdHn/Exj9yyKKX4Nmz6GhYTBLhSyh
         SFmmtMH9nKeAWPW6GHa+4h1bSFWEP6RPxEO4PgplednpMzlUNCyJg9ZR1TdmaEsVZqff
         mVdSndkoXFwJMqYRKqJf2vxKpRWNkO+2Njfm8uyxTg0frqrioLNW2PBM+LkAOyNPpijW
         2ReKdixEKHiytpn66ZXfG1iRqaM03K4385p4BPv3JwAWvKIug1BthwEX6ftNgRJRF9Q7
         djpaL7REQnV7wAdlsfb/UNDcKrrUjE43coiZT7C1xXqkzT/IDhRljAwsE4ZPcfNFr398
         4RBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781582133; x=1782186933; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NlkMMQXKZ3qMnVNE0DvQcTJV1l3bEvFLSu0esX+xef4=;
        b=SWXpczCQHDjDYdxi1yMZNZWaEH9wWjvUWIeqL7EulRe+3brYwnjRFrW98oLatJhJCj
         1J1W5x0sUOMDLBtiwBI6oYTPCg5V06TPb2Ym2k5xVUCBx1yHnFnmUvNcma0MH2Gei4DI
         VPIneKFEO34x88LBjoLvN81iOcNGbwNGN0+x0JeSQcmzpW7MFUMSWIRrYO3XsQqyU24k
         gIWtwzkIR8ViPZ3eEEysWTcFHkGwYFPA2iqFwypcxCQNbvBF0arlEEetvLb4jvC8DJDh
         KPEXSRlqKuL+GjEav4jXNrLeAu79koTtqcIoyGDlw3FyeCK0IwgeHD8d/EXr/NqkFffQ
         fZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781582133; x=1782186933;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlkMMQXKZ3qMnVNE0DvQcTJV1l3bEvFLSu0esX+xef4=;
        b=FGLh6sHqsdSZsHJJ+CRiHVqmUYKuk/vByVjC4OAYQRE0vIr22MF//aLNBT6jDp3MxG
         q7wTvgJSuT5CHz2sBP2TOU56Su+QZC3qQRNPV7ZNt69nb7Etk+xqnPwPz57LutrwR2d4
         glXqudFTBNY/hUEEMMLZf3Gu3wv1LO03d2LUJQDNAjxf0HqQdBQUc4vFchS7m47SkbYY
         5Ehr5OY+fw191EOXyIDCf6gtBjXEWMqaVxbjjgae3Raj6gIdFFmQ6LPHPFk/Qs6rv8+B
         rY2Vpu2QrWGtk1fXcI5ASzxr5IVF/4+p+sz6zG+jZgmFARqCst9to7Hg1C+lvNWlR9aO
         Mi3w==
X-Gm-Message-State: AOJu0Ywe8mKzVWd4VKyEommnbn174e/X13NTESHI6N76/LfqpSDVkSNy
	ST9nbsdaOkHyTh22yBFrSi2dpsQ3VZxM4MAbQ9kQR/WgcbGJKiIrZ1HfEaGAC+Md+2A09MGfx1T
	QAJFhtMKej2TcIv1jpHE1s68tIwW7KaWtOg==
X-Gm-Gg: Acq92OExc4+/bLuyJfsg1GRfpCx8bi+yhhaYhcQNB5wPhQyLf5KlEW+w8SCXzWmzQoY
	kAm41ZKzirdD4SRUrydrU7gZFE4QtL3fUQbhgPUeWya2ZYmaeXphQYJzqBz8G62XMWeR/2F0YkR
	QchWFCQqBL6iaZ5Z7wENRri77Z675uD/QXbnsy9mHxi826SgtymtWO724GHvWst6wazawVpuhQH
	wmDtE3gI4zTRKK8/jV5jrUOohGWYNWPOY6MtxaD/XdH/+oq9FsSJCvJQMSbJKtzYjwSOUE3kLi3
	j8sQeQ==
X-Received: by 2002:a05:6402:3485:b0:687:7fa4:faa0 with SMTP id
 4fb4d7f45d1cf-695087e0a35mr796049a12.23.1781582133197; Mon, 15 Jun 2026
 20:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 16 Jun 2026 09:25:21 +0530
X-Gm-Features: AVVi8CdzMm7F_rER_LR6lhSDFsUrtkAi_crNz31qFHHudlQ4M3SMr1OHq5cvHmw
Message-ID: <CANT5p=py8E7Rnd4C-1vMHMw2_dMxS_Cshy3hcbOEXzaO1pVqLQ@mail.gmail.com>
Subject: Status of delegations feature in NFSv4 client
To: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:trondmy@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nspmangalore@gmail.com,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22566-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3119B68BC62

Hi Trond,

I wanted to understand if the file delegations feature on the NFSv4
client is stable enough on Linux to support it in production
environments? It looks like this feature has been around on the client
for a really long time now. We tried running some workloads and file
delegations offer really good perf benefits.

At the same time, I'd like to understand about the stability of
directory delegations feature on NFS (I understand that this is much
newer and only a part of NFSv4.2?). If there are gaps that exist
today, please let me know. I'd be interested to submit patches to fix
those issues.

-- 
Regards,
Shyam

