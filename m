Return-Path: <linux-nfs+bounces-21973-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMEXE5CyFWpxYAcAu9opvQ
	(envelope-from <linux-nfs+bounces-21973-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:47:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2FB5D7E0B
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBC413001BFC
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 14:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA23C8C7C;
	Tue, 26 May 2026 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="P1PbwFHK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED173CD8A1
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806454; cv=none; b=YnZMXPP+IpyaoUi5SuMthiJ7R/4yBxEUkOzfPPJ7r6U3vJa3gBDJWY6MlV7C1crdPJ6pCJQCUR6eFD6qJKIC3NjSmzPMM0hZdydSuCAbdWleeOdv1UD+UcCelpuKKHHCbmyYLrWEEjg6iLGd7+CMbfdiB1QGwbTqU3a6sJwtrMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806454; c=relaxed/simple;
	bh=lVWngBv3CAOVQTiBYCBCe7XO3gHA6t7Ur2B10yWEItQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UyMAZUlRO/3pYdnuNp02y72KUBGDWdLZCMxPIcnS02bIfotULhDBdelhPgIuVm6oXUSrNeIYDZAXMnmV8WFP0/uD/Ur8Zo0IgRkp5xmXPzD8jN1dhb8O1CqI9kpuddz/E8QPqG4tISMy4PBLTuoIRhHzBPQ9fJcjGxYbkyDuZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=P1PbwFHK; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69d7e72b052so2893983eaf.2
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1779806452; x=1780411252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HVcpaFqRzjgkIhOLqCiHJZ7o1KvffXCljJ1XG+9BMgQ=;
        b=P1PbwFHKuNTVWELZwPsjwRjpf/9MESYTYLt++6/1EfjrZB4MNDf9JgQtA04ypXxWjW
         0j5itfhzZAjhJU8LTNFuJf0x+TuYbecgzjgjoMO0aQ85PcPP5GAzCL0QfcBAnCGhrKzc
         EBmoxZjyfFaxnta/2A4p544qs2II80ypQ7pCfF3XCKfKJ8IziNIus8GC4+Gd5p5BHxK1
         BRHrFfVt96ytZrUANQnMkZDd8qoQ2a4zahEvPl+4OfdYQlgp6O4Oimh5bFgKJ4bKmQjC
         OYsqu9lt3NrdXN9a1ngcGpInpSajWBZqI/C1VtdS79vWrgGC/yBypOOdF1l6ot+RzKbl
         B68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806452; x=1780411252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVcpaFqRzjgkIhOLqCiHJZ7o1KvffXCljJ1XG+9BMgQ=;
        b=XQlL3OdMIWvyNfmIHEm+BGOdgXna8HWc7DtHldJ0ygZRzgA9+Q99eZ+xqFTQ8tpiFa
         QbmUb2paktjU3enj/eVhV1absnm38NP2WVoamLMQwolcewN/wPOM+j9cn3QX/gM/CCv3
         XnoBCzycm9hyihqFfaBetW0tQSQxlppDxugAEIxAQ4MISdsv7U2TPlPakApb3GasyJHh
         wKKngYCLE8lnxhYMnEFp6r9POMBnz0b7tp8xaBHqFym6G4MCV93Em1oAWedjHRnIcAc3
         K2toTG0Bo5l3JbQKO8ryH+rIqlncVi0kUIwSLzED0ZvlOPy9OPkizsCPYcaax32SEjCD
         sSdQ==
X-Gm-Message-State: AOJu0YwKJaq+AWbFIi+SHtHONRiArDzpw686ylexJUZ2uetqkFxJCQ/I
	c1KYT92a/DFeUgTmSGrsAgQyAU5iGDYD5ay1iLci2TCWf0wTDjgIAlwczH+b9NRFDEs=
X-Gm-Gg: Acq92OHQyaqX+lmBsExRAJ2V9jG9eL5AL1+3XRY20dqh0L6AybwaL4+edKAn9NcqrCr
	Q5T45bJxvH3p5KmBFn9FS16UUEhT9ymwA6xxRw0NM7qAgj+eGdYqfvth0+sjXGFo0WSAqzjFWJ7
	p+KzKMroqj1dtakQIZn40CI+IGeQvNRDHIzTtov2y1Obsa5etgTaOO0I981OcwsjQifgMNp9qve
	FncaBjCiMY9q+rrb7kTqCCxVp5Cq6Ckz0gygb/1AT5ZuEmD+7beSyZNfSR/2kUt7jcCI5yZMwIA
	dk3Oaykr4xb0Edpl7fS1em1w8kaGMLIM2sZ62I0okMFCnqJB1wf6h3BOZkRHgYos4u+llUHq9nk
	V2suIqOl61vJf+XsKliLqyTsh8L32+APdAw+mCU+7ba9mckUX3j6RcCEticOJvJsytN9m6N6M16
	4hSns2Yj8kkXWIi0ogUG4FuJ1dNko+SudsHgjBNr8jpGOcK2T4oB7FY05vQQsBj9MXemz9iA==
X-Received: by 2002:a4a:d813:0:b0:69d:7bdb:ade2 with SMTP id 006d021491bc7-69d7ec28651mr7542350eaf.32.1779806451904;
        Tue, 26 May 2026 07:40:51 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63512d63sm13071941fac.2.2026.05.26.07.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:40:51 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/1] nfs-utils: nfs-fh-verify signed filehandles
Date: Tue, 26 May 2026 10:40:48 -0400
Message-ID: <cover.1779805943.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21973-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: 6F2FB5D7E0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We've had a lot of folks configure signed filehandles, and then wonder "Is
this thing actually working?".  Given the various filehandle lengths and
types, it can be pretty difficult to know if the kernel is actually
correctly signing its filehandles.  Claude and I wrote this tool that allows
anyone to verify the correct functioning of filehandle signing given the
original key and a list of filehandles.

Beyond that, this tool shows a way to monitor the configured state of signed
filehandles in a distributed installation.

Benjamin Coddington (1):
  nfs-fh-verify: add tool to validate kNFSD filehandle signatures

 configure.ac                          |   7 +
 tools/Makefile.am                     |   4 +
 tools/nfs-fh-verify/Makefile.am       |  10 +
 tools/nfs-fh-verify/main.c            | 337 ++++++++++++++++++++++++++
 tools/nfs-fh-verify/nfs-fh-verify.man | 171 +++++++++++++
 5 files changed, 529 insertions(+)
 create mode 100644 tools/nfs-fh-verify/Makefile.am
 create mode 100644 tools/nfs-fh-verify/main.c
 create mode 100644 tools/nfs-fh-verify/nfs-fh-verify.man


base-commit: a806c9d65662ecf5d40c00d60a514e13ada8d76e
-- 
2.53.0


