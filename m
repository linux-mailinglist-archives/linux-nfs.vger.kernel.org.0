Return-Path: <linux-nfs+bounces-21948-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LBmDmKGFWpXWQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21948-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:39:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A9E5D5005
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A46193048C25
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 11:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA03E2AB9;
	Tue, 26 May 2026 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGae/F5g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99C3E3C51
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795464; cv=none; b=f8h1v/IyxFziEZnkRjBCK1WWKMk92eKR/56zpeyOfTVawozaxiKrUDvg+V/4utvTgxc4z3Xpy625+sFLsPzjHPUQcv+oKGZnWZzLnHxuUTLOjcs4oGkIuNWore1cFdnCn0LVht8UMDQDcUdcMJL9Koc+McCo7D3iCZz4Ck+pAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795464; c=relaxed/simple;
	bh=EoKlLzVEGQUTEHhNXiSKXlzVVWBxr3b2WMKw/edAkWQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CLzK+2JE5s2VzwhgyLfPi8iyzxqPwQLr/82ZE2Jt/0vvhfXvR7h1EIlP3YGrrH/GdU2nLW2bRc6RUJXC8P0j7gXlQQWeVkuaK9QF2puUJad6qXbcpLrinEruGlK908I958d1f5HO+3CYaDi7Zt07fnnLljQmU/WTDSnGom2tUMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGae/F5g; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a88de2b52eso13036680e87.2
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 04:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779795455; x=1780400255; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OB8PxKu5O1haLqyjpxm1OAl69TGxKZ6MYUXMP5i6NZk=;
        b=FGae/F5gt2Ik/oUpNqWHN0Iyi4ZIMKpvAH1UWjZKMqm6yaHNkfhp/nDNRnXs9gbdNJ
         l/DkIDXMTsjceprFZoLzRl0k3FA2tRyLrT7n7zL8McrGik/YndLLNYAfMSmOcfZ49COE
         wUrWrQod50B1qj5H60a0F9lpgL9htN10CS/Hzd5wJd8vV5lar8bNvk5HgL7vYhDjPKPR
         /6kyEoXQVuzBx77TBmdJ4+Am3izrOnqyi46AqP2gyoU/Y7Xs8gNUIq46heCvTRwMsjfW
         VvbpwlkZHoXuTZEcUV2Oo8UrH0vjJP9OQgzUkeuOcOYSOJBc2PlSUonI+2+9p/U9E50v
         l65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779795455; x=1780400255;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OB8PxKu5O1haLqyjpxm1OAl69TGxKZ6MYUXMP5i6NZk=;
        b=HgIWNbEla+q4QrWUypA9lldsjK7ti3RY1fY5zwb/SaXVSHBj0ndPf+7XZcY7rQwqVd
         JHfEf+xeXqGn8584MUYCkIr5V+PrZ36CyXAWYGZy4Av4OPwmkbaFIXyur5Ue/sDlRG4v
         XTNW9tly2ZlxxVUuq75yO978D6p9anNvx0O97t3C15vyqLWZQCJ+M1kCEHoCTJdZkNAc
         wrygM5Xu8iRoTCm1TWrCwV5TaGt3EwzBL/1ts0MPCMilo2v/J4L5MxsxDUSR91cNUwnK
         wGKY3A9yrDKad/fQlhLWkBEa9TvSBjQR9ugQqe6ziZpfJwdwXAw/OXxXHGJFC+zPOaAZ
         pSNA==
X-Forwarded-Encrypted: i=1; AFNElJ8dDSoUlS6PMkBrS6mpBYZ+63sdiNYldi8Wskm9AHu3E54PSDVKt6+9NxnJbWKPgZ5Ft87PIp1LWMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcsZyRud7NbHC8BaLQwPc25065U61XAe9ZqHXPWWy7JSjIXbs
	mIz2k5CEbCV/DC9qA7hhIUthWgkdAD8vVbWAaKxris4kXtmt9ba+VQqn3uif0fYN
X-Gm-Gg: Acq92OGj6VYKWrsJEyCH9ICE7ujlk29wQN5EKwxSu5P6pLaKMiyAvB5l2n4MbGOJUah
	kBEIQhBKEvSGEnV0Vtw64aQNrO9VESIls2wpEaHDiLGJ7utl3hTHALuFFUrSD6JkIaaqkoi0zL0
	Oqc13aQi6DRP/X7HwO68ObChSe7GShx/9L3NnyhddiXaAq7I1Pf4JyyocnQB8XpVKH1ZNr1QfmC
	6N9jg9P3EtIGR95sw7uWTdbF+35zVuXMoXKfipwKB+DTp2DiumfLcBIDOrP9suM/ISJSSNvN6jW
	2ToHDUg5+y0UW6WPUsX5t9ZyEnQQP7gkjgbwYbAz4GwngLxBEGc6fmoAxzYZvpIYp0U3sPSV7Sr
	lUtInrUOxLJSp2T9JtnXuEG3GuSHrVLa7/4MeCYfoIXe5g9ti+zZT+jANstM21Ac9icQBtimaRs
	18A+hChM9s2f/l6WEEK9ZQe0Kn+GfEAMdaun+xXVwv8R7+GbqCWzBmYzSiYfKabuv/yoZg
X-Received: by 2002:ac2:4312:0:b0:5a8:a754:4b57 with SMTP id 2adb3069b0e04-5aa323b28e6mr4727265e87.41.1779795455040;
        Tue, 26 May 2026 04:37:35 -0700 (PDT)
Received: from [127.0.1.1] (h-62-63-197-109.NA.cust.bahnhof.se. [62.63.197.109])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa46330d9asm376332e87.59.2026.05.26.04.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:37:34 -0700 (PDT)
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Subject: [PATCH RFC 0/3] Demote to lower tier using non-temporal stores
Date: Tue, 26 May 2026 13:37:01 +0200
Message-Id: <20260526-rfc-nt-demote-v1-0-eb9c9422daef@zptcorp.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN2FFWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMz3aK0ZN28Et2U1Nz8klRdg7TEtMSUtJQUAwMzJaCegqLUtMwKsHn
 RSkFuzkqxEMHi0qSs1OQSkElKtbUAPu0T73YAAAA=
X-Change-ID: 20260526-rfc-nt-demote-0fafadfdd006
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: David Rientjes <rientjes@google.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>, 
 Frank van der Linden <fvdl@google.com>, Jonathan Cameron <jic23@kernel.org>, 
 Raghavendra K T <rkodsara@amd.com>, 
 "Rao, Bharata Bhasker" <bharata@amd.com>, SeongJae Park <sj@kernel.org>, 
 Wei Xu <weixugc@google.com>, Xuezheng Chu <xuezhengchu@huawei.com>, 
 Yiannis Nikolakopoulos <yiannis@zptcorp.com>, dimitrios@palyvos.net, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>, 
 Alirad Malek <alirad.malek@zptcorp.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21948-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,linux-foundation.org,oracle.com,google.com,suse.com,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,goodmis.org,efficios.com,cmpxchg.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,stgolabs.net,gmail.com,kernel.org,amd.com,huawei.com,zptcorp.com,palyvos.net,arm.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yiannisnikolakop@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A2A9E5D5005
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In most memory tiering scenarios, the memory to be demoted is expected
to be cold and most likely out of the node's last-level cache (as well
as target pages in the target node). Using non-temporal stores instead
of a standard memcpy path can reduce the cache pollution in the local
node and the bandwidth overhead to the target node. Furthermore, for
certain types of CXL devices that support in-line memory compression,
the last-level cache eviction patterns can negatively affect the
bandwidth of the device. Non-temporal stores can mitigate this.

This patch-set introduces a new migrate_mode flag for using non-temporal
stores that is used only in the demotion path. Patch 1 adds some helpers in
x86 and mm to bring non-temporal stores support to a respective folio_copy
function. Patch 2 adds the new flag and necessary changes for compatibility
with the existing behavior. Patch 3 uses the new flag for demotions and
guards this by a Kconfig option.

Experimental data: in a CXL system with 1 memory expander, a microbenchmark
that allocates N=64 GB memory in the local node and then triggers demotion
using memory.reclaim, shows a practically complete elimination of read
traffic on the device, i.e. write traffic is N GB with and without the
patch, while read traffic drops from N to almost 0 with the patch.

Opens:
1. There is some "duplication" in the x86 tree and a bit in mm. Can we do
   something better there? As it is now in copy_mc_to_kernel_nt we
duplicate the machine check functionality, which if available will override
the non-temporal. We were not sure how to prioritize these two and what's
the best approach here. Can we completely skip the machine checked for this
path?
2. We've hidden the use of the new flag behind a Kconfig option. Is this
   the right way to add this?  
3. We have not carefully considered how this should be structured so that
   it is easily adopted in other architecture trees (e.g. aarch64). Arm
support is currently out of our scope but any input is appreciated.

Signed-off-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
---
Alirad Malek (3):
      mm, x86: support copying a folio using non-temporal stores
      mm: new migrate_mode flag for async using non-temporal stores
      mm: use non-temporal stores for demotion

 arch/x86/include/asm/uaccess.h |  4 ++++
 arch/x86/lib/copy_mc.c         | 26 ++++++++++++++++++++++++++
 fs/nfs/write.c                 |  2 +-
 include/linux/highmem.h        | 32 ++++++++++++++++++++++++++++++++
 include/linux/migrate_mode.h   |  9 +++++++++
 include/linux/mm.h             |  1 +
 include/trace/events/migrate.h |  1 +
 mm/Kconfig                     |  8 ++++++++
 mm/compaction.c                | 18 +++++++++---------
 mm/migrate.c                   | 21 ++++++++++++++-------
 mm/util.c                      | 17 +++++++++++++++++
 11 files changed, 122 insertions(+), 17 deletions(-)
---
base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
change-id: 20260526-rfc-nt-demote-0fafadfdd006

Best regards,
--  
Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>


