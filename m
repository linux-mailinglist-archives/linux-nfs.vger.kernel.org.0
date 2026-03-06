Return-Path: <linux-nfs+bounces-19841-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGlQD9Uiq2n6aAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19841-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 19:54:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B9E226DDF
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 19:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30FA330080B1
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4E31F9F7A;
	Fri,  6 Mar 2026 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZprdXYw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE91DB34C
	for <linux-nfs@vger.kernel.org>; Fri,  6 Mar 2026 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823247; cv=none; b=m+S1e893+Ni7rav06urdTN7e5WDiDCs13fI77ee5WFCghthPhO/c0CfuaxxcF3Kr4psmZURtVF5/Jz2lCKa6Eh+qfwoyBP5p6xwvpCnuhxtfJ9a6390y/mgobbpgoFiY84mAeDfTZH5SfLAC0TgznTVrFd+5AJhPqXecNJOaGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823247; c=relaxed/simple;
	bh=7oPfUyXueVle9ArXNE31Dz2kOMF7M5viUhm0OTxxpLk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=M+lYu530966vz6kBK5zqjW7UyYmaGTHNIYCgzmbeyermn7JqNRk86+orunhAliodYLq6PWuvgyPLLhgAA+vNOmkzR39+qExDXG3YBnQ6aGrIeOPlqhja2/gp5mVDh7QhGxJnKCgm6yTm29tmzr1EgL07x49n4F9Ljv20J55nE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZprdXYw; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2be26d11b95so6630506eec.0
        for <linux-nfs@vger.kernel.org>; Fri, 06 Mar 2026 10:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772823245; x=1773428045; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oPfUyXueVle9ArXNE31Dz2kOMF7M5viUhm0OTxxpLk=;
        b=FZprdXYwgR4IxtrtA4vsOOHW9Lbypfen83iCp42btvJOh/jhaOm0/URhGKIf6VxuYk
         wETN95MKhKk3ZzxEm2WwwluBC5RbjrhV1rWsUlscTW7YX/urAkiZD+Fn3bRzFBYim1m/
         DzqMNd/X91BME+PR18qzqdYcDPFX8UCTdlXDDyQa+jeriA5vDLeFuV+oZ3OOwBlCZfTi
         xtbBbrqbG8c4Ty7olE933RGGVlBL2hGcnLyfCDqvOr/YJR7FdUCCROE4YqLqciuOyBkt
         x3QBKPZ5J4ZPsVK/XnocO76Hb/c5UkzZxdai+faQIgBE/yNhGAPqm+ZslZirx5pHPqY8
         sdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772823245; x=1773428045;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7oPfUyXueVle9ArXNE31Dz2kOMF7M5viUhm0OTxxpLk=;
        b=lAGKvxYJsw4suSPqGzMTk4decAFds0IfOJDHtxsjlwlAzJtP7rcOO+m9nw1CXrDhsu
         tz0MuLneER/QuMbXoyvYk+b4/HDpEsKQnTt4PZ9WkFatk6WsTDkX7QVGfHKglchESzCD
         aG35Fjnggl0CrZMD5i+BM7n6K5qV8V19hz1tOV+63mDF/Xwt/r51SvZ7HIQRglLFAPdg
         Oc3ijPIw0dWjHFMEa7GGYJWtLKqta4XVXxrvLKA7USvOYWxWfImFdEIO0cm+Eb10UIYE
         kjWopBz+AsVyfds2hF2DsngTNmoq/84CEVvL29kVEDWFvGWWrDHJmdsJazE1oSwSfED3
         IF9Q==
X-Gm-Message-State: AOJu0Ywf0AYNDWAZxNk8kEdpuKRvcGHgVslZE4zYgciSF2Wqk71lKmYf
	4infLS/uqxb1qffjUjHTa9WJCU9rfNq9wk6Nl7ZBIftGRh5rxxFxoua+iZ90m8DJ
X-Gm-Gg: ATEYQzxUX24nqvEm2uCvfwlLyKbGFOpM1zuIPhAcCZGLLepI6Hb7tyMHjVeu1v/2cN9
	csydJSm23V4JQ4eRSftcYIhsNdht0hM8K8eOGOrUxRUzyxiKzDqZn2CR8tpO1rSozY5l6PHqpd9
	/aoC70IDCpULJ43kc1ygB9SLOXgEVyYI0iP2UN4JOj9+DEnxLfxviluHjUiZzC8tH1HDdg22oHF
	CWzfErfJnbReDAHx4ZP6fhg2ET0mYqnYRnOZPxINlXcGUaZ7UIpprtSJPGtA74f0s7w5sA1/qMl
	2peHJ4FjcTIeI5gjp8zaPCPu0hdARGnP+G4LCiHMwHHJSxxzzThrIJLwhGJiKZxSDH5FX+LXStN
	OtDdrh3ic72RuhlAOhqEAez5NLU27sFEfMXGfUkvpBLziZgXSfsJxx4RoywJvIE3ZtQxCBPEL5Y
	ru9M1l2PG7Z+0ro5j490Hm8mtr3ALw8BNfF7IcAkfL0tnOgj8NRUYsbUpI6HkThWjYgJHDQiO48
	zcF8cgq
X-Received: by 2002:a05:7300:730e:b0:2bd:dd33:7996 with SMTP id 5a478bee46e88-2be4e03cd91mr1344644eec.19.1772823245124;
        Fri, 06 Mar 2026 10:54:05 -0800 (PST)
Received: from smtpclient.apple (c-174-160-87-152.hsd1.ca.comcast.net. [174.160.87.152])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f82850fsm2212666eec.9.2026.03.06.10.54.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2026 10:54:04 -0800 (PST)
From: Thomas Haynes <loghyr@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Spring 2026 NFSv4 BAT - 04/13-04/17 in Redwood City
Message-Id: <FD9A4909-10E1-4378-A130-3CE0766A8681@gmail.com>
Date: Fri, 6 Mar 2026 10:53:53 -0800
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
To: bakeathon-announce@googlegroups.com
X-Mailer: Apple Mail (2.3864.400.21)
X-Rspamd-Queue-Id: 58B9E226DDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19841-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loghyr@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-0.934];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

I=E2=80=99m happy to announce the next BAT: =
https://nfsv4bat.org/Events/2026/Apr/BAT/index.html

Note I have dropped the ball on hotels - I=E2=80=99ll try to see about =
that next week.=

