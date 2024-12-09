Return-Path: <linux-nfs+bounces-8476-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1319EA0F5
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 22:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04586281D7A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 21:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19B819DF4B;
	Mon,  9 Dec 2024 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUGj9qWn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CC19ABD4;
	Mon,  9 Dec 2024 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778855; cv=none; b=KFA2IF1Ho7GfkSyj0tDKCZPFaeGEwNxxZOIfKK7P3YTZR+BZSJqJfQFSkv5Q9V9maxXYAG106Oub3ksAdm/Hi8j/hhW7T8G6uFdqZwCWdHqC4fPl+TSGLgDMn41grR02t0VkcrDXlfWGIi5qniL3nhEL7PNcyCcSrthVK1qSAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778855; c=relaxed/simple;
	bh=S97t7gPHtGnAlPeQ+hUHe59otJ5uml4So/GHhjqjpYI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=haCXRF83erEtT12OQt6hbElL/LO8EsWbFQAlp4vYGfgbQQ5FPlA1FhtsMIGVWb66tqSR6FgSn5KoJiL+V37aHwGYQLvMP70xXM2QBRDhbRpzDp2x5MEPaO+LLOu71AL3ITB3qUZaY+HmeHQk/le9V7GMwa8CyqMzkjonR+X/jFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUGj9qWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E68FC4CED1;
	Mon,  9 Dec 2024 21:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733778855;
	bh=S97t7gPHtGnAlPeQ+hUHe59otJ5uml4So/GHhjqjpYI=;
	h=From:Subject:Date:To:Cc:From;
	b=JUGj9qWndhB2v5CQir2j117ygqIE9KHGSxjBW0nzUWmGRzaRtTtjrGqP8+VYn7iCv
	 5+uKm84/TmpNxzff3erxp5Je9O0uH1h8X8NJBBktNEEDeMzUn6QGRHTsK56xo7mnk9
	 /+xRlFVBXP+AGTbwePE4yN4+cFVfn9bHuXRJG2vRmePwt/dY+jClmar9wUl891McxT
	 hUI69jxqwvvlarAAjq7PBUAe1QrKl6/HmldF2+GbVbXjId8Tnbero8C6RpMuJ1IGG8
	 RUz/bytlFH5u8czATYQ2eo77gSSKm5dZnn9qMDeHAiJUzj1tJM5ave5qBhMp5euQGz
	 pTCxjrrYZsw1w==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 00/10] nfsd: implement the "delstid" draft
Date: Mon, 09 Dec 2024 16:13:52 -0500
Message-Id: <20241209-delstid-v5-0-42308228f692@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJFdV2cC/z3MQQrCMBCF4auUWRtJ4liIK+9RuojJ2A6WRJISl
 JK7Gyu4/B+Pb4NMiSnDpdsgUeHMMbQ4Hzpwsw0TCfatQUuNSksjPC15ZS9ulhSSw16dHLT3M9G
 dX7s0jK1nzmtM7x0u+F1/hpT4NwoKKXptnTYOjdN0fVAKtBxjmmCstX4AC1r++Z8AAAA=
X-Change-ID: 20241209-delstid-bae14ec4613c
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6155; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=S97t7gPHtGnAlPeQ+hUHe59otJ5uml4So/GHhjqjpYI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnV12dRjg6P3y+RgBbJtYN+c0XbNAdTlNz3p4s5
 JvXOZxML1yJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ1ddnQAKCRAADmhBGVaC
 Ffd8D/4lWjWLOPA0NWiWXjf9tQMFt/07t4O61kQB/Htv+VmPiD3K+SQkSFmMqxwggn4MFo9o3vN
 yaaGK5Sx6sLq0IqU3LK/Aa3lHMzuSmQojcJ9zWvNCRd4s5qJ6brqILS8I8nM5b7ainVUs3Kp6Cv
 l/5gH3+LoW+w0HkYsvN6I85WU6I4JlglbYBHg4f3k/rSCucxukGpsEgexi4K6jVsUBxnhURJCNh
 LTuY0+phLijSBiwzd61o+5K5n9DrVus7eXTG8N7aqcRtk/O1xnMET9umwsYHrNf4eHMZ9JCB6EI
 DBdhXmlZRcE9CxeYvjc3MaKm/PYX5tHjVRjzRlzTPIbmf3DTKp4Vmo0rzdRogB28grVvffKLAh1
 f6w7Rc7f5KK6v7HIhdUW9PjqzLaeUluifXCqbtQakWNhjrRA+uGI/FQmHbc+s5kKKIE8wzlJrZ+
 sZmjMVrlPmC06ecMZ96HvX+tEryRToJB5GfJbcizHVExOsKxy7MLz2EcLMYHERmJ1AfjhmC1iiS
 s0Q/K8YxxqLX0MuA3bGAjTR1Lo/+Got0BmnUC3+GqNNN9gyUzOQofEiyXMyJeEsRSmLXKj3QnXl
 Cdbl0FdifL3uKGpZtNXSoXYx8sEqARa/ZLW71IZv3G494pd6uy3sgdNS3eukE3e3dj77HvDIe0q
 5iqKoMdOKMavc0Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We had a report from the kernel test robot that adding support for
OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION caused an "App Overhead"
regression in the fs_mark benchmark, and we dropped that series for
v6.13.

I've not been able to reproduce this problem. Even on the real hardware
to which I have access, I don't see the regression in App Overhead
values that the KTR is reporting in that test.xi

Here's the result of 10 runs of fs_mark with and without the last patch
applied. 375b976b5dbf is with that patch applied, and 08605b27815e is
without it:

               FSUse%      Count         Size      Files/sec     App Overhead

08605b27815e:     1        10240         4096        108.2         31292316
08605b27815e:     1        10240         4096        107.9         31287716
08605b27815e:     1        10240         4096        108.4         31196928
08605b27815e:     1        10240         4096        102.8         31356359
08605b27815e:     1        10240         4096        102.8         31406975
08605b27815e:     1        10240         4096        107.7         31089457
08605b27815e:     1        10240         4096        108.5         31177091
08605b27815e:     1        10240         4096        109.1         31169644
08605b27815e:     1        10240         4096        107.8         31192249
08605b27815e:     1        10240         4096        108.9         31073774

375b976b5dbf:     1        10240         4096        110.0         31741587
375b976b5dbf:     1        10240         4096        110.1         31602001
375b976b5dbf:     1        10240         4096        110.0         31833994
375b976b5dbf:     1        10240         4096        109.5         31737180
375b976b5dbf:     1        10240         4096        108.7         32027953
375b976b5dbf:     1        10240         4096        106.2         31625207
375b976b5dbf:     1        10240         4096        110.3         30842987
375b976b5dbf:     1        10240         4096        110.0         31664667
375b976b5dbf:     1        10240         4096        110.9         30925099
375b976b5dbf:     1        10240         4096        110.4         31247975

The difference is whether the last patch in this series is applied.
Adding them all up, I see about a ~0.9% regression in App overhead with
375b976b5dbf, but the Files/sec is ~2% faster in that case.

At this point, I'm not sure what to do. We don't have a clear definition
for what App Overhead represents, and I can't reproduce this. In my
testing with this, the performance of the part we care about seems to be
faster with this support enabled.

So, I'm posting what I have so far. This is a respin of that series
with a few minor changes. In particular, it should now be possible to
drop the last patch in the series, if that turns out to be the best way
to proceed.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v5:
- split out rework of SHARE_ACCESS_WANT flag masks into separate patch
- move WANT_OPEN_XOR_DELEGATION patch to the end of the series
- fix handling of OPEN4_SHARE_ACCESS_WANT_* values in nfsd4_deleg_xgrade_none_ext()
- Link to v4: https://lore.kernel.org/r/20241004-delstid-v4-0-62ac29c49c2e@kernel.org

Changes in v4:
- rebase onto Chuck's latest xdrgen patches
- ignore WANT_OPEN_XOR_DELEGATION flag if there is an extant open stateid
- consolidate patches that fix handling of delegated change attr
- Link to v3: https://lore.kernel.org/r/20240829-delstid-v3-0-271c60806c5d@kernel.org

Changes in v3:
- fix includes in nfs4xdr_gen.c
- drop ATTR_CTIME_DLG flag (just use ATTR_DELEG instead)
- proper handling for SETATTR (maybe? Outstanding q about stateid here)
- incorporate Neil's patches for handling non-delegation leases
- always return times from CB_GETATTR instead of from local vfs_getattr
- fix potential races vs. mgtimes by moving ctime handling into VFS layer
- Link to v2: https://lore.kernel.org/r/20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org

Changes in v2:
- rebase onto Chuck's lkxdrgen branch, and reworked how autogenerated
  code is included
- declare nfsd_open_arguments as a global, so it doesn't have to be
  set up on the stack each time
- delegated timestamp support has been added
- Link to v1: https://lore.kernel.org/r/20240816-delstid-v1-0-c221c3dc14cd@kernel.org

---
Jeff Layton (10):
      nfsd: fix handling of delegated change attr in CB_GETATTR
      nfs_common: make include/linux/nfs4.h include generated nfs4_1.h
      nfsd: switch to autogenerated definitions for open_delegation_type4
      nfsd: rename NFS4_SHARE_WANT_* constants to OPEN4_SHARE_ACCESS_WANT_*
      nfsd: prepare delegation code for handing out *_ATTRS_DELEG delegations
      nfsd: add support for FATTR4_OPEN_ARGUMENTS
      nfsd: rework NFS4_SHARE_WANT_* flag handling
      nfsd: add support for delegated timestamps
      nfsd: handle delegated timestamps in SETATTR
      nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION

 Documentation/sunrpc/xdr/nfs4_1.x    | 186 +++++++++++++++++++++++++
 fs/nfsd/Makefile                     |  16 ++-
 fs/nfsd/nfs4callback.c               |  54 ++++++--
 fs/nfsd/nfs4proc.c                   |  31 ++++-
 fs/nfsd/nfs4state.c                  | 190 ++++++++++++++++++++------
 fs/nfsd/nfs4xdr.c                    | 121 ++++++++++++++---
 fs/nfsd/nfs4xdr_gen.c                | 256 +++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr_gen.h                |  25 ++++
 fs/nfsd/nfsd.h                       |  10 +-
 fs/nfsd/state.h                      |  18 +++
 fs/nfsd/xdr4cb.h                     |  10 +-
 include/linux/nfs4.h                 |   9 +-
 include/linux/nfs_xdr.h              |   5 -
 include/linux/sunrpc/xdrgen/nfs4_1.h | 153 +++++++++++++++++++++
 include/linux/time64.h               |   5 +
 include/uapi/linux/nfs4.h            |   7 +-
 16 files changed, 1005 insertions(+), 91 deletions(-)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241209-delstid-bae14ec4613c

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


