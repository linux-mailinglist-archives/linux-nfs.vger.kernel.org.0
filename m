Return-Path: <linux-nfs+bounces-21371-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFHrD9Wn92k/kQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21371-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 03 May 2026 21:53:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F337D4B72EB
	for <lists+linux-nfs@lfdr.de>; Sun, 03 May 2026 21:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 739273009014
	for <lists+linux-nfs@lfdr.de>; Sun,  3 May 2026 19:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E83A6F05;
	Sun,  3 May 2026 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="gLt8R0w6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E02773C3
	for <linux-nfs@vger.kernel.org>; Sun,  3 May 2026 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838032; cv=none; b=Z3RxGasGXiTAa0o1ZNFtBmdochBcYQw/lNEA5In5Dg5mZAy13xWhaHLqANYJXWng2GfF+vVac4XD4zuM4ZWyNVVUYmcMLqt06yl+IwQQWkazJ6VqYS7agcOtRIW57WQtRvuHGU6gd1tYbM5IhgptS7s25eDq8YfJZ89FNDUyyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838032; c=relaxed/simple;
	bh=JfMGdIbiT2KdVHz8g0viJ1GpkDYuCJYV2rWnOwAWMT0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MHqcLkM3/+y4wEcEGR+MSgNrlaBnykbwtU4QLtLq4ls42q1l9Uy5zB91MSmk+m6pWHPYznMsnFtnYM+SlgDYs0KQbucPprMjnq4IGz0VSILCd/9xmNMWI1GBH/36mdBWW9I+6LwgKHgjgUpcW0uQzCpHrmpUHc+p4BuYCcwR058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=gLt8R0w6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d7e23defbso1908496f8f.0
        for <linux-nfs@vger.kernel.org>; Sun, 03 May 2026 12:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1777838028; x=1778442828; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nc4ouqvmyuFYLLFWfP/eIRW8O+xQJ4l+PCrNjSXuyTM=;
        b=gLt8R0w6xEj5VGInipc+Tkd8NYqPhw6ejM4+1gbdBOPoEJ8qDamAhiaK1mlv/KWUX/
         Xo4tbC3ntqpz0UGYzGtyEDoJWREYwrZE/uyRKGAnwADWl175PrkD0BvVWzkc12fTs51h
         eSEIInUkHbt4gNlL5rN4HY/oSdwi7gkIN3dKnk/3iCEU1N9805vbA9kbPSAE4/cT2mVP
         2uzMTCRcSday7/nm55WBzDsfNZgt0UEkLpRLu8A1zMpVLaBKM1Bexv+mYgOnaYJgrhaS
         S/IZyuCjHZt1Gd0tx3y6hsMXX5m+rjCYBLSq4xhB+HYc9TQpFOK6z699q58dp76crfeu
         yDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777838028; x=1778442828;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nc4ouqvmyuFYLLFWfP/eIRW8O+xQJ4l+PCrNjSXuyTM=;
        b=Jpu5+bjwd8ROceRgXWMwL6m8pXpQQ7bDhMb+v4slzxZeWe/OsWNFkFdAuD0YZkDr5U
         kQpT3bUHWM1PlCIpuU7UC5S1QsI2kmIIvgvTJtblAp83HC6DFtW/mUE7zFUf3dat3XBc
         HG6hfgr23yG2W9RlXkUs2HG+2TePQr2eTHZuzgII+D8JiQXhaUZKwNe92+L/DTbhk46P
         VeaMEdXP+PMpwjpru7VFwY2JMmGr3m8YaXLl/d4bPP460R3UFOkS+SdNDZ2GlLC7/J2A
         Z+iV8lO9QVcdFrL6mkf74gJed/hwbLpuqQErcpP47p6C3hDignBFUFWZDSAf0FL2I54D
         m3pQ==
X-Gm-Message-State: AOJu0Yy/cSxDzEh0ADltsg6IA1mvVa1BOZhno5u0md/9QK6Sxt5Uwg+d
	SR91KCoCoWedbNS2QjVo/WmOu7Ee8eA/vQhcR5VoekzGCvyU8+Z61vGkedLhdLnOmvJFOTM28SB
	1+RXU4yDXfrYHorLCYs9Vji1cGsjqZMH3ULDhtEgpYdHSd3mQQqIbiiC5FtU3aMXiePKNmxHShk
	Fvllp/lLMl333nAVDuxlfAOTGNydfvhfrwYGNsNjicNF2QWBU7c3XULbnLJvZe
X-Gm-Gg: AeBDietm5f+axO+/p1dPLEv/cYLDUC3nzmPw/fdt1dnrN23X0IU+IdBp/MFaxcat8KE
	1Jjdsl9IyeF7FqkUoNL+2hm+XwyJClu1u7PF3FmvdPuaC30T/C5pE4x8NGhENo1yzRsh/S1DfUM
	iuiJ3yP6kNL8Ycef72r8hI228PyNeeYjSpW6abvTV/kZeSGV/WVuboQ4iDeLNERFcDTVYlRN1x6
	vldavP47kpLjx9VVynrMNtK+hFVd1TLleBQk5Ug/ZZL2pvTslG2NSq0vnEpmHV6h4Jr5II/ZziF
	Uh237M7neer9AYXwkcqZNZVhihuAClexLtDj9+pdO5rd6nRpFQ8kTx4wATwDVXTpMuXr7wtapyu
	AkP8jY7sgT4YyqsPYP2S3tiODzHcdy49nlkWKE7NDLF1GSv4sdHypcGr+3vD5Sv2Ab2+lj0xCmh
	C/OrcM7NwI2GutOcqyOp+sUqaqv+K8hOKUGaJPpEkH7CgE9YDDo1IdwuTieAAoidssxf/p2P3tL
	+IM63Drlg5Z67FN9cd6ejXUdkb8Xg==
X-Received: by 2002:a05:6000:4312:b0:43d:300b:2285 with SMTP id ffacd0b85a97d-44bb32fd70cmr11638437f8f.11.1777838028438;
        Sun, 03 May 2026 12:53:48 -0700 (PDT)
Received: from [192.168.50.79] (46-116-175-134.bb.netvision.net.il. [46.116.175.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a986aaad6sm18033489f8f.28.2026.05.03.12.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 12:53:47 -0700 (PDT)
Message-ID: <40e3d522-dfcf-4fc1-9c55-b5e81f1536d5@vastdata.com>
Date: Sun, 3 May 2026 22:53:45 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Dan Aloni <dan.aloni@vastdata.com>,
 roi.azarzar@vastdata.com, sagi.grimberg@vastdata.com
From: Michael Nemanov <michael.nemanov@vastdata.com>
Subject: [RFC PATCH] Possible use-after-free bug in mTLS connect
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F337D4B72EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[vastdata.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[vastdata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-21371-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[vastdata.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.nemanov@vastdata.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[connect_worker.work:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The NFS-over-TLS implementation seems to have a use-after-free bug where
a raw unrefcounted pointer to an rpc_clnt is stored in xs_connect() and
accessed by a delayed workqueue item after the client has been freed.

The issue manifests when an NFS mount uses incorrect credentials (client
cert is valid but does not match the server's) during TLS setup,
leading to the client being freed while a delayed work item still
holds a pointer to it.

The patch contains several debug traces that hopefully illustrate the problem
and a key msleep(100) that helps (though not guarantees) reproduction.
I had to use pr_debug as the bug often involves a kernel crash and logs can
only be collected from vmcore-dmesg.
Used with kernel v7.0-rc5.

Traces from vmcore-dmesg.txt showing the lifecycle of the RPC
client from creation to use-after-free:
  [   38.611952] New mount #5
  [   38.630156] @ rpc_new_client: New: 00000000f636d223, parent: 0000000000000000	<< Client created
  [   38.630179] @ xs_connect: Queue connect work in 0 for clnt 00000000f636d223
  [   38.630209] @ xs_tcp_tls_setup_socket: Using clnt 00000000f636d223
  [   38.630258] @ rpc_new_client: New: 0000000004f8c0fe, parent: 0000000000000000
  [   38.630265] @ xs_connect: Queue connect work in 0 for clnt 0000000004f8c0fe
  [   38.752404] @ rpc_shutdown_client: 0000000004f8c0fe
  [   38.752474] @ rpc_free_client: put_cred 0000000004f8c0fe
  [   38.752489] @ xs_tcp_tls_setup_socket: Done with clnt 00000000f636d223. status=0
  [   38.752573] @ rpc_free_client_work: xprt_put done for 0000000004f8c0fe
  [   38.752955] @ xs_sock_process_cmsg: TLS alert -13, level 2
  [   38.753069] @ xs_tcp_state_change: sk_state=8
  [   38.857474] @ xs_reset_transport: Null transport->sock for xprt 0000000066fa6fda
  [   38.857558] @ xs_connect: Queue connect work in 0 for clnt 00000000f636d223	<< Client used
  [   38.857574] @ xs_tcp_tls_setup_socket: Using clnt 00000000f636d223
  [   38.857677] @ rpc_new_client: New: 00000000d1455d7f, parent: 0000000000000000
  [   38.857684] @ xs_connect: Queue connect work in 0 for clnt 00000000d1455d7f
  [   38.975657] @ rpc_shutdown_client: 00000000d1455d7f
  [   38.975728] @ rpc_free_client: put_cred 00000000d1455d7f
  [   38.975742] @ xs_tcp_tls_setup_socket: Done with clnt 00000000f636d223. status=0	<< Client used
  [   38.975836] @ rpc_free_client_work: xprt_put done for 00000000d1455d7f
  [   38.976220] @ xs_sock_process_cmsg: TLS alert -13, level 2
  [   38.976269] @ xs_tcp_state_change: sk_state=8
  [   38.976303] @ xs_connect: Queue connect work in 3000 for clnt 00000000f636d223	<< Client used
  [   39.065470] @ rpc_shutdown_client: 00000000f636d223
  [   39.065580] @ rpc_free_client: put_cred 00000000f636d223				<< Client being destroyed
  [   42.033267] @ xs_tcp_tls_setup_socket: Using clnt 00000000f636d223			<< Client used
  [   42.033481] @ rpc_new_client: New: 00000000762dc139, parent: 0000000000000000
  [   42.033505] @ xs_connect: Queue connect work in 0 for clnt 00000000762dc139
  [   42.153240] @ rpc_shutdown_client: 00000000762dc139
  [   42.153274] @ rpc_free_client: put_cred 00000000762dc139
  [   42.153283] @ xs_tcp_tls_setup_socket: Done with clnt 00000000f636d223. status=0
  [   42.153297] @ xs_reset_transport: Null transport->sock for xprt 0000000066fa6fda
  [   42.153355] @ rpc_free_client_work: xprt_put done for 00000000f636d223
  [   42.153373] @ rpc_free_client_work: xprt_put done for 00000000762dc139
  [   42.153419] @ xs_reset_transport: Null transport->sock for xprt 0000000093fd6749
  [   42.164197] ------------[ cut here ]------------
  [   42.165779] refcount_t: underflow; use-after-free.
  [   42.166596] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x5e/0x90, CPU#5: swapper/5/0

And for reference, a non-crashing attempt:
  [   16.756822] New mount #1
  [   17.122657] NFS: Registering the id_resolver key type
  [   17.123591] Key type id_resolver registered
  [   17.124329] Key type id_legacy registered
  [   17.131019] @ rpc_new_client: New: 0000000074283ee9, parent: 0000000000000000
  [   17.131035] @ xs_connect: Queue connect work in 0 for clnt 0000000074283ee9
  [   17.131042] @ xs_tcp_tls_setup_socket: Using clnt 0000000074283ee9
  [   17.131108] @ rpc_new_client: New: 00000000b25a12a5, parent: 0000000000000000
  [   17.131114] @ xs_connect: Queue connect work in 0 for clnt 00000000b25a12a5
  [   17.254743] @ xs_``tcp_state_change: sk_state=8
  [   17.262363] @ rpc_shutdown_client: 00000000b25a12a5
  [   17.262398] @ rpc_free_client: put_cred 00000000b25a12a5
  [   17.262404] @ xs_tcp_tls_setup_socket: Done with clnt 0000000074283ee9. status=0
  [   17.262448] @ rpc_free_client_work: xprt_put done for 00000000b25a12a5
  [   17.473543] @ xs_reset_transport: Null transport->sock for xprt 000000004c2083b6
  [   17.473597] @ xs_connect: Queue connect work in 0 for clnt 0000000074283ee9
  [   17.473606] @ xs_tcp_tls_setup_socket: Using clnt 0000000074283ee9
  [   17.473709] @ rpc_new_client: New: 00000000c549945c, parent: 0000000000000000
  [   17.473717] @ xs_connect: Queue connect work in 0 for clnt 00000000c549945c
  [   17.591937] @ rpc_shutdown_client: 00000000c549945c
  [   17.591977] @ rpc_free_client: put_cred 00000000c549945c
  [   17.591984] @ xs_tcp_tls_setup_socket: Done with clnt 0000000074283ee9. status=0
  [   17.592030] @ rpc_free_client_work: xprt_put done for 00000000c549945c
  [   17.592534] @ xs_sock_process_cmsg: TLS alert -13, level 2
  [   17.592564] @ xs_tcp_state_change: sk_state=8
  [   17.592569] @ rpc_shutdown_client: 0000000074283ee9
  [   17.592608] @ rpc_free_client: put_cred 0000000074283ee9
  [   17.593105] @ rpc_free_client_work: xprt_put done for 0000000074283ee9
  [   17.593148] @ xs_reset_transport: Null transport->sock for xprt 000000004c2083b6

Note that on some iterations, the queued work runs successfully
despite using a freed client. Not sure if this is of interest.

Reproduction script:

```bash
sudo echo 'file net/sunrpc/clnt.c +p' > /sys/kernel/debug/dynamic_debug/control
sudo echo 'file net/sunrpc/xprtsock.c +p' >> /sys/kernel/debug/dynamic_debug/control
sudo mkdir -p /mnt/export

for i in {1..1000}; do
        echo "Iteration $i"
        echo "New mount #$i" | sudo tee /dev/kmsg
        sudo mount -o vers=4.2,proto=tcp,xprtsec=mtls remote_addr:/opt/export /mnt/export
        sleep 5
done
```

What I understand:
The connecting task terminates, presumably due to the fatal TLS error as
expected. The upper client is being destroyed: `rpc_shutdown_client`
down to `rpc_free_client`, which *puts the creds* that would be used
by queued connect work.

Where I need help:
I don't understand if the use-after-free is the root cause and must be
fixed or a symptom of a problem elsewhere.
I am also not sure what causes the bug to manifest. It *might* be related
to the timing of server's FIN (sk_state=8 in the log) and the
flags it changes.
Any guidance or pointers on where to look next would be much appreciated.

Thank you for reading,
Michael.

Signed-off-by: Michael Nemanov <michael.nemanov@vastdata.com>
---
 net/sunrpc/clnt.c     | 4 ++++
 net/sunrpc/xprtsock.c | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index bc8ca470718b..dbc7d51f073d 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -429,6 +429,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 		refcount_inc(&parent->cl_count);
 
 	trace_rpc_clnt_new(clnt, xprt, args);
+	pr_debug("@ %s: New: %p, parent: %p\n", __func__, clnt, parent);
 	return clnt;
 
 out_no_path:
@@ -949,6 +950,7 @@ void rpc_shutdown_client(struct rpc_clnt *clnt)
 	might_sleep();
 
 	trace_rpc_clnt_shutdown(clnt);
+	pr_debug("@ %s: %p\n", __func__, clnt);
 
 	clnt->cl_shutdown = 1;
 	while (!list_empty(&clnt->cl_tasks)) {
@@ -983,6 +985,7 @@ static void rpc_free_client_work(struct work_struct *work)
 	rpc_free_clid(clnt);
 	rpc_clnt_remove_pipedir(clnt);
 	xprt_put(rcu_dereference_raw(clnt->cl_xprt));
+	pr_debug("@ %s: xprt_put done for %p\n", __func__, clnt);
 
 	kfree(clnt);
 	rpciod_down();
@@ -1000,6 +1003,7 @@ rpc_free_client(struct rpc_clnt *clnt)
 	clnt->cl_metrics = NULL;
 	xprt_iter_destroy(&clnt->cl_xpi);
 	put_cred(clnt->cl_cred);
+	pr_debug("@ %s: put_cred %p\n", __func__, clnt);
 
 	INIT_WORK(&clnt->cl_work, rpc_free_client_work);
 	schedule_work(&clnt->cl_work);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 2e1fe6013361..cc4275e0b276 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -377,6 +377,7 @@ xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
 		tls_alert_recv(sock->sk, msg, &level, &description);
 		ret = (level == TLS_ALERT_LEVEL_FATAL) ?
 			-EACCES : -EAGAIN;
+		pr_debug("@ %s: TLS alert %d, level %d\n", __func__, ret, level);
 		break;
 	default:
 		/* discard this record type */
@@ -1297,6 +1298,7 @@ static void xs_reset_transport(struct sock_xprt *transport)
 	transport->inet = NULL;
 	transport->sock = NULL;
 	transport->file = NULL;
+	pr_debug("@ %s: Null transport->sock for xprt %p\n", __func__, xprt);
 
 	sk->sk_user_data = NULL;
 	sk->sk_sndtimeo = 0;
@@ -1589,6 +1591,7 @@ static void xs_tcp_state_change(struct sock *sk)
 		 */
 		if (xprt->reestablish_timeout < XS_TCP_INIT_REEST_TO)
 			xprt->reestablish_timeout = XS_TCP_INIT_REEST_TO;
+		pr_debug("@ %s: sk_state=%d\n", __func__, sk->sk_state);
 		break;
 	case TCP_LAST_ACK:
 		set_bit(XPRT_CLOSING, &xprt->state);
@@ -2688,6 +2691,7 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 	struct sock_xprt *upper_transport =
 		container_of(work, struct sock_xprt, connect_worker.work);
 	struct rpc_clnt *upper_clnt = upper_transport->clnt;
+	pr_debug("@ %s: Using clnt %p\n", __func__, upper_clnt);
 	struct rpc_xprt *upper_xprt = &upper_transport->xprt;
 	struct rpc_create_args args = {
 		.net		= upper_xprt->xprt_net,
@@ -2759,6 +2763,7 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 	current_restore_flags(pflags, PF_MEMALLOC);
 	upper_transport->clnt = NULL;
 	xprt_unlock_connect(upper_xprt, upper_transport);
+	pr_debug("@ %s: Done with clnt %p. status=%d\n", __func__, upper_clnt, status);
 	return;
 
 out_close:
@@ -2806,6 +2811,7 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);
 
 	transport->clnt = task->tk_client;
+	pr_debug("@ %s: Queue connect work in %lu for clnt %p\n", __func__, delay, transport->clnt);
 	queue_delayed_work(xprtiod_workqueue,
 			&transport->connect_worker,
 			delay);
@@ -2847,6 +2853,8 @@ static void xs_error_handle(struct work_struct *work)
 	struct sock_xprt *transport = container_of(work,
 			struct sock_xprt, error_worker);
 
+	msleep(100); // Improves reproducibility
+
 	xs_wake_disconnect(transport);
 	xs_wake_write(transport);
 	xs_wake_error(transport);

base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.43.7


