Return-Path: <linux-nfs+bounces-20230-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE1kA2X1uGk5mQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20230-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 07:32:05 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 625192A44F2
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 07:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B89333012D23
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 06:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014032C375A;
	Tue, 17 Mar 2026 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="f8BBtctp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0686578F4A;
	Tue, 17 Mar 2026 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773729121; cv=none; b=mbGysUy0XF8XvINyMi+bbbgNmPtbgkE1ehglnRz1dr7WfpaqMri053sEg7rVPFdVo9g6YobisLj7QioHdo1BiHqbz3p10eGNs3df8Pbsn3pjE8adUHNfP2m0TojbujeGGi1Oga2RruFLERDpsOm6ypA3thcCjp2d4Csyl8ezfgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773729121; c=relaxed/simple;
	bh=ju96+bJmrc2VpckiecwxoQi78vr/xzdhIQQusWz9+xs=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=J3OcdUT9V6EgFzGc3It+04XuE6kAonyV53CV3dWxBSL6JjdOnXQZhvvUUId4DnUmmhFUfSdx3AsKCg1qR3QDa+BLgfcs4VyfLPgCehqCOsx09lzN7ZOAKEXR0Ikb2PvRsn/rj9fFtph1SNhtOsOYQ8rmPJX45frQVG3dQA/eJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=f8BBtctp; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5s8+WlE0XKAze0Ewc+sTllcMzzu/Ix1r4OTpAN2QuEs=;
	b=f8BBtctpS1FTJfRXBDV3+KozIaHXIdzPwXBqGZuj2AYO+2fVO/m5zAso4wDJKahhaAXgvurhA
	HsIJWWnXjYygR2GVhekXSMEmW9RK7udzrpFGV2NATSffLGAlHKoe3SSZy/NN7oJm5sc4TLOmH4m
	5WgztSCejbPCBL2CykrtkQI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fZhnV15rTz1prN0;
	Tue, 17 Mar 2026 14:26:54 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 41D0240538;
	Tue, 17 Mar 2026 14:31:55 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Mar 2026 14:31:54 +0800
Message-ID: <64fecc88-6b11-4fdf-a26f-271c4445be1a@huawei.com>
Date: Tue, 17 Mar 2026 14:31:53 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, yangerkun
	<yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao
	<houtao1@huawei.com>, "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
	"zhangjian (CG)" <zhangjian496@huawei.com>, Li Lingfeng
	<lilingfeng@huaweicloud.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
Subject: [BUG]nfs_writepages may loop forever with -EBADF after state recovery
 failure
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200013.china.huawei.com (7.202.194.25)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20230-lists,linux-nfs=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lilingfeng3@huawei.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 625192A44F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We have encountered an issue where the NFS client gets stuck in an
infinite loop in nfs_writepages after a server restart and state recovery
failure. This causes mount operations to hang because the superblock lock
is held by the looping writeback process.

Problem Description:
When the NFS server is restarted, the client's state manager attempts to
reclaim open files. If the server returns errors such as EROFS, EIO, or
ESTALE during reclamation, the affected file's state is marked as bad (via
nfs4_state_mark_open_context_bad). Subsequently, when the writeback work
(wb_workfn) tries to flush dirty pages for that inode, nfs_writepages
enters a loop because nfs_page_create returns -EBADF, and nfs_writepages
does not treat -EBADF as a fatal error, so it retries indefinitely.

The call chain is:
nfs4_do_reclaim
  nfs4_reclaim_open_state
   __nfs4_reclaim_open_state // get -ESTALE
    nfs4_open_reclaim // ops->recover_open
     nfs4_do_open_reclaim
      _nfs4_do_open_reclaim
       nfs4_open_recover
        nfs4_open_recover_helper // return -ESTALE
         nfs4_opendata_to_nfs4_state
          _nfs4_opendata_reclaim_to_nfs4_state
           nfs_refresh_inode
   nfs4_state_mark_recovery_failed
    nfs4_state_mark_open_context_bad
     set_bit // NFS_CONTEXT_BAD

wb_workfn
  wb_do_writeback
   wb_writeback
    writeback_sb_inodes
     __writeback_single_inode
      do_writepages
       nfs_writepages // loop here
        write_cache_pages
         nfs_writepages_callback
          nfs_do_writepage
           nfs_page_async_flush
            nfs_pageio_add_request
             nfs_pageio_add_request_mirror
              __nfs_pageio_add_request
               nfs_create_subreq
                nfs_page_create // return -EBADF

nfs_writepages retries the loop as long as the error is not fatal
according to nfs_error_is_fatal(). Since -EBADF is not considered fatal,
it keeps retrying forever. This prevents the superblock lock from being
released, causing any concurrent mount operation to hang.

Steps to Reproduce:
We have a reliable reproducer on a recent kernel (Linux 7.0-rc4, commit
2d1373e4246da3b58e1df058374ed6b101804e07).

1) Prepare a server with an export:
mkfs.ext4 -F /dev/sdb
mount /dev/sdb /mnt/sdb
echo "/mnt *(rw,no_root_squash,fsid=0)" > /etc/exports
echo "/mnt/sdb *(rw,no_root_squash,fsid=1)" >> /etc/exports
systemctl restart nfs-server
dd if=/dev/random of=/mnt/sdb/testfile bs=1k count=4 oflag=direct

2) On the client, mount the export and start a writer that holds a file
open and creates dirty pages:
mount -t nfs -o rw,vers=4.1,rsize=1024,wsize=1024 127.0.0.1:/sdb /mnt/sdbb

Run the following Python script in one terminal:
import os, time
fd = os.open("/mnt/sdbb/testfile", os.O_CREAT|os.O_WRONLY|os.O_TRUNC, 0o644)
buf = b'A' * 4096
for i in range(1024):  # ~1GB
     os.write(fd, buf)
print("dirty pages created, fd kept open, sleeping...")
time.sleep(10**9)

3) In another terminal, restart the server and wipe the underlying
filesystem to force ESTALE:
systemctl stop nfs-server
umount /dev/sdb
mkfs.ext4 -F /dev/sdb
mount /dev/sdb /mnt/sdb
echo "/mnt *(rw,no_root_squash,fsid=0)" > /etc/exports
echo "/mnt/sdb *(rw,no_root_squash,fsid=1)" >> /etc/exports
systemctl restart nfs-server

Temporary Workaround:
We have applied the following patch to break the loop by treating -EBADF
as fatal in nfs_writepages
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index dc57e67cefcd..0147f7a7a1a3 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -781,7 +781,7 @@ int nfs_writepages(struct address_space *mapping, 
struct writeback_control *wbc)
                                         &pgio);
                 pgio.pg_error = 0;
                 nfs_pageio_complete(&pgio);
-       } while (err < 0 && !nfs_error_is_fatal(err));
+       } while (err < 0 && !nfs_error_is_fatal(err) && (err != -EBADF));
         nfs_io_completion_put(ioc);

         if (err < 0)

While the patch above avoids the hang, we wonder if a more comprehensive
fix is needed. For instance, perhaps nfs_error_is_fatal() should include
-EBADF in its fatal list, or the state manager should actively abort
pending I/O for contexts marked bad. We are not sure whether -EBADF should
always be considered fatal in writeback paths.

We would appreciate your insights and any suggestions for a proper fix.

Thanks,
Lingfeng


