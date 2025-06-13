Return-Path: <linux-nfs+bounces-12403-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CCFAD80B2
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 03:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28007189961E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 01:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922E41E3DED;
	Fri, 13 Jun 2025 01:58:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F51C84AD;
	Fri, 13 Jun 2025 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779894; cv=none; b=oaXjOROMNOsJD+P+lL8TVtxuahQuAloaSBHg01URZA8g3LekHt6dYyD8IxM8xHjeYwbmW4ag8rhTo4EoZ/Cdk9d5swSLr5KIN/e74XwlFYxj2yr2jAfqiPBsc95PHXX0FWQ48Bj5OY2+dhICuK0Agnt1nMODHa95QlEvVRDap4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779894; c=relaxed/simple;
	bh=f8QMY8mB0N1LrAKGUrjE24/b/zE5GWubtfdOBpiexTI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rmqEaFtTa2nrm1HIid8BF1Y41feF6KsJiah4+zDbzTVH/U9PsUOutzxS3t37/LS6BHszj8XF3kA5aprMLGmScs3pNIAqc0K2rmPcQkBxeUVbPCHlf/HRyxLR+av4IUJyL34kDSj6AIKDJXxqihshtBCE+zGd2NTndAJnZ948mu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 0384CC089D;
	Fri, 13 Jun 2025 01:58:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 2F5EB20025;
	Fri, 13 Jun 2025 01:58:02 +0000 (UTC)
Date: Thu, 12 Jun 2025 21:58:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, NeilBrown <neil@brown.name>, Jeff Layton
 <jlayton@kernel.org>
Subject: Unused trace events in nfs and nfsd
Message-ID: <20250612215801.2c4c0ff8@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: x719qad1fpmmsad68t94rj1wrs8aayhp
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2F5EB20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Ztyoxj3+BWsPrNZnq+hEv3EPGmd3HT/Y=
X-HE-Tag: 1749779882-397026
X-HE-Meta: U2FsdGVkX18ba4CfpSNkMDnfUmhGv2rUl4sBX6UVhqnssSHcEzMyJ25jDfRIJTZvGjJNFhd+cUm9JMDGrOckC/ZF15SS2AHFg4oBViepJ/lGowxZWJF4X4Kv+dqH6lnuJZyguknHD44xurRgmgk7CE4bxzg3RmakM8ZRPIIDhQ0cbLFbg2iqNLjLzZ0zJoZOe5dsfybX6fXnJOmxPHppO6iQOUejOqZgQQupavrqaiC4LiyhIELkzVJfISRUNLp8mWTKrgC/p4Ewn89VfcymE9PjrS/kcZ1CrOTkr0jp3pl4iC3t/flBaZge0HM+2rQyxq7Y9TGmUX8/B4+tg66OBfc+dtMpHIfQcVBXLPvrkTLlYLDChiM4/oFuTeuhf2zUWlbKvMXLzvivYTlEkiIlGA==

I have code that will trigger a warning if a trace event is defined but
not used[1]. It gives a list of unused events. Here's what I have in nfs
and nfsd:

warning: tracepoint 'nfs4_renew' is unused.
warning: tracepoint 'nfs4_rename' is unused.
warning: tracepoint 'nfsd_file_unhash_and_queue' is unused.
warning: tracepoint 'nfsd_file_lru_add_disposed' is unused.
warning: tracepoint 'nfsd_file_lru_del_disposed' is unused.
warning: tracepoint 'nfsd_file_gc_recent' is unused.
warning: tracepoint 'nfsd_ctl_maxconn' is unused.

nfs4_renew looks to never have been used.

trace_nfs4_rename() was removed by 33912be816d9 ("nfs: remove
synchronous rename code") but did not remove the event.

trace_nfsd_file_unhash_and_queue() was removed by ac3a2585f01 ("nfsd:
rework refcounting in filecache")

Events nfsd_file_lru_add_disposed and nfsd_file_lru_del_disposed were
added by 4a0e73e635e3 ("NFSD: Leave open files out of the filecache
LRU") but they were never used.

Event nfsd_file_gc_recent was added by 64912122a4f8 ("nfsd: filecache:
introduce NFSD_FILE_RECENT") but never used.

trace_nfsd_ctl_maxconn() was removed by a4b853f183a1 ("sunrpc: remove
all connection limit configuration") but did not remove the event.

-- Steve

[1] https://lore.kernel.org/linux-trace-kernel/20250612235827.011358765@goodmis.org/

