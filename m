Return-Path: <linux-nfs+bounces-21451-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PrDXBVUB/2mW1AAAu9opvQ
	(envelope-from <linux-nfs+bounces-21451-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 09 May 2026 11:41:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6594FF045
	for <lists+linux-nfs@lfdr.de>; Sat, 09 May 2026 11:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D923630069A7
	for <lists+linux-nfs@lfdr.de>; Sat,  9 May 2026 09:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCD439A05D;
	Sat,  9 May 2026 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Fs2HHj1i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5A3845A9;
	Sat,  9 May 2026 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778319690; cv=none; b=rdwFTu7kIMrloitZ8i+chPjEhGB2QEzxdWFWHF6Rd3xOOer2zFeQ3aUj446yBQelaIKuokXoAEyv0MQkBeVrY8X73VI85q13umbRZ8zEfgeSYFnIVb8I/ajVmSnXBE7b5OEJAP7SYg3/TM2y63VSdMmhlDIvNOHk2k/ge9qqsZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778319690; c=relaxed/simple;
	bh=oLpg47DSe9US8IX5roqIcuUzQM4CfiqXPvK6CvOwUBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Scxgg8KWGbVFaj/fXimxLm+6GaUJkRfSVXECRi5ebu2jtBR3naCGnLRbtvXd8T+GbfKcqkVo7bNah1nMGCAm4Xs7vKcFo9KQyynsGWu5W0j+kpZeexDQyTaiGhqz7YWYnNMfRRfCxKzhVgd33XG7pYqSjPa8LFxlg+zLKa9dYGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Fs2HHj1i; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tMT5B6mrg7SMy3LvephoG51biiHh3rgEicSBYASx8d0=;
	b=Fs2HHj1imE5n726zGGh6xeghlqL5c3iyzLPDeQnyJF8rVgqo8EYpyWsRcyJ+/g+eFFRuoAzK0
	D2BsuVOrSDJ8kZDOpPcsw83V26ntOFbXF7l6xfDmHIfE0Z8HutPWlms7IdyQYds5ViP9p6yTrbP
	/yUcD+klXvnaS6Pzqq61LDM=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gCLRG4kdDznTc7;
	Sat,  9 May 2026 17:34:18 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id B01834055B;
	Sat,  9 May 2026 17:41:23 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 9 May 2026 17:41:22 +0800
Message-ID: <4ee398d0-d2ec-45b2-8214-6e35520fca2d@huawei.com>
Date: Sat, 9 May 2026 17:41:21 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] SUNRPC: Address remaining cache_check_rcu() UAF in
 cache content files
To: Chuck Lever <cel@kernel.org>, Misbah Anjum N <misanjum@linux.ibm.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
	<anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, <yi.zhang@huawei.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>, Li Lingfeng <lilingfeng3@huawei.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>
References: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
 <c45779f6-fe6c-4037-bb1c-01cfbbaa8aac@huawei.com>
 <76a10e49-54a6-4813-8b58-b7cd0820fdc6@app.fastmail.com>
 <4bb9ed6b-1a64-406a-9239-b0560ca963cc@huawei.com>
 <05f93fc4-59d7-4735-bc7d-a00d1497687a@huawei.com>
 <10019b42-4589-4f9f-8d5b-d8197db1ce3c@huawei.com>
 <39819ad4-3105-4802-b5e2-79e131b25984@huawei.com>
 <f4caa4fa-f15f-4c95-8318-d4ec216e6090@app.fastmail.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <f4caa4fa-f15f-4c95-8318-d4ec216e6090@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100006.china.huawei.com (7.202.181.220)
X-Rspamd-Queue-Id: 9A6594FF045
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-21451-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huawei.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Chuck!

在 2026/5/9 4:47, Chuck Lever 写道:
> Hi Erkun -
> 
> On Fri, May 8, 2026, at 9:00 AM, yangerkun wrote:
>> 在 2026/5/8 16:16, yangerkun 写道:
>>>
>>>
>>> 在 2026/5/8 11:08, yangerkun 写道:
>>> After reviewing these two commits:
>>>
>>> e7fcf179b82d NFSD: Hold net reference for the lifetime of /proc/fs/nfs/
>>> exports fd
>>> 48db892356d6 NFSD: Defer sub-object cleanup in export put callbacks
>>>
>>> I believe that the issue described in commit e7fcf179b82d might be the
>>> root cause of the null pointer dereferences mentioned in [1].
> 
> That's where I landed too. e7fcf179b82d closed the specific
> oops Misbah hit on /proc/fs/nfs/exports. The matching patch

Yeah!

> in this series is 5/6 ("SUNRPC: Hold cd->net for the lifetime
> of cache files"), which extends the same get_net()/put_net()
> guard to the sunrpc cache files at
> 
>   /proc/net/rpc/<cache>/{content,channel,flush} .
> 
> Those open helpers had the same hole; sosreport just hit the
> nfsd-specific file first because it reads /proc/fs/nfsd/exports.


Hmm... /proc/net is always a symlink to /proc/self/net. After opening 
/proc/net/rpc/<cache>/content and attempting to read it, the 
proc_reg_read function calls use_pde before pde_read. This sequence can 
prevent a race condition because nfsd_export_shutdown leads to 
cache_unregister_net, which calls remove_cache_proc_entries, then 
proc_remove, and eventually proc_entry_rundown. The proc_entry_rundown 
function waits until unuse_pde is called in proc_reg_read. Therefore, 
I'm not sure if forgetting to call get_net when opening 
/proc/net/rpc/<cache>/content is the root cause of the null pointer in 
c_show. I've tried to find any other possible root causes but have been 
unsuccessful. Sorry....


> 
> Patch 5/6's changelog pins down the deref site you asked
> about: cache_check_rcu() faults reading h->flags off a
> garbage cache_head returned by __cache_seq_start() walking a
> cd->hash_table that cache_destroy_net() already freed. Not a
> dentry deref. The dentry-teardown path is a separate failure
> mode that 48db892356d6 closed for the export and expkey caches.
> 
> 
>>> To prevent the
>>> issue described in commit 69d803c40ede, should we consider reverting
>>> commit 48db892356d6 first?
> 
> Not for this series. Patches 3/6 and 4/6 don't add any new
> path_put deferral; their commit messages call them out as
> consistency changes, not bug fixes. ip_map holds only an
> auth_domain reference and unix_gid holds only a group_info,
> so neither cache reaches mntput from the deferred release.
> The exportfs-r-then-umount sequence isn't touched by this
> series.
> 
> The svc_export and svc_expkey path_put deferral lives in
> 48db892356d6, which is already in v7.0. If the umount window
> from 69d803c40ede is still reachable through that commit,
> that's a regression in 48db892356d6 and worth a separate
> thread.

Yeah! Totally agree!

> 
> 
>> Locally, I wrote a stable regression test case. I also reverted to
>> commit 9189d23b835cec646ba5010db35d1557a77c5857 (which is before commits
>> 2862eee078a4 "SUNRPC: make sure cache entry active before cache_show"
>> and be8f982c369c "nfsd: make sure exp active before svc_export_show").
>> Even then, a panic can still be triggered without any actual export path...
> 
> That fits 5/6's failure mode. Without an export no svc_export
> or svc_expkey entry is populated, but rpc.mountd reads
> auth.unix.ip/content and auth.unix.gid/content directly,
> and on a pre-5/6 tree the open helpers in cache.c hold no
> reference on cd->net. cache_destroy_net() at namespace exit
> then races a reader still inside cache_seq_start_rcu(), and
> the reader walks a freed cd->hash_table.
> 
> Could you share the reproducer and the panic stack trace?
> If the fault is in cache_check_rcu() through one of the
> sunrpc cache files, that confirms 5/6 is the right fix, and
> I'll happily carry your Tested-by on it.

The shell(Created will AI assist):

#!/bin/bash
#
# Test for e7fcf179b82d ("NFSD: Hold net reference for ...")
#
# Reproduces the scenario described in the commit:
#   1. Process opens /proc/fs/nfsd/exports in netns A
#   2. Process leaves A (joins B), emptying A
#   3. ip netns del A triggers nfsd_export_shutdown → cache_detail freed
#   4. Process reads from still-open fd → UAF on UNFIXED kernel
#
# On current kernel (with e7fcf179b82d applied):
#   get_net in exports_net_open prevents netns A from being destroyed
#   → read succeeds safely (test output: "SUCCESS")
#
# On kernel WITHOUT e7fcf179b82d:
#   No get_net → A destroyed → read triggers UAF:
#     - KASAN: use-after-free, or
#     - NULL deref, or
#     - slab corruption (ASCII strings like "cap_type", "libz.so.")
#
# Usage: sudo ./test_nfsd_exports_uaf.sh

set -e -u

NS_A="nfsd_test_A_$$"
NS_B="nfsd_test_B_$$"
SYNC="/tmp/nfsd_uaf_sync_$$"
GO="/tmp/nfsd_uaf_go_$$"
REPRO="/tmp/uaf_repro_$$"

cleanup() {
     set +e
     kill $REPRO_PID 2>/dev/null || true
     wait $REPRO_PID 2>/dev/null || true
     ip netns del "$NS_B" 2>/dev/null || true
     ip netns del "$NS_A" 2>/dev/null || true
     rm -f "$REPRO" "$SYNC" "$GO"
}
trap cleanup EXIT

echo "=== Reproduce e7fcf179b82d scenario ==="

# --- Setup ---
echo "[setup] creating netns A and B..."
ip netns add "$NS_A"
ip netns add "$NS_B"

echo "[setup] loading nfsd..."
modprobe nfsd || true

echo "[setup] compiling repro..."
gcc -o "$REPRO" /tmp/uaf_repro.c 2>/dev/null || \
     gcc -o "$REPRO" -x c - <<'SRCEOF' 2>/dev/null
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sched.h>
#include <signal.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
static volatile sig_atomic_t go_flag = 0;
static void handler(int sig) { go_flag = 1; }
int main(int argc, char *argv[]) {
     const char *netns_b = argv[1], *sync_f = argv[2], *go_f = argv[3];
     int fd, nsfd; ssize_t n; char buf[4096];
     fd = open("/proc/fs/nfs/exports", O_RDONLY);
     if (fd < 0) { perror("open exports debug"); return 1; }
     fprintf(stderr, "[repro] opened exports (fd=%d) in netns A\n", fd);
     nsfd = open(netns_b, O_RDONLY);
     if (nsfd < 0) { perror("open B"); return 1; }
     if (setns(nsfd, CLONE_NEWNET) < 0) { perror("setns"); return 1; }
     close(nsfd);
     fprintf(stderr, "[repro] moved to B; A has no processes\n");
     close(open(sync_f, O_CREAT | O_WRONLY, 0666));
     signal(SIGCONT, handler);
     while (!go_flag) { struct stat st; if (stat(go_f, &st) == 0) break; 
pause(); }
     fprintf(stderr, "[repro] reading exports fd...\n");
     lseek(fd, 0, SEEK_SET);
     sleep(1);
     n = read(fd, buf, sizeof(buf)-1);
     if (n < 0) { perror("read"); close(fd); return 1; }
     buf[n] = '\0';
     fprintf(stderr, "[repro] SUCCESS: read %zd bytes (no UAF)\n", n);
     close(fd);
     return 0;
}
SRCEOF

# --- Run repro inside A ---
rm -f "$SYNC" "$GO"
echo "[test] starting repro inside netns A..."
ip netns exec "$NS_A" "$REPRO" /var/run/netns/"$NS_B" "$SYNC" "$GO" &
REPRO_PID=$!

# --- Wait for repro to move to B ---
echo "[test] waiting for repro to signal that A is empty..."
for i in $(seq 1 30); do
     if [ -f "$SYNC" ]; then break; fi
     if ! kill -0 $REPRO_PID 2>/dev/null; then
         echo "[FAIL] repro exited prematurely"
         wait $REPRO_PID || true
         exit 1
     fi
     sleep 0.2
done

if [ ! -f "$SYNC" ]; then
     echo "[FAIL] timeout waiting for repro"
     exit 1
fi
echo "[test] repro moved to B"

# --- Destroy netns A ---
echo "[test] destroying netns A (ip netns del $NS_A)..."
set +e
ip netns del "$NS_A" 2>&1
RC=$?
set -e

if [ $RC -eq 0 ]; then
     echo "[test] 'ip netns del $NS_A' returned success"
else
     echo "[test] 'ip netns del $NS_A' returned $RC"
fi

# --- Signal repro to read from the exports fd ---
echo "[test] signaling repro to read from exports fd..."
touch "$GO"
kill -CONT $REPRO_PID 2>/dev/null || true

# --- Wait for repro and check result ---
set +e
wait $REPRO_PID
RC=$?
set -e

if [ $RC -eq 0 ]; then
     echo ""
     echo "=== TEST PASSED: no UAF detected (kernel has e7fcf179b82d 
fix) ==="
     echo "   get_net() holds netns A alive while the fd is open."
else
     echo ""
     echo "=== TEST FAILED with exit code $RC ==="
     echo "   Possible UAF or other error."
     echo "   If running on a kernel WITHOUT e7fcf179b82d, this crash is 
EXPECTED."
fi
exit $RC


Panic show as follow with commit:

commit 9189d23b835cec646ba5010db35d1557a77c5857 (HEAD -> master)
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Thu Oct 17 09:36:31 2024 -0400

     lockd: Remove unneeded initialization of file_lock::c.flc_flags


localhost login: [   39.462598][  T579] 
================================================================== 
  
  
     [202/363]
[   39.463541][  T579] BUG: KASAN: slab-use-after-free in 
cache_seq_next_rcu+0xa4/0x180 [sunrpc]
[   39.464551][  T579] Read of size 4 at addr ffff00000fbe8408 by task 
uaf_repro_563/579
[   39.465291][  T579]
[   39.465513][  T579] CPU: 1 UID: 0 PID: 579 Comm: uaf_repro_563 Not 
tainted 6.12.0-rc7+ #17
[   39.466349][  T579] Hardware name: linux,dummy-virt (DT)
[   39.466897][  T579] Call trace:
[   39.467224][  T579]  dump_backtrace+0xa4/0x140
[   39.467742][  T579]  show_stack+0x20/0x38
[   39.468156][  T579]  dump_stack_lvl+0x80/0xf8
[   39.468694][  T579]  print_report+0xfc/0x5c8
[   39.469237][  T579]  kasan_report+0x78/0xc8
[   39.469676][  T579]  __asan_load4+0x9c/0xc0
[   39.470115][  T579]  cache_seq_next_rcu+0xa4/0x180 [sunrpc]
[   39.470842][  T579]  seq_read_iter+0x4a0/0x6c0
[   39.471355][  T579]  seq_read+0x194/0x218
[   39.471770][  T579]  proc_reg_read+0x110/0x198
[   39.472235][  T579]  vfs_read+0x150/0x490
[   39.472656][  T579]  ksys_read+0xd4/0x198
[   39.473070][  T579]  __arm64_sys_read+0x4c/0x68
[   39.473537][  T579]  invoke_syscall+0x64/0x188
[   39.473992][  T579]  el0_svc_common.constprop.1+0xd8/0x158
[   39.474558][  T579]  do_el0_svc+0x38/0x50
[   39.474981][  T579]  el0_svc+0x34/0xc0
[   39.475422][  T579]  el0t_64_sync_handler+0xa0/0xc8
[   39.475933][  T579]  el0t_64_sync+0x188/0x190
[   39.476385][  T579]
[   39.476618][  T579] Allocated by task 566:
[   39.477087][  T579]  kasan_save_stack+0x2c/0x58
[   39.477561][  T579]  kasan_save_track+0x20/0x40
[   39.478030][  T579]  kasan_save_alloc_info+0x40/0x58
[   39.478539][  T579]  __kasan_kmalloc+0xa0/0xb8
[   39.478997][  T579]  __kmalloc_node_track_caller_noprof+0x194/0x370
[   39.479646][  T579]  kmemdup_noprof+0x34/0x68
[   39.480094][  T579]  cache_create_net+0x30/0x108 [sunrpc]
[   39.480800][  T579]  nfsd_export_init+0x78/0x188 [nfsd]
[   39.481505][  T579]  nfsd_net_init+0x50/0x1e8 [nfsd]
[   39.482136][  T579]  ops_init+0xcc/0x210
[   39.482615][  T579]  register_pernet_operations+0x218/0x348
[   39.483180][  T579]  register_pernet_subsys+0x38/0x60
[   39.483698][  T579]  0xffffb6c9bf5b90c0
[   39.484096][  T579]  do_one_initcall+0xa8/0x3c8
[   39.484563][  T579]  do_init_module+0x100/0x378
[   39.485070][  T579]  load_module+0x2d78/0x2e80
[   39.485532][  T579]  init_module_from_file+0xec/0x148
[   39.486044][  T579]  __arm64_sys_finit_module+0x394/0x618
[   39.486604][  T579]  invoke_syscall+0x64/0x188
[   39.487065][  T579]  el0_svc_common.constprop.1+0xd8/0x158
[   39.487629][  T579]  do_el0_svc+0x38/0x50
[   39.488044][  T579]  el0_svc+0x34/0xc0
[   39.488437][  T579]  el0t_64_sync_handler+0xa0/0xc8
[   39.488939][  T579]  el0t_64_sync+0x188/0x190
[   39.489398][  T579]
[   39.489635][  T579] Freed by task 53:
[   39.490013][  T579]  kasan_save_stack+0x2c/0x58
[   39.490479][  T579]  kasan_save_track+0x20/0x40
[   39.490948][  T579]  kasan_save_free_info+0x4c/0x78
[   39.491449][  T579]  __kasan_slab_free+0x50/0x70
[   39.491924][  T579]  kfree+0x160/0x310
[   39.492312][  T579]  cache_destroy_net+0x34/0x50 [sunrpc]
[   39.493015][  T579]  nfsd_export_shutdown+0xc0/0x150 [nfsd]
[   39.493711][  T579]  nfsd_net_exit+0x68/0x88 [nfsd]
[   39.494338][  T579]  ops_exit_list.isra.13+0x64/0xc0
[   39.494856][  T579]  cleanup_net+0x508/0x788
[   39.495300][  T579]  process_scheduled_works+0x3d8/0x7e8
[   39.495895][  T579]  worker_thread+0x29c/0x630
[   39.496364][  T579]  kthread+0x170/0x188
[   39.496773][  T579]  ret_from_fork+0x10/0x20
[   39.497217][  T579]
[   39.497453][  T579] The buggy address belongs to the object at 
ffff00000fbe8400

I have try to replace
fd = open("/proc/fs/nfs/exports", O_RDONLY);
with
fd = open("/proc/fs/nfs/exports", O_RDONLY);

No c_show UAF trigger...


> 
> 


