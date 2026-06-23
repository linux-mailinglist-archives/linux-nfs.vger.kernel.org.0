Return-Path: <linux-nfs+bounces-22778-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mILAJZdZOmoy6wcAu9opvQ
	(envelope-from <linux-nfs+bounces-22778-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 12:01:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EE96B60A2
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 12:01:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ioMugKa4;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22778-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22778-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D641300729D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jun 2026 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C943A34B183;
	Tue, 23 Jun 2026 10:01:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E533A9FE
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 10:01:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208913; cv=none; b=UKB1iScrqZYvL49XwnqRBoTyrReIUwN3cSSiT7xTu2YXGpYhc8CE2G433GxromEc81kbBubyp5n5rI2mFmcJEOqLh3vK4kmf0IDU1vt+X0YbrrBr9WDBGh1kXfdQSAzSIVQ2RFP4KCYMTUXCpOqqrKety77wfZFfzim25N2swMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208913; c=relaxed/simple;
	bh=4FychGiQokW8myhu14rFsgDtjxa3yPjm1iGI3LvR/k4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XslpJwbDO84lEwe0vz8XdfiLCJSXHc42usT6UH19YvUWjOTGywNsutP4HHdYrxzWvoZTR1+yo27aK+8TX4PB2Att3KHAlk4TzCAAA3AF+nyAgzL8SM6MhObNTsiFkBbWbtvgkBD1vVHKxeeCdkb5VY+F5quZxyHGxZojNcr5Lcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioMugKa4; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-842358aaf36so2367034b3a.2
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jun 2026 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782208912; x=1782813712; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tNSWRZXsCCBKPrvOedC4pwja5q458btxYd/tRhWFRqg=;
        b=ioMugKa4k0dj43SKeq2XGJ8fdR3VdiaHTLLGdyuXY2KgZRxCXWigNfZWfGkXeNugNa
         tvvhEFLpTjJudbiqAQye9rWMknESTVysnRNiHPXVJZZqgYPiZLmEQYY2MkV/N/x96zs5
         DDbroRTK2x0XvpZOpJj3QrMFKvN1wdvEefHI5rHZGhkXPWKH4K43KGG2Doka+eH3PyR1
         Chws+6h+GyJ3v9YqBQ4ymqeE8noL5s9WQobMoQCGlaH/uk4cn60n6GH/Iw81vDziRBrL
         JvrVoUkQmUdsIOywCff6BjgYjiTzoLxZR+utxohCFZ8cNolujT/epH5UGYmNSbPi6xfF
         Dttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782208912; x=1782813712;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNSWRZXsCCBKPrvOedC4pwja5q458btxYd/tRhWFRqg=;
        b=s6dkxCI6OgWbzDpqLvAw2szODuoZ72npfP+2fyneo8wO81dCCKCpKj/rSCcl6KG+tg
         aHG93DxQ2u+pz/kQ5Y6X+TKncS/b1KkZL9aRYCkGA93U7ZcWE+gloRjl8pSEjOaqBw1u
         xXiwN8Ujp8VmnH1/pzPJ9E1jCGStQJfne/lYplXNcL9dtt28ZxNptLB5R4HikB3h9zIB
         8uzWa+CTPUNQea85X7ElvZnhaLMx6s7uO0Ttpy7OCYWYj96s5/aJHzTvIHsswLmyY2aj
         livzYTKLNAH4XxN2hSgXqNZRRESzZdOCyq6DGbM8BTqYiHgv020LptmqINsD9YMs/856
         Xm1g==
X-Gm-Message-State: AOJu0YxsmpxnZGTbmmX79V7ld13eM8jyrDpGkaOvOipv0P9xZCX3Z9ut
	uGDFz3n+gzyCDK3qeHMEKYjSXsgN2l93JyEYFk8z4PegDQxwZk0ISVsxtLDxcA==
X-Gm-Gg: AfdE7ckRjSxe52dTA6iDZzFLwF84tJSn5pyzzvyJIu0gBz14wyV9ZeQF4kCg+hB7hgL
	6xE/zeAFd6J03IQma3EgMkvpnD/a996TQHDghjvRjw6e5N8oF84hZs88Z4NJQI5Wh3eGgcu0f7w
	lltzmntbH9Jxzns6YJWGKVmachaZfhAy5UVSMnsYA8G3Fi9KmDUkyN1/RnkJwgUq4ZQJRcv/c/+
	CiTmMrQGrU8qPm3QLq16Ia9XLbxKTOoX92H9TaP9STpJy097jCUcTmuWbClUPkxLLLY1TGo+Rbn
	A+celxrSSSHZzXOwJmYuKplSeqGPXQUDe5bt2xiQLMkFq82nY6wYsBhYNXPVqU2h4bDTEG/hCm+
	2aRSxneswkME7Ip8mxiNMJCgZT4Ev7Mn+gnMVvGwOnOyfL4sOZnJ7OH6JSTuZRKsq++fLuLjWRY
	nzcG0YyUpD637S47y2Abm2wno8rq1XkiGr7NrHVdQ=
X-Received: by 2002:a05:6a00:2a03:b0:835:405a:7e6d with SMTP id d2e1a72fcca58-845970eb55bmr2289433b3a.21.1782208911487;
        Tue, 23 Jun 2026 03:01:51 -0700 (PDT)
Received: from localhost ([49.207.146.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e7696dsm13856411b3a.37.2026.06.23.03.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 03:01:50 -0700 (PDT)
From: Piyush Sachdeva <s.piyush1024@gmail.com>
To: linux-nfs@vger.kernel.org, cel@kernel.org, trondmy@kernel.org,
 sfrench@samba.org, sprasad@microsoft.com
Cc: vaibsharma@microsoft.com
Subject: NFS delegations behavior analysis
Date: Tue, 23 Jun 2026 15:31:45 +0530
Message-ID: <m2qzlx7eye.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22778-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:cel@kernel.org,m:trondmy@kernel.org,m:sfrench@samba.org,m:sprasad@microsoft.com,m:vaibsharma@microsoft.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[spiyush1024@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spiyush1024@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70EE96B60A2

Hi,
Lately I have been running micro benchmarks around the `ls` command and
reading through the code documentation of the NFS client to better
understand the client side caching behavior with and without
delegations.

Understanding so far:
Delegations (both file and directory) are granted by the server to the
client, indefinitely (until revoked or under the watermark) to cache
attributes. The caching of data is a result of the attribute
cache. Hence forth, a directory delegation will cache the directory
attributes and the names of the files in the directory, and a file
delegation will cache the attributes of the file and the file data.

Workload run:
I focused on the 2 workloads below, doing 2 passes of a large flat
directory (with close to 100K files) - 
a cold pass, and warm pass using the cache from the cold pass:
- lslr - ls -lR on both runs
- lsmix - ls -R (cold) and then ls -lR (warm)

I also played with the rdirplus behavior using both the default
heuristic behavior and the `rdirplus=force` set at mount time.

Numbers:
actimeo=5s, rdirplus=force, ACLs off, flat_dir
==================================================================

                 |         LSLR          |         LSMIX
                 |  (ls -lR cold / warm) |  (p1 ls -R / p2 ls -lR)
Operation        |  flat cold  | flat warm |   flat p1   | flat p2
-----------------+-------------+-----------+-------------+---------
READDIR calls    |    27       |     0     |   27        |    0
READDIR recv B   | 23,603,024  |     0     | 23,603,024  |    0
   call type     | readdirplus |    --     | readdirplus |    --
LOOKUP           |     1       |     0     |    1        |    0
GETATTR          |     3       |  100,000  |    2        | 100,001
ACCESS           |     2       |     0     |    2        |    0
-----------------+-------------+-----------+-------------+---------
Elapsed (age)    |  ~14 s      |  ~62 s    |   ~16 s     |  ~63 s


Observations:
When doing `ls` or `ls -l` on a directory, due to the open(2) on the
directory, the client gets a directory delegation - caching the
directory attributes and file names. However, as we don't have file
delegations due to no open(2) calls to any of the files. Henceforth,
the cache of file attributes is governed by `actimeo`.
Now here is the interesting bit, if the next `ls -l` is issued after
the `actimeo`, a massive GETATTR storm hits the server, doing stat()
calls for every file in the directory. As a result, the performance of
this warm `ls -l` run ends up being worse than the cold pass. I am
guessing this is most likely due to the compounded "rdirplus" being more
efficient than stat() calls.


Proposal:
For large directories, this ends up being a massive problem, taking 1-2
minutes when enumerating a directory on the warm passes.
- An easier way to tackle this could be to do a rdirplus=[auto | forced]
  instead of issuing the stat(2) storm to the server: When the client
  notices that there are cache misses, which would be the case of file
  attributes, instead of fetching file names from the directory-delegation
  cache and attributes from GETATTR, the client does a READDIRPLUS to
  the server, nonetheless.
- A more tedious would be the to cache file attributes as well, as a part
  of the directory delegation. This would end up requiring a change in the
  NFS protocol spec though.
- Bulk GETATTR calls: I am uncertain of the feasibility of this, but
  what if, the client could do 1 GETATTR call for getting attributes
  for multiple files. 

-- 
Piyush

