Return-Path: <linux-nfs+bounces-20022-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOxGM5cosWkBrgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20022-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 09:32:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B97FB25F5FF
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 09:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 025D930E3D93
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2026 08:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DB235A399;
	Wed, 11 Mar 2026 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QMM2M6Vv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B930C35F;
	Wed, 11 Mar 2026 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217400; cv=none; b=FaaQ1LzzV7mhx/MgbLNvXdc944iQB7KQ+LEux8EMNXtO7ZfZmfK3Bhf20FRS/7+nig6Lcjt5n+aRzT/cgseQBJGbcvfThZ5zj6adYeiubsaQCM22ynM29SP7NkeFl3G1AtkZznDmFkWGASsc5OeuOVFU4DMAPHHjt6UcpPB/E6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217400; c=relaxed/simple;
	bh=4eSZyoFAwEUMZ81ixtbBeaHswzP34BePZ92kjzklOBY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=S2W33VaYe6p2KrA+YgA816pTEVq5BzU+swLfi+HIsl9PCbKU9NGtozDxar5g8eIV3PJrh0PzNAafCmy168gzmnjleS/TNsxf1lyMx1bUqzxReKy5yhD8jwGP+6ueGRkKWBf9PgmbLwJmanzllNGRk6syE2+skC10jx9RWmVK2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QMM2M6Vv; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nG6kOv9RugoOWjX5D9vaNFJbG9fivW5371xa0ifivZ4=;
	b=QMM2M6VvaZjizR1KDlpy5SFI3tPBCfltBW2OVwknTOPPithwWhegG4iUQQYWZOXxxJXeoX8i5
	2rjOkx1F1bgIaIVA0f9nK5FTc6rSpv/Y/ZHaNflTYlb6X45H7wszdJ2oDaEhztz/oelHaqoSDbH
	BoeNZoZUWEQcAYjpfIuBTj8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fW3XW260YzpStF;
	Wed, 11 Mar 2026 16:18:03 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id BBE012022B;
	Wed, 11 Mar 2026 16:23:14 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Mar 2026 16:23:13 +0800
Message-ID: <55da00d4-a656-4ed2-ae57-7f881297a1b2@huawei.com>
Date: Wed, 11 Mar 2026 16:23:13 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
From: Li Lingfeng <lilingfeng3@huawei.com>
Subject: [BUG] Server returns nfserr_grace causing client infinite loop
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, yangerkun
	<yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao
	<houtao1@huawei.com>, "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
	"zhangjian (CG)" <zhangjian496@huawei.com>, Li Lingfeng
	<lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj200013.china.huawei.com (7.202.194.25)
X-Rspamd-Queue-Id: B97FB25F5FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_FROM(0.00)[bounces-20022-lists,linux-nfs=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lilingfeng3@huawei.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:dkim,huawei.com:mid,nfs-client1:email]
X-Rspamd-Action: no action

We recently encountered an issue where the NFS client's state manager gets
stuck in an infinite loop, making the client unresponsive to user
operations. The problem occurs when the server returns nfserr_grace during
open reclaim.

Stack trace from the client:
// client
nfs4_state_manager
  nfs4_do_reclaim // NFS4CLNT_RECLAIM_NOGRACE
   nfs4_reclaim_open_state
    __nfs4_reclaim_open_state
     nfs41_open_expired // ops->recover_open
      nfs4_open_expired
       nfs4_do_open_expired
        _nfs4_open_expired // gets NFS4ERR_GRACE and retries

On the server side, nfsd4_open returns nfserr_grace because:
1. The session exists
2. The NFSD4_CLIENT_RECLAIM_COMPLETE flag is not set
3. The op_claim_type is not NFS4_OPEN_CLAIM_PREVIOUS


Steps to reproduce:

1. Normal mount on client
    On server:
    mkfs.ext4 -F /dev/sdb
    mount /dev/sdb /mnt/sdb
    echo "/mnt *(rw,no_root_squash,fsid=0)" > /etc/exports
    echo "/mnt/sdb *(rw,no_root_squash,fsid=1)" >> /etc/exports
    systemctl restart nfs-server
    echo 123 > /mnt/sdb/testfile

    On client:
    mount -t nfs -o rw 192.168.122.251:/sdb /mnt/sdbb

2. Client opens a file and prepares a delay before entering the
NFS4CLNT_RECLAIM_NOGRACE branch in the state manager
    exec 100>/mnt/sdbb/testfile
    rpcdebug -m nfs -s proc

3. Change hostname on server
    hostname server-nfs

4. Restart NFS service on server
    systemctl restart nfs-server

5. Wait for client to set NFS4CLNT_RECLAIM_NOGRACE and enter the delay
before the NFS4CLNT_RECLAIM_NOGRACE branch in the state manager

6. Enable delay for force_expire_client on server
    rpcdebug -m nfsd -s proc

7. Trigger client expiration on server (stop at the delay point)
    echo "expire" > /proc/fs/nfsd/clients/4/ctl &

8. Enable delay for the NFS4CLNT_LEASE_EXPIRED branch on client, and
disable the delay for the NFS4CLNT_RECLAIM_NOGRACE branch
    rpcdebug -m nfs -s xdr
    rpcdebug -m nfs -c proc

9. Client state now has flags NFS4CLNT_LEASE_EXPIRED,
NFS4CLNT_RECLAIM_NOGRACE, and NFS4CLNT_MANAGER_RUNNING, and is stopped at
the delay point in the NFS4CLNT_LEASE_EXPIRED branch

10. Disable delay on server
     rpcdebug -m nfsd -c proc

11. Disable delay on client
     rpcdebug -m nfs -c xdr

12. Client state manager enters an infinite loop in the
NFS4CLNT_RECLAIM_NOGRACE branch
[root@nfs-client1 ~]# cat /proc/779/stack
[<0>] nfs4_handle_exception+0x245/0x600
[<0>] nfs4_do_open_expired+0x2c8/0x4e0
[<0>] nfs4_open_expired+0x31/0x90
[<0>] nfs41_open_expired+0x18b/0x290
[<0>] __nfs4_reclaim_open_state+0x4f/0x330
[<0>] nfs4_reclaim_open_state+0x1e9/0x530
[<0>] nfs4_do_reclaim+0x2a9/0x470
[<0>] nfs4_state_manager+0x1644/0x17f0
[<0>] nfs4_run_state_manager+0x1cc/0x490
[<0>] kthread+0x327/0x410
[<0>] ret_from_fork+0x360/0x6c0
[<0>] ret_from_fork_asm+0x1a/0x30
[root@nfs-client1 ~]#

base:
Linux 7.0-rc3
master 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681

diff:
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 305a772e5497..5d0b1eef5d9b 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1315,6 +1315,7 @@ int nfs4_state_mark_reclaim_nograce(struct 
nfs_client *clp, struct nfs4_state *s
         clear_bit(NFS_STATE_RECLAIM_REBOOT, &state->flags);
         set_bit(NFS_OWNER_RECLAIM_NOGRACE, &state->owner->so_flags);
         set_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state);
+       printk("%s set NFS4CLNT_RECLAIM_NOGRACE for clp %px\n", 
__func__, clp);
         return 1;
  }

@@ -1814,6 +1815,7 @@ static int nfs4_recovery_handle_error(struct 
nfs_client *clp, int error)
                 break;
         case -NFS4ERR_EXPIRED:
                 set_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state);
+               printk("%s set NFS4CLNT_LEASE_EXPIRED for clp %px\n", 
__func__, clp);
                 nfs4_state_start_reclaim_nograce(clp);
                 break;
         case -NFS4ERR_BADSESSION:
@@ -2540,6 +2542,14 @@ static void nfs4_state_manager(struct nfs_client 
*clp)

                 if (test_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state)) {
                         section = "lease expired";
+                       while (1) {
+                               ifdebug(XDR) {
+                                       printk("%s sleep before lease 
expired\n", __func__);
+                                       msleep(5 * 1000);
+                                       continue;
+                               }
+                               break;
+                       }
                         /* We're going to have to re-establish a 
clientid */
                         status = nfs4_reclaim_lease(clp);
                         if (status < 0)
@@ -2616,9 +2626,18 @@ static void nfs4_state_manager(struct nfs_client 
*clp)

                 /* Now recover expired state... */
                 if (test_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state)) {
+                       while (1) {
+                               ifdebug(PROC) {
+                                       printk("%s sleep before deal 
NFS4CLNT_RECLAIM_NOGRACE\n", __func__);
+                                       msleep(5 * 1000);
+                                       continue;
+                               }
+                               break;
+                       }
                         section = "reclaim nograce";
                         status = nfs4_do_reclaim(clp,
clp->cl_mvops->nograce_recovery_ops);
+                       printk("%s nograce reclaim status %d 
clp->cl_state 0x%lx\n", __func__, status, clp->cl_state);
                         if (status == -EAGAIN)
                                 continue;
                         if (status < 0)
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6b9c399b89df..203f1d7c6c5f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3146,6 +3146,14 @@ static void force_expire_client(struct 
nfs4_client *clp)
         clp->cl_time = 0;
         spin_unlock(&nn->client_lock);

+       while (1) {
+               ifdebug(PROC) {
+                       printk("%s sleep before destroy session\n", 
__func__);
+                       msleep(5 * 1000);
+                       continue;
+               }
+               break;
+       }
         wait_event(expiry_wq, atomic_read(&clp->cl_rpc_users) == 0);
         spin_lock(&nn->client_lock);
         already_expired = list_empty(&clp->cl_lru);

 From the server's perspective, returning nfserr_grace is reasonable when
no RECLAIM_COMPLETE request has set the NFSD4_CLIENT_RECLAIM_COMPLETE
flag. However, I suspect the loss of the NFSD4_CLIENT_RECLAIM_COMPLETE
flag is related to the server-side "expire" write. Therefore, I'm unsure
whether this issue should be attributed to the server or the client.

Please let me know if you need any further information or testing.

Thanks,
Lingfeng.


