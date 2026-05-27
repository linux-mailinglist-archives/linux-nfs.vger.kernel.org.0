Return-Path: <linux-nfs+bounces-22011-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCy3KHcIF2oo1wcAu9opvQ
	(envelope-from <linux-nfs+bounces-22011-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:06:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFEA5E688C
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B1EA3065E94
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9F3644C7;
	Wed, 27 May 2026 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAAOis8u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D7A426685;
	Wed, 27 May 2026 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894023; cv=none; b=uDofXx/CKbiXcmdWTuAijPjENjZiq8bWJoRcoB8E6OJSw8aZK7QsgKcVfE6AonHBvivpvVJnagW8obR2J3PxT7/uOfIqgSzGp07tPA86/6V1blD00Xr9CXNfbxlqRw83ADaBfwkJ4NUSBOFeYfbcwznJj2tVpRPqWrRMka9GZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894023; c=relaxed/simple;
	bh=suZFFmVjLw0fekZJ2nMJzwOTmxsjSPf1W+iwq6xAudM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CKyl/x3hFaJqyN9BORa40YVjE1L2DA/Rfa0mAupHO4nRKmxR0T84MQmhWr5neYGIvWEqOsGtks1uacuHlJC3G34cEId0oiEw6VhYzsSSFdjWoYoyvFfNnsjj91INwLlWYnqoJ6EL59FPx/Byq85PTpWH1x6suI7mCsVx5UgcVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAAOis8u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344061F000E9;
	Wed, 27 May 2026 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894021;
	bh=c2gJU04MIg2HU5/t08CF5fBe7NOaONIgH0Q7NYG03wc=;
	h=From:Subject:Date:To:Cc;
	b=VAAOis8uMCmsdqrQMlBQNUoYKTClrX1E7b/ULie06VfuTRXpoHqTPM3cvPtzhJvBS
	 v/aJTmzSVsJ9kCrKSGurVAUftuKubhclr9gfZmCWPE2/DfHJwwMAbtMwStV7B5IB9F
	 HYXMEqvCjt+UVBPehhBAzdSjaSw5jqjmeckxt/I2cB1+fQLPsseqNjsWTyfbVuboAz
	 thnKu4MoSjYSuB6FItnlEPkelhK4/5VWVDFNKAr4xPTGsq88GUE1gS67WAV22CaDn5
	 IEuFiUf1MoKvkNnghvXBIqXxCIpI3h7AssEglf5iUGb5dIPapiHSoDm2zaqinJv0YW
	 V+NxhDRqyZnqw==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 0/5] Fix resource lifecycle bugs in svcrdma transport setup
 and teardown
Date: Wed, 27 May 2026 11:00:10 -0400
Message-Id: <20260527-rdma-follow-on-v1-0-1b09bd87b6cd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw7CMAwFr1J5jaU2UJC4CmKRj9MaFQfF4SNVv
 TsJLOfpzayglJkUzt0KmV6snKTCsOvAz1YmQg6VwfTm2I/mhDncLca0LOmNSdDR6MNgDntLDqr
 0yBT58wtern/Wp7uRL63SHs4qoctW/NwmiRqwkBaWCbbtC/nsqRCRAAAA
X-Change-ID: 20260527-rdma-follow-on-be5cd1243aeb
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chris Mason <clm@meta.com>, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2238;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=suZFFmVjLw0fekZJ2nMJzwOTmxsjSPf1W+iwq6xAudM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFwb9hcQdCR3rcud+ZmspiLwnd9y3NCD/mbnrg
 NDpOpD+UC2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahcG/QAKCRAzarMzb2Z/
 l5IAD/94unkZowZRiZ4vlfjzCueW6KIUbaekPungxA+1yPpMKtjzUobWTKlz9gPQh/A+B1zJoUW
 F10X3YOpWIjVXAUBoeL8I+EBiVaZ8Vn5Uh9e1bEKfSYbuXIGo3khneUOwv2tfOtjNaxmhXGijDb
 phR4KTHdLuNRsXJgX3Dwu+83LT9NHgvIQ/PGbIUFvQHKtswXkyFHgK+YK6SuqloKz0zNxaBnqpZ
 +zKKkDIgfO/WJnkO8cLq8G5G9uoS5JFnBED9/EhO/rwEkjhQ6YnquqYvOAY7OHQp3RXo/b5oWng
 Xi278MJG9ipXNEz05dm/gGTTrI5qyDne2+LQbd1qfO7EzMjG1YQQnfbTynxd+tlOcuJD3dF08Ep
 zGfqrsHDGGzAIKXXrT2F5RBTADa6QjtWapfYK4lFx9R5e6uHDxXarJ4MSOEBikE4Mzskq200dq2
 FM/U6hEhhYgoHE1iFkdg1QDqFe20FBkXNEvAr+NySIW5AI9oADNYJwcYP6qsSXjjxwHwEx0Qgk6
 jifXi+Gm+e1bIz5E7pHSfYdbZ179uZ3VpODLJumgys4Z4SLWPUVkiFvwHsxDdI/X3NWLuWEd9L4
 5a0iK968wjNaPmSiZ2/z/+U9r7lofWVHB/Ek1NSSfTKvhoPxQMxC2nkgvKbNQLsPrqFSQyNZO1K
 D6WL3KVrZc6phiA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22011-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 3BFEA5E688C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Several resource lifecycle bugs lurk in svcrdma's transport
creation, acceptance, and teardown paths. This series addresses
those bugs. Two design choices span the series:

The first is the rn_done sentinel. rpcrdma_rn_register() assigns
rn->rn_done only after xa_alloc() and kref_get() have both
succeeded, making rn_done == NULL a natural "never registered"
marker. Adding an early-return guard in rpcrdma_rn_unregister()
turns it into an idempotent operation -- callers no longer need to
track whether registration completed before calling unregister.
The accept error path, the reordered free path, and any future
partially-constructed transport that reaches svc_rdma_free() all
rely on this single mechanism rather than separate boolean flags.

The second is routing error-path teardown through svc_xprt_put()
instead of inline cleanup. The accept error path previously did
manual ib_destroy_qp / rdma_destroy_id / rpcrdma_rn_unregister
sequences and then leaked the svcxprt_rdma; the listener create
path called kfree() directly, bypassing svc_xprt_free()'s net
namespace release. Both now drop the kref_init() birth reference
via svc_xprt_put(), which dispatches svc_rdma_free() where the
existing NULL/IS_ERR guards (plus the new rn_done sentinel) handle
partially-constructed state. A consequence is that svc_xprt_free()
drops a module reference, but each caller's failure path also puts
one, so a compensating __module_get() is taken before the
svc_xprt_put().

---
Chris Mason (1):
      svcrdma: Fix unmatched rn_unregister on failed accept

Chuck Lever (4):
      svcrdma: Reorder rpcrdma_rn_unregister before rdma_destroy_id
      svcrdma: Use svc_xprt_put to free listener on create failure
      svcrdma: Reject connection when transport allocation fails
      svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement fails

 net/sunrpc/xprtrdma/ib_client.c          | 24 ++++++++++-
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 69 +++++++++++++++++++++++---------
 2 files changed, 74 insertions(+), 19 deletions(-)
---
base-commit: b69fc3eaa867d0caa904634ea7a1b4569411b163
change-id: 20260527-rdma-follow-on-be5cd1243aeb

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


